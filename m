Return-Path: <linux-integrity+bounces-1185-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E288538B2
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F61C2656E
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39D5FF16;
	Tue, 13 Feb 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VMbHVwDm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816A57885
	for <linux-integrity@vger.kernel.org>; Tue, 13 Feb 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845982; cv=none; b=iWlv1cS4j4xujmAD0oecd+FpyQE5t8yB1WSvPWY3Kra/Lxj76XtFTY75Uo8tZLhFacDKr/hPG1+fggSo1UtmDr6oBi0r+VkdZgLzFWyALtkm9IrpdNhPAmecHue1xWaGseynr5lLICCvnvZyMRclwL3gLcmLNVgJ3kbqZDwpx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845982; c=relaxed/simple;
	bh=y3Ee5ZaUk4Lzbi+t019PvonPWxZVzBwtU4y6cjtVdCc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q+IMaMdONXCG2TAAw0cS3hsW6O3l07fYv2f+3ELBUdXa0Yae3OAwO0nAm0gGnnKXv5oPg3yT+icb3xGoeXSOrnpC1WvQJ/DdEPQmfkJTSXKox/7YSUXZp+2T5Z53+cUKv3szhvWcwpXSITNR5qjwcN8iirhwRQQT1jtuQnHdJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VMbHVwDm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DGqH06018751;
	Tue, 13 Feb 2024 17:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vqaHm1Fx/bAQtLaGue9/1Z+zJt2Ny3WpLsW1a68HTko=;
 b=VMbHVwDm6b2AsleeOUBo9jBYol0s9g1ook0fESMfieFYXShTx6ihSVkJ361hXhBtie0Q
 bfclN48FZNP/TCVOm/0xJ22Q/dN22F77N/h6WarYOb/hT6bZ/+NXvn/mPKlpMcbSo0Nb
 r4mQHPQqZ1L2vWGJg7FbPY2SUOT89SgoUQt5zD9331RfEyPdm4cRLKa2kkMwLVZt/QlA
 Fvr0kf+QO+q5Glgofg3Gj4rXfbLLkDF13NvBeTzZxvCZGW7VWVHpVGpI5oO/PLnPsezf
 ReJe3kfdXh0wu8I60Mz/vNUZw14EKxsdSfT7qgQ1Xy0pQJjDWW/64iZi7GbUi4dUX2/u iA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8caqh780-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 17:39:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DH9foo024888;
	Tue, 13 Feb 2024 17:39:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp8tb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 17:39:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DHdUcG22938324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 17:39:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE4F5805C;
	Tue, 13 Feb 2024 17:39:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22AF558058;
	Tue, 13 Feb 2024 17:39:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 17:39:29 +0000 (GMT)
Message-ID: <f7cf068f-c161-405a-9ba3-cb88228ee318@linux.ibm.com>
Date: Tue, 13 Feb 2024 12:39:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 ima-evm-utils 4/6] Add support for OpenSSL provider to
 the library and evmctl
Content-Language: en-US
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com
References: <20240205141528.3566511-1-stefanb@linux.ibm.com>
 <20240205141528.3566511-5-stefanb@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240205141528.3566511-5-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uaysJTDTzsiRKQ-0vvltJVlz_wgxTX6V
X-Proofpoint-ORIG-GUID: uaysJTDTzsiRKQ-0vvltJVlz_wgxTX6V
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130139



On 2/5/24 09:15, Stefan Berger wrote:
> Also implement the --provider option that is useful for testing with
> provider. It also helps a user to select whether to use an engine or a
> provider.

FYI: When running with provider one may see messages from p11-kit like 
these here:

# evmctl ima_sign --key 
'pkcs11:model=SoftHSM%20v2;manufacturer=SoftHSM%20project;serial=d7ac797325116907;token=swtpm-test;id=%17%C1%25%A7%AF%05%9D%A5%B7%33%79%C1%61%FE%F6%66%10%33%34%C3;object=mykey;type=private?pin-value=1234' 
--keyid 0x12 --provider pkcs11 --xattr-user testfile
hash(sha256): 
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
evm/ima signature: 264 bytes
03020400000012010029e1f64950bd3f86c8bf088231f02fe56edfcd9b7f49c9e1db6bf02ab0239d98c78d875097d66c7bedd94632d1c6a0f3cb4ae620b06a3e32d2a93727a24a6a695367acdfcb6e4eab9d0b59d91c285fe228c9b7b49c2fb423a2c29595e0b07945f8644ba17e958d3352474af9815556d32a484384c278e3d7f981e5bb5eea22133b1be85a86296fdff93461d275074bb3f9b4eac0adc685f49c6a025818b558d6b8fdd5e5102b8a041068dd015009b813a453b2b964437e7e9188c5e09438945480252e1f6cd073621592996a3275372fb92188bd7fb29143e7984ddc3ace634bacc1b7e450b7a20f59066f2bf7ede4f408eaf0db33c4ae407204b24eadb6275d
p11-kit: 'bound != NULL' not true at fixed1_C_CloseSession
p11-kit: 'bound != NULL' not true at fixed1_C_CloseSession
p11-kit: 'bound != NULL' not true at fixed1_C_Finalize

