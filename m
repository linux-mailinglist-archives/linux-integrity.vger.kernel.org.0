Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450D1442052
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Nov 2021 19:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhKASy5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Nov 2021 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhKASyz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Nov 2021 14:54:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB96C061764
        for <linux-integrity@vger.kernel.org>; Mon,  1 Nov 2021 11:52:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mhcPo-0004xR-KL; Mon, 01 Nov 2021 19:52:16 +0100
Subject: Re: [PATCH RESEND] KEYS: trusted: Fix trusted key backends when
 building as module
To:     andreas@rammhold.de, James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211101184115.1468041-1-andreas@rammhold.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <26c8be4c-c1cd-3e53-1713-c5d9a667f9c5@pengutronix.de>
Date:   Mon, 1 Nov 2021 19:52:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211101184115.1468041-1-andreas@rammhold.de>
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

On 01.11.21 19:41, andreas@rammhold.de wrote:
> From: Andreas Rammhold <andreas@rammhold.de>
> 
> Before this commit the kernel could end up with no trusted key sources
> even though both of the currently supported backends (TPM and TEE) were
> compiled as modules. This manifested in the trusted key type not being
> registered at all.
> 
> When checking if a CONFIG_… preprocessor variable is defined we only
> test for the builtin (=y) case and not the module (=m) case. By using
> the IS_REACHABLE() macro we do test for both cases.
> 
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>

You dropped the Reviewed-by Tags. Feel free to add

Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

as well. You should also keep the patch revision (i.e.
"PATCH (RESEND v3|v3 RESEND"), even for RESENDs.

Thanks!
Ahmad

> ---
> 
> This is a resend becuase of this unfortunate timeline:
>   - 2021-05-09: Regression hits mainline with v5.13-rc1
>   - 2021-07-16: Issue reported. v1 of this patch sent out
>   - 2021-07-21: Ahmad sends out alternative patch to fix issue
>   - 2021-07-27: Jarkko (Maintainer) NACKs Ahmad's patch because of scope
>   - 2021-07-29: v2 with fixes sent out
>   - 2021-07-29: Jarkko gives his Reviewed-by and requests one more v3
>   - 2021-07-31: v3 sent out
>   - 2021-09-13: Pinged, no feedback
>   - 2021-09-27: Pinged, Mimi (Maintainer) comments due to to misunderstanding.
>                 Question about why this is not merged ignored
>   - 2021-10-11: Pinged, no feedback
> 
> v3:
> * Fixed patch formatting
> 
> v2:
> * Fixed commit message
> * Switched from IS_DEFINED() to IS_REACHABLE()
> 
> 
>  security/keys/trusted-keys/trusted_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index d5c891d8d3534..5b35f1b876441 100644
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
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
