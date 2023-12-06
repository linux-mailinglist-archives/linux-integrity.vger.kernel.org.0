Return-Path: <linux-integrity+bounces-368-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24E8078A3
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7754528219C
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FF847F5D;
	Wed,  6 Dec 2023 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bkJSej1R"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA141725
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:20 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6HoIwh012742
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V5JcMJDtGuRWDxYq0YXS76su8N32iwb4SLt2EY56qKc=;
 b=bkJSej1RFTD9zUyVvFchpEueGxML6L5deYJ15xlvQ8uUPbcOCK7DQ1aVDAMnr6qBksew
 JG3AEWuP0WoF3p9k1bJ3NLdtSYrppQzXsUSvATj02c5q266as41D0KOs1owL2jLk8v8Y
 Z0OUCCw7XBfE20fIjGt5YeFj4YYuL9nOxAkP7DOA+8FUIdpHyUFowFASXmGA7R1K9r0v
 spQXIvVUgcvSX2ZGibDB/p4VyJYqcLtNToOz2Tz5hfXwRZvHWC16l32pQ2OcyRYzEdut
 JHqCL9s8qwrBWid7VifNwB0+0383XmhX7owAurLGzurd7YTS+a7X1noa2e58LSdHmEDT qg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utwem2w5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:19 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IeOJP015413
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavkejf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JSFbs10355356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6796B2004D;
	Wed,  6 Dec 2023 19:28:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976F620040;
	Wed,  6 Dec 2023 19:28:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:14 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 09/13] Use a local hash algorithm variable when verifying file signatures
Date: Wed,  6 Dec 2023 14:27:30 -0500
Message-Id: <20231206192734.339999-10-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206192734.339999-1-zohar@linux.ibm.com>
References: <20231206192734.339999-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NsxxIG2UX6kpv5g8DJy21Fh9apfo8qAx
X-Proofpoint-GUID: NsxxIG2UX6kpv5g8DJy21Fh9apfo8qAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=946 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

Instead of relying on the "imaevm_params.algo" global variable, which
is not concurrency-safe, define and use a local variable.

Update static verify_hash_v2(), verify_hash_v3(), and verify_hash_common()
function definitions to include a hash algorithm argument.

