Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAB3E8E7C
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbhHKKX0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 06:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbhHKKXZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 06:23:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD23C061798
        for <linux-integrity@vger.kernel.org>; Wed, 11 Aug 2021 03:23:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mDlNw-0005uA-OH; Wed, 11 Aug 2021 12:22:56 +0200
Subject: Re: [PATCH 3/4] crypto: caam - add in-kernel interface for blob
 generator
To:     David Gstir <david@sigma-star.at>
Cc:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
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
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <4078060ab2e44114af8204b4defea4f3d4b9e285.1626885907.git-series.a.fatoum@pengutronix.de>
 <796E18E6-1329-40D6-B12F-4CE6C90DD988@sigma-star.at>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <7cc83edd-dc39-ee7e-d18c-30b2492247ea@pengutronix.de>
Date:   Wed, 11 Aug 2021 12:22:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <796E18E6-1329-40D6-B12F-4CE6C90DD988@sigma-star.at>
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

On 10.08.21 13:29, David Gstir wrote:
> Hi Ahmad,
> 
>> On 21.07.2021, at 18:48, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> 
> 
> [...]
> 
>> diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
>> new file mode 100644
>> index 000000000000..513d3f90e438
>> --- /dev/null
>> +++ b/drivers/crypto/caam/blob_gen.c
>> @@ -0,0 +1,230 @@
> 
> [...]
> 
>> +
>> +int caam_encap_blob(struct caam_blob_priv *priv, const char *keymod,
>> +		    void *input, void *output, size_t length)
>> +{
>> +	u32 *desc;
>> +	struct device *jrdev = &priv->jrdev;
>> +	dma_addr_t dma_in, dma_out;
>> +	struct caam_blob_job_result testres;
>> +	size_t keymod_len = strlen(keymod);
>> +	int ret;
>> +
>> +	if (length <= CAAM_BLOB_OVERHEAD || keymod_len > CAAM_BLOB_KEYMOD_LENGTH)
> 
> The docs for this function mention the length <= CAAM_BLOB_MAX_LEN
> restriction. This is not checked here. Is this intended?

Yes.

> Since you already assert that MAX_BLOB_SIZE <= CAAM_BLOB_MAX_LEN
> in security/keys/trusted-keys/trusted_caam.c, this will never
> be an issue for CAAM-based trusted-keys though.
I omitted checks in code, which are verified at compile-time.
Would you prefer a runtime check to be added as well?

>> +		return -EINVAL;
>> +
>> +	desc = caam_blob_alloc_desc(keymod_len);
>> +	if (!desc) {
>> +		dev_err(jrdev, "unable to allocate desc\n");
>> +		return -ENOMEM;
>> +	}
>> +
> 
> [...]
> 
>> diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
>> new file mode 100644
>> index 000000000000..aebbc9335f64
>> --- /dev/null
>> +++ b/include/soc/fsl/caam-blob.h
>> @@ -0,0 +1,56 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2020 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
>> + */
>> +
>> +#ifndef __CAAM_BLOB_GEN
>> +#define __CAAM_BLOB_GEN
>> +
>> +#include <linux/types.h>
>> +
>> +#define CAAM_BLOB_KEYMOD_LENGTH		16
>> +#define CAAM_BLOB_OVERHEAD		(32 + 16)
>> +#define CAAM_BLOB_MAX_LEN		4096
>> +
>> +struct caam_blob_priv;
>> +
>> +/** caam_blob_gen_init - initialize blob generation
>> + *
>> + * returns either pointer to new caam_blob_priv instance
>> + * or error pointer
>> + */
>> +struct caam_blob_priv *caam_blob_gen_init(void);
>> +
>> +/** caam_blob_gen_init - free blob generation resources
> 
> s/init/exit/

Oh, thanks for catching.

>> + *
>> + * @priv: instance returned by caam_blob_gen_init
>> + */
>> +void caam_blob_gen_exit(struct caam_blob_priv *priv);
> 
> 
> Except these minor things, I noticed no issues with this whole series:
> 
> Reviewed-by: David Gstir <david@sigma-star.at>

Thanks! Will include it with the next iteration.

Cheers,
Ahmad 


> 
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
