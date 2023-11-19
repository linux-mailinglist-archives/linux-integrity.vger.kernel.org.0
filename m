Return-Path: <linux-integrity+bounces-86-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C260A7F079B
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749E0280E37
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853514AAD;
	Sun, 19 Nov 2023 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NxMxZFXf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD6911A
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:09 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGAbES012838
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zzWqt7hAhOLEJyzTcvtJBkb2JUZLezTzCsPX1S5FZpY=;
 b=NxMxZFXfWpwFvliGkPNumul/RTMJA5IwItKd3Ol0ZZrlMoYfirHoq461dWWBM0xdVJoL
 Rjlet6Jsxy+rh0st7/ZiigXXZF1hv1QLCk4GpPcrU6wm4Lkst/IRgeHyIuSpY6fjADyP
 7hKCSgNmvObtgatZt6CcitDJio0jzDAiOUeTyurPJohod12GRox7G69HqAQFARHi6bQC
 ScXm3OQW5tmw7TVdBjeylFQdT5S3/w+vjPyx4/i/SCToYAA3ww4rcx9pmWAlVmxEAPq5
 /ONmedeVlpV2pGt3jMpSfIFeKsC553ovHK+dCaGUzyikiJ1TAZcKZMwm691WEPpUwZXY IA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf1f6rcd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJE6Jq0021000
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ksmbgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGp4b143713120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:51:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA7220049;
	Sun, 19 Nov 2023 16:51:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D706720040;
	Sun, 19 Nov 2023 16:51:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:51:03 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 09/12] Use a local hash algorithm variable when verifying file signatures
Date: Sun, 19 Nov 2023 11:50:40 -0500
Message-Id: <20231119165043.46960-10-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231119165043.46960-1-zohar@linux.ibm.com>
References: <20231119165043.46960-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RURGaFTzopUBr96rCFirr8T1P7PBzUsx
X-Proofpoint-ORIG-GUID: RURGaFTzopUBr96rCFirr8T1P7PBzUsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190129

Instead of relying on the "imaevm_params.algo" global variable, which
is not concurrency-safe, define and use a local variable.

Update static verify_hash_v2(), verify_hash_v3(), and verify_hash_common()
function definitions to include a hash algorithm argument.

Similarly update ima_verify_signature2() and ima_calc_hash2() to define
and use a local hash algorithm variable.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 4c9da7a2f06b..18b6a6f27237 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -488,6 +488,7 @@ void init_public_keys(const char *keyfiles)
  * (Note: signature_v2_hdr struct does not contain the 'type'.)
  */
 static int verify_hash_common(void *public_keys, const char *file,
+			      const char *hash_algo,
 			      const unsigned char *hash,
 			      int size, unsigned char *sig, int siglen)
 {
@@ -499,7 +500,7 @@ static int verify_hash_common(void *public_keys, const char *file,
 	const char *st;
 
 	if (imaevm_params.verbose > LOG_INFO) {
-		log_info("hash(%s): ", imaevm_params.hash_algo);
+		log_info("hash(%s): ", hash_algo);
 		log_dump(hash, size);
 	}
 
@@ -530,7 +531,7 @@ static int verify_hash_common(void *public_keys, const char *file,
 	if (!EVP_PKEY_verify_init(ctx))
 		goto err;
 	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
+	if (!(md = EVP_get_digestbyname(hash_algo)))
 		goto err;
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
@@ -566,11 +567,12 @@ err:
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
 static int verify_hash_v2(void *public_keys, const char *file,
+			  const char *hash_algo,
 			  const unsigned char *hash,
 			  int size, unsigned char *sig, int siglen)
 {
 	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
-	return verify_hash_common(public_keys, file, hash, size,
+	return verify_hash_common(public_keys, file, hash_algo, hash, size,
 				  sig + 1, siglen - 1);
 }
 
@@ -581,19 +583,20 @@ static int verify_hash_v2(void *public_keys, const char *file,
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
 static int verify_hash_v3(void *public_keys, const char *file,
+			  const char *hash_algo,
 			  const unsigned char *hash,
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
@@ -636,8 +639,10 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
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
@@ -757,10 +762,10 @@ int verify_hash2(void *public_keys, const char *file, const char *hash_algo,
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
@@ -774,7 +779,8 @@ int verify_hash2(void *public_keys, const char *file, const char *hash_algo,
 int verify_hash(const char *file, const unsigned char *hash, int size,
 		unsigned char *sig, int siglen)
 {
-	return verify_hash2(g_public_keys, file, NULL, hash, size, sig, siglen);
+	return verify_hash2(g_public_keys, file, imaevm_params.hash_algo,
+			    hash, size, sig, siglen);
 }
 
 int ima_verify_signature2(void *public_keys, const char *file,
@@ -783,6 +789,7 @@ int ima_verify_signature2(void *public_keys, const char *file,
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
+	const char *hash_algo;
 
 	if (sig[0] != EVM_IMA_XATTR_DIGSIG && sig[0] != IMA_VERITY_DIGSIG) {
 		log_err("%s: xattr ima has no signature\n", file);
@@ -800,22 +807,23 @@ int ima_verify_signature2(void *public_keys, const char *file,
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
-		return verify_hash2(public_keys, file, NULL, digest, digestlen,
-				   sig, siglen);
+		return verify_hash2(public_keys, file,
+				    hash_algo, digest, digestlen,
+				    sig, siglen);
 
-	hashlen = ima_calc_hash(file, hash);
+	hashlen = ima_calc_hash2(file, hash_algo, hash);
 	if (hashlen <= 1)
 		return hashlen;
 	assert(hashlen <= sizeof(hash));
 
-	return verify_hash2(public_keys, file, NULL, hash, hashlen,
+	return verify_hash2(public_keys, file, hash_algo, hash, hashlen,
 			    sig, siglen);
 }
 
-- 
2.39.3