They have also been reported here and I would consider them as harmless: 
https://github.com/p11-glue/p11-kit/issues/495



> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   configure.ac    |  6 ++++
>   src/Makefile.am | 21 +++++++++++---
>   src/evmctl.c    | 50 +++++++++++++++++++++++++++++++++
>   src/imaevm.h    |  9 ++++++
>   src/libimaevm.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 155 insertions(+), 4 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 365aacf..d0d2e21 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -61,6 +61,11 @@ AC_ARG_ENABLE(engine,
>   	AC_CHECK_LIB([crypto], [ENGINE_init],, [enable_engine=no])
>   	AM_CONDITIONAL([CONFIG_IMA_EVM_ENGINE], [test "x$enable_engine" = "xyes"])
>   
> +AC_ARG_ENABLE(provider,
> +	      [AS_HELP_STRING([--disable-provider], [build ima-evm-utils without OpenSSL providre support])],,[enable_provider=yes])
> +	AC_CHECK_LIB([crypto], [OSSL_PROVIDER_load],, [enable_provider=no])
> +	AM_CONDITIONAL([CONFIG_IMA_EVM_PROVIDER], [test "x$enable_provider" = "xyes"])
> +
>   #debug support - yes for a while
>   PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
>   if test $pkg_cv_enable_debug = yes; then
> @@ -99,6 +104,7 @@ echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
>   echo    "         ibmtss: $ac_cv_header_ibmtss_tss_h"
>   echo    "         sigv1:  $enable_sigv1"
>   echo    "         engine: $enable_engine"
> +echo    "       provider: $enable_provider"
>   echo	"            doc: $have_doc"
>   echo	"         pandoc: $have_pandoc"
>   echo
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 3bf742f..7c3f5fd 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -7,12 +7,18 @@ libimaevm_la_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>   libimaevm_la_LDFLAGS = -version-info 4:0:0
>   libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)
>   
> +libimaevm_la_CFLAGS =
> +
>   if CONFIG_SIGV1
> -libimaevm_la_CFLAGS = -DCONFIG_SIGV1
> +libimaevm_la_CFLAGS += -DCONFIG_SIGV1
>   endif
>   
>   if CONFIG_IMA_EVM_ENGINE
> -libimaevm_la_CFLAGS = -DCONFIG_IMA_EVM_ENGINE
> +libimaevm_la_CFLAGS += -DCONFIG_IMA_EVM_ENGINE
> +endif
> +
> +if CONFIG_IMA_EVM_PROVIDER
> +libimaevm_la_CFLAGS += -DCONFIG_IMA_EVM_PROVIDER
>   endif
>   
>   include_HEADERS = imaevm.h
> @@ -30,14 +36,21 @@ evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>   evmctl_LDFLAGS = $(LDFLAGS_READLINE)
>   evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
>   
> +evmctl_CFLAGS =
> +
>   # Enable IMA signature version 1
>   if CONFIG_SIGV1
> -evmctl_CFLAGS = -DCONFIG_SIGV1
> +evmctl_CFLAGS += -DCONFIG_SIGV1
>   endif
>   
>   # Enable "--engine" support
>   if CONFIG_IMA_EVM_ENGINE
> -evmctl_CFLAGS = -DCONFIG_IMA_EVM_ENGINE
> +evmctl_CFLAGS += -DCONFIG_IMA_EVM_ENGINE
> +endif
> +
> +# Enable "--provider" support
> +if CONFIG_IMA_EVM_PROVIDER
> +evmctl_CFLAGS += -DCONFIG_IMA_EVM_PROVIDER
>   endif
>   
>   # USE_PCRTSS uses the Intel TSS
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 776f304..475c62d 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -68,6 +68,9 @@
>   #if CONFIG_IMA_EVM_ENGINE
>   #include <openssl/engine.h>
>   #endif
> +#if CONFIG_IMA_EVM_PROVIDER
> +#include <openssl/provider.h>
> +#endif
>   #include <openssl/x509v3.h>
>   #include "hash_info.h"
>   #include "pcr.h"
> @@ -2913,6 +2916,9 @@ static void usage(void)
>   		"      --verify-sig   verify measurement list signatures\n"
>   #if CONFIG_IMA_EVM_ENGINE
>   		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
> +#endif
> +#if CONFIG_IMA_EVM_PROVIDER
> +		"      --provider p   preload OpenSSL provider (such as: pkcs11)\n"
>   #endif
>   		"      --ignore-violations ignore ToMToU measurement violations\n"
>   #ifdef DEBUG
> @@ -2990,6 +2996,9 @@ static struct option opts[] = {
>   	{"veritysig", 0, 0, 146},
>   	{"hwtpm", 0, 0, 147},
>   	{"hmackey", 1, 0, 148},
> +#if CONFIG_IMA_EVM_PROVIDER
> +	{"provider", 1, 0, 149},
> +#endif
>   	{}
>   
>   };
> @@ -3035,6 +3044,25 @@ static char *get_password(void)
>   	return password;
>   }
>   
> +
> +#if CONFIG_IMA_EVM_PROVIDER
> +static OSSL_PROVIDER *setup_provider(const char *name)
> +{
> +	OSSL_PROVIDER *p = OSSL_PROVIDER_load(NULL, name);
> +
> +	if (!p) {
> +		log_err("provider %s isn't available\n", optarg);
> +		ERR_print_errors_fp(stderr);
> +	} else if (!OSSL_PROVIDER_self_test(p)) {
> +		log_err("provider %s self test failed\n", optarg);
> +		ERR_print_errors_fp(stderr);
> +		OSSL_PROVIDER_unload(p);
> +		p = NULL;
> +	}
> +	return p;
> +}
> +#endif
> +
>   #if CONFIG_IMA_EVM_ENGINE
>   static ENGINE *setup_engine(const char *engine_id)
>   {
> @@ -3239,6 +3267,16 @@ int main(int argc, char *argv[])
>   		case 148:
>   			imaevm_params.hmackeyfile = optarg;
>   			break;
> +#if CONFIG_IMA_EVM_PROVIDER
> +		case 149: /* --provider p */
> +			access_info.u.provider = setup_provider(optarg);
> +			if (!access_info.u.provider) {
> +				log_info("setup_provider failed\n");
> +				goto error;
> +			}
> +			access_info.type = IMAEVM_OSSL_ACCESS_TYPE_PROVIDER;
> +			break;
> +#endif
>   		case '?':
>   			exit(1);
>   			break;
> @@ -3253,6 +3291,13 @@ int main(int argc, char *argv[])
>   	if (imaevm_params.keyfile != NULL &&
>   	    access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE &&
>   	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
> +#if CONFIG_IMA_EVM_PROVIDER
> +		if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE) {
> +			access_info.u.provider = setup_provider("pkcs11");
> +			if (access_info.u.provider)
> +				access_info.type = IMAEVM_OSSL_ACCESS_TYPE_PROVIDER;
> +		}
> +#endif
>   #if CONFIG_IMA_EVM_ENGINE
>   		if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_NONE) {
>   			access_info.u.engine = setup_engine("pkcs11");
> @@ -3293,6 +3338,11 @@ error:
>   		ENGINE_cleanup();
>   #endif
>   	}
> +#endif
> +#if CONFIG_IMA_EVM_PROVIDER
> +	if (access_info.type == IMAEVM_OSSL_ACCESS_TYPE_PROVIDER) {
> +		OSSL_PROVIDER_unload(access_info.u.provider);
> +	}
>   #endif
>   	ERR_free_strings();
>   	EVP_cleanup();
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 9345e74..7a135ea 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -57,6 +57,13 @@ struct engine_st;
>   typedef struct engine_st ENGINE; /* unused when no engine support */
>   #endif
>   
> +#if OPENSSL_VERSION_NUMBER >= 0x30000000
> +# include <openssl/provider.h>
> +#else
> +struct ossl_provider_st;
> +typedef struct ossl_provider_st OSSL_PROVIDER;
> +#endif
> +
>   #ifdef USE_FPRINTF
>   #define do_log(level, fmt, args...)	\
>   	({ if (level <= imaevm_params.verbose) fprintf(stderr, fmt, ##args); })
> @@ -268,8 +275,10 @@ struct imaevm_ossl_access {
>       int type;
>   #define IMAEVM_OSSL_ACCESS_TYPE_NONE   0
>   #define IMAEVM_OSSL_ACCESS_TYPE_ENGINE 1  /* also: engine field exists */
> +#define IMAEVM_OSSL_ACCESS_TYPE_PROVIDER 2 /* also: provider field exists */
>       union {
>           ENGINE *engine;
> +        OSSL_PROVIDER *provider;
>       } u;
>   };
>   
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index c872aab..2ddfd44 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -62,6 +62,12 @@
>   #include <openssl/err.h>
>   #include <openssl/engine.h>
>   
> +#if CONFIG_IMA_EVM_PROVIDER
> +#include <openssl/provider.h>
> +#include <openssl/ui.h>
> +#include <openssl/store.h>
> +#endif
> +
>   #include "imaevm.h"
>   #include "hash_info.h"
>   
> @@ -1064,6 +1070,64 @@ err_engine:
>   #endif
>   }
>   
> +#ifdef CONFIG_IMA_EVM_PROVIDER
> +static int ui_get_pin(UI *ui, UI_STRING *uis)
> +{
> +	return UI_set_result(ui, uis, UI_get0_user_data(ui));
> +}
> +
> +static EVP_PKEY *read_priv_pkey_provider(OSSL_PROVIDER *p, const char *keyfile,
> +				         const char *keypass, uint32_t keyid)
> +{
> +	UI_METHOD *ui_method = NULL;
> +	OSSL_STORE_INFO *info;
> +	OSSL_STORE_CTX *store;
> +	EVP_PKEY *pkey = NULL;
> +	int typ;
> +
> +	if (!keyid) {
> +		log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
> +		return NULL;
> +	}
> +
> +	if (keypass) {
> +		ui_method = UI_create_method("PIN reader");
> +		if (!ui_method)
> +			return NULL;
> +		UI_method_set_reader(ui_method, ui_get_pin);
> +	}
> +	store = OSSL_STORE_open_ex(keyfile, NULL, "provider=pkcs11", ui_method,
> +				   (void *)keypass, NULL, NULL, NULL);
> +	if (!store) {
> +		log_err("Failed to open store for provider=pkcs11\n");
> +		goto err_provider;
> +	}
> +	for (info = OSSL_STORE_load(store);
> +	     info != NULL && pkey == NULL;
> +	     info = OSSL_STORE_load(store)) {
> +		typ = OSSL_STORE_INFO_get_type(info);
> +
> +		switch (typ) {
> +		case OSSL_STORE_INFO_PKEY:
> +			pkey = OSSL_STORE_INFO_get1_PKEY(info);
> +			break;
> +		}
> +		OSSL_STORE_INFO_free(info);
> +	}
> +	OSSL_STORE_close(store);
> +
> +	if (!pkey) {
> +		log_err("Failed to load private key %s\n", keyfile);
> +		goto err_provider;
> +	}
> +	return pkey;
> +
> +err_provider:
> +	output_openssl_errors();
> +	return NULL;
> +}
> +#endif
> +
>   static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass,
>   				const struct imaevm_ossl_access *access_info,
>   				uint32_t keyid)
> @@ -1077,6 +1141,12 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass,
>   			pkey = read_priv_pkey_engine(access_info->u.engine,
>   						     keyfile, keypass, keyid);
>   			break;
> +#ifdef CONFIG_IMA_EVM_PROVIDER
> +		case IMAEVM_OSSL_ACCESS_TYPE_PROVIDER:
> +			pkey = read_priv_pkey_provider(access_info->u.provider,
> +						       keyfile, keypass, keyid);
> +			break;
> +#endif
>   		}
>   	} else {
>   		fp = fopen(keyfile, "r");
> @@ -1331,6 +1401,9 @@ static int check_ossl_access(const struct imaevm_ossl_access *access_info)
>   	case IMAEVM_OSSL_ACCESS_TYPE_NONE:
>   #ifdef CONFIG_IMA_EVM_ENGINE
>   	case IMAEVM_OSSL_ACCESS_TYPE_ENGINE:
> +#endif
> +#ifdef CONFIG_IMA_EVM_PROVIDER
> +	case IMAEVM_OSSL_ACCESS_TYPE_PROVIDER:
>   #endif
>   		return 0;
>   

