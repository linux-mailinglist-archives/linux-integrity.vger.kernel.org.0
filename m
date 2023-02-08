Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA468E652
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 03:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBHCwN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 21:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBHCwM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 21:52:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6D3BD94;
        Tue,  7 Feb 2023 18:52:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1182DB81B9F;
        Wed,  8 Feb 2023 02:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1CDC433EF;
        Wed,  8 Feb 2023 02:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675824727;
        bh=b/rkymYs8+pjheRuYyegq/Om1XooZkZ/LI4pZoJDRVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaDVTGhkKI4ZBPjAlHb+gUIHgeBKmxo0U2I2yRvZB4o8li5UpeKZxMQDVwKZyMxlt
         Ufp8DeaHUML/fopNaEwYMhBvqvRnMs3L3D5fUhAjaVfoViLCeDqrlOaiLDBMNMJQb+
         javTqb2h8S4BgtHWDphOip3EWRCzvkgEUXm2BWkoAomtOavGdD/L4gG+2CP/VfNfxh
         nLTbwBf36NZNOdDir7tmEfJ/9ltqeOqls0Y/7H6XIy00wqMlnGIE2n43S1pD0KjNgF
         qQq4s0rDMVNCxNP0SiNHT3sNcoEGn2d2fJ77WQ5HtJs4bxiOuRXq/7o6kh44eswyfK
         zjmJn3zepZU6A==
Date:   Wed, 8 Feb 2023 04:52:02 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, reach622@mailcuk.com,
        1138267643@qq.com
Subject: Re: [regression] Bug 216989 - since 6.1 systems with AMD Ryzen
 stutter when fTPM is enabled
Message-ID: <Y+MOUsLIniYS/mw8@kernel.org>
References: <3a196414-68d8-29c9-24cc-2b8cb4c9d358@leemhuis.info>
 <8a7775912f31394944b43db12adc78efd84b1fad.camel@HansenPartnership.com>
 <Y+MFNvr2deX7+Mxa@kernel.org>
 <Y+MFUZ7WD0rX2rU9@kernel.org>
 <CAHmME9pwT52maXyQMNutv6svgDxAaz3L4MDeq_KVDutOAe8uPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pwT52maXyQMNutv6svgDxAaz3L4MDeq_KVDutOAe8uPw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 07, 2023 at 11:31:37PM -0300, Jason A. Donenfeld wrote:
> On Tue, Feb 7, 2023 at 11:13 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Feb 08, 2023 at 04:13:16AM +0200, Jarkko Sakkinen wrote:
> > > On Thu, Feb 02, 2023 at 07:57:37AM -0500, James Bottomley wrote:
> > > > On Thu, 2023-02-02 at 11:28 +0100, Linux kernel regression tracking
> > > > (Thorsten Leemhuis) wrote:
> > > > [...]
> > > > > So it's a firmware problem, but apparently one that Linux only
> > > > > triggers since 6.1.
> > > > >
> > > > > Jason, could the hwrng changes have anything to do with this?
> > > > >
> > > > > A bisection really would be helpful, but I guess that is not easy as
> > > > > the problem apparently only shows up after some time...
> > > >
> > > > the problem description says the fTPM causes system stutter when it
> > > > writes to NVRAM.  Since an fTPM is a proprietary implementation, we
> > > > don't know what it does.  The ms TPM implementation definitely doesn't
> > > > trigger NV writes on rng requests, but it is plausible this fTPM does
> > > > ... particularly if they have a time based input to the DRNG.  Even if
> > > > this speculation is true, there's not much we can do about it, since
> > > > it's a firmware bug and AMD should have delivered the BIOS update that
> > > > fixes it.
> > > >
> > > > The way to test this would be to set the config option
> > > >
> > > > CONFIG_HW_RANDOM_TPM=n
> > > >
> > > > and see if the stutter goes away.  I suppose if someone could quantify
> > > > the bad bioses, we could warn, but that's about it.
> > > >
> > > > James
> > > >
> > >
> > > And e.g. I do not have a Ryzen CPU so pretty hard to answer such question.
> >
> > ... about hwrng
> 
> Well, the options here are basically:
> 
> a) Do nothing, and just expect people to update their BIOSes, since an
> update is available.
> b) Do nothing, and expect people with broken BIOSes to `echo blacklist
> tpm >> /etc/modprobesomethingsomething`.
> c) Figure out how to identify the buggy BIOS and disable the TPM's rng
> with a quirk in this case.
> d) Figure out how to dynamically detect TPM rng latency, and warn about it.
> e) Figure out how to dynamically detect TPM rng latency, and disable it.
> 
> I think given that a firmware update *is* available, (a) is fine. And
> the generic workaround remains (b). But if you want to be really nice,
> (c) would be fine too. Somebody with the affected hardware would
> probably have to send in some DMI logs or whatever else. (d) and (e)
> sound possible in theory but I dunno really... seems finicky.
> 
> Jason

For now (a), but if someone with capable hardware can make up something
I'm happy to go that through, if it makes sense.

BR, Jarkko
