Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3721BA2D
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGJQBP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:01:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727901AbgGJQBP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AFXf1a157319;
        Fri, 10 Jul 2020 12:01:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpc1c5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:12 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFXpov158421;
        Fri, 10 Jul 2020 12:01:11 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpc1c3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:11 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AG19HS030328;
        Fri, 10 Jul 2020 16:01:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 326bcf0sg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:01:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AG17vw6226176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:01:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C70F4204D;
        Fri, 10 Jul 2020 16:01:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 727EF4203F;
        Fri, 10 Jul 2020 16:01:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:06 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 2/8] ima_evm_utils: support extending TPM 2.0 banks w/original SHA1 padded digest
Date:   Fri, 10 Jul 2020 12:00:53 -0400
Message-Id: <1594396859-9232-3-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_10:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Initially the sha1 digest, including violations, was padded with zeroes
before being extended into the other TPM banks.  Support walking the
IMA measurement list, calculating the per TPM bank SHA1 padded
digest(s).

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 0e489e2c7ba6..814aa6b75571 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1613,6 +1613,10 @@ static struct tpm_bank_info *init_tpm_banks(int *num_banks)
 	return banks;
 }
 
+/*
+ * Compare the calculated TPM PCR banks against the PCR values read.
+ * On failure to match any TPM bank, fail comparison.
+ */
 static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
 			     struct tpm_bank_info *tpm_bank)
 {
@@ -1632,14 +1636,15 @@ static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
 			log_info("%s: TPM PCR-%d: ", tpm_bank[i].algo_name, j);
 			log_dump(tpm_bank[i].pcr[j], tpm_bank[i].digest_size);
 
-			ret = memcmp(bank[i].pcr[j], tpm_bank[i].pcr[j],
-				     bank[i].digest_size);
-			if (!ret)
+			if (memcmp(bank[i].pcr[j], tpm_bank[i].pcr[j],
+				     bank[i].digest_size) == 0) {
 				log_info("%s PCR-%d: succeed\n",
 					 bank[i].algo_name, j);
-			else
+			} else {
+				ret = 1;
 				log_info("%s: PCRAgg %d does not match TPM PCR-%d\n",
 					 bank[i].algo_name, j, j);
+			}
 		}
 	}
 	return ret;
@@ -1695,10 +1700,7 @@ static int extend_tpm_bank(EVP_MD_CTX *pctx, const EVP_MD *md,
 		goto out;
 	}
 
-	if (validate && !memcmp(entry->header.digest, zero, SHA_DIGEST_LENGTH))
-		err = EVP_DigestUpdate(pctx, fox, bank->digest_size);
-	else
-		err = EVP_DigestUpdate(pctx, bank->digest, bank->digest_size);
+	err = EVP_DigestUpdate(pctx, bank->digest, bank->digest_size);
 	if (!err) {
 		printf("EVP_DigestUpdate() failed\n");
 		goto out;
@@ -1716,7 +1718,8 @@ out:
 
 /* Calculate and extend the template hash for multiple hash algorithms */
 static void extend_tpm_banks(struct template_entry *entry, int num_banks,
-			     struct tpm_bank_info *bank)
+			     struct tpm_bank_info *bank,
+			     struct tpm_bank_info *padded_bank)
 {
 	EVP_MD_CTX *pctx;
 	const EVP_MD *md;
@@ -1741,24 +1744,53 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
 		}
 
 		/*
-		 * Measurement violations are 0x00 digests.  No need to
-		 * calculate the per TPM bank template digests.
+		 * Measurement violations are 0x00 digests, which are extended
+		 * into the TPM as 0xff.  Verifying the IMA measurement list
+		 * will fail, unless the 0x00 digests are converted to 0xff's.
+		 *
+		 * Initially the sha1 digest, including violations, was padded
+		 * with zeroes before being extended into the TPM.  With the
+		 * per TPM bank digest, violations are the full per bank digest
+		 * size.
 		 */
-		if (memcmp(entry->header.digest, zero, SHA_DIGEST_LENGTH) == 0)
-			memset(bank[i].digest, 0x00, bank[i].digest_size);
-		else {
+		if (memcmp(entry->header.digest, zero, SHA_DIGEST_LENGTH) == 0) {
+			if (!validate) {
+				memset(bank[i].digest, 0x00, bank[i].digest_size);
+				memset(padded_bank[i].digest, 0x00, padded_bank[i].digest_size);
+			} else {
+				memset(bank[i].digest, 0xff,
+				       bank[i].digest_size);
+
+				memset(padded_bank[i].digest, 0x00,
+				       padded_bank[i].digest_size);
+				memset(padded_bank[i].digest, 0xff,
+				       SHA_DIGEST_LENGTH);
+			}
+		} else {
 			err = calculate_template_digest(pctx, md, entry,
 							&bank[i]);
 			if (!err) {
 				bank[i].supported = 0;
 				continue;
 			}
+
+			/*
+			 * calloc set the memory to zero, so just copy the
+			 * sha1 digest.
+			 */
+			memcpy(padded_bank[i].digest, entry->header.digest,
+			       SHA_DIGEST_LENGTH);
 		}
 
 		/* extend TPM BANK with template digest */
 		err = extend_tpm_bank(pctx, md, entry, &bank[i]);
 		if (!err)
 			bank[i].supported = 0;
+
+		/* extend TPM BANK with zero padded sha1 template digest */
+		err = extend_tpm_bank(pctx, md, entry, &padded_bank[i]);
+		if (!err)
+			padded_bank[i].supported = 0;
 	}
 #if OPENSSL_VERSION_NUMBER >= 0x10100000
 	EVP_MD_CTX_free(pctx);
@@ -1825,6 +1857,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 
 static int ima_measurement(const char *file)
 {
+	struct tpm_bank_info *pseudo_padded_banks;
 	struct tpm_bank_info *pseudo_banks;
 	struct tpm_bank_info *tpm_banks;
 	int is_ima_template, cur_template_fmt;
@@ -1839,6 +1872,7 @@ static int ima_measurement(const char *file)
 	memset(zero, 0, MAX_DIGEST_SIZE);
 	memset(fox, 0xff, MAX_DIGEST_SIZE);
 
+	pseudo_padded_banks = init_tpm_banks(&num_banks);
 	pseudo_banks = init_tpm_banks(&num_banks);
 	tpm_banks = init_tpm_banks(&num_banks);
 
@@ -1939,7 +1973,8 @@ static int ima_measurement(const char *file)
 			       entry.template_buf_len - len);
 		}
 
-		extend_tpm_banks(&entry, num_banks, pseudo_banks);
+		extend_tpm_banks(&entry, num_banks, pseudo_banks,
+				 pseudo_padded_banks);
 
 		if (verify)
 			ima_verify_template_hash(&entry);
@@ -1954,7 +1989,15 @@ static int ima_measurement(const char *file)
 		err = 0;
 		log_info("Failed to read any TPM PCRs\n");
 	} else {
+		log_info("Comparing with per TPM digest\n");
 		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
+
+		/* On failure, check older SHA1 zero padded hashes */
+		if (err) {
+			log_info("Comparing with SHA1 padded digest\n");
+			err = compare_tpm_banks(num_banks, pseudo_padded_banks,
+						tpm_banks);
+		}
 	}
 
 out:
-- 
2.7.5

