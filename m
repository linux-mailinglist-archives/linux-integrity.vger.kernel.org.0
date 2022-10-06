Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171FF5F6645
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Oct 2022 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiJFMlu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Oct 2022 08:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJFMls (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Oct 2022 08:41:48 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879B8F950;
        Thu,  6 Oct 2022 05:41:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 99075320090D;
        Thu,  6 Oct 2022 08:41:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 08:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1665060105; x=
        1665146505; bh=WjfN3TnG3qyIp+b77nmfwa/0mGwvYTAgTe3PiH8ciEE=; b=W
        cl/t60RHccMRbIHxNtZppCSGv+KOGIG8iyciTRiIkmxlKm/MZBBKvbwiAnpxaD8T
        BwL//MpPzgRNUqF6OJY2t+baiVRpJtI+o/bSz+Il9b+RjJ1CZxQFZ8vSjg+YxUG+
        MqJ+2PeL8zO4ukHP/NwRBww7XIypeJ5yh4anM0wCFdI/0SyYfUPlzkDqVBLtHk9p
        iVGmZLsULN7JTDF4EAdRzprGOm6nInRsIhN18gVLnm668myEORgmwkbzqOloHy9m
        xUHvVSnXxPAK5hdPgAYmzw4pZ8Jn4lIg0WVEAQplL9Ot5a3B1QmGs53uSP9ga7ZL
        6q6kvnoKOek0NAw1EiyJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1665060105; x=1665146505; bh=WjfN3TnG3qyIp
        +b77nmfwa/0mGwvYTAgTe3PiH8ciEE=; b=BFZYF9gXLkSbDZHyxHzhBjPsY0R0t
        WHiUm2vlPDiOXSkd8tuR/ov0+L3wREOdmJSgXTwxBBYeBlQfeQM70z46pfJvP1+A
        sYnhMWMG4lgmrCevaW5n/7Q3v/2MSDPOSZ44tMC5eymjFPcdFNLdYFe/oKq89Ie3
        Ir7tqxFfCIR8jLPin5rvtpjtOTOIGqB1A51DacMV+pWzE08SzeRp36z/REhWf1PN
        2Op5dYFPm+Xc3wv6eamrpVSZMv0rEIDI6wUtWib1F9BLjcq9oogZuD6wuaiMZrfb
        WULL9CLod1fyHtnG/vIsKnLAyQtAcbCb2rfLsAIKMrbFSVGWpEdSCrdDw==
X-ME-Sender: <xms:B80-Yz230Gol5ZsN305g5vda9sgmTF2Jj7QFTSDK65QixInnufiJFQ>
    <xme:B80-YyHvsBkXgIGh7cDi_pts6YaarCeEcRITfE__hFxGDVpjliOko0Xl770y6g7pd
    M1HgUqV-GTlNU2HAws>
X-ME-Received: <xmr:B80-Yz7P-e51cRaEyPWZrILIqpQo037ZLsvj-xuik-3lM82VUaif0EhceVt2QXBozevoKvw6IXi6-0OfWascDEdeqlndwLLCRCAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkrhhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegv
    nhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeduteehgfefudfffeelfffhheejgfdvfffhledvueekudeuieegueejieff
    vdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:B80-Y41dmkadIYs_oMXZBoivvasthp8GFDy7FLiyBnqh6UwRVwQHkw>
    <xmx:B80-Y2FHBoC3JsDIF1p0ZZDqV6GUEHo8pEzpaskN82DrQU3lx7BebA>
    <xmx:B80-Y58mIJNlaASd6QTkImhS3Am2DRugin2253QiW4ajPqDMvKSaIw>
    <xmx:Cc0-Y5bv-TC9YXZspjWrC4mBc0i-uNmb0ESAeNCEF9nXSdj7Hbv4tg>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 08:41:43 -0400 (EDT)
Date:   Thu, 6 Oct 2022 08:42:32 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     jarkko@kernel.org, a.fatoum@pengutronix.de, gilad@benyossef.com,
        Jason@zx2c4.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        dhowells@redhat.com, sumit.garg@linaro.org, david@sigma-star.at,
        michael@walle.cc, john.ernberg@actia.se, jmorris@namei.org,
        serge@hallyn.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v0 6/8] KEYS: trusted: caam based black key
Message-ID: <Yz7NOB1vePLE4yoB@megas.dev.benboeckel.internal>
Reply-To: list.lkml.keyrings@me.benboeckel.net
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-7-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221006130837.17587-7-pankaj.gupta@nxp.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 06, 2022 at 18:38:35 +0530, Pankaj Gupta wrote:
> - CAAM supports two types of black keys:
>   -- Plain key encrypted with ECB
>   -- Plain key encrypted with CCM

What is a "black key"? Is this described in the documentation or local
comments at all? (I know I'm unfamiliar with CAAM, but maybe this should
be mentioned somewhere?).

>   Note: Due to robustness, default encytption used for black key is CCM.
                                     ^^^^^^^^^^ encryption

What "robustness"? Surely there's some more technical details involved
here?

> - A black key blob is generated, and added to trusted key payload.
>   This is done as part of sealing operation, that was triggered as a result of:
>   -- new key generation
>   -- load key,

It seems that "black keys" are what the uapi calls "hw". I think this
should be mentioned in the commit message (and CAAM docs).

What do other keytypes do if `hw` is requested and it's not possible
(say, `big_key`)?

Thanks,

--Ben
