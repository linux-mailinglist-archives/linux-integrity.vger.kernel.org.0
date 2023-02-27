Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EAB6A3BD2
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 08:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjB0Hrz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 02:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjB0Hry (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 02:47:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64E8E;
        Sun, 26 Feb 2023 23:47:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51367B80CA6;
        Mon, 27 Feb 2023 07:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09518C433D2;
        Mon, 27 Feb 2023 07:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677484069;
        bh=IOfVTKzkzpmk/a2RVqDjpjAlItxmYpDshlK/A3JmEg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rfc+SfQCE+10mWLFriszu0RrnI5hayPP6hN4fcpLBvJvKVaiqb/CWZ5LmRZsXsWyf
         DzEjMwLb7btcJu/itlBrEYV6ik5XJ2HX8PFpZluirOinNoSw94mEK52fUjOFveX57X
         B2Fgk45vsMTKT+/Y3mOyiIjC6dN1pEm4AcUw+PGCy1mOLEevYNufuNePlz2ekPjYii
         f+SS12CC+GOrOtqJdY6PWbSGXWgt/BJiPVhgeIEDN9Rdgml/jSQ6cM1f4FRpGWj5i+
         xXhmHsl9HIblmPBpudrV72LSvNvWzQuxqrTRmJb7oI8MCU+pqPs8QZWXH7WfX2c9M0
         yqsAlunecW4vw==
Date:   Mon, 27 Feb 2023 09:47:47 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 01/12] crypto: lib - implement library version of AES in
 CFB mode
Message-ID: <Y/xgIzTC854qhr+G@kernel.org>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
 <20230216201410.15010-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216201410.15010-2-James.Bottomley@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 16, 2023 at 03:13:59PM -0500, James Bottomley wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Implement AES in CFB mode using the existing, mostly constant-time
> generic AES library implementation.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/crypto/aes.h |  5 +++
>  lib/crypto/Kconfig   |  5 +++
>  lib/crypto/Makefile  |  3 ++
>  lib/crypto/aescfb.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 lib/crypto/aescfb.c
> 
> diff --git a/include/crypto/aes.h b/include/crypto/aes.h
> index 2090729701ab..7b9e1df1ccb0 100644
> --- a/include/crypto/aes.h
> +++ b/include/crypto/aes.h
> @@ -87,4 +87,9 @@ void aes_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
>  extern const u8 crypto_aes_sbox[];
>  extern const u8 crypto_aes_inv_sbox[];
>  
> +void aescfb_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
> +		    int len, const u8 *iv);
> +void aescfb_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
> +		    int len, const u8 *iv);
> +
>  #endif
> diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
> index 45436bfc6dff..b01253cac70a 100644
> --- a/lib/crypto/Kconfig
> +++ b/lib/crypto/Kconfig
> @@ -8,6 +8,11 @@ config CRYPTO_LIB_UTILS
>  config CRYPTO_LIB_AES
>  	tristate
>  
> +config CRYPTO_LIB_AESCFB
> +	tristate
> +	select CRYPTO_LIB_AES
> +	select CRYPTO_LIB_UTILS
> +
>  config CRYPTO_LIB_AESGCM
>  	tristate
>  	select CRYPTO_LIB_AES
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 6ec2d4543d9c..33213a01aab1 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -10,6 +10,9 @@ obj-$(CONFIG_CRYPTO_LIB_CHACHA_GENERIC)		+= libchacha.o
>  obj-$(CONFIG_CRYPTO_LIB_AES)			+= libaes.o
>  libaes-y					:= aes.o
>  
> +obj-$(CONFIG_CRYPTO_LIB_AESCFB)			+= libaescfb.o
> +libaescfb-y					:= aescfb.o
> +
>  obj-$(CONFIG_CRYPTO_LIB_AESGCM)			+= libaesgcm.o
>  libaesgcm-y					:= aesgcm.o
>  
> diff --git a/lib/crypto/aescfb.c b/lib/crypto/aescfb.c
> new file mode 100644
> index 000000000000..e9de1c6d874a
> --- /dev/null
> +++ b/lib/crypto/aescfb.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Minimal library implementation of AES in CFB mode
> + *
> + * Copyright 2023 Google LLC
> + */
> +
> +#include <linux/module.h>
> +
> +#include <crypto/algapi.h>
> +#include <crypto/aes.h>
> +
> +#include <asm/irqflags.h>

I'd remove the newlines in-between.

> +
> +static void aescfb_encrypt_block(const struct crypto_aes_ctx *ctx, void *dst,
> +				 const void *src)
> +{
> +	unsigned long flags;
> +
> +	/*
> +	 * In AES-CFB, the AES encryption operates on known 'plaintext' (the IV
> +	 * and ciphertext), making it susceptible to timing attacks on the
> +	 * encryption key. The AES library already mitigates this risk to some
> +	 * extent by pulling the entire S-box into the caches before doing any
> +	 * substitutions, but this strategy is more effective when running with
> +	 * interrupts disabled.
> +	 */
> +	local_irq_save(flags);
> +	aes_encrypt(ctx, dst, src);
> +	local_irq_restore(flags);
> +}
> +
> +void aescfb_encrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
> +		    int len, const u8 *iv)
> +{
> +	while (len > 0) {
> +		u8 ks[AES_BLOCK_SIZE];
> +
> +		aescfb_encrypt_block(ctx, ks, iv);
> +		crypto_xor_cpy(dst, src, ks, min(len, AES_BLOCK_SIZE));
> +		iv = dst;
> +
> +		dst += AES_BLOCK_SIZE;
> +		src += AES_BLOCK_SIZE;
> +		len -= AES_BLOCK_SIZE;
> +	}
> +}
> +
> +void aescfb_decrypt(const struct crypto_aes_ctx *ctx, u8 *dst, const u8 *src,
> +		    int len, const u8 *iv)
> +{
> +	u8 ks[2][AES_BLOCK_SIZE];
> +
> +	aescfb_encrypt_block(ctx, ks[0], iv);
> +
> +	for (int i = 0; len > 0; i ^= 1) {
> +		if (len > AES_BLOCK_SIZE)
> +			/*
> +			 * Generate the keystream for the next block before
> +			 * performing the XOR, as that may update in place and
> +			 * overwrite the ciphertext.
> +			 */
> +			aescfb_encrypt_block(ctx, ks[!i], src);
> +
> +		crypto_xor_cpy(dst, src, ks[i], min(len, AES_BLOCK_SIZE));
> +
> +		dst += AES_BLOCK_SIZE;
> +		src += AES_BLOCK_SIZE;
> +		len -= AES_BLOCK_SIZE;
> +	}
> +}
> +
> +MODULE_DESCRIPTION("Generic AES-CFB library");
> +MODULE_AUTHOR("Ard Biesheuvel <ardb@kernel.org>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.35.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
