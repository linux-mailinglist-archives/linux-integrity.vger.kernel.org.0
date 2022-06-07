Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488FA53F5F7
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 08:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiFGGPy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 02:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiFGGPx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 02:15:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E71D771A
        for <linux-integrity@vger.kernel.org>; Mon,  6 Jun 2022 23:15:52 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nySVL-0002dw-5c; Tue, 07 Jun 2022 08:15:51 +0200
Message-ID: <1eda7b47-1f9f-9188-efbe-e135326d7585@pengutronix.de>
Date:   Tue, 7 Jun 2022 08:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] trusted-keys-fix-migratable-logic
To:     david.safford@gmail.com, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <874177b3b34b10679829dbf011e5bde7f37a4c9c.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <874177b3b34b10679829dbf011e5bde7f37a4c9c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello David,

On 03.06.22 15:28, david.safford@gmail.com wrote:
> When creating (sealing) a new trusted key, migratable
> trusted keys have the FIXED_TPM and FIXED_PERM attributes
> set, and non-migratable keys don't. This is backwards, and
> also causes creation to fail when creating a migratable key
> under a migratable parent. (The TPM thinks you are trying to
> seal a non-migratable blob under a migratable parent.)
> 
> The following simple patch fixes the logic, and has been
> tested for all four combinations of migratable and non-migratable
> trusted keys and parent storage keys. With this logic, you will
> get a proper failure if you try to create a non-migratable 
> trusted key under a migratable parent storage key, and all other
> combinations work correctly.
> 
> david safford

Thanks for your patch. It looks sensible, but needs some work to
be aligned to the kernel patch guidelines, documented here:
Documentation/process/submitting-patches.rst

What I noticed in particular:

  - Your Signed-off-by is missing
  - Your patch title needs alignment to others in the revision history,
    you could change it e.g. "KEYS: trusted: tpm2: Fix migratable logic"
  - The To:/Cc: list is incomplete. Patches to this file are normally
    merged via Jarkko's tree. get_maintainers.pl will produce a full list
    of people and mailing lists to copy.

Looking forward to your v2.

Cheers,
Ahmad

> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..2b2c8eb258d5 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -283,8 +283,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	/* key properties */
>  	flags = 0;
>  	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> -	flags |= payload->migratable ? (TPM2_OA_FIXED_TPM |
> -					TPM2_OA_FIXED_PARENT) : 0;
> +	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM |
> +					    TPM2_OA_FIXED_PARENT);
>  	tpm_buf_append_u32(&buf, flags);
>  
>  	/* policy */


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
