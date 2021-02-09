Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE27314EDC
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 13:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBIMWO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 07:22:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229558AbhBIMWM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 07:22:12 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119C1CI5111983;
        Tue, 9 Feb 2021 07:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9yi7Ze6MIUHSALhzhRtn1ExXA8XiiqLaqOn0ofMUnFc=;
 b=Cqbs6d7RMEAVOS4M7Rfgd/nSjDilbHz6QEquVfUknBwDCNbHZi52uwisSJZI9fWE9fnM
 qjwXffNXA/v5/mypNcat+aSPLzadPfFGnafmUA2oLDYuKnxjDTOWlPxkaVa2Cmt0ql7m
 C1Cl8MqECyIbjK/yN37pVvv/0qrf5qSvaGlm+JM3+TnQojhDAEPWwDreRfkqZce5wDWm
 fY4n1FViUyLV/VDpZPwQy7u5MYzijz9hMP5yS111noY4xD5FQlNtd49EHcMReSAfy/QC
 VQJDU88Rqp+QARL9CmvIJWIxMUY8MIM6bg4Uw4lLWPXR1ifyC3ptsIjmQ7rbokSbQgtX vA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ksr995t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 07:21:23 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119BwYnX022254;
        Tue, 9 Feb 2021 12:21:22 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 36hjr93vm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 12:21:22 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119CLL9X36831622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 12:21:21 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94BCF124055;
        Tue,  9 Feb 2021 12:21:21 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BC3A124053;
        Tue,  9 Feb 2021 12:21:21 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 12:21:21 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2] ima-evm-utils: Improve ima_measurement matching on busy system with >1 banks
Date:   Tue,  9 Feb 2021 07:21:06 -0500
Message-Id: <20210209122106.870973-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090061
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When a system is very busy with IMA taking measurements into more than
one bank, then we often do not get the PCR 10 values of the sha1 bank
that represents the same log entry as the reading of the PCR value of
the sha256 bank. In other words, the reading of the PCR 10 value from
the sha1 bank may represent the PCR 10 state at the time of the
n-th entry in the log while the reading of the PCR 10 value from the
sha256 bank may represent the state at the time of a later-than-n entry.
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

$ evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/binary_runtime_measurements -v
sha1: PCRAgg  10: 381cc6139e2fbda76037ec0946089aeccaaa5374
sha1: TPM PCR-10: 381cc6139e2fbda76037ec0946089aeccaaa5374
sha1 PCR-10: succeed at entry 4918
sha1: PCRAgg  10: 381cc6139e2fbda76037ec0946089aeccaaa5374
sha1: TPM PCR-10: 381cc6139e2fbda76037ec0946089aeccaaa5374
sha1 PCR-10: succeed at entry 4918
[...]
sha256: PCRAgg  10: c21dcb7098b3d7627f7aaeddf8aff68a65209027274d82af52be2fd302193eb7
sha256: TPM PCR-10: c21dcb7098b3d7627f7aaeddf8aff68a65209027274d82af52be2fd302193eb7
sha256 PCR-10: succeed at entry 4922
Matched per TPM bank calculated digest(s).

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
v1->v2:
 - Reporting entry number that resulted in a match when in verbose mode

---
 src/evmctl.c | 57 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1815f55..f18eaae 100644
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
+			     unsigned int banks_mask, unsigned long entry_num)
 {
 	int i, j;
 	int ret = 0;
@@ -1605,6 +1610,9 @@ static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
 	for (i = 0; i < num_banks; i++) {
 		if (!bank[i].supported || !tpm_bank[i].supported)
 			continue;
+		/* do we need to look at the n-th bank ? */
+		if ((banks_mask & (1 << i)) == 0)
+			continue;
 		for (j = 0; j < NUM_PCRS; j++) {
 			if (memcmp(bank[i].pcr[j], zero, bank[i].digest_size)
 			    == 0)
@@ -1625,8 +1633,8 @@ static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
 			log_dump(tpm_bank[i].pcr[j], tpm_bank[i].digest_size);
 
 			if (!ret)
-				log_info("%s PCR-%d: succeed\n",
-					 bank[i].algo_name, j);
+				log_info("%s PCR-%d: succeed at entry %lu\n",
+					 bank[i].algo_name, j, entry_num);
 			else
 				log_info("%s: PCRAgg %d does not match TPM PCR-%d\n",
 					 bank[i].algo_name, j, j);
@@ -1941,6 +1949,9 @@ static int ima_measurement(const char *file)
 	int num_banks = 0;
 	int tpmbanks = 1;
 	int first_record = 1;
+	unsigned int pseudo_padded_banks_mask, pseudo_banks_mask;
+	unsigned long entry_num = 0;
+	int c;
 
 	struct template_entry entry = { .template = 0 };
 	FILE *fp;
@@ -1974,7 +1985,12 @@ static int ima_measurement(const char *file)
 	if (read_tpm_banks(num_banks, tpm_banks) != 0)
 		tpmbanks = 0;
 
+	/* A mask where each bit represents the banks to check against */
+	pseudo_banks_mask = (1 << num_banks) - 1;
+	pseudo_padded_banks_mask = pseudo_banks_mask;
+
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
+		entry_num++;
 		if (entry.header.name_len > TCG_EVENT_NAME_LEN_MAX) {
 			log_err("%d ERROR: event name too long!\n",
 				entry.header.name_len);
@@ -2086,18 +2102,33 @@ static int ima_measurement(const char *file)
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
+						tpm_banks, 1 << c, entry_num);
+			if (!err)
+				pseudo_banks_mask ^= (1 << c);
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
+						       1 << c, entry_num);
+			if (!err_padded)
+				pseudo_padded_banks_mask ^= (1 << c);
+		}
+		if (pseudo_padded_banks_mask == 0)
 			break;
 	}
 
-- 
2.29.2

