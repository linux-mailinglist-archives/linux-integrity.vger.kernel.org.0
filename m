Return-Path: <linux-integrity+bounces-1476-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD64867FB5
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 19:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38D2B22BAA
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19112F378;
	Mon, 26 Feb 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bRBnT7yK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863412EBEA
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971682; cv=none; b=HjCdTkuAHmnt27y9EQCB3HPJZ/5uIRm+nqu5iSOsS9UfWS2L1HfLCKJMz4Lz+yjBP/ui4f/0eDGvWPqj0qg7LxpvkRUzzyUoVrEpop22ddGnO/VzpGrRu/cKHgRwL5JhLiKSwLpWgNOO35Gdn6nU93EnNFvfJipOR9LdsVIkNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971682; c=relaxed/simple;
	bh=h7WfAq7U/cJ1mhh/23qx9O38D9knj4LAO7UkG4PJTfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDLs15bhhhN8ACabvH9wrgeWt/JE7wl5epaF2sQ1olX/fsDcxSOFMKogrkpfCA2PTtxJqozkRu0wmGR00deyqcGoBXEQpji59FOKUxoFgJpxeM8LfxcIN10gFvnyYhUa4jQXybI9JdMJ50mJRC9tuss4XCtRS1Ag5EB0WThooH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bRBnT7yK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHDYhB023975;
	Mon, 26 Feb 2024 18:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TC92paM6IIUxtmTco8hPgZym8UmDjZqYvgKPVQG+xbw=;
 b=bRBnT7yKeifVuf1QAXDhpd5dIF28+pNSXFMfm+8msLH9UoVgksB3bMWVcS08YqXTHoha
 crcv+JDi4fWioLZzO5V1o/tq1R++T6QIo1O9H5oGt2ZEPA1MPAWAFFnac6HWIOxfmriH
 DwTidyuKlIoKwJxyAd2a6QkO+M+p04PpU1WszKl+VzwNer11YPSA65Jpy6NjB2K4KI0K
 qL+R3pK4BaRiPdlqvB+EPjuJ0ZtmrkKvqJJAMMlehpTww9k2SlR4dI2fBL4d9BbTHFRl
 gVgLiWvrvrYNYbYuvrHL1H54h+avCnrSHKhca8AH+tzMUdRvmNIrq54tIO6k8yWEY3IF nA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgxur1jmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHN7a5008170;
	Mon, 26 Feb 2024 18:21:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9m2s5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QIL6AO62193948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:21:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B00558059;
	Mon, 26 Feb 2024 18:21:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8646758058;
	Mon, 26 Feb 2024 18:21:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 18:21:05 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 3/7] Pass ENGINE and keyid through to function using them
Date: Mon, 26 Feb 2024 13:20:57 -0500
Message-ID: <20240226182101.25210-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226182101.25210-1-stefanb@linux.ibm.com>
References: <20240226182101.25210-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l1hfAFxRqmW4Ta6LNG6ab2NxF_aDRTVi
X-Proofpoint-ORIG-GUID: l1hfAFxRqmW4Ta6LNG6ab2NxF_aDRTVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260139

Instead of relying on imaevm_params.engine and imaevm_params.keyid global
variables, which are not concurrency-safe, define a new library function
imaevm_signhash() function with the engine and keyid as parameters.

Pass the ENGINE and keyid all the way through to the function that is
using them and deprecate sign_hash since it needs to pass these parameters
from the global imaevm_params.

In preparation of support for OpenSSL providers, wrap the ENGINE in a
union inside a struct imaevm_ossl_access and add a type for the selection
of the ENGINE or provider later on.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/imaevm.h    |  26 ++++++++-
 src/libimaevm.c | 144 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 134 insertions(+), 36 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 6a52afb..6764604 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -51,7 +51,10 @@
 #include <openssl/opensslconf.h>
 
 #if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
-#include <openssl/engine.h>
+# include <openssl/engine.h>
+#else
+struct engine_st;
+typedef struct engine_st ENGINE; /* unused when no engine support */
 #endif
 
 #ifdef USE_FPRINTF
@@ -250,7 +253,9 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
 int key2bin(RSA *key, unsigned char *pub);
 uint32_t imaevm_read_keyid(const char *certfile);
 
-int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
+IMAEVM_DEPRECATED int sign_hash(const char *algo, const unsigned char *hash,
+				int size, const char *keyfile, const char *keypass,
+				unsigned char *sig);
 IMAEVM_DEPRECATED int ima_calc_hash(const char *file, uint8_t *hash);
 IMAEVM_DEPRECATED int verify_hash(const char *file, const unsigned char *hash,
 				  int size, unsigned char *sig, int siglen);
