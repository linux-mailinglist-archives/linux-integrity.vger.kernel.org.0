Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21E85FBBB7
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Oct 2022 22:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJKUCX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Oct 2022 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJKUCF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Oct 2022 16:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67609AF9E;
        Tue, 11 Oct 2022 13:01:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF95612C4;
        Tue, 11 Oct 2022 20:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6889C433D7;
        Tue, 11 Oct 2022 20:01:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l0by20+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665518510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8LEP6iTQrSruVuUlMCIfaNsSoU3M6nvioOPFUPzrh0=;
        b=l0by20+ebmJonHYlRKOQTn2Rq/LTha1yH59+bV2KEU74nVxvpahVEdVt1xI2f62NLBAgn3
        twsEZXzZOJm9ZMzTNMu4Omevnc6Vjr/aqBgSm2Zr1v9v/kRjssiiteoY/bB3tR2Ys4R5Cx
        Xs4GBoajGWwllSQHEx3cJfpFhjyEW8I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 50afa035 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Oct 2022 20:01:50 +0000 (UTC)
Date:   Tue, 11 Oct 2022 14:01:45 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
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
Message-ID: <Y0XLqd/+C1sxq2G0@zx2c4.com>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
 <Y0UxY51KQoKCq59o@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0UxY51KQoKCq59o@gondor.apana.org.au>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 11, 2022 at 05:03:31PM +0800, Herbert Xu wrote:
> On Mon, Oct 10, 2022 at 09:15:48AM -0600, Jason A. Donenfeld wrote:
> >
> > Do you mean to say that other drivers that use hardware-backed keys do
> > so by setting "cra_name" to something particular? Like instead of "aes"
> > it'd be "aes-but-special-for-this-driver"? If so, that would seem to
> > break the design of the crypto API. Which driver did you see that does
> > this? Or perhaps, more generally, what are the drivers that Herbert is
> > talking about when he mentions the "plenty of existing drivers" that
> > already do this?
> 
> Grep for paes for the existing drivers that support this.  I don't
> have anything against this feature per se, but the last thing we
> want is a proliferation of different ways of doing the same thing.

I've got no stake in this, but isn't the whole idea that if you specify
"aes" you get AES, and if you specify "cbc(aes)" you get AES-CBC, and so
forth? And so leaking implementation details into the algorithm name
feels like it breaks the abstraction a bit.

Rather, drivers that do AES should be called "aes". For this hardware
key situation, I guess that means keys have a type (in-memory vs
hardware-resident). Then, a crypto operation takes an "algorithm" and a
"key", and the abstraction then picks the best implementation that's
compatible with both the "algorithm" and the "key".

I haven't looked carefully, but I assume that's more or less what this
patchset does.

If you don't want a proliferation of different ways of doing the same
thing, maybe the requirement should be that the author of this series
also converts the existing "paes" kludge to use the new thing he's
proposing?

Or maybe the "paes" kludge is better for other reasons? I don't know
really. Just my 2¢, but feel free to disregard, as I really have nothing
to do with this change.

Jason
