Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873305AFE9D
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIGILy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIGILw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 04:11:52 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73D5C9CD;
        Wed,  7 Sep 2022 01:11:43 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D562C1D4E;
        Wed,  7 Sep 2022 10:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662538300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MbgxfVeCiTAtpT/pLeUY0BnZmSfzrLq/enBZxmaPfE=;
        b=kGqLMLal3LiZAwAtzhJVL3i8sb4WwWHSNG6GMJJP6iVyiqvmjcq/pS6pZeW3w6Xm+WDesn
        D5i9WnoH+84YyUX5w85oRROt3QgLG3StCYTGv8Voc6gvRJTWYS88HUA6liQlnT0VD7l1lH
        C7Qzjxu4rICzQa4z1LNc2nvclelZ6qFcNnIch+onTsXQVavS6LMYBQT2w3BJZVUSC6nm4x
        SECd3ocNrhhbcdv1wYM1l/j235eOY6G0qfUXngWpOoni5kvnzQ0iJTRViboDUca2dXpXB2
        ZgiFUVH86txO/pgasrHAQWIhl8s658QGatYdL+lU3TJHhpvQ/7K847tEILrzvg==
MIME-Version: 1.0
Date:   Wed, 07 Sep 2022 10:11:40 +0200
From:   Michael Walle <michael@walle.cc>
To:     David Gstir <david@sigma-star.at>
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, Jason@zx2c4.com,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>, john.ernberg@actia.se,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
In-Reply-To: <1E73DC47-9494-453C-899D-CE386336EF8D@sigma-star.at>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <047746e1134d5bdce699d8c021f849b6@walle.cc>
 <DU2PR04MB8630C63609D6D785F12DEC6E95419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <5d67b4d45aa1b2a3d2738c93edaeffdd@walle.cc>
 <1E73DC47-9494-453C-899D-CE386336EF8D@sigma-star.at>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9f6fbc2b549fe8bca8a442a5bcaa1942@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi David,

Am 2022-09-07 09:46, schrieb David Gstir:
>> On 07.09.2022, at 09:29, Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2022-09-07 09:22, schrieb Pankaj Gupta:
>>>> -----Original Message-----
>>>> From: Michael Walle <michael@walle.cc>
>>>> Sent: Tuesday, September 6, 2022 12:43 PM
>>>> To: Pankaj Gupta <pankaj.gupta@nxp.com>
>>>> Cc: jarkko@kernel.org; a.fatoum@pengutronix.de; Jason@zx2c4.com;
>>>> jejb@linux.ibm.com; zohar@linux.ibm.com; dhowells@redhat.com;
>>>> sumit.garg@linaro.org; david@sigma-star.at; john.ernberg@actia.se;
>>>> jmorris@namei.org; serge@hallyn.com; herbert@gondor.apana.org.au;
>>>> davem@davemloft.net; j.luebbe@pengutronix.de; ebiggers@kernel.org;
>>>> richard@nod.at; keyrings@vger.kernel.org; 
>>>> linux-crypto@vger.kernel.org;
>>>> linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; 
>>>> linux-
>>>> security-module@vger.kernel.org; Sahil Malhotra
>>>> <sahil.malhotra@nxp.com>; Kshitiz Varshney 
>>>> <kshitiz.varshney@nxp.com>;
>>>> Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
>>>> Subject: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
>>>> Caution: EXT Email
>>>> Hi,
>>>> Am 2022-09-06 08:51, schrieb Pankaj Gupta:
>>>> > Hardware Bound key(HBK), is never acessible as plain key outside of
>>>> > the hardware boundary. Thus, it is un-usable, even if somehow fetched
>>>> > from kernel memory. It ensures run-time security.
>>>> >
>>>> > This patchset adds generic support for classing the Hardware Bound
>>>> > Key, based on:
>>>> >
>>>> > - Newly added flag-'is_hbk', added to the tfm.
>>>> >
>>>> >   Consumer of the kernel crypto api, after allocating
>>>> >   the transformation, sets this flag based on the basis
>>>> >   of the type of key consumer has.
>>>> >
>>>> > - This helps to influence the core processing logic
>>>> >   for the encapsulated algorithm.
>>>> >
>>>> > - This flag is set by the consumer after allocating
>>>> >   the tfm and before calling the function crypto_xxx_setkey().
>>>> >
>>>> > First implementation is based on CAAM.
>>>> >
>>>> > NXP built CAAM IP is the Cryptographic Acceleration and Assurance
>>>> > Module.
>>>> > This is contain by the i.MX and QorIQ SoCs by NXP.
>>>> >
>>>> > CAAM is a suitable backend (source) for kernel trusted keys.
>>>> > This backend source can be used for run-time security as well by
>>>> > generating the hardware bound key.
>>>> >
>>>> > Along with plain key, the CAAM generates black key. A black key is an
>>>> > encrypted key, which can only be decrypted inside CAAM. Hence, CAAM's
>>>> > black key can only be used by CAAM. Thus it is declared as a hardware
>>>> > bound key.
>>>> What is the difference to the current trusted keys with CAAM?
>>>> When I tested the patch series back then, I wasn't able to import a 
>>>> sealed
>>>> key on another board with the same SoC.
>>> Currently, keys that are part of trusted key-ring, contains plain 
>>> key.
>>> With this patch-set, these key will become Hw Bound Key, which is not
>>> a plain key anymore.
>>> After this patch-set, if somehow the HB-key is retrieved from the
>>> keyring, the retrieved key  would be un-usable without hw.
>> 
>> This doesn't answer my question why I couldn't import one key on
>> another board with the same SoC.
> 
> I don’t believe this is intended to work this way. Each key blob
> created by CAAM is bound
> to a specific device. Being able to decrypt the same blob on another 
> SoC would
> open up some attack vectors: Think of a locked down device where I’m 
> able to
> extract this key blob. Simply buying a board with the same Soc would 
> allow me to
> decrypt this blob by copying it over to my board.

I agree, thus my first question here was, what this series is adding,
if the key is already "bound" to the hardware. That is what I don't
understand.

-michael

> Roughly speaking, CAAM key blobs are secure using a key derived from
> the device’s master
> key. This master key can be programmed via eFUSEs. So you’d have to
> burn the same master
> key on both SoCs and it should work.
> 
> In any way, check the security reference manual for your SoC. It
> should explain this in more detail.
