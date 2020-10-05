Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8924228427D
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 00:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgJEW1X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 18:27:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727155AbgJEW1X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 18:27:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095M2I0f157331
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 18:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=wS2ZtYUP1Xck2Gsf1iNYRa89qdCDFKwQ+cW/INvn940=;
 b=OzWzI1ONSY8hZJjLnB2x8CTcUdAqlM0/0WuNGKbfc+Cxz+jYLQ3EMmwYzrB3aBFsmg5I
 LzNH+yJ1cqeM0PmHbTyK0ESYwBdfXEhDzIy+RwDlqqUNmqoy/dtvK1jdBTd4nZh720dK
 o8VPcPJImBp+UHLBC05VG9D2WN/qegeFH3IG4AVFJGz6a0KdgBS+O5GOhFbVsy2JVf/X
 fZrvi3JqPMTqRaFK99iZiE/5Ki60u4FbbZJM9A7ReMvvFWzXBq79+Yl15SPNDXL139ge
 mDH+m7Q9rlyb+9tZGwGVlumY6tBgqcnh9F1nkjW/wjkFA+aqqyqqGSfmy6od1re1+0es Zg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 340a4sbkfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2020 18:27:22 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095M7MI1013503
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 22:27:21 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 33xgx97kf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Oct 2020 22:27:21 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095MRFYr36831726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Mon, 5 Oct 2020 22:27:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13548C6057
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:27:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3BE7C6059
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:27:19 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Mon,  5 Oct 2020 22:27:19 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 2/6] ima-evm-utils: Change PCR iterater from int to uint32_t
Message-ID: <8877d400-7888-bc64-6ceb-b2f611419e1d@linux.ibm.com>
Date:   Mon, 5 Oct 2020 18:27:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_16:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=698 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050153
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PCR numbers are naturally unsigned values.  Further, they are
32 bits, even on 64-bit machines. This change eliminates the
need for negative value and overflow tests.

The parameter name is changed from j and idx to pcrHandle,
which is more descriptive and is the parameter name used in
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

