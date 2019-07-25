Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47C674351
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 04:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbfGYCcN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 22:32:13 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53674 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388369AbfGYCcN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 22:32:13 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 495DE72CC6C;
        Thu, 25 Jul 2019 05:24:21 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 261B44A4AE8;
        Thu, 25 Jul 2019 05:24:21 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2] ima-evm-utils: Namespace some too generic object names
Date:   Thu, 25 Jul 2019 05:24:14 +0300
Message-Id: <20190725022414.6109-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prefix `dump', `do_dump', and `params' with `ima_' to avoid colliding
with other global symbols.
Also, rename `libevm_' to `libimaevm_`, only used with `params'.
Additionally, rename `dump' into `hexdump'.

Lines that became too long are splitted. No code changes.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    | 94 +++++++++++++++++++++++++++++----------------------------
 src/imaevm.h    | 14 +++++----
 src/libimaevm.c | 42 ++++++++++++++------------
 3 files changed, 78 insertions(+), 72 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3289061..38193ec 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -403,9 +403,10 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		return -1;
 	}
 
-	md = EVP_get_digestbyname(params.hash_algo);
+	md = EVP_get_digestbyname(ima_params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
+		log_err("EVP_get_digestbyname(%s) failed\n",
+			ima_params.hash_algo);
 		return 1;
 	}
 
@@ -549,7 +550,7 @@ static int sign_evm(const char *file, const char *key)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
+	len = sign_hash(ima_params.hash_algo, hash, len, key, NULL, sig + 1);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -564,8 +565,8 @@ static int sign_evm(const char *file, const char *key)
 	if (evm_immutable)
 		sig[1] = 3; /* immutable signature version */
 
