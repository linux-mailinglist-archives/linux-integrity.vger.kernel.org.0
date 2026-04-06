Return-Path: <linux-integrity+bounces-9130-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBAyIIX50mkXcwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9130-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 02:08:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B053A0CA3
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 02:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 919333001383
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2026 00:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89FD40DFA3;
	Mon,  6 Apr 2026 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sSJXnDdU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1E15E8B
	for <linux-integrity@vger.kernel.org>; Mon,  6 Apr 2026 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775434112; cv=none; b=RF3wWXWb5BekbSPDEONQtR0j+6zDNIS+XYHGs4IjKeBc93RjOJKF+sHoGZOtRoLfXhIbPmmf+t2RL8C7VRp71FeJc7siayq1FZq/jvRPl3kigwwAy2DHyUb4jdO8fMebTRG1UK4g91wnuSbsWF6Z+1mlHKwGBaOH5IZNy65uECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775434112; c=relaxed/simple;
	bh=ktx3IzBN3K7pgp4/NAfjrhcqSogqh6ARDpJKXuaOoUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIvfKxOjiNwtNxu3rVtH9xMULSQvLcSPguyo6LB6Glcx7ePNkByLqTupZF5GwpnGN/YgqEyN23srDmKPVafySUER5o3BgXwbjxae6lqIEZXztCwOg94JrN3Kew2o2cu3qWQc6WzwDoYDfOnLDstO2mDCqdbp64QyM0r6sKm4ByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sSJXnDdU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635DorN92775034;
	Mon, 6 Apr 2026 00:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8RM2bpux8wWJ4tWfL
	cOWoZpfgwDTJJ2+Ob1X/aid2is=; b=sSJXnDdUVCvLdIKqZnOLgWNlLNQ6V1zow
	aY5SNnrUMpWpZDy/CyMIHZLYunuond2xoWkuMN0XGhttG9U6Ayvp4iGKHBGkEXK2
	INXlD/NISZ8hsXTue8IF3nEWkEQ+uw4Rta/TEtG/C5P1JSXKv+si8l9P+r5mM95b
	GzTSI3I/KpzXYnx3DFcCoVDC8qL/WGApfxQ2n4vSiGrZn9QYJZcNwteWQDJZyzZJ
	O2hdAso+FjJ8h5V7mUSEhkMlDtEAJqVz+kl4vU0YeKT8/MY17kaoqsZ8KLFzWCzq
	HuUiXc9B57WWwS6r23r7suaVITSA9bM4vRBpZPjwetV//by+pfvMQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap4m30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635Hm2ON006378;
	Mon, 6 Apr 2026 00:08:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbfp1jjp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 00:08:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63608IYt24904272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 00:08:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2ADC5805D;
	Mon,  6 Apr 2026 00:08:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5257058057;
	Mon,  6 Apr 2026 00:08:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 00:08:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, ebiggers@kernel.org,
        coxu@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 3/5] Support signing with ML-DSA keys when OpenSSL >=3.5 is available
Date: Sun,  5 Apr 2026 20:08:08 -0400
Message-ID: <20260406000810.4013201-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406000810.4013201-1-stefanb@linux.ibm.com>
References: <20260406000810.4013201-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d2f974 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jdpBqLYSq3f7ShB8L4wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDI0NyBTYWx0ZWRfX70H6jOPbxGtM
 9JFQg4SG5KWQqEkLXQrAGf7/mgw6WyI9crhynhZqoe1TobCFOxiqfnicqLfMm4+8ClItyt5SQJI
 dpbNr6imf7EtetTtUgF7O/0mhAV/SVIyykMfgkx+l/SvpeYRt2lfJFFHL9/y/RyhlOgxpBHiF3K
 Gzk3hy+vf5MYeOR5unv3vdZqOTQDzFm+WEm5jic1bJB4IO6hLxiFEKKJHzw3OQE7CbrPrP9U6ev
 Dp+kkXZ2FXbCKQyIGYBmS8+LhXX4qn96lWDAfVJnEu4R+dbMFha8TZVa5xW3Zy0T4NCDS6SVqAM
 +o2p4ZECs60lhdPERx86LzG/gW7oia6luN7qvG/VMNoj9KHhP2k2FUrUXVZyAUPLO/9auuEQ7m5
 rqWmsJN1m6HIuNOSNGzdEuVRJyNdt5mYrS8t17XXJE+nNaARY3O8OeSVJ2bHyvYbb4YO/b8hBqL
 UMBiXzEEUsTaV2J4vXQ==
