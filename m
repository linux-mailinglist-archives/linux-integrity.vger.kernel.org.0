Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325BF3DB07B
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jul 2021 03:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhG3BCu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 21:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhG3BCu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 21:02:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58B9960F12;
        Fri, 30 Jul 2021 01:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627606966;
        bh=qGB1okmmj8o/nQTkBj4e1glQqFEEf5vQoQbggtmQbJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNuxD5aMmrakeHQtd8tIA9SVMkbUAYqSDs0FepMKdJ/stYgnVn7+3TZFtE0gTY4hF
         FKy64cyMyYevP50zNhtLDblwKYuZu5DwiwJhJ8zuoojrUPYuLBaTHJXO8vk7itOPO4
         VRLf9HV0UwuOOe2uhqkQEc92YSt7PDGghZzWuP9LYt9REkPVgAbWWtRjbVHUWX0MG3
         QMB5slRGVpXEM204br7YRWA/LjDZ8pUF5uRaDw1E9mE2dNQeP1yhoTwC/Xj+4M4WGk
         wZZa39oHUtPCWB++nMa578PpBKBF3mwHyna/Ync4CpvgivDa/nngGxuXYfjQQwbTbr
         9U+SHXeLSqmyg==
Date:   Fri, 30 Jul 2021 04:02:42 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Andreas Rammhold <andreas@rammhold.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: Fix trusted key backends when building
 as module
Message-ID: <20210730010242.4hbx7ehk5d5xllvp@kernel.org>
References: <20210729183333.1070629-1-andreas@rammhold.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210729183333.1070629-1-andreas@rammhold.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 29, 2021 at 08:33:32PM +0200, Andreas Rammhold wrote:
> Before this commit the kernel could end up with no trusted key sources
> even though both of the currently supported backends (TPM and TEE) were
> compiled as modules. This manifested in the trusted key type not being
> registered at all.
> 
> When checking if a CONFIG_… preprocessor variable is defined we only
> test for the builtin (=y) case and not the module (=m) case. By using
> the IS_REACHABLE() macro we do test for both cases.
> 
> 
> v2:
> * Fixed commit message
> * Switched from IS_DEFINED() to IS_REACHABLE()

Please put these below '---' because otherwise they included to the commit
log.

> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> ---
> 
> Here is the version that was proposed by Ahmad [1] in response to the
> feedback received in the "[PATCH v2] KEYS: trusted: fix use as module
> when CONFIG_TCG_TPM=m" discussion [2].
> 
> I have tested both of the patches on v5.13 and they both fix the problem
> I originally encountered.
> 
> [1] https://lore.kernel.org/keyrings/fe39a449-88df-766b-a13a-290f4847d43e@pengutronix.de/
> [2] https://lore.kernel.org/keyrings/20210721160258.7024-1-a.fatoum@pengutronix.de/
> 
> 
>  security/keys/trusted-keys/trusted_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index d5c891d8d353..5b35f1b87644 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>  
>  static const struct trusted_key_source trusted_key_sources[] = {
> -#if defined(CONFIG_TCG_TPM)
> +#if IS_REACHABLE(CONFIG_TCG_TPM)
>  	{ "tpm", &trusted_key_tpm_ops },
>  #endif
> -#if defined(CONFIG_TEE)
> +#if IS_REACHABLE(CONFIG_TEE)
>  	{ "tee", &trusted_key_tee_ops },
>  #endif
>  };
> -- 
> 2.32.0
> 
>

Can you send a one more v3 without the changelog in the commit message
and also add

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
