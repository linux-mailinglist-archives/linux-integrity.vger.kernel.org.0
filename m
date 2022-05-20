Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81D52F03A
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351443AbiETQLh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351551AbiETQLS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 12:11:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C0A165B0
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 09:11:18 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KFpAnf017368;
        Fri, 20 May 2022 16:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=v8Ae+RkMxkLpDKMCL1vCQylns6uxzM2Rnn9XUNfqVxk=;
 b=OpHVJcu0ewm+4bq+n2MXEMTOZbjf/fW77CS7pMK53kDtpDg9Ocof5O59xkdsCoI5zqUZ
 qKWK6PINGDSqW3jrum39+jH1Ev/Q7w6jhHJpySuJlFjMI3R3Gk5JeweIfhs3NgYIQWWN
 8HNMqouPfuAlH4F3CT3BPyIRDT8KwiJ4MRyaPCOur57cAQCFMSbiVQESP5kXJvLmUWFr
 BSc8oCrr++7b2gD4VK6AVH5xYezA5y9CJC+NUwrkr4ijoh+QlAEqkUHDqP5TjFC+CyPt
 2L0exj4XEqzFE+KRbTC6+5KG5SrLIN+lOaSnGWzDRt04PN0M1jqqOSGCoRaGuY7pKw3v 4w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6dyygcmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:11:15 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KFrBE7016023;
        Fri, 20 May 2022 16:11:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjh3pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:11:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KGBAoi15729062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 16:11:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 641145204E;
        Fri, 20 May 2022 16:11:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.82.251])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C278652052;
        Fri, 20 May 2022 16:11:09 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 1/3] Reset 'errno' after failure to open or access a file
Date:   Fri, 20 May 2022 12:11:01 -0400
Message-Id: <20220520161103.373554-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220520161103.373554-1-zohar@linux.ibm.com>
References: <20220520161103.373554-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uToSZT-rDcrHJSh-raT3fyNjVEOfBlnf
X-Proofpoint-ORIG-GUID: uToSZT-rDcrHJSh-raT3fyNjVEOfBlnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_04,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Not being able to open a file is not necessarily a problem. If
and when it occurs, an informational or error message with the
actual filename is emitted as needed.

Reset 'errno' to prevent the "errno: No such file or directory (2)"
generic message.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c    | 16 ++++++++++++++--
 src/libimaevm.c |  4 ++++
 src/utils.c     |  5 ++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 8bdd34817408..101cd407e05d 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -181,6 +181,7 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
 	fp = fopen(name, "w");
 	if (!fp) {
 		log_err("Failed to open: %s\n", name);
+		errno = 0;
 		return -1;
 	}
 	err = fwrite(data, len, 1, fp);
@@ -206,6 +207,7 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 	fp = fopen(name, "r");
 	if (!fp) {
 		log_err("Failed to open: %s\n", name);
+		errno = 0;
 		return NULL;
 	}
 	if (fstat(fileno(fp), &stats) == -1) {
@@ -312,8 +314,10 @@ static int get_uuid(struct stat *st, char *uuid)
 	sprintf(path, "blkid -s UUID -o value /dev/block/%u:%u", major, minor);
 
 	fp = popen(path, "r");
-	if (!fp)
+	if (!fp) {
+		errno = 0;
 		goto err;
+	}
 
 	len = fread(_uuid, 1, sizeof(_uuid), fp);
 	pclose(fp);
@@ -370,6 +374,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 
 			if (fd < 0) {
 				log_err("Failed to open: %s\n", file);
+				errno = 0;
 				return -1;
 			}
 			if (ioctl(fd, FS_IOC_GETVERSION, &generation)) {
@@ -1122,6 +1127,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 
 		if (fd < 0) {
 			log_err("Failed to open %s\n", file);
+			errno = 0;
 			goto out;
 		}
 		if (ioctl(fd, FS_IOC_GETVERSION, &generation)) {
@@ -1312,6 +1318,7 @@ static int ima_fix(const char *path)
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
 		log_errno("Failed to open file: %s", path);
+		errno = 0;
 		return -1;
 	}
 
@@ -1828,8 +1835,10 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 	int i, result;
 
 	fp = fopen(pcrs, "r");
-	if (!fp)
+	if (!fp) {
 		fp = fopen(misc_pcrs, "r");
+		errno = 0;
+	}
 	if (!fp)
 		return -1;
 
@@ -1892,6 +1901,7 @@ static int read_file_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 		fp = fopen(path, "r");
 		if (!fp) {
 			log_err("Could not open '%s'\n", path);
+			errno = 0;
 			return -1;
 		}
 
@@ -1984,6 +1994,7 @@ static int ima_measurement(const char *file)
 	fp = fopen(file, "rb");
 	if (!fp) {
 		log_err("Failed to open measurement file: %s\n", file);
+		errno = 0;
 		return -1;
 	}
 
@@ -2229,6 +2240,7 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 	fp = fopen(file, "r");
 	if (!fp) {
 		log_errno("Failed to open TPM 1.2 event log.\n");
+		errno = 0;
 		return 1;
 	}
 
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 388b726f1e3a..a4f2ec40684d 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -144,6 +144,7 @@ static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
 	fp = fopen(file, "r");
 	if (!fp) {
 		log_err("Failed to open: %s\n", file);
+		errno = 0;
 		return -1;
 	}
 
@@ -258,6 +259,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 	if (!fp) {
 		if (imaevm_params.verbose > LOG_INFO)
 			log_info("Failed to open keyfile: %s\n", keyfile);
+		errno = 0;
 		return NULL;
 	}
 
@@ -735,6 +737,7 @@ static int read_keyid_from_cert(uint32_t *keyid_be, const char *certfile, int tr
 
 	if (!(fp = fopen(certfile, "r"))) {
 		log_err("Cannot open %s: %s\n", certfile, strerror(errno));
+		errno = 0;
 		return -1;
 	}
 	if (!PEM_read_X509(fp, &x, NULL, NULL)) {
@@ -826,6 +829,7 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 		fp = fopen(keyfile, "r");
 		if (!fp) {
 			log_err("Failed to open keyfile: %s\n", keyfile);
+			errno = 0;
 			return NULL;
 		}
 		pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
diff --git a/src/utils.c b/src/utils.c
index 294dac554392..1026d44776da 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <errno.h>
 
 #include "utils.h"
 
@@ -26,8 +27,10 @@ static int file_exist(const char *path)
 {
 	struct stat st;
 
-	if (!access(path, R_OK) && !stat(path, &st) && S_ISREG(st.st_mode))
+	if (!access(path, R_OK) && !stat(path, &st) && S_ISREG(st.st_mode)) {
+		errno = 0;
 		return 1;
+	}
 
 	return 0;
 }
-- 
2.27.0

