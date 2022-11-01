Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6886615305
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKAUSb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiKAUS2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E452666
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:22 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1JxKfc003020;
        Tue, 1 Nov 2022 20:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2b5YjR1S0N6x3Khxi5N6Ych3YUvKfCnM5IiTFsl86RA=;
 b=k8IRmYHfpEO6XgE6X2vsxNSW4fZl1gMuWQ73wN+x3MvWQ5zzWwAiZOww246AvCsjM0/m
 9zBhWjFiCftud8PQk9DimePaw5NVebQ7weOwL0ruRc9f8JDe2r06bCK4/95q2GcWpcRM
 zynN/uWTWyp4uYwq2Fq6c/rCjeaXa5yf8NjikuOxDzwf12/I0RRuDwnAmMuKY3Z7KqbQ
 ByGsNoD0/V7wJgBJUI0XVtoj6s9YWaC+gBPwMtSjWlRx2UGAmj5CjTF+F3OgckAq0jea
 kQXE6SaP2YIJ7ELEHVcqYJs/Fn+90KFyTSBv/bzA3RUa4nlojc2GrfaEzvGW0WP30X3L FQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjwjjjyuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K6kmg014575;
        Tue, 1 Nov 2022 20:18:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut9572g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KID9Z34472648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 944EAA405C;
        Tue,  1 Nov 2022 20:18:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBE67A4054;
        Tue,  1 Nov 2022 20:18:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:12 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 06/17] Deprecate IMA signature version 1
Date:   Tue,  1 Nov 2022 16:17:52 -0400
Message-Id: <20221101201803.372652-7-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t6ospBdMcDYGJO6wZHSorQuPWtIvcqMs
X-Proofpoint-GUID: t6ospBdMcDYGJO6wZHSorQuPWtIvcqMs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The original IMA file signatures were based on a SHA1 hash.  Kernel
support for other hash algorithms was subsequently upstreamed.  Deprecate
"--rsa" support.

Define "--enable-sigv1" option to configure signature v1 support.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 configure.ac           |  6 ++++++
 src/Makefile.am        | 10 ++++++++++
 src/evmctl.c           | 20 ++++++++++++++++----
 src/libimaevm.c        | 22 +++++++++++++++++++---
 tests/sign_verify.test | 21 +++++++++++++++------
 5 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9d3b23ff8def..dc666f2bb1fa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -49,6 +49,11 @@ AC_ARG_ENABLE([openssl_conf],
 		AC_DEFINE(DISABLE_OPENSSL_CONF, 1, [Define to disable loading of openssl config by evmctl.])
 	      fi], [enable_openssl_conf=yes])
 
+AC_ARG_ENABLE(sigv1,
+	      AS_HELP_STRING([--enable-sigv1], [Build ima-evm-utils with signature v1 support]))
+	AM_CONDITIONAL([CONFIG_SIGV1], [test "x$enable_sigv1" = "xyes"])
+	AS_IF([test "$enable_sigv1"  != "yes"], [enable_sigv1="no"])
+
 #debug support - yes for a while
 PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
 if test $pkg_cv_enable_debug = yes; then
@@ -83,5 +88,6 @@ echo	"   openssl-conf: $enable_openssl_conf"
 echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
 echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
 echo    "         ibmtss: $ac_cv_header_ibmtss_tss_h"
+echo    "         sigv1:  $enable_sigv1"
 echo	"            doc: $have_doc"
 echo
diff --git a/src/Makefile.am b/src/Makefile.am
index 396496bb439d..90c7249020cf 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -7,6 +7,10 @@ libimaevm_la_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 libimaevm_la_LDFLAGS = -version-info 3:0:0
 libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)
 
+if CONFIG_SIGV1
+libimaevm_la_CFLAGS = -DCONFIG_SIGV1
+endif
+
 include_HEADERS = imaevm.h
 
 nodist_libimaevm_la_SOURCES = hash_info.h
