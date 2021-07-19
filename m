Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6CF3CCE41
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jul 2021 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhGSHNK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 03:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbhGSHNJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 03:13:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB1C061766
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jul 2021 00:10:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m5NPg-0006h3-8C; Mon, 19 Jul 2021 09:10:04 +0200
Subject: Re: [PATCH] KEYS: trusted: Fix trusted key backends when building as
 module
To:     Andreas Rammhold <andreas@rammhold.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20210716081722.4130161-1-andreas@rammhold.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <0a684d56-66d0-184e-4853-9faafa2d243d@pengutronix.de>
Date:   Mon, 19 Jul 2021 09:10:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716081722.4130161-1-andreas@rammhold.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Andreas,

On 16.07.21 10:17, Andreas Rammhold wrote:
> Before this commit the kernel could end up with no trusted key sources
> even thought both of the currently supported backends (tpm & tee) were
> compoiled as modules. This manifested in the trusted key type not being
> registered at all.

I assume (TPM) trusted key module use worked before the TEE rework? If so,

an appropriate Fixes: Tag would then be in order.

> When checking if a CONFIG_… preprocessor variable is defined we only
> test for the builtin (=y) case and not the module (=m) case. By using
> the IS_ENABLE(…) macro we to test for both cases.

It looks to me like you could now provoke a link error if TEE is a module
and built-in trusted key core tries to link against trusted_key_tee_ops.

One solution for that IS_REACHABLE(). Another is to address the root cause,
which is the inflexible trusted keys Kconfig description:

- Trusted keys despite TEE support can still only be built when TCG_TPM is enabled
- There is no support to have TEE or TPM enabled without using those for
  enabled trusted keys as well
- As you noticed, module build of the backend has issues

I addressed these three issues in a patch[1], a month ago, but have yet to
receive feedback.

[1]: https://lore.kernel.org/linux-integrity/f8285eb0135ba30c9d846cf9dd395d1f5f8b1efc.1624364386.git-series.a.fatoum@pengutronix.de/

Cheers,
Ahmad

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
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
