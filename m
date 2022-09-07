Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C805AFDDB
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 09:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiIGHqa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIGHq1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 03:46:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EB786713
        for <linux-integrity@vger.kernel.org>; Wed,  7 Sep 2022 00:46:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j26so8269374wms.0
        for <linux-integrity@vger.kernel.org>; Wed, 07 Sep 2022 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=0vhyt6mGlvKatRlgIu0f+c6VRtWSnSVoY5U6wDSdUl4=;
        b=b5adUilYN2ScZ7+8j0cwCUVQE7qJ2qTcHvvF13uL2wJfakwkIu8Afu/UfRAa5kKwfZ
         yXlii2vc7I6tIcv8yh+C3bevEQSXgv0QD4i5X3/MK7Z9ZLFM6EZJ2II0bhLsE+pjtZUv
         MMukrrmpdnf+H5eBbeEhrBDGyV4nf59JpfD7A2/PmyfGPA1GD4xCZCf1J6ci4CgVc6Rv
         v2Vbds/nYiutD3Aj2U9lUieXOdl6TnlJI2R5TpExgXgtZZg20m5aWNRY3YkhoVp3EgAr
         nUisEZ/RPDZ3jtVi3rJea8ZyIxNf1E1+dYc7cCauWDHy4rxYCoNTpjqwoBoCtXZo9O9P
         sY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0vhyt6mGlvKatRlgIu0f+c6VRtWSnSVoY5U6wDSdUl4=;
        b=6pvFFPRQAHefJdu8ToyhnNw7xZV6YyBRInzfkApEBDkOwrHflwWZN28DosxJVZp1hm
         dqB2EXKhTvpf9wBfvmGTcVvhvNiEuSvdfzZVxzKA4+4bFj62ot1zMv5UHHgkEd80m4fJ
         z4kKVZfUXJcVLlab6nKiiTVOUgVzNQ1WwNKKw1wqaOSb4HmzsB3gyD5BnOrA18wk9LTD
         caU3HCTkb351Yzil5jCzWHFiuhQ4vIqMrBmOPm0sTp47jaP+186BecGbVTLdFk2NdqOb
         C15vRltHmOl0u+rcg6IU1v50BJyXi/hQ1dqk0I175NNzQFDFXQ70gxevz+XK7Lpgqn+J
         clpQ==
X-Gm-Message-State: ACgBeo2WGRbsIDPmWe+PRfqsaCmJvg4Kky5IgRQTUaW3YJdRUoGslgP9
        W6YmxQLxY6oqP3szqlx+77qXgg==