@@ -259,7 +264,24 @@ IMAEVM_DEPRECATED int ima_verify_signature(const char *file, unsigned char *sig,
 					   int digestlen);
 IMAEVM_DEPRECATED void init_public_keys(const char *keyfiles);
 
+struct imaevm_ossl_access {
+	int type;
+#define IMAEVM_OSSL_ACCESS_TYPE_NONE   0
+#define IMAEVM_OSSL_ACCESS_TYPE_ENGINE 1  /* also: engine field exists */
+	union {
+		ENGINE *engine;
+	} u;
+};
+
+#define IMAEVM_SIGFLAG_SIGNATURE_V1	(1 << 0) /* v1 signature; deprecated */
+#define IMAEVM_SIGFLAGS_SUPPORT		(1 << 0) /* mask of all supported flags */
+
 int ima_calc_hash2(const char *file, const char *hash_algo, uint8_t *hash);
+int imaevm_signhash(const char *hashalgo, const unsigned char *hash, int size,
+		    const char *keyfile, const char *keypass,
+		    unsigned char *sig, long sigflags,
+		    const struct imaevm_ossl_access *access_info,
+		    uint32_t keyid);
 int imaevm_verify_hash(struct public_key_entry *public_keys, const char *file,
 		       const char *hash_algo, const unsigned char *hash,
 		       int size, unsigned char *sig, int siglen);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index ce4f6f7..91af613 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -1031,33 +1031,53 @@ uint32_t imaevm_read_keyid(const char *certfile)
 	return ntohl(keyid_be);
 }
 
