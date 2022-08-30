Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733C85A59CA
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 05:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiH3DOS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 23:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiH3DNw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 23:13:52 -0400
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Aug 2022 20:13:18 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38A93A926D
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 20:13:17 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D3C3472C97D;
        Tue, 30 Aug 2022 06:03:53 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id BA32D4A470D;
        Tue, 30 Aug 2022 06:03:53 +0300 (MSK)
Date:   Tue, 30 Aug 2022 06:03:53 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 08/11] Deprecate use of OpenSSL 3
 "engine" support
Message-ID: <20220830030353.lwggzfsqmalpznoy@altlinux.org>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-9-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220830005936.189922-9-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Aug 29, 2022 at 08:59:33PM -0400, Mimi Zohar wrote:
> OpenSSL 3 "engine" support is deprecated, which results in deprecated
> build warning messages.  In preparation for OpenSSL "engine" support
> to be removed, define a "--enable-engine" configuration option. If not
> specified, disable engine support on systems with OpenSSL v3.

This seems to change default behavior.

Many distributions (AFAIK) still contain openssl1, and some contain both
openssl1 and openssl3, including devel packages. So they will suddenly
drop --engine support on ima-evm-utils update, even though their OpenSSL
supports it.

Maybe --disable-engine should be added instead if user wants to avoid
compile time deprecation warnings?

(Also, engines aren't just deprecated, they are deprecated in favor of
providers.)

