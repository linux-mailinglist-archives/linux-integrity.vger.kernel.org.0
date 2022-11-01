Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3666152FF
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKAUS0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKAUSY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB4F6373
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:23 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1IL633031881;
        Tue, 1 Nov 2022 20:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3AWH/kyBDXen+GMgwU+7BI8VCESrxppP/nM6OzO0Zdg=;
 b=VPBOGMLabCiRQFyIk85qXVG/s1vS4RFx+lZIuRp6gSvHL3Jc4wAUG9z8EDzQzn3ExPVA
 jUFZ7kgeF19gKBRIFodd0W4nJ7NBDseiS0nUnlHEsZczlfAS5SDJ5spvQntiznetRQfR
 b1K74QlXa9kyx2y2Dgn6n0kHbVXDulNGR023afoZdXpZA8N7DC2zHLqz3W1i27/5TwN1
 E+QjZODLugHuB6++3nlQhUtmzmd6wHS5az6TgmcNbKxoYd0VDGoXJJJ2jWz30czIE0qt
 5HJr5kDj8rC+K740lmxl6FMg190WPFCuY2rln+D6txBTr9Fmy8biyA8BBa5eWARYS/bc VQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjw7ubj18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:19 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K5cXv020222;
        Tue, 1 Nov 2022 20:18:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3kgut8kw7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KIEAu1573532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95BDBA4054;
        Tue,  1 Nov 2022 20:18:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C27C3A405B;
        Tue,  1 Nov 2022 20:18:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:13 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 07/17] Replace the low level SHA1 calls when calculating the TPM 1.2 PCRs
Date:   Tue,  1 Nov 2022 16:17:53 -0400
Message-Id: <20221101201803.372652-8-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2mcStGUhV_P8KQvqtIepRU7lmmBnz2Mm
X-Proofpoint-GUID: 2mcStGUhV_P8KQvqtIepRU7lmmBnz2Mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 src/evmctl.c | 78 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 15 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 158c1f9bf7a1..808f7d43bd18 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2293,6 +2293,11 @@ static int cmd_ima_measurement(struct command *cmd)
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
@@ -2305,17 +2310,22 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
 
-	if (stat(file, &s) == -1) {
-		errno = 0;
+	if (stat(file, &s) == -1)
 		return 1;
-	}
 
 	if (!S_ISREG(s.st_mode)) {
 		log_info("Bios event log: not a regular file or link to regular file\n");
@@ -2323,13 +2333,27 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 	}
 
 	fp = fopen(file, "r");
-	if (!fp) {
-		log_errno("Failed to open TPM 1.2 event log.\n");
+	if (!fp)
 		return 1;
-	}
 
 	if (imaevm_params.verbose > LOG_INFO)
-		log_info("Reading the TPM 1.2 event log %s.\n", file);
+		log_info("Reading the TPM 1.2 event log (%s)\n", file);
+
+	md = EVP_get_digestbyname(bank->algo_name);
+	if (!md) {
+		log_err("Unknown message digest %s\n", bank->algo_name);
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
 
 	/* Extend the pseudo TPM PCRs with the event digest */
 	while (fread(&event, sizeof(event.header), 1, fp) == 1) {
@@ -2339,13 +2363,30 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2354,10 +2395,17 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2481,8 +2529,8 @@ static int cmd_ima_bootaggr(struct command *cmd)
 
 		err = read_binary_bios_measurements(file, tpm_banks);
 		if (err) {
-			log_info("Failed reading the TPM 1.2 event log %s.\n",
-				 file);
+			log_err("Failed reading the TPM 1.2 event log (%s)\n",
+				file);
 			return -1;
 		}
 	} else {
-- 
2.31.1

