Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8D6833F9
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 18:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjAaReU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 12:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjAaReC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 12:34:02 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99DE539B1
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 09:33:59 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VG07Ub018578
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Ud7RImv6nGeEgaaIaebNkKEr5q/G7CGrPdK79lYS6f8=;
 b=Sn67NXZ25taPtinFeQUWd1ACCgiteKpqFzSyvJC2pIGrYfFQMYt1w6WvYbeSrxDWnjhK
 KZ5EgFqrKECZARubtiWJva7KOb6JQgalRj9srZ2TUutxLqVklXKYLMhpA/RmNOnN2ghO
 4Bb9OqhoMUlmtQOV2iVgGTq9znkMEugeq2iYPFjxztj4N06NZiBCiLIjBad7XYtshn79
 4UmMZBUCvD3jXyt/b/GXcGA0mMdOcgmFuOU0ADuu+5xiOR/fOhtfNHbsu57N6r+/R12K
 jnEAb2aVsm03REEr7KE1I7E/rua4aCmPi86VXXCYLDldPUQATTA6EcmNnQEgbRZ9nHa8 Vw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf519vmgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:33:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEGX5o013445
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:33:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtybsc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 17:33:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VHXrxo45613488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 17:33:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7504E20043;
        Tue, 31 Jan 2023 17:33:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36BBE2004B;
        Tue, 31 Jan 2023 17:33:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.77.155.214])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 17:33:51 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] Fix reading the TPM 2.0 PCRs
Date:   Tue, 31 Jan 2023 12:33:44 -0500
Message-Id: <20230131173344.8147-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n6tgLnGQajKn8pPP7Yzm04jSxj5BdmCi
X-Proofpoint-GUID: n6tgLnGQajKn8pPP7Yzm04jSxj5BdmCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prior to the support for reading the TPM 2.0 PCRs via the sysfs
interface, based on environment variables the userspace application read
either the physical or software TPM's PCRs.

With the support for reading the exported TPM 2.0 PCRs via the sysfs
interface, the physical TPM's PCRs are always read.  Define a new evmctl
option named '--hwtpm' to limit reading the TPM 2.0 PCRs via the sysfs
interface.

Fixes: a141bd594263 ("add support for reading per bank TPM 2.0 PCRs via sysfs")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c              | 9 +++++++--
 tests/boot_aggregate.test | 7 +++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 91b531c9e01e..95281df08051 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -139,6 +139,7 @@ static dev_t fs_dev;
 static bool evm_immutable;
 static bool evm_portable;
 static bool veritysig;
+static bool hwtpm;
 
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
@@ -2152,7 +2153,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	if (read_sysfs_pcrs(num_banks, bank) == 0)
 		return 0;
 
-	if (read_sysfs_tpm2_pcrs(num_banks, bank) == 0)
+	if (hwtpm && read_sysfs_tpm2_pcrs(num_banks, bank) == 0)
 		return 0;
 
 	/* Any userspace applications available for reading TPM 2.0 PCRs? */
@@ -2878,7 +2879,7 @@ struct command cmds[] = {
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
 	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] [--verify-bank hash-algorithm] file", "Verify measurement list (experimental).\n"},
-	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]", "Calculate per TPM bank boot_aggregate digests\n"},
+	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log] [--hwtpm]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
 	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass password]", "Sign hashes from either shaXsum or \"fsverity digest\" output.\n"},
@@ -2924,6 +2925,7 @@ static struct option opts[] = {
 	{"keyid", 1, 0, 144},
 	{"keyid-from-cert", 1, 0, 145},
 	{"veritysig", 0, 0, 146},
+	{"hwtpm", 0, 0, 147},
 	{}
 
 };
@@ -3166,6 +3168,9 @@ int main(int argc, char *argv[])
 		case 146:
 			veritysig = 1;
 			break;
+		case 147:
+			hwtpm = 1;
+			break;
 		case '?':
 			exit(1);
 			break;
diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index ca5faf9cd97d..b0b2db41f4c1 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -126,8 +126,10 @@ display_pcrs() {
 # Verify that the last "boot_aggregate" record in the IMA measurement
 # list matches.
 check() {
+	local options=$1
+
 	echo "INFO: Calculating the boot_aggregate (PCRs 0 - 9) for multiple banks"
-	bootaggr=$(evmctl ima_boot_aggregate)
+	bootaggr=$(evmctl ima_boot_aggregate ${options})
 	if [ $? -ne 0 ]; then
 		echo "${CYAN}SKIP: evmctl ima_boot_aggregate: $bootaggr${NORM}"
 		exit "$SKIP"
@@ -151,6 +153,7 @@ check() {
 }
 
 if [ "$(id -u)" = 0 ] && [ -c "/dev/tpm0" ]; then
+	BOOTAGGR_OPTIONS="--hwtpm"
 	ASCII_RUNTIME_MEASUREMENTS="/sys/kernel/security/ima/ascii_runtime_measurements"
 	if [ ! -d "/sys/kernel/security/ima" ]; then
 		echo "${CYAN}SKIP: CONFIG_IMA not enabled${NORM}"
@@ -194,4 +197,4 @@ if [ "$(id -u)" != 0 ] || [ ! -c "/dev/tpm0" ]; then
 	fi
 fi
 
-expect_pass check
+expect_pass check $BOOTAGGR_OPTIONS
-- 
2.31.1

