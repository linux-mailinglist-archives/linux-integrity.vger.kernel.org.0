Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902DD6187B6
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKCSjb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKCSj3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7A2638
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:29 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3IDjnt012938;
        Thu, 3 Nov 2022 18:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2lks0BnQgohoUaJq+G7PgwAF8lcM/g9KviusbcUfL6Y=;
 b=UdHmNwsAT0wzZN541q1h2FHP+mGQUs3Z7Dpy9P1NJY6yChcOJ+9gJMyxpi5GLNILQsfU
 8Q+m4f91yiH/GwXyrrB2893BY6W48nWMvSMGpUQL2KccZYVbVgq/zORFg7KJmjIMfDBm
 MBUsFyqBuVNUWqXxRLUAAcibjFELZLOcvV11lw8hBwkHDxzO28yvXwshNcf+YOWQ9hR8
 j+DILeVQID/tdHc9QkLWbf1LlNyDWHvn+cDQ/3k3IZVLOv7acGMasS07/AYID31+zYAu
 aPg+0FwwtfaMkFXsz96wdKwoJxzlc1bjb7JqGJIaV1CG/pK68W1IF7A8MKJeW108m5zG aw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kme16ctkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:24 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3Ia9BE030432;
        Thu, 3 Nov 2022 18:39:22 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3kgut8pvwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3Idtro47841736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:39:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49A194203F;
        Thu,  3 Nov 2022 18:39:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E1E642042;
        Thu,  3 Nov 2022 18:39:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:18 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 07/17] Replace the low level SHA1 calls when calculating the TPM 1.2 PCRs
Date:   Thu,  3 Nov 2022 14:38:54 -0400
Message-Id: <20221103183904.103562-8-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BP_k68KT4k8xTenJOemV4jrriMvCDlXm
X-Proofpoint-ORIG-GUID: BP_k68KT4k8xTenJOemV4jrriMvCDlXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030125
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
index b2560aae0905..35842b72a494 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2298,6 +2298,11 @@ static int cmd_ima_measurement(struct command *cmd)
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
@@ -2310,17 +2315,22 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2328,13 +2338,27 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2344,13 +2368,30 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2359,10 +2400,17 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
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
@@ -2486,8 +2534,8 @@ static int cmd_ima_bootaggr(struct command *cmd)
 
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

