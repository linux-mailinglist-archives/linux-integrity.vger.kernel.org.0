Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6B54FD6E
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jun 2022 21:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiFQTVr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jun 2022 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiFQTVr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jun 2022 15:21:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AF85131C
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jun 2022 12:21:45 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HIkYX5004336;
        Fri, 17 Jun 2022 19:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ow0N0avEVhi2+e4D85aut05TR1gpnB8TWP752TPd8L8=;
 b=ETIgNzU/XJk4F5TBLOV4LrF5kt4OJOmLkTH2CikYLIqi3qNf/D6L/u0VQfq2+wgoVOVs
 Zeny8wUF50WiNaNKW8KR3C8NTBjnnPY3eNR1iuVbjW2zLRkn+jH8hlGq/lPGmIUY0z9S
 JXhH0yFTTVJxDzCy2J4J6fVkbpSdc6kijGRlkW7nNEzoMtPK8wxWXxylyDWNniqXHG+m
 gXWfG2zrAZXRZ1BkD5nNfupv48thtHtzBGBY97MEAFIOYvb8SrIGLr9GqaOCA2qCGx62
 jUkwgpZUAuPuU/sW082d1sK+7rfr1kjaKxVMQgRTNOykEaSRZCKRobhsuNvLqo8MgA4k 5Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gry6h8qvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 19:21:36 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25HJ6sR0023025;
        Fri, 17 Jun 2022 19:21:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjajh807-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 19:21:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25HJLZYN22544706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 19:21:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 349E1A4040;
        Fri, 17 Jun 2022 19:21:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91117A4051;
        Fri, 17 Jun 2022 19:21:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.64.10])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jun 2022 19:21:30 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 ima-evm-utils 2/3] Sign an fs-verity file digest
Date:   Fri, 17 Jun 2022 15:21:06 -0400
Message-Id: <20220617192107.270865-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220617192107.270865-1-zohar@linux.ibm.com>
References: <20220617192107.270865-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 60VmgLoq6yU0UEceR99IvqZv7VLQ5L-N
X-Proofpoint-GUID: 60VmgLoq6yU0UEceR99IvqZv7VLQ5L-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_13,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Sign fs-verity file digests provided in the format as produced by
"fsverity digest".  The output is of the same format as the input,
but with the file signature appended.  Use setfattr to write the
signature as security.ima xattr.

fsverity digest format: <algo>:<hash> <pathname>
output format: <algo>:<hash> <pathname> <signature>

Instead of directly signing the fsverity hash, to disambiguate the
original IMA signatures from the fs-verity signatures stored in the
security.ima xattr a new signature format version 3 (sigv3) was
defined as the hash of the xattr type (enum evm_ima_xattr_type),
the hash algorithm (enum hash_algo), and the hash.

Example:
fsverity digest <pathname> | evmctl sign_hash --veritysig \
 --key <pem encoded private key>

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 README          |  3 +-
 src/evmctl.c    | 99 +++++++++++++++++++++++++++++++++++++++++--------
 src/imaevm.h    |  5 ++-
 src/libimaevm.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+), 17 deletions(-)

diff --git a/README b/README
index 5b5ecb52a74b..ffe46ad75728 100644
--- a/README
+++ b/README
@@ -34,7 +34,7 @@ COMMANDS
  ima_hash file
  ima_measurement [--ignore-violations] [--verify-sig [--key "key1, key2, ..."]]  [--pcrs [hash-algorithm,]file [--pcrs hash-algorithm,file] ...] file
  ima_fix [-t fdsxm] path
- sign_hash [--key key] [--pass password]
+ sign_hash [--veritysig] [--key key] [--pass password]
  hmac [--imahash | --imasig ] file
 
 
@@ -43,6 +43,7 @@ OPTIONS
 
   -a, --hashalgo     sha1, sha224, sha256, sha384, sha512
   -s, --imasig       make IMA signature
+      --veritysig    sign an fs-verity file digest hash
   -d, --imahash      make IMA hash
   -f, --sigfile      store IMA signature in .sig file instead of xattr
       --xattr-user   store xattrs in user namespace (for testing purposes)
diff --git a/src/evmctl.c b/src/evmctl.c
index 101cd407e05d..a8aba65fec4d 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -135,6 +135,7 @@ static int msize;
 static dev_t fs_dev;
 static bool evm_immutable;
 static bool evm_portable;
+static bool veritysig;
 
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
@@ -731,33 +732,97 @@ static int cmd_sign_ima(struct command *cmd)
 	return do_cmd(cmd, sign_ima_file);
 }
 
