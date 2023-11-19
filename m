Return-Path: <linux-integrity+bounces-94-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBEB7F07A3
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6053F280E68
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F345B168BA;
	Sun, 19 Nov 2023 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XU8rkyAa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDEE128
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:18 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGejvE001788
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=72I2xOrg9vf1uTNNoibqCZ8b92D/DR31HNf4uRamXqA=;
 b=XU8rkyAaqIhKPJ73o0xHDZyk2jZbvD9MpwAv0w1OZrRGJfKL9Q3yfQDORr0NjewSTIww
 IKREYHO0GDH0+hI0pQQdxNAGgHWU+xfOibCDHZInnS31qOkv2ttvywSYGmEtGDjnOBGz
 HbEFQpOy0FcdJJiqVUwgdGvbh+PFl3oW6KXEFiQPNnIklvZ9F25iwAEiEpHT+2eJpepp
 hltT6MywNAUtkr6im+3Uq8H0VbHyA2gVtbZiCZbr+NLLKSuJuqak/GBz+PjS1x8BRfHA
 ZrlgiNiXSM3HnjwhgegpkPHsYFghjhzqXJOUjrMbU6wBlM8/+s2TP3naVFVof7FM5h9A RQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf0ndh2bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJEBfQO031842
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kbwhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGowPi9306814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:50:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 089DF2004B;
	Sun, 19 Nov 2023 16:50:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E5C20040;
	Sun, 19 Nov 2023 16:50:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:50:56 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 03/12] Update library function definitions to include a "public_keys" parameter
Date: Sun, 19 Nov 2023 11:50:34 -0500
Message-Id: <20231119165043.46960-4-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: 0vKyW3VdzX9BaArKrp2J2m2RfffUkiky
X-Proofpoint-ORIG-GUID: 0vKyW3VdzX9BaArKrp2J2m2RfffUkiky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190129

Instead of relying on a global static "public_keys" variable, which is
not concurrency-safe, update static library function definitions to
include it as a parameter, define new library functions with it as
a parameter, and deprecate existing functions.

Define init_public_keys2(), verify_hash2(), and ima_verify_signature2()
functions. Update static function defintions to include "public_keys".

To avoid library incompatablity, make the existing functions -
init_public_keys(), verify_hash(), ima_verify_signature() - wrappers
for the new function versions.

Deprecate init_public_keys(), verify_hash(), ima_verify_signature()
functions.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  2 ++
 src/libimaevm.c | 94 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 828976e52881..146123ba5c42 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -249,8 +249,10 @@ uint32_t imaevm_read_keyid(const char *certfile);
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
+int ima_verify_signature2(void *public_keys, const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
 void free_public_keys(void *public_keys);
 void init_public_keys(const char *keyfiles);
+int init_public_keys2(const char *keyfiles, void **public_keys);
 int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
 int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo, const unsigned char *in_hash, unsigned char *out_hash);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 74e9d09b1f05..bf8c99770ddc 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -372,12 +372,12 @@ struct public_key_entry {
 };
 static struct public_key_entry *g_public_keys = NULL;
 
-static EVP_PKEY *find_keyid(uint32_t keyid)
+static EVP_PKEY *find_keyid(void *public_keys, uint32_t keyid)
 {
-	struct public_key_entry *entry, *tail = g_public_keys;
+	struct public_key_entry *entry, *tail = public_keys;
 	int i = 1;
 
-	for (entry = g_public_keys; entry != NULL; entry = entry->next) {
+	for (entry = public_keys; entry != NULL; entry = entry->next) {
 		if (entry->keyid == keyid)
 			return entry->key;
 		i++;
@@ -394,7 +394,7 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
 	if (tail)
 		tail->next = entry;
 	else
-		g_public_keys = entry;
+		public_keys = (void *) entry;
 	log_err("key %d: %x (unknown keyid)\n", i, __be32_to_cpup(&keyid));
 	return 0;
 }
@@ -412,7 +412,7 @@ void free_public_keys(void *public_keys)
 	}
 }
 
-void init_public_keys(const char *keyfiles)
+int init_public_keys2(const char *keyfiles, void **public_keys)
 {
 	struct public_key_entry *entry;
 	char *tmp_keyfiles, *keyfiles_free;
@@ -420,6 +420,11 @@ void init_public_keys(const char *keyfiles)
 	int err = 0;
 	int i = 1;
 
+	if (!public_keys)
+		return -EINVAL;
+
+	*public_keys = NULL;
+
 	tmp_keyfiles = strdup(keyfiles);
 	keyfiles_free = tmp_keyfiles;
 
@@ -444,12 +449,24 @@ void init_public_keys(const char *keyfiles)
 		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
-		entry->next = g_public_keys;
-		g_public_keys = entry;
+		entry->next = (struct public_key_entry *) *public_keys;
+		*public_keys = (void *)entry;
 	}
+
 	free(keyfiles_free);
 	if (err < 0)
