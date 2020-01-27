Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3616314A8B0
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 18:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgA0RH0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 12:07:26 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727586AbgA0RH0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:07:26 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BBBAF1FB86A83793CFCF;
        Mon, 27 Jan 2020 17:07:24 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 27 Jan 2020 17:07:15 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>,
        <james.bottomley@hansenpartnership.com>,
        <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 8/8] ima: switch to ima_hash_algo for boot aggregate
Date:   Mon, 27 Jan 2020 18:04:43 +0100
Message-ID: <20200127170443.21538-9-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127170443.21538-1-roberto.sassu@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
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
work with a TPM 1.2, the SHA1 PCR bank was always selected.

Currently, even if a TPM 2.0 is used, the SHA1 PCR bank is selected.
However, the assumption that the SHA1 PCR bank is always available is not
correct, as PCR banks can be selected with the PCR_Allocate() TPM command.

This patch tries to use ima_hash_algo as hash algorithm for boot_aggregate.
If no PCR bank uses that algorithm, the patch scans the allocated PCR banks
and selects the first for which the mapping between TPM algorithm ID and
crypto algorithm ID is known. If no suitable algorithm is found, an error
is returned.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_crypto.c | 38 +++++++++++++++++------------
 security/integrity/ima/ima_init.c   |  6 ++---
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index f84dfd8fc5ca..9bf5e69945b7 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -780,25 +780,27 @@ static void __init ima_pcrread(u32 idx, struct tpm_digest *d)
 /*
  * Calculate the boot aggregate hash
  */
-static int __init ima_calc_boot_aggregate_tfm(char *digest,
-					      struct crypto_shash *tfm)
+static int __init ima_calc_boot_aggregate_tfm(char *digest, int bank_idx)
 {
-	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0} };
+	struct tpm_digest d = { .digest = {0} };
 	int rc;
 	u32 i;
-	SHASH_DESC_ON_STACK(shash, tfm);
+	SHASH_DESC_ON_STACK(shash, ima_algo_array[bank_idx].tfm);
 
-	shash->tfm = tfm;
+	shash->tfm = ima_algo_array[bank_idx].tfm;
 
 	rc = crypto_shash_init(shash);
 	if (rc != 0)
 		return rc;
 
+	d.alg_id = ima_tpm_chip->allocated_banks[bank_idx].alg_id;
+
 	/* cumulative sha1 over tpm registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
 		/* now accumulate with current aggregate */
-		rc = crypto_shash_update(shash, d.digest, TPM_DIGEST_SIZE);
+		rc = crypto_shash_update(shash, d.digest,
+			ima_tpm_chip->allocated_banks[bank_idx].digest_size);
 	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
@@ -807,17 +809,21 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 
 int __init ima_calc_boot_aggregate(struct ima_digest_data *hash)
 {
-	struct crypto_shash *tfm;
-	int rc;
+	int bank_idx = ima_hash_algo_idx;
 
-	tfm = ima_alloc_tfm(hash->algo);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	hash->length = crypto_shash_digestsize(tfm);
-	rc = ima_calc_boot_aggregate_tfm(hash->digest, tfm);
+	if (bank_idx >= ima_tpm_chip->nr_allocated_banks) {
+		for (bank_idx = 0; bank_idx < ima_tpm_chip->nr_allocated_banks;
+		     bank_idx++)
+			if (ima_algo_array[bank_idx].tfm)
+				break;
 
-	ima_free_tfm(tfm);
+		if (bank_idx == ima_tpm_chip->nr_allocated_banks) {
+			pr_err("No suitable algo found for boot aggregate\n");
+			return -ENOENT;
+		}
+	}
 
-	return rc;
+	hash->algo = ima_algo_array[bank_idx].algo;
+	hash->length = crypto_shash_digestsize(ima_algo_array[bank_idx].tfm);
+	return ima_calc_boot_aggregate_tfm(hash->digest, bank_idx);
 }
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 195cb4079b2b..b4da190a33ba 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -51,14 +51,14 @@ static int __init ima_add_boot_aggregate(void)
 	int violation = 0;
 	struct {
 		struct ima_digest_data hdr;
-		char digest[TPM_DIGEST_SIZE];
+		char digest[SHA512_DIGEST_SIZE];
 	} hash;
 
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
 	iint->ima_hash = &hash.hdr;
-	iint->ima_hash->algo = HASH_ALGO_SHA1;
-	iint->ima_hash->length = SHA1_DIGEST_SIZE;
+	iint->ima_hash->algo = ima_hash_algo;
+	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
 
 	if (ima_tpm_chip) {
 		result = ima_calc_boot_aggregate(&hash.hdr);
-- 
2.17.1

