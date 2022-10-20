Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D321960564B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 06:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJTE0K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 00:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJTE0J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 00:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199786CD2C;
        Wed, 19 Oct 2022 21:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AEF3619DD;
        Thu, 20 Oct 2022 04:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D5CC433D6;
        Thu, 20 Oct 2022 04:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666239967;
        bh=3umPUvfp+ZdS2/b5YkkwJDF80zqjXSIkipDtGhz5ce4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tb92p97DWaxzjXjwVK4TeOa6QkVdaDnDSVo/vJUBM1aO+urHJ6f/YkhkxKva78SHz
         pFMPbhMffAYqTWT3j8YFFzprop51+MqrJF+x7eNNKj45Ek0q97grA/FXdurAtwZ/xz
         FcRwKBslCvcNzQnIilKIP/aHwZSYiDuUmTHlxnvgg6KkKKsYhNgNkFoRvO9LRHGng1
         NgqCVX9WFM9RzYTdqYXH0Ac9ZHt1+MAGL8Cgmi0Wrd81CsA8ZVLLPSsrBLrpp89GU3
         ZPnHOdnm2jPirTA/fAIHj89RcWKw0jZglskMO9/S6PkklDi7xZhlVoohYCq7x72QPz
         dg10w7h5DLB5g==
Date:   Wed, 19 Oct 2022 21:26:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <Y1DN3SqEyFZd9i37@sol.localdomain>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
 <Y0UxY51KQoKCq59o@gondor.apana.org.au>
 <Y0XLqd/+C1sxq2G0@zx2c4.com>
 <Y0aDiLp7BztzwNez@gondor.apana.org.au>
 <Y0m2TU5k78I1AR+p@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0m2TU5k78I1AR+p@ziepe.ca>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jason,

On Fri, Oct 14, 2022 at 04:19:41PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 12, 2022 at 05:06:16PM +0800, Herbert Xu wrote:
> 
> > > Rather, drivers that do AES should be called "aes". For this hardware
> > > key situation, I guess that means keys have a type (in-memory vs
> > > hardware-resident). Then, a crypto operation takes an "algorithm" and a
> > > "key", and the abstraction then picks the best implementation that's
> > > compatible with both the "algorithm" and the "key".
> > 
> > No the key is already in a specific hardware bound to some driver.
> > The user already knows where the key is and therefore they know
> > which driver it is.
> 
> Do they?
> 
> We have HW that can do HW resident keys as as well, in our case it is
> plugged into the storage system with fscrypt and all the crypto
> operations are being done "inline" as the data is DMA'd into/out of
> the storage. So, no crypto API here.
> 
> I would say the user knows about the key and its binding in the sense
> they loaded a key into the storage device and mounted a fscrypt
> filesystem from that storage device - but the kernel may not know this
> explicitly.

Are you referring to the support for hardware-wrapped inline crypto keys?  It
isn't upstream yet, but my latest patchset is at
https://lore.kernel.org/linux-fscrypt/20220927014718.125308-2-ebiggers@kernel.org/T/#u.
There's also a version of it used by some Android devices already.  Out of
curiosity, are you using it in an Android device, or have you adopted it in some
other downstream?

Anyway, that feature does indeed use a boolean flag to indicate whether the key
is hardware-wrapped or not.  And yes, it doesn't use the crypto API.  Nor does
it use the keyrings subsystem, for that matter.

However, the design of hardware-wrapped inline crypto keys is that keys are
scoped to a particular block device (or a set of block devices), which are
assumed to have only one version of wrapped keys.  That makes the boolean flag
work, as it's always unambiguous what the keys mean.

I don't think that would work as well for the crypto API, which is a bit more
general.  In the crypto API, there can be an arbitrary number of crypto drivers,
each of which has its own version of hardware-wrapped (bound) keys.  So maybe
the existing design that is based on algorithm names is fine.

> > > If you don't want a proliferation of different ways of doing the same
> > > thing, maybe the requirement should be that the author of this series
> > > also converts the existing "paes" kludge to use the new thing he's
> > > proposing?
> > 
> > Yes that would definitely be a good idea.  We should also talk to the
> > people who added paes in the first place, i.e., s390.
> 
> Yes, it would be nice to see a comprehensive understand on how HW
> resident keys can be modeled in the keyring.

Note that the keyrings subsystem is not as useful as it might seem.  It sounds
like something you want (you have keys, and there is a subsystem called
"keyrings", so it should be used, right?), but often it isn't.  fscrypt has
mostly moved away from using it, as it caused lots of problems.  I would caution
against assuming that it needs to be part of any solution.

- Eric