-	if (sigdump || params.verbose >= LOG_INFO)
-		dump(sig, len);
+	if (sigdump || ima_params.verbose >= LOG_INFO)
+		ima_hexdump(sig, len);
 
 	if (xattr) {
 		err = lsetxattr(file, xattr_evm, sig, len, 0);
@@ -582,7 +583,7 @@ static int hash_ima(const char *file)
 {
 	unsigned char hash[MAX_DIGEST_SIZE + 2]; /* +2 byte xattr header */
 	int len, err, offset;
-	int algo = get_hash_algo(params.hash_algo);
+	int algo = get_hash_algo(ima_params.hash_algo);
 
 	if (algo > PKEY_HASH_SHA1) {
 		hash[0] = IMA_XATTR_DIGEST_NG;
@@ -600,11 +601,11 @@ static int hash_ima(const char *file)
 
 	len += offset;
 
-	if (params.verbose >= LOG_INFO)
+	if (ima_params.verbose >= LOG_INFO)
 		log_info("hash: ");
 
-	if (sigdump || params.verbose >= LOG_INFO)
-		dump(hash, len);
+	if (sigdump || ima_params.verbose >= LOG_INFO)
+		ima_hexdump(hash, len);
 
 	if (xattr) {
 		err = lsetxattr(file, xattr_ima, hash, len, 0);
@@ -628,7 +629,7 @@ static int sign_ima(const char *file, const char *key)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
+	len = sign_hash(ima_params.hash_algo, hash, len, key, NULL, sig + 1);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -637,8 +638,8 @@ static int sign_ima(const char *file, const char *key)
 	len++;
 	sig[0] = EVM_IMA_XATTR_DIGSIG;
 
-	if (sigdump || params.verbose >= LOG_INFO)
-		dump(sig, len);
+	if (sigdump || ima_params.verbose >= LOG_INFO)
+		ima_hexdump(sig, len);
 
 	if (sigfile)
 		bin2file(file, "sig", sig, len);
@@ -718,7 +719,7 @@ static int sign_ima_file(const char *file)
 {
 	const char *key;
 
-	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
+	key = ima_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
 	return sign_ima(file, key);
 }
@@ -739,7 +740,7 @@ static int cmd_sign_hash(struct command *cmd)
 	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
 	int siglen;
 
-	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
+	key = ima_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
 	/* support reading hash (eg. output of shasum) */
 	while ((len = getline(&line, &line_len, stdin)) > 0) {
@@ -753,7 +754,7 @@ static int cmd_sign_hash(struct command *cmd)
 
 		assert(hashlen / 2 <= sizeof(hash));
 		hex2bin(hash, line, hashlen / 2);
-		siglen = sign_hash(params.hash_algo, hash, hashlen/2,
+		siglen = sign_hash(ima_params.hash_algo, hash, hashlen/2,
 				 key, NULL, sig + 1);
 		if (siglen <= 1)
 			return siglen;
@@ -779,7 +780,7 @@ static int sign_evm_path(const char *file)
 	const char *key;
 	int err;
 
-	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
+	key = ima_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
 	if (digsig) {
 		err = sign_ima(file, key);
@@ -838,13 +839,13 @@ static int cmd_verify_evm(struct command *cmd)
 		return -1;
 	}
 
-	if (params.keyfile)	/* Support multiple public keys */
-		init_public_keys(params.keyfile);
+	if (ima_params.keyfile)	/* Support multiple public keys */
+		init_public_keys(ima_params.keyfile);
 	else			/* assume read pubkey from x509 cert */
 		init_public_keys("/etc/keys/x509_evm.der");
 
 	err = verify_evm(file);
-	if (!err && params.verbose >= LOG_INFO)
+	if (!err && ima_params.verbose >= LOG_INFO)
 		log_info("%s: verification is OK\n", file);
 	return err;
 }
@@ -884,8 +885,8 @@ static int cmd_verify_ima(struct command *cmd)
 	char *file = g_argv[optind++];
 	int err;
 
-	if (params.keyfile)	/* Support multiple public keys */
-		init_public_keys(params.keyfile);
+	if (ima_params.keyfile)	/* Support multiple public keys */
+		init_public_keys(ima_params.keyfile);
 	else			/* assume read pubkey from x509 cert */
 		init_public_keys("/etc/keys/x509_evm.der");
 
@@ -898,7 +899,7 @@ static int cmd_verify_ima(struct command *cmd)
 
 	do {
 		err = verify_ima(file);
-		if (!err && params.verbose >= LOG_INFO)
+		if (!err && ima_params.verbose >= LOG_INFO)
 			log_info("%s: verification is OK\n", file);
 	} while ((file = g_argv[optind++]));
 	return err;
@@ -913,15 +914,15 @@ static int cmd_convert(struct command *cmd)
 	uint8_t keyid[8];
 	RSA *key;
 
-	params.x509 = 0;
+	ima_params.x509 = 0;
 
 	inkey = g_argv[optind++];
 	if (!inkey) {
-		inkey = params.x509 ? "/etc/keys/x509_evm.der" :
+		inkey = ima_params.x509 ? "/etc/keys/x509_evm.der" :
 				      "/etc/keys/pubkey_evm.pem";
 	}
 
-	key = read_pub_key(inkey, params.x509);
+	key = read_pub_key(inkey, ima_params.x509);
 	if (!key)
 		return 1;
 
@@ -945,7 +946,7 @@ static int cmd_import(struct command *cmd)
 
 	inkey = g_argv[optind++];
 	if (!inkey) {
-		inkey = params.x509 ? "/etc/keys/x509_evm.der" :
+		inkey = ima_params.x509 ? "/etc/keys/x509_evm.der" :
 				      "/etc/keys/pubkey_evm.pem";
 	} else
 		ring = g_argv[optind++];
@@ -975,8 +976,8 @@ static int cmd_import(struct command *cmd)
 		}
 	}
 
-	if (params.x509) {
-		EVP_PKEY *pkey = read_pub_pkey(inkey, params.x509);
+	if (ima_params.x509) {
+		EVP_PKEY *pkey = read_pub_pkey(inkey, ima_params.x509);
 
 		if (!pkey)
 			return 1;
@@ -988,7 +989,7 @@ static int cmd_import(struct command *cmd)
 		calc_keyid_v2((uint32_t *)keyid, name, pkey);
 		EVP_PKEY_free(pkey);
 	} else {
-		RSA *key = read_pub_key(inkey, params.x509);
+		RSA *key = read_pub_key(inkey, ima_params.x509);
 
 		if (!key)
 			return 1;
@@ -999,7 +1000,8 @@ static int cmd_import(struct command *cmd)
 
 	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
 
-	id = add_key(params.x509 ? "asymmetric" : "user", params.x509 ? NULL : name, pub, len, id);
+	id = add_key(ima_params.x509 ? "asymmetric" : "user",
+		     ima_params.x509 ? NULL : name, pub, len, id);
 	if (id < 0) {
 		log_err("add_key failed\n");
 		err = id;
@@ -1007,7 +1009,7 @@ static int cmd_import(struct command *cmd)
 		log_info("keyid: %d\n", id);
 		printf("%d\n", id);
 	}
-	if (params.x509)
+	if (ima_params.x509)
 		free(pub);
 	return err;
 }
@@ -1119,9 +1121,9 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 		goto out;
 	}
 
-	md = EVP_get_digestbyname(params.hash_algo);
+	md = EVP_get_digestbyname(ima_params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
+		log_err("EVP_get_digestbyname(%s) failed\n", ima_params.hash_algo);
 		goto out;
 	}
 
@@ -1243,7 +1245,7 @@ static int cmd_hmac_evm(struct command *cmd)
 		return -1;
 	}
 
-	key = params.keyfile ? : "/etc/keys/privkey_evm.pem";
+	key = ima_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
 	if (digsig) {
 		err = sign_ima(file, key);
@@ -1584,7 +1586,7 @@ void ima_ng_show(struct template_entry *entry)
 	}
 
 	/* ascii_runtime_measurements */
-	if (params.verbose > LOG_INFO) {
+	if (ima_params.verbose > LOG_INFO) {
 		log_info("%d ", entry->header.pcr);
 		log_dump_n(entry->header.digest, sizeof(entry->header.digest));
 		log_info(" %s %s", entry->name, algo);
@@ -1597,7 +1599,7 @@ void ima_ng_show(struct template_entry *entry)
 	}
 
 	if (sig) {
-		if (params.verbose > LOG_INFO) {
+		if (ima_params.verbose > LOG_INFO) {
 			log_info(" ");
 			log_dump(sig, sig_len);
 		}
@@ -1606,10 +1608,10 @@ void ima_ng_show(struct template_entry *entry)
 						   digest, digest_len);
 		else
 			err = ima_verify_signature(path, sig, sig_len, NULL, 0);
-		if (!err && params.verbose > LOG_INFO)
+		if (!err && ima_params.verbose > LOG_INFO)
 			log_info("%s: verification is OK\n", path);
 	} else {
-		if (params.verbose > LOG_INFO)
+		if (ima_params.verbose > LOG_INFO)
 			log_info("\n");
 	}
 
@@ -1644,8 +1646,8 @@ static int ima_measurement(const char *file)
 		return -1;
 	}
 
-	if (params.keyfile)	/* Support multiple public keys */
-		init_public_keys(params.keyfile);
+	if (ima_params.keyfile)	/* Support multiple public keys */
+		init_public_keys(ima_params.keyfile);
 	else			/* assume read pubkey from x509 cert */
 		init_public_keys("/etc/keys/x509_evm.der");
 
@@ -1955,7 +1957,7 @@ int main(int argc, char *argv[])
 			exit(0);
 			break;
 		case 'v':
-			params.verbose++;
+			ima_params.verbose++;
 			break;
 		case 'd':
 			digest = 1;
@@ -1969,13 +1971,13 @@ int main(int argc, char *argv[])
 			sigdump = 1;
 			break;
 		case 'a':
-			params.hash_algo = optarg;
+			ima_params.hash_algo = optarg;
 			break;
 		case 'p':
 			if (optarg)
-				params.keypass = optarg;
+				ima_params.keypass = optarg;
 			else
-				params.keypass = get_password();
+				ima_params.keypass = get_password();
 			break;
 		case 'f':
 			sigfile = 1;
@@ -1986,10 +1988,10 @@ int main(int argc, char *argv[])
 				hmac_flags |= HMAC_FLAG_NO_UUID;
 			break;
 		case '1':
-			params.x509 = 0;
+			ima_params.x509 = 0;
 			break;
 		case 'k':
-			params.keyfile = optarg;
+			ima_params.keyfile = optarg;
 			break;
 		case 'i':
 			if (evm_portable)
diff --git a/src/imaevm.h b/src/imaevm.h
index 0414433..81596cb 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -50,8 +50,10 @@
 #include <openssl/rsa.h>
 
 #ifdef USE_FPRINTF
-#define do_log(level, fmt, args...)	({ if (level <= params.verbose) fprintf(stderr, fmt, ##args); })
-#define do_log_dump(level, p, len, cr)	({ if (level <= params.verbose) do_dump(stderr, p, len, cr); })
+#define do_log(level, fmt, args...)	\
+	({ if (level <= ima_params.verbose) fprintf(stderr, fmt, ##args); })
+#define do_log_dump(level, p, len, cr)	\
+	({ if (level <= ima_params.verbose) ima_do_hexdump(stderr, p, len, cr); })
 #else
 #define do_log(level, fmt, args...)	syslog(level, fmt, ##args)
 #define do_log_dump(level, p, len, cr)
@@ -188,7 +190,7 @@ struct signature_v2_hdr {
 	uint8_t sig[0];		/* signature payload */
 } __packed;
 
-struct libevm_params {
+struct libimaevm_params {
 	int verbose;
 	int x509;
 	const char *hash_algo;
@@ -204,10 +206,10 @@ struct RSA_ASN1_template {
 #define	NUM_PCRS 20
 #define DEFAULT_PCR 10
 
-extern struct libevm_params params;
+extern struct libimaevm_params ima_params;
 
-void do_dump(FILE *fp, const void *ptr, int len, bool cr);
-void dump(const void *ptr, int len);
+void ima_do_hexdump(FILE *fp, const void *ptr, int len, bool cr);
+void ima_hexdump(const void *ptr, int len);
 int ima_calc_hash(const char *file, uint8_t *hash);
 int get_hash_algo(const char *algo);
 RSA *read_pub_key(const char *keyfile, int x509);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 2d99570..f83a347 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -81,7 +81,7 @@ const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
 	[PKEY_HASH_STREEBOG_512] = "streebog512",
 };
 
-struct libevm_params params = {
+struct libimaevm_params ima_params = {
 	.verbose = LOG_INFO - 1,
 	.x509 = 1,
 	.hash_algo = "sha1",
@@ -89,7 +89,7 @@ struct libevm_params params = {
 
 static void __attribute__ ((constructor)) libinit(void);
 
-void do_dump(FILE *fp, const void *ptr, int len, bool cr)
+void ima_do_hexdump(FILE *fp, const void *ptr, int len, bool cr)
 {
 	int i;
 	uint8_t *data = (uint8_t *) ptr;
@@ -100,9 +100,9 @@ void do_dump(FILE *fp, const void *ptr, int len, bool cr)
 		fprintf(fp, "\n");
 }
 
-void dump(const void *ptr, int len)
+void ima_hexdump(const void *ptr, int len)
 {
-	do_dump(stdout, ptr, len, true);
+	ima_do_hexdump(stdout, ptr, len, true);
 }
 
 const char *get_hash_algo_by_id(int algo)
@@ -258,9 +258,10 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		goto err;
 	}
 
-	md = EVP_get_digestbyname(params.hash_algo);
+	md = EVP_get_digestbyname(ima_params.hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
+		log_err("EVP_get_digestbyname(%s) failed\n",
+			ima_params.hash_algo);
 		err = 1;
 		goto err;
 	}
@@ -500,8 +501,8 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	const EVP_MD *md;
 	const char *st;
 
-	if (params.verbose > LOG_INFO) {
-		log_info("hash(%s): ", params.hash_algo);
+	if (ima_params.verbose > LOG_INFO) {
+		log_info("hash(%s): ", ima_params.hash_algo);
 		log_dump(hash, size);
 	}
 
@@ -521,7 +522,7 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	if (!EVP_PKEY_verify_init(ctx))
 		goto err;
 	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(params.hash_algo)))
+	if (!(md = EVP_get_digestbyname(ima_params.hash_algo)))
 		goto err;
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
@@ -610,7 +611,7 @@ int verify_hash(const char *file, const unsigned char *hash, int size, unsigned
 		const char *key = NULL;
 
 		/* Read pubkey from RSA key */
-		if (!params.keyfile)
+		if (!ima_params.keyfile)
 			key = "/etc/keys/pubkey_evm.pem";
 		return verify_hash_v1(file, hash, size, sig, siglen, key);
 	} else if (sig[0] == DIGSIG_VERSION_2) {
@@ -636,7 +637,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 		return -1;
 	}
 	/* Use hash algorithm as retrieved from signature */
-	params.hash_algo = get_hash_algo_by_id(sig_hash_algo);
+	ima_params.hash_algo = get_hash_algo_by_id(sig_hash_algo);
 
 	/*
 	 * Validate the signature based on the digest included in the
@@ -708,7 +709,7 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
 	id = __be64_to_cpup((__be64 *) keyid);
 	sprintf(str, "%llX", (unsigned long long)id);
 
-	if (params.verbose > LOG_INFO)
+	if (ima_params.verbose > LOG_INFO)
 		log_info("keyid-v1: %s\n", str);
 }
 
@@ -736,7 +737,7 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
 	log_debug_dump(keyid, 4);
 	sprintf(str, "%x", __be32_to_cpup(keyid));
 
-	if (params.verbose > LOG_INFO)
+	if (ima_params.verbose > LOG_INFO)
 		log_info("keyid: %s\n", str);
 
 	X509_PUBKEY_free(pk);
@@ -826,7 +827,7 @@ int sign_hash_v1(const char *hashalgo, const unsigned char *hash, int size, cons
 	log_info("hash: ");
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, params.keypass);
+	key = read_priv_key(keyfile, ima_params.keypass);
 	if (!key)
 		return -1;
 
@@ -909,10 +910,10 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 		return -1;
 	}
 
-	log_info("hash(%s): ", params.hash_algo);
+	log_info("hash(%s): ", ima_params.hash_algo);
 	log_dump(hash, size);
 
-	pkey = read_priv_pkey(keyfile, params.keypass);
+	pkey = read_priv_pkey(keyfile, ima_params.keypass);
 	if (!pkey)
 		return -1;
 
@@ -931,7 +932,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	if (!EVP_PKEY_sign_init(ctx))
 		goto err;
 	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(params.hash_algo)))
+	if (!(md = EVP_get_digestbyname(ima_params.hash_algo)))
 		goto err;
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
@@ -962,10 +963,11 @@ err:
 int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
 {
 	if (keypass)
-		params.keypass = keypass;
+		ima_params.keypass = keypass;
 
-	return params.x509 ? sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
-			     sign_hash_v1(hashalgo, hash, size, keyfile, sig);
+	return ima_params.x509 ?
+		sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
+		sign_hash_v1(hashalgo, hash, size, keyfile, sig);
 }
 
 static void libinit()
-- 
2.11.0

