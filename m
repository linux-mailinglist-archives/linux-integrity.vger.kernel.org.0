Return-Path: <linux-integrity+bounces-7283-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC38BA7E5A
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 06:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F693C2679
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 04:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4321C17D;
	Mon, 29 Sep 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh96lChb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871621B9C0;
	Mon, 29 Sep 2025 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118394; cv=none; b=B17bIaI/STf5X+9m5K45unnuORlJDicQJ4J0Ejnc2uffWMhqGjKjCX8nwSwskemL0KU38hi11+wN9l+CB21XlPmZiQt0FRXcqZMGSNd8tQg/ak4pr431pDtss4n4tJl2yKZZzb3f4OrreEgKQEj+048aITF7idr/fSc02sbej8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118394; c=relaxed/simple;
	bh=q1gt730fnSd2Av052hqSCVRgXrypYYybsDg0l/9rpQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oX2GToslwSj4L+7WzgkUpXAR3GrH8gLzqNV6DuMsxY9PENXdBHCH6rnaVoOa5qYWsOuoE+NeYgFsN0YSL6Tx/VWrEEaNXKINtnBJznz08fxYUP7KEPTLGmEnQc4GX1FwFnntFMwIqvmiVP+a7xym8kflwD1c/P+KtnNtOrAeiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh96lChb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DB4C116B1;
	Mon, 29 Sep 2025 03:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759118394;
	bh=q1gt730fnSd2Av052hqSCVRgXrypYYybsDg0l/9rpQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yh96lChbM7jTHNlV+UNRzkrbovHmEroZXnrFTnWUwVPiQ1wYg4d0Y4CKx2rFqCkCm
	 rXvO1Ka+2vIa29zccfBW1LkgXvtIsY8Iec5OALafd9NmouZZ2on8lANhx/LRD3tDgE
	 TzPKSt2AjLw0RDHYeZmD0YIgI6U36j7rs99dvX+FSpQHYAr/V6v3ADXTph2E4PobqV
	 ZCh5l3e6X36Rqewe9oANgCxWVrJzlo7D6T3J15HZlAxque7iOLdS6jzH0Rv25ktbOv
	 J0Uu97Kcg6hcl+PODzw0FrfGrefYf2Zkppwou46aBdRJS6/vs0VVzJ682HlGlpW5Hk
	 A13ukCe6s+6IA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 1/9] tpm: cap PCR bank in tpm2_get_pcr_allocations()
Date: Mon, 29 Sep 2025 06:59:30 +0300
Message-Id: <20250929035938.1773341-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929035938.1773341-1-jarkko@kernel.org>
References: <20250929035938.1773341-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

tpm2_get_pcr_allocation() does not cap any upper limit for the number of
banks received from external hardware device. This could lead into resource
over-consumption with a fauly TPM device.

Cc: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v2:
- A new patch.
---
 drivers/char/tpm/tpm-chip.c | 13 +++++++++----
 drivers/char/tpm/tpm.h      |  1 -
 drivers/char/tpm/tpm1-cmd.c | 25 -------------------------
 drivers/char/tpm/tpm2-cmd.c |  8 +++-----
 include/linux/tpm.h         | 18 ++++++++----------
 5 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 687f6d8cd601..9a6538f76f50 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -559,14 +559,19 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
 
 static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 {
-	int rc;
+	int rc = 0;
 
 	if (tpm_is_firmware_upgrade(chip))
 		return 0;
 
-	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
-	     tpm2_get_pcr_allocation(chip) :
-	     tpm1_get_pcr_allocation(chip);
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
+		chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
+		chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
+		chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
+		chip->nr_allocated_banks = 1;
+	} else {
+		rc = tpm2_get_pcr_allocation(chip);
+	}
 
 	if (rc > 0)
 		return -ENODEV;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 57ef8589f5f5..769fa6b00c54 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -252,7 +252,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
 int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
-int tpm1_get_pcr_allocation(struct tpm_chip *chip);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
 int tpm_pm_resume(struct device *dev);
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index cf64c7385105..5c49bdff33de 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -786,28 +786,3 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 
 	return rc;
 }
-
-/**
- * tpm1_get_pcr_allocation() - initialize the allocated bank
- * @chip: TPM chip to use.
- *
- * The function initializes the SHA1 allocated bank to extend PCR
- *
- * Return:
- * * 0 on success,
- * * < 0 on error.
- */
-int tpm1_get_pcr_allocation(struct tpm_chip *chip)
-{
-	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
-					GFP_KERNEL);
-	if (!chip->allocated_banks)
-		return -ENOMEM;
-
-	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
-	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
-	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
-	chip->nr_allocated_banks = 1;
-
-	return 0;
-}
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7d77f6fbc152..e416cc8705e3 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 
 	nr_possible_banks = be32_to_cpup(
 		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
-
-	chip->allocated_banks = kcalloc(nr_possible_banks,
-					sizeof(*chip->allocated_banks),
-					GFP_KERNEL);
-	if (!chip->allocated_banks) {
+	if (nr_possible_banks > TPM2_MAX_BANKS) {
+		pr_err("tpm:: unexpected large number of banks: %u > %u",
+		       nr_possible_banks, TPM2_MAX_BANKS);
 		rc = -ENOMEM;
 		goto out;
 	}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 900c81a2bc41..fc7df87dfb9a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -27,7 +27,12 @@
 #include <crypto/aes.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
+#define TPM_HEADER_SIZE		10
+
+#define TPM2_PLATFORM_PCR	24
+#define TPM2_PCR_SELECT_MIN	3
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+#define TPM2_MAX_BANKS		4
 
 struct tpm_chip;
 struct trusted_key_payload;
@@ -69,7 +74,7 @@ enum tpm2_curves {
 
 struct tpm_digest {
 	u16 alg_id;
-	u8 digest[TPM_MAX_DIGEST_SIZE];
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
 } __packed;
 
 struct tpm_bank_info {
@@ -190,7 +195,7 @@ struct tpm_chip {
 	unsigned int groups_cnt;
 
 	u32 nr_allocated_banks;
-	struct tpm_bank_info *allocated_banks;
+	struct tpm_bank_info allocated_banks[TPM2_MAX_BANKS];
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
@@ -217,13 +222,6 @@ struct tpm_chip {
 #endif
 };
 
-#define TPM_HEADER_SIZE		10
-
-enum tpm2_const {
-	TPM2_PLATFORM_PCR       =     24,
-	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
-};
-
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
 	TPM2_TIMEOUT_B          =   4000,
-- 
2.39.5