+/*
+ * Sign file hash(es) provided in the format as produced by either
+ * sha*sum or "fsverity digest".
+ *
+ * sha*sum format: <hash> <pathname>
+ * fsverity digest format: <algo>:<hash> <pathname>
+ *
+ * To disambiguate the resulting file signatures, a new signature format
+ * version 3 (sigv3) was defined as the hash of the xattr type (enum
+ * evm_ima_xattr_type), the hash algorithm (enum hash_algo), and the hash.
+ *
+ * Either directly sign the sha*sum hash or indirectly sign the fsverity
+ * hash (sigv3).
+ *
+ * The output is the same format as the input with the resulting file
+ * signature appended.
+ */
 static int cmd_sign_hash(struct command *cmd)
 {
+	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
+	unsigned char hash[MAX_DIGEST_SIZE];
+	int siglen, algolen = 0, hashlen = 0;
+	char *line = NULL, *token, *hashp;
+	size_t line_len = 0;
 	const char *key;
-	char *token, *line = NULL;
-	int hashlen = 0;
-	size_t line_len;
+	char algo[7];	/* Current maximum fsverity hash algo name length */
 	ssize_t len;
-	unsigned char hash[MAX_DIGEST_SIZE];
-	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
-	int siglen;
+	int ret;
 
 	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
-	/* support reading hash (eg. output of shasum) */
 	while ((len = getline(&line, &line_len, stdin)) > 0) {
 		/* remove end of line */
 		if (line[len - 1] == '\n')
 			line[--len] = '\0';
 
-		/* find the end of the hash */
-		token = strpbrk(line, ", \t");
-		hashlen = token ? token - line : strlen(line);
+		/*
+		 * Before either directly or indirectly signing the hash,
+		 * convert the hex-ascii hash representation to binary.
+		 */
+		if (veritysig) {
+
+			/* split the algorithm from the hash */
+			hashp = strpbrk(line, ":");
+			if (hashp)	/* pointer to the delimiter */
+				algolen = hashp - line;
+
+			if (!hashp || algolen <= 0 ||
+			    algolen >= sizeof(algo)) {
+				log_err("Missing/invalid fsverity hash algorithm\n");
+				continue;
+			}
+
+			strncpy(algo, line, algolen);
+			algo[algolen] = '\0';	/* Nul terminate algorithm */
+
+			hashp++;
+			token = strpbrk(line, ", \t");
+			hashlen = token - hashp;
+			if (hashlen <= 0) {
+				log_err("Missing fsverity hash\n");
+				continue;
+			}
+
+			assert(hashlen / 2 <= sizeof(hash));
+			hex2bin(hash, hashp, hashlen / 2);
+
+			ret = calc_hash_sigv3(IMA_VERITY_DIGSIG, algo, hash,
+					      sigv3_hash);
+			if (ret < 0 || ret == 1) {
+				log_info("Failure to calculate fs-verity hash\n");
+				continue;
+			}
+
+			siglen = sign_hash(algo, sigv3_hash, hashlen / 2,
+					   key, NULL, sig + 1);
+
+			sig[0] = IMA_VERITY_DIGSIG;
+			sig[1] = DIGSIG_VERSION_3;	/* sigv3 */
+		} else {
+			token = strpbrk(line, ", \t");
+			hashlen = token ? token - line : strlen(line);
+			assert(hashlen / 2 <= sizeof(hash));
+			hex2bin(hash, line, hashlen / 2);
+
+			siglen = sign_hash(imaevm_params.hash_algo, hash,
+					   hashlen / 2, key, NULL, sig + 1);
+			sig[0] = EVM_IMA_XATTR_DIGSIG;
+		}
 
-		assert(hashlen / 2 <= sizeof(hash));
-		hex2bin(hash, line, hashlen / 2);
-		siglen = sign_hash(imaevm_params.hash_algo, hash, hashlen / 2,
-				 key, NULL, sig + 1);
 		if (siglen <= 1)
 			return siglen;
 		assert(siglen < sizeof(sig));
@@ -2568,7 +2633,7 @@ struct command cmds[] = {
 	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "[--pcrs hash-algorithm,file] [TPM 1.2 BIOS event log]", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
-	{"sign_hash", cmd_sign_hash, 0, "[--key key] [--pass [password]", "Sign hashes from shaXsum output.\n"},
+	{"sign_hash", cmd_sign_hash, 0, "[--veritysig] [--key key] [--pass password]", "Sign hashes from either shaXsum or \"fsverity digest\" output.\n"},
 #ifdef DEBUG
 	{"hmac", cmd_hmac_evm, 0, "[--imahash | --imasig ] file", "Sign file metadata with HMAC using symmetric key (for testing purpose).\n"},
 #endif
@@ -2608,6 +2673,7 @@ static struct option opts[] = {
 	{"verify-bank", 2, 0, 143},
 	{"keyid", 1, 0, 144},
 	{"keyid-from-cert", 1, 0, 145},
+	{"veritysig", 0, 0, 146},
 	{}
 
 };
@@ -2838,6 +2904,9 @@ int main(int argc, char *argv[])
 			}
 			imaevm_params.keyid = keyid;
 			break;
+		case 146:
+			veritysig = 1;
+			break;
 		case '?':
 			exit(1);
 			break;
diff --git a/src/imaevm.h b/src/imaevm.h
index 0d53a0232ae4..afcf1e042014 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -93,6 +93,7 @@ enum evm_ima_xattr_type {
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
 	EVM_XATTR_PORTABLE_DIGSIG,
+	IMA_VERITY_DIGSIG,
 };
 
 struct h_misc {
@@ -138,7 +139,8 @@ enum digest_algo {
 
 enum digsig_version {
 	DIGSIG_VERSION_1 = 1,
-	DIGSIG_VERSION_2
+	DIGSIG_VERSION_2,
+	DIGSIG_VERSION_3	/* hash of ima_file_id struct (portion used) */
 };
 
 struct pubkey_hdr {
@@ -233,5 +235,6 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsig
 void init_public_keys(const char *keyfiles);
 int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
+int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo, const unsigned char *in_hash, unsigned char *out_hash);
 
 #endif
diff --git a/src/libimaevm.c b/src/libimaevm.c
index a4f2ec40684d..52663a464cd7 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -497,6 +497,91 @@ err:
 	return ret;
 }
 
+#define HASH_MAX_DIGESTSIZE 64	/* kernel HASH_MAX_DIGESTSIZE is 64 bytes */
+
+struct ima_file_id {
+	__u8 hash_type;		/* xattr type [enum evm_ima_xattr_type] */
+	__u8 hash_algorithm;	/* Digest algorithm [enum hash_algo] */
+	__u8 hash[HASH_MAX_DIGESTSIZE];
+} __packed;
+
+/*
+ * Calculate the signature format version 3 hash based on the portion
+ * of the ima_file_id structure used, not the entire structure.
+ *
+ * For openssl errors return 1, other errors return -EINVAL.
+ */
+int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
+		    const unsigned char *in_hash, unsigned char *out_hash)
+{
+	struct ima_file_id file_id = { .hash_type = IMA_VERITY_DIGSIG };
+	uint8_t *data = (uint8_t *) &file_id;
+
+	const EVP_MD *md;
+	EVP_MD_CTX *pctx;
+	unsigned int mdlen;
+	int err;
+#if OPENSSL_VERSION_NUMBER < 0x10100000
+	EVP_MD_CTX ctx;
+	pctx = &ctx;
+#else
+	pctx = EVP_MD_CTX_new();
+#endif
+	int hash_algo;
+	int hash_size;
+	unsigned int unused;
+
+	if (type != IMA_VERITY_DIGSIG) {
+		log_err("Only fsverity supports signature format v3 (sigv3)\n");
+		return -EINVAL;
+	}
+
+	if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
+		log_err("Hash algorithm %s not supported\n", algo);
+		return -EINVAL;
+	}
+	file_id.hash_algorithm = hash_algo;
+
+	md = EVP_get_digestbyname(algo);
+	if (!md) {
+		log_err("EVP_get_digestbyname(%s) failed\n", algo);
+		err = 1;
+		goto err;
+	}
+
+	hash_size = EVP_MD_size(md);
+	memcpy(file_id.hash, in_hash, hash_size);
+
+	err = EVP_DigestInit(pctx, md);
+	if (!err) {
+		log_err("EVP_DigestInit() failed\n");
+		err = 1;
+		goto err;
+	}
+
+	unused = HASH_MAX_DIGESTSIZE - hash_size;
+	if (!EVP_DigestUpdate(pctx, data, sizeof(file_id) - unused)) {
+		log_err("EVP_DigestUpdate() failed\n");
+		err = 1;
+		goto err;
+	}
+
+	err = EVP_DigestFinal(pctx, out_hash, &mdlen);
+	if (!err) {
+		log_err("EVP_DigestFinal() failed\n");
+		err = 1;
+		goto err;
+	}
+	err = mdlen;
+err:
+	if (err == 1)
+		output_openssl_errors();
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	EVP_MD_CTX_free(pctx);
+#endif
+	return err;
+}
+
 int imaevm_get_hash_algo(const char *algo)
 {
 	int i;
-- 
2.27.0

