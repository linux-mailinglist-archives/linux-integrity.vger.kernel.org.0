Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1C83C7C
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2019 23:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfHFVfU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Aug 2019 17:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbfHFVfU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Aug 2019 17:35:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53D62089E;
        Tue,  6 Aug 2019 21:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127318;
        bh=cPivkqwnQ1OdRMluIbubqEiTl3DSailklhPA6Iw5au4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oldEed+hx2SsGGcigoPJ5DkGtmF2H+whCxo8x7JcEq4GCNSdyiSK6BEyefJwEIane
         GnRnV0btWFkjUOMfdUtas2FqJk1Pt4LzF7SXLozF3Q8py+uUGpGVPZmfEO5MS8zZks
         poox7QAuOqPW2IugRLnjQYmjoJAnAyhjzsH0LhUU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nayna Jain <nayna@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 59/59] tpm: tpm_ibm_vtpm: Fix unallocated banks
Date:   Tue,  6 Aug 2019 17:33:19 -0400
Message-Id: <20190806213319.19203-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Nayna Jain <nayna@linux.ibm.com>

[ Upstream commit fa4f99c05320eb28bf6ba52a9adf64d888da1f9e ]

The nr_allocated_banks and allocated banks are initialized as part of
tpm_chip_register. Currently, this is done as part of auto startup
function. However, some drivers, like the ibm vtpm driver, do not run
auto startup during initialization. This results in uninitialized memory
issue and causes a kernel panic during boot.

This patch moves the pcr allocation outside the auto startup function
into tpm_chip_register. This ensures that allocated banks are initialized
in any case.

Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with PCR read")
Reported-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Michal Suchánek <msuchanek@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 20 ++++++++++++++++++++
 drivers/char/tpm/tpm.h      |  2 ++
 drivers/char/tpm/tpm1-cmd.c | 36 ++++++++++++++++++++++++------------
 drivers/char/tpm/tpm2-cmd.c |  6 +-----
 4 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index d47ad10a35fe3..1d3c25831604a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -545,6 +545,20 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
 	return hwrng_register(&chip->hwrng);
 }
 
+static int tpm_get_pcr_allocation(struct tpm_chip *chip)
+{
+	int rc;
+
+	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
+	     tpm2_get_pcr_allocation(chip) :
+	     tpm1_get_pcr_allocation(chip);
+
+	if (rc > 0)
+		return -ENODEV;
+
+	return rc;
+}
+
 /*
  * tpm_chip_register() - create a character device for the TPM chip
  * @chip: TPM chip to use.
@@ -564,6 +578,12 @@ int tpm_chip_register(struct tpm_chip *chip)
 	if (rc)
 		return rc;
 	rc = tpm_auto_startup(chip);
+	if (rc) {
+		tpm_chip_stop(chip);
+		return rc;
+	}
+
+	rc = tpm_get_pcr_allocation(chip);
 	tpm_chip_stop(chip);
 	if (rc)
 		return rc;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e503ffc3aa39c..a7fea3e0ca86a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -394,6 +394,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
 int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
+int tpm1_get_pcr_allocation(struct tpm_chip *chip);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
@@ -449,6 +450,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
+ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index faacbe1ffa1a9..149e953ca3699 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -699,18 +699,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	}
 
-	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
-					GFP_KERNEL);
-	if (!chip->allocated_banks) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
-	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
-	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
-	chip->nr_allocated_banks = 1;
-
 	return rc;
 out:
 	if (rc > 0)
@@ -779,3 +767,27 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 	return rc;
 }
 
+/**
+ * tpm1_get_pcr_allocation() - initialize the allocated bank
+ * @chip: TPM chip to use.
+ *
+ * The function initializes the SHA1 allocated bank to extend PCR
+ *
+ * Return:
+ * * 0 on success,
+ * * < 0 on error.
+ */
+int tpm1_get_pcr_allocation(struct tpm_chip *chip)
+{
+	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
+					GFP_KERNEL);
+	if (!chip->allocated_banks)
+		return -ENOMEM;
+
+	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
+	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
+	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
+	chip->nr_allocated_banks = 1;
+
+	return 0;
+}
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index d103545e40550..ba9acae83bff1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -840,7 +840,7 @@ struct tpm2_pcr_selection {
 	u8  pcr_select[3];
 } __packed;
 
-static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
+ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 {
 	struct tpm2_pcr_selection pcr_selection;
 	struct tpm_buf buf;
@@ -1040,10 +1040,6 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 			goto out;
 	}
 
-	rc = tpm2_get_pcr_allocation(chip);
-	if (rc)
-		goto out;
-
 	rc = tpm2_get_cc_attrs_tbl(chip);
 
 out:
-- 
2.20.1

