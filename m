Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8127D3D6C25
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 04:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhG0COj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhG0COi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E5D460FEE;
        Tue, 27 Jul 2021 02:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627354506;
        bh=N66m5BqH6fBSNOyaUyEyoRc1HO/1ORZUE+4M0QQOz9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDPj7DNiwMzaTMTCmJQI3c2bPDlRiJGtsz5P5RMkA+7ONiJQLE7n32QIYjCCPD7vW
         tqZGA4s9//e7YWBI+SSJf8L9cVU8/Sjv+RcOXvqpy/KuAdgCSe8fZm8ZorPhcb7DYV
         aINh1jmJOUt+IyGoUIFvAySOSZ1+DYqh0EJrCG/DeFny8Jp4BSR1lCP3AuwbTsLQWl
         NS/AwnAjevQySPglrvNkPUwt9X18EmoxJpAcwkeJUxbTAhqT9a0eJBiD76xiAZK/3z
         eNWkcEK4o0mHUSMMx3prujAuzw7vt49zZ3alo17NiQJO7ESaNyi8vC5RstX/mw2iuS
         ZAu8HNqifKDXw==
Date:   Tue, 27 Jul 2021 05:55:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Andreas Rammhold <andreas@rammhold.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Fix trusted key backends when building as
 module
Message-ID: <20210727025504.w4afe4m6e2k57cve@kernel.org>
References: <20210716081722.4130161-1-andreas@rammhold.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210716081722.4130161-1-andreas@rammhold.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 16, 2021 at 10:17:22AM +0200, Andreas Rammhold wrote:
> Before this commit the kernel could end up with no trusted key sources
> even thought both of the currently supported backends (tpm & tee) were

Nit: "TPM and TEE" instead of "tpm & tee"

> compoiled as modules. This manifested in the trusted key type not being
> registered at all.

Do you have a commit ID for the failing commit?

> When checking if a CONFIG_… preprocessor variable is defined we only
> test for the builtin (=y) case and not the module (=m) case. By using
> the IS_ENABLE(…) macro we to test for both cases.

Nit: IS_ENABLED() (without dots inside, missing 'D').

> 
> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> ---
>  security/keys/trusted-keys/trusted_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index d5c891d8d353..fd640614b168 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>  
>  static const struct trusted_key_source trusted_key_sources[] = {
> -#if defined(CONFIG_TCG_TPM)
> +#if IS_ENABLED(CONFIG_TCG_TPM)
>  	{ "tpm", &trusted_key_tpm_ops },
>  #endif
> -#if defined(CONFIG_TEE)
> +#if IS_ENABLED(CONFIG_TEE)
>  	{ "tee", &trusted_key_tee_ops },
>  #endif
>  };
> -- 
> 2.32.0
> 
> 

/Jarkko
