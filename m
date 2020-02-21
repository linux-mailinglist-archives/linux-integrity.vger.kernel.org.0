Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E81686CF
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 19:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgBUSju (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 13:39:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729288AbgBUSju (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 13:39:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LIdkrA186542
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:49 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubycwum-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:48 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Feb 2020 18:39:14 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 18:39:10 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LId9sZ42467454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 18:39:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACA32AE053;
        Fri, 21 Feb 2020 18:39:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F5FDAE051;
        Fri, 21 Feb 2020 18:39:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 18:39:08 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 3/8] ima-evm-utils: calculate the digests for multiple TPM banks
Date:   Fri, 21 Feb 2020 13:38:53 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022118-0020-0000-0000-000003AC6645
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-0021-0000-0000-00002204717B
Message-Id: <1582310338-1562-4-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=3 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210141
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA currently extends the different TPM banks by padding/truncating the
SHA1 template digest.  Although the IMA measurement list only includes
the SHA1 template digest, the template digest could be re-calculated
properly for each bank.

This patch adds support for properly calculating the template hash for
multiple TPM banks - "sha1" and "sha256".

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 162 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 9c8544a95b6a..61a0e15c8dd7 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -63,6 +63,7 @@
 #include <openssl/err.h>
 #include <openssl/rsa.h>
 #include <openssl/engine.h>
+#include "hash_info.h"
 
 #ifndef XATTR_APPAARMOR_SUFFIX
 #define XATTR_APPARMOR_SUFFIX "apparmor"
@@ -1647,8 +1648,165 @@ void ima_ng_show(struct template_entry *entry)
 	}
 }
 
+struct tpm_bank_info {
+	int digest_size;
+	int supported;
+	const char *algo_name;
+	uint8_t digest[MAX_DIGEST_SIZE];
+	uint8_t pcr[NUM_PCRS][MAX_DIGEST_SIZE];
+};
+
+static void set_bank_info(struct tpm_bank_info *bank, const char *algo_name)
+{
+	const EVP_MD *md;
+
+	bank->algo_name = algo_name;
+	md = EVP_get_digestbyname(bank->algo_name);
+	if (!md)
+		return;
+
+	bank->supported = 1;
+	bank->digest_size = EVP_MD_size(md);
+}
+
+static struct tpm_bank_info *init_tpm_banks(int *num_banks)
+{
+	struct tpm_bank_info *banks = NULL;
+	const char *default_algos[] = {"sha1", "sha256"};
+	int num_algos = sizeof(default_algos) / sizeof(default_algos[0]);
+	int i, j;
+
+	banks = calloc(num_algos, sizeof(struct tpm_bank_info));
+	if (!banks)
+		return banks;
+
+	/* re-calculate the PCRs digests for only known algorithms */
+	*num_banks = num_algos;
+	for (i = 0; i < num_algos; i++) {
+		for (j = 0; j < HASH_ALGO__LAST; j++) {
+			if (!strcmp(default_algos[i], hash_algo_name[j]))
+				set_bank_info(&banks[i], hash_algo_name[j]);
+		}
+	}
+	return banks;
+}
+
+/* Calculate the template hash for a particular hash algorithm */
+static int calculate_template_digest(EVP_MD_CTX *pctx, const EVP_MD *md,
+				     struct template_entry *entry,
+				     struct tpm_bank_info *bank)
+{
+	unsigned int mdlen;
+	int err;
+
+	err = EVP_DigestInit(pctx, md);
+	if (!err) {
+		printf("EVP_DigestInit() failed\n");
+		goto out;
+	}
+
+	err = EVP_DigestUpdate(pctx, entry->template, entry->template_len);
+	if (!err) {
+		printf("EVP_DigestUpdate() failed\n");
+		goto out;
+	}
+
+	err = EVP_DigestFinal(pctx, bank->digest, &mdlen);
+	if (!err)
+		printf("EVP_DigestUpdate() failed\n");
+out:
+	if (!err)
+		err = 1;
+	return err;
+}
+
+/* Extend a specific TPM bank with the template hash */
+static int extend_tpm_bank(EVP_MD_CTX *pctx, const EVP_MD *md,
+			   struct template_entry *entry,
+			   struct tpm_bank_info *bank)
+{
+	unsigned int mdlen;
+	int err;
+
+	err = EVP_DigestInit(pctx, md);
+	if (!err) {
+		printf("EVP_DigestInit() failed\n");
+		goto out;
+	}
+
+	err = EVP_DigestUpdate(pctx, bank->pcr[entry->header.pcr],
+			       bank->digest_size);
+	if (!err) {
+		printf("EVP_DigestUpdate() failed\n");
+		goto out;
+	}
+
+	if (validate && !memcmp(entry->header.digest, zero, SHA_DIGEST_LENGTH))
+		err = EVP_DigestUpdate(pctx, fox, bank->digest_size);
+	else
+		err = EVP_DigestUpdate(pctx, bank->digest, bank->digest_size);
+	if (!err) {
+		printf("EVP_DigestUpdate() failed\n");
+		goto out;
+	}
+
+	err = EVP_DigestFinal(pctx, bank->pcr[entry->header.pcr], &mdlen);
+	if (!err)
+		printf("EVP_DigestFinal() failed\n");
+
+out:
+	if (!err)
+		err = 1;
+	return err;
+}
+
+/* Calculate and extend the template hash for multiple hash algorithms */
+static void extend_tpm_banks(struct template_entry *entry, int num_banks,
+			     struct tpm_bank_info *bank)
+{
+	EVP_MD_CTX *pctx;
+	const EVP_MD *md;
+#if OPENSSL_VERSION_NUMBER < 0x10100000
+	EVP_MD_CTX ctx;
+	pctx = &ctx;
+#else
+	pctx = EVP_MD_CTX_new();
+#endif
+	int err;
+	int i;
+
+	for (i = 0; i < num_banks; i++) {
+		if (!bank[i].supported)
+			continue;
+		md = EVP_get_digestbyname(bank[i].algo_name);
+		if (!md) {
+			printf("EVP_get_digestbyname(%s) failed\n",
+				bank[i].algo_name);
+			bank[i].supported = 0;
+			continue;
+		}
+
+		err = calculate_template_digest(pctx, md, entry, &bank[i]);
+		if (!err) {
+			bank[i].supported = 0;
+			continue;
+		}
+
+		/* extend TPM BANK with template digest */
+		err = extend_tpm_bank(pctx, md, entry, &bank[i]);
+		if (!err)
+			bank[i].supported = 0;
+	}
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	EVP_MD_CTX_free(pctx);
+#endif
+}
+
 static int ima_measurement(const char *file)
 {
+	struct tpm_bank_info *pseudo_banks;
+	int num_banks = 0;
+
 	uint8_t pcr[NUM_PCRS][SHA_DIGEST_LENGTH] = {{0}};
 	uint8_t hwpcr[SHA_DIGEST_LENGTH];
 	struct template_entry entry = { .template = 0 };
@@ -1664,6 +1822,8 @@ static int ima_measurement(const char *file)
 	log_debug("Initial PCR value: ");
 	log_debug_dump(pcr, sizeof(pcr));
 
+	pseudo_banks = init_tpm_banks(&num_banks);
+
 	fp = fopen(file, "rb");
 	if (!fp) {
 		log_err("Failed to open measurement file: %s\n", file);
@@ -1702,6 +1862,8 @@ static int ima_measurement(const char *file)
 			goto out;
 		}
 
+		extend_tpm_banks(&entry, num_banks, pseudo_banks);
+
 		if (validate)
 			ima_verify_template_hash(&entry);
 
-- 
2.7.5

