Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F069968E453
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 00:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBGXUX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 18:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBGXUW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 18:20:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6ED4491;
        Tue,  7 Feb 2023 15:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB44BB81B30;
        Tue,  7 Feb 2023 23:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658EBC433D2;
        Tue,  7 Feb 2023 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675812018;
        bh=So+Vqa3aMT2QOZxbrMv3Y/x9jBsIPhU5ldo/WI5PlqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJoZoX8yV0cVhyXM1ZUzPiMNG7MdXqFyMAiISMmQXzoG+9Ae0Q5p32PxBZIW7v9BK
         ngL7Wus9AmKYXRgUPIVWak6YL/VM7JteO1qXa7b9kEtJE34SsKgvi4SAFNE4vG3Cfq
         LXnnF0jRIkEkDvcuRW/htGjyGHftWc3S7i2wsCPq1oEFCg5K0/VBkePsa4eh8ylTbo
         eAIBm7EQS7O3rGH8GIw8Yb7/G2ZrLfLclJ+zCSms2KTK8/nvOQMWoKdlLsUldRt9uk
         PsbgFuHU5EcX6IyWFJCdI4DSok5w9EZA2vBepLxuNXzleynU7WhdWG6ziwoJLgUJGb
         41baGQOWQ36Yg==
Date:   Wed, 8 Feb 2023 01:20:11 +0200
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
Message-ID: <Y+Lcq0u6mUWxxgzd@kernel.org>
References: <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
 <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
 <Y8tcEtr8Kl3p4qtA@kernel.org>
 <CAFftDdoVraQVKLZGc6gMpZRyyK+LEO3cwjLhKM61qbp8ZSRYrg@mail.gmail.com>
 <5fb9193be57d22131feecf8b39dffbb03af3f60a.camel@linux.ibm.com>
 <Y9K2mOsmB1+CFk9l@kernel.org>
 <CAFftDdqq-eeryycv_11m=-1+aR=cgCUU7C_BFDrmYRwFF13i5w@mail.gmail.com>
 <Y9LxDYYEp0qTfhqN@kernel.org>
 <CAFftDdoSg-kF6fd2Jyz5UuP1pG_bUe0kYy+G9Y1_nfoUkkpW4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFftDdoSg-kF6fd2Jyz5UuP1pG_bUe0kYy+G9Y1_nfoUkkpW4g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 26, 2023 at 04:01:55PM -0600, William Roberts wrote:
