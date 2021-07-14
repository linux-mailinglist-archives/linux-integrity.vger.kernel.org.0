Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9C3C8328
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 12:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGNKrV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 06:47:21 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38632 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhGNKrU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 06:47:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 71B6C6169BC1;
        Wed, 14 Jul 2021 12:44:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JR8DSbn3rLNy; Wed, 14 Jul 2021 12:44:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CF0236169BC8;
        Wed, 14 Jul 2021 12:44:26 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cpm4SZBSJOXK; Wed, 14 Jul 2021 12:44:26 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 91DB06169BC1;
        Wed, 14 Jul 2021 12:44:26 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:44:26 +0200 (CEST)
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
Message-ID: <2032322938.25484.1626259466410.JavaMail.zimbra@nod.at>
In-Reply-To: <714571a1-e8dd-3417-b5ab-2a6d611fb3ee@pengutronix.de>
References: <20210614201620.30451-1-richard@nod.at> <20210614201620.30451-3-richard@nod.at> <714571a1-e8dd-3417-b5ab-2a6d611fb3ee@pengutronix.de>
Subject: Re: [PATCH 2/3] KEYS: trusted: Introduce support for NXP DCP-based
 trusted keys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: KEYS: trusted: Introduce support for NXP DCP-based trusted keys
Thread-Index: vMUSY/wC2Uw3FhL++LkJN55JKnqxvQ==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ahmad,

----- Ursprüngliche Mail -----
> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>

[...]

>> /*
>>  * struct dcp_blob_fmt - DCP BLOB format.
>>  *
>>  * @fmt_version: Format version, currently being %1
>>  * @blob_key: Random AES 128 key which is used to encrypt @payload,
>>  *            @blob_key itself is encrypted with OTP or UNIQUE device key in
>>  *            AES-128-ECB mode by DCP.
>>  * @nonce: Random nonce used for @payload encryption.
>>  * @payload_len: Length of the plain text @payload.
>>  * @payload: The payload itself, encrypted using AES-128-GCM and @blob_key,
>>  *           GCM auth tag of size AES_BLOCK_SIZE is attached at the end of it.
>>  *
>>  * The total size of a DCP BLOB is sizeof(struct dcp_blob_fmt) + @payload_len +
>>  * AES_BLOCK_SIZE.
>>  */
>> struct dcp_blob_fmt {
>> 	__u8 fmt_version;
>> 	__u8 blob_key[AES_KEYSIZE_128];
>> 	__u8 nonce[AES_KEYSIZE_128];
>> 	__le32 payload_len;
>> 	__u8 payload[0];
> 
> There's been ongoing effort to replace the [0] GNU extension with C99
> flexible array members. Please use [] here as well.

Makes sense!

[...]

>> +KEYS-TRUSTED-DCP
>> +M:	David Gstir <david@sigma-star.at>
>> +M:	Richard Weinberger <richard@nod.at>
>> +L:	linux-integrity@vger.kernel.org
>> +L:	keyrings@vger.kernel.org
>> +S:	Supported
>> +F:	include/keys/trusted_dcp.h
>> +F:	security/keys/trusted-keys/trusted_dcp.c
> 
> Hmm, I didn't add a MAINTAINERS entry for CAAM trusted keys. Do you think I
> should?

Sure, why not? It shows that you will also in future take care of it.

[...]

>> +} __packed;
>> +
>> +static bool use_otp_key;
>> +module_param_named(dcp_use_otp_key, use_otp_key, bool, 0);
>> +MODULE_PARM_DESC(dcp_use_otp_key, "Use OTP instead of UNIQUE key for sealing");
> 
> Shouldn't these be documented in admin-guide/kernel-parameters.txt as well?

Yes. Will do.

>> +static bool skip_zk_test;
>> +module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
>> +MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are
>> zero'ed");
> 
> Does this need to be configurible? I'd assume this can only happen when using an
> unfused OTP. In such a case, it's ok to always warn, so you don't need to make
> this configurible.

We found such a setting super useful while working with targets where the keys are
zero'ed for various reasons.
There are cases where you want to use/test trusted keys even when the master key
is void. Our detection logic does not only print a warning, it refuses to load
blobs. So IMHO the config knob makes sense.

>> +
>> +static unsigned int calc_blob_len(unsigned int payload_len) 
>> +{
>> +	return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
>> +}
>> +
>> +static int do_dcp_crypto(u8 *in, u8 *out, bool is_encrypt)
> 
> I assume in can't be const because the use with sg APIs?

I'm pretty sure this was the main reason, but I can check again.

>> +{
>> +	int res = 0;
>> +	struct skcipher_request *req = NULL;
>> +	DECLARE_CRYPTO_WAIT(wait);
>> +	struct scatterlist src_sg, dst_sg;
>> +	struct crypto_skcipher *tfm;
>> +	u8 paes_key[DCP_PAES_KEYSIZE];
>> +
>> +	if (!use_otp_key)
> 
> I'd invert this. Makes code easier to read.

Ok. :-)

>> +		paes_key[0] = DCP_PAES_KEY_UNIQUE;
>> +	else
>> +		paes_key[0] = DCP_PAES_KEY_OTP;
>> +
>> +	tfm = crypto_alloc_skcipher("ecb-paes-dcp", CRYPTO_ALG_INTERNAL,
>> +				    CRYPTO_ALG_INTERNAL);
>> +	if (IS_ERR(tfm)) {
>> +		res = PTR_ERR(tfm);
>> +		pr_err("Unable to request DCP pAES-ECB cipher: %i\n", res);
> 
> Can you define pr_fmt above? There's also %pe now that can directly print out an
> error pointer.

pr_fmt is not defined on purpose. include/keys/trusted-type.h defines already one
and I assumed "trusted_key:" is the desired prefix for all kinds of trusted keys.

[...]

> - payload_len is at offset 33, but MIN_KEY_SIZE == 32 and there are no minimum
>   size checks. Couldn't you read beyond the buffer this way?

The key has a minimum size of MIN_KEY_SIZE, but p->blob (being struct trusted_key_payload->blob[MAX_BLOB_SIZE])
is much larger.
So the assumption is that a DCP blob will always be smaller than MAX_BLOB_SIZE.

> - offset 33 is unaligned for payload_len. Please use get_unaligned_le32 here.

Oh yes. Makes sense!

[...]

> 
> jfyi, in the prelude of my CAAM series, I made this the default
> when .get_random == NULL.

Right. :-)

[...]

>> +	ret = do_dcp_crypto(buf, buf, true);
>> +	if (ret)
>> +		goto out;
>> +
>> +	if (memcmp(buf, bad, AES_BLOCK_SIZE) == 0) {
>> +		pr_err("Device neither in secure nor trusted mode!\n");
> 
> What's the difference between secure and trusted? Can't this test be skipped
> if use_otp_key == false?

DCP has many modes of operation. Secure is one level above trusted.
For the gory details see "Security Reference Manual for the i.MX 6ULL Applications Processor".
I'm not sure whether all information my manual describes is publicly available so I
don't dare to copy&paste from it.

As David and I understood the logic, both OTP and UNIQUE keys can be zero'ed.
It is also possible that DCP has no support at all for these keys,
then you'll also get a zero key. That's why we have this check here.

Thanks,
//richard
