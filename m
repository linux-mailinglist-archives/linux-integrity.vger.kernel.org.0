Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008941686CD
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgBUSjt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 13:39:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgBUSjt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 13:39:49 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LIdjcl036658
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:48 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubwnsxm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:47 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Feb 2020 18:39:18 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 18:39:15 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LIdEXd50725062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 18:39:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FB20AE045;
        Fri, 21 Feb 2020 18:39:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC8A9AE04D;
        Fri, 21 Feb 2020 18:39:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 18:39:13 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 7/8] ima-evm-utils: use a common bank variable for TPM 1.2 and TPM 2.0
Date:   Fri, 21 Feb 2020 13:38:57 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022118-0020-0000-0000-000003AC6647
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-0021-0000-0000-00002204717D
Message-Id: <1582310338-1562-8-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210141
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend read_tpm_banks() to support TPM 1.2, by reading TPM 1.2 SHA1 PCRs
into the first bank and mark the other banks as disabled.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 9e21d3963556..49ce7ea2ce1a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1399,7 +1399,7 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 	char *p, pcr_str[7], buf[70]; /* length of the TPM string */
 	int result = -1;
 
-	sprintf(pcr_str, "PCR-%d", idx);
+	sprintf(pcr_str, "PCR-%2.2d", idx);
 
 	fp = fopen(pcrs, "r");
 	if (!fp)
@@ -1844,8 +1844,26 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
 #endif
 }
 
+/* Read TPM 1.2 PCRs */
+static int read_tpm_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
+{
+	int i;
+
+	for (i = 0; i < NUM_PCRS; i++) {
+		if (tpm_pcr_read(i, tpm_banks[0].pcr[i], SHA_DIGEST_LENGTH)) {
+			log_debug("Failed to read TPM 1.2 PCRs.\n");
+			return -1;
+		}
+	}
+
+	tpm_banks[0].supported = 1;
+	for (i = 1; i < num_banks; i++)
+		tpm_banks[i].supported = 0;
+	return 0;
+}
+
 /*
- * Attempt to read TPM PCRs from the multiple TPM 2.0 banks.
+ * Attempt to read TPM PCRs from either TPM 1.2 or multiple TPM 2.0 banks.
  *
  * On success reading from any TPM bank, return 0.
  */
@@ -1856,12 +1874,17 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	int i, j;
 	int err;
 
+	/* First try reading PCRs from exported TPM 1.2 securityfs file */
+	if (read_tpm_pcrs(num_banks, bank) == 0)
+		return 0;
+
 	/* Any userspace applications available for reading TPM 2.0 PCRs? */
 	if (!tpm2_pcrread) {
-		log_info("Failed to read TPM 2.0 PCRs\n");
+		log_debug("Failed to read TPM 2.0 PCRs\n");
 		return 1;
 	}
 
+	/* Read PCRs from multiple TPM 2.0 banks */
 	for (i = 0; i < num_banks; i++) {
 		err = 0;
 		for (j = 0; j < NUM_PCRS && !err; j++) {
@@ -1869,8 +1892,8 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 					    bank[i].pcr[j], bank[i].digest_size,
 					    &errmsg);
 			if (err) {
-				log_info("Failed to read %s PCRs: (%s)\n",
-					 bank[i].algo_name, errmsg);
+				log_debug("Failed to read %s PCRs: (%s)\n",
+					  bank[i].algo_name, errmsg);
 				free(errmsg);
 				bank[i].supported = 0;
 			}
@@ -1991,8 +2014,8 @@ static int ima_measurement(const char *file)
 
 	if (!verify_failed)
 		err = 0;
-	else if (read_tpm_banks(num_banks, tpm_banks) != 0)
-		log_info("Failed to read TPM 2.0 PCRs\n");
+	if (read_tpm_banks(num_banks, tpm_banks) != 0)
+		log_info("Failed to read any TPM PCRs\n");
 	else
 		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
 
-- 
2.7.5

