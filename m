Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232DB21A23C
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 16:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGIOgy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 10:36:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726410AbgGIOgy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 10:36:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069EXgPd094461;
        Thu, 9 Jul 2020 10:36:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 325ktsvu2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 10:36:51 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 069EYVRu098613;
        Thu, 9 Jul 2020 10:36:51 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 325ktsvu1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 10:36:51 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069EUttc003540;
        Thu, 9 Jul 2020 14:36:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 325mr2ry2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 14:36:49 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 069EalT5590124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 14:36:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44B82A405F;
        Thu,  9 Jul 2020 14:36:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 916A7A4054;
        Thu,  9 Jul 2020 14:36:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.231.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jul 2020 14:36:46 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 1/3] ima-evm-utils: improve reading TPM 1.2 PCRs
Date:   Thu,  9 Jul 2020 10:36:34 -0400
Message-Id: <1594305396-21280-2-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594305396-21280-1-git-send-email-zohar@linux.ibm.com>
References: <1594305396-21280-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_08:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=1
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090104
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

