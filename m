Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9D21BA2E
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGJQBQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:01:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbgGJQBQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AFWmTe156449;
        Fri, 10 Jul 2020 12:01:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk8uq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:13 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFjQ4q013009;
        Fri, 10 Jul 2020 12:01:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk8una-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AG0S7p003359;
        Fri, 10 Jul 2020 16:01:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 326bc30rk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:01:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AG18hW65077392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:01:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E834142047;
        Fri, 10 Jul 2020 16:01:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 461ED4203F;
        Fri, 10 Jul 2020 16:01:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:07 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 3/8] ima-evm-utils: support providing the TPM 1.2 PCRs as a file
Date:   Fri, 10 Jul 2020 12:00:54 -0400
Message-Id: <1594396859-9232-4-git-send-email-zohar@linux.ibm.com>
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

