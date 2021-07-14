Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC7E3C8185
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 11:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhGNJ1o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbhGNJ1n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 05:27:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4FEC06175F
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jul 2021 02:24:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m3b8G-0007Mc-Hj; Wed, 14 Jul 2021 11:24:44 +0200
Subject: Re: [PATCH 1/3] crypto: mxs-dcp: Add support for hardware provided
 keys
To:     Richard Weinberger <richard@nod.at>, keyrings@vger.kernel.org
Cc:     David Gstir <david@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Bottomley <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <20210614201620.30451-1-richard@nod.at>
 <20210614201620.30451-2-richard@nod.at>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <76db3736-5a5f-bf7b-3b52-62d01a84ee2d@pengutronix.de>
Date:   Wed, 14 Jul 2021 11:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614201620.30451-2-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Richard,

Let's trade reviews to get the ball rolling?

On 14.06.21 22:16, Richard Weinberger wrote:
> DCP is capable to performing AES with hardware-bound keys.
> These keys are not stored in main memory and are therefore not directly
> accessible by the operating system.
> 
> So instead of feeding the key into DCP, we need to place a
> reference to such a key before initiating the crypto operation.
> Keys are referenced by a one byte identifiers.
> 
> DCP supports 6 different keys: 4 slots in the secure memory area,
> a one time programmable key which can be burnt via on-chip fuses
> and an unique device key.
> 
> Using these keys is restricted to in-kernel users that use them as building
> block for other crypto tools such as trusted keys. Allowing userspace
> (e.g. via AF_ALG) to use these keys to crypt or decrypt data is a security
> risk, because there is no access control mechanism.
> 
> Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: keyrings@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Co-developed-by: David Gstir <david@sigma-star.at>
> Signed-off-by: David Gstir <david@sigma-star.at>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/crypto/mxs-dcp.c | 110 ++++++++++++++++++++++++++++++++++-----
>  include/linux/mxs-dcp.h  |  19 +++++++
>  2 files changed, 117 insertions(+), 12 deletions(-)
>  create mode 100644 include/linux/mxs-dcp.h
> 
> diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
> index d6a7784d2988..c3e0c0ccbc20 100644
> --- a/drivers/crypto/mxs-dcp.c
> +++ b/drivers/crypto/mxs-dcp.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/stmp_device.h>
>  #include <linux/clk.h>
> +#include <linux/mxs-dcp.h>

