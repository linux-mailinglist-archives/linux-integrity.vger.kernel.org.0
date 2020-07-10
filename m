Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25421BA2C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGJQBP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:01:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727810AbgGJQBO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AFWpvb156762;
        Fri, 10 Jul 2020 12:01:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk8unc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:11 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFkA42016279;
        Fri, 10 Jul 2020 12:01:11 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk8ukq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:10 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AFr4kX031046;
        Fri, 10 Jul 2020 16:01:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 326bcvrbkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:01:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AFxiA239977424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 15:59:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49B3742047;
        Fri, 10 Jul 2020 16:01:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DC3242049;
        Fri, 10 Jul 2020 16:01:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:05 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 1/8] ima-evm-utils: improve reading TPM 1.2 PCRs
Date:   Fri, 10 Jul 2020 12:00:52 -0400
Message-Id: <1594396859-9232-2-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_10:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007100104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of reading the TPM 1.2 PCRs one at a time, opening and closing
the securityfs file each time, read all of PCRs at once.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 21809b3229e9..0e489e2c7ba6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -152,6 +152,14 @@ static void print_usage(struct command *cmd);
 static const char *xattr_ima = "security.ima";
 static const char *xattr_evm = "security.evm";
 
+struct tpm_bank_info {
+	int digest_size;
+	int supported;
+	const char *algo_name;
+	uint8_t digest[MAX_DIGEST_SIZE];
+	uint8_t pcr[NUM_PCRS][MAX_DIGEST_SIZE];
+};
+
 static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
 {
 	FILE *fp;
@@ -1366,13 +1374,13 @@ static int cmd_ima_clear(struct command *cmd)
 static char *pcrs = "/sys/class/tpm/tpm0/device/pcrs";  /* Kernels >= 4.0 */
 static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
 
-static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
+/* Read all of the TPM 1.2 PCRs */
+static int tpm_pcr_read(struct tpm_bank_info *tpm_banks, int len)
 {
 	FILE *fp;
 	char *p, pcr_str[7], buf[70]; /* length of the TPM string */
 	int result = -1;
-
-	sprintf(pcr_str, "PCR-%2.2d", idx);
+	int i = 0;
 
 	fp = fopen(pcrs, "r");
 	if (!fp)
@@ -1385,11 +1393,10 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 		p = fgets(buf, sizeof(buf), fp);
 		if (!p)
 			break;
-		if (!strncmp(p, pcr_str, 6)) {
-			hex2bin(pcr, p + 7, len);
-			result = 0;
-			break;
-		}
+		sprintf(pcr_str, "PCR-%2.2d", i);
+		if (!strncmp(p, pcr_str, 6))
+			hex2bin(tpm_banks[0].pcr[i++], p + 7, len);
+		result = 0;
 	}
 	fclose(fp);
 	return result;
@@ -1571,14 +1578,6 @@ void ima_ng_show(struct template_entry *entry)
 	}
 }
 
-struct tpm_bank_info {
-	int digest_size;
-	int supported;
-	const char *algo_name;
-	uint8_t digest[MAX_DIGEST_SIZE];
-	uint8_t pcr[NUM_PCRS][MAX_DIGEST_SIZE];
-};
-
 static void set_bank_info(struct tpm_bank_info *bank, const char *algo_name)
 {
 	const EVP_MD *md;
@@ -1771,11 +1770,9 @@ static int read_tpm_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 {
 	int i;
 
-	for (i = 0; i < NUM_PCRS; i++) {
-		if (tpm_pcr_read(i, tpm_banks[0].pcr[i], SHA_DIGEST_LENGTH)) {
-			log_debug("Failed to read TPM 1.2 PCRs.\n");
-			return -1;
-		}
+	if (tpm_pcr_read(tpm_banks, SHA_DIGEST_LENGTH)) {
+		log_debug("Failed to read TPM 1.2 PCRs.\n");
+		return -1;
 	}
 
 	tpm_banks[0].supported = 1;
-- 
2.7.5