X-Proofpoint-GUID: eyP4eHkkpAwks3Op-yv-g7FghDPc3nTC
X-Proofpoint-ORIG-GUID: eyP4eHkkpAwks3Op-yv-g7FghDPc3nTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_08,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050247
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9130-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 88B053A0CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OpenSSL >= v3.5.0 supports signing with ML-DSA-44/65/87. Add support for
it to the imaevm_create_sigv3 library function. Since the ML-DSA signatures
require a lot more space for the signature now, increase the size of the
array where the signatures are stored. The following are the sizes of
ML-DSA signatures by key type:

- ML-DSA-44: 2420
- ML-DSA-65: 3309
- ML-DSA-87: 4627

Prevent signature V2 from being created with any other key types than
'RSA', 'EC', 'GOST' (ECRDSA), or 'SM2'.

In the functions that created a v2 signature, only RSA, ECDSA, and ECRDSA
signatures are created and they can easily work with the old buffer size of
less than 1024 bytes.

The size available for extended attributes may be smaller than what is
required by the ML-DSA signature size, and therefore may not be possible
to store for example ML-DSA-87 signatures (depends on type of filesystem).
Nevertheless, extend the MAX_SIGNATURE_SIZE to the required size of
ML-DSA-87 and display an error if writing the signature of a size larger
than 4k did not work.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README          |   3 +-
 src/evmctl.c    |   4 +
 src/imaevm.h    |   5 +-
 src/libimaevm.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 258 insertions(+), 12 deletions(-)

diff --git a/README b/README
index 34dfddf..1b0be4c 100644
--- a/README
+++ b/README
@@ -153,7 +153,8 @@ in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabl
 
 For v2 and v3 signatures x509 certificate (containing the public key) could be appended to the
 private key (they both are in PEM format) to automatically extract keyid from its Subject
-Key Identifier (SKID).
+Key Identifier (SKID). v3 signatures can be created with the --v3 option. This signature format
+is required for signing with ML-DSA keys.
 
 Integrity keyrings
 ----------------
diff --git a/src/evmctl.c b/src/evmctl.c
index c8da495..44b52f6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -617,6 +617,10 @@ static int sign_evm(const char *file, char *hash_algo, const char *key)
 		if (err < 0) {
 			log_errno_reset(LOG_ERR, "Setting EVM xattr failed: %s",
 					file);
+			if (len >= 4096)
+				log_err("The signature with %zu bytes is likely too large for the file "
+					"extended attribute. Consider using a different key type.\n",
+					len);
 			return err;
 		}
 	}
diff --git a/src/imaevm.h b/src/imaevm.h
index 5a8441b..a098ee3 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -74,8 +74,11 @@ typedef struct ossl_provider_st OSSL_PROVIDER;
 #define	DATA_SIZE	4096
 #define SHA1_HASH_LEN   20
 
+#define ML_DSA_87_SIGNATURE_SIZE	4627
+
 #define MAX_DIGEST_SIZE		64
-#define MAX_SIGNATURE_SIZE	1024
+#define MAX_SIGNATURE_SIZE	(1 + sizeof(struct signature_v2_hdr) + \
+				 ML_DSA_87_SIGNATURE_SIZE)
 
 /*
  * The maximum template data size is dependent on the template format. For
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 49bfb62..d26074e 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -37,6 +37,9 @@
 #include <openssl/x509.h>
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
+#if OPENSSL_VERSION_NUMBER >= 0x30000000
+#include <openssl/core_names.h>
+#endif
 
 #if CONFIG_IMA_EVM_ENGINE
 #include <openssl/engine.h>
@@ -81,8 +84,25 @@ struct libimaevm_params imaevm_params = {
 	.hash_algo = DEFAULT_HASH_ALGO,
 };
 
+#define HASH_MAX_DIGESTSIZE 64	/* kernel HASH_MAX_DIGESTSIZE is 64 bytes */
+
+struct ima_file_id {
+	__u8 hash_type;		/* xattr type [enum evm_ima_xattr_type] */
+	__u8 hash_algorithm;	/* Digest algorithm [enum hash_algo] */
+	__u8 hash[HASH_MAX_DIGESTSIZE];
+} __packed;
+
 static void __attribute__ ((constructor)) libinit(void);
 
