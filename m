Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C65615303
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiKAUS3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKAUS0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8DF644A
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:25 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1IaH3c032273;
        Tue, 1 Nov 2022 20:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VYYMkhwQG+wfyk3wxq1h6bcWHrs7e2US+4y/UJWmv9o=;
 b=MxVwRVXFALbNVQ3vRNQVSGthq5/fdvBXwbWQgnx9a8ytu+t6ycfP+7j4N5mNB5crXqF7
 4rgYWaeIaknaznJTomHX45NloKZN/QdWhv97Ml6PopuJudma5eqXZj5/RhTj9nb5zJod
 DDxLfYIVK71uHVyL8GfAr2ethdtnnEryCnkfaZGHvoNCbvq//yPOTYFV0DDuTbMisa/B
 c8XyKskoyVmwLaSvbTVlFcgZUFcBKe3qGToLLN2XbZ4lRS4A5kKWgrftn4ywOGbx0zuO
 smpE6hChlFJ03WSnOQwqEFuapBdgMMf7iDoFKBKRbnq6wi/9LdPQP+GdyO7C1xCaSRKH Hw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjtw3g4fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:21 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K5JlK025198;
        Tue, 1 Nov 2022 20:18:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3kgut9bwbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KIq0X39125474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88571A4060;
        Tue,  1 Nov 2022 20:18:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC476A4054;
        Tue,  1 Nov 2022 20:18:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:15 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 09/17] Add missing EVP_MD_CTX_free() call in calc_evm_hash()
Date:   Tue,  1 Nov 2022 16:17:55 -0400
Message-Id: <20221101201803.372652-10-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: opd1Wh6UV8VT7lFRJY7A4FELlvlXKPAM
X-Proofpoint-GUID: opd1Wh6UV8VT7lFRJY7A4FELlvlXKPAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When EVP_MD_CTX_new() call was added, the corresponding EVP_MD_CTX_free()
was never called.  Properly free it.

Fixes: 81010f0d87ef ("ima-evm-utils: Add backward compatible support for openssl 1.1")
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 58 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 5306d3b6356d..039571577448 100644
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
@@ -349,12 +355,10 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 #if OPENSSL_VERSION_NUMBER < 0x10100000
 	EVP_MD_CTX ctx;
 	pctx = &ctx;
-#else
-	pctx = EVP_MD_CTX_new();
 #endif
 
 	if (lstat(file, &st)) {
-		log_err("Failed to stat: %s\n", file);
+		log_errno_reset(LOG_ERR, "Failed to stat: %s", file);
 		return -1;
 	}
 
@@ -389,21 +393,30 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 
 	list_size = llistxattr(file, list, sizeof(list));
 	if (list_size < 0) {
-		log_err("llistxattr() failed\n");
+		log_errno_reset(LOG_ERR, "llistxattr() failed");
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
@@ -414,7 +427,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			if (err > sizeof(xattr_value)) {
 				log_err("selinux[%u] value is too long to fit into xattr[%zu]\n",
 					err, sizeof(xattr_value));
-				return -1;
+				err = -1;
+				goto out;
 			}
 			strcpy(xattr_value, selinux_str);
 		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && ima_str) {
@@ -422,7 +436,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			if (err > sizeof(xattr_value)) {
 				log_err("ima[%u] value is too long to fit into xattr[%zu]\n",
 					err, sizeof(xattr_value));
-				return -1;
+				err = -1;
+				goto out;
 			}
 			hex2bin(xattr_value, ima_str, err);
 		} else if (!strcmp(*xattrname, XATTR_NAME_IMA) && evm_portable){
@@ -431,7 +446,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			if (err < 0) {
 				log_err("EVM portable sig: %s required\n",
 					xattr_ima);
-				return -1;
+				goto out;
 			}
 			use_xattr_ima = 1;
 		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
@@ -441,7 +456,8 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 			if (err >= sizeof(xattr_value)) {
 				log_err("caps[%u] value is too long to fit into xattr[%zu]\n",
 					err + 1, sizeof(xattr_value));
-				return -1;
+				err = -1;
+				goto out;
 			}
 			strcpy(xattr_value, caps_str);
 		} else {
@@ -462,7 +478,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		err = EVP_DigestUpdate(pctx, xattr_value, err);
 		if (!err) {
 			log_err("EVP_DigestUpdate() failed\n");
-			return 1;
+			goto out;
 		}
 	}
 
@@ -516,29 +532,33 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
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
-- 
2.31.1

