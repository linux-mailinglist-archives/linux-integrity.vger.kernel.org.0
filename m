Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F03C8309
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 12:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhGNKmi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 06:42:38 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38512 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhGNKmi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 06:42:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3D1A9606BA4F;
        Wed, 14 Jul 2021 12:39:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rV1lZ2SKB4Ku; Wed, 14 Jul 2021 12:39:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A9DA86169BC8;
        Wed, 14 Jul 2021 12:39:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AP29PNq9W7qd; Wed, 14 Jul 2021 12:39:43 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6D52F6169BC1;
        Wed, 14 Jul 2021 12:39:43 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:39:43 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        david <david@sigma-star.at>, David Howells <dhowells@redhat.com>,
        davem <davem@davemloft.net>, festevam <festevam@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Bottomley <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-imx <linux-imx@nxp.com>, kernel <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        shawnguo <shawnguo@kernel.org>
Message-ID: <1409091619.25467.1626259183269.JavaMail.zimbra@nod.at>
In-Reply-To: <76db3736-5a5f-bf7b-3b52-62d01a84ee2d@pengutronix.de>
References: <20210614201620.30451-1-richard@nod.at> <20210614201620.30451-2-richard@nod.at> <76db3736-5a5f-bf7b-3b52-62d01a84ee2d@pengutronix.de>
Subject: Re: [PATCH 1/3] crypto: mxs-dcp: Add support for hardware provided
 keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: crypto: mxs-dcp: Add support for hardware provided keys
Thread-Index: NDot3bI3Q+rKmPD/+NEwkrQ8VTnhRw==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

----- Ursprüngliche Mail -----
> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
> Let's trade reviews to get the ball rolling?

Sounds like a fair deal. :-)

[...]

>> --- a/drivers/crypto/mxs-dcp.c
>> +++ b/drivers/crypto/mxs-dcp.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/stmp_device.h>
>>  #include <linux/clk.h>
>> +#include <linux/mxs-dcp.h>
> 
> The CAAM specific headers are in <soc/fsl/*.h>.
> Should this be done likewise here as well?

I have no preferences. If soc/fsl/ is the way to go, fine by me.

[...]

>> @@ -219,15 +224,18 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
>>  	struct dcp *sdcp = global_sdcp;
>>  	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
>>  	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
>> +	dma_addr_t src_phys, dst_phys, key_phys = {0};
> 
> Why = {0}; ? dma_addr_t is a scalar type and the value is always
> written here before access.

Initializing a scalar with {} is allowed in C, the braces are optional.
I like the braces because it works even when the underlaying type changes.
But that's just a matter of taste.

key_phys is initialized because it triggered a false positive gcc warning
on one of my targets. Let me re-run again to be sure, the code saw a lot of
refactoring since that.
 
[...]
  
>> +static int mxs_dcp_aes_setrefkey(struct crypto_skcipher *tfm, const u8 *key,
>> +				 unsigned int len)
>> +{
>> +	struct dcp_async_ctx *actx = crypto_skcipher_ctx(tfm);
>> +	int ret = -EINVAL;
>> +
>> +	if (len != DCP_PAES_KEYSIZE)
>> +		goto out;
> 
> Nitpick: there is no cleanup, so why not return -EINVAL here
> and unconditionally return 0 below?

What is the benefit?
Usually I try to use goto to have a single exit point of a function
but I don't have a strong preference...

>> +
>> +	actx->key_len = len;
>> +	actx->refkey = true;
>> +
>> +	switch (key[0]) {
>> +	case DCP_PAES_KEY_SLOT0:
>> +	case DCP_PAES_KEY_SLOT1:
>> +	case DCP_PAES_KEY_SLOT2:
>> +	case DCP_PAES_KEY_SLOT3:
>> +	case DCP_PAES_KEY_UNIQUE:
>> +	case DCP_PAES_KEY_OTP:
>> +		memcpy(actx->key, key, len);
>> +		ret = 0;
>> +	}
> 
> In the error case you return -EINVAL below, but you still write
> into actx. Is that intentional?

You mean acts->key_len and actk->refkey?
Is this a problem?

Thanks,
//richard