-static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
+static EVP_PKEY *read_priv_pkey_engine(ENGINE *e, const char *keyfile,
+				       const char *keypass, uint32_t keyid)
 {
-	FILE *fp;
-	EVP_PKEY *pkey = NULL;
-
-	if (!strncmp(keyfile, "pkcs11:", 7)) {
 #ifdef CONFIG_IMA_EVM_ENGINE
-		if (!imaevm_params.keyid) {
-			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
-			return NULL;
-		}
+	EVP_PKEY *pkey;
 
-		if (keypass) {
-			if (!ENGINE_ctrl_cmd_string(imaevm_params.eng, "PIN", keypass, 0)) {
-				log_err("Failed to set the PIN for the private key\n");
-				goto err_engine;
-			}
-		}
-		pkey = ENGINE_load_private_key(imaevm_params.eng, keyfile, NULL, NULL);
-		if (!pkey) {
-			log_err("Failed to load private key %s\n", keyfile);
+	if (!keyid) {
+		log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
+		return NULL;
+	}
+
+	if (keypass) {
+		if (!ENGINE_ctrl_cmd_string(e, "PIN", keypass, 0)) {
+			log_err("Failed to set the PIN for the private key\n");
 			goto err_engine;
 		}
-#else
-		log_err("OpenSSL \"engine\" support is disabled\n");
+	}
+	pkey = ENGINE_load_private_key(e, keyfile, NULL, NULL);
+	if (!pkey) {
+		log_err("Failed to load private key %s\n", keyfile);
 		goto err_engine;
+	}
+	return pkey;
+
+err_engine:
+	output_openssl_errors();
+	return NULL;
+#else
+	log_err("OpenSSL \"engine\" support is disabled\n");
+	return NULL;
 #endif
+}
+
+static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass,
+				const struct imaevm_ossl_access *access_info,
+				uint32_t keyid)
+{
+	FILE *fp;
+	EVP_PKEY *pkey = NULL;
+
+	if (!strncmp(keyfile, "pkcs11:", 7)) {
+		switch (access_info->type) {
+		case IMAEVM_OSSL_ACCESS_TYPE_ENGINE:
+			pkey = read_priv_pkey_engine(access_info->u.engine,
+						     keyfile, keypass, keyid);
+			break;
+		}
 	} else {
 		fp = fopen(keyfile, "r");
 		if (!fp) {
@@ -1076,18 +1096,17 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 
 	return pkey;
 
-err_engine:
-	output_openssl_errors();
-	return NULL;
 }
 
 #if CONFIG_SIGV1
-static RSA *read_priv_key(const char *keyfile, const char *keypass)
+static RSA *read_priv_key(const char *keyfile, const char *keypass,
+			  const struct imaevm_ossl_access *access_info,
+			  uint32_t keyid)
 {
 	EVP_PKEY *pkey;
 	RSA *key;
 
-	pkey = read_priv_pkey(keyfile, keypass);
+	pkey = read_priv_pkey(keyfile, keypass, access_info, keyid);
 	if (!pkey)
 		return NULL;
 	key = EVP_PKEY_get1_RSA(pkey);
@@ -1113,7 +1132,9 @@ static int get_hash_algo_v1(const char *algo)
 
 static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
 			int size, const char *keyfile, const char *keypass,
-			unsigned char *sig)
+			unsigned char *sig,
+			const struct imaevm_ossl_access *access_info,
+			uint32_t keyid)
 {
 	int len = -1, hashalgo_idx;
 	SHA_CTX ctx;
@@ -1147,7 +1168,7 @@ static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
 	log_info("hash(%s): ", hashalgo);
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, keypass);
+	key = read_priv_key(keyfile, keypass, access_info, keyid);
 	if (!key)
 		return -1;
 
@@ -1201,7 +1222,9 @@ out:
  */
 static int sign_hash_v2(const char *algo, const unsigned char *hash,
 			int size, const char *keyfile, const char *keypass,
-			unsigned char *sig)
+			unsigned char *sig,
+			const struct imaevm_ossl_access *access_info,
+			uint32_t keyid)
 {
 	struct signature_v2_hdr *hdr;
 	int len = -1;
@@ -1211,7 +1234,6 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	const EVP_MD *md;
 	size_t sigsize;
 	const char *st;
-	uint32_t keyid;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -1236,7 +1258,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	log_info("hash(%s): ", algo);
 	log_dump(hash, size);
 
-	pkey = read_priv_pkey(keyfile, keypass);
+	pkey = read_priv_pkey(keyfile, keypass, access_info, keyid);
 	if (!pkey)
 		return -1;
 
@@ -1259,8 +1281,8 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	}
 #endif
 
-	if (imaevm_params.keyid)
-		keyid = htonl(imaevm_params.keyid);
+	if (keyid)
+		keyid = htonl(keyid);
 	else {
 		int keyid_read_failed = read_keyid_from_cert(&keyid, keyfile, false);
 
@@ -1303,17 +1325,71 @@ err:
 	return len;
 }
 
+static int check_ossl_access(const struct imaevm_ossl_access *access_info)
+{
+	switch (access_info->type) {
+	case IMAEVM_OSSL_ACCESS_TYPE_NONE:
+#ifdef CONFIG_IMA_EVM_ENGINE
+	case IMAEVM_OSSL_ACCESS_TYPE_ENGINE:
+#endif
+		return 0;
+
+	default:
+		errno = EINVAL;
+		return -1;
+	}
+}
+
+int imaevm_signhash(const char *hashalgo, const unsigned char *hash, int size,
+		    const char *keyfile, const char *keypass,
+		    unsigned char *sig, long sigflags,
+		    const struct imaevm_ossl_access *access_info,
+		    uint32_t keyid)
+{
+	int rc;
+
+	if (access_info) {
+		rc = check_ossl_access(access_info);
+		if (rc)
+			return rc;
+	}
+	if (sigflags & ~IMAEVM_SIGFLAGS_SUPPORT) {
+		/* unsupported flag */
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (sigflags & IMAEVM_SIGFLAG_SIGNATURE_V1) {
+#if CONFIG_SIGV1
+		return sign_hash_v1(hashalgo, hash, size, keyfile, keypass, sig,
+				    access_info, keyid);
+#else
+		log_info("Signature version 1 deprecated.");
+		return -1;
+#endif
+	}
+
+	return sign_hash_v2(hashalgo, hash, size, keyfile, keypass, sig,
+			    access_info, keyid);
+}
+
 
 int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
 {
+	const struct imaevm_ossl_access access_info = {
+		.type = IMAEVM_OSSL_ACCESS_TYPE_ENGINE,
+		.u.engine = imaevm_params.eng,
+	};
 	if (!keypass)	/* Avoid breaking existing libimaevm usage */
 		keypass = imaevm_params.keypass;
 
 	if (imaevm_params.x509)
-		return sign_hash_v2(hashalgo, hash, size, keyfile, keypass, sig);
+		return sign_hash_v2(hashalgo, hash, size, keyfile, keypass, sig,
+				    &access_info, imaevm_params.keyid);
 #if CONFIG_SIGV1
 	else
-		return sign_hash_v1(hashalgo, hash, size, keyfile, keypass, sig);
+		return sign_hash_v1(hashalgo, hash, size, keyfile, keypass, sig,
+				    &access_info, imaevm_params.keyid);
 #endif
 	log_info("Signature version 1 deprecated.");
 	return -1;
-- 
2.43.2


