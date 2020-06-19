Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1094C2000FF
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 06:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFSEN3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 00:13:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34092 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgFSEN3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 00:13:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jm8Oo-0007ct-8B; Fri, 19 Jun 2020 14:13:07 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Jun 2020 14:13:06 +1000
Date:   Fri, 19 Jun 2020 14:13:06 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [kbuild-all] security/integrity/ima/ima_crypto.c:575:12:
 warning: stack frame size of 1152 bytes in function
 'ima_calc_field_array_hash_tfm'
Message-ID: <20200619041306.GA22098@gondor.apana.org.au>
References: <202006172132.iBj7mjDX%lkp@intel.com>
 <932f46e1-3ea9-e0cd-218a-db163c146a0e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932f46e1-3ea9-e0cd-218a-db163c146a0e@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 19, 2020 at 10:43:22AM +0800, Rong Chen wrote:
> 
> Could you take a look at this warning? Roberto mentioned you in previous
> report:
> https://lore.kernel.org/linux-integrity/9dbec9465bda4f8995a42593eb0db010@huawei.com/

Well having a shash descriptor on the stack is always pushing
the envelope.  Doing it when you put another 256-byte string is
obviously not a good idea.  The good thing is that the string
isn't necessary, so how about:

---8<---
The function ima_calc_field_array_hash_tfm uses a stack descriptor
for shash.  As hashing requires a large amount of space this means
that you shouldn't put any other large data on the stack at the same
time, for example, you definitely shouldn't put a 256-byte string
which you're going to hash on the stack.

Luckily this string is mostly composed of zeroes so we could just
use ZERO_PAGE instead.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 220b14920c37..0a925d1a1bf7 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/moduleparam.h>
 #include <linux/ratelimit.h>
 #include <linux/file.h>
@@ -605,11 +606,11 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 		return rc;
 
 	for (i = 0; i < num_fields; i++) {
-		u8 buffer[IMA_EVENT_NAME_LEN_MAX + 1] = { 0 };
 		u8 *data_to_hash = field_data[i].data;
 		u32 datalen = field_data[i].len;
 		u32 datalen_to_hash =
 		    !ima_canonical_fmt ? datalen : cpu_to_le32(datalen);
+		u32 padlen = 0;
 
 		if (strcmp(td->name, IMA_TEMPLATE_IMA_NAME) != 0) {
 			rc = crypto_shash_update(shash,
@@ -617,14 +618,21 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 						sizeof(datalen_to_hash));
 			if (rc)
 				break;
-		} else if (strcmp(td->fields[i]->field_id, "n") == 0) {
-			memcpy(buffer, data_to_hash, datalen);
-			data_to_hash = buffer;
-			datalen = IMA_EVENT_NAME_LEN_MAX + 1;
-		}
+		} else if (strcmp(td->fields[i]->field_id, "n") == 0 &&
+			   datalen < IMA_EVENT_NAME_LEN_MAX + 1)
+			padlen = IMA_EVENT_NAME_LEN_MAX + 1 - datalen;
+
 		rc = crypto_shash_update(shash, data_to_hash, datalen);
 		if (rc)
 			break;
+
+		if (padlen) {
+			const u8 *zero = page_address(ZERO_PAGE(0));
+
+			rc = crypto_shash_update(shash, zero, padlen);
+			if (rc)
+				break;
+		}
 	}
 
 	if (!rc)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
