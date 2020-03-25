Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB32E19261E
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 11:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgCYKtX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 06:49:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbgCYKtX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 06:49:23 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 01DF12FCB04C1788E4CE;
        Wed, 25 Mar 2020 10:49:22 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Mar 2020 10:49:13 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v4 1/7] ima: Switch to ima_hash_algo for boot aggregate
Date:   Wed, 25 Mar 2020 11:47:06 +0100
Message-ID: <20200325104712.25694-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325104712.25694-1-roberto.sassu@huawei.com>
References: <20200325104712.25694-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

boot_aggregate is the first entry of IMA measurement list. Its purpose is
to link pre-boot measurements to IMA measurements. As IMA was designed to
work with a TPM 1.2, the SHA1 PCR bank was always selected even if a
TPM 2.0 with support for stronger hash algorithms is available.

This patch first tries to find a PCR bank with the IMA default hash
algorithm. If it does not find it, it selects the SHA256 PCR bank for
TPM 2.0 and SHA1 for TPM 1.2. Ultimately, it selects SHA1 also for TPM 2.0
if the SHA256 PCR bank is not found.

If none of the PCR banks above can be found, boot_aggregate file digest is
filled with zeros, as for TPM bypass, making it impossible to perform a
remote attestation of the system.

Changelog

v3:
- Remove option to select the first PCR bank and select SHA1 as fallback
  choice also for TPM 2.0 (suggested by Mimi)

v1:
- add Mimi's comments
- if there is no PCR bank for the IMA default hash algorithm use SHA256
  (suggested by James Bottomley)

Cc: stable@vger.kernel.org # 5.1.x
Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with PCR read")
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_crypto.c | 47 +++++++++++++++++++++++++----
 security/integrity/ima/ima_init.c   | 22 +++++++++++---
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 423c84f95a14..8e445a671225 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -655,18 +655,29 @@ static void __init ima_pcrread(u32 idx, struct tpm_digest *d)
 }
 
 /*
- * Calculate the boot aggregate hash
+ * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
+ * TPM 1.2 the boot_aggregate was based on reading the SHA1 PCRs, but with
+ * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
+ * allowing firmware to configure and enable different banks.
+ *
+ * Knowing which TPM bank is read to calculate the boot_aggregate digest
+ * needs to be conveyed to a verifier.  For this reason, use the same
+ * hash algorithm for reading the TPM PCRs as for calculating the boot
+ * aggregate digest as stored in the measurement list.
  */
-static int __init ima_calc_boot_aggregate_tfm(char *digest,
+static int __init ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 					      struct crypto_shash *tfm)
 {
-	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0} };
+	struct tpm_digest d = { .alg_id = alg_id, .digest = {0} };
 	int rc;
 	u32 i;
 	SHASH_DESC_ON_STACK(shash, tfm);
 
 	shash->tfm = tfm;
 
+	pr_devel("calculating the boot-aggregate based on TPM bank: %04x\n",
+		 d.alg_id);
+
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
 		return rc;
@@ -675,7 +686,8 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
 		/* now accumulate with current aggregate */
-		rc = crypto_shash_update(shash, d.digest, TPM_DIGEST_SIZE);
+		rc = crypto_shash_update(shash, d.digest,
+					 crypto_shash_digestsize(tfm));
 	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
@@ -685,14 +697,37 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 int __init ima_calc_boot_aggregate(struct ima_digest_data *hash)
 {
 	struct crypto_shash *tfm;
-	int rc;
+	u16 crypto_id, alg_id;
+	int rc, i, bank_idx = -1;
+
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
+		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
+		if (crypto_id == hash->algo) {
+			bank_idx = i;
+			break;
+		}
+
+		if (crypto_id == HASH_ALGO_SHA256)
+			bank_idx = i;
+
+		if (bank_idx == -1 && crypto_id == HASH_ALGO_SHA1)
+			bank_idx = i;
+	}
+
+	if (bank_idx == -1) {
+		pr_err("No suitable TPM algorithm for boot aggregate\n");
+		return 0;
+	}
+
+	hash->algo = ima_tpm_chip->allocated_banks[bank_idx].crypto_id;
 
 	tfm = ima_alloc_tfm(hash->algo);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
 	hash->length = crypto_shash_digestsize(tfm);
-	rc = ima_calc_boot_aggregate_tfm(hash->digest, tfm);
+	alg_id = ima_tpm_chip->allocated_banks[bank_idx].alg_id;
+	rc = ima_calc_boot_aggregate_tfm(hash->digest, alg_id, tfm);
 
 	ima_free_tfm(tfm);
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 567468188a61..fc1e1002b48d 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -25,7 +25,7 @@ struct tpm_chip *ima_tpm_chip;
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
  *
- * Calculate the boot aggregate, a SHA1 over tpm registers 0-7,
+ * Calculate the boot aggregate, a hash over tpm registers 0-7,
  * assuming a TPM chip exists, and zeroes if the TPM chip does not
  * exist.  Add the boot aggregate measurement to the measurement
  * list and extend the PCR register.
@@ -49,15 +49,27 @@ static int __init ima_add_boot_aggregate(void)
 	int violation = 0;
 	struct {
 		struct ima_digest_data hdr;
-		char digest[TPM_DIGEST_SIZE];
+		char digest[TPM_MAX_DIGEST_SIZE];
 	} hash;
 
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
 	iint->ima_hash = &hash.hdr;
-	iint->ima_hash->algo = HASH_ALGO_SHA1;
-	iint->ima_hash->length = SHA1_DIGEST_SIZE;
-
+	iint->ima_hash->algo = ima_hash_algo;
+	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
+
+	/*
+	 * With TPM 2.0 hash agility, TPM chips could support multiple TPM
+	 * PCR banks, allowing firmware to configure and enable different
+	 * banks.  The SHA1 bank is not necessarily enabled.
+	 *
+	 * Use the same hash algorithm for reading the TPM PCRs as for
+	 * calculating the boot aggregate digest.  Preference is given to
+	 * the configured IMA default hash algorithm.  Otherwise, use the
+	 * TCG required banks - SHA256 for TPM 2.0, SHA1 for TPM 1.2.
+	 * Ultimately select SHA1 also for TPM 2.0 if the SHA256 PCR bank
+	 * is not found.
+	 */
 	if (ima_tpm_chip) {
 		result = ima_calc_boot_aggregate(&hash.hdr);
 		if (result < 0) {
-- 
2.17.1

