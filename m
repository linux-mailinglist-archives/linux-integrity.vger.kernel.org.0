Return-Path: <linux-integrity+bounces-657-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA382489C
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0401C2219A
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3B2C18C;
	Thu,  4 Jan 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rsm/Rs5o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0D2C18F
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404IDuKV014653
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aUTHVwAswm5bQC6tuiITqSHt2usnLZOk8wDzVe7ImNI=;
 b=rsm/Rs5oKt1RtrSVjBR2YqxMYMSYQRCth2K3QracpERnudD/aE+lHldblzfYW4v2i93X
 ZEykrMYgo3qTx2sLMfs+c7mmkIEehlsNc+bxZZy/uPMiA1zVirn9ZWGuFwgctQqH7BeY
 QRyZ4lpKW+x5jwelBAC1ESJc/xZzlYijDrDZlegVU20Y5z2lbrLbFpH6lOF2fL+xZ/wn
 zLpzvDB4bPP31lHb1I/f8mZktEXkomDAxffNBFXPmKaSVvEds9MG4c7idkD7zMJ1jY/3
 OjbzccFXUKuCcxq7OW//pPn+a3v+Kv4XMGey80MxQw+bWdcVomCTtzkhWQ59d8ODxeMq lg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve1rxhbjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404GvNI7019314
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30stabc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6ETZ11272860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0392820043;
	Thu,  4 Jan 2024 19:06:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54FAD20040;
	Thu,  4 Jan 2024 19:06:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:13 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 09/13] Use a local hash algorithm variable when verifying file signatures
Date: Thu,  4 Jan 2024 14:05:54 -0500
Message-Id: <20240104190558.3674008-10-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240104190558.3674008-1-zohar@linux.ibm.com>
References: <20240104190558.3674008-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aBvaKiYxpOR-PxAxw2qP-oidgrQsIrRx
X-Proofpoint-GUID: aBvaKiYxpOR-PxAxw2qP-oidgrQsIrRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=940 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401040149

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
index 214c656d6eba..48bce59fba43 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -485,7 +485,8 @@ void init_public_keys(const char *keyfiles)
  * (Note: signature_v2_hdr struct does not contain the 'type'.)
  */
 static int verify_hash_common(struct public_key_entry *public_keys,
-			      const char *file, const unsigned char *hash,
+			      const char *file, const char *hash_algo,
+			      const unsigned char *hash,
 			      int size, unsigned char *sig, int siglen)
 {
 	int ret = -1;
@@ -496,7 +497,7 @@ static int verify_hash_common(struct public_key_entry *public_keys,
 	const char *st;
 
 	if (imaevm_params.verbose > LOG_INFO) {
-		log_info("hash(%s): ", imaevm_params.hash_algo);
+		log_info("hash(%s): ", hash_algo);
 		log_dump(hash, size);
 	}
 
@@ -527,7 +528,8 @@ static int verify_hash_common(struct public_key_entry *public_keys,
 	if (!EVP_PKEY_verify_init(ctx))
 		goto err;
 	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
+	md = EVP_get_digestbyname(hash_algo);
+	if (!md)
 		goto err;
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
@@ -563,11 +565,12 @@ err:
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
 
@@ -578,19 +581,20 @@ static int verify_hash_v2(struct public_key_entry *public_keys,
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
@@ -633,8 +637,10 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
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
@@ -754,10 +760,10 @@ int imaevm_verify_hash(struct public_key_entry *public_keys, const char *file,
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
@@ -766,8 +772,8 @@ int imaevm_verify_hash(struct public_key_entry *public_keys, const char *file,
 int verify_hash(const char *file, const unsigned char *hash, int size,
 		unsigned char *sig, int siglen)
 {
-	return imaevm_verify_hash(g_public_keys, file, NULL, hash, size,
-				  sig, siglen);
+	return imaevm_verify_hash(g_public_keys, file, imaevm_params.hash_algo,
+				  hash, size, sig, siglen);
 }
 
 int ima_verify_signature2(struct public_key_entry *public_keys, const char *file,
@@ -776,6 +782,7 @@ int ima_verify_signature2(struct public_key_entry *public_keys, const char *file
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
+	const char *hash_algo;
 
 	if (sig[0] != EVM_IMA_XATTR_DIGSIG && sig[0] != IMA_VERITY_DIGSIG) {
 		log_err("%s: xattr ima has no signature\n", file);
@@ -793,22 +800,23 @@ int ima_verify_signature2(struct public_key_entry *public_keys, const char *file
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


