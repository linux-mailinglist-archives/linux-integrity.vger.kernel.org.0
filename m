Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B168A606A45
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 23:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJTV25 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 17:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJTV24 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 17:28:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26E41D0D51;
        Thu, 20 Oct 2022 14:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CE85B8295E;
        Thu, 20 Oct 2022 21:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF24C433C1;
        Thu, 20 Oct 2022 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666301327;
        bh=rWfQzP6/H9EAAjSIpr3p+kEno6vt0QBXq32WDxAfruU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETkFoNIwV/rtQAkC6D0iTcGP48Lv+lCWAEfot85DN9OQs9Tnc4XCjUH5pFR4ztre3
         nZG3MyrrlnpUwkuUnr8qqsNqMuBZLyf3vg2OnfSLc6jwAG2RU3bUAT3bCYrl0AB8hU
         vQCBfUbT4Oumto+b5K8TtrWcQcS8zVuk03inW/pg54jeZ4LIRRbIFljLOIshOzyEkK
         hwdxurKtatrsk+N9iliJjkw2fSpEIAyydd60T7KEQuXbYs69SJ++9ed0+eCzxZLbXt
         7OpqMh3jh+wdkBlBIgy2DSpm9HBuBMrAarmBV2qy7MEl/1f/KGnvP/KZZvy58CION1
         li7bd6SYatLqA==
Date:   Thu, 20 Oct 2022 14:28:36 -0700
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
Message-ID: <Y1G9hKPT1MNQQxcG@sol.localdomain>
References: <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
 <Y0UxY51KQoKCq59o@gondor.apana.org.au>
 <Y0XLqd/+C1sxq2G0@zx2c4.com>
 <Y0aDiLp7BztzwNez@gondor.apana.org.au>
 <Y0m2TU5k78I1AR+p@ziepe.ca>
 <Y1DN3SqEyFZd9i37@sol.localdomain>
 <Y1GgSX+ZmOsxhB2N@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1GgSX+ZmOsxhB2N@ziepe.ca>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 20, 2022 at 04:23:53PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 19, 2022 at 09:26:05PM -0700, Eric Biggers wrote:
> 
> > Are you referring to the support for hardware-wrapped inline crypto keys?  It
> > isn't upstream yet, but my latest patchset is at
> > https://lore.kernel.org/linux-fscrypt/20220927014718.125308-2-ebiggers@kernel.org/T/#u.
> > There's also a version of it used by some Android devices already.  Out of
> > curiosity, are you using it in an Android device, or have you adopted it in some
> > other downstream?
> 
> Unrelated to Android, similar functionality, but slightly different
> ultimate purpose. We are going to be sending a fscrypt patch series
> for mlx5 and nvme soonish.

That's interesting, though also slightly scary in that it sounds like you've
already shipped some major fscrypt changes without review!

> > > Yes, it would be nice to see a comprehensive understand on how HW
> > > resident keys can be modeled in the keyring.
> > 
> > Note that the keyrings subsystem is not as useful as it might seem.  It sounds
> > like something you want (you have keys, and there is a subsystem called
> > "keyrings", so it should be used, right?), but often it isn't.  fscrypt has
> > mostly moved away from using it, as it caused lots of problems.  I would caution
> > against assuming that it needs to be part of any solution.
> 
> That sounds disappointing that we are now having parallel ways for the
> admin to manipulate kernel owned keys.

Well, the keyrings subsystem never worked properly for fscrypt anyway.  At most,
it's only useful for providing the key to the filesystem initially (by passing a
key ID to FS_IOC_ADD_ENCRYPTION_KEY, instead of the key bytes), similar to what
dm-crypt allows.  After that, the keyrings subsystem plays no role.

I'm open to making FS_IOC_ADD_ENCRYPTION_KEY accept other 'struct key' types,
like "trusted" which has been discussed before and which dm-crypt supports.

Just don't assume that just because you have a key, that you automatically
*need* the keyrings subsystem.  Normally just passing the key bytes in the ioctl
works just as well and is much simpler.  Same for dm-crypt, which normally takes
the key bytes in the device-mapper table parameters...

- Eric
