Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC08667D2D0
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAZRMn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 12:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZRMn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 12:12:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9765BC;
        Thu, 26 Jan 2023 09:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F86FCE237C;
        Thu, 26 Jan 2023 17:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9C4C433EF;
        Thu, 26 Jan 2023 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674753157;
        bh=Im0qSEmIpEvi0cG/8KX6m/5mv9jtPX9n8iqAuczZp1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4rLxeKatKTlfCnFNGNXVgz1r1hnTh4DAF6To1mDpxRt6uD5+XdR9nhzj041A82lq
         yfh/Xz+rYnJ+5tZpEXHoZSbpiPTw32+k2JPOMXCWo6lMeqd80Uj/dN4HRjFGKhaHhb
         jwk+Xw6KV/N9UKBeLr9o1ErnVIxboFxuzunWibU10YhOxiGCNwHjLyjW3yVFvJxIMc
         rqVM7ayqw0H0ZaPNsty0+ihiLJKXWSat8EU8qHKRbvX586HvzxsDupA2h6G+orirDf
         NnviOoeUqJT+toPK0NJ2ruvVjkNsg9ZQQBzL88go4QSHhQNlHZumGcu6WxX3EcivlE
         o47Yth4ujI8kw==
Date:   Thu, 26 Jan 2023 17:12:35 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, linux-pm@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <Y9K0g6LbyDZSK29q@kernel.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
 <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
 <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
 <Y8tcEtr8Kl3p4qtA@kernel.org>
 <CAFftDdoVraQVKLZGc6gMpZRyyK+LEO3cwjLhKM61qbp8ZSRYrg@mail.gmail.com>
 <Y9KzXPuMUAa47lj3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9KzXPuMUAa47lj3@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 26, 2023 at 05:07:43PM +0000, Jarkko Sakkinen wrote:
> On Mon, Jan 23, 2023 at 11:48:25AM -0600, William Roberts wrote:
> > On Fri, Jan 20, 2023 at 9:29 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Sat, Jan 14, 2023 at 09:55:37AM -0500, James Bottomley wrote:
> > > > On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> > > > > On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> > > > > <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > > What's the use case of using the creation data and ticket in this
> > > > > > context? Who gets the creationData and the ticket?
> > > > > > Could a user supplied outsideInfo work? IIRC I saw some patches
> > > > > > flying around where the sessions will get encrypted and presumably
> > > > > > correctly as well. This would allow the transfer of that
> > > > > > outsideInfo, like the NV Index PCR value to be included and
> > > > > > integrity protected by the session HMAC.
> > > > >
> > > > > The goal is to ensure that the key was generated by the kernel. In
> > > > > the absence of the creation data, an attacker could generate a
> > > > > hibernation image using their own key and trick the kernel into
> > > > > resuming arbitrary code. We don't have any way to pass secret data
> > > > > from the hibernate kernel to the resume kernel, so I don't think
> > > > > there's any easy way to do it with outsideinfo.
> > > >
> > > > Can we go back again to why you can't use locality?  It's exactly
> > > > designed for this since locality is part of creation data.  Currently
> > > > everything only uses locality 0, so it's impossible for anyone on Linux
> > > > to produce a key with anything other than 0 in the creation data for
> > > > locality.  However, the dynamic launch people are proposing that the
> > > > Kernel should use Locality 2 for all its operations, which would allow
> > > > you to distinguish a key created by the kernel from one created by a
> > > > user by locality.
> > > >
> > > > I think the previous objection was that not all TPMs implement
> > > > locality, but then not all laptops have TPMs either, so if you ever
> > > > come across one which has a TPM but no locality, it's in a very similar
> > > > security boat to one which has no TPM.
> > >
> > > Kernel could try to use locality 2 and use locality 0 as fallback.
> > 
> > I don't think that would work for Matthew, they need something
> > reliable to indicate key provenance.
> > 
> > I was informed that all 5 localities should be supported starting
> > with Gen 7 Kaby Lake launched in 2016. Don't know if this is
> > still "too new".
> 
> What about having opt-in flag that distributions can then enable?

This is more intrusive but still worth of consideration: add opt-in
kernel command-line flag for no locality. I.e. require locality support
unless explicitly stated otherwise.

I'd presume that legacy production cases are a rarity but really is
something that is beyond me, and could potentially draw wrong conclusions.

BR, Jarkko
