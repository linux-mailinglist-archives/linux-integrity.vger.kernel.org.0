Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3627619FF3
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 19:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiKDScA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 14:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiKDSbw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 14:31:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA384091C
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 11:31:46 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Gnqh8032531;
        Fri, 4 Nov 2022 18:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gUbfSzYCr4fqWYUcM0qnryNZ0yTkbxDSgl/YMf7fEvQ=;
 b=N7FoSELIQx0SvUgD8gudnzoulI5KRaFSRGeAXXXKp5RqmlvcCzzsKIwjDc7W4niJMCSP
 tKfF/Q6WcvTbUU1C7iIU5YzQ2ivGtYMCq0Y6AHDl2arGcy/pL+k8C94m99dtwvcoFii+
 J1GZw17T/8qkh4ZDADvu98R3xe7i6+c5hzreezatYqeTMOU04Hw7SsOO/mGb36Kr0JH4
 bu8hnvrVz0pMgnwMwTMrLN5I7cxhnp+Zqeyx5+e2hrUSPQiyopJ1haukXL83YFqzlfzB
 GEw9vNLr7+49unqZ6zphyxzxGcGFCfJtluHjBRQpvnGkQJM5ZpNP3Io0sPaCv5MYT4qX vA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmpna1srx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 18:31:40 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A4IJsN2020667;
        Fri, 4 Nov 2022 18:31:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3kgutbc85t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 18:31:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A4IVcZ318743926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Nov 2022 18:31:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 116E758062;
        Fri,  4 Nov 2022 18:31:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B59958055;
        Fri,  4 Nov 2022 18:31:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Nov 2022 18:31:37 +0000 (GMT)
Message-ID: <74477b45-b10e-370f-6023-4a7e2fabce43@linux.ibm.com>
Date:   Fri, 4 Nov 2022 14:31:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v5 10/17] Disable use of OpenSSL "engine"
 support
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-11-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221103183904.103562-11-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EXjVq4o7cGhyiB1KNxdf4ZXPHEQthJMq
X-Proofpoint-ORIG-GUID: EXjVq4o7cGhyiB1KNxdf4ZXPHEQthJMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

  <stefanb@linux.ibm.com>

