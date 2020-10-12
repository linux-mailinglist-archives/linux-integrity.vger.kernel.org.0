Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FB128C55A
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 01:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgJLXoa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Oct 2020 19:44:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729993AbgJLXoa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Oct 2020 19:44:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CNhXR1083784
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L3TDXvrJf3m/VsVBVClyqsMoMPUFvFRo9mIjq4WiHVE=;
 b=TROITHgQhbvudeWQPOYZt4H3untVS/qZCLIZcCBaDnURtiW172qsSTH2G9tcJG0HMzR+
 u9IazjAXiMCktsYkeeHiuOtiXUaSu4jVX9VsQ0SGC6EoiOPE3ld5Bttoc/zBw1Y8BggR
 Yz++w2iMY4KrH4nY9fUtp92+OyUwII/a+wwr45zZBOUCOvxUbY4QzpXzp1PurfBsHgyD
 aZhrTt604nC2SJdcnZv2Yic5vHLqhHpNPmSd+9s3Bw67ZWxAGpU7y6lZRB86RfBUWp/t
 B1Mca6lk/nDTARjVSINtPlE/X+vcTUxahk62zZ4WZN0p1eMuvfG9PgFL+cx9REABnAz9 4g== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34512m8096-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 19:44:30 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CNfo59011009
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:29 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3434k980q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2020 23:44:29 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CNiSb751249570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 23:44:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43DC1B2064;
        Mon, 12 Oct 2020 23:44:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39B52B205F;
        Mon, 12 Oct 2020 23:44:27 +0000 (GMT)
Received: from eve.home (unknown [9.85.142.21])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 23:44:27 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v2 2/5] ima-evm-utils: Change PCR iterater from int to uint32_t
Date:   Mon, 12 Oct 2020 19:44:13 -0400
Message-Id: <20201012234416.20995-3-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201012234416.20995-1-kgoldman@us.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=743 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120171
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PCR numbers are naturally unsigned values.  Further, they are
32 bits, even on 64-bit machines. This change eliminates the
need for negative value and overflow tests.

The parameter name is changed from j and idx to pcrHandle,
which is more decriptive and is the parameter name used in
the TPM 2.0 specification.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
 src/evmctl.c         | 9 +++++----
 src/pcr.h            | 2 +-
 src/pcr_tss.c        | 4 ++--
 src/pcr_tsspcrread.c | 4 ++--
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1815f55..b056a1e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1895,7 +1895,8 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 {
 	int tpm_enabled = 0;
 	char *errmsg = NULL;
-	int i, j;
+	int i;
+	uint32_t pcrHandle;
 	int err;
 
 	/* If --pcrs was specified, read only from the specified file(s) */
@@ -1915,9 +1916,9 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	/* Read PCRs from multiple TPM 2.0 banks */
 	for (i = 0; i < num_banks; i++) {
 		err = 0;
-		for (j = 0; j < NUM_PCRS && !err; j++) {
-			err = tpm2_pcr_read(bank[i].algo_name, j,
-					    bank[i].pcr[j], bank[i].digest_size,
+		for (pcrHandle = 0; pcrHandle < NUM_PCRS && !err; pcrHandle++) {
+			err = tpm2_pcr_read(bank[i].algo_name, pcrHandle,
+					    bank[i].pcr[pcrHandle], bank[i].digest_size,
 					    &errmsg);
 			if (err) {
 				log_debug("Failed to read %s PCRs: (%s)\n",
diff --git a/src/pcr.h b/src/pcr.h
index 79547bd..dd8311a 100644
--- a/src/pcr.h
+++ b/src/pcr.h
@@ -1,3 +1,3 @@
 int tpm2_pcr_supported(void);
-int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+int tpm2_pcr_read(const char *algo_name, uint32_t pcrHandle, uint8_t *hwpcr,
 		 int len, char **errmsg);
diff --git a/src/pcr_tss.c b/src/pcr_tss.c
index feb1ff7..5e00524 100644
--- a/src/pcr_tss.c
+++ b/src/pcr_tss.c
@@ -106,7 +106,7 @@ static TPM2_ALG_ID algo_to_tss2(const char *algo_name)
 	return TPM2_ALG_ERROR;
 }
 
-int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+int tpm2_pcr_read(const char *algo_name, uint32_t pcrHandle, uint8_t *hwpcr,
 		 int len, char **errmsg)
 {
 	TSS2_ABI_VERSION abi_version = {
@@ -140,7 +140,7 @@ int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
 		}
 	};
 
-	pcr_select_in.pcrSelections[0].pcrSelect[idx / 8] = (1 << (idx % 8));
+	pcr_select_in.pcrSelections[0].pcrSelect[pcrHandle / 8] = (1 << (pcrHandle % 8));
 
 	ret = Esys_Initialize(&ctx, NULL, &abi_version);
 	if (ret != TPM2_RC_SUCCESS) {
diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
index 462f270..118c7d2 100644
--- a/src/pcr_tsspcrread.c
+++ b/src/pcr_tsspcrread.c
@@ -68,7 +68,7 @@ int tpm2_pcr_supported(void)
 	return 1;
 }
 
-int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+int tpm2_pcr_read(const char *algo_name, uint32_t pcrHandle, uint8_t *hwpcr,
 		 int len, char **errmsg)
 {
 	FILE *fp;
@@ -77,7 +77,7 @@ int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
 	int ret;
 
 	sprintf(cmd, "%s -halg %s -ha %d -ns 2> /dev/null",
-		path, algo_name, idx);
+		path, algo_name, pcrHandle);
 	fp = popen(cmd, "r");
 	if (!fp) {
 		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
-- 
2.25.1

