Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1E280643
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 20:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgJASKg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 14:10:36 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50790 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730116AbgJASKg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 14:10:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 353138EE17F;
        Thu,  1 Oct 2020 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601575836;
        bh=r2aUSXeDGTdP5KqVvoQXerUkssqFJTCk6NoMyHjsceM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+h/qzocJTY+rRcm56EPVzPEJEvdLiKC02aC1lTvJhhBaR9di7qD+9BltYSByK2J7
         bHlYsK5Qb7P4ylZDOd3syuWPfz2lXQ7PHwACMNW+g/DbFDOnPk5nBW1ifQsoYrxYtV
         WqIMRMMeLsILH6QFnBGpwVFG9jvYkAxspcxmeC/k=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YkVC2EF60aDa; Thu,  1 Oct 2020 11:10:36 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BB5A18EE0DA;
        Thu,  1 Oct 2020 11:10:35 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v2 1/5] tpm_tis: Fix check_locality for correct locality acquisition
Date:   Thu,  1 Oct 2020 11:09:21 -0700
Message-Id: <20201001180925.13808-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TPM TIS specification says the TPM signals the acquisition of
locality when the TMP_ACCESS_REQUEST_USE bit goes to one *and* the
TPM_ACCESS_REQUEST_USE bit goes to zero.  Currently we only check the
former not the latter, so check both.  Adding the check on
TPM_ACCESS_REQUEST_USE should fix the case where the locality is
re-requested before the TPM has released it.  In this case the
locality may get released briefly before it is reacquired, which
causes all sorts of problems. However, with the added check,
TPM_ACCESS_REQUEST_USE should remain 1 until the second request for
the locality is granted.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: added this patch
---
 drivers/char/tpm/tpm_tis_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 92c51c6cfd1b..f3ecde8df47d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -125,7 +125,8 @@ static bool check_locality(struct tpm_chip *chip, int l)
 	if (rc < 0)
 		return false;
 
-	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) ==
+	if ((access & (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID
+		       | TPM_ACCESS_REQUEST_USE)) ==
 	    (TPM_ACCESS_ACTIVE_LOCALITY | TPM_ACCESS_VALID)) {
 		priv->locality = l;
 		return true;
-- 
2.28.0

