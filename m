Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9F4C172D
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 16:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiBWPlV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 10:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbiBWPlN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 10:41:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67651BECD3;
        Wed, 23 Feb 2022 07:40:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0541061851;
        Wed, 23 Feb 2022 15:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22D4C340E7;
        Wed, 23 Feb 2022 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645630836;
        bh=8IktSqdB85n+lg+7e0S9tm1HlnzAvjvyAcTHddVcl48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOWsE+Dwps7RGGwJq5CF82rcPW4Cajm7jGQms+3TSQz0peUcA8SY7gnOaGT0LF3L+
         I+Z+qbcrjBT6dPz9IYTg44nXBRCmW6nDZ9eRozMKuuNDrNEaJk0UemHU10uqjPrd7b
         pD2yqXPUyK6rjF+EqqxJtPQKjj1X799AXCdR2f1PjE4krNgtWxgF1jgP+MdM3ZWGNM
         8i1uqlVFNEin9RkvzqBALtk1I7zP8slQR0JkQrw29mg4Y4BPXnp33SBBwfJlkOst2A
         ITquYHoXPkvbOVC3BKPBVIAFmOTv6W90oAdG0Bkxflfi+8aYnDICz3tkeWrkANF4jm
         K2wmGU/7ScniQ==
Date:   Wed, 23 Feb 2022 16:41:12 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 4/5] crypto: caam - add in-kernel interface for blob
 generator
Message-ID: <YhZVmBy3/nWbqf+/@iki.fi>
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
 <20220222195819.2313913-5-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222195819.2313913-5-a.fatoum@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 22, 2022 at 08:58:18PM +0100, Ahmad Fatoum wrote:
> The NXP Cryptographic Acceleration and Assurance Module (CAAM)
> can be used to protect user-defined data across system reboot:
> 
>   - When the system is fused and boots into secure state, the master
>     key is a unique never-disclosed device-specific key
>   - random key is encrypted by key derived from master key
>   - data is encrypted using the random key
>   - encrypted data and its encrypted random key are stored alongside
>   - This blob can now be safely stored in non-volatile memory
> 
> On next power-on:
>   - blob is loaded into CAAM
>   - CAAM writes decrypted data either into memory or key register
> 
> Add functions to realize encrypting and decrypting into memory alongside
> the CAAM driver.
> 
> They will be used in a later commit as a source for the trusted key
> seal/unseal mechanism.
> 
> Reviewed-by: David Gstir <david@sigma-star.at>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Tested-By: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> To: "Horia Geantă" <horia.geanta@nxp.com>
> To: Aymen Sghaier <aymen.sghaier@nxp.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> To: "David S. Miller" <davem@davemloft.net>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  drivers/crypto/caam/Kconfig    |   3 +
>  drivers/crypto/caam/Makefile   |   1 +
>  drivers/crypto/caam/blob_gen.c | 230 +++++++++++++++++++++++++++++++++
>  include/soc/fsl/caam-blob.h    |  56 ++++++++
>  4 files changed, 290 insertions(+)
>  create mode 100644 drivers/crypto/caam/blob_gen.c
>  create mode 100644 include/soc/fsl/caam-blob.h
> 
> diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
> index 84ea7cba5ee5..ea9f8b1ae981 100644
> --- a/drivers/crypto/caam/Kconfig
> +++ b/drivers/crypto/caam/Kconfig
> @@ -151,6 +151,9 @@ config CRYPTO_DEV_FSL_CAAM_RNG_API
>  	  Selecting this will register the SEC4 hardware rng to
>  	  the hw_random API for supplying the kernel entropy pool.
>  
> +config CRYPTO_DEV_FSL_CAAM_BLOB_GEN
> +	bool
> +
>  endif # CRYPTO_DEV_FSL_CAAM_JR
>  
>  endif # CRYPTO_DEV_FSL_CAAM
> diff --git a/drivers/crypto/caam/Makefile b/drivers/crypto/caam/Makefile
> index 3570286eb9ce..25f7ae5a4642 100644
> --- a/drivers/crypto/caam/Makefile
> +++ b/drivers/crypto/caam/Makefile
> @@ -21,6 +21,7 @@ caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += caamalg_qi.o
>  caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_AHASH_API) += caamhash.o
>  caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_RNG_API) += caamrng.o
>  caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_PKC_API) += caampkc.o pkc_desc.o
> +caam_jr-$(CONFIG_CRYPTO_DEV_FSL_CAAM_BLOB_GEN) += blob_gen.o
>  
>  caam-$(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI) += qi.o
>  ifneq ($(CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_QI),)
> diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
> new file mode 100644
> index 000000000000..513d3f90e438
> --- /dev/null
> +++ b/drivers/crypto/caam/blob_gen.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
> + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
> + */
> +
> +#include <linux/device.h>
> +#include <soc/fsl/caam-blob.h>
> +
> +#include "compat.h"
> +#include "desc_constr.h"
> +#include "desc.h"
> +#include "error.h"
> +#include "intern.h"
> +#include "jr.h"
> +#include "regs.h"
> +
> +struct caam_blob_priv {
> +	struct device jrdev;
> +};
> +
> +struct caam_blob_job_result {
> +	int err;
> +	struct completion completion;
> +};
> +
> +static void caam_blob_job_done(struct device *dev, u32 *desc, u32 err, void *context)
> +{
> +	struct caam_blob_job_result *res = context;
> +	int ecode = 0;
> +
> +	dev_dbg(dev, "%s %d: err 0x%x\n", __func__, __LINE__, err);
> +
> +	if (err)
> +		ecode = caam_jr_strstatus(dev, err);
> +
> +	res->err = ecode;
> +
> +	/*
> +	 * Upon completion, desc points to a buffer containing a CAAM job
> +	 * descriptor which encapsulates data into an externally-storable
> +	 * blob.
> +	 */
> +	complete(&res->completion);
> +}
> +
> +static u32 *caam_blob_alloc_desc(size_t keymod_len)
> +{
> +	size_t len;
> +
> +	/* header + (key mod immediate) + 2x pointers + op */
> +	len = 4 + (4 + ALIGN(keymod_len, 4)) + 2*(4 + 4 + CAAM_PTR_SZ_MAX) + 4;

Nit: the amount of magic numbers is overwhelming here. I neither understand
the statement nor how that comment should help me to understand it.

BR, Jarkko
