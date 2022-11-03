Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA326187B0
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKCSjZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiKCSjY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB62638
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:23 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3IURVK001890;
        Thu, 3 Nov 2022 18:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qxq90qBrR9pOtJArpqU39kMaPYesIl3zkGw8+LLsPUI=;
 b=JmFpU4y1Jg7QiVo9fhrcqriiHaeZW1LjGED+oyrn9DmjuhvpFuCOcpk5mrsAJSfB9v6Z
 L/ZIbdkWh43b7THb/SWBMtlmSxWsxv8r6MMcXh80Ovv7ZwSWOryWGKqxWz5v3X/0bIqZ
 rVneZkmePWuCqLDYv+kap3Vm8CTxgof96BhFMRVp/opE5YCFNHHA0i4ucvNguQL8sIw5
 jscGfBW4rczXu6L9upfDwLLfv99BKDjeUI/j7fmn0cbZf3Gh2+D+78KLAl2AgbOsDGpb
 bArPz/GA7P3mbPsjR7zyNo3ncqSWeVokn1EXn2xVjh2LA18HRW40yhVVBRSwbiHmULvH Yw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kme7ykxjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:18 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3IZKlK019052;
        Thu, 3 Nov 2022 18:39:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3kjepecp98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IdnQm43778526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:39:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C799A42042;
        Thu,  3 Nov 2022 18:39:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17C2D4203F;
        Thu,  3 Nov 2022 18:39:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:11 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 01/17] Revert "Reset 'errno' after failure to open or access a file"
Date:   Thu,  3 Nov 2022 14:38:48 -0400
Message-Id: <20221103183904.103562-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4tjzSz2ySt6_u-NNNJzAh-Op0YAHKm18
X-Proofpoint-ORIG-GUID: 4tjzSz2ySt6_u-NNNJzAh-Op0YAHKm18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c    | 18 ++----------------
 src/libimaevm.c |  4 ----
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 76e2561798fa..0412bc0ac2b0 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -182,7 +182,6 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
 	fp = fopen(name, "w");
 	if (!fp) {
 		log_err("Failed to open: %s\n", name);
-		errno = 0;
 		return -1;
 	}
 	err = fwrite(data, len, 1, fp);
@@ -208,7 +207,6 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 	fp = fopen(name, "r");
 	if (!fp) {
 		log_err("Failed to open: %s\n", name);
-		errno = 0;
 		return NULL;
 	}
 	if (fstat(fileno(fp), &stats) == -1) {
@@ -315,10 +313,8 @@ static int get_uuid(struct stat *st, char *uuid)
 	sprintf(path, "blkid -s UUID -o value /dev/block/%u:%u", major, minor);
 
 	fp = popen(path, "r");
-	if (!fp) {
-		errno = 0;
+	if (!fp)
 		goto err;
-	}
 
 	len = fread(_uuid, 1, sizeof(_uuid), fp);
 	pclose(fp);
@@ -375,7 +371,6 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 
 			if (fd < 0) {
 				log_err("Failed to open: %s\n", file);
-				errno = 0;
 				return -1;
 			}
 			if (ioctl(fd, FS_IOC_GETVERSION, &generation)) {
@@ -1201,7 +1196,6 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 
 		if (fd < 0) {
 			log_err("Failed to open %s\n", file);
-			errno = 0;
 			goto out;
 		}
 		if (ioctl(fd, FS_IOC_GETVERSION, &generation)) {
@@ -1392,7 +1386,6 @@ static int ima_fix(const char *path)
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
 		log_errno("Failed to open file: %s", path);
-		errno = 0;
 		return -1;
 	}
 
@@ -1916,10 +1909,8 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 	int i, result;
 
 	fp = fopen(pcrs, "r");
-	if (!fp) {
+	if (!fp)
 		fp = fopen(misc_pcrs, "r");
-		errno = 0;
-	}
 	if (!fp)
 		return -1;
 
@@ -1982,7 +1973,6 @@ static int read_file_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 		fp = fopen(path, "r");
 		if (!fp) {
 			log_err("Could not open '%s'\n", path);
-			errno = 0;
 			return -1;
 		}
 
@@ -2075,7 +2065,6 @@ static int ima_measurement(const char *file)
 	fp = fopen(file, "rb");
 	if (!fp) {
 		log_err("Failed to open measurement file: %s\n", file);
-		errno = 0;
 		return -1;
 	}
 
@@ -2321,7 +2310,6 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 	fp = fopen(file, "r");
 	if (!fp) {
 		log_errno("Failed to open TPM 1.2 event log.\n");
-		errno = 0;
 		return 1;
 	}
 
@@ -2758,8 +2746,6 @@ int main(int argc, char *argv[])
 	unsigned long keyid;
 	char *eptr;
 
-	errno = 0;	/* initialize errno */
-
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
 #ifndef DISABLE_OPENSSL_CONF
diff --git a/src/libimaevm.c b/src/libimaevm.c
index e4b62b4989b2..611631c57f14 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -144,7 +144,6 @@ static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
 	fp = fopen(file, "r");
 	if (!fp) {
 		log_err("Failed to open: %s\n", file);
-		errno = 0;
 		return -1;
 	}
 
@@ -259,7 +258,6 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 	if (!fp) {
 		if (imaevm_params.verbose > LOG_INFO)
 			log_info("Failed to open keyfile: %s\n", keyfile);
-		errno = 0;
 		return NULL;
 	}
 
@@ -878,7 +876,6 @@ static int read_keyid_from_cert(uint32_t *keyid_be, const char *certfile, int tr
 
 	if (!(fp = fopen(certfile, "r"))) {
 		log_err("Cannot open %s: %s\n", certfile, strerror(errno));
-		errno = 0;
 		return -1;
 	}
 	if (!PEM_read_X509(fp, &x, NULL, NULL)) {
@@ -970,7 +967,6 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 		fp = fopen(keyfile, "r");
 		if (!fp) {
 			log_err("Failed to open keyfile: %s\n", keyfile);
-			errno = 0;
 			return NULL;
 		}
 		pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
-- 
2.31.1

