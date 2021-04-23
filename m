Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54B368B58
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Apr 2021 04:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhDWDAR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Apr 2021 23:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhDWDAQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Apr 2021 23:00:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0B6C061574;
        Thu, 22 Apr 2021 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HBOB9+1dQZ8HFU8hecdF0SodpayfgYp4Mp4najr3kSE=; b=oqKeppikN9fTMjnZzq/QQSTrf6
        Z4pGMfDHMCuabnPTp3IZg9IBXBZzuPVbEjeJmfbhWi3/J72wwvGyk8XMaByqYC27wguHrh3wiUxj0
        x75yfjxnc3FlYdGd01WeK+1mglxBMcHoQJIio+fAJEQNC0uKbsKqJR9HzKd1wkyGp3rAgT27M6a6x
        4USbHXwTFJMp1IBk8feE8bvliGs+w1/JXrk8mJr6BAWNwmONEkQsHMNG+/hLbZAQKFi3iU2itW0AI
        I5T9BXSjPLa21V0jzyeO1NBqOouVpX7z8PP6nujB1nHNqXMUqdMPWspAb2sIYtc0uk6QzDXQx15S/
        qpMbfOow==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZm0k-000Piv-2k; Fri, 23 Apr 2021 02:58:17 +0000
Subject: Re: [PATCH] ima: ensure IMA_APPRAISE_MODSIG has necessary
 dependencies
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210423011602.138946-1-nayna@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <24feb895-eae1-5b9e-47d8-9ee9851710cc@infradead.org>
Date:   Thu, 22 Apr 2021 19:57:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210423011602.138946-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/22/21 6:16 PM, Nayna Jain wrote:
> IMA_APPRAISE_MODSIG is used for verifying the integrity of both kernel
> and modules. Enabling IMA_APPRAISE_MODSIG without MODULES causes a build
> break.
> 
> Ensure the build time kernel signing key is only generated if both
> IMA_APPRAISE_MODSIG and MODULES are enabled.
> 
> Fixes: 0165f4ca223b ("ima: enable signing of modules with build time generated key") 
> Reported-by: Randy Dunlap <rdunlap@infradead.org> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Works For Me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  certs/Kconfig               | 2 +-
>  certs/Makefile              | 2 ++
>  certs/system_certificates.S | 3 ++-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 48675ad319db..e4d00348fd73 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -4,7 +4,7 @@ menu "Certificates for signature checking"
>  config MODULE_SIG_KEY
>  	string "File name or PKCS#11 URI of module signing key"
>  	default "certs/signing_key.pem"
> -	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
> +	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
>  	help
>           Provide the file name of a private key/certificate in PEM format,
>           or a PKCS#11 URI according to RFC7512. The file should contain, or
> diff --git a/certs/Makefile b/certs/Makefile
> index e3185c57fbd8..2f369d6aa494 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -36,8 +36,10 @@ ifeq ($(CONFIG_MODULE_SIG),y)
>  endif
>  
>  ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
> +ifeq ($(CONFIG_MODULES),y)
>  	SIGN_KEY = y
>  endif
> +endif
>  
>  ifdef SIGN_KEY
>  ###############################################################################
> diff --git a/certs/system_certificates.S b/certs/system_certificates.S
> index dcad27ea8527..e1645e6f4d97 100644
> --- a/certs/system_certificates.S
> +++ b/certs/system_certificates.S
> @@ -9,7 +9,8 @@
>  system_certificate_list:
>  __cert_list_start:
>  __module_cert_start:
> -#if defined(CONFIG_MODULE_SIG) || defined(CONFIG_IMA_APPRAISE_MODSIG)
> +#if defined(CONFIG_MODULE_SIG) || (defined(CONFIG_IMA_APPRAISE_MODSIG) \
> +			       && defined(CONFIG_MODULES))
>  	.incbin "certs/signing_key.x509"
>  #endif
>  __module_cert_end:
> 


-- 
~Randy

