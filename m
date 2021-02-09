Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3339231542A
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhBIQnH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 11:43:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233034AbhBIQmI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 11:42:08 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119Ga0OL043188
        for <linux-integrity@vger.kernel.org>; Tue, 9 Feb 2021 11:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=48jmY6Esvp0xwhpuftqZd0FynTwTUcVdcl5lIvMrdbg=;
 b=jQ/CWCet8GPgtEkqhflCBfBOwCY88b4/pwKEVkh0kEGubE9HpIRSfqL9rr8gv+/pN6y5
 yBpSlNbZ+VNv1vSKQ8J/eNIiTeswxGeL/zey/5FAjqTu5Ash0IHAoBm80bWCR8qUo57n
 gcNZ2Qjnw9j1iXMRP3qz+rJckf18bxIhSBm8/ejuIvx4ESu+oxOIQ+1Q+fu6I3OXTIKA
 otP5B4asYwKfC/zEC2vuu68S2qm4rIDVVqFRF7joiMoM1C3kae3EqVNItAe6+mMlkn3F
 1R9onLmGu8t3+P+yd1v4BfT5ubEzO0TVMNfzZbNuyic5R6oeiYDzCWqQ9YUxPRvBo/PY FA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kw4tanfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Feb 2021 11:41:27 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119GbCHf003598
        for <linux-integrity@vger.kernel.org>; Tue, 9 Feb 2021 16:41:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 36hjr89uqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 09 Feb 2021 16:41:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119GfMWu40436200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 16:41:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 666214C040;
        Tue,  9 Feb 2021 16:41:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F9B14C044;
        Tue,  9 Feb 2021 16:41:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.79.210])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 16:41:21 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils][PATCH] Limit comparing the calculated PCR value to just a single bank
Date:   Tue,  9 Feb 2021 11:41:16 -0500
Message-Id: <20210209164116.152447-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM 2.0 banks may be extended either with a padded SHA1 hash or more
recently with a per TPM bank calculated hash.  If the measurement list
is carried across kexec, the original kernel might extend the TPM
differently than the new kernel.

Support for verifying a mixed IMA measurement list is not supported.  To
permit verifying just the SHA1 bank, specify "--verify-bank=sha1" on the
command line.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index f7ffe388ef4f..051c218cc8b5 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -125,6 +125,7 @@ static char *caps_str;
 static char *ima_str;
 static char *selinux_str;
 static char *search_type;
+static char *verify_bank;
 static int verify_list_sig;
 static int recursive;
 static int msize;
@@ -2011,6 +2012,16 @@ static int ima_measurement(const char *file)
 	pseudo_banks_mask = (1 << num_banks) - 1;
 	pseudo_padded_banks_mask = pseudo_banks_mask;
 
+	/* Instead of verifying all the banks, only verify a single bank */
+	for (c = 0; c < num_banks; c++) {
+		if (verify_bank
+		    && strcmp(pseudo_padded_banks[c].algo_name, verify_bank)) {
+			pseudo_banks_mask ^= (1 << c);
+			pseudo_padded_banks_mask ^= (1 << c);
+			break;
+		}
+	}
+
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
 		entry_num++;
 		if (entry.header.name_len > TCG_EVENT_NAME_LEN_MAX) {
@@ -2537,7 +2548,7 @@ struct command cmds[] = {
 	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
-	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
+	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] [--verify-bank hash-algorithm] file", "Verify measurement list (experimental).\n"},
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
@@ -2578,6 +2589,7 @@ static struct option opts[] = {
 	{"xattr-user", 0, 0, 140},
 	{"ignore-violations", 0, 0, 141},
 	{"pcrs", 1, 0, 142},
+	{"verify-bank", 2, 0, 143},
 	{}
 
 };
@@ -2766,6 +2778,9 @@ int main(int argc, char *argv[])
 			}
 			pcrfile[npcrfile++] = optarg;
 			break;
+		case 143:
+			verify_bank = optarg;
+			break;
 		case '?':
 			exit(1);
 			break;
-- 
2.27.0

