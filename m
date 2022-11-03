Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928D46187B4
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKCSja (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKCSj2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100EA100
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:27 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3ILNDW001178;
        Thu, 3 Nov 2022 18:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6IVDMobT2NnrgRjuuPS3ER41B25HTwj+Rp5F8yJbL7E=;
 b=MUV2aBOpgDFueqWvk/DxJnEHRnm3fLBdgdgj/gOe2zbNL9MJ6OdFa/dlNwDnkymrRGyk
 z7hOlL+h8YKa8kYAgBLPpMhevnNfVoi3K1Fo/Emtrbnmt9ICxh9lTrJJfqJai3J86DAI
 pd9QM+/1CFfTB4dN/QJ1m2xH06lNiuPx3I6aALaZ4Wv92muNvP4CYezY9AwhASYdhGZg
 rQvo0B7DHQzFNC0Zu5kONON9KkmHsr2srD4BTbq8LcsFZluBuJT4b5dwKrNKzoSxxmon
 9yBQTPlOv1wGTY/czsZTVP7+NHf/6V8UNKisKOaLAYdtrbPOCBKRQm2CRQshrNKEoaId Gg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmemwtukt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3IbQAf005507;
        Thu, 3 Nov 2022 18:39:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut9974t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IdIME57409896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:39:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE7342042;
        Thu,  3 Nov 2022 18:39:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 767E44203F;
        Thu,  3 Nov 2022 18:39:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:17 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 06/17] Deprecate IMA signature version 1
Date:   Thu,  3 Nov 2022 14:38:53 -0400
Message-Id: <20221103183904.103562-7-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c_tFEuoAXYlr37wUn9ShYEJBT2BevCmr
X-Proofpoint-GUID: c_tFEuoAXYlr37wUn9ShYEJBT2BevCmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030125
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
index 53af4d2cb961..b2560aae0905 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -990,7 +990,6 @@ static int cmd_verify_ima(struct command *cmd)
 			init_public_keys("/etc/keys/x509_evm.der");
 	}
 
-	errno = 0;
 	if (!file) {
 		log_err("Parameters missing\n");
 		print_usage(cmd);
@@ -1007,6 +1006,7 @@ static int cmd_verify_ima(struct command *cmd)
 	return fails > 0;
 }
 
+#if CONFIG_SIGV1
 static int cmd_convert(struct command *cmd)
 {
 	char *inkey;
@@ -1037,6 +1037,7 @@ static int cmd_convert(struct command *cmd)
 	RSA_free(key);
 	return err;
 }
+#endif
 
 static int cmd_import(struct command *cmd)
 {
@@ -1091,6 +1092,7 @@ static int cmd_import(struct command *cmd)
 		calc_keyid_v2((uint32_t *)keyid, name, pkey);
 		EVP_PKEY_free(pkey);
 	} else {
+#if CONFIG_SIGV1
 		RSA *key = read_pub_key(inkey, imaevm_params.x509);
 
 		if (!key)
@@ -1098,6 +1100,10 @@ static int cmd_import(struct command *cmd)
 		len = key2bin(key, pub);
 		calc_keyid_v1(keyid, name, pub, len);
 		RSA_free(key);
+#else
+		log_info("Importing public RSA key is not supported\n");
+		return 1;
+#endif
 	}
 
 	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
@@ -2600,7 +2606,9 @@ static void usage(void)
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
@@ -2639,8 +2647,12 @@ static void usage(void)
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

