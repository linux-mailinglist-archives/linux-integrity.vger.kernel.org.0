Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30BD14DEFB
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgA3QXR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 11:23:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727332AbgA3QXK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 11:23:10 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UGIdZm120318
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2020 11:23:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xuvd5n3qq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2020 11:23:09 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 30 Jan 2020 16:23:07 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 16:23:04 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00UGN3nB39780488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 16:23:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CC1742041;
        Thu, 30 Jan 2020 16:23:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 746F54203F;
        Thu, 30 Jan 2020 16:23:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.199.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 16:23:02 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 1/2] ima: support calculating the boot aggregate based on non-SHA1 algorithms
Date:   Thu, 30 Jan 2020 11:22:42 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 20013016-0016-0000-0000-000002E23C14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013016-0017-0000-0000-00003345077F
Message-Id: <1580401363-5593-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_05:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=1
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The boot aggregate is a cumulative SHA1 hash over TPM registers 0 - 7.
NIST has depreciated the usage of SHA1 in most instances.  Instead of
continuing to use SHA1 to calculate the boot_aggregate, use the same
hash algorithm for reading the TPM PCRs as for calculating the boot
aggregate digest.  Preference is given to the configured IMA default
hash algorithm.

Although the IMA measurement list boot_aggregate template data contains
the hash algorithm followed by the digest, allowing verifiers (e.g.
attesttaion servers) to calculate and verify the boot_aggregate, the
verifiers might not have the knowledge of what constitutes a good value
based on a different hash algorithm.

Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>  # using common alg
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_init.c | 41 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 195cb4079b2b..e79fdd8cc860 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -27,7 +27,7 @@ struct tpm_chip *ima_tpm_chip;
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
  *
- * Calculate the boot aggregate, a SHA1 over tpm registers 0-7,
+ * Calculate the boot aggregate, a hash over tpm registers 0-7,
  * assuming a TPM chip exists, and zeroes if the TPM chip does not
  * exist.  Add the boot aggregate measurement to the measurement
  * list and extend the PCR register.
@@ -49,18 +49,49 @@ static int __init ima_add_boot_aggregate(void)
 					     .filename = boot_aggregate_name };
 	int result = -ENOMEM;
 	int violation = 0;
+	int i;
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
+	iint->ima_hash->algo = ima_hash_algo;	/* preferred algorithm */
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
+	 * TPM required banks - SHA256 for TPM 2.0, SHA1 for TPM 1.2.
+	 */
 	if (ima_tpm_chip) {
+		for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
+			if (ima_hash_algo ==
+			    ima_tpm_chip->allocated_banks[i].crypto_id)
+				break;
+		}
+
+		/*
+		 * The IMA default hash algo is not an enabled TPM PCR
+		 * bank, use the TPM required bank.
+		 */
+		if (i == ima_tpm_chip->nr_allocated_banks) {
+			if (ima_tpm_chip->flags & TPM_CHIP_FLAG_TPM2) {
+				iint->ima_hash->algo = HASH_ALGO_SHA256;
+				iint->ima_hash->length = SHA256_DIGEST_SIZE;
+			} else {
+				iint->ima_hash->algo = HASH_ALGO_SHA1;
+				iint->ima_hash->length = SHA1_DIGEST_SIZE;
+			}
+		}
+
 		result = ima_calc_boot_aggregate(&hash.hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
-- 
2.7.5