+/* RSA, ECDSA, ECDRSA, and SM2 all use hashes for signing */
+static inline bool keytype_uses_hash_for_signing(const char *keytype)
+{
+	return strcmp("RSA", keytype) == 0 ||
+		strcmp("EC", keytype) == 0 ||
+		strncmp("GOST2012_", keytype, 9) == 0 ||
+		strcmp("SM2", keytype) == 0;
+}
+
 void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool newline)
 {
 	int i;
@@ -460,6 +480,77 @@ void init_public_keys(const char *keyfiles)
 	imaevm_init_public_keys(keyfiles, &g_public_keys);
 }
 
+#if OPENSSL_VERSION_NUMBER >= 0x30500000
+static int verify_hashless(EVP_PKEY *pkey,
+			   const char *algo,
+			   const unsigned char *hash, int hash_size,
+			   unsigned char *sig, int siglen,
+			   enum evm_ima_xattr_type type,
+			   const char *file)
+{
+	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
+	struct ima_file_id file_id = { .hash_type = type, };
+	const char *keytype = EVP_PKEY_get0_type_name(pkey);
+	uint8_t *data = (uint8_t *)&file_id;
+	EVP_SIGNATURE *sig_alg = NULL;
+	unsigned int unused;
+	EVP_PKEY_CTX *ctx;
+	int hash_algo;
+	const char *st;
+	int ret = -1;
+
+	if (!algo) {
+		log_err("Hash algorithm unspecified\n");
+		return -EINVAL;
+	}
+
+	hash_algo = imaevm_get_hash_algo(algo);
+	if (hash_algo < 0) {
+		log_err("Hash algorithm %s not supported\n", algo);
+		return -EINVAL;
+	}
+	file_id.hash_algorithm = hash_algo;
+
+	memcpy(file_id.hash, hash, hash_size);
+	unused = HASH_MAX_DIGESTSIZE - hash_size;
+
+	st = "EVP_PKEY_CTX_new";
+	ctx = EVP_PKEY_CTX_new(pkey, NULL);
+	if (!ctx)
+		goto err;
+	st = "EVP_SIGNATURE_fetch";
+	sig_alg = EVP_SIGNATURE_fetch(NULL, keytype, NULL);
+	if (!sig_alg)
+		goto err;
+	st = "EVP_PKEY_verify_message_init";
+	if (!EVP_PKEY_verify_message_init(ctx, sig_alg, NULL))
+		goto err;
+	st = "EVP_PKEY_verify";
+	ret = EVP_PKEY_verify(ctx, sig + sizeof(*hdr),
+			      siglen - sizeof(*hdr),
+			      data, sizeof(file_id) - unused);
+	if (ret == 1) {
+		ret = 0;
+	} else if (ret == 0) {
+		log_err("%s: verification failed: %d (%s)\n",
+			file, ret, ERR_reason_error_string(ERR_get_error()));
+		output_openssl_errors();
+		ret = 1;
+	}
+err:
+	if (ret < 0 || ret > 1) {
+		log_err("%s: verification failed: %d (%s) in %s\n",
+			file, ret, ERR_reason_error_string(ERR_peek_error()),
+			st);
+		output_openssl_errors();
+		ret = -1;
+	}
+	EVP_SIGNATURE_free(sig_alg);
+	EVP_PKEY_CTX_free(ctx);
+	return ret;
+}
+#endif
+
 /*
  * Verify a signature, prefixed with the signature_v2_hdr, either based
  * directly or indirectly on the file data hash.
@@ -577,6 +668,28 @@ static int verify_hash_v3(struct public_key_entry *public_keys,
 {
 	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
 	int ret;
+#if OPENSSL_VERSION_NUMBER >= 0x30500000
+	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)(sig + 1);
+	const char *keytype;
+	EVP_PKEY *pkey; // do not free here
+
+	pkey = find_keyid(public_keys, hdr->keyid);
+	if (!pkey) {
+		uint32_t keyid = hdr->keyid;
+
+		if (imaevm_params.verbose > LOG_INFO)
+			log_info("%s: verification failed: unknown keyid %x\n",
+				 file, __be32_to_cpup(&keyid));
+		return -1;
+	}
+
+	keytype = EVP_PKEY_get0_type_name(pkey);
+
+	if (keytype && !keytype_uses_hash_for_signing(keytype))
+		return verify_hashless(pkey, hash_algo,
+				       hash, size, sig + 1, siglen - 1,
+				       sig[0], file);
+#endif
 
 	ret = calc_hash_sigv3(sig[0], hash_algo, hash, sigv3_hash);
 	if (ret < 0)
@@ -587,14 +700,6 @@ static int verify_hash_v3(struct public_key_entry *public_keys,
 				  size, sig + 1, siglen - 1);
 }
 
-#define HASH_MAX_DIGESTSIZE 64	/* kernel HASH_MAX_DIGESTSIZE is 64 bytes */
-
-struct ima_file_id {
-	__u8 hash_type;		/* xattr type [enum evm_ima_xattr_type] */
-	__u8 hash_algorithm;	/* Digest algorithm [enum hash_algo] */
-	__u8 hash[HASH_MAX_DIGESTSIZE];
-} __packed;
-
 /*
  * Calculate the signature format version 3 hash based on the portion
  * of the ima_file_id structure used, not the entire structure.
@@ -1292,7 +1397,7 @@ out:
 #endif /* CONFIG_SIGV1 */
 
 /*
- * @sig is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
+ * @sig is assumed to be of at least (1024 - 1) size
  * Return: -1 signing error, >0 length of signature
  */
 static int sign_hash_v2(const char *algo, const unsigned char *hash,
@@ -1306,6 +1411,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	EVP_PKEY *pkey;
 	char name[20];
 	EVP_PKEY_CTX *ctx = NULL;
+	const char *keytype;
 	const EVP_MD *md;
 	size_t sigsize;
 	const char *st;
@@ -1337,6 +1443,15 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	if (!pkey)
 		return -1;
 
+#if OPENSSL_VERSION_NUMBER >= 0x30000000
+	keytype = EVP_PKEY_get0_type_name(pkey);
+	/* if it's neither an RSA, EC(R)DSA, nor SM2 key then it cannot be used here */
+	if (keytype && !keytype_uses_hash_for_signing(keytype)) {
+		log_err("sign_hash_v2: Cannot use '%s' type of key\n", keytype);
+		return -1;
+	}
+#endif
+
 	hdr = (struct signature_v2_hdr *)sig;
 	hdr->version = (uint8_t) DIGSIG_VERSION_2;
 
@@ -1379,7 +1494,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
 		goto err;
 	st = "EVP_PKEY_sign";
-	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
+	sigsize = 1024 - sizeof(struct signature_v2_hdr) - 1;
 	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
 		goto err;
 	len = (int)sigsize;
@@ -1451,6 +1566,106 @@ int imaevm_signhash(const char *hashalgo, const unsigned char *hash, int size,
 			    access_info, keyid);
 }
 
