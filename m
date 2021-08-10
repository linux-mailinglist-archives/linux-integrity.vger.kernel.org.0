Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEECA3E5913
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhHJL3e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 07:29:34 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:26020 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbhHJL3e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 07:29:34 -0400
Date:   Tue, 10 Aug 2021 11:29:04 +0000
Authentication-Results: mail-40131.protonmail.ch; dkim=none
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
From:   David Gstir <david@sigma-star.at>
Cc:     =?utf-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Reply-To: David Gstir <david@sigma-star.at>
Subject: Re: [PATCH 3/4] crypto: caam - add in-kernel interface for blob generator
Message-ID: <796E18E6-1329-40D6-B12F-4CE6C90DD988@sigma-star.at>
In-Reply-To: <4078060ab2e44114af8204b4defea4f3d4b9e285.1626885907.git-series.a.fatoum@pengutronix.de>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de> <4078060ab2e44114af8204b4defea4f3d4b9e285.1626885907.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.0 required=10.0 tests=ALL_TRUSTED shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ahmad,

> On 21.07.2021, at 18:48, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:


[...]

> diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
> new file mode 100644
> index 000000000000..513d3f90e438
> --- /dev/null
> +++ b/drivers/crypto/caam/blob_gen.c
> @@ -0,0 +1,230 @@

[...]

> +
> +int caam_encap_blob(struct caam_blob_priv *priv, const char *keymod,
> +		    void *input, void *output, size_t length)
> +{
> +	u32 *desc;
> +	struct device *jrdev = &priv->jrdev;
> +	dma_addr_t dma_in, dma_out;
> +	struct caam_blob_job_result testres;
> +	size_t keymod_len = strlen(keymod);
> +	int ret;
> +
> +	if (length <= CAAM_BLOB_OVERHEAD || keymod_len > CAAM_BLOB_KEYMOD_LENGTH)

The docs for this function mention the length <= CAAM_BLOB_MAX_LEN
restriction. This is not checked here. Is this intended?

Since you already assert that MAX_BLOB_SIZE <= CAAM_BLOB_MAX_LEN
in security/keys/trusted-keys/trusted_caam.c, this will never
be an issue for CAAM-based trusted-keys though.


> +		return -EINVAL;
> +
> +	desc = caam_blob_alloc_desc(keymod_len);
> +	if (!desc) {
> +		dev_err(jrdev, "unable to allocate desc\n");
> +		return -ENOMEM;
> +	}
> +

[...]

> diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
> new file mode 100644
> index 000000000000..aebbc9335f64
> --- /dev/null
> +++ b/include/soc/fsl/caam-blob.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
> + */
> +
> +#ifndef __CAAM_BLOB_GEN
> +#define __CAAM_BLOB_GEN
> +
> +#include <linux/types.h>
> +
> +#define CAAM_BLOB_KEYMOD_LENGTH		16
> +#define CAAM_BLOB_OVERHEAD		(32 + 16)
> +#define CAAM_BLOB_MAX_LEN		4096
> +
> +struct caam_blob_priv;
> +
> +/** caam_blob_gen_init - initialize blob generation
> + *
> + * returns either pointer to new caam_blob_priv instance
> + * or error pointer
> + */
> +struct caam_blob_priv *caam_blob_gen_init(void);
> +
> +/** caam_blob_gen_init - free blob generation resources

s/init/exit/


> + *
> + * @priv: instance returned by caam_blob_gen_init
> + */
> +void caam_blob_gen_exit(struct caam_blob_priv *priv);


Except these minor things, I noticed no issues with this whole series:

Reviewed-by: David Gstir <david@sigma-star.at>


