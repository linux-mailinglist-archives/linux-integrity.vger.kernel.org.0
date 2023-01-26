Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D3267D33B
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 18:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAZRcj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 12:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZRcg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 12:32:36 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47714203;
        Thu, 26 Jan 2023 09:32:35 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id r10so507372ual.3;
        Thu, 26 Jan 2023 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Kvan1cE5TszXm3b20r5mPyE1X4Ro0snfMtMiTJyF3M=;
        b=qgu8hWtCalIXRBaY8ckd2nhMjzCFHsQN4d7oK5nX70FFa3MiKXnw1SzYkMYOY+ViQS
         vCSDCU6IfzFcVfRWnKHvfrrEN+BxQPXCyxPKdnMNwCoZzCT7WYXZ/qC3EzqlFo7Fibo8
         mo3E3iJnXcuj7iUnTetRBawnskCSXLUera5pDdDwD4UwHLhmfYwHR/RjgKTSAOeg4BHD
         cRkHSL1pZrhuLc0WR23rgqw60VY1u6SqJ9LCZfTYI1cTol6B9gwjdO3IaTOYN8TNhVii
         p8QdVjL7V+fvrgYE/6RRahDhcyTT4Qwr/g3T4qyY2zHS/dq+0A19bDWrzuDv45FXz43n
         AdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Kvan1cE5TszXm3b20r5mPyE1X4Ro0snfMtMiTJyF3M=;
        b=OnwuGqltAYNaL1TEybfEI2paj6E5xB/+KdA6a/NjEUfxH91IbZcE2LME84tJr9OlHN
         qXbAUbnnPXLUzSDc91BgEmBDkUqrMNfiPuRJAtvml4vKv/L6gflqpLSO6ahNJgII9MDi
         EETYKbrPrz5ia6H96fIEzwyggO08VLl6U0HtFigFQ1iydx+0zSk7Jg8MPtjfIVCY6m15
         M7+UQe4+tYxSDS9ZFwBdjz2o2vOYDiVOix3SPB0g51RD0tF4bVSPrADX0jcqPBljjmk2
         /lNVLofA9bbLnpLA9O83HxCVFUsZkH2iuonhstgTAJeMLqekLj4sNZjjAcBISj0BlX4X
         IxzQ==
X-Gm-Message-State: AFqh2kpoHHgqCNMwFGesr03FanXMeFNV9UNUYQB6dUjlO7+ykcLihQCp
        z2TeUMJsKxPf+h8pkGwgsdBW5vn1pvputPxGuo8=
X-Google-Smtp-Source: AMrXdXuABD3oR5/YWZU62q2k2T36A2P/sZc6EOA2y4ZKKLnK5zo2vxEVYaWtNmsZx+JvoBHcUSmm5W07YhRVYqB2cVk=
X-Received: by 2002:a9f:3767:0:b0:512:da2a:c925 with SMTP id
 a36-20020a9f3767000000b00512da2ac925mr4017787uae.71.1674754354176; Thu, 26
 Jan 2023 09:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
 <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
 <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
 <Y8tcEtr8Kl3p4qtA@kernel.org> <CAFftDdoVraQVKLZGc6gMpZRyyK+LEO3cwjLhKM61qbp8ZSRYrg@mail.gmail.com>
 <5fb9193be57d22131feecf8b39dffbb03af3f60a.camel@linux.ibm.com> <Y9K2mOsmB1+CFk9l@kernel.org>
