Return-Path: <linux-integrity+bounces-7331-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39BABAEAC5
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 00:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64DF4A5741
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092552C11C3;
	Tue, 30 Sep 2025 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBPmFzf5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842422A4FE;
	Tue, 30 Sep 2025 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270642; cv=none; b=nUmyOgq0nt3CmLmTjKZj8AD+C9iWIfRz4ikrxAu6ssnykv3g04fiSMTDJFwS1OSG0L/uNIR8DQOiwNMuLHUfEnOZJSo/lVtn0y1tB+uxRj6mEFpOwiEV9T6sziNmWDUo6hAjKG0g1WVBpX0osm+pTYGNnaRFhWjMINI+O+yWUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270642; c=relaxed/simple;
	bh=jLukbEi9WeHZ/RUrynJjtKIC1cl16Ls2i2TcnnAUgaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XsmM/vTmVXv23OSLR0q/hjggooO5ijJXlFTO/1hropLzjHZUm8CeVcYv95Y+z+/6uOdVzcuNI9CT/t8JyG0BgcpWvLPQ6bFa1x4xCWOP8XNjo2yDRvNPVTqaJII2YEg2+YVwO14cZC2R6GKAb8V/kJoXHKniZSs44ZQbaeien2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBPmFzf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED325C4CEF0;
	Tue, 30 Sep 2025 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759270640;
	bh=jLukbEi9WeHZ/RUrynJjtKIC1cl16Ls2i2TcnnAUgaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBPmFzf5EQO7L2RGrGsK7x43G0RT3tMWY2kFH5fX9cQQHRHbgTI5iMGROsdu778AP
	 bOgbaweT1II4LK9EB8SG3oIsz4TB5bLXIGKwucCOnqPECi5eTp5Ou5TMiRosrGJSff
	 sSEO9lKW4K7FSOmMAO64n1XmVBRs0yiU2ZcSV9vnZrd5X2EEzc9AhZJOMm2qamu89U
	 r9iWVjqi27+iC52gPqs5extanWEokPLy9xYPL8Y1FNpJdZwJqJKclbtozCURdMYLvI
	 n0Wn7nzAmeLQTsqBtz5jJg23pYTJZVCRUQaFXBo0TXQXrrjvKiKAYyq/35J/MqgkjK
	 sfey9uHhU9Egg==
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
Subject: [PATCH v4 1/9] tpm: Cap the number of PCR banks
Date: Wed,  1 Oct 2025 01:16:59 +0300
Message-Id: <20250930221707.1373912-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930221707.1373912-1-jarkko@kernel.org>
References: <20250930221707.1373912-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

tpm2_get_pcr_allocation() does not cap any upper limit for the number of
banks. Cap the limit to four banks so that out of bounds values coming
from external I/O cause on only limited harm.

Cc: Roberto Sassu <roberto.sassu@huawei.com>
Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v4:
- Revert spurious changes from include/linux/tpm.h.
- Increase TPM2_MAX_BANKS to 8.
- Rename TPM2_MAX_BANKS as TPM2_MAX_PCR_BANKS for the sake of clarity.
v3:
- Wrote a more clear commit message.
- Fixed pr_err() message.
v2:
- A new patch.
---
 drivers/char/tpm/tpm-chip.c | 13 +++++++++----
 drivers/char/tpm/tpm.h      |  1 -
 drivers/char/tpm/tpm1-cmd.c | 25 -------------------------
 drivers/char/tpm/tpm2-cmd.c |  8 +++-----
 include/linux/tpm.h         |  8 +++++---
 5 files changed, 17 insertions(+), 38 deletions(-)

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
index 7d77f6fbc152..97501c567c34 100644
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
+	if (nr_possible_banks > TPM2_MAX_PCR_BANKS) {
+		pr_err("tpm: unexpected number of banks: %u > %u",
+		       nr_possible_banks, TPM2_MAX_PCR_BANKS);
 		rc = -ENOMEM;
 		goto out;
 	}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 900c81a2bc41..f998dca4ea07 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -27,7 +27,9 @@
 #include <crypto/aes.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
+
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+#define TPM2_MAX_PCR_BANKS	8
 
 struct tpm_chip;
 struct trusted_key_payload;
@@ -69,7 +71,7 @@ enum tpm2_curves {
 
 struct tpm_digest {
 	u16 alg_id;
-	u8 digest[TPM_MAX_DIGEST_SIZE];
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
 } __packed;
 
 struct tpm_bank_info {
@@ -190,7 +192,7 @@ struct tpm_chip {
 	unsigned int groups_cnt;
 
 	u32 nr_allocated_banks;
-	struct tpm_bank_info *allocated_banks;
+	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
-- 
2.39.5


