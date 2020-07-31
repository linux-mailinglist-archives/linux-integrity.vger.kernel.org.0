Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D0023478B
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgGaOPG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 10:15:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728997AbgGaOPF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 10:15:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VE2pmG127583;
        Fri, 31 Jul 2020 10:15:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mg7b01wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 10:15:01 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VE44Cr132684;
        Fri, 31 Jul 2020 10:15:01 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mg7b01t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 10:15:01 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VE9TO6013654;
        Fri, 31 Jul 2020 14:14:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 32gcpwcgmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:14:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VEDUCg57016796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 14:13:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3910F4203F;
        Fri, 31 Jul 2020 14:14:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D02E42049;
        Fri, 31 Jul 2020 14:14:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.38.42])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jul 2020 14:14:55 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [ima-evm-utils: PATCH 3/3] Update the ima_boot_aggregate apsects of the "README" and "help" files
Date:   Fri, 31 Jul 2020 10:14:32 -0400
Message-Id: <20200731141432.668318-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731141432.668318-1-zohar@linux.ibm.com>
References: <20200731141432.668318-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add the missing "evmctl ima_boot_aggregate" info to the README.  Update
the "help" to include the new "--pcrs" option.  In addition, replace
the "file" option with "TPM 1.2 BIOS event log".  The new format is:

ima_boot_aggregate [--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]

Reminder: calculating the TPM PCRs based on the BIOS event log and
comparing them with the TPM PCRs should be done prior to calculating the
possible boot_aggregate value(s).

For TPM 1.2, the TPM 1.2 BIOS event log may be provided as an option
when calculating the ima_boot_aggregate.  For TPM 2.0, "tsseventextend
-sim -if <binary_bios_measurements> -ns -v", may be used to validate
the TPM 2.0 event log.

(Note: some TPM 2.0's export the BIOS event log in the TPM 1.2 format.)

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 README       | 1 +
 src/evmctl.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/README b/README
index b37325f31802..321045d9d52b 100644
--- a/README
+++ b/README
@@ -28,6 +28,7 @@ COMMANDS
  import [--rsa] pubkey keyring
  sign [-r] [--imahash | --imasig ] [--portable] [--key key] [--pass password] file
  verify file
+ ima_boot_aggregate [--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]
  ima_sign [--sigfile] [--key key] [--pass password] file
  ima_verify file
  ima_hash file
diff --git a/src/evmctl.c b/src/evmctl.c
index 7ad11507487f..de7299d41b2c 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2485,7 +2485,7 @@ struct command cmds[] = {
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
 	{"ima_measurement", cmd_ima_measurement, 0, "[--ignore-violations] [--verify-sig [--key key1, key2, ...]] [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file", "Verify measurement list (experimental).\n"},
-	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
+	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
 	{"sign_hash", cmd_sign_hash, 0, "[--key key] [--pass [password]", "Sign hashes from shaXsum output.\n"},
-- 
2.18.4

