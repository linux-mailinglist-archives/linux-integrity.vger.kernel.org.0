Return-Path: <linux-integrity+bounces-3998-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5EA9BA121
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Nov 2024 16:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB170282288
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Nov 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4501A3042;
	Sat,  2 Nov 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpHHKPZo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01594185936;
	Sat,  2 Nov 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560960; cv=none; b=JeSFOxrOplpTaFJf/t0ORKgl4OJGReVaqbLb1zXnJbXneLrXXdGEr6t5IqKW0H1KRpWHTpyPntV7CbxGTMIZ1X3IRICGlY+yJRtjSSLnCLTjERrSIV6JhAanTS78Ij/lHYu9WyWaVULQSvm8vJsiC7I/saNemF8EMRAJ3s2YBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560960; c=relaxed/simple;
	bh=68YV7lYxwusnDvzyWCT/Q+HR0JDgE7I7JZdfOswM0dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfN66+lG6bp+AIOR61LZj7M45dm+9PEnM64Zwf8TASuyc1+a1nrB8bqKrlIt5vbs2bgdDCiJ4566x1S8Q7qlZdb515/kspO/Jfnt+5ahaiAkPsYpp4EXp+dYuRpr+6uA43Kf6nQJv2h8jo+JwfkRowzfumNMuqaYJhLzoAt30kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpHHKPZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA63AC4CEC3;
	Sat,  2 Nov 2024 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560959;
	bh=68YV7lYxwusnDvzyWCT/Q+HR0JDgE7I7JZdfOswM0dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpHHKPZo0btC1HFGFlM3HzFk3VNVBv5prfnv/lnmhy80RfoXC2Iend43GEoLPoJJj
	 sZ5+NfjGMNxcHkYfSspTYz81xsi+/4MBiT0ULHj/jYDdNp2x6gWUEX7/C+hLmP2tTj
	 y7OiHxg9/aNPbkFbg1Cey9xHIbgfgbeQ1aYLEdcPt5xJlirY9+66qXQ4np4lz5ALei
	 uJ0Nux9Bh/FWDz92z7eAvzXYVWPq2YD7uEGJ4RUPmS1r24ewDEy1c0RqyepwcvFVD4
	 p9GpbIdByMoJM0rzTY1UxadgVTLhOvFykZ0Ik0zAql0vJBnciuxij32oRfb/cKl3GQ
	 +lnfUk0lXqkPA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: x86@kernel.org,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list),
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 1/4] tpm, tpm_tis: Close all localities
Date: Sat,  2 Nov 2024 17:22:18 +0200
Message-ID: <20241102152226.2593598-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102152226.2593598-1-jarkko@kernel.org>
References: <20241102152226.2593598-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

There are environments, for example, those that comply with the TCG D-RTM
specification that requires the TPM to be left in locality 2. Prepare
kernel for such environments by closing all the localities.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 include/linux/tpm.h             |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..c58f360fb4a4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1104,7 +1104,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, i;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1166,6 +1166,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
+	/*
+	 * There are environments, for example, those that comply with the TCG D-RTM
+	 * specification that requires the TPM to be left in Locality 2.
+	 */
+	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
+		if (check_locality(chip, i))
+			tpm_tis_relinquish_locality(chip, i);
+	}
+
 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 587b96b4418e..0708f744c803 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -147,6 +147,12 @@ struct tpm_chip_seqops {
  */
 #define TPM2_MAX_CONTEXT_SIZE 4096
 
+/*
+ * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
-- 
2.47.0


