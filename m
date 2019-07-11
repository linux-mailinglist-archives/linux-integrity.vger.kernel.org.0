Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8E4659FC
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfGKPHg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 11:07:36 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43820 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfGKPHg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 11:07:36 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E28DE72CCD6;
        Thu, 11 Jul 2019 18:07:32 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id C21344A4AE8;
        Thu, 11 Jul 2019 18:07:32 +0300 (MSK)
Date:   Thu, 11 Jul 2019 18:07:32 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/4] ima-evm-utils: link to libcrypto instead of OpenSSL
Message-ID: <20190711150732.7xrx42cnlsef6lit@altlinux.org>
Mail-Followup-To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190523122623.25684-1-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190523122623.25684-1-dbaryshkov@gmail.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dmitry,

On Thu, May 23, 2019 at 03:26:20PM +0300, Dmitry Eremin-Solenikov wrote:
> There is no need to link to full libssl. evmctl uses functions from
> libcrypto, so let's link only against that library.

Btw, this breaks my tests in my set up with gost-engine, making evmctl
crash on OPENSSL_init_crypto (in bind_gost). Did not investigate real
cause yet. I test with latest version of gost-engine (e372739) and
openssl 0fc4d00a00.


> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  configure.ac    | 4 +---
>  src/Makefile.am | 9 ++++-----
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 10d1d88ccdc7..9beb4b6c2377 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -24,9 +24,7 @@ LT_INIT
>  # Checks for header files.
>  AC_HEADER_STDC
>  
> -PKG_CHECK_MODULES(OPENSSL, [ openssl >= 0.9.8 ])
> -AC_SUBST(OPENSSL_CFLAGS)
> -AC_SUBST(OPENSSL_LIBS)
> +PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >= 0.9.8 ])
>  AC_SUBST(KERNEL_HEADERS)
>  AC_CHECK_HEADER(unistd.h)
>  AC_CHECK_HEADERS(openssl/conf.h)
> diff --git a/src/Makefile.am b/src/Makefile.am
> index d74fc6f6e190..b81281a31d9b 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -1,11 +1,11 @@
>  lib_LTLIBRARIES = libimaevm.la
>  
>  libimaevm_la_SOURCES = libimaevm.c
> -libimaevm_la_CPPFLAGS = $(OPENSSL_CFLAGS)
> +libimaevm_la_CPPFLAGS = $(LIBCRYPTO_CFLAGS)
>  # current[:revision[:age]]
>  # result: [current-age].age.revision
>  libimaevm_la_LDFLAGS = -version-info 0:0:0
> -libimaevm_la_LIBADD =  $(OPENSSL_LIBS)
> +libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)
>  
>  include_HEADERS = imaevm.h
>  
> @@ -17,12 +17,11 @@ hash_info.h: Makefile
>  bin_PROGRAMS = evmctl
>  
>  evmctl_SOURCES = evmctl.c
> -evmctl_CPPFLAGS = $(OPENSSL_CFLAGS)
> +evmctl_CPPFLAGS = $(LIBCRYPTO_CFLAGS)
>  evmctl_LDFLAGS = $(LDFLAGS_READLINE)
> -evmctl_LDADD =  $(OPENSSL_LIBS) -lkeyutils libimaevm.la
> +evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
>  
>  INCLUDES = -I$(top_srcdir) -include config.h
>  
>  CLEANFILES = hash_info.h
>  DISTCLEANFILES = @DISTCLEANFILES@
> -
> -- 
> 2.20.1
