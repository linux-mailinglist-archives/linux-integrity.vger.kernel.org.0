Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138791F9EEC
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgFOR6x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 13:58:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728585AbgFOR6u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 13:58:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FHoTnD071497;
        Mon, 15 Jun 2020 13:58:47 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31n0mmu5yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 13:58:47 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FHu84K024963;
        Mon, 15 Jun 2020 17:58:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 31mpe7hmgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 17:58:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05FHvPBU51708248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 17:57:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7728AE053;
        Mon, 15 Jun 2020 17:58:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CC27AE045;
        Mon, 15 Jun 2020 17:58:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.11])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jun 2020 17:58:42 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Subject: [PATCH] ima_evm_utils: emit the per TPM PCR bank "boot_aggregate" values
Date:   Mon, 15 Jun 2020 13:58:39 -0400
Message-Id: <1592243919-29915-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_07:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 cotscore=-2147483648 suspectscore=3 clxscore=1015 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150131
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of emitting the per TPM PCR bank "boot_aggregate" values one
at a time, store them in a buffer and emit them all at once.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 675980823636..1d065ceed886 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1937,11 +1937,36 @@ static void calc_bootaggr(struct tpm_bank_info *bank)
 	}
 
 out:
-	printf("%s:", bank->algo_name);
-	imaevm_hexdump(bank->digest, bank->digest_size);
 #if OPENSSL_VERSION_NUMBER >= 0x10100000
 	EVP_MD_CTX_free(pctx);
 #endif
+
+}
+
+/*
+ * The "boot_aggregate" format is the TPM PCR bank algorithm, a colon
+ * separator, followed by a per bank TPM PCR bank specific digest.
+ * Store the TPM PCR bank specific "boot_aggregate" value as a newline
+ * terminated string in the provided buffer.
+ */
+static int append_bootaggr(char *bootaggr, struct tpm_bank_info *tpm_banks)
+{
+	uint8_t *buf;
+	int j;
+
+	strcpy(bootaggr, tpm_banks->algo_name);
+	j = strlen(tpm_banks->algo_name);
+	bootaggr[j++] = ':';
+
+	for (buf = tpm_banks->digest;
+	     buf < (tpm_banks->digest + tpm_banks->digest_size);
+	     buf++) {
+		bootaggr[j++] = hex_asc_hi(*buf);
+		bootaggr[j++] = hex_asc_lo(*buf);
+	}
+
+	bootaggr[j++] = '\n';
+	return j;
 }
 
 /*
@@ -1953,7 +1978,10 @@ out:
 static int cmd_ima_bootaggr(struct command *cmd)
 {
 	struct tpm_bank_info *tpm_banks;
+	int bootaggr_len = 0;
+	char *bootaggr;
 	int num_banks = 0;
+	int offset = 0;
 	int i;
 
 	tpm_banks = init_tpm_banks(&num_banks);
@@ -1963,11 +1991,34 @@ static int cmd_ima_bootaggr(struct command *cmd)
 		return -1;
 	}
 
+	/*
+	 * Allocate enough memory for the per TPM 2.0 PCR bank algorithm,
+	 * the colon separator, the boot_aggregate digest and newline.
+	 *
+	 * Format: <hash algorithm name>:<boot_aggregate digest>\n ...
+	 */
+	for (i = 0; i < num_banks; i++) {
+		if (!tpm_banks[i].supported)
+			continue;
+		bootaggr_len += strlen(tpm_banks[i].algo_name) + 1;
+		bootaggr_len += (tpm_banks[i].digest_size * 2) + 1;
+	}
+	bootaggr = malloc(bootaggr_len);
+
+	/*
+	 * Calculate and convert the per TPM 2.0 PCR bank algorithm
+	 * "boot_aggregate" digest from binary to asciihex.  Store the
+	 * "boot_aggregate" values as a list of newline terminated
+	 * strings.
+	 */
 	for (i = 0; i < num_banks; i++) {
 		if (!tpm_banks[i].supported)
 			continue;
 		calc_bootaggr(&tpm_banks[i]);
+		offset += append_bootaggr(bootaggr + offset, tpm_banks + i);
 	}
+	printf("%s", bootaggr);
+	free(bootaggr);
 	return 0;
 }
 
-- 
2.7.5

