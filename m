Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95D45AB68D
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Sep 2022 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiIBQ3W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 12:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiIBQ3S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 12:29:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A627DDA8D
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 09:29:09 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282G0w0m030758;
        Fri, 2 Sep 2022 16:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/J9sLw+5b/f42Q5km3yDhBKn+qpgjLTUWcPySEm8vXY=;
 b=lgnABf6OAezevGrPAlyesF2fFF5LvrrBEA+F0aMVWxeE7tkMQOqZY4tLl5fgZJfTko1D
 0YIMcC+Rfv7NjaJ8GcI0aaE4RYm1U6zZpCcTnnkFPNKy10kXD8hCMFE7i/4CGMThmk7O
 NLtIMWPbnXEz/flzxUVFi0QONNQDUJTvPcL+VlIXp7ppmT0/rk2VZ9suaA1+UlO9MR4O
 W5Qn5dfm8Dm6ORTVtcux3vj6rqnEIUXXw4vdQsmTbLQa/eIioO3cKeJnuJUlY1BmAhCN
 8cNo1DpAhbX3qCNS9+X5kEoQVGAXT+su6GhMW8WuPvmOb+mdGNPK3eH6lKMSBSN1ROhf 9A== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbmyx0xw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:29:03 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282G7qsn019601;
        Fri, 2 Sep 2022 16:29:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3j7aw8x5d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:29:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282GTKaY21955006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 16:29:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF83C5204E;
        Fri,  2 Sep 2022 16:28:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.132.193])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4C60D5204F;
        Fri,  2 Sep 2022 16:28:56 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 07/11] Add missing EVP_MD_CTX_free() call in calc_evm_hash()
Date:   Fri,  2 Sep 2022 12:28:32 -0400
Message-Id: <20220902162836.554839-8-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902162836.554839-1-zohar@linux.ibm.com>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SooPzYGuGTb7br4AARNXBC9I49EWZlmH
X-Proofpoint-ORIG-GUID: SooPzYGuGTb7br4AARNXBC9I49EWZlmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209020075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When EVP_MD_CTX_new() call was added, the corresponding EVP_MD_CTX_free()
was never called.  Properly free it.

Fixes: 81010f0d87ef ("ima-evm-utils: Add backward compatible support for openssl 1.1")
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 57 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index a9b2f1040787..b89e74e06c3d 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -331,11 +331,17 @@ err:
 	return -1;
 }
 
+/*
+ * calc_evm_hash - calculate the file metadata hash
+ *
+ * Returns 0 for EVP_ function failures. Return -1 for other failures.
+ * Return hash algorithm size on success.
+ */
 static int calc_evm_hash(const char *file, unsigned char *hash)
 {
         const EVP_MD *md;
 	struct stat st;
-	int err;
+	int err = -1;
 	uint32_t generation = 0;
 	EVP_MD_CTX *pctx;
 	unsigned int mdlen;
@@ -349,12 +355,11 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 #if OPENSSL_VERSION_NUMBER < 0x10100000
 	EVP_MD_CTX ctx;
 	pctx = &ctx;
-#else
-	pctx = EVP_MD_CTX_new();
 #endif
 
 	if (lstat(file, &st)) {
 		log_err("Failed to stat: %s\n", file);
+		errno = 0;
 		return -1;
 	}
 
@@ -391,20 +396,30 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 	list_size = llistxattr(file, list, sizeof(list));
 	if (list_size < 0) {
 		log_err("llistxattr() failed\n");
+		errno = 0;
 		return -1;
 	}
 
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	pctx = EVP_MD_CTX_new();
+	if (!pctx) {
+		log_err("EVP_MD_CTX_new() failed\n");
+		return 0;
+	}
+#endif
+
 	md = EVP_get_digestbyname(imaevm_params.hash_algo);
 	if (!md) {
 		log_err("EVP_get_digestbyname(%s) failed\n",
 			imaevm_params.hash_algo);
-		return 1;
+		err = 0;
+		goto out;
 	}
 
 	err = EVP_DigestInit(pctx, md);
 	if (!err) {
 		log_err("EVP_DigestInit() failed\n");
-		return 1;
+		goto out;
 	}
 
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
@@ -415,7 +430,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			if (err > sizeof(xattr_value)) {
 				log_err("selinux[%u] value is too long to fit into xattr[%zu]\n",
 					err, sizeof(xattr_value));
-				return -1;
+				err = -1;
+				goto out;
 			}
 			strcpy(xattr_value, selinux_str);
 		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && ima_str) {
@@ -423,7 +439,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			if (err > sizeof(xattr_value)) {
 				log_err("ima[%u] value is too long to fit into xattr[%zu]\n",
 					err, sizeof(xattr_value));
-				return -1;
+				err = -1;
+				goto out;
 			}
 			hex2bin(xattr_value, ima_str, err);
 		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && evm_portable){
@@ -432,7 +449,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			if (err < 0) {
 				log_err("EVM portable sig: %s required\n",
 					xattr_ima);
-				return -1;
+				goto out;
 			}
 			use_xattr_ima = 1;
 		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
@@ -442,7 +459,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			if (err >= sizeof(xattr_value)) {
 				log_err("caps[%u] value is too long to fit into xattr[%zu]\n",
 					err + 1, sizeof(xattr_value));
-				return -1;
+				err = -1;
+				goto out;
 			}
 			strcpy(xattr_value, caps_str);
 		} else {
@@ -463,7 +481,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		err = EVP_DigestUpdate(pctx, xattr_value, err);
 		if (!err) {
 			log_err("EVP_DigestUpdate() failed\n");
-			return 1;
+			goto out;
 		}
 	}
 
@@ -517,29 +535,33 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 	err = EVP_DigestUpdate(pctx, &hmac_misc, hmac_size);
 	if (!err) {
 		log_err("EVP_DigestUpdate() failed\n");
-		return 1;
+		goto out;
 	}
 
 	if (!evm_immutable && !evm_portable &&
 	    !(hmac_flags & HMAC_FLAG_NO_UUID)) {
 		err = get_uuid(&st, uuid);
 		if (err)
-			return -1;
+			goto out;
 
 		err = EVP_DigestUpdate(pctx, (const unsigned char *)uuid, sizeof(uuid));
 		if (!err) {
 			log_err("EVP_DigestUpdate() failed\n");
-			return 1;
+			goto out;
 		}
 	}
 
 	err = EVP_DigestFinal(pctx, hash, &mdlen);
-	if (!err) {
+	if (!err)
 		log_err("EVP_DigestFinal() failed\n");
-		return 1;
-	}
 
-	return mdlen;
+out:
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	EVP_MD_CTX_free(pctx);
+#endif
+	if (err == 1)
+		return mdlen;
+	return err;
 }
 
 static int sign_evm(const char *file, const char *key)
@@ -575,6 +597,7 @@ static int sign_evm(const char *file, const char *key)
 		err = lsetxattr(file, xattr_evm, sig, len, 0);
 		if (err < 0) {
 			log_err("setxattr failed: %s\n", file);
+			errno = 0;
 			return err;
 		}
 	}
-- 
2.31.1

