Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1E1F79E2
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2020 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgFLOio (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jun 2020 10:38:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbgFLOin (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jun 2020 10:38:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CEXCOO067394;
        Fri, 12 Jun 2020 10:38:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31mb5r92t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 10:38:34 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05CEXLev068274;
        Fri, 12 Jun 2020 10:38:33 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31mb5r92sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 10:38:33 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CEYj4D018886;
        Fri, 12 Jun 2020 14:38:32 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 31jqymac17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 14:38:32 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CEcU2f30802356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 14:38:30 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3044C605B;
        Fri, 12 Jun 2020 14:38:30 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5637C605A;
        Fri, 12 Jun 2020 14:38:29 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.65.244.234])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jun 2020 14:38:29 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, maurizio.drocco@ibm.com,
        serge@hallyn.com
Subject: [PATCH] extend IMA boot_aggregate with kernel measurements
Date:   Fri, 12 Jun 2020 10:38:12 -0400
Message-Id: <20200612143812.1609-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1591921795.11061.12.camel@linux.ibm.com>
References: <1591921795.11061.12.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_11:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=999 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120109
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
 security/integrity/ima/ima_crypto.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index 220b14920c37..64f5e3151e18 100644
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
@@ -830,6 +830,19 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 		rc = crypto_shash_update(shash, d.digest,
 					 crypto_shash_digestsize(tfm));
 	}
+	/*
+	 * extend cumulative sha1 over tpm registers 8-9, which contain
+	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
+	 * in a typical PCR allocation.
+	 */
+	for (i = TPM_PCR8; i < TPM_PCR10; i++) {
+		ima_pcrread(i, &d);
+		/* if not zero, accumulate with current aggregate */
+		if (memcmp(d.digest, d0.digest,
+			   crypto_shash_digestsize(tfm)) != 0)
+			rc = crypto_shash_update(shash, d.digest,
+						 crypto_shash_digestsize(tfm));
+	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
 	return rc;
-- 
2.17.1

