Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975AE52AA82
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352028AbiEQSV2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352029AbiEQSVB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 14:21:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A449CEE2F;
        Tue, 17 May 2022 11:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F57061572;
        Tue, 17 May 2022 18:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A66C34100;
        Tue, 17 May 2022 18:20:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZuGFcQ7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652811655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrNAXMhJ8mMt1s0emycVPYEmjWKKVUxh1cIx7NgNQRA=;
        b=ZuGFcQ7HqjJE6N/4FKfja7HhkUhhKfJLBlFfarWuglq47CTKhYlOtPcM+KWWz8Ryujubva
        V75Gu2dAXANAViWkoeVd3kc+sQQf2Xv/XnwGClh3Qy+tdOxPgLV4CFLnV52WR/D3o/ATOk
        vh2lzem+aoZbYLqk3DGEeg1gYcgYcYM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id daf36959 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 17 May 2022 18:20:55 +0000 (UTC)
Date:   Tue, 17 May 2022 20:20:49 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
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
Message-ID: <YoPngQEY3az9J+AB@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <YoPa7C8xs8lgKtwv@zx2c4.com>
 <0e8da958a222e5c1dccaaf1600b08bdb8705b48e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e8da958a222e5c1dccaaf1600b08bdb8705b48e.camel@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,


On Tue, May 17, 2022 at 09:10:57PM +0300, Jarkko Sakkinen wrote:
> On Tue, 2022-05-17 at 19:27 +0200, Jason A. Donenfeld wrote:
> > On Fri, May 13, 2022 at 04:57:00PM +0200, Ahmad Fatoum wrote:
> > > +       trusted.rng=    [KEYS]
> > > +                       Format: <string>
> > > +                       The RNG used to generate key material for trusted keys.
> > > +                       Can be one of:
> > > +                       - "kernel"
> > > +                       - the same value as trusted.source: "tpm" or "tee"
> > > +                       - "default"
> > > +                       If not specified, "default" is used. In this case,
> > > +                       the RNG's choice is left to each individual trust source.
> > > +
> > 
> > As a general mechanism, I object to this. The kernel's RNG must be
> > trusted in the first place for key material. That's the whole point of
> > it.
> 
> I would relax this  a bit: kernel's RNG must be implicitly must be

Sorry, I didn't mean to seem unrelaxed. What I meant was that as a
general mechanism, it doesn't make sense, but it isn't a general
mechanism, it's a particular one for trusted_keys, which led me to
question why it seemed to have such a general name like "trusted.rng".
Ahmad pointed out that the trusted prefix actually isn't general. It's
what trusted_keys compiles its module as. So just a misunderstanding. It
appears to be a module param after all. Sorry for the noise!

Jason
