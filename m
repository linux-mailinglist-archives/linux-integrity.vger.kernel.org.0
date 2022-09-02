Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3570D5AB68B
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Sep 2022 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiIBQ3O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiIBQ3N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 12:29:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C5D9D61
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 09:29:05 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282GGKZa005743;
        Fri, 2 Sep 2022 16:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aC5jSjS3TermB7ZlLZSKn86p5sCBXEW6/NSGcDZgwAQ=;
 b=iRn2vIH1YsQWFOKHIglkJOXCutcV1XEej101KPKTjuXl6hyKMkxtLWyQNOAn0RLO4++K
 CyjGlzcYrPSi7hCRkUO8WAYMRpoIi2MDAlkb1V4MXQwuoEi5Ljg0H+wI2x+PV60dWy+X
 A+IPXfhd0mAZvRFRnezh5178w7xtA2r7Zvy1ch30hKqY9kc15GET+1pqZxfuiCmNhKZS
 JUlx4u91RIxFlCnAbqqaUgx4r/6sXMX2ThV0ZLEOlID9mlWibC7oisXaGaUgF0l/sowR
 66VuZ5ETnkiqUdblxPe8tr+QkDJVQMyDGFPBGemhE7BuEyNAnWUGB0MlRZCvr4gSmhGa ow== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbn730apj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:29:00 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282G8Bl2019937;
        Fri, 2 Sep 2022 16:28:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3j7aw8x5d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:28:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282GSs1o38535504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 16:28:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94FA252050;
        Fri,  2 Sep 2022 16:28:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.132.193])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 68CE85204E;
        Fri,  2 Sep 2022 16:28:53 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 05/11] Replace the low level SHA1 calls when calculating the TPM 1.2 PCRs
Date:   Fri,  2 Sep 2022 12:28:30 -0400
Message-Id: <20220902162836.554839-6-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902162836.554839-1-zohar@linux.ibm.com>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1990rCNoOOZmz0xfkRmCZntK5Y2N8osY
X-Proofpoint-ORIG-GUID: 1990rCNoOOZmz0xfkRmCZntK5Y2N8osY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209020078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

OpenSSL v3 emits deprecated warnings for SHA1 functions.  Use the
EVP_ functions when walking the TPM 1.2 binary bios measurements
to calculate the TPM 1.2 PCRs.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 13b0105af8c4..641504047a36 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2295,6 +2295,11 @@ static int cmd_ima_measurement(struct command *cmd)
 	return ima_measurement(file);
 }
 
+/*
+ * read_binary_bios_measurements - read the TPM 1.2 event log
+ *
+ * Returns 0 on success, 1 on failure.
+ */
 #define MAX_EVENT_DATA_SIZE 200000
 static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 {
@@ -2307,12 +2312,19 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 		} header;
 		unsigned char data[MAX_EVENT_DATA_SIZE];
 	} event;
+	EVP_MD_CTX *mdctx;
+	const EVP_MD *md;
+	unsigned int mdlen;
+	int evp_err = 1;	/* success */
 	struct stat s;
 	FILE *fp;
-	SHA_CTX c;
 	int err = 0;
 	int len;
 	int i;
+#if OPENSSL_VERSION_NUMBER < 0x10100000
+	EVP_MD_CTX ctx;
+	mdctx = &ctx;
+#endif
 
 	if (stat(file, &s) == -1) {
 		errno = 0;
@@ -2334,6 +2346,23 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 	if (imaevm_params.verbose > LOG_INFO)
 		log_info("Reading the TPM 1.2 event log %s.\n", file);
 
+	md = EVP_get_digestbyname(bank->algo_name);
+	if (!md) {
+		log_errno("Unknown message digest %s\n", bank->algo_name);
+		errno = 0;
+		fclose(fp);
+		return 1;
+	}
+
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	mdctx = EVP_MD_CTX_new();
+	if (!mdctx) {
+		log_err("EVP_MD_CTX_new failed\n");
+		fclose(fp);
+		return 1;
+	}
+#endif
+
 	/* Extend the pseudo TPM PCRs with the event digest */
 	while (fread(&event, sizeof(event.header), 1, fp) == 1) {
 		if (imaevm_params.verbose > LOG_INFO) {
@@ -2342,13 +2371,30 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 		}
 		if (event.header.pcr >= NUM_PCRS) {
 			log_err("Invalid PCR %d.\n", event.header.pcr);
-			err = 1;
 			break;
 		}
-		SHA1_Init(&c);
-		SHA1_Update(&c, bank->pcr[event.header.pcr], 20);
-		SHA1_Update(&c, event.header.digest, 20);
-		SHA1_Final(bank->pcr[event.header.pcr], &c);
+
+		evp_err = EVP_DigestInit(mdctx, md);
+		if (evp_err == 0) {
+			log_err("EVP_DigestInit() failed\n");
+			break;
+		}
+
+		evp_err = EVP_DigestUpdate(mdctx, bank->pcr[event.header.pcr], 20);
+		if (evp_err == 0) {
+			log_err("EVP_DigestUpdate() failed\n");
+			break;
+		}
+		evp_err = EVP_DigestUpdate(mdctx, event.header.digest, 20);
+		if (evp_err == 0) {
+			log_err("EVP_DigestUpdate() failed\n");
+			break;
+		}
+		evp_err = EVP_DigestFinal(mdctx, bank->pcr[event.header.pcr], &mdlen);
+		if (evp_err == 0) {
+			log_err("EVP_DigestFinal() failed\n");
+			break;
+		}
 		if (event.header.len > MAX_EVENT_DATA_SIZE) {
 			log_err("Event data event too long.\n");
 			err = 1;
@@ -2357,10 +2403,17 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 		len = fread(event.data, event.header.len, 1, fp);
 		if (len != 1) {
 			log_errno("Failed reading event data (short read)\n");
+			err = 1;
 			break;
 		}
 	}
+
+	if (evp_err == 0) /* EVP_ functions return 1 on success, 0 on failure */
+		err = 1;
 	fclose(fp);
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	EVP_MD_CTX_free(mdctx);
+#endif
 
 	if (imaevm_params.verbose <= LOG_INFO)
 		return err;
-- 
2.31.1

