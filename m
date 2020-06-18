Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A811FFC56
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 22:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgFRUMM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 16:12:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728027AbgFRUML (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 16:12:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IK3Rfs190980;
        Thu, 18 Jun 2020 16:11:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31repa0rby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 16:11:56 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05IKArYY020767;
        Thu, 18 Jun 2020 16:11:56 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31repa0rbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 16:11:56 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IK9t3q005729;
        Thu, 18 Jun 2020 20:11:55 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 31q8kkwv2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 20:11:55 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05IKBsJ412845462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 20:11:54 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BC20AE06B;
        Thu, 18 Jun 2020 20:11:54 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A50AE064;
        Thu, 18 Jun 2020 20:11:53 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.160.61.88])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jun 2020 20:11:53 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     roberto.sassu@huawei.com
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, maurizio.drocco@ibm.com,
        serge@hallyn.com, zohar@linux.ibm.com, mdrocco@linux.vnet.ibm.com
Subject: [PATCH] extend IMA boot_aggregate with kernel measurements
Date:   Thu, 18 Jun 2020 16:11:25 -0400
Message-Id: <20200618201126.2081-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b744c1b79ba14a17a786f5de04c1f3c4@huawei.com>
References: <b744c1b79ba14a17a786f5de04c1f3c4@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 clxscore=1011
 mlxscore=0 cotscore=-2147483648 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA is not considering TPM registers 8-9 when calculating the boot
aggregate. When registers 8-9 are used to store measurements of the
kernel and its command line (e.g., grub2 bootloader with tpm module
enabled), IMA should include them in the boot aggregate.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
---
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index df93ac258e01..9d94080bdad8 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -30,7 +30,7 @@
 
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
-enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
+enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 /* digest size for IMA, fits SHA1 or MD5 */
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 220b14920c37..299b23dad8d9 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -809,7 +809,7 @@ static void ima_pcrread(u32 idx, struct tpm_digest *d)
 static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 				       struct crypto_shash *tfm)
 {
-	struct tpm_digest d = { .alg_id = alg_id, .digest = {0} };
+	struct tpm_digest d = { .alg_id = alg_id, .digest = {0} }, d0 = d;
 	int rc;
 	u32 i;
 	SHASH_DESC_ON_STACK(shash, tfm);
@@ -823,13 +823,29 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 	if (rc != 0)
 		return rc;
 
-	/* cumulative sha1 over tpm registers 0-7 */
+	/* cumulative digest over tpm registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
 		/* now accumulate with current aggregate */
 		rc = crypto_shash_update(shash, d.digest,
 					 crypto_shash_digestsize(tfm));
 	}
+	/*
+	 * extend cumulative digest over tpm registers 8-9, which contain
+	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
+	 * in a typical PCR allocation. Registers 8-9 are only included in
+	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
+	 */
+	if (alg_id != TPM_ALG_SHA1) {
+		for (i = TPM_PCR8; i < TPM_PCR10; i++) {
+			ima_pcrread(i, &d);
+			/* if not zero, accumulate with current aggregate */
+			if (memcmp(d.digest, d0.digest,
+				crypto_shash_digestsize(tfm)) != 0)
+				rc = crypto_shash_update(shash, d.digest,
+						crypto_shash_digestsize(tfm));
+		}
+	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
 	return rc;
-- 
2.17.1