@@ -22,6 +26,12 @@ evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 evmctl_LDFLAGS = $(LDFLAGS_READLINE)
 evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
 
+# Enable IMA signature version 1
+if CONFIG_SIGV1
+evmctl_CFLAGS = -DCONFIG_SIGV1
+endif
+
+
 # USE_PCRTSS uses the Intel TSS
 if USE_PCRTSS
  evmctl_SOURCES += pcr_tss.c
diff --git a/src/evmctl.c b/src/evmctl.c
index b1dcd9b1c1ef..158c1f9bf7a1 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -987,7 +987,6 @@ static int cmd_verify_ima(struct command *cmd)
 			init_public_keys("/etc/keys/x509_evm.der");
 	}
 
-	errno = 0;
 	if (!file) {
 		log_err("Parameters missing\n");
 		print_usage(cmd);
@@ -1004,6 +1003,7 @@ static int cmd_verify_ima(struct command *cmd)
 	return fails > 0;
 }
 
+#if CONFIG_SIGV1
 static int cmd_convert(struct command *cmd)
 {
 	char *inkey;
@@ -1034,6 +1034,7 @@ static int cmd_convert(struct command *cmd)
 	RSA_free(key);
 	return err;
 }
+#endif
 
 static int cmd_import(struct command *cmd)
 {
@@ -1088,6 +1089,7 @@ static int cmd_import(struct command *cmd)
 		calc_keyid_v2((uint32_t *)keyid, name, pkey);
 		EVP_PKEY_free(pkey);
 	} else {
+#if CONFIG_SIGV1
 		RSA *key = read_pub_key(inkey, imaevm_params.x509);
 
 		if (!key)
@@ -1095,6 +1097,10 @@ static int cmd_import(struct command *cmd)
 		len = key2bin(key, pub);
 		calc_keyid_v1(keyid, name, pub, len);
 		RSA_free(key);
+#else
+		log_info("Importing public RSA key is not supported\n");
+		return 1;
+#endif
 	}
 
 	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
@@ -2595,7 +2601,9 @@ static void usage(void)
 		"  -d, --imahash      make IMA hash\n"
 		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
 		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
-		"      --rsa          use RSA key type and signing scheme v1\n"
+#if CONFIG_SIGV1
+		"      --rsa          use RSA key type and signing scheme v1 (deprecated)\n"
+#endif
 		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
 		"                     or a pkcs11 URI\n"
 		"      --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)\n"
@@ -2634,8 +2642,12 @@ static void usage(void)
 struct command cmds[] = {
 	{"--version", NULL, 0, ""},
 	{"help", cmd_help, 0, "<command>"},
-	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring.\n"},
-	{"convert", cmd_convert, 0, "key", "convert public key into the keyring.\n"},
+#if CONFIG_SIGV1
+	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring. ([--rsa] deprecated)\n"},
+	{"convert", cmd_convert, 0, "key", "convert public key into the keyring. (deprecated)\n"},
+#else
+	{"import", cmd_import, 0, "pubkey keyring", "Import public key into the keyring.\n"},
+#endif
 	{"sign", cmd_sign_evm, 0, "[-r] [--imahash | --imasig ] [--key key] [--pass [password] file", "Sign file metadata.\n"},
 	{"verify", cmd_verify_evm, 0, "file", "Verify EVM signature (for debugging).\n"},
 	{"ima_sign", cmd_sign_ima, 0, "[--sigfile] [--key key] [--pass [password] file", "Make file content signature.\n"},
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 611631c57f14..b12b7ff14d95 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -290,6 +290,7 @@ out:
 	return pkey;
 }
 