In-Reply-To: <Y9K2mOsmB1+CFk9l@kernel.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 26 Jan 2023 11:32:22 -0600
Message-ID: <CAFftDdqq-eeryycv_11m=-1+aR=cgCUU7C_BFDrmYRwFF13i5w@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 26, 2023 at 11:21 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Jan 24, 2023 at 07:38:04AM -0500, James Bottomley wrote:
> > On Mon, 2023-01-23 at 11:48 -0600, William Roberts wrote:
> > > On Fri, Jan 20, 2023 at 9:29 PM Jarkko Sakkinen <jarkko@kernel.org>
> > > wrote:
> > > >
> > > > On Sat, Jan 14, 2023 at 09:55:37AM -0500, James Bottomley wrote:
> > > > > On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> > > > > > On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> > > > > > <bill.c.roberts@gmail.com> wrote:
> > > > > >
> > > > > > > What's the use case of using the creation data and ticket in
> > > > > > > this context? Who gets the creationData and the ticket?
> > > > > > > Could a user supplied outsideInfo work? IIRC I saw some
> > > > > > > patches flying around where the sessions will get encrypted
> > > > > > > and presumably correctly as well. This would allow the
> > > > > > > transfer of that outsideInfo, like the NV Index PCR value to
> > > > > > > be included and integrity protected by the session HMAC.
> > > > > >
> > > > > > The goal is to ensure that the key was generated by the kernel.
> > > > > > In the absence of the creation data, an attacker could generate
> > > > > > a hibernation image using their own key and trick the kernel
> > > > > > into resuming arbitrary code. We don't have any way to pass
> > > > > > secret data from the hibernate kernel to the resume kernel, so
> > > > > > I don't think there's any easy way to do it with outsideinfo.
> > > > >
> > > > > Can we go back again to why you can't use locality?  It's exactly
> > > > > designed for this since locality is part of creation data.
> > > > > Currently everything only uses locality 0, so it's impossible for
> > > > > anyone on Linux to produce a key with anything other than 0 in
> > > > > the creation data for locality.  However, the dynamic launch
> > > > > people are proposing that the Kernel should use Locality 2 for
> > > > > all its operations, which would allow you to distinguish a key
> > > > > created by the kernel from one created by a user by locality.
> > > > >
> > > > > I think the previous objection was that not all TPMs implement
> > > > > locality, but then not all laptops have TPMs either, so if you
> > > > > ever come across one which has a TPM but no locality, it's in a
> > > > > very similar security boat to one which has no TPM.
> > > >
> > > > Kernel could try to use locality 2 and use locality 0 as fallback.
> > >
> > > I don't think that would work for Matthew, they need something
> > > reliable to indicate key provenance.
> >
> > No, I think it would be good enough: locality 0 means anyone (including
> > the kernel on a machine which doesn't function correctly) could have
> > created this key.  Locality 2 would mean only the kernel could have
> > created this key.
> >
> > By the time the kernel boots and before it loads the hibernation image
> > it will know the answer to the question "does my TPM support locality
> > 2", so it can use that in its security assessment: if the kernel
> > supports locality 2 and the key wasn't created in locality 2 then
> > assume an attack.  Obviously, if the kernel doesn't support locality 2
> > then the hibernation resume has to accept any old key, but that's the
> > same as the situation today.
>
> This sounds otherwise great to me but why bother even allowing a
> machine with no-locality TPM to be involved with hibernate? Simply
> detect locality support during driver initialization and disallow
> sealed hibernation (or whatever the feature was called) if localities
> were not detected.
>
> I get supporting old hardware with old features but it does not make
> sense to maintain new features with hardware, which clearly does not
> scale, right?
>
> BR, Jarkko

Here's a thought, what if we had a static/cmd line configurable
no-auth NV Index and writelocked it with the expected key information,
name or something. I guess the problem is atomicity with write/lock,
but can't the kernel lock out all other users?

An attacker would need to issue tpm2_startup, which in this case would DOS
the kernel in both scenarios. If an attacker already wrote and locked the NV
index, that would also be a DOS. If they already wrote it, the kernel simply
writes whatever they want. Is there an attack I am missing?

I guess the issue here would be setup, since creating the NV index requires
hierarchy auth, does the kernel have platform auth or is that already shut down
by firmware (I can't recall)? A null hierarchy volatile lockable index would be
nice for this, too bad that doesn't exist.