The CAAM specific headers are in <soc/fsl/*.h>.
Should this be done likewise here as well?

>  
>  #include <crypto/aes.h>
>  #include <crypto/sha1.h>
> @@ -101,6 +102,7 @@ struct dcp_async_ctx {
>  	struct crypto_skcipher		*fallback;
>  	unsigned int			key_len;
>  	uint8_t				key[AES_KEYSIZE_128];
> +	bool				refkey;
>  };
>  
>  struct dcp_aes_req_ctx {
> @@ -155,6 +157,7 @@ static struct dcp *global_sdcp;
>  #define MXS_DCP_CONTROL0_HASH_TERM		(1 << 13)
>  #define MXS_DCP_CONTROL0_HASH_INIT		(1 << 12)
>  #define MXS_DCP_CONTROL0_PAYLOAD_KEY		(1 << 11)
> +#define MXS_DCP_CONTROL0_OTP_KEY		(1 << 10)
>  #define MXS_DCP_CONTROL0_CIPHER_ENCRYPT		(1 << 8)
>  #define MXS_DCP_CONTROL0_CIPHER_INIT		(1 << 9)
>  #define MXS_DCP_CONTROL0_ENABLE_HASH		(1 << 6)
> @@ -168,6 +171,8 @@ static struct dcp *global_sdcp;
>  #define MXS_DCP_CONTROL1_CIPHER_MODE_ECB	(0 << 4)
>  #define MXS_DCP_CONTROL1_CIPHER_SELECT_AES128	(0 << 0)
>  
> +#define MXS_DCP_CONTROL1_KEY_SELECT_SHIFT	8
> +
>  static int mxs_dcp_start_dma(struct dcp_async_ctx *actx)
>  {
>  	struct dcp *sdcp = global_sdcp;
> @@ -219,15 +224,18 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
>  	struct dcp *sdcp = global_sdcp;
>  	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
>  	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
> +	dma_addr_t src_phys, dst_phys, key_phys = {0};

Why = {0}; ? dma_addr_t is a scalar type and the value is always
written here before access.

> +	bool key_referenced = actx->refkey;
>  	int ret;
>  
> -	dma_addr_t key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
> -					     2 * AES_KEYSIZE_128,
> -					     DMA_TO_DEVICE);
> -	dma_addr_t src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
> -					     DCP_BUF_SZ, DMA_TO_DEVICE);
> -	dma_addr_t dst_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_out_buf,
> -					     DCP_BUF_SZ, DMA_FROM_DEVICE);
> +	if (!key_referenced) {
> +		key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
> +					  2 * AES_KEYSIZE_128, DMA_TO_DEVICE);
> +	}
> +	src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf, DCP_BUF_SZ,
> +				  DMA_TO_DEVICE);
> +	dst_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_out_buf, DCP_BUF_SZ,
> +				  DMA_FROM_DEVICE);
>  
>  	if (actx->fill % AES_BLOCK_SIZE) {
>  		dev_err(sdcp->dev, "Invalid block size!\n");
> @@ -240,8 +248,13 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
>  		    MXS_DCP_CONTROL0_INTERRUPT |
>  		    MXS_DCP_CONTROL0_ENABLE_CIPHER;
>  
> -	/* Payload contains the key. */
> -	desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
> +	if (key_referenced) {
> +		/* Set OTP key bit to select the key via KEY_SELECT. */
> +		desc->control0 |= MXS_DCP_CONTROL0_OTP_KEY;
> +	} else {
> +		/* Payload contains the key. */
> +		desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
> +	}
>  
>  	if (rctx->enc)
>  		desc->control0 |= MXS_DCP_CONTROL0_CIPHER_ENCRYPT;
> @@ -255,6 +268,9 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
>  	else
>  		desc->control1 |= MXS_DCP_CONTROL1_CIPHER_MODE_CBC;
>  
> +	if (key_referenced)
> +		desc->control1 |= sdcp->coh->aes_key[0] << MXS_DCP_CONTROL1_KEY_SELECT_SHIFT;
> +
>  	desc->next_cmd_addr = 0;
>  	desc->source = src_phys;
>  	desc->destination = dst_phys;
> @@ -265,8 +281,10 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
>  	ret = mxs_dcp_start_dma(actx);
>  
>  aes_done_run:
> -	dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
> -			 DMA_TO_DEVICE);
> +	if (!key_referenced) {
> +		dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
> +				 DMA_TO_DEVICE);
> +	}
>  	dma_unmap_single(sdcp->dev, src_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
>  	dma_unmap_single(sdcp->dev, dst_phys, DCP_BUF_SZ, DMA_FROM_DEVICE);
>  
> @@ -454,7 +472,7 @@ static int mxs_dcp_aes_enqueue(struct skcipher_request *req, int enc, int ecb)
>  	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
>  	int ret;
>  
> -	if (unlikely(actx->key_len != AES_KEYSIZE_128))
> +	if (unlikely(actx->key_len != AES_KEYSIZE_128 && !actx->refkey))
>  		return mxs_dcp_block_fallback(req, enc);
>  
>  	rctx->enc = enc;
> @@ -501,6 +519,7 @@ static int mxs_dcp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  	 * there can still be an operation in progress.
>  	 */
>  	actx->key_len = len;
> +	actx->refkey = false;
>  	if (len == AES_KEYSIZE_128) {
>  		memcpy(actx->key, key, len);
>  		return 0;
> @@ -517,6 +536,33 @@ static int mxs_dcp_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  	return crypto_skcipher_setkey(actx->fallback, key, len);
>  }
>  
> +static int mxs_dcp_aes_setrefkey(struct crypto_skcipher *tfm, const u8 *key,
> +				 unsigned int len)
> +{
> +	struct dcp_async_ctx *actx = crypto_skcipher_ctx(tfm);
> +	int ret = -EINVAL;
> +
> +	if (len != DCP_PAES_KEYSIZE)
> +		goto out;

Nitpick: there is no cleanup, so why not return -EINVAL here
and unconditionally return 0 below?

> +
> +	actx->key_len = len;
> +	actx->refkey = true;
> +
> +	switch (key[0]) {
> +	case DCP_PAES_KEY_SLOT0:
> +	case DCP_PAES_KEY_SLOT1:
> +	case DCP_PAES_KEY_SLOT2:
> +	case DCP_PAES_KEY_SLOT3:
> +	case DCP_PAES_KEY_UNIQUE:
> +	case DCP_PAES_KEY_OTP:
> +		memcpy(actx->key, key, len);
> +		ret = 0;
> +	}

In the error case you return -EINVAL below, but you still write
into actx. Is that intentional?

> +
> +out:
> +	return ret;
> +}
> +
>  static int mxs_dcp_aes_fallback_init_tfm(struct crypto_skcipher *tfm)
>  {
>  	const char *name = crypto_tfm_alg_name(crypto_skcipher_tfm(tfm));
> @@ -540,6 +586,13 @@ static void mxs_dcp_aes_fallback_exit_tfm(struct crypto_skcipher *tfm)
>  	crypto_free_skcipher(actx->fallback);
>  }
>  
> +static int mxs_dcp_paes_init_tfm(struct crypto_skcipher *tfm)
> +{
> +	crypto_skcipher_set_reqsize(tfm, sizeof(struct dcp_aes_req_ctx));
> +
> +	return 0;
> +}
> +
>  /*
>   * Hashing (SHA1/SHA256)
>   */
> @@ -882,6 +935,39 @@ static struct skcipher_alg dcp_aes_algs[] = {
>  		.ivsize			= AES_BLOCK_SIZE,
>  		.init			= mxs_dcp_aes_fallback_init_tfm,
>  		.exit			= mxs_dcp_aes_fallback_exit_tfm,
> +	}, {
> +		.base.cra_name		= "ecb(paes)",
> +		.base.cra_driver_name	= "ecb-paes-dcp",
> +		.base.cra_priority	= 401,
> +		.base.cra_alignmask	= 15,
> +		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_INTERNAL,
> +		.base.cra_blocksize	= AES_BLOCK_SIZE,
> +		.base.cra_ctxsize	= sizeof(struct dcp_async_ctx),
> +		.base.cra_module	= THIS_MODULE,
> +
> +		.min_keysize		= DCP_PAES_KEYSIZE,
> +		.max_keysize		= DCP_PAES_KEYSIZE,
> +		.setkey			= mxs_dcp_aes_setrefkey,
> +		.encrypt		= mxs_dcp_aes_ecb_encrypt,
> +		.decrypt		= mxs_dcp_aes_ecb_decrypt,
> +		.init			= mxs_dcp_paes_init_tfm,
> +	}, {
> +		.base.cra_name		= "cbc(paes)",
> +		.base.cra_driver_name	= "cbc-paes-dcp",
> +		.base.cra_priority	= 401,
> +		.base.cra_alignmask	= 15,
> +		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_INTERNAL,
> +		.base.cra_blocksize	= AES_BLOCK_SIZE,
> +		.base.cra_ctxsize	= sizeof(struct dcp_async_ctx),
> +		.base.cra_module	= THIS_MODULE,
> +
> +		.min_keysize		= DCP_PAES_KEYSIZE,
> +		.max_keysize		= DCP_PAES_KEYSIZE,
> +		.setkey			= mxs_dcp_aes_setrefkey,
> +		.encrypt		= mxs_dcp_aes_cbc_encrypt,
> +		.decrypt		= mxs_dcp_aes_cbc_decrypt,
> +		.ivsize			= AES_BLOCK_SIZE,
> +		.init			= mxs_dcp_paes_init_tfm,
>  	},
>  };
>  
> diff --git a/include/linux/mxs-dcp.h b/include/linux/mxs-dcp.h
> new file mode 100644
> index 000000000000..df6678ee10a1
> --- /dev/null
> +++ b/include/linux/mxs-dcp.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 sigma star gmbh
> + * Authors: David Gstir <david@sigma-star.at>
> + *          Richard Weinberger <richard@sigma-star.at>
> + */
> +
> +#ifndef MXS_DCP_H
> +#define MXS_DCP_H
> +
> +#define DCP_PAES_KEYSIZE 1
> +#define DCP_PAES_KEY_SLOT0 0x00
> +#define DCP_PAES_KEY_SLOT1 0x01
> +#define DCP_PAES_KEY_SLOT2 0x02
> +#define DCP_PAES_KEY_SLOT3 0x03
> +#define DCP_PAES_KEY_UNIQUE 0xfe
> +#define DCP_PAES_KEY_OTP 0xff
> +
> +#endif /* MXS_DCP_H */

Cheers,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