+#if OPENSSL_VERSION_NUMBER >= 0x30500000
+static int create_sigv3_hashless(EVP_PKEY *pkey, const char *algo,
+				 const unsigned char *hash, int hash_size,
+				 unsigned char **sig, size_t siglen,
+				 enum evm_ima_xattr_type type,
+				 const struct imaevm_ossl_access *access_info,
+				 uint32_t keyid)
+{
+	const char *keytype = EVP_PKEY_get0_type_name(pkey);
+	struct ima_file_id file_id = { .hash_type = type, };
+	uint8_t *data = (uint8_t *)&file_id;
+	EVP_SIGNATURE *sig_alg = NULL;
+	struct signature_v2_hdr *hdr;
+	EVP_PKEY_CTX *ctx = NULL;
+	bool allocated = false;
+	unsigned int unused;
+	size_t slen = -1;
+	const char *st;
+	int hash_algo;
+	char name[20];
+
+	hash_algo = imaevm_get_hash_algo(algo);
+	if (hash_algo < 0) {
+		log_err("Hash algorithm %s not supported\n", algo);
+		return -EINVAL;
+	}
+	file_id.hash_algorithm = hash_algo;
+	memcpy(file_id.hash, hash, hash_size);
+	unused = HASH_MAX_DIGESTSIZE - hash_size;
+
+	st = "EVP_PKEY_CTX_new";
+	ctx = EVP_PKEY_CTX_new(pkey, NULL);
+	if (!ctx)
+		goto err;
+	st = "EVP_SIGNATURE_fetch";
+	sig_alg = EVP_SIGNATURE_fetch(NULL, keytype, NULL);
+	if (!sig_alg)
+		goto err;
+	st = "EVP_PKEY_sign_init";
+	if (!EVP_PKEY_sign_message_init(ctx, sig_alg, NULL))
+		goto err;
+	st = "EVP_PKEY_sign";
+	/* query for size of signature */
+	if (!EVP_PKEY_sign(ctx, NULL, &slen,
+			   data, sizeof(file_id) - unused)) {
+		slen = -1;
+		goto err;
+	}
+
+	if (*sig) {
+		if (siglen < (1 + sizeof(*hdr) + slen)) {
+			siglen = -1;
+			goto err;
+		}
+	} else {
+		*sig = malloc(1 + sizeof(*hdr) + slen);
+		if (!*sig) {
+			siglen = -1;
+			goto err;
+		}
+		allocated = true;
+	}
+	hdr = (struct signature_v2_hdr *)(*sig + 1);
+
+	if (!EVP_PKEY_sign(ctx, hdr->sig, &slen,
+			   data, sizeof(file_id) - unused)) {
+		slen = -1;
+		goto err;
+	}
+
+	(*sig)[0] = type;
+	hdr->version = DIGSIG_VERSION_3;
+	hdr->hash_algo = hash_algo;
+	if (keyid)
+		keyid = htonl(keyid);
+	else
+		calc_keyid_v2(&keyid, name, pkey);
+	hdr->keyid = keyid;
+	hdr->sig_size = __cpu_to_be16(slen);
+
+	siglen = 1 + sizeof(*hdr) + slen;
+	log_info("evm/ima signature: %zu bytes\n", siglen);
+
+err:
+	EVP_SIGNATURE_free(sig_alg);
+	EVP_PKEY_CTX_free(ctx);
+	if (slen == -1) {
+		if (allocated) {
+			free(*sig);
+			*sig = NULL;
+		}
+		log_err("create_sigv3_mldsa signing failed: (%s) in %s\n",
+			ERR_reason_error_string(ERR_peek_error()), st);
+		output_openssl_errors();
+		return -1;
+	}
+	return siglen;
+}
+#endif
+
 /*
  * Create a v3 signature given a file hash
  *
@@ -1482,6 +1697,29 @@ int imaevm_create_sigv3(const char *hash_algo, const unsigned char *hash, int si
 	/* buffer capable of holding (more than) RSA-4096 signature; */
 	unsigned char sigbuf[1024];
 	int len, slen, err;
+#if OPENSSL_VERSION_NUMBER >= 0x30500000
+	const char *keytype;
+	EVP_PKEY *pkey;
+
+	if (access_info) {
+		err = check_ossl_access(access_info);
+		if (err)
+			return err;
+	}
+	pkey = read_priv_pkey(keyfile, keypass, access_info, keyid);
+	if (!pkey)
+		return -1;
+
+	keytype = EVP_PKEY_get0_type_name(pkey);
+	if (keytype && strncmp("ML-DSA-", keytype, 7) == 0) {
+		slen = create_sigv3_hashless(pkey, hash_algo, hash, size,
+					     sig, siglen,
+					     xattr_type, access_info, keyid);
+		EVP_PKEY_free(pkey);
+		return slen;
+	}
+	EVP_PKEY_free(pkey);
+#endif
 
 	len = calc_hash_sigv3(xattr_type, hash_algo, hash, sigv3_hash);
 	if (len < 0 || len == 1) {
-- 
2.53.0


