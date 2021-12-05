Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9801646889F
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Dec 2021 01:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhLEAUU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Dec 2021 19:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhLEAUT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Dec 2021 19:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE7C061751;
        Sat,  4 Dec 2021 16:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77EDF60F51;
        Sun,  5 Dec 2021 00:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084C4C341C2;
        Sun,  5 Dec 2021 00:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638663412;
        bh=lCojyquGM+/dF5jVVxjfOX437pXfCnyOalRt5yhHAKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0zwyFOIMewgI3ClU5X3jTjU+gQhAjwKJD7jSmcQcrZMb6uXv9TmN0xhCmmt2luvg
         eeCDxTnervskoqbZAmlP86wj1MjgWaGZo72PKPe5ciXrqqbqExfaFTRKuInhAz9dQ7
         MQRniZUqEGICq0Qdieesz/54SlUgQBhFBnbJ01F8+0R/LN7v7mOMlNjHYq4F/wb3hg
         3iYFta0u2jfkwQ6az+KtPfsp1+iETJbpY33jZmSKJbnqUp7ETNSm7D/W4WEDQ48EBo
         ACHysCq0vABMPCNokQNBsCIAGJ9ohzoAj3uDOijpi2gAkljy1ZlPT1+a7Z2mL2pP8G
         YdA/FqrhEC3WA==
Date:   Sun, 5 Dec 2021 02:16:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 2/5] KEYS: trusted: allow users to use kernel RNG for
 key material
Message-ID: <YawE8cQ2SZjxqWUo@iki.fi>
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
 <9bd8c969d5c656825a35aab6fb0725282a8a62cc.1633946449.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bd8c969d5c656825a35aab6fb0725282a8a62cc.1633946449.git-series.a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 11, 2021 at 12:02:35PM +0200, Ahmad Fatoum wrote:
> The two existing trusted key sources don't make use of the kernel RNG,
> but instead let the hardware doing the sealing/unsealing also
> generate the random key material. However, Users may want to place

"Users" -> "users"

> less trust into the quality of the trust source's random number
> generator and instead use the kernel entropy pool, which can be
> seeded from multiple entropy sources.
> 
> Make this possible by adding a new trusted.kernel_rng parameter,
> that will force use of the kernel RNG. In its absence, it's up
> to the trust source to decide, which random numbers to use,
> maintaining the existing behavior.
> 
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: David Gstir <david@sigma-star.at>
> Tested-By: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> To: James Bottomley <jejb@linux.ibm.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Udit Agarwal <udit.agarwal@nxp.com>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt   |  7 ++++++-
>  Documentation/security/keys/trusted-encrypted.rst | 20 +++++++++-------
>  security/keys/trusted-keys/trusted_core.c         | 17 +++++++++++++-
>  3 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 43dc35fe5bc0..d5969452f063 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5772,6 +5772,13 @@
>  			first trust source as a backend which is initialized
>  			successfully during iteration.
>  
> +	trusted.kernel_rng =	[KEYS]
> +			Format: <bool>
> +			When set to true (1), the kernel random number pool
> +			is used to generate key material for trusted keys.
> +			The default is to leave the RNG's choice to each
> +			individual trust source.
> +
>  	tsc=		Disable clocksource stability checks for TSC.
>  			Format: <string>
>  			[x86] reliable: mark tsc clocksource as reliable, this
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 80d5a5af62a1..1d4b4b8f12f0 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -87,22 +87,26 @@ Key Generation
>  Trusted Keys
>  ------------
>  
> -New keys are created from random numbers generated in the trust source. They
> -are encrypted/decrypted using a child key in the storage key hierarchy.
> -Encryption and decryption of the child key must be protected by a strong
> -access control policy within the trust source.
> +New keys are created from random numbers. They are encrypted/decrypted using
> +a child key in the storage key hierarchy. Encryption and decryption of the
> +child key must be protected by a strong access control policy within the
> +trust source. The random number generator in use differs according to the
> +selected trust source:
>  
> -  *  TPM (hardware device) based RNG
> +  *  TPM: hardware device based RNG
>  
> -     Strength of random numbers may vary from one device manufacturer to
> -     another.
> +     Keys are generated within the TPM. Strength of random numbers may vary
> +     from one device manufacturer to another.
>  
> -  *  TEE (OP-TEE based on Arm TrustZone) based RNG
> +  *  TEE: OP-TEE based on Arm TrustZone based RNG
>  
>       RNG is customizable as per platform needs. It can either be direct output
>       from platform specific hardware RNG or a software based Fortuna CSPRNG
>       which can be seeded via multiple entropy sources.
>  
> +Optionally, users may specify ``trusted.kernel_rng=1`` on the kernel
> +command-line to override the used RNG with the kernel's random number pool.
> +
>  Encrypted Keys
>  --------------
>  
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index 8cab69e5d0da..569af9af8df0 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -16,12 +16,17 @@
>  #include <linux/key-type.h>
>  #include <linux/module.h>
>  #include <linux/parser.h>
> +#include <linux/random.h>
>  #include <linux/rcupdate.h>
>  #include <linux/slab.h>
>  #include <linux/static_call.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>  
> +static bool trusted_kernel_rng;
> +module_param_named(kernel_rng, trusted_kernel_rng, bool, 0);
> +MODULE_PARM_DESC(kernel_rng, "Generate key material from kernel RNG");

It's not then always kernel RNG, i.e. that is a very misleading name.

I'd prefer trusted_rng with string values "kernel", "tee". That makes
it explicit what you are using.

/Jarkko
