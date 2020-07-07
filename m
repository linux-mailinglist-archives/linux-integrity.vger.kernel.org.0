Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4BC216402
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGGC1f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:27:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54370 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgGGC1f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:27:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06722KmM151246;
        Mon, 6 Jul 2020 22:27:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324bfgeftu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:27:33 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06729WKK179491;
        Mon, 6 Jul 2020 22:27:32 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324bfgeftb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:27:32 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672Qqu0001612;
        Tue, 7 Jul 2020 02:27:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 322hd7tvk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:27:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672RSCo51445844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:27:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD730A4059;
        Tue,  7 Jul 2020 02:27:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B554A4057;
        Tue,  7 Jul 2020 02:27:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:27:27 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 2/3] ima-evm-utils: read the TPM 1.2 binary_bios_measurements
Date:   Mon,  6 Jul 2020 22:27:16 -0400
Message-Id: <1594088837-27526-3-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594088837-27526-1-git-send-email-zohar@linux.ibm.com>
References: <1594088837-27526-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 cotscore=-2147483648 suspectscore=1 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of just calculating the "boot_aggregate" based on the current
TPM PCRs, the original LTP and standalone ima_boot_aggregate test walked
the TPM 1.2 event log, calculating the PCRs.

If the TPM 1.2 event log is provided as an option on the "evmctl
ima_boot_aggregate" command, read the event log, calculate the sha1
PCRs, and calculate the "boot_aggregate" based on these PCRs.

The code for walking the IMA measurement list is based on the LTP and
standalone ima_boot_aggregate tests.  Similar support for reading the
TPM 2.0 event log to calculate the PCRs requires the TPM 2.0 event log
to be exported or a TSS to read the event log.  Parsing the TPM 2.0
event log is not supported here.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index b157c452839b..9ee440f6a50a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1963,6 +1963,67 @@ static int cmd_ima_measurement(struct command *cmd)
 	return ima_measurement(file);
 }
 
+#define MAX_EVENT_DATA_SIZE 200000
+static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
+{
+	struct {
+		struct {
+			uint32_t pcr;
+			int type;
+			unsigned char digest[SHA_DIGEST_LENGTH];
+			uint32_t len;
+		} header;
+		unsigned char data[MAX_EVENT_DATA_SIZE];
+	} event;
+	FILE *fp;
+	SHA_CTX c;
+	int err = 0;
+	int i;
+
+	fp = fopen(file, "r");
+	if (!fp) {
+		log_errno("Failed to open TPM 1.2 event log.\n");
+		return 1;
+	}
+
+	if (imaevm_params.verbose > LOG_INFO)
+		log_info("Reading the TPM 1.2 event log %s.\n", file);
+
+	/* Extend the pseudo TPM PCRs with the event digest */
+	while (fread(&event, sizeof(event.header), 1, fp)) {
+		if (imaevm_params.verbose > LOG_INFO) {
+			log_info("%02u ", event.header.pcr);
+			log_dump(event.header.digest, SHA_DIGEST_LENGTH);
+		}
+		if (event.header.pcr > NUM_PCRS) {
+			log_err("Invalid PCR %d.\n", event.header.pcr);
+			err = 1;
+			break;
+		}
+		SHA1_Init(&c);
+		SHA1_Update(&c, bank->pcr[event.header.pcr], 20);
+		SHA1_Update(&c, event.header.digest, 20);
+		SHA1_Final(bank->pcr[event.header.pcr], &c);
+		if (event.header.len > MAX_EVENT_DATA_SIZE) {
+			log_err("Event data event too long.\n");
+			err = 1;
+			break;
+		}
+		fread(event.data, event.header.len, 1, fp);
+	}
+	fclose(fp);
+
+	if (imaevm_params.verbose <= LOG_INFO)
+		return err;
+
+	for (i = 0; i < NUM_PCRS; i++) {
+		log_info("PCR-%2.2x ", i);
+		log_dump(bank->pcr[i], SHA_DIGEST_LENGTH);
+
+	}
+	return err;
+}
+
 static void calc_bootaggr(struct tpm_bank_info *bank)
 {
 	EVP_MD_CTX *pctx;
@@ -2056,13 +2117,34 @@ static int cmd_ima_bootaggr(struct command *cmd)
 	char *bootaggr;
 	int num_banks = 0;
 	int offset = 0;
+	int err = 0;
 	int i;
 
-	tpm_banks = init_tpm_banks(&num_banks);
+	char *file = g_argv[optind++];
 
-	if (read_tpm_banks(num_banks, tpm_banks) != 0) {
-		log_info("Failed to read any TPM PCRs\n");
-		return -1;
+	/*
+	 * Instead of just reading the TPM 1.2 PCRs, walk the exported
+	 * TPM 1.2 SHA1 event log, calculating the PCRs.
+	 */
+	if (file) {
+		tpm_banks = init_tpm_banks(&num_banks);
+
+		/* TPM 1.2 only supports SHA1.*/
+		for (i = 1; i < num_banks; i++)
+			tpm_banks[i].supported = 0;
+
+		err = read_binary_bios_measurements(file, tpm_banks);
+		if (err) {
+			log_info("Failed reading the TPM 1.2 event log %s.\n",
+				 file);
+			return -1;
+		}
+	} else {
+		tpm_banks = init_tpm_banks(&num_banks);
+		if (read_tpm_banks(num_banks, tpm_banks) != 0) {
+			log_info("Failed to read any TPM PCRs\n");
+			return -1;
+		}
 	}
 
 	/*
@@ -2211,7 +2293,7 @@ struct command cmds[] = {
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
 	{"ima_measurement", cmd_ima_measurement, 0, "[--validate] [--verify] file", "Verify measurement list (experimental).\n"},
-	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "", "Calculate per TPM bank boot_aggregate digests\n"},
+	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[file]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
 	{"sign_hash", cmd_sign_hash, 0, "[--key key] [--pass [password]", "Sign hashes from shaXsum output.\n"},
-- 
2.7.5

