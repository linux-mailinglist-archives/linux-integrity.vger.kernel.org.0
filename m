Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8037234789
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 16:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgGaOPE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 10:15:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728997AbgGaOPE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 10:15:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VE2ZHX071694;
        Fri, 31 Jul 2020 10:15:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mkr7aauc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 10:15:00 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VE2bPw071759;
        Fri, 31 Jul 2020 10:14:59 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mkr7aatr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 10:14:59 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VE7DlX027608;
        Fri, 31 Jul 2020 14:14:57 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 32gcqgqb4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:14:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VEEtli52756964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 14:14:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A5904204B;
        Fri, 31 Jul 2020 14:14:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC9184203F;
        Fri, 31 Jul 2020 14:14:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.38.42])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jul 2020 14:14:53 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [ima-evm-utils: PATCH 2/3] Rename "--validate" to "--ignore-violations"
Date:   Fri, 31 Jul 2020 10:14:31 -0400
Message-Id: <20200731141432.668318-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731141432.668318-1-zohar@linux.ibm.com>
References: <20200731141432.668318-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310101
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA records file "Time of Measure, Time of Use (ToMToU)" and "open
writers" integrity violations by adding a record to the measurement
list containing one value (0x00's), but extending the TPM with a
different value (0xFF's).

To avoid known file integrity violations, the builtin "tcb" measurement
policy should be replaced with a custom policy as early as possible.
This patch renames the existing "--validate" option to
"--ignore-violations".

Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 README       |  4 ++--
 src/evmctl.c | 13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/README b/README
index d8b8f404534b..b37325f31802 100644
--- a/README
+++ b/README
@@ -31,7 +31,7 @@ COMMANDS
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
- ima_measurement [--validate] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
+ ima_measurement [--ignore-violations] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
  ima_fix [-t fdsxm] path
  sign_hash [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
@@ -60,7 +60,7 @@ OPTIONS
       --m64          force EVM hmac/signature for 64 bit target system
       --engine e     preload OpenSSL engine e (such as: gost)
       --pcrs         file containing TPM pcrs, one per hash-algorithm/bank
-      --validate     ignore ToMToU measurement violations
+      --ignore-violations ignore ToMToU measurement violations
       --verify-sig   verify the file signature based on the file hash, both
                      stored in the template data.
   -v                 increase verbosity level
diff --git a/src/evmctl.c b/src/evmctl.c
index b4d2333fb880..7ad11507487f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1392,7 +1392,7 @@ struct template_entry {
 
 static uint8_t zero[MAX_DIGEST_SIZE];
 
-static int validate = 0;
+static int ignore_violations = 0;
 
 static int ima_verify_template_hash(struct template_entry *entry)
 {
@@ -1739,7 +1739,7 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
 		 * size.
 		 */
 		if (memcmp(entry->header.digest, zero, SHA_DIGEST_LENGTH) == 0) {
-			if (!validate) {
+			if (!ignore_violations) {
 				memset(bank[i].digest, 0x00, bank[i].digest_size);
 				memset(padded_bank[i].digest, 0x00, padded_bank[i].digest_size);
 			} else {
@@ -2467,6 +2467,7 @@ static void usage(void)
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --verify-sig   verify measurement list signatures\n"
 		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
+		"      --ignore-violations ignore ToMToU measurement violations"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n");
@@ -2483,7 +2484,7 @@ struct command cmds[] = {
 	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
-	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
+	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
@@ -2522,7 +2523,7 @@ static struct option opts[] = {
 	{"verify-sig", 0, 0, 138},
 	{"engine", 1, 0, 139},
 	{"xattr-user", 0, 0, 140},
-	{"validate", 0, 0, 141},
+	{"ignore-violations", 0, 0, 141},
 	{"pcrs", 1, 0, 142},
 	{}
 
@@ -2702,8 +2703,8 @@ int main(int argc, char *argv[])
 			xattr_ima = "user.ima";
 			xattr_evm = "user.evm";
 			break;
-		case 141: /* --validate */
-			validate = 1;
+		case 141: /* --ignore-violations */
+			ignore_violations = 1;
 			break;
 		case 142:
 			if (npcrfile >= MAX_PCRFILE) {
-- 
2.18.4