+#if CONFIG_SIGV1
 RSA *read_pub_key(const char *keyfile, int x509)
 {
 	EVP_PKEY *pkey;
@@ -349,6 +350,7 @@ static int verify_hash_v1(const char *file, const unsigned char *hash, int size,
 
 	return 0;
 }
+#endif  /* CONFIG_SIGV1 */
 
 struct public_key_entry {
 	struct public_key_entry *next;
@@ -684,6 +686,7 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
 {
 	/* Get signature type from sig header */
 	if (sig[1] == DIGSIG_VERSION_1) {
+#if CONFIG_SIGV1
 		const char *key = NULL;
 
 		/* Read pubkey from RSA key */
@@ -693,6 +696,10 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
 			key = imaevm_params.keyfile;
 		return verify_hash_v1(file, hash, size, sig + 1, siglen - 1,
 					 key);
+#else
+		log_info("Signature version 1 deprecated.");
+		return -1;
+#endif
 	} else if (sig[1] == DIGSIG_VERSION_2) {
 		return verify_hash_v2(file, hash, size, sig, siglen);
 	} else if (sig[1] == DIGSIG_VERSION_3) {
@@ -740,6 +747,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	return verify_hash(file, hash, hashlen, sig, siglen);
 }
 
+#if CONFIG_SIGV1
 /*
  * Create binary key representation suitable for kernel
  */
@@ -798,6 +806,7 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
 	if (imaevm_params.verbose > LOG_INFO)
 		log_info("keyid-v1: %s\n", str);
 }
+#endif /* CONFIG_SIGV1 */
 
 /*
  * Calculate keyid of the public_key part of EVP_PKEY
@@ -986,6 +995,7 @@ err_engine:
 	return NULL;
 }
 
+#if CONFIG_SIGV1
 static RSA *read_priv_key(const char *keyfile, const char *keypass)
 {
 	EVP_PKEY *pkey;
@@ -1096,6 +1106,7 @@ out:
 	RSA_free(key);
 	return len;
 }
+#endif /* CONFIG_SIGV1 */
 
 /*
  * @sig is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
@@ -1210,9 +1221,14 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 	if (keypass)
 		imaevm_params.keypass = keypass;
 
-	return imaevm_params.x509 ?
-		sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
-		sign_hash_v1(hashalgo, hash, size, keyfile, sig);
+	if (imaevm_params.x509)
+		return sign_hash_v2(hashalgo, hash, size, keyfile, sig);
+#if CONFIG_SIGV1
+	else
+		return sign_hash_v1(hashalgo, hash, size, keyfile, sig);
+#endif
+	log_info("Signature version 1 deprecated.");
+	return -1;
 }
 
 static void libinit()
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index c56290aa4932..3e9548e1aeb7 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -17,6 +17,10 @@
 
 cd "$(dirname "$0")" || exit 1
 PATH=../src:$PATH
+
+# set the env SIGV1=1 to execute the signature v1 tests
+SIGV1=${SIGV1:-0}
+
 source ./functions.sh
 
 _require cmp evmctl getfattr openssl xxd
@@ -368,13 +372,18 @@ try_different_sigs() {
 
 ## Test v1 signatures
 # Signature v1 only supports sha1 and sha256 so any other should fail
-expect_fail \
-  check_sign TYPE=ima KEY=rsa1024 ALG=md5 PREFIX=0x0301 OPTS=--rsa
+if [ $SIGV1 -eq 0 ]; then
+  __skip() { echo "IMA signature v1 tests are skipped: not supported"; return $SKIP; }
+  expect_pass __skip
+else
+   expect_fail \
+      check_sign TYPE=ima KEY=rsa1024 ALG=md5 PREFIX=0x0301 OPTS=--rsa
 
-sign_verify  rsa1024  sha1    0x0301 --rsa
-sign_verify  rsa1024  sha256  0x0301 --rsa
-  try_different_keys
-  try_different_sigs
+   sign_verify  rsa1024  sha1    0x0301 --rsa
+   sign_verify  rsa1024  sha256  0x0301 --rsa
+      try_different_keys
+      try_different_sigs
+fi
 
 ## Test v2 signatures with RSA PKCS#1
 # List of allowed hashes much greater but not all are supported.
-- 
2.31.1

