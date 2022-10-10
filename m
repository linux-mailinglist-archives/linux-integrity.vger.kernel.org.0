Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CEA5FA708
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Oct 2022 23:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJJVf4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Oct 2022 17:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJJVfy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Oct 2022 17:35:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921A87D1DB
        for <linux-integrity@vger.kernel.org>; Mon, 10 Oct 2022 14:35:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so7112554wmq.1
        for <linux-integrity@vger.kernel.org>; Mon, 10 Oct 2022 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMldxqHe7oqZnxhOWbNDSf+/ipc4cdrY3PI40/wIFyY=;
        b=CAEjxiNCW9LHGV0xN0Q++SUzIDZqtVfDFAw45WPF7haNM/KA16A0B7RWvuzWIX4/Tg
         u4rVcvonRwwbM+VKFKRgS+gqIftQVevj3jrBCQuhibhDTjXeX63XVCHR4iHyB6O7L38z
         AeBm6A46eDkB5FzYqTvpSF0KewaxxhG9qiX05EX21km//OEPWyb7Dd8kO+Wf8FMMwRtj
         7YUouRiS4jFlHvoTM7OX1ayed0QHJKGrKUEQpbLLsu4tZqbc4wDwe81sJSfUo+Hxi6j9
         b8rfj36BGLda+/XjH5/Beh0FU0mPZY/E6Q4oqA3K6qc+0XUvje2G2qlvtZEMXJQjhFP/
         peNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMldxqHe7oqZnxhOWbNDSf+/ipc4cdrY3PI40/wIFyY=;
        b=KlN/vH10NY6+dazuS8uazdq89v35/aBayXpBv8/nLHUrCUr2o3gvnDPKs8ECgHb7i0
         oQGUuE/xgjVMJf/h6B4loJoXTSHGwD7aFPfvu6c9STDxF7jH6nT9uA4RrliV+1HIE1wD
         6WnhA9L9Pdi3/kLyBuZA+o8IAPqpFPJtMg0bgty37QbSMI1ix/nruLL1IkMKcab9DrqN
         rXY2w2V5RB5xsZC/bO2beWbQ4UCQkfUNuEu8kvagZu961WOv+bTMYgMCtn4vFVsi8YUs
         1jVYwmGFAoRfP/MKQSm8IemJoxhE5EISwac00Oy6ipoxPJipKquhyU+pwTNU8tWTEdfq
         w6yg==
X-Gm-Message-State: ACrzQf2tDPEe4qZhCxi5O2mwS6+1pdmoPtb2pwqJp0Akd3YvuAy0HJlL
        9oXhDHdZTjYr9Zmy49XNeQ6NnLYzDLRROrm3
X-Google-Smtp-Source: AMsMyM5/zWG+cYg4AJpExgutt6xqdD3M9Ya1ZzEuWcFffeTxg7i3FbXoZgFGVEUzHmTeWTpvgmTmHQ==
X-Received: by 2002:a05:600c:444b:b0:3b4:cb9e:bd5c with SMTP id v11-20020a05600c444b00b003b4cb9ebd5cmr21012193wmn.124.1665437749904;
        Mon, 10 Oct 2022 14:35:49 -0700 (PDT)
Received: from smtpclient.apple (17-14-114.cgnat.fonira.net. [185.17.14.114])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe9c5000000b0022da3977ec5sm9674476wrn.113.2022.10.10.14.35.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2022 14:35:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [EXT] [PATCH v0 3/8] crypto: hbk flags & info added to the tfm
From:   David Gstir <david@sigma-star.at>
In-Reply-To: <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
Date:   Mon, 10 Oct 2022 23:35:47 +0200
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "gilad@benyossef.com" <gilad@benyossef.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
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
Message-Id: <6A3D70F9-1206-4EBB-BFCC-CA3733688EFC@sigma-star.at>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On 10.10.2022, at 17:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> On Mon, Oct 10, 2022 at 11:15:00AM +0000, Pankaj Gupta wrote:
>>> Nack.  You still have not provided a convincing argument why this is =
necessary
>>> since there are plenty of existing drivers in the kernel already =
providing similar
>>> features.
>>>=20
>> CAAM is used as a trusted source for trusted keyring. CAAM can expose
>> these keys either as plain key or HBK(hardware bound key- managed by
>> the hardware only and never visible in plain outside of hardware).
>>=20
>> Thus, Keys that are inside CAAM-backed-trusted-keyring, can either be
>> plain key or HBK. So the trusted-key-payload requires additional flag
>> & info(key-encryption-protocol)  to help differentiate it from each
>> other. Now when CAAM trusted-key is presented to the kernel crypto
>> framework, the additional information associated with the key, needs
>> to be passed to the hardware driver. Currently the kernel keyring and
>> kernel crypto frameworks are associated for plain key, but completely
>> dis-associated for HBK. This patch addresses this problem.
>>=20
>> Similar capabilities (trusted source), are there in other crypto
>> accelerators on NXP SoC(s). Having hardware specific crypto algorithm
>> name, does not seems to be a scalable solution.
>=20
> Do you mean to say that other drivers that use hardware-backed keys do
> so by setting "cra_name" to something particular? Like instead of =
"aes"
> it'd be "aes-but-special-for-this-driver"? If so, that would seem to
> break the design of the crypto API. Which driver did you see that does
> this? Or perhaps, more generally, what are the drivers that Herbert is
> talking about when he mentions the "plenty of existing drivers" that
> already do this?

I believe what Herbert means are drivers registered with the cipher name=20=

prefix =E2=80=9Cp=E2=80=9D. E.g. [1] registers multiple =E2=80=9Cpaes=E2=80=
=9D variants. There was a
previous patch set for CAAM where this was suggested as well [2].

- David

[1] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/crypto/ccree/cc_cipher.c#n1011
[2] =
https://lore.kernel.org/linux-crypto/20200716073610.GA28215@gondor.apana.o=
rg.au/=
