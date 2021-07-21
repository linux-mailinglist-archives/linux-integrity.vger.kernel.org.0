Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6633D14F5
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 19:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhGUQhe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhGUQhe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 12:37:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDECC061757
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 10:18:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m6FrA-0008OQ-Fm; Wed, 21 Jul 2021 19:18:04 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 2/3] KEYS: trusted: Introduce support for NXP DCP-based
 trusted keys
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
 <20210614201620.30451-3-richard@nod.at>
 <714571a1-e8dd-3417-b5ab-2a6d611fb3ee@pengutronix.de>
 <2032322938.25484.1626259466410.JavaMail.zimbra@nod.at>
Message-ID: <5c381015-64dc-039f-8bc2-3109dd3b9bf4@pengutronix.de>
Date:   Wed, 21 Jul 2021 19:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2032322938.25484.1626259466410.JavaMail.zimbra@nod.at>
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

Hello Richard,

On 14.07.21 12:44, Richard Weinberger wrote:
> Ahmad,
> 
> ----- Ursprüngliche Mail -----
>> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
> 
> [...]
> 
> Sure, why not? It shows that you will also in future take care of it.

Good point. I did that for v3.

> 
> [...]
> 
>>> +} __packed;
>>> +
>>> +static bool use_otp_key;
>>> +module_param_named(dcp_use_otp_key, use_otp_key, bool, 0);
>>> +MODULE_PARM_DESC(dcp_use_otp_key, "Use OTP instead of UNIQUE key for sealing");
>>
>> Shouldn't these be documented in admin-guide/kernel-parameters.txt as well?
> 
> Yes. Will do.
> 
>>> +static bool skip_zk_test;
>>> +module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
>>> +MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are
>>> zero'ed");
>>
>> Does this need to be configurible? I'd assume this can only happen when using an
>> unfused OTP. In such a case, it's ok to always warn, so you don't need to make
>> this configurible.
> 
> We found such a setting super useful while working with targets where the keys are
> zero'ed for various reasons.
> There are cases where you want to use/test trusted keys even when the master key
> is void. Our detection logic does not only print a warning, it refuses to load
> blobs. So IMHO the config knob makes sense.

Ah, I missed that it refuses to continue in that case.

> 
>>> +
>>> +static unsigned int calc_blob_len(unsigned int payload_len) 
>>> +{
>>> +	return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
>>> +}
>>> +
>>> +static int do_dcp_crypto(u8 *in, u8 *out, bool is_encrypt)
>>
>> I assume in can't be const because the use with sg APIs?
> 
> I'm pretty sure this was the main reason, but I can check again.
> 
>>> +{
>>> +	int res = 0;
>>> +	struct skcipher_request *req = NULL;
>>> +	DECLARE_CRYPTO_WAIT(wait);
>>> +	struct scatterlist src_sg, dst_sg;
>>> +	struct crypto_skcipher *tfm;
>>> +	u8 paes_key[DCP_PAES_KEYSIZE];
>>> +
>>> +	if (!use_otp_key)
>>
>> I'd invert this. Makes code easier to read.
> 
> Ok. :-)
> 
>>> +		paes_key[0] = DCP_PAES_KEY_UNIQUE;
>>> +	else
>>> +		paes_key[0] = DCP_PAES_KEY_OTP;
>>> +
>>> +	tfm = crypto_alloc_skcipher("ecb-paes-dcp", CRYPTO_ALG_INTERNAL,
>>> +				    CRYPTO_ALG_INTERNAL);
>>> +	if (IS_ERR(tfm)) {
>>> +		res = PTR_ERR(tfm);
>>> +		pr_err("Unable to request DCP pAES-ECB cipher: %i\n", res);
>>
>> Can you define pr_fmt above? There's also %pe now that can directly print out an
>> error pointer.
> 
> pr_fmt is not defined on purpose. include/keys/trusted-type.h defines already one
> and I assumed "trusted_key:" is the desired prefix for all kinds of trusted keys.

Ah, all good then. I didn't define it for CAAM either, but forgot why I didn't
along the way. May've been the same reason.

> [...]
> 
>> - payload_len is at offset 33, but MIN_KEY_SIZE == 32 and there are no minimum
>>   size checks. Couldn't you read beyond the buffer this way?
> 
> The key has a minimum size of MIN_KEY_SIZE, but p->blob (being struct trusted_key_payload->blob[MAX_BLOB_SIZE])
> is much larger.
> So the assumption is that a DCP blob will always be smaller than MAX_BLOB_SIZE.
> 
>> - offset 33 is unaligned for payload_len. Please use get_unaligned_le32 here.
> 
> Oh yes. Makes sense!
> 
> [...]
> 
>>
>> jfyi, in the prelude of my CAAM series, I made this the default
>> when .get_random == NULL.
> 
> Right. :-)
> 
> [...]
> 
>>> +	ret = do_dcp_crypto(buf, buf, true);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	if (memcmp(buf, bad, AES_BLOCK_SIZE) == 0) {
>>> +		pr_err("Device neither in secure nor trusted mode!\n");
>>
>> What's the difference between secure and trusted? Can't this test be skipped
>> if use_otp_key == false?
> 
> DCP has many modes of operation. Secure is one level above trusted.
> For the gory details see "Security Reference Manual for the i.MX 6ULL Applications Processor".
> I'm not sure whether all information my manual describes is publicly available so I
> don't dare to copy&paste from it.
> 
> As David and I understood the logic, both OTP and UNIQUE keys can be zero'ed.
> It is also possible that DCP has no support at all for these keys,
> then you'll also get a zero key. That's why we have this check here.

Thanks for the clarification.

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
