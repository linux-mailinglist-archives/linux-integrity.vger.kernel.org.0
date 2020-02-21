Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F491686CA
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 19:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgBUSjT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 13:39:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728442AbgBUSjT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 13:39:19 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LIKGI0142204
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:18 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yafh946c2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:18 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Feb 2020 18:39:16 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 18:39:13 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LIdCl656426580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 18:39:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49FE0AE04D;
        Fri, 21 Feb 2020 18:39:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 437C6AE045;
        Fri, 21 Feb 2020 18:39:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 18:39:11 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 5/8] ima-evm-utils: read the PCRs for the requested TPM banks
Date:   Fri, 21 Feb 2020 13:38:55 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022118-0028-0000-0000-000003DCCA85
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-0029-0000-0000-000024A1DABC
Message-Id: <1582310338-1562-6-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=3 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Read and store the PCRs for the requested banks to compare with the
re-calculated PCR values.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1eeab1d8268b..3e512cf4e3d2 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1423,6 +1423,7 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 }
 
 #ifdef HAVE_TSSPCRREAD
+static int tpm2_pcrread = 1;
 static int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
 			 int len, char **errmsg)
 {
@@ -1464,6 +1465,13 @@ static int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
 
 	return ret;
 }
+#else
+static int tpm2_pcrread = 0;
+static int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+			 int len, char **errmsg)
+{
+	return -1;
+}
 #endif
 
 #define TCG_EVENT_NAME_LEN_MAX	255
@@ -1804,9 +1812,47 @@ static void extend_tpm_banks(struct template_entry *entry, int num_banks,
 #endif
 }
 
+/*
+ * Attempt to read TPM PCRs from the multiple TPM 2.0 banks.
+ *
+ * On success reading from any TPM bank, return 0.
+ */
+static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
+{
+	int tpm_enabled = 0;
+	char *errmsg = NULL;
+	int i, j;
+	int err;
+
+	/* Any userspace applications available for reading TPM 2.0 PCRs? */
+	if (!tpm2_pcrread) {
+		log_info("Failed to read TPM 2.0 PCRs\n");
+		return 1;
+	}
+
+	for (i = 0; i < num_banks; i++) {
+		err = 0;
+		for (j = 0; j < NUM_PCRS && !err; j++) {
+			err = tpm2_pcr_read(bank[i].algo_name, j,
+					    bank[i].pcr[j], bank[i].digest_size,
+					    &errmsg);
+			if (err) {
+				log_info("Failed to read %s PCRs: (%s)\n",
+					 bank[i].algo_name, errmsg);
+				free(errmsg);
+				bank[i].supported = 0;
+			}
+		}
+		if (bank[i].supported)
+			tpm_enabled = 1;
+	}
+	return tpm_enabled ? 0 : 1;
+}
+
 static int ima_measurement(const char *file)
 {
 	struct tpm_bank_info *pseudo_banks;
+	struct tpm_bank_info *tpm_banks;
 	int num_banks = 0;
 
 	uint8_t pcr[NUM_PCRS][SHA_DIGEST_LENGTH] = {{0}};
@@ -1825,6 +1871,7 @@ static int ima_measurement(const char *file)
 	log_debug_dump(pcr, sizeof(pcr));
 
 	pseudo_banks = init_tpm_banks(&num_banks);
+	tpm_banks = init_tpm_banks(&num_banks);
 
 	fp = fopen(file, "rb");
 	if (!fp) {
@@ -1912,6 +1959,9 @@ static int ima_measurement(const char *file)
 
 	if (!verify_failed)
 		err = 0;
+	else
+		read_tpm_banks(num_banks, tpm_banks);
+
 out:
 	fclose(fp);
 	return err;
-- 
2.7.5