> 
> When ima-evm-utils engine support is disabled, don't execute the tests
> requiring it.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  configure.ac           | 15 +++++++++++++++
>  src/Makefile.am        |  8 ++++++++
>  src/evmctl.c           | 17 +++++++++++++++--
>  src/imaevm.h           |  2 ++
>  src/libimaevm.c        |  5 +++++
>  tests/functions.sh     | 11 ++++++++++-
>  tests/ima_hash.test    |  9 +++++++++
>  tests/sign_verify.test | 10 ++++++++++
>  8 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index dc666f2bb1fa..5e0b78eb651b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,6 +54,19 @@ AC_ARG_ENABLE(sigv1,
>  	AM_CONDITIONAL([CONFIG_SIGV1], [test "x$enable_sigv1" = "xyes"])
>  	AS_IF([test "$enable_sigv1"  != "yes"], [enable_sigv1="no"])
>  
> +AC_ARG_ENABLE(engine,
> +	      [AS_HELP_STRING([--enable-engine], [build ima-evm-utils with OpenSSL engine support])])
> +
> +ssl_version=$(openssl version | sed -e 's/^OpenSSL //' | sed -e 's/ .*//')
> +if test -z "$enable_engine"; then
> +	if test "${ssl_version::1}" = "3"; then
> +		enable_engine="no"
> +	else
> +		enable_engine="yes"
> +	fi
> +fi
> +AM_CONDITIONAL([CONFIG_ENGINE], [test "x$enable_engine" = "xyes"])
> +
>  #debug support - yes for a while
>  PKG_ARG_ENABLE(debug, "yes", DEBUG, [Enable Debug support])
>  if test $pkg_cv_enable_debug = yes; then
> @@ -89,5 +102,7 @@ echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
>  echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
>  echo    "         ibmtss: $ac_cv_header_ibmtss_tss_h"
>  echo    "         sigv1:  $enable_sigv1"
> +echo    "         engine: $enable_engine"
> +echo    "            ssl: $ssl_version"
>  echo	"            doc: $have_doc"
>  echo
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 90c7249020cf..a810d6e0acff 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -11,6 +11,10 @@ if CONFIG_SIGV1
>  libimaevm_la_CFLAGS = -DCONFIG_SIGV1
>  endif
>  
> +if CONFIG_ENGINE
> +libimaevm_la_CFLAGS = -DCONFIG_ENGINE
> +endif
> +
>  include_HEADERS = imaevm.h
>  
>  nodist_libimaevm_la_SOURCES = hash_info.h
> @@ -31,6 +35,10 @@ if CONFIG_SIGV1
>  evmctl_CFLAGS = -DCONFIG_SIGV1
>  endif
>  
> +# Enable "--engine" support
> +if CONFIG_ENGINE
> +evmctl_CFLAGS = -DCONFIG_ENGINE
> +endif
>  
>  # USE_PCRTSS uses the Intel TSS
>  if USE_PCRTSS
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 490d355188d0..ad96789f1984 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -64,7 +64,9 @@
>  #include <openssl/hmac.h>
>  #include <openssl/err.h>
>  #include <openssl/rsa.h>
> +#if CONFIG_ENGINE
>  #include <openssl/engine.h>
> +#endif
>  #include <openssl/x509v3.h>
>  #include "hash_info.h"
>  #include "pcr.h"
> @@ -2715,7 +2717,7 @@ static void usage(void)
>  		"      --selinux      use custom Selinux label for EVM\n"
>  		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
>  		"      --verify-sig   verify measurement list signatures\n"
> -		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
> +		"      --engine e     preload OpenSSL engine e (such as: gost) id deprecated\n"

Typo.

>  		"      --ignore-violations ignore ToMToU measurement violations\n"
>  		"  -v                 increase verbosity level\n"
>  		"  -h, --help         display this help and exit\n"
> @@ -2828,7 +2830,9 @@ static char *get_password(void)
>  
>  static ENGINE *setup_engine(const char *engine_id)
>  {
> +#if CONFIG_ENGINE
>  	ENGINE *eng = ENGINE_by_id(engine_id);
> +
>  	if (!eng) {
>  		log_err("engine %s isn't available\n", optarg);
>  		ERR_print_errors_fp(stderr);
> @@ -2841,6 +2845,9 @@ static ENGINE *setup_engine(const char *engine_id)
>  	if (eng)
>  		ENGINE_set_default(eng, ENGINE_METHOD_ALL);
>  	return eng;
> +#endif
> +	log_err("OpenSSL 3 \"engine\" support is deprecated\n");
> +	return NULL;
>  }
>  
>  int main(int argc, char *argv[])
> @@ -2969,8 +2976,12 @@ int main(int argc, char *argv[])
>  			break;
>  		case 139: /* --engine e */
>  			imaevm_params.eng = setup_engine(optarg);
> -			if (!imaevm_params.eng)
> +			if (!imaevm_params.eng) {
> +#ifndef CONFIG_ENGINE
> +				err = 77; /* SKIP */
> +#endif
>  				goto error;
> +			}
>  			break;
>  		case 140: /* --xattr-user */
>  			xattr_ima = "user.ima";
> @@ -3056,6 +3067,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  error:
> +#if CONFIG_ENGINE
>  	if (imaevm_params.eng) {
>  		ENGINE_finish(imaevm_params.eng);
>  		ENGINE_free(imaevm_params.eng);
> @@ -3063,6 +3075,7 @@ error:
>  		ENGINE_cleanup();
>  #endif
>  	}
> +#endif
>  	ERR_free_strings();
>  	EVP_cleanup();
>  	BIO_free(NULL);
> diff --git a/src/imaevm.h b/src/imaevm.h
> index afcf1e042014..ebe8c20d566a 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -48,7 +48,9 @@
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <openssl/rsa.h>
> +#ifdef CONFIG_ENGINE
>  #include <openssl/engine.h>
> +#endif
>  
>  #ifdef USE_FPRINTF
>  #define do_log(level, fmt, args...)	\
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index cb815f953a80..d81bdbb85250 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -965,6 +965,7 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>  	EVP_PKEY *pkey;
>  
>  	if (!strncmp(keyfile, "pkcs11:", 7)) {
> +#ifdef CONFIG_ENGINE
>  		if (!imaevm_params.keyid) {
>  			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
>  			return NULL;
> @@ -981,6 +982,10 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>  			log_err("Failed to load private key %s\n", keyfile);
>  			goto err_engine;
>  		}
> +#else
> +		log_err("OpenSSL 3 \"engine\" support is deprecated\n");
> +		goto err_engine;
> +#endif
>  	} else {
>  		fp = fopen(keyfile, "r");
>  		if (!fp) {
> diff --git a/tests/functions.sh b/tests/functions.sh
> index 8f6f02dfcd95..ddc8fe9e5ea6 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -312,4 +312,13 @@ _softhsm_teardown() {
>    rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
>    unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
>      EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
> -}
> \ No newline at end of file
> +}
> +
> +# OpenSSL 3 engine support still works, but is deprecated. In preparation
> +# for it being removed, a new ima-evm-utils configuration option
> +# "--enable-engine" is defined.`
> +_is_engine_supported() {
> +  cmd="evmctl --engine pkcs11"

I think pkcs11 engine is optional (and could be in additional package)
even if other engines are present.

Also engine could be loaded via openssl.cnf/OPENSSL_CONF, in that case
--engine option is not needed but engine is still there to use/test.


> +  $cmd &>/dev/null
> +  ENGINE_SUPPORTED=$?
> +}
> diff --git a/tests/ima_hash.test b/tests/ima_hash.test
> index e88fd59cc359..0de9e6808af9 100755
> --- a/tests/ima_hash.test
> +++ b/tests/ima_hash.test
> @@ -71,6 +71,15 @@ expect_pass check  sha384     0x0405 38b060a751ac96384cd9327eb1b1e36a21fdb71114b
>  expect_pass check  sha512     0x0406 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
>  expect_pass check  rmd160     0x0403 9c1185a5c5e9fc54612808977ee8f548b2258d31
>  expect_pass check  sm3        0x0411 1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b
> +
> +# Remaining tests require engine support
> +_is_engine_supported
> +if [ $ENGINE_SUPPORTED -eq 77 ]; then
> +  __skip() { echo "Tests requiring engine support are skipped (not supported)"; return $SKIP; }
> +  expect_pass __skip
> +  exit 0
> +fi

GOST tests try to handle absence of algorithms (can work w/o --engine
option if configured via openssl config) and skip gracefully.
Perhaps this check should be moved below them just for pkcs11 tests
if they are so sensitive.

Thanks,

> +
>  _enable_gost_engine
>  expect_pass check  md_gost12_256 0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
>  expect_pass check  streebog256   0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 948892759424..8c005b741916 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -18,6 +18,8 @@
>  cd "$(dirname "$0")" || exit 1
>  PATH=../src:$PATH
>  SIGV1=0
> +ENGINE_SUPPORTED=0
> +
>  source ./functions.sh
>  
>  _require cmp evmctl getfattr openssl xxd
> @@ -418,6 +420,14 @@ if [ -x /opt/openssl3/bin/openssl ]; then
>      sign_verify  sm2    sm3    0x030211:K:004[345678]
>  fi
>  
> +# Remaining tests require engine support
> +_is_engine_supported
> +if [ $ENGINE_SUPPORTED -eq 77 ]; then
> +  __skip() { echo "Tests requiring engine support are skipped (not supported)"; return $SKIP; }
> +  expect_pass __skip
> +  exit 0
> +fi
> +
>  # Test v2 signatures with EC-RDSA
>  _enable_gost_engine
>  sign_verify  gost2012_256-A md_gost12_256 0x030212:K:0040
> -- 
> 2.31.1
