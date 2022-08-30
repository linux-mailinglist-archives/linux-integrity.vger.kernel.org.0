Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF95A58AD
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 03:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH3BAJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 21:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiH3BAH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 21:00:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4906B2AC74
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 18:00:04 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0o6kZ020611;
        Tue, 30 Aug 2022 00:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d8KrJptHY3H/kikZKcZrFwwgcat/58SsH9Gd3YF2zH8=;
 b=mrs4IObBbjcL93tdPO+MNN8eYxOhobROy1nOfq7sgpQGBpE4K3jJR9dCmYvAuyZvk8iH
 DSWjLt3HcMQ7T3BWg7dhkrowsukQvsPY/9A36916++APF25NILEk9cm8n08+/nLVtkEN
 /lIgHFC7bgZsM/4f2cbGnoNyR9Y3OaQkCs7Rgymp+kusRoyfVx6kcCT4mguztQHd39fo
 2FuEKtccSKSfMKMHsFkoqnZ2Fl4tjg6YiFfdPOjY2QoFt6gAQy2VOkZt4e/m5B3iayvz
 UM52erP9Bng+YPPnBcrOTPvED8irXVI1myz9QMtGD05MK457YrQMIYqUjeZ1Eoh32lmw tA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j98bn8abn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 00:59:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U0pgAB027779;
        Tue, 30 Aug 2022 00:59:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3j7aw8txtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 00:59:57 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U0xst732571814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 00:59:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C74EA404D;
        Tue, 30 Aug 2022 00:59:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4358FA4040;
        Tue, 30 Aug 2022 00:59:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.117.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 00:59:53 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH ima-evm-utils 05/11] Replace the low level SHA1 calls when calculating the TPM 1.2 PCRs
Date:   Mon, 29 Aug 2022 20:59:30 -0400
Message-Id: <20220830005936.189922-6-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830005936.189922-1-zohar@linux.ibm.com>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4R8B3M6HwFkbsnRwVPmtyRM654hjaEUM
X-Proofpoint-GUID: 4R8B3M6HwFkbsnRwVPmtyRM654hjaEUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290107
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

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 621136b5b85f..6534950f3683 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2296,6 +2296,11 @@ static int cmd_ima_measurement(struct command *cmd)
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
@@ -2308,12 +2313,19 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2335,6 +2347,23 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2343,13 +2372,30 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2358,10 +2404,17 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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

