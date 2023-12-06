Return-Path: <linux-integrity+bounces-362-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3129A80789C
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F181F211B9
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C72747F4B;
	Wed,  6 Dec 2023 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BilgJtll"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFE810DB
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:12 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6I7fX9000648
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q0TQvS5giH2eMtSjixVKfys0qaLCDsaZAWzf+A3JdNw=;
 b=BilgJtllXg4Obht4TnxxsHUHnw8SrmAi7oCDF2x5TzrFsK9SVZPvcc5I7XUqw/V+m9Hk
 2hWCUGOLTQ2KYjTR1Y9/3tmH+heHDZDoXjVPMDaZc4EHzlv/lECdNvOg4MHRdB4c7NUz
 WhBFYM33DwyN6UVsn2A61slDEiBuOTWrww8zdqfkAua6NjClBXqxxAD4q6dGdfkFb8QT
 c4iM+oiHde9+rUtda1FhYQJSaC+kBqUKVHj/4E6USk01sLx3q8xGL6w4uiQu+q1CTTRJ
 RqmZcU5Fnw1T5pzGtECAdPXLcnXToPzRX8tZxJy5MQJE/dQRRyHdyQhQKRAzKzjkCIVx RQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utwm5ap3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:11 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6ITDVT013743
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utau46jtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JS72w12518070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D567E2004B;
	Wed,  6 Dec 2023 19:28:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED2DC20040;
	Wed,  6 Dec 2023 19:28:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:06 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 03/13] Update library function definitions to include a "public_keys" parameter
Date: Wed,  6 Dec 2023 14:27:24 -0500
Message-Id: <20231206192734.339999-4-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: IfGDGMX8nwL8FH-assGpi_nfi91-X24A
X-Proofpoint-GUID: IfGDGMX8nwL8FH-assGpi_nfi91-X24A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

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

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/imaevm.h    |  4 +++
 src/libimaevm.c | 85 ++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 470e8376f2fb..b29a4745fc77 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -249,8 +249,12 @@ uint32_t imaevm_read_keyid(const char *certfile);
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
+int ima_verify_signature2(void *public_keys, const char *file,
+			  unsigned char *sig, int siglen,
+			  unsigned char *digest, int digestlen);
 void imaevm_free_public_keys(void *public_keys);
 void init_public_keys(const char *keyfiles);
+int imaevm_init_public_keys(const char *keyfiles, void **public_keys);
 int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
 int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo, const unsigned char *in_hash, unsigned char *out_hash);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 534468fe99ca..6fecb2ffd139 100644
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
+		public_keys = (void *)entry;
 	log_err("key %d: %x (unknown keyid)\n", i, __be32_to_cpup(&keyid));
 	return 0;
 }
@@ -412,7 +413,7 @@ void imaevm_free_public_keys(void *public_keys)
 	}
 }
 
-void init_public_keys(const char *keyfiles)
+int imaevm_init_public_keys(const char *keyfiles, void **public_keys)
 {
 	struct public_key_entry *entry;
 	char *tmp_keyfiles, *keyfiles_free;
@@ -420,6 +421,11 @@ void init_public_keys(const char *keyfiles)
 	int err = 0;
 	int i = 1;
 
+	if (!public_keys)
+		return -EINVAL;
+
+	*public_keys = NULL;
+
 	tmp_keyfiles = strdup(keyfiles);
 	keyfiles_free = tmp_keyfiles;
 
@@ -444,12 +450,19 @@ void init_public_keys(const char *keyfiles)
 		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
-		entry->next = g_public_keys;
-		g_public_keys = entry;
+		entry->next = (struct public_key_entry *)*public_keys;
+		*public_keys = (void *)entry;
 	}
+
 	free(keyfiles_free);
 	if (err < 0)
-		imaevm_free_public_keys(g_public_keys);
+		imaevm_free_public_keys(public_keys);
+	return err;
+}
+
+__attribute__((deprecated)) void init_public_keys(const char *keyfiles)
+{
+	imaevm_init_public_keys(keyfiles, (void **)&g_public_keys);
 }
 
 /*
@@ -466,7 +479,8 @@ void init_public_keys(const char *keyfiles)
  *
  * (Note: signature_v2_hdr struct does not contain the 'type'.)
  */
-static int verify_hash_common(const char *file, const unsigned char *hash,
+static int verify_hash_common(struct public_key_entry *public_keys,
+			      const char *file, const unsigned char *hash,
 			      int size, unsigned char *sig, int siglen)
 {
 	int ret = -1;
@@ -481,7 +495,7 @@ static int verify_hash_common(const char *file, const unsigned char *hash,
 		log_dump(hash, size);
 	}
 
-	pkey = find_keyid(hdr->keyid);
+	pkey = find_keyid(public_keys, hdr->keyid);
 	if (!pkey) {
 		uint32_t keyid = hdr->keyid;
 
@@ -543,11 +557,13 @@ err:
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
@@ -556,7 +572,8 @@ static int verify_hash_v2(const char *file, const unsigned char *hash,
  *
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
-static int verify_hash_v3(const char *file, const unsigned char *hash,
+static int verify_hash_v3(struct public_key_entry *public_keys,
+			  const char *file, const unsigned char *hash,
 			  int size, unsigned char *sig, int siglen)
 {
 	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
@@ -567,7 +584,8 @@ static int verify_hash_v3(const char *file, const unsigned char *hash,
 		return ret;
 
 	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
-	return verify_hash_common(file, sigv3_hash, size, sig + 1, siglen - 1);
+	return verify_hash_common(public_keys, file, sigv3_hash, size,
+				  sig + 1, siglen - 1);
 }
 
 #define HASH_MAX_DIGESTSIZE 64	/* kernel HASH_MAX_DIGESTSIZE is 64 bytes */
@@ -710,8 +728,9 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
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
@@ -730,15 +749,25 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
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
+__attribute__((deprecated)) int verify_hash(const char *file,
+					    const unsigned char *hash, int size,
+					    unsigned char *sig, int siglen)
+{
+	return imaevm_verify_hash(g_public_keys, file, hash, size, sig, siglen);
+}
+
+int ima_verify_signature2(void *public_keys, const char *file,
+			  unsigned char *sig, int siglen,
+			  unsigned char *digest, int digestlen)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
@@ -766,14 +795,26 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
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
+__attribute__((deprecated)) int ima_verify_signature(const char *file,
+						     unsigned char *sig,
+						     int siglen,
+						     unsigned char *digest,
+						     int digestlen)
+{
+	return ima_verify_signature2(g_public_keys, file, sig, siglen,
+				     digest, digestlen);
 }
 
 #if CONFIG_SIGV1
-- 
2.39.3


