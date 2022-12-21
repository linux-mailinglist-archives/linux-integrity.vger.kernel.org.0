Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC94652D11
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Dec 2022 07:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiLUGyd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Dec 2022 01:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiLUGy3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Dec 2022 01:54:29 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2C51F2F4;
        Tue, 20 Dec 2022 22:54:27 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p7szG-00989G-S1; Wed, 21 Dec 2022 14:53:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 21 Dec 2022 14:53:58 +0800
Date:   Wed, 21 Dec 2022 14:53:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
        davem@davemloft.net, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: [v2 PATCH] lib/mpi: Fix buffer overrun when SG is too long
Message-ID: <Y6Kthn+rIUnCEJWz@gondor.apana.org.au>
References: <20221209150633.1033556-1-roberto.sassu@huaweicloud.com>
 <Y5OGr59A9wo86rYY@sol.localdomain>
 <fa8a307541735ec9258353d8ccb75c20bb22aafe.camel@huaweicloud.com>
 <Y5bxJ5UZNPzxwtoy@gondor.apana.org.au>
 <0f80852578436dbba7a0fce03d86c3fa2d38c571.camel@huaweicloud.com>
 <Y6FjQPZiJYTEG1zI@gondor.apana.org.au>
 <a04e6458-6814-97fc-f03a-617809e2e6ce@huaweicloud.com>
 <Y6IbWA5aZeBnn4n2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6IbWA5aZeBnn4n2@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 20, 2022 at 08:30:16PM +0000, Eric Biggers wrote:
>
> > Tried, could not boot the UML kernel.
> > 
> > After looking, it seems we have to call sg_miter_stop(). Or alternatively,
> > we could let sg_miter_next() be called but not writing anything inside the
> > loop.
> > 
> > With either of those fixes, the tests pass (using one scatterlist).

Thanks for the quick feedback Roberto!

> I think it should look like:
> 
> 	while (nbytes) {
> 		sg_miter_next(&miter);
> 		...
> 	}
> 	sg_miter_stop(&miter);

You're right Eric.  However, we could also do it by simply not
checking nbytes since we already set nents according to nbytes
at the top of the function.

---8<---
The helper mpi_read_raw_from_sgl sets the number of entries in
the SG list according to nbytes.  However, if the last entry
in the SG list contains more data than nbytes, then it may overrun
the buffer because it only allocates enough memory for nbytes.

Fixes: 2d4d1eea540b ("lib/mpi: Add mpi sgl helpers")
Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
index 39c4c6731094..157ef532a6a2 100644
--- a/lib/mpi/mpicoder.c
+++ b/lib/mpi/mpicoder.c
@@ -504,7 +501,8 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
 
 	while (sg_miter_next(&miter)) {
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