> On Thu, Jan 26, 2023 at 3:30 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Thu, Jan 26, 2023 at 11:32:22AM -0600, William Roberts wrote:
> > > On Thu, Jan 26, 2023 at 11:21 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Tue, Jan 24, 2023 at 07:38:04AM -0500, James Bottomley wrote:
> > > > > On Mon, 2023-01-23 at 11:48 -0600, William Roberts wrote:
> > > > > > On Fri, Jan 20, 2023 at 9:29 PM Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > wrote:
> > > > > > >
> > > > > > > On Sat, Jan 14, 2023 at 09:55:37AM -0500, James Bottomley wrote:
> > > > > > > > On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> > > > > > > > > On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> > > > > > > > > <bill.c.roberts@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > > What's the use case of using the creation data and ticket in
> > > > > > > > > > this context? Who gets the creationData and the ticket?
> > > > > > > > > > Could a user supplied outsideInfo work? IIRC I saw some
> > > > > > > > > > patches flying around where the sessions will get encrypted
> > > > > > > > > > and presumably correctly as well. This would allow the
> > > > > > > > > > transfer of that outsideInfo, like the NV Index PCR value to
> > > > > > > > > > be included and integrity protected by the session HMAC.
> > > > > > > > >
> > > > > > > > > The goal is to ensure that the key was generated by the kernel.
> > > > > > > > > In the absence of the creation data, an attacker could generate
> > > > > > > > > a hibernation image using their own key and trick the kernel
> > > > > > > > > into resuming arbitrary code. We don't have any way to pass
> > > > > > > > > secret data from the hibernate kernel to the resume kernel, so
> > > > > > > > > I don't think there's any easy way to do it with outsideinfo.
> > > > > > > >
> > > > > > > > Can we go back again to why you can't use locality?  It's exactly
> > > > > > > > designed for this since locality is part of creation data.
> > > > > > > > Currently everything only uses locality 0, so it's impossible for
> > > > > > > > anyone on Linux to produce a key with anything other than 0 in
> > > > > > > > the creation data for locality.  However, the dynamic launch
> > > > > > > > people are proposing that the Kernel should use Locality 2 for
> > > > > > > > all its operations, which would allow you to distinguish a key
> > > > > > > > created by the kernel from one created by a user by locality.
> > > > > > > >
> > > > > > > > I think the previous objection was that not all TPMs implement
> > > > > > > > locality, but then not all laptops have TPMs either, so if you
> > > > > > > > ever come across one which has a TPM but no locality, it's in a
> > > > > > > > very similar security boat to one which has no TPM.
> > > > > > >
> > > > > > > Kernel could try to use locality 2 and use locality 0 as fallback.
> > > > > >
> > > > > > I don't think that would work for Matthew, they need something
> > > > > > reliable to indicate key provenance.
> > > > >
> > > > > No, I think it would be good enough: locality 0 means anyone (including
> > > > > the kernel on a machine which doesn't function correctly) could have
> > > > > created this key.  Locality 2 would mean only the kernel could have
> > > > > created this key.
> > > > >
> > > > > By the time the kernel boots and before it loads the hibernation image
> > > > > it will know the answer to the question "does my TPM support locality
> > > > > 2", so it can use that in its security assessment: if the kernel
> > > > > supports locality 2 and the key wasn't created in locality 2 then
> > > > > assume an attack.  Obviously, if the kernel doesn't support locality 2
> > > > > then the hibernation resume has to accept any old key, but that's the
> > > > > same as the situation today.
> > > >
> > > > This sounds otherwise great to me but why bother even allowing a
> > > > machine with no-locality TPM to be involved with hibernate? Simply
> > > > detect locality support during driver initialization and disallow
> > > > sealed hibernation (or whatever the feature was called) if localities
> > > > were not detected.
> > > >
> > > > I get supporting old hardware with old features but it does not make
> > > > sense to maintain new features with hardware, which clearly does not
> > > > scale, right?
> > > >
> > > > BR, Jarkko
> > >
> > > Here's a thought, what if we had a static/cmd line configurable
> > > no-auth NV Index and writelocked it with the expected key information,
> > > name or something. I guess the problem is atomicity with write/lock,
> > > but can't the kernel lock out all other users?
> > >
> > > An attacker would need to issue tpm2_startup, which in this case would DOS
> > > the kernel in both scenarios. If an attacker already wrote and locked the NV
> > > index, that would also be a DOS. If they already wrote it, the kernel simply
> > > writes whatever they want. Is there an attack I am missing?
> > >
> > > I guess the issue here would be setup, since creating the NV index requires
> > > hierarchy auth, does the kernel have platform auth or is that already shut down
> > > by firmware (I can't recall)? A null hierarchy volatile lockable index would be
> > > nice for this, too bad that doesn't exist.
> >
> > How do you see this would better when compared to finding a way to use
> > locality, which could potentially be made to somewhat simple to setup
> > (practically zero config)?
> >
> 
> I never said it was better, I said here is a thought for discussion.
> If we had to support older hardware (I could care less about things
> that don't support localities, but some might not), this could be an
> avenue to support them without walling off a PCR. I pointed out the
> downsides, and argument could be made that when localities is not
> supported then walling off PCR23 is the better approach if older
> hardware is an issue. This all hinges on do we care about things
> that don't support multiple localities. I don't, im for if you have locality
> support you get the feature else you don't.

Probably does not make much sense to care for this feature.

BR, Jarkko
