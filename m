Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D371EF174
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 08:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFEGly (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 02:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEGly (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 02:41:54 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D249C08C5C2;
        Thu,  4 Jun 2020 23:41:54 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 49dY336tn3z9sT8; Fri,  5 Jun 2020 16:41:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1591339311;
        bh=4xfwcfWg3fYDkvoSshyHr3xzme+hp4xxgCEBnrJPiQA=;
        h=From:To:Cc:Subject:Date:From;
        b=IrxIHTOtq36n7hL5oemlz8t7GEAZpF+h8mTGZWroOBqSOJhlOm51dSAX5GS8JjdQw
         WHPJOGd2sMRNJx6TszW1g1u49Df8BhbVSg50aDEDD0Kr11VDFLFtDyVVb6LQh/IizZ
         9MyDft/8Rp9JAU6KU9KeE06jCzBBToAxZF9pO1V4=
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] tpm: ibmvtpm: Wait for ready buffer before probing for TPM2 attributes
Date:   Fri,  5 Jun 2020 16:37:19 +1000
Message-Id: <20200605063719.456277-1-david@gibson.dropbear.id.au>
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

Fixes: 18b3670d79ae9 "tpm: ibmvtpm: Add support for TPM2"
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 09fe45246b8c..994385bf37c0 100644
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

