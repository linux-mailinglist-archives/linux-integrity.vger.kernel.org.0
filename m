Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D383C8356
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbhGNLEW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 07:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhGNLES (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 07:04:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBF3C061760
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jul 2021 04:01:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m3cdh-00038r-J8; Wed, 14 Jul 2021 13:01:17 +0200
Subject: Re: [PATCH 1/3] crypto: mxs-dcp: Add support for hardware provided
 keys
To:     Richard Weinberger <richard@nod.at>
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
References: <20210614201620.30451-1-richard@nod.at>
 <20210614201620.30451-2-richard@nod.at>
 <76db3736-5a5f-bf7b-3b52-62d01a84ee2d@pengutronix.de>
 <1409091619.25467.1626259183269.JavaMail.zimbra@nod.at>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <efa704fa-7817-7654-7664-447fa56e5ab2@pengutronix.de>
Date:   Wed, 14 Jul 2021 13:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1409091619.25467.1626259183269.JavaMail.zimbra@nod.at>
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

Hi,

On 14.07.21 12:39, Richard Weinberger wrote:
> Ahmad,
> 
> ----- Ursprüngliche Mail -----
>> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
>> Let's trade reviews to get the ball rolling?
> 
> Sounds like a fair deal. :-)

:)

> [...]
> 
>>> --- a/drivers/crypto/mxs-dcp.c
>>> +++ b/drivers/crypto/mxs-dcp.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/platform_device.h>
>>>  #include <linux/stmp_device.h>
>>>  #include <linux/clk.h>
>>> +#include <linux/mxs-dcp.h>
>>
>> The CAAM specific headers are in <soc/fsl/*.h>.
>> Should this be done likewise here as well?
> 
> I have no preferences. If soc/fsl/ is the way to go, fine by me.

I think it's the more appropriate place, but if the maintainers
are fine with <linux/mxs-dcp.h>, I don't mind.

> 
> [...]
> 
>>> @@ -219,15 +224,18 @@ static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
>>>  	struct dcp *sdcp = global_sdcp;
>>>  	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
>>>  	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
>>> +	dma_addr_t src_phys, dst_phys, key_phys = {0};
>>
>> Why = {0}; ? dma_addr_t is a scalar type and the value is always
>> written here before access.
> 
> Initializing a scalar with {} is allowed in C, the braces are optional.
> I like the braces because it works even when the underlaying type changes.
> But that's just a matter of taste.
> 
> key_phys is initialized because it triggered a false positive gcc warning
> on one of my targets. Let me re-run again to be sure, the code saw a lot of
> refactoring since that.
>  
> [...]
>   
>>> +static int mxs_dcp_aes_setrefkey(struct crypto_skcipher *tfm, const u8 *key,
>>> +				 unsigned int len)
>>> +{
>>> +	struct dcp_async_ctx *actx = crypto_skcipher_ctx(tfm);
>>> +	int ret = -EINVAL;
>>> +
>>> +	if (len != DCP_PAES_KEYSIZE)
>>> +		goto out;
>>
>> Nitpick: there is no cleanup, so why not return -EINVAL here
>> and unconditionally return 0 below?
> 
> What is the benefit?

Similar to why you wouldn't write: 

  if (len == DCP_PAES_KEYSIZE) { 
  	/* longer code block */
  }

  return ret;

Code is easier to scan through with early-exits.

> Usually I try to use goto to have a single exit point of a function
> but I don't have a strong preference...

It's just a nitpick. I am fine with it either way.

>>> +
>>> +	actx->key_len = len;
>>> +	actx->refkey = true;
>>> +
>>> +	switch (key[0]) {
>>> +	case DCP_PAES_KEY_SLOT0:
>>> +	case DCP_PAES_KEY_SLOT1:
>>> +	case DCP_PAES_KEY_SLOT2:
>>> +	case DCP_PAES_KEY_SLOT3:
>>> +	case DCP_PAES_KEY_UNIQUE:
>>> +	case DCP_PAES_KEY_OTP:
>>> +		memcpy(actx->key, key, len);
>>> +		ret = 0;
>>> +	}
>>
>> In the error case you return -EINVAL below, but you still write
>> into actx. Is that intentional?
> 
> You mean acts->key_len and actk->refkey?
> Is this a problem?

It's easier to reason about code when it doesn't leave objects
it operates on in invalid states on failure. Changing key_len,
but leaving actx->key uninitialized is surprising IMO.

I can't judge whether this is a problem in practice, but less
surprises are a worthwhile goal.

Cheers,
Ahmad

> 
> Thanks,
> //richard
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