X-Google-Smtp-Source: AA6agR5POQFrAK+/FIH6XGrSyEIoioETCntc7qhGmkDLburTlGtOqkSNl8jrXX1xN05CMHHQuS4BwA==
X-Received: by 2002:a7b:cd11:0:b0:3a8:3f6c:9abf with SMTP id f17-20020a7bcd11000000b003a83f6c9abfmr16172913wmj.30.1662536779781;
        Wed, 07 Sep 2022 00:46:19 -0700 (PDT)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b003a5dbdea6a8sm33893887wmq.27.2022.09.07.00.46.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 00:46:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [EXT] [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
From:   David Gstir <david@sigma-star.at>
In-Reply-To: <5d67b4d45aa1b2a3d2738c93edaeffdd@walle.cc>
Date:   Wed, 7 Sep 2022 09:46:17 +0200
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
        Richard Weinberger <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        =?utf-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E73DC47-9494-453C-899D-CE386336EF8D@sigma-star.at>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <047746e1134d5bdce699d8c021f849b6@walle.cc>
 <DU2PR04MB8630C63609D6D785F12DEC6E95419@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <5d67b4d45aa1b2a3d2738c93edaeffdd@walle.cc>
To:     Michael Walle <michael@walle.cc>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Michael,

> On 07.09.2022, at 09:29, Michael Walle <michael@walle.cc> wrote:
>=20
> Am 2022-09-07 09:22, schrieb Pankaj Gupta:
>>> -----Original Message-----
>>> From: Michael Walle <michael@walle.cc>
>>> Sent: Tuesday, September 6, 2022 12:43 PM
>>> To: Pankaj Gupta <pankaj.gupta@nxp.com>
>>> Cc: jarkko@kernel.org; a.fatoum@pengutronix.de; Jason@zx2c4.com;
>>> jejb@linux.ibm.com; zohar@linux.ibm.com; dhowells@redhat.com;
>>> sumit.garg@linaro.org; david@sigma-star.at; john.ernberg@actia.se;
>>> jmorris@namei.org; serge@hallyn.com; herbert@gondor.apana.org.au;
>>> davem@davemloft.net; j.luebbe@pengutronix.de; ebiggers@kernel.org;
>>> richard@nod.at; keyrings@vger.kernel.org; =
linux-crypto@vger.kernel.org;
>>> linux-integrity@vger.kernel.org; linux-kernel@vger.kernel.org; =
linux-
>>> security-module@vger.kernel.org; Sahil Malhotra
>>> <sahil.malhotra@nxp.com>; Kshitiz Varshney =
<kshitiz.varshney@nxp.com>;
>>> Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
>>> Subject: [EXT] Re: [RFC PATCH HBK: 0/8] HW BOUND KEY as TRUSTED KEY
>>> Caution: EXT Email
>>> Hi,
>>> Am 2022-09-06 08:51, schrieb Pankaj Gupta:
>>> > Hardware Bound key(HBK), is never acessible as plain key outside =
of
>>> > the hardware boundary. Thus, it is un-usable, even if somehow =
fetched
>>> > from kernel memory. It ensures run-time security.
>>> >
>>> > This patchset adds generic support for classing the Hardware Bound
>>> > Key, based on:
>>> >
>>> > - Newly added flag-'is_hbk', added to the tfm.
>>> >
>>> >   Consumer of the kernel crypto api, after allocating
>>> >   the transformation, sets this flag based on the basis
>>> >   of the type of key consumer has.
>>> >
>>> > - This helps to influence the core processing logic
>>> >   for the encapsulated algorithm.
>>> >
>>> > - This flag is set by the consumer after allocating
>>> >   the tfm and before calling the function crypto_xxx_setkey().
>>> >
>>> > First implementation is based on CAAM.
>>> >
>>> > NXP built CAAM IP is the Cryptographic Acceleration and Assurance
>>> > Module.
>>> > This is contain by the i.MX and QorIQ SoCs by NXP.
>>> >
>>> > CAAM is a suitable backend (source) for kernel trusted keys.
>>> > This backend source can be used for run-time security as well by
>>> > generating the hardware bound key.
>>> >
>>> > Along with plain key, the CAAM generates black key. A black key is =
an
>>> > encrypted key, which can only be decrypted inside CAAM. Hence, =
CAAM's
>>> > black key can only be used by CAAM. Thus it is declared as a =
hardware
>>> > bound key.
>>> What is the difference to the current trusted keys with CAAM?
>>> When I tested the patch series back then, I wasn't able to import a =
sealed
>>> key on another board with the same SoC.
>> Currently, keys that are part of trusted key-ring, contains plain =
key.
>> With this patch-set, these key will become Hw Bound Key, which is not
>> a plain key anymore.
>> After this patch-set, if somehow the HB-key is retrieved from the
>> keyring, the retrieved key  would be un-usable without hw.
>=20
> This doesn't answer my question why I couldn't import one key on
> another board with the same SoC.

I don=E2=80=99t believe this is intended to work this way. Each key blob =
created by CAAM is bound
to a specific device. Being able to decrypt the same blob on another SoC =
would
open up some attack vectors: Think of a locked down device where I=E2=80=99=
m able to=20
extract this key blob. Simply buying a board with the same Soc would =
allow me to
decrypt this blob by copying it over to my board.

Roughly speaking, CAAM key blobs are secure using a key derived from the =
device=E2=80=99s master
key. This master key can be programmed via eFUSEs. So you=E2=80=99d have =
to burn the same master
key on both SoCs and it should work.

In any way, check the security reference manual for your SoC. It should =
explain this in more detail.

- David=
