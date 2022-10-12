Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD15FC2A8
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Oct 2022 11:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJLJHe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Oct 2022 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLJHd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Oct 2022 05:07:33 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911884599A;
        Wed, 12 Oct 2022 02:07:28 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oiXgv-00DsnR-3W; Wed, 12 Oct 2022 20:06:18 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 12 Oct 2022 17:06:17 +0800
Date:   Wed, 12 Oct 2022 17:06:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
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
Message-ID: <Y0aDiLp7BztzwNez@gondor.apana.org.au>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
 <Y0UxY51KQoKCq59o@gondor.apana.org.au>
 <Y0XLqd/+C1sxq2G0@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XLqd/+C1sxq2G0@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 11, 2022 at 02:01:45PM -0600, Jason A. Donenfeld wrote:
>
> I've got no stake in this, but isn't the whole idea that if you specify
> "aes" you get AES, and if you specify "cbc(aes)" you get AES-CBC, and so
> forth? And so leaking implementation details into the algorithm name
> feels like it breaks the abstraction a bit.

Well, keys stored in hardware are fundamentally incompatible with
the algorithm/implementation model.  The whole point of having
algorithms with multiple implementations (e.g., drivers) is that
they all provide exactly the same functionality and could be
substituted at will.

This completely breaks down with hardware keys because by definition
the key is stored in a specific piece of hardware so it will only
work with a particular driver.  IOW it almost never makes sense
to allocate "aes" if you have a hardware key, you almost always
want to allocate "aes-mydriver" instead.

> Rather, drivers that do AES should be called "aes". For this hardware
> key situation, I guess that means keys have a type (in-memory vs
> hardware-resident). Then, a crypto operation takes an "algorithm" and a
> "key", and the abstraction then picks the best implementation that's
> compatible with both the "algorithm" and the "key".

No the key is already in a specific hardware bound to some driver.
The user already knows where the key is and therefore they know
which driver it is.

> If you don't want a proliferation of different ways of doing the same
> thing, maybe the requirement should be that the author of this series
> also converts the existing "paes" kludge to use the new thing he's
> proposing?

Yes that would definitely be a good idea.  We should also talk to the
people who added paes in the first place, i.e., s390.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
