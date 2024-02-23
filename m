Return-Path: <linux-integrity+bounces-1420-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A83F58615D9
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 16:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA6E1F24CCC
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091481AC6;
	Fri, 23 Feb 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dCUrqM2N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B1823C1
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702274; cv=none; b=hXnji8Ch7FhRSq1BJUi+E2x/vc0zrmu75Sgx2IB3DVo5DoTRsYcdG9J/Mc7Krj/OzQ/oghRwrsOVS7oq/1QfsBPlgzpIT+8tSjiml/VgZSqUsRc8tNddg7NUUJe9dGIA9QQLZDZfqsNoO21DpADTmCoeTe55KrFdYhJGLoZ/2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702274; c=relaxed/simple;
	bh=V1Z76+BR3lwe3KZVBdSwXm5O/UukM3J0PTIW4knz8eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5ryIPr+VuL1/OhnMOYh/5zqoZnNrXmVmg4W9qs3Xv7E1TUpEarKDFRNDaDw+I+crdEC+dBViOsLnRPl1G8JwoTuvLP2ztRvbTxa+AG1mx/UJZfoiFhs0lLgK6zijw6vrfrHAK5SWLaiEcwmMyVTk6R+hxXvEJqm5GB+jx0z7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dCUrqM2N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NFB8GE011789;
	Fri, 23 Feb 2024 15:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fPAoa5ZxBPmEuPybKsfWkgr17xwZ6AZWFBT6q4hzdSQ=;
 b=dCUrqM2Nb+LkQRRZb1oMeehqPKD+ePbQwN9INb/FAb3liav8E8cKR6ZcXTxfy/iKp0O9
 vkaQgZzaamgJEKwFmKw09yYdcUkb6jJdJuLC59AreCZkLMY00GWZtwp1WAMhhCGJ4N5X
 ViKGFDeVeNZnQgXvQWEc41auS6RP+/oBjSBCo1lT+xKGs+6ASQecAPO60qSA56v+q8GQ
 jHQfnRTF1C1J+EJqWpAL2oMQfA7v1CJb5yFCsfFn10wQw+WABK+L+cuFXqI1LIWU2orn
 nHoJew7xueSswLdnd50tYqV0s3lGK2L95opqij67BeP3v/oHqbgf3nn21DjBognsJRIs UQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wevxdt46t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NCeZF5003611;
	Fri, 23 Feb 2024 15:30:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u6g18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NFUN5c18088686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:30:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6B358066;
	Fri, 23 Feb 2024 15:30:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2ADA58060;
	Fri, 23 Feb 2024 15:30:22 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:30:22 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 ima-evm-utils 4/6] Add support for OpenSSL provider to the library and evmctl
Date: Fri, 23 Feb 2024 10:30:12 -0500
Message-ID: <20240223153014.4048133-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223153014.4048133-1-stefanb@linux.ibm.com>
References: <20240223153014.4048133-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iKhni7cSmNEB6eme3oEt5rr95Vuf2ceY
X-Proofpoint-GUID: iKhni7cSmNEB6eme3oEt5rr95Vuf2ceY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230112

Also implement the --provider option that is useful for testing with
provider. It also helps a user to select whether to use an engine or a
provider.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 configure.ac    |  6 ++++
 src/Makefile.am | 21 +++++++++++---
 src/evmctl.c    | 49 +++++++++++++++++++++++++++++++++
 src/imaevm.h    |  9 ++++++
 src/libimaevm.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 365aacf..d0d2e21 100644
--- a/configure.ac
+++ b/configure.ac
@@ -61,6 +61,11 @@ AC_ARG_ENABLE(engine,
 	AC_CHECK_LIB([crypto], [ENGINE_init],, [enable_engine=no])
 	AM_CONDITIONAL([CONFIG_IMA_EVM_ENGINE], [test "x$enable_engine" = "xyes"])
 
+AC_ARG_ENABLE(provider,
+	      [AS_HELP_STRING([--disable-provider], [build ima-evm-utils without OpenSSL providre support])],,[enable_provider=yes])
+	AC_CHECK_LIB([crypto], [OSSL_PROVIDER_load],, [enable_provider=no])
+	AM_CONDITIONAL([CONFIG_IMA_EVM_PROVIDER], [test "x$enable_provider" = "xyes"])
+
 #debug support - yes for a while
 PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
 if test $pkg_cv_enable_debug = yes; then
@@ -99,6 +104,7 @@ echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
 echo    "         ibmtss: $ac_cv_header_ibmtss_tss_h"
 echo    "         sigv1:  $enable_sigv1"
 echo    "         engine: $enable_engine"
+echo    "       provider: $enable_provider"
 echo	"            doc: $have_doc"
 echo	"         pandoc: $have_pandoc"
 echo
diff --git a/src/Makefile.am b/src/Makefile.am
index 3bf742f..7c3f5fd 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -7,12 +7,18 @@ libimaevm_la_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 libimaevm_la_LDFLAGS = -version-info 4:0:0
 libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)
 
