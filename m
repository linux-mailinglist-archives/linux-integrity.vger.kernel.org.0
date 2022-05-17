Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D79852A9C9
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351744AbiEQSBN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351724AbiEQSBD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 14:01:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DCC38DA7;
        Tue, 17 May 2022 11:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F7861475;
        Tue, 17 May 2022 18:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C14C385B8;
        Tue, 17 May 2022 18:00:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IWaU0P9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652810456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIvWyHfOQIR1tPAdB9mF+GPuZBnqjHJbDDlA9qL55rA=;
        b=IWaU0P9YKirAbyAX2ryUkPQEA2hxEes0Y3qkw4mt+f8Cgoci+m4YJBKKeQMoXBV9PoUhoO
        GpySOT4hW+NN0ZjwRCALfKVgGdXUqAKdVug0vEuomby3JhkiHBqTcJi9f4PfGqo0OYmcmT
        XTqCCA6DFbm5vzXk+2GZBFZsadB6B2U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8ca48184 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 17 May 2022 18:00:55 +0000 (UTC)
Date:   Tue, 17 May 2022 20:00:45 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
Message-ID: <YoPizavHFXHah2z3@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <YoPa7C8xs8lgKtwv@zx2c4.com>
 <21250bc0-623b-f11d-7dbf-458d144b7963@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21250bc0-623b-f11d-7dbf-458d144b7963@pengutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ahmad,

On Tue, May 17, 2022 at 07:52:51PM +0200, Ahmad Fatoum wrote:
> Hello Jason,
> 
> On 17.05.22 19:27, Jason A. Donenfeld wrote:
> > On Fri, May 13, 2022 at 04:57:00PM +0200, Ahmad Fatoum wrote:
> >> +	trusted.rng=	[KEYS]
> >> +			Format: <string>
> >> +			The RNG used to generate key material for trusted keys.
> >> +			Can be one of:
> >> +			- "kernel"
> >> +			- the same value as trusted.source: "tpm" or "tee"
> >> +			- "default"
> >> +			If not specified, "default" is used. In this case,
> >> +			the RNG's choice is left to each individual trust source.
> >> +
> > 
> > As a general mechanism, I object to this. The kernel's RNG must be
> > trusted in the first place for key material. That's the whole point of
> > it.
> > 
> > However, it sounds like you're not proposing a general mechanism, but
> > just something particular to this "trusted keys" business.
> 
> The two currently upstream trust sources (trusted key backends) each provide
> their own RNG callback. This series adds a third backend that uses kernel RNG
> and additionally provides users of the two existing trust sources the option
> to benefit from kernel RNG as well.
> 
> > this should be a module flag, and thus not documented here, but rather
> > some place namespaced to your trusted keys stuff. "trusted_keys.preferred_rng={whatever}"
> 
> The trusted keys module is trusted.ko and directly before my added lines is
> the trusted.source=  documentation, so I think this is already at the correct place.

My apologies; I should have looked at the file itself instead of just
relying on git line context. You're right, the module itself is called
trusted.ko. This is confusing (shouldn't it be trusted_keys or
something?) , but what you propose sounds consistent from a namespacing
perspective with what's already there.

Jason
