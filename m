Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7351E14A7B7
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgA0QCT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 11:02:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbgA0QCT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 11:02:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RFsbuh118737
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 11:02:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrk3bt537-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 11:02:17 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 27 Jan 2020 16:02:15 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 16:02:12 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RG1KaJ43057476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 16:01:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 464FCA4040;
        Mon, 27 Jan 2020 16:02:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CB36A404D;
        Mon, 27 Jan 2020 16:02:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.238])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 16:02:10 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 2/2] ima: support calculating the boot_aggregate based on different TPM banks
Date:   Mon, 27 Jan 2020 11:01:59 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20012716-0016-0000-0000-000002E11ED7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012716-0017-0000-0000-00003343DC02
Message-Id: <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_05:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=1 phishscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270134
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Calculating the boot_aggregate attempts to read the TPM SHA1 bank,
assuming it is always enabled.  With TPM 2.0 hash agility, TPM chips
could support multiple TPM PCR banks, allowing firmware to configure and
enable different banks.

Instead of hard coding the TPM 2.0 bank hash algorithm used for calculating
the boot-aggregate, see if the configured IMA_DEFAULT_HASH algorithm is
an allocated TPM bank, otherwise use the first allocated TPM bank.

For TPM 1.2 SHA1 is the only supported hash algorithm.

Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_crypto.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7967a6904851..b1b26d61f174 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -656,8 +656,25 @@ static void __init ima_pcrread(u32 idx, struct tpm_digest *d)
 		pr_err("Error Communicating to TPM chip\n");
 }
 
+/* tpm2_hash_map is the same as defined in tpm2-cmd.c and trusted_tpm2.c */
+static struct tpm2_hash tpm2_hash_map[] = {
+	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
+	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
+	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
+	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
+	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
+};
+
 /*
- * Calculate the boot aggregate hash
+ * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
+ * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
+ * allowing firmware to configure and enable different banks.
+ *
+ * Instead of hard coding the TPM bank hash algorithm used for calculating
+ * the boot-aggregate, see if the configured IMA_DEFAULT_HASH algorithm is
+ * an allocated TPM bank, otherwise use the first allocated TPM bank.
+ *
+ * For TPM 1.2 SHA1 is the only hash algorithm.
  */
 static int __init ima_calc_boot_aggregate_tfm(char *digest,
 					      struct crypto_shash *tfm)
@@ -673,6 +690,24 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 	if (rc != 0)
 		return rc;
 
+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
+		if (tpm2_hash_map[i].crypto_id == ima_hash_algo) {
+			d.alg_id = tpm2_hash_map[i].tpm_id;
+			break;
+		}
+	}
+
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
+		if (ima_tpm_chip->allocated_banks[i].alg_id == d.alg_id)
+			break;
+	}
+
+	if (i == ima_tpm_chip->nr_allocated_banks)
+		d.alg_id = ima_tpm_chip->allocated_banks[0].alg_id;
+
+	pr_info("Calculating the boot-aggregregate, reading TPM PCR bank: %04x",
+		d.alg_id);
+
 	/* cumulative sha1 over tpm registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
-- 
2.7.5

