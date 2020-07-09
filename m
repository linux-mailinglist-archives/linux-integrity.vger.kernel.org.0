Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A07321A23F
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGIOg4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 10:36:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgGIOg4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 10:36:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069EWbvp029313;
        Thu, 9 Jul 2020 10:36:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32637wc4sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 10:36:54 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 069EWdXT029426;
        Thu, 9 Jul 2020 10:36:53 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32637wc4r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 10:36:53 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069EWbco029964;
        Thu, 9 Jul 2020 14:36:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 325k2qrfs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 14:36:51 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 069EanQu66191798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 14:36:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04219A405B;
        Thu,  9 Jul 2020 14:36:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51E21A4054;
        Thu,  9 Jul 2020 14:36:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.231.222])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jul 2020 14:36:48 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 3/3] ima-evm-utils: support providing the TPM 1.2 PCRs as a file
Date:   Thu,  9 Jul 2020 10:36:36 -0400
Message-Id: <1594305396-21280-4-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594305396-21280-1-git-send-email-zohar@linux.ibm.com>
References: <1594305396-21280-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_08:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=1 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007090104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

"evmctl ima_measurement" walks the IMA measurement list calculating the
PCRs and verifies the calculated values against the system's PCRs.
Instead of reading the system's PCRs, provide the PCRs as a file.  For
TPM 1.2 the PCRs are exported via a securityfs file.

Verifying the IMA measurement list against the exported TPM 1.2 PCRs
file may be used remotely for regression testing.  If used in a
production environment, the provided TPM PCRs must be compared with
those included in the TPM 1.2 quote as well.

This patch defines an evmctl ima_measurement "--pcrs <filename>" option.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 814aa6b75571..21ae1c7ca5a7 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -160,6 +160,8 @@ struct tpm_bank_info {
 	uint8_t pcr[NUM_PCRS][MAX_DIGEST_SIZE];
 };
 
+static char *pcrfile;
+
 static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
 {
 	FILE *fp;
@@ -1377,12 +1379,18 @@ static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
 /* Read all of the TPM 1.2 PCRs */
 static int tpm_pcr_read(struct tpm_bank_info *tpm_banks, int len)
 {
-	FILE *fp;
+	FILE *fp = NULL;
 	char *p, pcr_str[7], buf[70]; /* length of the TPM string */
 	int result = -1;
 	int i = 0;
 
-	fp = fopen(pcrs, "r");
+	/* Use the provided TPM 1.2 pcrs file */
+	if (pcrfile)
+		fp = fopen(pcrfile, "r");
+
+	if (!fp)
+		fp = fopen(pcrs, "r");
+
 	if (!fp)
 		fp = fopen(misc_pcrs, "r");
 
@@ -2347,7 +2355,7 @@ struct command cmds[] = {
 	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
-	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] file", "Verify measurement list (experimental).\n"},
+	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] [--pcrs file] file", "Verify measurement list (experimental).\n"},
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
@@ -2388,6 +2396,7 @@ static struct option opts[] = {
 	{"xattr-user", 0, 0, 140},
 	{"validate", 0, 0, 141},
 	{"verify", 0, 0, 142},
+	{"pcrs", 1, 0, 143},
 	{}
 
 };
@@ -2572,6 +2581,9 @@ int main(int argc, char *argv[])
 		case 142: /* --verify */
 			verify = 1;
 			break;
+		case 143:
+			pcrfile = optarg;
+			break;
 		case '?':
 			exit(1);
 			break;
-- 
2.7.5

