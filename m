Return-Path: <linux-integrity+bounces-656-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD082489A
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC581C21FCB
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74BC2C192;
	Thu,  4 Jan 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F9BeqPoa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB52C18E
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404HiXsm014399
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d7zCtbYd/2xv5VX6iTrP/eRg8kiNh9DwFdCsbfFTWb4=;
 b=F9BeqPoaRL0mCrfRSihtwBjwcye0F6ncW7L4eZDQ34W6KblTvuI+jmeebRJWBNUrAj4m
 +U7ioFws5mSGziZP62uvtT5YaWKKFvbgPZelExJ7uDlwiraZM3GXseEcgvjED9GCkkbN
 a7+7WY7Rcq9c5P6msfWxArHPgDutAQb07uJm4N0Lxqt5shPFM9954MYbX1F0LsqT5woV
 Yvv6FWdq1cxewjYuaiSBGuN7bc9D1fsWNgTY6jH7CqqjYwHBaM6iGIBCorCPXmW881kb
 LEsLP9hK5AUCxmmXUiMMea+ArIfDZ3UKPBBxpH9P9TI4eCTej/gITT9yiVJxReUiW0So cw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve13xk4vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404Ii7I1017830
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vawx037yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J68JI58196362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FF092004B;
	Thu,  4 Jan 2024 19:06:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC54F20040;
	Thu,  4 Jan 2024 19:06:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:07 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 03/13] Update library function definitions to include a "public_keys" parameter
Date: Thu,  4 Jan 2024 14:05:48 -0500
Message-Id: <20240104190558.3674008-4-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: HZlptHhN_F9K2Np9rmr2N_5Y6sAfhGoD
X-Proofpoint-ORIG-GUID: HZlptHhN_F9K2Np9rmr2N_5Y6sAfhGoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040149

Instead of relying on a global static "public_keys" variable, which is
not concurrency-safe, update static library function definitions to
include it as a parameter, define new library functions with it as
a parameter, and deprecate existing functions.

Define imaevm_init_public_keys(), imaevm_verify_hash(), and
ima_verify_signature2() functions. Update static function definitions
to include "public_keys".

To avoid library incompatibility, make the existing functions -
init_public_keys(), verify_hash(), ima_verify_signature() - wrappers
for the new function versions.

Deprecate init_public_keys(), verify_hash(), ima_verify_signature()
functions.

Allow suppressing just the libimevm deprecate warnings by enabling
IMAEVM_SUPPRESS_DEPRECATED.
    e.g. configure CFLAGS="-DIMAEVM_SUPPRESS_DEPRECATED"

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    | 21 +++++++++++--
 src/libimaevm.c | 82 ++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 64f7db79b33a..4fd421f5cd1d 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -232,6 +232,12 @@ struct RSA_ASN1_template {
 #define	NUM_PCRS 24
 #define DEFAULT_PCR 10
 
+#ifdef IMAEVM_SUPPRESS_DEPRECATED
+#define IMAEVM_DEPRECATED
+#else
+#define IMAEVM_DEPRECATED __attribute__ ((deprecated))
+#endif
+
 extern struct libimaevm_params imaevm_params;
 struct public_key_entry;
 
@@ -248,9 +254,18 @@ int key2bin(RSA *key, unsigned char *pub);
 uint32_t imaevm_read_keyid(const char *certfile);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
-int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
-int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
-void init_public_keys(const char *keyfiles);
+IMAEVM_DEPRECATED int verify_hash(const char *file, const unsigned char *hash,
+				  int size, unsigned char *sig, int siglen);
+IMAEVM_DEPRECATED int ima_verify_signature(const char *file, unsigned char *sig,
+					   int siglen, unsigned char *digest,
+					   int digestlen);
+IMAEVM_DEPRECATED void init_public_keys(const char *keyfiles);
+
+int ima_verify_signature2(struct public_key_entry *public_keys, const char *file,
+			  unsigned char *sig, int siglen,
+			  unsigned char *digest, int digestlen);
+int imaevm_init_public_keys(const char *keyfiles,
+			    struct public_key_entry **public_keys);
 void imaevm_free_public_keys(struct public_key_entry *public_keys);
 int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 61f91df02460..9cc83e071610 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -372,12 +372,13 @@ struct public_key_entry {
 };
 static struct public_key_entry *g_public_keys = NULL;
 
-static EVP_PKEY *find_keyid(uint32_t keyid)
+static EVP_PKEY *find_keyid(struct public_key_entry *public_keys,
+			    uint32_t keyid)
 {
-	struct public_key_entry *entry, *tail = g_public_keys;
+	struct public_key_entry *entry, *tail = public_keys;
 	int i = 1;
 
-	for (entry = g_public_keys; entry; entry = entry->next) {
+	for (entry = public_keys; entry; entry = entry->next) {
 		if (entry->keyid == keyid)
 			return entry->key;
 		i++;
@@ -394,7 +395,7 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
 	if (tail)
 		tail->next = entry;
 	else
-		g_public_keys = entry;
+		public_keys = entry;
 	log_err("key %d: %x (unknown keyid)\n", i, __be32_to_cpup(&keyid));
 	return 0;
 }
@@ -412,7 +413,8 @@ void imaevm_free_public_keys(struct public_key_entry *public_keys)
 	}
 }
 
-void init_public_keys(const char *keyfiles)
+int imaevm_init_public_keys(const char *keyfiles,
+			    struct public_key_entry **public_keys)
 {
 	struct public_key_entry *entry;
 	char *tmp_keyfiles, *keyfiles_free;
@@ -420,6 +422,11 @@ void init_public_keys(const char *keyfiles)
 	int err = 0;
 	int i = 1;
 
+	if (!public_keys)
+		return -EINVAL;
+
+	*public_keys = NULL;
+
 	tmp_keyfiles = strdup(keyfiles);
 	keyfiles_free = tmp_keyfiles;
 
@@ -444,12 +451,19 @@ void init_public_keys(const char *keyfiles)
 		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
-		entry->next = g_public_keys;
-		g_public_keys = entry;
+		entry->next = *public_keys;
+		*public_keys = entry;
 	}
+
 	free(keyfiles_free);
 	if (err < 0)
-		imaevm_free_public_keys(g_public_keys);
+		imaevm_free_public_keys(*public_keys);
+	return err;
+}
+
+void init_public_keys(const char *keyfiles)
+{
+	imaevm_init_public_keys(keyfiles, &g_public_keys);
 }
 
 /*
@@ -466,7 +480,8 @@ void init_public_keys(const char *keyfiles)
  *
  * (Note: signature_v2_hdr struct does not contain the 'type'.)
  */
