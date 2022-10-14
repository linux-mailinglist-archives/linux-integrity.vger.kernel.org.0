Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE25FF408
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiJNTTt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Oct 2022 15:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiJNTTr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Oct 2022 15:19:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F218381
        for <linux-integrity@vger.kernel.org>; Fri, 14 Oct 2022 12:19:43 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f8so3129910qkg.3
        for <linux-integrity@vger.kernel.org>; Fri, 14 Oct 2022 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoUaVX7WeSWMFX3nree3fUpxXXfgx6Q4WFZ3tSVkQHg=;
        b=UiEjKjYPArwu+erj/QUVX0fUkhEFZapV4R65wkaTG4gFBsMcgJkyatk9panVMud2En
         ULChv0jbZe6RCkW9Iub/eHAKRijGlZZLlyB/QtBtT8Jd2DMUP/dA/wbvumatgVajvxbP
         G7SxU8S1iwmPUTUEjd4IaN98wy6rQ8LTLC+JOHaboTX6clRtjnZnCfMw6W74UA5pn3tr
         f4O0lOsL1wNhPGua2PNkidmINtdhwvKbbfBBogrEW1mfetqWW+iVvZDMD0V2+7XBDAhI
         qJKG3H0SORHdEHhf5ZgcnL9I0h1XitsYBQy83ToiZvytz5BMG8lso5aBrU5+WRL62ScD
         yTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoUaVX7WeSWMFX3nree3fUpxXXfgx6Q4WFZ3tSVkQHg=;
        b=MZe+DlEowas1jf6/GfBph33/OM+W2+/9ACU0hZpf9qT9LjyowxrPCXhg0B1MUkA/31
         Fikz6fBWRboP8qNqVp/CivuuQofFqiX4wrL3y6mEe+yLjRQPRU6EQ5oBfbmxj/kLYwB3
         /H0+Qv7lQfWstiB3r5G8te7VCuZOiImhG3AgiTciTiU6Lp1NSsy/M6gOPdyD5m69brgS
         sNUCF9iO6AhPUbS0KyrieWd+0vDZ/AIQl7s077egPPxgttf0eCDDg/1aGBT6W6oVBAfS
         De0x4Ab59J6Jx+lJYrNZXqa4Al1UbQmL3tlqPF9IhU818pOgeuqvWzVuyfLTefjACTz9
         yBFw==
X-Gm-Message-State: ACrzQf0jV+BJvZEDf0U0XG9QKwf5g1XSN9A78HotTpeEmc+4zLnKVgJA
        Z1HzdDsMUOpDsUHuZ6AAS3D5hg==
X-Google-Smtp-Source: AMsMyM5kq8HSA0NWVB8q1M2PQnkKFbfau0narXlYBV62ON1xN11WXriiPNcPad7RxtFAPMdU5bCjTw==
X-Received: by 2002:a37:bd84:0:b0:6cf:6049:f12a with SMTP id n126-20020a37bd84000000b006cf6049f12amr4919050qkf.697.1665775183082;
        Fri, 14 Oct 2022 12:19:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id x78-20020a376351000000b006ce3cffa2c8sm3020159qkb.43.2022.10.14.12.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 12:19:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ojQDd-003BJU-IB;
        Fri, 14 Oct 2022 16:19:41 -0300
Date:   Fri, 14 Oct 2022 16:19:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "gilad@benyossef.com" <gilad@benyossef.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Message-ID: <Y0m2TU5k78I1AR+p@ziepe.ca>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
 <Y0UxY51KQoKCq59o@gondor.apana.org.au>
 <Y0XLqd/+C1sxq2G0@zx2c4.com>
 <Y0aDiLp7BztzwNez@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0aDiLp7BztzwNez@gondor.apana.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 12, 2022 at 05:06:16PM +0800, Herbert Xu wrote:

> > Rather, drivers that do AES should be called "aes". For this hardware
> > key situation, I guess that means keys have a type (in-memory vs
> > hardware-resident). Then, a crypto operation takes an "algorithm" and a
> > "key", and the abstraction then picks the best implementation that's
> > compatible with both the "algorithm" and the "key".
> 
> No the key is already in a specific hardware bound to some driver.
> The user already knows where the key is and therefore they know
> which driver it is.

Do they?

We have HW that can do HW resident keys as as well, in our case it is
plugged into the storage system with fscrypt and all the crypto
operations are being done "inline" as the data is DMA'd into/out of
the storage. So, no crypto API here.

I would say the user knows about the key and its binding in the sense
they loaded a key into the storage device and mounted a fscrypt
filesystem from that storage device - but the kernel may not know this
explicitly.

> > If you don't want a proliferation of different ways of doing the same
> > thing, maybe the requirement should be that the author of this series
> > also converts the existing "paes" kludge to use the new thing he's
> > proposing?
> 
> Yes that would definitely be a good idea.  We should also talk to the
> people who added paes in the first place, i.e., s390.

Yes, it would be nice to see a comprehensive understand on how HW
resident keys can be modeled in the keyring. Almost every computer now
has a TPM that is also quite capable of doing operations with these
kinds of keys. Seeing the whole picture, including how we generate and
load/save/provision these things seems important.

Jason
