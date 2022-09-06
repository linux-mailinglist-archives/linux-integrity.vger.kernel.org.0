Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA545AF51B
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIFTzT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiIFTxK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:53:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B05B0B1F
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:50:57 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JmoYQ016577;
        Tue, 6 Sep 2022 19:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DhrBZjS1AFS5sc8EtxZksmCabDS3EuA+nNgAPixVj4w=;
 b=NorJrxmTvrp38uP6VUlQKeg5vIOMHukN5RItCmqYr2ae6xt0H+x34puJviKHZVHJoIVj
 H8oYZoy/t8h3elttpJ4707BiUZ3GwFEpGUYxJ/Qp0nt/zdMa+YC1mpOdlKfo2U59BKO4
 K0QWeciY7tDtkaGyiCkydhKSy4tiYosvWRkAq10xDt001YxsL2j1ZRDLAOzLj1eOZZ8R
 UYFRUiWGyu9OmoMqSkQhOsXJxPLSJrAynKM7Sr1u+ZttgoEue9JtOK2khKxXI8o5w8eo
 0qKjtFheHhyKCnczwowKGy8ZnHyFypL4WfOemWm1SrPog6FDIYgRRX3nfsODP29YlHqW YA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecpq00tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:51 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JZnKw014133;
        Tue, 6 Sep 2022 19:50:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3jbxj8u3bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Jp9l634079088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:51:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E72311C04A;
        Tue,  6 Sep 2022 19:50:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEC9911C054;
        Tue,  6 Sep 2022 19:50:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:43 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 08/12] Disable use of OpenSSL "engine" support
Date:   Tue,  6 Sep 2022 15:50:17 -0400
Message-Id: <20220906195021.854090-9-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906195021.854090-1-zohar@linux.ibm.com>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WZeLtM1Bxo0eNj4NOWg1xoDpF-CbnUwO
X-Proofpoint-ORIG-GUID: WZeLtM1Bxo0eNj4NOWg1xoDpF-CbnUwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

OpenSSL v3 "engine" support is deprecated and replaced with "providers".
Engine support will continue to work for a while, but results in
deprecated declaration and other messages.  One option is simply to hide
them ("-Wno-deprecated-declarations").  The other alternative is to
conditionally build ima-evm-utils without OpenSSL engine support and
without disabling deprecated declarations.

Based on "--disable-engine" or "--enable-engine=no" configuration
option, disable OpenSSL "engine" support.

