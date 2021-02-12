Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0131A86A
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Feb 2021 00:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhBLXse (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 18:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLXsd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 18:48:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2904E64D9A;
        Fri, 12 Feb 2021 23:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613173672;
        bh=b0rTBrVHXS+DaL/v4c5xa1WnMPEsXvECxilMn7XJ7U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDzYMCRJl4huDWwIORgsVxhjt/yecvMrGp3AOJtQ4Et2nbj03Mjv51hZrblK5npO4
         Fi1BuIxi8EwnJWJZra+pIWD+e5EG0RxyPPjz07glI5+8wr04g70x0Hby5IFfet0Am5
         csItvQgQIyb535CJU9leqQiURRCquq4cIfZhWlJ0vJA8BNOcmG3aO2vqBWa4jaUEG7
         BZ+niHt6QULsTeCCtoCfiT0Dg4syI1o/sf7EEACuPS7n5wHe7n8yL4+EyUjdj+yic4
         4VNywALSNXUvl7hVrPtTbO+4fuMfndo14C7Ta8BjX9EgQD8pVt1vADOH+1uAPKLQCB
         DOoezEtDL6c2Q==
Date:   Sat, 13 Feb 2021 01:47:43 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] keys: generate self-signed module signing key using
 CSR
Message-ID: <YCcTnz7eBmP40wx7@kernel.org>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
 <20210211195435.135582-3-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211195435.135582-3-nayna@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 11, 2021 at 02:54:32PM -0500, Nayna Jain wrote:
> Loading a key on the IMA trusted keyring requires the key be signed
> by an existing key on the builtin or secondary trusted keyring.
> Creating a Certificate Signing Request (CSR) allows the certificate
> to be self-signed or signed by a CA.
> 
> This patch generates a self-signed module signing key using CSR.

"Generate ..."

/Jarkko

> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  Makefile       |  3 ++-
>  certs/Makefile | 15 +++++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index af18aab6bbee..9c87fdd600d8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1473,7 +1473,8 @@ MRPROPER_FILES += include/config include/generated          \
>  		  .config .config.old .version \
>  		  Module.symvers \
>  		  certs/signing_key.pem certs/signing_key.x509 \
> -		  certs/x509.genkey \
> +		  certs/x509.genkey certs/signing_key.key \
> +		  certs/signing_key.crt certs/signing_key.csr \
>  		  vmlinux-gdb.py \
>  		  *.spec
>  
> diff --git a/certs/Makefile b/certs/Makefile
> index f4c25b67aad9..b2be7eb413d3 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -60,11 +60,18 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
>  	@$(kecho) "### needs to be run as root, and uses a hardware random"
>  	@$(kecho) "### number generator if one is available."
>  	@$(kecho) "###"
> -	$(Q)openssl req -new -nodes -utf8 -$(CONFIG_MODULE_SIG_HASH) -days 36500 \
> -		-batch -x509 -config $(obj)/x509.genkey \
> -		-outform PEM -out $(obj)/signing_key.pem \
> -		-keyout $(obj)/signing_key.pem \
> +	$(Q)openssl req -new -nodes -utf8 \
> +		-batch -config $(obj)/x509.genkey \
> +		-outform PEM -out $(obj)/signing_key.csr \
> +		-keyout $(obj)/signing_key.key -extensions myexts \
>  		$($(quiet)redirect_openssl)
> +	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
> +		-outform PEM -out $(obj)/signing_key.crt \
> +		-signkey $(obj)/signing_key.key \
> +		-$(CONFIG_MODULE_SIG_HASH) -extensions myexts \
> +		-extfile $(obj)/x509.genkey \
> +		$($(quiet)redirect_openssl)
> +	@cat $(obj)/signing_key.key $(obj)/signing_key.crt >> $(obj)/signing_key.pem
>  	@$(kecho) "###"
>  	@$(kecho) "### Key pair generated."
>  	@$(kecho) "###"
> -- 
> 2.18.1
> 
> 
