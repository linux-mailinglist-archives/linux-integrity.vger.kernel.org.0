Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1AE67838F
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 18:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAWRsj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 12:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAWRsi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 12:48:38 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63897ED7;
        Mon, 23 Jan 2023 09:48:37 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 3so13765340vsq.7;
        Mon, 23 Jan 2023 09:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5T0R8xw8fLnWbY1bVzZ9vubTFqhlFK/RWCUsjgwBlk0=;
        b=mQ/DwTxG5eOQGFJv2eC2szm9EanBABfaeHDADhlyiz5KEeo1n5ITjX65tdcjBCu0gc
         Vklg1PLCIG6T3B1XiWYLzg3Zsbj9GpmCeGTzlWDtBEwZB1GHD5vLtJL4mcnkTSRcDGME
         KqncecNfpF+ufysoO3TTLOdHm2ugvGP8UFCYTYLDDLybVDXO5MODUAfuYGS5OOLgq73I
         LO3pGeS1yEiR+OltOytCdnIfPM19fmQpFYpWaQtJugD2wAOk0IUIZjbYqL1FVZ6lI9fq
         kwriEf2MOBjM2d/1IF8uYY8HUjFQOHVOVwHC7UDRf3DWsuY34ZIyevNzWVysYu4fjKat
         d3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5T0R8xw8fLnWbY1bVzZ9vubTFqhlFK/RWCUsjgwBlk0=;
        b=NfQXkVDmKVwM2s/hPevCRYJWUpKdSK6Vl2vllhYJ/mQTv9/5TdyFt9fZBwh3zaKWAX
         W+fDsfn1kZSaqf4cLXOLK70mOKTx368q4Fs9g6fk0o4oQw4i1iTE8eh/U0OgtmPiDhnA
         F0QPrPcro4beWk+HalgmNxl6gx773DaKTT7GqvaYgkS62Dvfyo/8cEWzy54T3h/CNVru
         MAuslWOtPr0U2ZbvvHlx67MrPXCxaUayazd87RXX8eUmp/zwJypql5KpcYXGxO8Ta8jL
         uYeIjt5CgAPOND1uaNhr7L45rIDh1gbi1geP6/jUoJ2q5ottoqbKDdsP/1sTq4DGy8A8
         6lQQ==
X-Gm-Message-State: AFqh2kqsHBd9i/wa2kJDBHZ4C0bclKPh+LJ62/xsu0a3Y57fATkUwu9I
        M3wPubY10kspWnnL80p1dPtwNq8cuK2TL0YRSy0=
X-Google-Smtp-Source: AMrXdXvuPwYtIEZpsWrv4ZFsxzPB4C+HGxA0g+XpqN1OFuaz75cvM0xxhTuLaS2ziKK3sI9p9uaL/zAk4sliCAhbxEc=
X-Received: by 2002:a67:efc2:0:b0:3d0:d941:d598 with SMTP id
 s2-20020a67efc2000000b003d0d941d598mr4303312vsp.8.1674496116700; Mon, 23 Jan
 2023 09:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
 <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
 <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com> <Y8tcEtr8Kl3p4qtA@kernel.org>
In-Reply-To: <Y8tcEtr8Kl3p4qtA@kernel.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 23 Jan 2023 11:48:25 -0600
Message-ID: <CAFftDdoVraQVKLZGc6gMpZRyyK+LEO3cwjLhKM61qbp8ZSRYrg@mail.gmail.com>
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

On Fri, Jan 20, 2023 at 9:29 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat, Jan 14, 2023 at 09:55:37AM -0500, James Bottomley wrote:
> > On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> > > On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > >
> > > > What's the use case of using the creation data and ticket in this
> > > > context? Who gets the creationData and the ticket?
> > > > Could a user supplied outsideInfo work? IIRC I saw some patches
> > > > flying around where the sessions will get encrypted and presumably
> > > > correctly as well. This would allow the transfer of that
> > > > outsideInfo, like the NV Index PCR value to be included and
> > > > integrity protected by the session HMAC.
> > >
> > > The goal is to ensure that the key was generated by the kernel. In
> > > the absence of the creation data, an attacker could generate a
> > > hibernation image using their own key and trick the kernel into
> > > resuming arbitrary code. We don't have any way to pass secret data
> > > from the hibernate kernel to the resume kernel, so I don't think
> > > there's any easy way to do it with outsideinfo.
> >
> > Can we go back again to why you can't use locality?  It's exactly
> > designed for this since locality is part of creation data.  Currently
> > everything only uses locality 0, so it's impossible for anyone on Linux
> > to produce a key with anything other than 0 in the creation data for
> > locality.  However, the dynamic launch people are proposing that the
> > Kernel should use Locality 2 for all its operations, which would allow
> > you to distinguish a key created by the kernel from one created by a
> > user by locality.
> >
> > I think the previous objection was that not all TPMs implement
> > locality, but then not all laptops have TPMs either, so if you ever
> > come across one which has a TPM but no locality, it's in a very similar
> > security boat to one which has no TPM.
>
> Kernel could try to use locality 2 and use locality 0 as fallback.

I don't think that would work for Matthew, they need something
reliable to indicate key provenance.

I was informed that all 5 localities should be supported starting
with Gen 7 Kaby Lake launched in 2016. Don't know if this is
still "too new".

>
> BR, Jarkko
