Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7B21BA54
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGJQIA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:08:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5168 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbgGJQIA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:08:00 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AG7QY2180906;
        Fri, 10 Jul 2020 12:07:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326b8yg8uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:07:57 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFaQXl098907;
        Fri, 10 Jul 2020 12:02:58 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326b8yg86k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:02:56 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AG1D99030445;
        Fri, 10 Jul 2020 16:02:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 326bcf0sha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:02:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AG1BqG28049610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:01:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 041614204D;
        Fri, 10 Jul 2020 16:01:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71CB042049;
        Fri, 10 Jul 2020 16:01:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:10 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 7/8] ima-evm-utils: optionally verify the template data file signature
Date:   Fri, 10 Jul 2020 12:00:58 -0400
Message-Id: <1594396859-9232-8-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_13:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=1
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007100109
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rename "--list" to "verify-sig" to optionally verify the file signature
contained in the template data based on the supplied set of keys.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 README       |  3 ++-
 src/evmctl.c | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 3603ae8a6084..374b748c59bf 100644
--- a/README
+++ b/README
@@ -31,7 +31,7 @@ COMMANDS
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
- ima_measurement [--key "key1, key2, ..."] [--list] file
+ ima_measurement [--verify-sig [--key "key1, key2, ..."]] file
  ima_fix [-t fdsxm] path
  sign_hash [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
@@ -59,6 +59,7 @@ OPTIONS
       --m32          force EVM hmac/signature for 32 bit target system
       --m64          force EVM hmac/signature for 64 bit target system
       --engine e     preload OpenSSL engine e (such as: gost)
+      --verify-sig   verify the template data file signature
   -v                 increase verbosity level
   -h, --help         display this help and exit
 
diff --git a/src/evmctl.c b/src/evmctl.c
index 88fd8e4c31f0..90a3eebc4431 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -125,7 +125,7 @@ static char *caps_str;
 static char *ima_str;
 static char *selinux_str;
 static char *search_type;
-static int measurement_list;
+static int verify_list_sig;
 static int recursive;
 static int msize;
 static dev_t fs_dev;
@@ -1566,7 +1566,7 @@ void ima_ng_show(struct template_entry *entry)
 			log_info(" ");
 			log_dump(sig, sig_len);
 		}
-		if (measurement_list)
+		if (verify_list_sig)
 			err = ima_verify_signature(path, sig, sig_len,
 						   digest, digest_len);
 		else
@@ -2367,7 +2367,7 @@ static void usage(void)
 		"      --ima          use custom IMA signature for EVM\n"
 		"      --selinux      use custom Selinux label for EVM\n"
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
-		"      --list         measurement list verification\n"
+		"      --verify-sig   verify measurement list signatures\n"
 		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
@@ -2385,7 +2385,7 @@ struct command cmds[] = {
 	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
-	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] [--pcrs file] file", "Verify measurement list (experimental).\n"},
+	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] [--verify-sig [--key key1, key2, ...]] [--pcrs file] file", "Verify measurement list (experimental).\n"},
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
@@ -2421,7 +2421,7 @@ static struct option opts[] = {
 	{"ima", 1, 0, 135},
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
-	{"list", 0, 0, 138},
+	{"verify-sig", 0, 0, 138},
 	{"engine", 1, 0, 139},
 	{"xattr-user", 0, 0, 140},
 	{"validate", 0, 0, 141},
@@ -2586,7 +2586,7 @@ int main(int argc, char *argv[])
 			hmac_flags |= HMAC_FLAG_CAPS_SET;
 			break;
 		case 138:
-			measurement_list = 1;
+			verify_list_sig = 1;
 			break;
 		case 139: /* --engine e */
 			eng = ENGINE_by_id(optarg);
-- 
2.7.5

