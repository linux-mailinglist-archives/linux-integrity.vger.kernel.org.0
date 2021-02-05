Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8472E310F9A
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 19:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhBEQ2k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 11:28:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233602AbhBEQ0F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 11:26:05 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 115I2t3h195926;
        Fri, 5 Feb 2021 13:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XuGkAeSFIed21LhreDtRggiHves309BF8OcSgh8DpmA=;
 b=mkxIll+GvtGy12tsSj3r16FCiwSaFwu+5psvfFmzujot8ncN15tQKh+oJMsDTmk8f8qc
 3MuUKPBbpv3YV+1/O6NYpW148RXFUKQD3vCtFEjYjU2Kkg3Bpcwm80TzHymfYzknNzwG
 7MkqP2Eq4/FvrjGp0OoIbV7v+FVB9ISr5KhZ3rSCOJq8rsWO9jGIAQivMNUb48D+O7uh
 FRmxH3KCn7XGQ6aIa5pg2yE/miNcpq3pUar6raNkXVF2AN4rP3iNV9vq/f1TxPNHIeB7
 4d3JO4zEFHGaub0RBsM8TWlkRtxf/nK/mH1UKR9OrXoky2HWK0owfrC7H1P2G+2AxuaA Fw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36hae5s6bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 13:07:44 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 115I6O84026222;
        Fri, 5 Feb 2021 18:07:43 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 36eu8re21y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 18:07:43 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 115I7frc28049794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Feb 2021 18:07:41 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 753FEBE053;
        Fri,  5 Feb 2021 18:07:41 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08A02BE04F;
        Fri,  5 Feb 2021 18:07:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Feb 2021 18:07:40 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] ima-evm-utils: Improve ima_measurement matching on busy system with >1 banks
Date:   Fri,  5 Feb 2021 13:07:39 -0500
Message-Id: <20210205180739.676410-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When a system is very busy with IMA taking measurements into more than
one bank, then we often do not get the PCR 10 values of the sha1 bank
that represents the same log entry as the reading of the PCR value of
the sha256 bank. In other words, the reading of the PCR 10 value from
the sha1 bank may represent the PCR 10 state at the time of the
n-th entry in the log while the reading of the PCR 10 value from the
sha256 bank may represent the state at the time of the (n+1)-th entry.
The result currently is that the PCR measurements do not match and
on a busy system the tool may not easily report a successful match.

This patch fixes this issue by separating the TPM bank comparison for
each one of the banks being looked and using a bit mask for checking
which banks have already been matched. Once the mask has become 0
all PCR banks have been successfully matched.

A run on a busy system may result in the output as follows indicating
PCR bank matches at the n-th entry for the sha1 bank and at a later
entry, possibly n + 1 or n + 2 or so, for the sha256 bank. The
output is interleaved with a match of the sha1 bank against 'padded
matching'.

$ evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/binary_runtime_measurements
Matched bank number 1.
Matched padded bank number 1.
Matched bank number 2.
Matched per TPM bank calculated digest(s).

An idle system may report this here, indicating matches at the n-th
entry.

$ evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/binary_runtime_measurements
Matched bank number 1.
Matched bank number 2.
Matched per TPM bank calculated digest(s).

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 55 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1815f55..67a2407 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1594,10 +1594,15 @@ static struct tpm_bank_info *init_tpm_banks(int *num_banks)
 
 /*
  * Compare the calculated TPM PCR banks against the PCR values read.
+ * The banks_mask parameter allows to select which banks to consider.
+ * A banks_maks of 0x3 would consider banks 1 and 2, 0x2 would only
+ * consider the 2nd bank, ~0 would consider all banks.
+ *
  * On failure to match any TPM bank, fail comparison.
  */
 static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
-			     struct tpm_bank_info *tpm_bank)
+			     struct tpm_bank_info *tpm_bank,
+			     unsigned int banks_mask)
 {
 	int i, j;
 	int ret = 0;
@@ -1605,6 +1610,9 @@ static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
 	for (i = 0; i < num_banks; i++) {
 		if (!bank[i].supported || !tpm_bank[i].supported)
 			continue;
+		if ((banks_mask & (1 << i)) == 0)
+			continue;
+		/* do we need to look at the n-th bank ? */
 		for (j = 0; j < NUM_PCRS; j++) {
 			if (memcmp(bank[i].pcr[j], zero, bank[i].digest_size)
 			    == 0)
@@ -1941,6 +1949,8 @@ static int ima_measurement(const char *file)
 	int num_banks = 0;
 	int tpmbanks = 1;
 	int first_record = 1;
+	unsigned int pseudo_padded_banks_mask, pseudo_banks_mask;
+	int c;
 
 	struct template_entry entry = { .template = 0 };
 	FILE *fp;
@@ -1974,6 +1984,10 @@ static int ima_measurement(const char *file)
 	if (read_tpm_banks(num_banks, tpm_banks) != 0)
 		tpmbanks = 0;
 
+	/* A mask where each bit represents the banks to check against */
+	pseudo_banks_mask = (1 << num_banks) - 1;
+	pseudo_padded_banks_mask = pseudo_banks_mask;
+
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
 		if (entry.header.name_len > TCG_EVENT_NAME_LEN_MAX) {
 			log_err("%d ERROR: event name too long!\n",
@@ -2086,18 +2100,37 @@ static int ima_measurement(const char *file)
 		if (!tpmbanks)
 			continue;
 
-		/* The measurement list might contain too many entries,
-		 * compare the re-calculated TPM PCR values after each
-		 * extend.
-		 */
-		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
-		if (!err)
+		for (c = 0; c < num_banks; c++) {
+			if ((pseudo_banks_mask & (1 << c)) == 0)
+				continue;
+			/* The measurement list might contain too many entries,
+			 * compare the re-calculated TPM PCR values after each
+			 * extend.
+			 */
+			err = compare_tpm_banks(num_banks, pseudo_banks,
+						tpm_banks, 1 << c);
+			if (!err) {
+				pseudo_banks_mask ^= (1 << c);
+				log_info("Matched bank number %u.\n", c + 1);
+			}
+		}
+		if (pseudo_banks_mask == 0)
 			break;
 
-		/* Compare against original SHA1 zero padded TPM PCR values */
-		err_padded = compare_tpm_banks(num_banks, pseudo_padded_banks,
-					       tpm_banks);
-		if (!err_padded)
+		for (c = 0; c < num_banks; c++) {
+			if ((pseudo_padded_banks_mask & (1 << c)) == 0)
+				continue;
+			/* Compare against original SHA1 zero padded TPM PCR values */
+			err_padded = compare_tpm_banks(num_banks,
+						       pseudo_padded_banks,
+						       tpm_banks,
+						       1 << c);
+			if (!err_padded) {
+				pseudo_padded_banks_mask ^= (1 << c);
+				log_info("Matched padded bank number %u.\n", c + 1);
+			}
+		}
+		if (pseudo_padded_banks_mask == 0)
 			break;
 	}
 
-- 
2.29.2

