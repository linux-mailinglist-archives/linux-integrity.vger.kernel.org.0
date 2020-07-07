Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766742163FD
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgGGC0w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:26:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbgGGC0v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:26:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06723jv6104351;
        Mon, 6 Jul 2020 22:26:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324864can5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:26:47 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0672Lote164312;
        Mon, 6 Jul 2020 22:26:46 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324864camn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:26:45 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672QTJW025220;
        Tue, 7 Jul 2020 02:26:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 322hd82wru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:26:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672QfMn7930292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:26:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 288B74C046;
        Tue,  7 Jul 2020 02:26:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CF8E4C040;
        Tue,  7 Jul 2020 02:26:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:26:40 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH 4/6] ima-evm-utils: calculate and verify the template data digest
Date:   Mon,  6 Jul 2020 22:26:29 -0400
Message-Id: <1594088791-27370-5-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
References: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 cotscore=-2147483648 mlxscore=0 suspectscore=1 bulkscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007070014
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Validating a TPM quote of PCR-10, the default IMA PCR, requires not only
sending the quote to the verifier, but the IMA measurement list as well.
The attestation server can verify the IMA measurement list simply by
walking the measurement list and re-calculating the PCRs based on the
template data digest.  In addition, the attestation server could verify
the template data digest based on the template data.

The LTP and standalone "ima_measure" test optionally verify the template
data digest.  Similarly add "--verify" support to conditionally verify
the template data digest against the template data.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3c4483ef2b0e..eda7dd845930 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1413,6 +1413,7 @@ static uint8_t zero[MAX_DIGEST_SIZE];
 static uint8_t fox[MAX_DIGEST_SIZE];
 
 static int validate = 0;
+static int verify = 0;
 
 static int ima_verify_template_hash(struct template_entry *entry)
 {
@@ -1875,7 +1876,7 @@ static int ima_measurement(const char *file)
 
 		extend_tpm_banks(&entry, num_banks, pseudo_banks);
 
-		if (validate)
+		if (verify)
 			ima_verify_template_hash(&entry);
 
 		if (!strcmp(entry.name, "ima"))
@@ -2156,7 +2157,7 @@ struct command cmds[] = {
 	{"ima_verify", cmd_verify_ima, 0, "file", "Verify IMA signature (for debugging).\n"},
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
-	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] file", "Verify measurement list (experimental).\n"},
+	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] file", "Verify measurement list (experimental).\n"},
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
@@ -2196,6 +2197,7 @@ static struct option opts[] = {
 	{"engine", 1, 0, 139},
 	{"xattr-user", 0, 0, 140},
 	{"validate", 0, 0, 141},
+	{"verify", 0, 0, 142},
 	{}
 
 };
@@ -2377,6 +2379,9 @@ int main(int argc, char *argv[])
 		case 141: /* --validate */
 			validate = 1;
 			break;
+		case 142: /* --verify */
+			verify = 1;
+			break;
 		case '?':
 			exit(1);
 			break;
-- 
2.7.5

