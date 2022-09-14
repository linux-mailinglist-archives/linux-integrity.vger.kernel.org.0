Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C865B7EFB
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiINCaY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINCaT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33DC4456C
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:17 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E2TjOJ015751;
        Wed, 14 Sep 2022 02:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kbugM/h6rXRRZoihxp1LccE33sxavvKleOO8XuE74fY=;
 b=Mh6Vd5z6kSFfCiEz8OvTDooRh0gLwrvwq7jr0z/Po5vwJVB2hqN/IgRgF3Rdc5Gdyo8A
 gjWr/Dey7CxDRwRCnQi3LnSBj2Bq3U9VzvpytRv2PsjbLAU+4fhZEy6hRIOwFK24Bh81
 eT1F6+mS/y8np0E1kW9MRZMyYvzpOIi/JAmNnWePHKwPCZI2MDaSNStJe34a+c1XP8AF
 Y/vrHUG5GeGrZ5X4PW5lng2F0TAK2hKycxqs9ZU0bap64uhc1eUc1DS6SaCdL8b25tel
 IpiWtuDHjuxtn2Y3oNH9ozLs4AyTEhwbnGYOrv1p0WDj56MdcV+Hj3CKwbKggzTb2MRs kw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk67m007p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:12 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2KmkY000923;
        Wed, 14 Sep 2022 02:30:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3jjy2j88w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2QMcJ21102858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:26:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9391BA4051;
        Wed, 14 Sep 2022 02:30:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBE57A404D;
        Wed, 14 Sep 2022 02:30:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:06 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 07/15] Disable use of OpenSSL "engine" support
Date:   Tue, 13 Sep 2022 22:29:48 -0400
Message-Id: <20220914022956.1359218-8-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p6H-_gF1wX5MmmhPsic3lUgccFCUl0ap
X-Proofpoint-ORIG-GUID: p6H-_gF1wX5MmmhPsic3lUgccFCUl0ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140008
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

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 configure.ac           |  5 +++++
 src/Makefile.am        |  8 ++++++++
 src/evmctl.c           | 17 ++++++++++++++++-
 src/imaevm.h           |  2 ++
 src/libimaevm.c        |  7 ++++++-
 tests/functions.sh     |  2 +-
 tests/ima_hash.test    |  1 +
 tests/sign_verify.test |  1 +
 8 files changed, 40 insertions(+), 3 deletions(-)

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
index b8c92aad6b84..19d822efcee0 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -65,7 +65,9 @@
 #include <openssl/hmac.h>
 #include <openssl/err.h>
 #include <openssl/rsa.h>
+#if CONFIG_ENGINE
 #include <openssl/engine.h>
+#endif
 #include <openssl/x509v3.h>
 #include "hash_info.h"
 #include "pcr.h"
@@ -2716,7 +2718,9 @@ static void usage(void)
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
@@ -2778,7 +2782,9 @@ static struct option opts[] = {
 	{"selinux", 1, 0, 136},
 	{"caps", 2, 0, 137},
 	{"verify-sig", 0, 0, 138},
+#if CONFIG_ENGINE
 	{"engine", 1, 0, 139},
+#endif
 	{"xattr-user", 0, 0, 140},
 	{"ignore-violations", 0, 0, 141},
 	{"pcrs", 1, 0, 142},
@@ -2831,9 +2837,11 @@ static char *get_password(void)
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
@@ -2847,6 +2855,7 @@ static ENGINE *setup_engine(const char *engine_id)
 		ENGINE_set_default(eng, ENGINE_METHOD_ALL);
 	return eng;
 }
+#endif
 
 int main(int argc, char *argv[])
 {
@@ -2972,11 +2981,13 @@ int main(int argc, char *argv[])
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
@@ -3035,7 +3046,9 @@ int main(int argc, char *argv[])
 	if (imaevm_params.keyfile != NULL &&
 	    imaevm_params.eng == NULL &&
 	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
+#if CONFIG_ENGINE
 		imaevm_params.eng = setup_engine("pkcs11");
+#endif
 		if (!imaevm_params.eng)
 			goto error;
 	}
@@ -3061,6 +3074,7 @@ int main(int argc, char *argv[])
 	}
 
 error:
+#if CONFIG_ENGINE
 	if (imaevm_params.eng) {
 		ENGINE_finish(imaevm_params.eng);
 		ENGINE_free(imaevm_params.eng);
@@ -3068,6 +3082,7 @@ error:
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
index 4b37bf5bd62c..5d05f1bc1720 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -956,9 +956,10 @@ uint32_t imaevm_read_keyid(const char *certfile)
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
-	EVP_PKEY *pkey;
+	EVP_PKEY *pkey = NULL;
 
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
index 8f6f02dfcd95..209d79684f04 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -312,4 +312,4 @@ _softhsm_teardown() {
   rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
   unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
     EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
-}
\ No newline at end of file
+}
diff --git a/tests/ima_hash.test b/tests/ima_hash.test
index e88fd59cc359..20c673e2d86f 100755
--- a/tests/ima_hash.test
+++ b/tests/ima_hash.test
@@ -71,6 +71,7 @@ expect_pass check  sha384     0x0405 38b060a751ac96384cd9327eb1b1e36a21fdb71114b
 expect_pass check  sha512     0x0406 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
 expect_pass check  rmd160     0x0403 9c1185a5c5e9fc54612808977ee8f548b2258d31
 expect_pass check  sm3        0x0411 1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b
+
 _enable_gost_engine
 expect_pass check  md_gost12_256 0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
 expect_pass check  streebog256   0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 948892759424..6839896aa04b 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -18,6 +18,7 @@
 cd "$(dirname "$0")" || exit 1
 PATH=../src:$PATH
 SIGV1=0
+
 source ./functions.sh
 
 _require cmp evmctl getfattr openssl xxd
-- 
2.31.1

