Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3C679CE4
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 16:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjAXPGF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 10:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjAXPGE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 10:06:04 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C9166F9;
        Tue, 24 Jan 2023 07:06:03 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id b18so3795841uan.11;
        Tue, 24 Jan 2023 07:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk4NzLn775SqBcZ9Gdxs085F6GDZQ3PRAe8LMT1ju+U=;
        b=opkDBuFFr0iqHbk1+WK1en1LCdiewYwnnrcBIpbNpI+rj6VK1o0plpD9kOQP03etTU
         zuyjkjFpCIe91cMdry3vD8yjnFL7Q7qfYjlmiUmBiBC9DeSG/dt1Uh6/M0kbYRNI8Pzp
         MJnBNieAp9FzNSlPbMH/pdqyHdsLUG2PjQGEJd+ElZG4b0arLzxTrONQ38e57dCtF3mx
         OMAUKhtnDQKU6gUeiLdt2X60efjUHbQWOjGeC9zLwC5JlnqweNcXyYjiSENhDU9+tNo0
         aQ/fuH31TNoIvjSCpIrwoMGruvUIUcp/GoABW26wxDubQo6Yje3WW+Jp8xMK4fXri2r6
         pUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xk4NzLn775SqBcZ9Gdxs085F6GDZQ3PRAe8LMT1ju+U=;
        b=WYpgkoOLLSM4sAiQZxQ0m5tn9/AcsmKD5ul72ohUdTKjWx64oFi9ucQPKEAIocweKy
         PY+rB1Iwb5vxtpGr/Dh0xaOCmQfU1RFZCvBsW2zuG18U+ynvdJsejI/CR9GVVfkXWHKf
         1gbg31DLoyjRnnq49OjjClX53lYubgfM24cjX7ZuHaxUOfo0RIsrwW42eI2Pc9uDWl1z
         8HARmWua3TJ0lVkV1ApJ+4Ak46U07pZyft/Mbmq1GCGo/XxEBayGB04WjskMcvFLU1IP
         Hdw1KAZaj4llYRi2vOlSrzRkONr8cQgMhKiEtkSWylrBdSX+UiIFw+551cCltDmDEVDv
         TVhg==
X-Gm-Message-State: AO0yUKVeQ89gSMHGcbRglSHsbcDihYBTAWglZXqh/B4kpUbkqmMGWCnp
        4utSFtfZtnVeWe14qd9peqazG4/ZlFILhXKEQeQ=
X-Google-Smtp-Source: AK7set9SxL8+BSSAQ+mGJmncufvAe48UOmzcxwxelwoZtvwfaIYGMbwfRem2FF7dyTqHGOxPxpCP4PWKX5CxGxWC588=
X-Received: by 2002:ab0:71ca:0:b0:655:c9e7:b4d2 with SMTP id
 n10-20020ab071ca000000b00655c9e7b4d2mr46376uao.78.1674572762009; Tue, 24 Jan
 2023 07:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
 <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
 <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
 <Y8tcEtr8Kl3p4qtA@kernel.org> <CAFftDdoVraQVKLZGc6gMpZRyyK+LEO3cwjLhKM61qbp8ZSRYrg@mail.gmail.com>
 <5fb9193be57d22131feecf8b39dffbb03af3f60a.camel@linux.ibm.com>
In-Reply-To: <5fb9193be57d22131feecf8b39dffbb03af3f60a.camel@linux.ibm.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 24 Jan 2023 09:05:50 -0600
Message-ID: <CAFftDdpC4BAqYHP=26T-bkntv-mdrwJD2MP6HBWzHvBSEXRDFw@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     jejb@linux.ibm.com
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
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

On Tue, Jan 24, 2023 at 6:38 AM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Mon, 2023-01-23 at 11:48 -0600, William Roberts wrote:
> > On Fri, Jan 20, 2023 at 9:29 PM Jarkko Sakkinen <jarkko@kernel.org>
> > wrote:
> > >
> > > On Sat, Jan 14, 2023 at 09:55:37AM -0500, James Bottomley wrote:
> > > > On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> > > > > On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> > > > > <bill.c.roberts@gmail.com> wrote:
> > > > >
> > > > > > What's the use case of using the creation data and ticket in
> > > > > > this context? Who gets the creationData and the ticket?
> > > > > > Could a user supplied outsideInfo work? IIRC I saw some
> > > > > > patches flying around where the sessions will get encrypted
> > > > > > and presumably correctly as well. This would allow the
> > > > > > transfer of that outsideInfo, like the NV Index PCR value to
> > > > > > be included and integrity protected by the session HMAC.
> > > > >
> > > > > The goal is to ensure that the key was generated by the kernel.
> > > > > In the absence of the creation data, an attacker could generate
> > > > > a hibernation image using their own key and trick the kernel
> > > > > into resuming arbitrary code. We don't have any way to pass
> > > > > secret data from the hibernate kernel to the resume kernel, so
> > > > > I don't think there's any easy way to do it with outsideinfo.
> > > >
> > > > Can we go back again to why you can't use locality?  It's exactly
> > > > designed for this since locality is part of creation data.
> > > > Currently everything only uses locality 0, so it's impossible for
> > > > anyone on Linux to produce a key with anything other than 0 in
> > > > the creation data for locality.  However, the dynamic launch
> > > > people are proposing that the Kernel should use Locality 2 for
> > > > all its operations, which would allow you to distinguish a key
> > > > created by the kernel from one created by a user by locality.
> > > >
> > > > I think the previous objection was that not all TPMs implement
> > > > locality, but then not all laptops have TPMs either, so if you
> > > > ever come across one which has a TPM but no locality, it's in a
> > > > very similar security boat to one which has no TPM.
> > >
> > > Kernel could try to use locality 2 and use locality 0 as fallback.
> >
> > I don't think that would work for Matthew, they need something
> > reliable to indicate key provenance.
>
> No, I think it would be good enough: locality 0 means anyone (including
> the kernel on a machine which doesn't function correctly) could have
> created this key.  Locality 2 would mean only the kernel could have
> created this key.

That's exactly what I was saying, for this feature to be functional
2 localities need to be supported.

>
> By the time the kernel boots and before it loads the hibernation image
> it will know the answer to the question "does my TPM support locality
> 2", so it can use that in its security assessment: if the kernel
> supports locality 2 and the key wasn't created in locality 2 then
> assume an attack.  Obviously, if the kernel doesn't support locality 2
> then the hibernation resume has to accept any old key, but that's the
> same as the situation today.
>

Yep, we had this conversation offline on a thread, i'm in agreement here
as well.

> > I was informed that all 5 localities should be supported starting
> > with Gen 7 Kaby Lake launched in 2016. Don't know if this is
> > still "too new".
>
> It's probably good enough.  Current laptops which can't use locality 2
> are in the same position as now, but newer ones can provide more
> security guarantees.
>
> There is, however, another wrinkle: can Kaby Lake be persuaded, though
> bios settings perhaps, to shut off the non zero localities?

I have no idea, and I don't have one handy, but I can ask around.

> This would
> allow for a downgrade attack where you shut off locality 2 then present
> a forged locality 0 key and hibernation image; the kernel will think,
> because it can't access locality 2, that it's in a reduced security
> environment so the key might be OK.  We could fix this by requiring
> Kaby Lake and beyond to have locality 2 and refusing to hibernate if it
> can't be accessed and building "is this Kaby lake or beyond" into the
> check for should I have locality 2, but this is getting complex and
> error prone.
>
> James
>