-static int verify_hash_common(const char *file, const unsigned char *hash,
+static int verify_hash_common(struct public_key_entry *public_keys,
+			      const char *file, const unsigned char *hash,
 			      int size, unsigned char *sig, int siglen)
 {
 	int ret = -1;
@@ -481,7 +496,7 @@ static int verify_hash_common(const char *file, const unsigned char *hash,
 		log_dump(hash, size);
 	}
 
-	pkey = find_keyid(hdr->keyid);
+	pkey = find_keyid(public_keys, hdr->keyid);
 	if (!pkey) {
 		uint32_t keyid = hdr->keyid;
 
@@ -543,11 +558,13 @@ err:
  *
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
-static int verify_hash_v2(const char *file, const unsigned char *hash,
+static int verify_hash_v2(struct public_key_entry *public_keys,
+			  const char *file, const unsigned char *hash,
 			  int size, unsigned char *sig, int siglen)
 {
 	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
-	return verify_hash_common(file, hash, size, sig + 1, siglen - 1);
+	return verify_hash_common(public_keys, file, hash, size,
+				  sig + 1, siglen - 1);
 }
 
 /*
@@ -556,7 +573,8 @@ static int verify_hash_v2(const char *file, const unsigned char *hash,
  *
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
-static int verify_hash_v3(const char *file, const unsigned char *hash,
+static int verify_hash_v3(struct public_key_entry *public_keys,
+			  const char *file, const unsigned char *hash,
 			  int size, unsigned char *sig, int siglen)
 {
 	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
@@ -567,7 +585,8 @@ static int verify_hash_v3(const char *file, const unsigned char *hash,
 		return ret;
 
 	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
-	return verify_hash_common(file, sigv3_hash, size, sig + 1, siglen - 1);
+	return verify_hash_common(public_keys, file, sigv3_hash, size,
+				  sig + 1, siglen - 1);
 }
 
 #define HASH_MAX_DIGESTSIZE 64	/* kernel HASH_MAX_DIGESTSIZE is 64 bytes */
@@ -710,8 +729,9 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 		return -1;
 }
 
-int verify_hash(const char *file, const unsigned char *hash, int size,
-		unsigned char *sig, int siglen)
+int imaevm_verify_hash(void *public_keys, const char *file,
+		       const unsigned char *hash, int size,
+		       unsigned char *sig, int siglen)
 {
 	/* Get signature type from sig header */
 	if (sig[1] == DIGSIG_VERSION_1) {
@@ -730,15 +750,24 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
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
+int verify_hash(const char *file, const unsigned char *hash, int size,
+		unsigned char *sig, int siglen)
+{
+	return imaevm_verify_hash(g_public_keys, file, hash, size, sig, siglen);
+}
+
+int ima_verify_signature2(struct public_key_entry *public_keys, const char *file,
+			  unsigned char *sig, int siglen,
+			  unsigned char *digest, int digestlen)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
@@ -766,14 +795,23 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	 * measurement list, not by calculating the local file digest.
 	 */
 	if (digest && digestlen > 0)
-		return verify_hash(file, digest, digestlen, sig, siglen);
+		return imaevm_verify_hash(public_keys, file, digest, digestlen,
+					  sig, siglen);
 
 	hashlen = ima_calc_hash(file, hash);
 	if (hashlen <= 1)
 		return hashlen;
 	assert(hashlen <= sizeof(hash));
 
-	return verify_hash(file, hash, hashlen, sig, siglen);
+	return imaevm_verify_hash(public_keys, file, hash, hashlen,
+				  sig, siglen);
+}
+
+int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
+			 unsigned char *digest, int digestlen)
+{
+	return ima_verify_signature2(g_public_keys, file, sig, siglen,
+				     digest, digestlen);
 }
 
 #if CONFIG_SIGV1
-- 
2.39.3


