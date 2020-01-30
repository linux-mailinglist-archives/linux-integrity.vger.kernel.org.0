Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414A514DEFA
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 17:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgA3QXM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 11:23:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727333AbgA3QXL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 11:23:11 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UGL5vN182353
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2020 11:23:10 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrj750760-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2020 11:23:10 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 30 Jan 2020 16:23:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 16:23:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00UGN42429819044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 16:23:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7599342042;
        Thu, 30 Jan 2020 16:23:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACE204203F;
        Thu, 30 Jan 2020 16:23:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.199.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 16:23:03 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 2/2] ima: support calculating the boot_aggregate based on different TPM banks
Date:   Thu, 30 Jan 2020 11:22:43 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1580401363-5593-1-git-send-email-zohar@linux.ibm.com>
References: <1580401363-5593-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20013016-0012-0000-0000-000003823BAF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013016-0013-0000-0000-000021BE96E8
Message-Id: <1580401363-5593-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_05:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Calculating the boot_aggregate attempts to read the TPM SHA1 bank,
assuming it is always enabled.  With TPM 2.0 hash agility, TPM chips
could support multiple TPM PCR banks, allowing firmware to configure and
enable different banks.

Instead of hard coding the TPM 2.0 bank hash algorithm used for calculating
the boot-aggregate, use the same hash algorithm for reading the TPM PCRs as
for calculating the boot aggregate digest.  Preference is given to the
configured IMA default hash algorithm.

For TPM 1.2 SHA1 is the only supported hash algorithm.

Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_crypto.c | 45 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7967a6904851..a020aaefdea8 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -656,13 +656,34 @@ static void __init ima_pcrread(u32 idx, struct tpm_digest *d)
 		pr_err("Error Communicating to TPM chip\n");
 }
 
+static enum hash_algo get_hash_algo(const char *algname)
+{
+	int i;
+
+	for (i = 0; i < HASH_ALGO__LAST; i++) {
+		if (strcmp(algname, hash_algo_name[i]) == 0)
+			break;
+	}
+
+	return i;
+}
+
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
 static int __init ima_calc_boot_aggregate_tfm(char *digest,
 					      struct crypto_shash *tfm)
 {
 	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0} };
+	enum hash_algo crypto_id;
 	int rc;
 	u32 i;
 	SHASH_DESC_ON_STACK(shash, tfm);
@@ -673,6 +694,28 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 	if (rc != 0)
 		return rc;
 
+	crypto_id = get_hash_algo(crypto_shash_alg_name(tfm));
+	if (crypto_id == HASH_ALGO__LAST) {
+		pr_devel("unknown hash algorithm (%s), failing to read PCRs.\n",
+			 crypto_shash_alg_name(tfm));
+		return 0;
+	}
+
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
+		if (ima_tpm_chip->allocated_banks[i].crypto_id == crypto_id) {
+			d.alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
+			break;
+		}
+	}
+	if (i == ima_tpm_chip->nr_allocated_banks) {
+		pr_devel("TPM %s bank not allocated, failing to read PCRs.\n",
+			 crypto_shash_alg_name(tfm));
+		return 0;
+	}
+
+	pr_devel("calculating the boot-aggregregate based on TPM bank: %04x\n",
+		  d.alg_id);
+
 	/* cumulative sha1 over tpm registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
-- 
2.7.5