On 11/3/22 14:38, Mimi Zohar wrote:
> OpenSSL v3 "engine" support is deprecated and replaced with "providers".
> Engine support will continue to work for a while, but results in
> deprecated declaration and other messages.  One option is simply to hide
> them ("-Wno-deprecated-declarations").  The other alternative is to
> conditionally build ima-evm-utils without OpenSSL engine support and
> without disabling deprecated declarations.
> 
> Based on "--disable-engine" or "--enable-engine=no" configuration
> option, disable OpenSSL "engine" support.
> 
> As suggested by Vitaly,
> - verify ENGINE_init symbol is defined in libcrypto
> - disable engine support if either OPENSSL_NO_DYNAMIC_ENGINE or
> OPENSSL_NO_ENGINE variables are defined
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   configure.ac    |  6 ++++++
>   src/Makefile.am |  8 ++++++++
>   src/evmctl.c    | 17 ++++++++++++++++-
>   src/imaevm.h    |  6 ++++++
>   src/libimaevm.c |  7 ++++++-
>   5 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index dc666f2bb1fa..90646da22061 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,6 +54,11 @@ AC_ARG_ENABLE(sigv1,
>   	AM_CONDITIONAL([CONFIG_SIGV1], [test "x$enable_sigv1" = "xyes"])
>   	AS_IF([test "$enable_sigv1"  != "yes"], [enable_sigv1="no"])
>   
> +AC_ARG_ENABLE(engine,
> +	      [AS_HELP_STRING([--disable-engine], [build ima-evm-utils without OpenSSL engine support])],,[enable_engine=yes])
> +	AC_CHECK_LIB([crypto], [ENGINE_init],, [enable_engine=no])
> +	AM_CONDITIONAL([CONFIG_IMA_EVM_ENGINE], [test "x$enable_engine" = "xyes"])
> +
>   #debug support - yes for a while
>   PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
>   if test $pkg_cv_enable_debug = yes; then
> @@ -89,5 +94,6 @@ echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
>   echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
>   echo    "         ibmtss: $ac_cv_header_ibmtss_tss_h"
>   echo    "         sigv1:  $enable_sigv1"
> +echo    "         engine: $enable_engine"
>   echo	"            doc: $have_doc"
>   echo
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 90c7249020cf..0527a7b9df5c 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -11,6 +11,10 @@ if CONFIG_SIGV1
>   libimaevm_la_CFLAGS = -DCONFIG_SIGV1
>   endif
>   
> +if CONFIG_IMA_EVM_ENGINE
> +libimaevm_la_CFLAGS = -DCONFIG_IMA_EVM_ENGINE
> +endif
> +
>   include_HEADERS = imaevm.h
>   
>   nodist_libimaevm_la_SOURCES = hash_info.h
> @@ -31,6 +35,10 @@ if CONFIG_SIGV1
>   evmctl_CFLAGS = -DCONFIG_SIGV1
>   endif
>   
> +# Enable "--engine" support
> +if CONFIG_IMA_EVM_ENGINE
> +evmctl_CFLAGS = -DCONFIG_IMA_EVM_ENGINE
> +endif
>   
>   # USE_PCRTSS uses the Intel TSS
>   if USE_PCRTSS
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 66eea481d115..6f253bfcba19 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -65,7 +65,9 @@
>   #include <openssl/hmac.h>
>   #include <openssl/err.h>
>   #include <openssl/rsa.h>
> +#if CONFIG_IMA_EVM_ENGINE
>   #include <openssl/engine.h>
> +#endif
>   #include <openssl/x509v3.h>
>   #include "hash_info.h"
>   #include "pcr.h"
> @@ -2709,7 +2711,9 @@ static void usage(void)
>   		"      --selinux      use custom Selinux label for EVM\n"
>   		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
>   		"      --verify-sig   verify measurement list signatures\n"
> -		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
> +#if CONFIG_IMA_EVM_ENGINE
> +		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
> +#endif
>   		"      --ignore-violations ignore ToMToU measurement violations\n"
>   		"  -v                 increase verbosity level\n"
>   		"  -h, --help         display this help and exit\n"
> @@ -2771,7 +2775,9 @@ static struct option opts[] = {
>   	{"selinux", 1, 0, 136},
>   	{"caps", 2, 0, 137},
>   	{"verify-sig", 0, 0, 138},
> +#if CONFIG_IMA_EVM_ENGINE
>   	{"engine", 1, 0, 139},
> +#endif
>   	{"xattr-user", 0, 0, 140},
>   	{"ignore-violations", 0, 0, 141},
>   	{"pcrs", 1, 0, 142},
> @@ -2824,9 +2830,11 @@ static char *get_password(void)
>   	return password;
>   }
>   
> +#if CONFIG_IMA_EVM_ENGINE
>   static ENGINE *setup_engine(const char *engine_id)
>   {
>   	ENGINE *eng = ENGINE_by_id(engine_id);
> +
>   	if (!eng) {
>   		log_err("engine %s isn't available\n", optarg);
>   		ERR_print_errors_fp(stderr);
> @@ -2840,6 +2848,7 @@ static ENGINE *setup_engine(const char *engine_id)
>   		ENGINE_set_default(eng, ENGINE_METHOD_ALL);
>   	return eng;
>   }
> +#endif
>   
>   int main(int argc, char *argv[])
>   {
> @@ -2965,11 +2974,13 @@ int main(int argc, char *argv[])
>   		case 138:
>   			verify_list_sig = 1;
>   			break;
> +#if CONFIG_IMA_EVM_ENGINE
>   		case 139: /* --engine e */
>   			imaevm_params.eng = setup_engine(optarg);
>   			if (!imaevm_params.eng)
>   				goto error;
>   			break;
> +#endif
>   		case 140: /* --xattr-user */
>   			xattr_ima = "user.ima";
>   			xattr_evm = "user.evm";
> @@ -3028,7 +3039,9 @@ int main(int argc, char *argv[])
>   	if (imaevm_params.keyfile != NULL &&
>   	    imaevm_params.eng == NULL &&
>   	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
> +#if CONFIG_IMA_EVM_ENGINE
>   		imaevm_params.eng = setup_engine("pkcs11");
> +#endif
>   		if (!imaevm_params.eng)
>   			goto error;
>   	}
> @@ -3054,6 +3067,7 @@ int main(int argc, char *argv[])
>   	}
>   
>   error:
> +#if CONFIG_IMA_EVM_ENGINE
>   	if (imaevm_params.eng) {
>   		ENGINE_finish(imaevm_params.eng);
>   		ENGINE_free(imaevm_params.eng);
> @@ -3061,6 +3075,7 @@ error:
>   		ENGINE_cleanup();
>   #endif
>   	}
> +#endif
>   	ERR_free_strings();
>   	EVP_cleanup();
>   	BIO_free(NULL);
> diff --git a/src/imaevm.h b/src/imaevm.h
> index afcf1e042014..884321670fa7 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -48,7 +48,13 @@
>   #include <errno.h>
>   #include <sys/types.h>
>   #include <openssl/rsa.h>
> +#ifdef CONFIG_IMA_EVM_ENGINE
>   #include <openssl/engine.h>
> +#endif
> +
> +#if defined(OPENSSL_NO_ENGINE) || defined(OPENSSL_NO_DYNAMIC_ENGINE)
> +#undef CONFIG_IMA_EVM_ENGINE
> +#endif
>   
>   #ifdef USE_FPRINTF
>   #define do_log(level, fmt, args...)	\
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index b12b7ff14d95..8070ffd61a2c 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -953,9 +953,10 @@ uint32_t imaevm_read_keyid(const char *certfile)
>   static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>   {
>   	FILE *fp;
> -	EVP_PKEY *pkey;
> +	EVP_PKEY *pkey = NULL;
>   
>   	if (!strncmp(keyfile, "pkcs11:", 7)) {
> +#ifdef CONFIG_IMA_EVM_ENGINE
>   		if (!imaevm_params.keyid) {
>   			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
>   			return NULL;
> @@ -972,6 +973,10 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>   			log_err("Failed to load private key %s\n", keyfile);
>   			goto err_engine;
>   		}
> +#else
> +		log_err("OpenSSL \"engine\" support is disabled\n");
> +		goto err_engine;
> +#endif
>   	} else {
>   		fp = fopen(keyfile, "r");
>   		if (!fp) {