+libimaevm_la_CFLAGS =
+
 if CONFIG_SIGV1
-libimaevm_la_CFLAGS = -DCONFIG_SIGV1
+libimaevm_la_CFLAGS += -DCONFIG_SIGV1
 endif
 
 if CONFIG_IMA_EVM_ENGINE
-libimaevm_la_CFLAGS = -DCONFIG_IMA_EVM_ENGINE
+libimaevm_la_CFLAGS += -DCONFIG_IMA_EVM_ENGINE
+endif
+
+if CONFIG_IMA_EVM_PROVIDER
+libimaevm_la_CFLAGS += -DCONFIG_IMA_EVM_PROVIDER
 endif
 
 include_HEADERS = imaevm.h
@@ -30,14 +36,21 @@ evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 evmctl_LDFLAGS = $(LDFLAGS_READLINE)
 evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
 
+evmctl_CFLAGS =
+
 # Enable IMA signature version 1
 if CONFIG_SIGV1
-evmctl_CFLAGS = -DCONFIG_SIGV1
+evmctl_CFLAGS += -DCONFIG_SIGV1
 endif
 
 # Enable "--engine" support
 if CONFIG_IMA_EVM_ENGINE
-evmctl_CFLAGS = -DCONFIG_IMA_EVM_ENGINE
+evmctl_CFLAGS += -DCONFIG_IMA_EVM_ENGINE
+endif
+
+# Enable "--provider" support
+if CONFIG_IMA_EVM_PROVIDER
+evmctl_CFLAGS += -DCONFIG_IMA_EVM_PROVIDER
 endif
 
 # USE_PCRTSS uses the Intel TSS
diff --git a/src/evmctl.c b/src/evmctl.c
index 20f34dd..ffe2fc9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -68,6 +68,9 @@
 #if CONFIG_IMA_EVM_ENGINE
 #include <openssl/engine.h>
 #endif
+#if CONFIG_IMA_EVM_PROVIDER
+#include <openssl/provider.h>
+#endif
 #include <openssl/x509v3.h>
 #include "hash_info.h"
 #include "pcr.h"
@@ -2914,6 +2917,9 @@ static void usage(void)
 		"      --verify-sig   verify measurement list signatures\n"
 #if CONFIG_IMA_EVM_ENGINE
 		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
+#endif
+#if CONFIG_IMA_EVM_PROVIDER
+		"      --provider p   preload OpenSSL provider (such as: pkcs11)\n"
 #endif
 		"      --ignore-violations ignore ToMToU measurement violations\n"
 #ifdef DEBUG
@@ -2991,6 +2997,9 @@ static struct option opts[] = {
 	{"veritysig", 0, 0, 146},
 	{"hwtpm", 0, 0, 147},
 	{"hmackey", 1, 0, 148},
+#if CONFIG_IMA_EVM_PROVIDER
+	{"provider", 1, 0, 149},
+#endif
 	{}
 
 };
@@ -3036,6 +3045,25 @@ static char *get_password(void)
 	return password;
 }
 
+
+#if CONFIG_IMA_EVM_PROVIDER
+static OSSL_PROVIDER *setup_provider(const char *name)
+{
+	OSSL_PROVIDER *p = OSSL_PROVIDER_load(NULL, name);
+
+	if (!p) {
+		log_err("provider %s isn't available\n", optarg);
+		ERR_print_errors_fp(stderr);
+	} else if (!OSSL_PROVIDER_self_test(p)) {
+		log_err("provider %s self test failed\n", optarg);
+		ERR_print_errors_fp(stderr);
+		OSSL_PROVIDER_unload(p);
+		p = NULL;
+	}
+	return p;
+}
+#endif
+
 #if CONFIG_IMA_EVM_ENGINE
 static ENGINE *setup_engine(const char *engine_id)
 {
@@ -3240,6 +3268,16 @@ int main(int argc, char *argv[])
 		case 148:
 			imaevm_params.hmackeyfile = optarg;
 			break;
+#if CONFIG_IMA_EVM_PROVIDER
+		case 149: /* --provider p */
+			access_info.u.provider = setup_provider(optarg);
+			if (!access_info.u.provider) {
+				log_info("setup_provider failed\n");
+				goto error;
+			}
+			access_info.type = IMAEVM_OSSL_ACCESS_TYPE_PROVIDER;
+			break;
+#endif
 		case '?':
 			exit(1);
 			break;
@@ -3254,6 +3292,13 @@ int main(int argc, char *argv[])
 	if (imaevm_params.keyfile != NULL &&
 	    access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE &&
 	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
+#if CONFIG_IMA_EVM_PROVIDER
+		if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE) {
+			access_info.u.provider = setup_provider("pkcs11");
+			if (access_info.u.provider)
+				access_info.type = IMAEVM_OSSL_ACCESS_TYPE_PROVIDER;
+		}
+#endif
 #if CONFIG_IMA_EVM_ENGINE
 		if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE) {
 			access_info.u.engine = setup_engine("pkcs11");
@@ -3294,6 +3339,10 @@ error:
 		ENGINE_cleanup();
 #endif
 	}
