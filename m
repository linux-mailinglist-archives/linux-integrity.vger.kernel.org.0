Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EED5B08DF
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIGPnW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 11:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGPnV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 11:43:21 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BF339E2D5
        for <linux-integrity@vger.kernel.org>; Wed,  7 Sep 2022 08:43:20 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A077772C90B;
        Wed,  7 Sep 2022 18:43:19 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5B64E4A4800;
        Wed,  7 Sep 2022 18:43:19 +0300 (MSK)
Date:   Wed, 7 Sep 2022 18:43:19 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils v2 12/12] Limit configuring OpenSSL
 engine support
Message-ID: <20220907154319.f2gewj42yhqi5wsv@altlinux.org>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
 <20220906195021.854090-13-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220906195021.854090-13-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Sep 06, 2022 at 03:50:21PM -0400, Mimi Zohar wrote:
> If either OPENSSL_NO_DYNAMIC_ENGINE or OPENSSL_NO_ENGINE is defined
> do not build ima-evm-utils with OpenSSL engine support.
> 
> Suggested-by: Vitaly Chikunov <vt@altlinux.org>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Vitaly, unlike with "--disable-engine" the "Tests requiring engine support
> are skipped (not supported)" message is not being displayed after building
> OpenSSL v3 with "no-engine" support.
> 
>  src/evmctl.c              | 14 ++++++++++++++
>  src/libimaevm.c           |  4 +++-
>  tests/install-openssl3.sh |  2 +-
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index e603449b7d9e..399a0d078a52 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -64,9 +64,11 @@
>  #include <openssl/hmac.h>
>  #include <openssl/err.h>
>  #include <openssl/rsa.h>
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
>  #if CONFIG_ENGINE
>  #include <openssl/engine.h>
>  #endif
> +#endif
>  #include <openssl/x509v3.h>
>  #include "hash_info.h"
>  #include "pcr.h"
> @@ -2722,8 +2724,10 @@ static void usage(void)
>  		"      --selinux      use custom Selinux label for EVM\n"
>  		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
>  		"      --verify-sig   verify measurement list signatures\n"
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
>  #if CONFIG_ENGINE

BTW, I would still undefine CONFIG_ENGINE (once, somewhere) if
OPENSSL_NO_ENGINE or OPENSSL_NO_DYNAMIC_ENGINE is defined by openssl,
instead of having two such #if-s each time we want to have engine
dependent code.

>  		"      --engine e     preload OpenSSL engine e (such as: gost) is deprecated\n"
> +#endif
>  #endif
>  		"      --ignore-violations ignore ToMToU measurement violations\n"
>  		"  -v                 increase verbosity level\n"
> @@ -2786,8 +2790,10 @@ static struct option opts[] = {
>  	{"selinux", 1, 0, 136},
>  	{"caps", 2, 0, 137},
>  	{"verify-sig", 0, 0, 138},
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
>  #if CONFIG_ENGINE
>  	{"engine", 1, 0, 139},
> +#endif
>  #endif
>  	{"xattr-user", 0, 0, 140},
>  	{"ignore-violations", 0, 0, 141},
> @@ -2841,6 +2847,7 @@ static char *get_password(void)
>  	return password;
>  }
>  
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
>  #if CONFIG_ENGINE
>  static ENGINE *setup_engine(const char *engine_id)
>  {
> @@ -2860,6 +2867,7 @@ static ENGINE *setup_engine(const char *engine_id)
>  	return eng;
>  }
>  #endif
> +#endif
>  
>  int main(int argc, char *argv[])
>  {
> @@ -2985,12 +2993,14 @@ int main(int argc, char *argv[])
>  		case 138:
>  			verify_list_sig = 1;
>  			break;
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
>  #if CONFIG_ENGINE

A lot of times.

Thanks,

>  		case 139: /* --engine e */
>  			imaevm_params.eng = setup_engine(optarg);
>  			if (!imaevm_params.eng)
>  				goto error;
>  			break;
> +#endif
>  #endif
>  		case 140: /* --xattr-user */
>  			xattr_ima = "user.ima";
> @@ -3050,8 +3060,10 @@ int main(int argc, char *argv[])
>  	if (imaevm_params.keyfile != NULL &&
>  	    imaevm_params.eng == NULL &&
>  	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
>  #if CONFIG_ENGINE
>  		imaevm_params.eng = setup_engine("pkcs11");
> +#endif
>  #endif
>  		if (!imaevm_params.eng)
>  			goto error;
> @@ -3078,6 +3090,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  error:
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
>  #if CONFIG_ENGINE
>  	if (imaevm_params.eng) {
>  		ENGINE_finish(imaevm_params.eng);
> @@ -3086,6 +3099,7 @@ error:
>  		ENGINE_cleanup();
>  #endif
>  	}
> +#endif
>  #endif
>  	ERR_free_strings();
>  	EVP_cleanup();
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 037027c1d951..c41b63fb97b9 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -959,7 +959,8 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>  	EVP_PKEY *pkey;
>  
>  	if (!strncmp(keyfile, "pkcs11:", 7)) {
> -#ifdef CONFIG_ENGINE
> +#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DYNAMIC_ENGINE)
> +#if CONFIG_ENGINE
>  		if (!imaevm_params.keyid) {
>  			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
>  			return NULL;
> @@ -979,6 +980,7 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>  #else
>  		log_err("OpenSSL \"engine\" support is disabled\n");
>  		goto err_engine;
> +#endif
>  #endif
>  	} else {
>  		fp = fopen(keyfile, "r");
> diff --git a/tests/install-openssl3.sh b/tests/install-openssl3.sh
> index 1b634681a760..cdda77980fea 100755
> --- a/tests/install-openssl3.sh
> +++ b/tests/install-openssl3.sh
> @@ -13,7 +13,7 @@ wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags
>  tar --no-same-owner -xzf ${version}.tar.gz
>  cd openssl-${version}
>  
> -./Configure --prefix=/opt/openssl3 --openssldir=/opt/openssl3/ssl
> +./Configure no-engine no-dynamic-engine --prefix=/opt/openssl3 --openssldir=/opt/openssl3/ssl
>  make -j$(nproc)
>  # only install apps and library
>  sudo make install_sw
> -- 
> 2.31.1