Similarly update ima_verify_signature2() and ima_calc_hash2() to define
and use a local hash algorithm variable.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index c14ba7632b61..10e1ed3eab4d 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -484,7 +484,8 @@ __attribute__((deprecated)) void init_public_keys(const char *keyfiles)
  * (Note: signature_v2_hdr struct does not contain the 'type'.)
  */
 static int verify_hash_common(struct public_key_entry *public_keys,
-			      const char *file, const unsigned char *hash,
+			      const char *file, const char *hash_algo,
+			      const unsigned char *hash,
 			      int size, unsigned char *sig, int siglen)
 {
 	int ret = -1;
@@ -495,7 +496,7 @@ static int verify_hash_common(struct public_key_entry *public_keys,
 	const char *st;
 
 	if (imaevm_params.verbose > LOG_INFO) {
-		log_info("hash(%s): ", imaevm_params.hash_algo);
+		log_info("hash(%s): ", hash_algo);
 		log_dump(hash, size);
 	}
 
@@ -526,7 +527,8 @@ static int verify_hash_common(struct public_key_entry *public_keys,
 	if (!EVP_PKEY_verify_init(ctx))
 		goto err;
 	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
+	md = EVP_get_digestbyname(hash_algo);
+	if (!md)
 		goto err;
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
@@ -562,11 +564,12 @@ err:
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
 static int verify_hash_v2(struct public_key_entry *public_keys,
-			  const char *file, const unsigned char *hash,
+			  const char *file, const char *hash_algo,
+			  const unsigned char *hash,
 			  int size, unsigned char *sig, int siglen)
 {
 	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
-	return verify_hash_common(public_keys, file, hash, size,
+	return verify_hash_common(public_keys, file, hash_algo, hash, size,
 				  sig + 1, siglen - 1);
 }
 
@@ -577,19 +580,20 @@ static int verify_hash_v2(struct public_key_entry *public_keys,
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
 static int verify_hash_v3(struct public_key_entry *public_keys,
-			  const char *file, const unsigned char *hash,
+			  const char *file, const char *hash_algo,
+			  const unsigned char *hash,
 			  int size, unsigned char *sig, int siglen)
 {
 	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
 	int ret;
 
-	ret = calc_hash_sigv3(sig[0], NULL, hash, sigv3_hash);
+	ret = calc_hash_sigv3(sig[0], hash_algo, hash, sigv3_hash);
 	if (ret < 0)
 		return ret;
 
 	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
-	return verify_hash_common(public_keys, file, sigv3_hash, size,
-				  sig + 1, siglen - 1);
+	return verify_hash_common(public_keys, file, hash_algo, sigv3_hash,
+				  size, sig + 1, siglen - 1);
 }
 
 #define HASH_MAX_DIGESTSIZE 64	/* kernel HASH_MAX_DIGESTSIZE is 64 bytes */
@@ -632,8 +636,10 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
 		return -EINVAL;
 	}
 
-	if (!algo)
-		algo = imaevm_params.hash_algo;
+	if (!algo) {
+		log_err("Hash algorithm unspecified\n");
+		return -EINVAL;
+	}
 
 	if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
 		log_err("Hash algorithm %s not supported\n", algo);
@@ -753,10 +759,10 @@ int imaevm_verify_hash(void *public_keys, const char *file,
 		return -1;
 #endif
 	} else if (sig[1] == DIGSIG_VERSION_2) {
-		return verify_hash_v2(public_keys, file, hash, size,
+		return verify_hash_v2(public_keys, file, hash_algo, hash, size,
 				      sig, siglen);
 	} else if (sig[1] == DIGSIG_VERSION_3) {
-		return verify_hash_v3(public_keys, file, hash, size,
+		return verify_hash_v3(public_keys, file, hash_algo, hash, size,
 				      sig, siglen);
 	} else
 		return -1;
@@ -766,8 +772,8 @@ __attribute__((deprecated)) int verify_hash(const char *file,
 					    const unsigned char *hash, int size,
 					    unsigned char *sig, int siglen)
 {
-	return imaevm_verify_hash(g_public_keys, file, NULL, hash, size,
-				  sig, siglen);
+	return imaevm_verify_hash(g_public_keys, file, imaevm_params.hash_algo,
+				  hash, size, sig, siglen);
 }
 
 int ima_verify_signature2(void *public_keys, const char *file,
@@ -776,6 +782,7 @@ int ima_verify_signature2(void *public_keys, const char *file,
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
+	const char *hash_algo;
 
 	if (sig[0] != EVM_IMA_XATTR_DIGSIG && sig[0] != IMA_VERITY_DIGSIG) {
 		log_err("%s: xattr ima has no signature\n", file);
@@ -793,22 +800,23 @@ int ima_verify_signature2(void *public_keys, const char *file,
 		return -1;
 	}
 	/* Use hash algorithm as retrieved from signature */
-	imaevm_params.hash_algo = imaevm_hash_algo_by_id(sig_hash_algo);
+	hash_algo = imaevm_hash_algo_by_id(sig_hash_algo);
 
 	/*
 	 * Validate the signature based on the digest included in the
 	 * measurement list, not by calculating the local file digest.
 	 */
 	if (digest && digestlen > 0)
-		return imaevm_verify_hash(public_keys, file, NULL, digest,
-					  digestlen, sig, siglen);
+		return imaevm_verify_hash(public_keys, file,
+					  hash_algo, digest, digestlen,
+					  sig, siglen);
 
-	hashlen = ima_calc_hash(file, hash);
+	hashlen = ima_calc_hash2(file, hash_algo, hash);
 	if (hashlen <= 1)
 		return hashlen;
 	assert(hashlen <= sizeof(hash));
 
-	return imaevm_verify_hash(public_keys, file, NULL, hash, hashlen,
+	return imaevm_verify_hash(public_keys, file, hash_algo, hash, hashlen,
 				  sig, siglen);
 }
 
-- 
2.39.3