When ima-evm-utils engine support is disabled, don't execute the tests
requiring it.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 configure.ac           |  5 +++++
 src/Makefile.am        |  8 ++++++++
 src/evmctl.c           | 17 ++++++++++++++++-
 src/imaevm.h           |  2 ++
 src/libimaevm.c        |  5 +++++
 tests/functions.sh     | 14 +++++++++++++-
 tests/ima_hash.test    |  9 +++++++++
 tests/sign_verify.test |  9 +++++++++
 8 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index dc666f2bb1fa..49e9350ace07 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,6 +54,10 @@ AC_ARG_ENABLE(sigv1,
 	AM_CONDITIONAL([CONFIG_SIGV1], [test "x$enable_sigv1" = "xyes"])
 	AS_IF([test "$enable_sigv1"  != "yes"], [enable_sigv1="no"])
 
+AC_ARG_ENABLE(engine,
+	      [AS_HELP_STRING([--disable-engine], [build ima-evm-utils without OpenSSL engine support])],,[enable_engine=yes])
+	AM_CONDITIONAL([CONFIG_ENGINE], [test "x$enable_engine" = "xyes"])
+
 #debug support - yes for a while
 PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
 if test $pkg_cv_enable_debug = yes; then
@@ -89,5 +93,6 @@ echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
 echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
 echo    "         ibmtss: $ac_cv_header_ibmtss_tss_h"
 echo    "         sigv1:  $enable_sigv1"
+echo    "         engine: $enable_engine"
 echo	"            doc: $have_doc"
 echo
diff --git a/src/Makefile.am b/src/Makefile.am
index 90c7249020cf..a810d6e0acff 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -11,6 +11,10 @@ if CONFIG_SIGV1
 libimaevm_la_CFLAGS = -DCONFIG_SIGV1
 endif
 
+if CONFIG_ENGINE
+libimaevm_la_CFLAGS = -DCONFIG_ENGINE
+endif
+
 include_HEADERS = imaevm.h
 
 nodist_libimaevm_la_SOURCES = hash_info.h
@@ -31,6 +35,10 @@ if CONFIG_SIGV1
 evmctl_CFLAGS = -DCONFIG_SIGV1
 endif
 
+# Enable "--engine" support
+if CONFIG_ENGINE
+evmctl_CFLAGS = -DCONFIG_ENGINE
+endif
 
 # USE_PCRTSS uses the Intel TSS
 if USE_PCRTSS
diff --git a/src/evmctl.c b/src/evmctl.c
index b89e74e06c3d..fa588e0caba2 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -64,7 +64,9 @@
 #include <openssl/hmac.h>
 #include <openssl/err.h>
 #include <openssl/rsa.h>
+#if CONFIG_ENGINE
 #include <openssl/engine.h>
+#endif
 #include <openssl/x509v3.h>
 #include "hash_info.h"
 #include "pcr.h"
@@ -2715,7 +2717,9 @@ static void usage(void)
 		"      --selinux      use custom Selinux label for EVM\n"
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --verify-sig   verify measurement list signatures\n"
-		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
+#if CONFIG_ENGINE
+		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
+#endif
 		"      --ignore-violations ignore ToMToU measurement violations\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
@@ -2777,7 +2781,9 @@ static struct option opts[] = {
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
 	{"verify-sig", 0, 0, 138},
+#if CONFIG_ENGINE
 	{"engine", 1, 0, 139},
+#endif
 	{"xattr-user", 0, 0, 140},
 	{"ignore-violations", 0, 0, 141},
 	{"pcrs", 1, 0, 142},
@@ -2830,9 +2836,11 @@ static char *get_password(void)
 	return password;
 }
 
+#if CONFIG_ENGINE
 static ENGINE *setup_engine(const char *engine_id)
 {
 	ENGINE *eng = ENGINE_by_id(engine_id);
+
 	if (!eng) {
 		log_err("engine %s isn't available\n", optarg);
 		ERR_print_errors_fp(stderr);
@@ -2846,6 +2854,7 @@ static ENGINE *setup_engine(const char *engine_id)
 		ENGINE_set_default(eng, ENGINE_METHOD_ALL);
 	return eng;
 }
+#endif
 
 int main(int argc, char *argv[])
 {
@@ -2971,11 +2980,13 @@ int main(int argc, char *argv[])
 		case 138:
 			verify_list_sig = 1;
 			break;
+#if CONFIG_ENGINE
 		case 139: /* --engine e */
 			imaevm_params.eng = setup_engine(optarg);
 			if (!imaevm_params.eng)
 				goto error;
 			break;
+#endif
 		case 140: /* --xattr-user */
 			xattr_ima = "user.ima";
 			xattr_evm = "user.evm";
@@ -3034,7 +3045,9 @@ int main(int argc, char *argv[])
 	if (imaevm_params.keyfile != NULL &&
 	    imaevm_params.eng == NULL &&
 	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
+#if CONFIG_ENGINE
 		imaevm_params.eng = setup_engine("pkcs11");
+#endif
 		if (!imaevm_params.eng)
 			goto error;
 	}
@@ -3060,6 +3073,7 @@ int main(int argc, char *argv[])
 	}
 
 error:
+#if CONFIG_ENGINE
 	if (imaevm_params.eng) {
 		ENGINE_finish(imaevm_params.eng);
 		ENGINE_free(imaevm_params.eng);
@@ -3067,6 +3081,7 @@ error:
 		ENGINE_cleanup();
 #endif
 	}
+#endif
 	ERR_free_strings();
 	EVP_cleanup();
 	BIO_free(NULL);
diff --git a/src/imaevm.h b/src/imaevm.h
index afcf1e042014..ebe8c20d566a 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -48,7 +48,9 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <openssl/rsa.h>
+#ifdef CONFIG_ENGINE
 #include <openssl/engine.h>
+#endif
 
 #ifdef USE_FPRINTF
 #define do_log(level, fmt, args...)	\
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 4b37bf5bd62c..037027c1d951 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -959,6 +959,7 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 	EVP_PKEY *pkey;
 
 	if (!strncmp(keyfile, "pkcs11:", 7)) {
+#ifdef CONFIG_ENGINE
 		if (!imaevm_params.keyid) {
 			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
 			return NULL;
@@ -975,6 +976,10 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 			log_err("Failed to load private key %s\n", keyfile);
 			goto err_engine;
 		}
+#else
+		log_err("OpenSSL \"engine\" support is disabled\n");
+		goto err_engine;
+#endif
 	} else {
 		fp = fopen(keyfile, "r");
 		if (!fp) {
diff --git a/tests/functions.sh b/tests/functions.sh
index 8f6f02dfcd95..9f7784584e91 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -312,4 +312,16 @@ _softhsm_teardown() {
   rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
   unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
     EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
-}
\ No newline at end of file
+}
+
+# OpenSSL v3 engine support still works, but is deprecated. In preparation
+# for it being removed, a new ima-evm-utils configuration option
+# "--disable-engine" and the equivalent "--enable-engine=no" is defined.`
+_is_engine_supported() {
+  cmd="evmctl --engine pkcs11"
+  $cmd &>/dev/null
+  if [ $? -eq 1 ]; then
+     return 0
+  fi
+  return 1
+}
diff --git a/tests/ima_hash.test b/tests/ima_hash.test
index e88fd59cc359..33223e6c7a94 100755
--- a/tests/ima_hash.test
+++ b/tests/ima_hash.test
@@ -71,6 +71,15 @@ expect_pass check  sha384     0x0405 38b060a751ac96384cd9327eb1b1e36a21fdb71114b
 expect_pass check  sha512     0x0406 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
 expect_pass check  rmd160     0x0403 9c1185a5c5e9fc54612808977ee8f548b2258d31
 expect_pass check  sm3        0x0411 1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b
+
+# Remaining tests require engine support
+_is_engine_supported
+if [ $? -eq 0 ]; then
+  __skip() { echo "Tests requiring engine support are skipped (not supported)"; return $SKIP; }
+  expect_pass __skip
+  exit 0
+fi
+
 _enable_gost_engine
 expect_pass check  md_gost12_256 0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
 expect_pass check  streebog256   0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 948892759424..1486447a8316 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -18,6 +18,7 @@
 cd "$(dirname "$0")" || exit 1
 PATH=../src:$PATH
 SIGV1=0
+
 source ./functions.sh
 
 _require cmp evmctl getfattr openssl xxd
@@ -418,6 +419,14 @@ if [ -x /opt/openssl3/bin/openssl ]; then
     sign_verify  sm2    sm3    0x030211:K:004[345678]
 fi
 
+# Remaining tests require engine support
+_is_engine_supported
+if [ $? -eq 0 ]; then
+  __skip() { echo "Tests requiring engine support are skipped (not supported)"; return $SKIP; }
+  expect_pass __skip
+  exit 0
+fi
+
 # Test v2 signatures with EC-RDSA
 _enable_gost_engine
 sign_verify  gost2012_256-A md_gost12_256 0x030212:K:0040
-- 
2.31.1

