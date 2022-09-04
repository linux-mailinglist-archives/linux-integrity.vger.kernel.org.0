Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66ED5AC220
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Sep 2022 05:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIDDIs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 3 Sep 2022 23:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIDDIr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 3 Sep 2022 23:08:47 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CDEA4BA7F
        for <linux-integrity@vger.kernel.org>; Sat,  3 Sep 2022 20:08:41 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3CE2B72C90B;
        Sun,  4 Sep 2022 06:08:40 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 044564A470D;
        Sun,  4 Sep 2022 06:08:40 +0300 (MSK)
Date:   Sun, 4 Sep 2022 06:08:39 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 08/11] Deprecate use of OpenSSL v3 "engine"
 support
Message-ID: <20220904030839.dighibhcyxz46utx@altlinux.org>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
 <20220902162836.554839-9-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220902162836.554839-9-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Fri, Sep 02, 2022 at 12:28:33PM -0400, Mimi Zohar wrote:
> OpenSSL v3 "engine" support is deprecated and replaced with "providers".
> Engine support will continue to work for a while, but results in
> deprecated declaration and other messages.  One option is simply to hide
> them ("-Wno-deprecated-declarations").  The other alternative is to
> conditionally build ima-evm-utils without OpenSSL v3 engine support and
> without disabling deprecated declarations.
> 
> Based on "--disable-engine" or "--enable-engine=no" configuration
> option, disable OpenSSL v3 "engine" support.
> 
> When ima-evm-utils engine support is disabled, don't execute the tests
> requiring it.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  configure.ac           | 13 +++++++++++++
>  src/Makefile.am        |  8 ++++++++
>  src/evmctl.c           | 17 ++++++++++++++++-
>  src/imaevm.h           |  2 ++
>  src/libimaevm.c        |  5 +++++
>  tests/functions.sh     | 14 +++++++++++++-
>  tests/ima_hash.test    |  9 +++++++++
>  tests/sign_verify.test | 10 ++++++++++
>  8 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index dc666f2bb1fa..1a7d7eb17370 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -54,6 +54,17 @@ AC_ARG_ENABLE(sigv1,
>  	AM_CONDITIONAL([CONFIG_SIGV1], [test "x$enable_sigv1" = "xyes"])
>  	AS_IF([test "$enable_sigv1"  != "yes"], [enable_sigv1="no"])
>  
> +AC_ARG_ENABLE(engine,

Thanks.

BTW, if we now have handling of disabled engine -- OpenSSL have defines
OPENSSL_NO_ENGINE and OPENSSL_NO_DYNAMIC_ENGINE -- I think if any of
them is defined we could disable engine support automatically.

(Just a thought: In general, I would prefer if we rely on what is
configured in OpenSSL (whatever is enabled or disabled), and not
complicate things for user with post-decision of what is allowed for us
from OpenSSL. But of course opinions are different.)

> +	      [AS_HELP_STRING([--disable-engine], [build ima-evm-utils without OpenSSL v3 engine support])])

I think "v3" could be removed since it exists in v1 too.

> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 4b37bf5bd62c..ba489402f6f1 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -959,6 +959,7 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>  	EVP_PKEY *pkey;
>  
>  	if (!strncmp(keyfile, "pkcs11:", 7)) {
> +#ifdef CONFIG_ENGINE
>  		if (!imaevm_params.keyid) {
>  			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
>  			return NULL;
> @@ -975,6 +976,10 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>  			log_err("Failed to load private key %s\n", keyfile);
>  			goto err_engine;
>  		}
> +#else
> +		log_err("OpenSSL 3 \"engine\" support is deprecated\n");

And here too "3" could be removed. And perhaps "is disabled" since this is
not just a deprecation warning, but an error.

Thanks,

