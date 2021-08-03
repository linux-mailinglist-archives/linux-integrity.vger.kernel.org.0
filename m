Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0F3DF680
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 22:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhHCUky (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 16:40:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229551AbhHCUky (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 16:40:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173Kb6PI161737
        for <linux-integrity@vger.kernel.org>; Tue, 3 Aug 2021 16:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Xa+MeCwjlYyLI+r+laok5Ia6yEXcL2rZViKH+UF1O5E=;
 b=SU04HRS+CJABduSJS/+CbZnKUbBdXoZTYQ0qr1iGOi3SYFMXMxRLkGm5wD4dmbACwaH6
 S5txRtcMcV2hHzYxM/Ry5xuLGRpeLkOfx+1Q/MpGRF2/pf2A99QDHx+R3XtnlIgRhBzD
 SvopNumokpSMqmZ9KPrylRUXRwYT+6Jsmr7XCh1005KMX3ipTtNoYpO3mHhltF3fzdXT
 dwnwSmBSrZuqFQrtU1av0tK7xBAewhxB6Eegu9mObXxCmadVzlGPb7adg93kbQMfer6n
 3o4tnIioxaXB2uSEE70dU5naRUJcg2OCp1ci+eGHiu4EDXj+Zys5wTAht5kldO9A3FMe Jg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a7232kpvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Aug 2021 16:40:41 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173Kcm8t019185
        for <linux-integrity@vger.kernel.org>; Tue, 3 Aug 2021 20:40:41 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3a4x5d05gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Aug 2021 20:40:41 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173Kee6G19398924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 20:40:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57F62B2064;
        Tue,  3 Aug 2021 20:40:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFE98B2068;
        Tue,  3 Aug 2021 20:40:38 +0000 (GMT)
Received: from eve.home (unknown [9.211.130.149])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 20:40:38 +0000 (GMT)
From:   Ken Goldman <kgoldman@us.ibm.com>
To:     zohar@linux.ibm.com, maroon@lists.linux.ibm.com,
        linux-integrity@vger.kernel.org
Cc:     kgold@linux.ibm.com, Ken Goldman <kgoldman@us.ibm.com>
Subject: [PATCH v5 ima-evm-utils 2/3] Change PCR iterator from int to uint32_t
Date:   Tue,  3 Aug 2021 16:40:07 -0400
Message-Id: <20210803204008.29612-3-kgoldman@us.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803204008.29612-1-kgoldman@us.ibm.com>
References: <20210803204008.29612-1-kgoldman@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3neNZ9gpIvPN6rFh3f_5q_UfOG12-HZY
X-Proofpoint-ORIG-GUID: 3neNZ9gpIvPN6rFh3f_5q_UfOG12-HZY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0
 mlxlogscore=708 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PCR numbers are naturally unsigned values.  Further, they are
32 bits, even on 64-bit machines. This change eliminates the
need for negative value and overflow tests.

The parameter name is changed from j and idx to pcr_handle, which is
more descriptive and is similar to the parameter name used in the TPM
2.0 specification.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
 src/evmctl.c         | 12 ++++++++----
 src/pcr.h            |  2 +-
 src/pcr_tss.c        |  5 +++--
 src/pcr_tsspcrread.c |  6 +++---
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index a8065bb..c999589 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1914,7 +1914,8 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 {
 	int tpm_enabled = 0;
 	char *errmsg = NULL;
-	int i, j;
+	int i;
+	uint32_t pcr_handle;
 	int err;
 
 	/* If --pcrs was specified, read only from the specified file(s) */
@@ -1934,9 +1935,12 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	/* Read PCRs from multiple TPM 2.0 banks */
 	for (i = 0; i < num_banks; i++) {
 		err = 0;
-		for (j = 0; j < NUM_PCRS && !err; j++) {
-			err = tpm2_pcr_read(bank[i].algo_name, j,
-					    bank[i].pcr[j], bank[i].digest_size,
+		for (pcr_handle = 0;
+		     pcr_handle < NUM_PCRS && !err;
+		     pcr_handle++) {
+			err = tpm2_pcr_read(bank[i].algo_name, pcr_handle,
+					    bank[i].pcr[pcr_handle],
+					    bank[i].digest_size,
 					    &errmsg);
 			if (err) {
 				log_debug("Failed to read %s PCRs: (%s)\n",
diff --git a/src/pcr.h b/src/pcr.h
index 79547bd..205bae8 100644
--- a/src/pcr.h
+++ b/src/pcr.h
@@ -1,3 +1,3 @@
 int tpm2_pcr_supported(void);
-int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+int tpm2_pcr_read(const char *algo_name, uint32_t pcr_handle, uint8_t *hwpcr,
 		 int len, char **errmsg);
diff --git a/src/pcr_tss.c b/src/pcr_tss.c
index feb1ff7..10930e2 100644
--- a/src/pcr_tss.c
+++ b/src/pcr_tss.c
@@ -106,7 +106,7 @@ static TPM2_ALG_ID algo_to_tss2(const char *algo_name)
 	return TPM2_ALG_ERROR;
 }
 
-int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+int tpm2_pcr_read(const char *algo_name, uint32_t pcr_handle, uint8_t *hwpcr,
 		 int len, char **errmsg)
 {
 	TSS2_ABI_VERSION abi_version = {
@@ -140,7 +140,8 @@ int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
 		}
 	};
 
-	pcr_select_in.pcrSelections[0].pcrSelect[idx / 8] = (1 << (idx % 8));
+	pcr_select_in.pcrSelections[0].pcrSelect[pcr_handle / 8] =
+	    (1 << (pcr_handle % 8));
 
 	ret = Esys_Initialize(&ctx, NULL, &abi_version);
 	if (ret != TPM2_RC_SUCCESS) {
diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
index 183dfc2..95048f8 100644
--- a/src/pcr_tsspcrread.c
+++ b/src/pcr_tsspcrread.c
@@ -68,7 +68,7 @@ int tpm2_pcr_supported(void)
 	return 1;
 }
 
-int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+int tpm2_pcr_read(const char *algo_name, uint32_t pcr_handle, uint8_t *hwpcr,
 		 int len, char **errmsg)
 {
 	FILE *fp;
@@ -76,8 +76,8 @@ int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
 	char cmd[PATH_MAX + 50];
 	int ret;
 
-	sprintf(cmd, "%s -halg %s -ha %d -ns 2> /dev/null",
-		path, algo_name, idx);
+	sprintf(cmd, "%s -halg %s -ha %u -ns 2> /dev/null",
+		path, algo_name, pcr_handle);
 	fp = popen(cmd, "r");
 	if (!fp) {
 		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
-- 
2.25.1

