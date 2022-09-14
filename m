Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8F5B8D36
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiINQiM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 12:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiINQiL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 12:38:11 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62B135B05D
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 09:38:05 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9346872C90B;
        Wed, 14 Sep 2022 19:38:04 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 103A54A46F0;
        Wed, 14 Sep 2022 19:38:04 +0300 (MSK)
Date:   Wed, 14 Sep 2022 19:38:03 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3 07/15] Disable use of OpenSSL "engine"
 support
Message-ID: <20220914163803.e6zo5kbgtxfewhti@altlinux.org>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
 <20220914022956.1359218-8-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220914022956.1359218-8-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 13, 2022 at 10:29:48PM -0400, Mimi Zohar wrote:
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
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  configure.ac           |  5 +++++
>  src/Makefile.am        |  8 ++++++++
>  src/evmctl.c           | 17 ++++++++++++++++-
>  src/imaevm.h           |  2 ++
>  src/libimaevm.c        |  7 ++++++-
>  tests/functions.sh     |  2 +-
>  tests/ima_hash.test    |  1 +
>  tests/sign_verify.test |  1 +
>  8 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index dc666f2bb1fa..49e9350ace07 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,6 +54,10 @@ AC_ARG_ENABLE(sigv1,
>  	AM_CONDITIONAL([CONFIG_SIGV1], [test "x$enable_sigv1" = "xyes"])
>  	AS_IF([test "$enable_sigv1"  != "yes"], [enable_sigv1="no"])
>  
> +AC_ARG_ENABLE(engine,
> +	      [AS_HELP_STRING([--disable-engine], [build ima-evm-utils without OpenSSL engine support])],,[enable_engine=yes])

I would insert here:

  AC_CHECK_LIB([crypto], [ENGINE_init],, [enable_engine=no])

So that if -lcrypto does not have ENGINE_init symbol, engine will be
automatically disabled.


> @@ -2972,11 +2981,13 @@ int main(int argc, char *argv[])
>  		case 138:
>  			verify_list_sig = 1;
>  			break;
> +#if CONFIG_ENGINE
>  		case 139: /* --engine e */
>  			imaevm_params.eng = setup_engine(optarg);
>  			if (!imaevm_params.eng)
>  				goto error;

Still it's a bit strange that this error will not cause exit(1).

Thanks,

>  			break;
> +#endif
>  		case 140: /* --xattr-user */
>  			xattr_ima = "user.ima";
>  			xattr_evm = "user.evm";
> @@ -3035,7 +3046,9 @@ int main(int argc, char *argv[])
>  	if (imaevm_params.keyfile != NULL &&
>  	    imaevm_params.eng == NULL &&
>  	    !strncmp(imaevm_params.keyfile, "pkcs11:", 7)) {
> +#if CONFIG_ENGINE
>  		imaevm_params.eng = setup_engine("pkcs11");
> +#endif
>  		if (!imaevm_params.eng)
>  			goto error;
>  	}
> @@ -3061,6 +3074,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  error:
> +#if CONFIG_ENGINE
>  	if (imaevm_params.eng) {
>  		ENGINE_finish(imaevm_params.eng);
>  		ENGINE_free(imaevm_params.eng);
> @@ -3068,6 +3082,7 @@ error:
>  		ENGINE_cleanup();
>  #endif
>  	}
> +#endif
>  	ERR_free_strings();
>  	EVP_cleanup();
>  	BIO_free(NULL);
