Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D366A2000C5
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 05:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFSDau (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 23:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbgFSDas (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 23:30:48 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E27EC06174E;
        Thu, 18 Jun 2020 20:30:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 49p4841Nvrz9sRk; Fri, 19 Jun 2020 13:30:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1592537444;
        bh=Z1znwFCrCzh+F1jGYnmAR0Tyf0EyfbusOiN3r/JH274=;
        h=From:To:Cc:Subject:Date:From;
        b=RWj1rESwwED1Om1JkEYHeCzam7cyKUIKly+0faRqHG717UTanjkbwH5ElVDAqko9S
         OSHLW0NYSO1vvGNnD+SG0fWsNczuNKaGJLTBQQwPrxM7Tt4gGT0w+wTMc6aLpD6lIX
         cRw1em/kjjIBENV9rY+9U7ezQNwhgEPwfi8vFwQE=
From:   David Gibson <david@gibson.dropbear.id.au>
To:     jarkko.sakkinen@linux.intel.com, stefanb@linux.ibm.com
Cc:     mpe@ellerman.id.au, peterhuewe@gmx.de, jgg@ziepe.ca,
        nayna@linux.ibm.com, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCHv2] tpm: ibmvtpm: Wait for ready buffer before probing for TPM2 attributes
Date:   Fri, 19 Jun 2020 13:30:40 +1000
Message-Id: <20200619033040.121412-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The tpm2_get_cc_attrs_tbl() call will result in TPM commands being issued,
which will need the use of the internal command/response buffer.  But,
we're issuing this *before* we've waited to make sure that buffer is
allocated.

This can result in intermittent failures to probe if the hypervisor / TPM
implementation doesn't respond quickly enough.  I find it fails almost
every time with an 8 vcpu guest under KVM with software emulated TPM.

To fix it, just move the tpm2_get_cc_attrs_tlb() call after the
existing code to wait for initialization, which will ensure the buffer
is allocated.

Fixes: 18b3670d79ae9 ("tpm: ibmvtpm: Add support for TPM2")
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Changes from v1:
 * Fixed a formatting error in the commit message
 * Added some more detail to the commit message
 
drivers/char/tpm/tpm_ibmvtpm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 09fe45246b8cc..994385bf37c0c 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -683,13 +683,6 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	if (rc)
 		goto init_irq_cleanup;
 
-	if (!strcmp(id->compat, "IBM,vtpm20")) {
-		chip->flags |= TPM_CHIP_FLAG_TPM2;
-		rc = tpm2_get_cc_attrs_tbl(chip);
-		if (rc)
-			goto init_irq_cleanup;
-	}
-
 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
@@ -697,6 +690,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 		goto init_irq_cleanup;
 	}
 
+	if (!strcmp(id->compat, "IBM,vtpm20")) {
+		chip->flags |= TPM_CHIP_FLAG_TPM2;
+		rc = tpm2_get_cc_attrs_tbl(chip);
+		if (rc)
+			goto init_irq_cleanup;
+	}
+
 	return tpm_chip_register(chip);
 init_irq_cleanup:
 	do {
-- 
2.26.2

