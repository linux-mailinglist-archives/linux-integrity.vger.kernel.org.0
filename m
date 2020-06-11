Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9841F6E57
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgFKTzN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jun 2020 15:55:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgFKTzN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jun 2020 15:55:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BJcst2100761;
        Thu, 11 Jun 2020 15:55:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31kgs4b27y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 15:55:02 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05BJgKBK112430;
        Thu, 11 Jun 2020 15:55:02 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31kgs4b274-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 15:55:02 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BJpIQO025893;
        Thu, 11 Jun 2020 19:55:01 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 31hw1cat5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 19:55:01 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05BJt0u914812116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 19:55:00 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3995112064;
        Thu, 11 Jun 2020 19:55:00 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 086EF112062;
        Thu, 11 Jun 2020 19:55:00 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.65.209.180])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jun 2020 19:54:59 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, Maurizio Drocco <maurizio.drocco@ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] extend IMA boot_aggregate with kernel measurements
Date:   Thu, 11 Jun 2020 15:54:22 -0400
Message-Id: <20200611195422.2117-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_20:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=1 lowpriorityscore=0 cotscore=-2147483648
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110151
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
 security/integrity/ima/ima_crypto.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index 220b14920c37..6f0137bdaf61 100644
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
@@ -830,6 +830,15 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 		rc = crypto_shash_update(shash, d.digest,
 					 crypto_shash_digestsize(tfm));
 	}
+	/* extend cumulative sha1 over tpm registers 8-9 */
+	for (i = TPM_PCR8; i < TPM_PCR10; i++) {
+		ima_pcrread(i, &d);
+		/* if not zero, accumulate with current aggregate */
+		if (memcmp(d.digest, d0.digest,
+					crypto_shash_digestsize(tfm) != 0))
+			rc = crypto_shash_update(shash, d.digest,
+					crypto_shash_digestsize(tfm));
+	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
 	return rc;
-- 
2.17.1