-		free_public_keys(g_public_keys);
+		free_public_keys(public_keys);
+	return err;
+}
+
+/*
+ * Global static variables are not concurrency-safe.
+ *
+ * Deprecate init_public_keys() usage.
+ */
+void init_public_keys(const char *keyfiles)
+{
+	init_public_keys2(keyfiles, (void **)&g_public_keys);
 }
 
 /*
@@ -466,7 +483,8 @@ void init_public_keys(const char *keyfiles)
  *
  * (Note: signature_v2_hdr struct does not contain the 'type'.)
  */
-static int verify_hash_common(const char *file, const unsigned char *hash,
+static int verify_hash_common(void *public_keys, const char *file,
+			      const unsigned char *hash,
 			      int size, unsigned char *sig, int siglen)
 {
 	int ret = -1;
@@ -481,7 +499,7 @@ static int verify_hash_common(const char *file, const unsigned char *hash,
 		log_dump(hash, size);
 	}
 
-	pkey = find_keyid(hdr->keyid);
+	pkey = find_keyid(public_keys, hdr->keyid);
 	if (!pkey) {
 		uint32_t keyid = hdr->keyid;
 
@@ -543,11 +561,13 @@ err:
  *
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
-static int verify_hash_v2(const char *file, const unsigned char *hash,
+static int verify_hash_v2(void *public_keys, const char *file,
+			  const unsigned char *hash,
 			  int size, unsigned char *sig, int siglen)
 {
 	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
-	return verify_hash_common(file, hash, size, sig + 1, siglen - 1);
+	return verify_hash_common(public_keys, file, hash, size,
+				  sig + 1, siglen - 1);
 }
 
 /*
@@ -556,7 +576,8 @@ static int verify_hash_v2(const char *file, const unsigned char *hash,
  *
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
-static int verify_hash_v3(const char *file, const unsigned char *hash,
+static int verify_hash_v3(void *public_keys, const char *file,
+			  const unsigned char *hash,
 			  int size, unsigned char *sig, int siglen)
 {
 	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
@@ -567,7 +588,8 @@ static int verify_hash_v3(const char *file, const unsigned char *hash,
 		return ret;
 
 	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
-	return verify_hash_common(file, sigv3_hash, size, sig + 1, siglen - 1);
+	return verify_hash_common(public_keys, file, sigv3_hash, size,
+				  sig + 1, siglen - 1);
 }
 
 #define HASH_MAX_DIGESTSIZE 64	/* kernel HASH_MAX_DIGESTSIZE is 64 bytes */
@@ -710,8 +732,9 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 		return -1;
 }
 
-int verify_hash(const char *file, const unsigned char *hash, int size,
-		unsigned char *sig, int siglen)
+int verify_hash2(void *public_keys, const char *file,
+		 const unsigned char *hash, int size,
+		 unsigned char *sig, int siglen)
 {
 	/* Get signature type from sig header */
 	if (sig[1] == DIGSIG_VERSION_1) {
@@ -730,15 +753,29 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
 		return -1;
 #endif
 	} else if (sig[1] == DIGSIG_VERSION_2) {
-		return verify_hash_v2(file, hash, size, sig, siglen);
+		return verify_hash_v2(public_keys, file, hash, size,
+				      sig, siglen);
 	} else if (sig[1] == DIGSIG_VERSION_3) {
-		return verify_hash_v3(file, hash, size, sig, siglen);
+		return verify_hash_v3(public_keys, file, hash, size,
+				      sig, siglen);
 	} else
 		return -1;
 }
 
-int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
-			 unsigned char *digest, int digestlen)
+/*
+ * Global static variables are not concurrency-safe.
+ *
+ * Deprecate verify_hash() usage.
+ */
+int verify_hash(const char *file, const unsigned char *hash, int size,
+		unsigned char *sig, int siglen)
+{
+	return verify_hash2(g_public_keys, file, hash, size, sig, siglen);
+}
+
+int ima_verify_signature2(void *public_keys, const char *file,
+			  unsigned char *sig, int siglen,
+			  unsigned char *digest, int digestlen)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
@@ -766,14 +803,27 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	 * measurement list, not by calculating the local file digest.
 	 */
 	if (digest && digestlen > 0)
-		return verify_hash(file, digest, digestlen, sig, siglen);
+		return verify_hash2(public_keys, file, digest, digestlen,
+				   sig, siglen);
 
 	hashlen = ima_calc_hash(file, hash);
 	if (hashlen <= 1)
 		return hashlen;
 	assert(hashlen <= sizeof(hash));
 
-	return verify_hash(file, hash, hashlen, sig, siglen);
+	return verify_hash2(public_keys, file, hash, hashlen, sig, siglen);
+}
+
+/*
+ * Global static variables are not concurrency-safe.
+ *
+ * Deprecate ima_verify_signature() usage.
+ */
+int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
+			 unsigned char *digest, int digestlen)
+{
+	return ima_verify_signature2(g_public_keys, file, sig, siglen,
+				     digest, digestlen);
 }
 
 #if CONFIG_SIGV1
-- 
2.39.3