+#endif
+#if CONFIG_IMA_EVM_PROVIDER
+	if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_PROVIDER)
+		OSSL_PROVIDER_unload(access_info.u.provider);
 #endif
 	ERR_free_strings();
 	EVP_cleanup();
diff --git a/src/imaevm.h b/src/imaevm.h
index 6764604..281a748 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -57,6 +57,13 @@ struct engine_st;
 typedef struct engine_st ENGINE; /* unused when no engine support */
 #endif
 
+#if OPENSSL_VERSION_NUMBER >= 0x30000000
+# include <openssl/provider.h>
+#else
+struct ossl_provider_st;
+typedef struct ossl_provider_st OSSL_PROVIDER;
+#endif
+
 #ifdef USE_FPRINTF
 #define do_log(level, fmt, args...)	\
 	({ if (level <= imaevm_params.verbose) fprintf(stderr, fmt, ##args); })
@@ -268,8 +275,10 @@ struct imaevm_ossl_access {
 	int type;
 #define IMAEVM_OSSL_ACCESS_TYPE_NONE   0
 #define IMAEVM_OSSL_ACCESS_TYPE_ENGINE 1  /* also: engine field exists */
+#define IMAEVM_OSSL_ACCESS_TYPE_PROVIDER 2 /* also: provider field exists */
 	union {
 		ENGINE *engine;
+		OSSL_PROVIDER *provider;
 	} u;
 };
 
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 91af613..64ddd96 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -62,6 +62,12 @@
 #include <openssl/err.h>
 #include <openssl/engine.h>
 
+#if CONFIG_IMA_EVM_PROVIDER
+#include <openssl/provider.h>
+#include <openssl/ui.h>
+#include <openssl/store.h>
+#endif
+
 #include "imaevm.h"
 #include "hash_info.h"
 
@@ -1064,6 +1070,64 @@ err_engine:
 #endif
 }
 
+#ifdef CONFIG_IMA_EVM_PROVIDER
+static int ui_get_pin(UI *ui, UI_STRING *uis)
+{
+	return UI_set_result(ui, uis, UI_get0_user_data(ui));
+}
+
+static EVP_PKEY *read_priv_pkey_provider(OSSL_PROVIDER *p, const char *keyfile,
+					 const char *keypass, uint32_t keyid)
+{
+	UI_METHOD *ui_method = NULL;
+	OSSL_STORE_INFO *info;
+	OSSL_STORE_CTX *store;
+	EVP_PKEY *pkey = NULL;
+	int typ;
+
+	if (!keyid) {
+		log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
+		return NULL;
+	}
+
+	if (keypass) {
+		ui_method = UI_create_method("PIN reader");
+		if (!ui_method)
+			return NULL;
+		UI_method_set_reader(ui_method, ui_get_pin);
+	}
+	store = OSSL_STORE_open_ex(keyfile, NULL, "provider=pkcs11", ui_method,
+				   (void *)keypass, NULL, NULL, NULL);
+	if (!store) {
+		log_err("Failed to open store for provider=pkcs11\n");
+		goto err_provider;
+	}
+	for (info = OSSL_STORE_load(store);
+	     info != NULL && pkey == NULL;
+	     info = OSSL_STORE_load(store)) {
+		typ = OSSL_STORE_INFO_get_type(info);
+
+		switch (typ) {
+		case OSSL_STORE_INFO_PKEY:
+			pkey = OSSL_STORE_INFO_get1_PKEY(info);
+			break;
+		}
+		OSSL_STORE_INFO_free(info);
+	}
+	OSSL_STORE_close(store);
+
+	if (!pkey) {
+		log_err("Failed to load private key %s\n", keyfile);
+		goto err_provider;
+	}
+	return pkey;
+
+err_provider:
+	output_openssl_errors();
+	return NULL;
+}
+#endif
+
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass,
 				const struct imaevm_ossl_access *access_info,
 				uint32_t keyid)
@@ -1077,6 +1141,12 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass,
 			pkey = read_priv_pkey_engine(access_info->u.engine,
 						     keyfile, keypass, keyid);
 			break;
+#ifdef CONFIG_IMA_EVM_PROVIDER
+		case IMAEVM_OSSL_ACCESS_TYPE_PROVIDER:
+			pkey = read_priv_pkey_provider(access_info->u.provider,
+						       keyfile, keypass, keyid);
+			break;
+#endif
 		}
 	} else {
 		fp = fopen(keyfile, "r");
@@ -1331,6 +1401,9 @@ static int check_ossl_access(const struct imaevm_ossl_access *access_info)
 	case IMAEVM_OSSL_ACCESS_TYPE_NONE:
 #ifdef CONFIG_IMA_EVM_ENGINE
 	case IMAEVM_OSSL_ACCESS_TYPE_ENGINE:
+#endif
+#ifdef CONFIG_IMA_EVM_PROVIDER
+	case IMAEVM_OSSL_ACCESS_TYPE_PROVIDER:
 #endif
 		return 0;
 
-- 
2.43.2


