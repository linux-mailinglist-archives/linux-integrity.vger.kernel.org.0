Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB87651B8D
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 08:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiLTHZj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 02:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiLTHZT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 02:25:19 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0755315F04;
        Mon, 19 Dec 2022 23:25:12 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p7WzY-008mhE-TF; Tue, 20 Dec 2022 15:24:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Dec 2022 15:24:48 +0800
Date:   Tue, 20 Dec 2022 15:24:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com,
        davem@davemloft.net, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: [PATCH] lib/mpi: Fix buffer overrun when SG is too long
Message-ID: <Y6FjQPZiJYTEG1zI@gondor.apana.org.au>
References: <20221209150633.1033556-1-roberto.sassu@huaweicloud.com>
 <Y5OGr59A9wo86rYY@sol.localdomain>
 <fa8a307541735ec9258353d8ccb75c20bb22aafe.camel@huaweicloud.com>
 <Y5bxJ5UZNPzxwtoy@gondor.apana.org.au>
 <0f80852578436dbba7a0fce03d86c3fa2d38c571.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f80852578436dbba7a0fce03d86c3fa2d38c571.camel@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 19, 2022 at 09:49:29AM +0100, Roberto Sassu wrote:
>
> do you have any news on this bug?

Thanks for the reminder.  Could you please try this patch?

---8<---
The helper mpi_read_raw_from_sgl ignores the second parameter
nbytes when reading the SG list and may overrun its own buffer
because it only allocates enough memory according to nbytes.

Fixes: 2d4d1eea540b ("lib/mpi: Add mpi sgl helpers")
Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
index 39c4c6731094..6bffc68c1a5a 100644
--- a/lib/mpi/mpicoder.c
+++ b/lib/mpi/mpicoder.c
@@ -494,17 +494,15 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
 	val->sign = 0;
 	val->nlimbs = nlimbs;
 
-	if (nbytes == 0)
-		return val;
-
 	j = nlimbs - 1;
 	a = 0;
 	z = BYTES_PER_MPI_LIMB - nbytes % BYTES_PER_MPI_LIMB;
 	z %= BYTES_PER_MPI_LIMB;
 
-	while (sg_miter_next(&miter)) {
+	while (nbytes && sg_miter_next(&miter)) {
 		buff = miter.addr;
-		len = miter.length;
+		len = min_t(unsigned, miter.length, nbytes);
+		nbytes -= len;
 
 		for (x = 0; x < len; x++) {
 			a <<= 8;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
