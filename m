Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11FB205674
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbgFWP5u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 11:57:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731616AbgFWP5t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 11:57:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NFX7DJ076972;
        Tue, 23 Jun 2020 11:57:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uk60uwnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 11:57:41 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NFXOUG078594;
        Tue, 23 Jun 2020 11:57:40 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uk60uwnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 11:57:40 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NFdlNl004195;
        Tue, 23 Jun 2020 15:57:39 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 31uk480ve1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 15:57:39 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05NFvcUh52887958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 15:57:38 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0229978066;
        Tue, 23 Jun 2020 15:57:38 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB7187805C;
        Tue, 23 Jun 2020 15:57:36 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.160.30.158])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 15:57:36 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     zohar@linux.ibm.com
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, maurizio.drocco@ibm.com,
        mdrocco@linux.vnet.ibm.com, roberto.sassu@huawei.com,
        serge@hallyn.com
Subject: [PATCH v4] ima: extend boot_aggregate with kernel measurements
Date:   Tue, 23 Jun 2020 11:57:32 -0400
Message-Id: <20200623155732.105-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1592920990.5437.15.camel@linux.ibm.com>
References: <1592920990.5437.15.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_07:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=1
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230118
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Registers 8-9 are used to store measurements of the kernel and its
command line (e.g., grub2 bootloader with tpm module enabled). IMA
should include them in the boot aggregate. Registers 8-9 should be
only included in non-SHA1 digests to avoid ambiguity.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
---
Changelog:
v4:
- Reworded comments: PCRs 8 & 9 are always included in non-sha1 digests
v3:
- Limit including PCRs 8 & 9 to non-sha1 hashes
v2:
- Minor comment improvements
v1:
- Include non zero PCRs 8 & 9 in the boot_aggregate

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
index 220b14920c37..011c3c76af86 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -823,13 +823,26 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
 	if (rc != 0)
 		return rc;
 
-	/* cumulative sha1 over tpm registers 0-7 */
+	/* cumulative digest over TPM registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
 		/* now accumulate with current aggregate */
 		rc = crypto_shash_update(shash, d.digest,
 					 crypto_shash_digestsize(tfm));
 	}
+	/*
+	 * Extend cumulative digest over TPM registers 8-9, which contain
+	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
+	 * in a typical PCR allocation. Registers 8-9 are only included in
+	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
+	 */
+	if (alg_id != TPM_ALG_SHA1) {
+		for (i = TPM_PCR8; i < TPM_PCR10; i++) {
+			ima_pcrread(i, &d);
+			rc = crypto_shash_update(shash, d.digest,
+						crypto_shash_digestsize(tfm));
+		}
+	}
 	if (!rc)
 		crypto_shash_final(shash, digest);
 	return rc;
-- 
2.17.1

