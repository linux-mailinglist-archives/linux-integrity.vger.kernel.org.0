Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475C1149AB2
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jan 2020 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgAZNOE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jan 2020 08:14:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726518AbgAZNOE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jan 2020 08:14:04 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00QDAKjq098563
        for <linux-integrity@vger.kernel.org>; Sun, 26 Jan 2020 08:14:02 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrgqcqwkk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 26 Jan 2020 08:14:02 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 26 Jan 2020 13:14:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 26 Jan 2020 13:13:59 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00QDDwgj37945524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jan 2020 13:13:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8289011C04C;
        Sun, 26 Jan 2020 13:13:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C257F11C04A;
        Sun, 26 Jan 2020 13:13:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.205.7])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 Jan 2020 13:13:57 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima: fix calculating the boot_aggregate
Date:   Sun, 26 Jan 2020 08:13:54 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 20012613-0012-0000-0000-00000380C383
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012613-0013-0000-0000-000021BD10FC
Message-Id: <1580044434-9132-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-26_01:2020-01-24,2020-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001260115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Calculating the boot_aggregate assumes that the TPM SHA1 bank is
enabled.  Before trying to read the TPM SHA1 bank, ensure it is enabled.
If it isn't enabled, calculate the boot_aggregate using the first bank
enabled.

Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_crypto.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7967a6904851..1253a2c187ef 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -663,6 +663,7 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 					      struct crypto_shash *tfm)
 {
 	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0} };
+	int found = 0;
 	int rc;
 	u32 i;
 	SHASH_DESC_ON_STACK(shash, tfm);
@@ -673,6 +674,22 @@ static int __init ima_calc_boot_aggregate_tfm(char *digest,
 	if (rc != 0)
 		return rc;
 
+	/*
+	 * For backward's compatibility use TPM PCR SHA1 bank if allocated,
+	 * otherwise use first enabled bank.
+	 */
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
+		if (ima_tpm_chip->allocated_banks[i].alg_id == TPM_ALG_SHA1) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		d.alg_id = ima_tpm_chip->allocated_banks[0].alg_id;
+		pr_info("Calculating the boot-aggregregate (TPM algorithm: %d)",
+			d.alg_id);
+	}
+
 	/* cumulative sha1 over tpm registers 0-7 */
 	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
 		ima_pcrread(i, &d);
-- 
2.7.5

