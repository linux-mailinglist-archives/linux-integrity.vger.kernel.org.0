Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627845AF4E7
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiIFTzM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiIFTxH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:53:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7FCAA37F
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:50:50 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IxVdJ018079;
        Tue, 6 Sep 2022 19:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Y9Rld75iQekuvLUzD1vgMip7BMykrnSVA//hIUurg5k=;
 b=D/JH8PdRoJaPpiscoe/tz6Ofe+d30ws22rB2vnwYXTVCtcuwDKaPJnV6hsoWXwCUXrxH
 DBSDXqRis3eY7FwU+35sr3CT3s0lfuLKSiRU9KuuYRg7HVNrhayZARMqp0Q+diOWaS1I
 iQkgdfe3rkVDv7Gd2Yen7ayypy1d7aF5pla1/Tvi1pef/ShtBVV/4jvAqZZ6h3lU00tx
 WiNnsJrwPQH3MJ3caLclTC5HAEYMVBVykZLQrADDBGRpTIno4HLDvDkpTpm7yDL/9ciU
 NqGaAJFaaLoo5sXnVV0JgEXW6qfaT9fx2fK9JKaLNg5AeaHSHr1POg26ye1eCdf6yaCC vg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jebyk1d7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:45 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JoND6006486;
        Tue, 6 Sep 2022 19:50:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3jbxj8v6g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286JoeCW42271164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:50:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42ACC11C04C;
        Tue,  6 Sep 2022 19:50:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D200C11C04A;
        Tue,  6 Sep 2022 19:50:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:38 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 05/12] Replace the low level SHA1 calls when calculating the TPM 1.2 PCRs
Date:   Tue,  6 Sep 2022 15:50:14 -0400
Message-Id: <20220906195021.854090-6-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906195021.854090-1-zohar@linux.ibm.com>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b-3uB670o-DFnFB5FKqfzKvyyYHPbEpM
X-Proofpoint-ORIG-GUID: b-3uB670o-DFnFB5FKqfzKvyyYHPbEpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060090
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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

