Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8477D280646
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgJASKr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 14:10:47 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50814 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730070AbgJASKr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 14:10:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3DA168EE17F;
        Thu,  1 Oct 2020 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601575847;
        bh=NMGPxTmJ4GUCEq0Vgluw0kdXmEy+kaRPs5J/spmwL9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wRuynoOabIS8a41+AvrJurbQHKk2PF3pUTJqgSvGU3PXQbzuQ5uIDSYFIHfnkxnfn
         AFwJjXFTDrL9lgi0rDQw0U77ZyZ0UqFFXxGHU49ae5aRdSlmDLAd/F4hKbtCSXQj4X
         V0155pL2gtxe8DQPQ1M2CQFICI5YpY8NuVkKliuY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pDIjutxGI7k8; Thu,  1 Oct 2020 11:10:47 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C24398EE0DA;
        Thu,  1 Oct 2020 11:10:46 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH v2 2/5] tpm_tis: Clean up locality release
Date:   Thu,  1 Oct 2020 11:09:22 -0700
Message-Id: <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current release locality code seems to be based on the
misunderstanding that the TPM interrupts when a locality is released:
it doesn't, only when the locality is acquired.

Furthermore, there seems to be no point in waiting for the locality to
be released.  All it does is penalize the last TPM user.  However, if
there's no next TPM user, this is a pointless wait and if there is a
next TPM user, they'll pay the penalty waiting for the new locality
(or possibly not if it's the same as the old locality).

Fix the code by making release_locality as simple write to release
with no waiting for completion.

Fixes: 33bafe90824b ("tpm_tis: verify locality released before returning from release_locality")
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: added fixes
---
 drivers/char/tpm/tpm_tis_core.c | 47 +--------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index f3ecde8df47d..431919d5f48a 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -135,58 +135,13 @@ static bool check_locality(struct tpm_chip *chip, int l)
 	return false;
 }
 
-static bool locality_inactive(struct tpm_chip *chip, int l)
-{
-	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int rc;
-	u8 access;
-
-	rc = tpm_tis_read8(priv, TPM_ACCESS(l), &access);
-	if (rc < 0)
-		return false;
-
-	if ((access & (TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY))
-	    == TPM_ACCESS_VALID)
-		return true;
-
-	return false;
-}
-
 static int release_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	unsigned long stop, timeout;
-	long rc;
 
 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
 
-	stop = jiffies + chip->timeout_a;
-
-	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
-again:
-		timeout = stop - jiffies;
-		if ((long)timeout <= 0)
-			return -1;
-
-		rc = wait_event_interruptible_timeout(priv->int_queue,
-						      (locality_inactive(chip, l)),
-						      timeout);
-
-		if (rc > 0)
-			return 0;
-
-		if (rc == -ERESTARTSYS && freezing(current)) {
-			clear_thread_flag(TIF_SIGPENDING);
-			goto again;
-		}
-	} else {
-		do {
-			if (locality_inactive(chip, l))
-				return 0;
-			tpm_msleep(TPM_TIMEOUT);
-		} while (time_before(jiffies, stop));
-	}
-	return -1;
+	return 0;
 }
 
 static int request_locality(struct tpm_chip *chip, int l)
-- 
2.28.0

