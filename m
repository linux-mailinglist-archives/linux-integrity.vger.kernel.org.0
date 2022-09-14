Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E3E5B7EF8
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiINCaV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiINCaS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC4843607
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:13 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E1Ip6Q032050;
        Wed, 14 Sep 2022 02:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=n1sozLaN+TCzgsZq38h5BMslZ4VBh5iWS4XThUTRPGI=;
 b=WAHqZgrRAvhdNhzdKgrYweDQioaPU1U4Fq219pPHoAsL7xuUbrot004n5HmlrMHKkttb
 0ttqKamO3aTqlFZBJT10auP+qs3kTLcMd+DgxqxpOzz82wUYlTzaDdSmcM6jE9k+HNDZ
 MfcsImByjBCrazpgGAo2xqBOWUFzBfbw3J3WZ3WQx3fwM4ZhsCksxWJpUAeTVC8+MtFz
 N0QA+1dNljJAFG/QN35d2Z1FCKlLAGWF6V2Oxf2gvIqDUpHa1l2JuUmwoAuGI0KFFiSc
 nkxGxXtztQRou8ulTMbIXAF4APiWvZKCFL4KViMR50J4SkLD0YCM98HpePecp/ojCEsB hQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk56e1ptq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:09 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2MMxR000993;
        Wed, 14 Sep 2022 02:30:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3jjy9a08da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2U4Rg38404560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D35A1A4053;
        Wed, 14 Sep 2022 02:30:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BD4AA4065;
        Wed, 14 Sep 2022 02:30:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:03 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 03/15] Deprecate IMA signature version 1
Date:   Tue, 13 Sep 2022 22:29:44 -0400
Message-Id: <20220914022956.1359218-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cd9cgXeMm8ckrs4nXjn_JerqVb-W5ytN
X-Proofpoint-GUID: cd9cgXeMm8ckrs4nXjn_JerqVb-W5ytN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 tests/sign_verify.test | 18 ++++++++++++------
 5 files changed, 63 insertions(+), 13 deletions(-)

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
index 76e2561798fa..13b0105af8c4 100644
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
@@ -2598,7 +2604,9 @@ static void usage(void)
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
@@ -2637,8 +2645,12 @@ static void usage(void)
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
index e4b62b4989b2..4b37bf5bd62c 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -292,6 +292,7 @@ out:
 	return pkey;
 }
 
+#if CONFIG_SIGV1
 RSA *read_pub_key(const char *keyfile, int x509)
 {
 	EVP_PKEY *pkey;
@@ -351,6 +352,7 @@ static int verify_hash_v1(const char *file, const unsigned char *hash, int size,
 
 	return 0;
 }
+#endif  /* CONFIG_SIGV1 */
 
 struct public_key_entry {
 	struct public_key_entry *next;
@@ -686,6 +688,7 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
 {
 	/* Get signature type from sig header */
 	if (sig[1] == DIGSIG_VERSION_1) {
+#if CONFIG_SIGV1
 		const char *key = NULL;
 
 		/* Read pubkey from RSA key */
@@ -695,6 +698,10 @@ int verify_hash(const char *file, const unsigned char *hash, int size,
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
@@ -742,6 +749,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	return verify_hash(file, hash, hashlen, sig, siglen);
 }
 
+#if CONFIG_SIGV1
 /*
  * Create binary key representation suitable for kernel
  */
@@ -800,6 +808,7 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
 	if (imaevm_params.verbose > LOG_INFO)
 		log_info("keyid-v1: %s\n", str);
 }
+#endif /* CONFIG_SIGV1 */
 
 /*
  * Calculate keyid of the public_key part of EVP_PKEY
@@ -990,6 +999,7 @@ err_engine:
 	return NULL;
 }
 
+#if CONFIG_SIGV1
 static RSA *read_priv_key(const char *keyfile, const char *keypass)
 {
 	EVP_PKEY *pkey;
@@ -1100,6 +1110,7 @@ out:
 	RSA_free(key);
 	return len;
 }
+#endif /* CONFIG_SIGV1 */
 
 /*
  * @sig is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
@@ -1214,9 +1225,14 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
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
index c56290aa4932..948892759424 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -17,6 +17,7 @@
 
 cd "$(dirname "$0")" || exit 1
 PATH=../src:$PATH
+SIGV1=0
 source ./functions.sh
 
 _require cmp evmctl getfattr openssl xxd
@@ -368,13 +369,18 @@ try_different_sigs() {
 
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

