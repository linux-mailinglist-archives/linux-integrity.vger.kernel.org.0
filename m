Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EDC67D2EC
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 18:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjAZRUo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 12:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAZRUn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 12:20:43 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203B3A8E;
        Thu, 26 Jan 2023 09:20:42 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id l20so1182266vkm.11;
        Thu, 26 Jan 2023 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gypZIGKCMBwRakbTeW2mNgmDloffVZ3ZFDcOsdQTUB4=;
        b=Jw5V33HgsfaC92O5v8Fz/T2rlWYCXZDXCXVGVWAe3Orrt2IzAm2BupN2dqAPiQgJ6p
         ZcEo/9UmbMfX5OmifTY61X5M+9Er6SZkpJqfW/uVvbQbxVLMesCvKckvoASAa1hFGv3o
         8rQQnThUDSnOBFZQhCiqAh9r2e3+TASAFW2NHJk2e4HwdJVKq/ioO60EXYaXln+AMS8B
         8MHi/9jyeyquoBNG2MVd+HHEPoeJRiuiE3rk7RbPJqoOT3s7Dhe2u3MP25/ldeGQ5qxL
         JYD4PbUm9qcdlUlYawnKP/bfUQIWax3EhhZ/5jjDbwRujZSBzhZFb6pY7qIkmU1Ml5vu
         6wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gypZIGKCMBwRakbTeW2mNgmDloffVZ3ZFDcOsdQTUB4=;
        b=g9tSdKvMFAY+BYq1JI4nPsHdmPGjTJU3QdtyHYIk8IiMq+XcSN10cq48ocL2n+YRRl
         hV0IOMJpCs1yPy2AwpgsOdTcZuMTE54ge+ThZkS/LyjEUpG4Hd3Isu6T4Y0FkflgLFA5
         5XP8wZA7/e8G3T1pL09Sg7qghH00OvTOCNVY6TThDt8ZR1tTxxk/w7qvgrLVKVFmAlDH
         UosjduRHQwCAQJa4JwOaEoay+5Ddwk922dL+H0Bm4IfSxYO2/Pj0MvedElGKTEjaathl
         fCmX1T8WXeu3XdHS/8w5UbZEsYfZiEQm8P7y8hzRzsoHHVH0mcymj49Gd8P9ZtJvqVVO
         eSbg==
X-Gm-Message-State: AO0yUKVMuwdn10mv5pSktiplMDodKg7Zwh7jDJLhl4Ugwy6jkyDeILxs
        NcFva0VwdJvfFjCjQu+oLHM2SLzd3tK6YvVk0O0=
X-Google-Smtp-Source: AK7set9kCH7YKP6MAeua8M6qc/TXXl9/rf8W7WzPuclH7p5FUqat1hX+7PC2XNaoUUCtO8DDzxkZftLbv/mhU4nhuu4=
X-Received: by 2002:a1f:a1cf:0:b0:3e6:16e7:b24b with SMTP id
 k198-20020a1fa1cf000000b003e616e7b24bmr781602vke.14.1674753641605; Thu, 26
 Jan 2023 09:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
 <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
 <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
 <Y8tcEtr8Kl3p4qtA@kernel.org> <CAFftDdoVraQVKLZGc6gMpZRyyK+LEO3cwjLhKM61qbp8ZSRYrg@mail.gmail.com>
 <Y9KzXPuMUAa47lj3@kernel.org> <Y9K0g6LbyDZSK29q@kernel.org>
In-Reply-To: <Y9K0g6LbyDZSK29q@kernel.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 26 Jan 2023 11:20:29 -0600
Message-ID: <CAFftDdqEY-_3smQ_7t=r4528_EcFstg5xUqtZH4F593_ra4zpg@mail.gmail.com>
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

On Thu, Jan 26, 2023 at 11:12 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Jan 26, 2023 at 05:07:43PM +0000, Jarkko Sakkinen wrote:
> > On Mon, Jan 23, 2023 at 11:48:25AM -0600, William Roberts wrote:
> > > On Fri, Jan 20, 2023 at 9:29 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Sat, Jan 14, 2023 at 09:55:37AM -0500, James Bottomley wrote:
> > > > > On Tue, 2023-01-03 at 13:10 -0800, Matthew Garrett wrote:
> > > > > > On Tue, Jan 3, 2023 at 1:05 PM William Roberts
> > > > > > <bill.c.roberts@gmail.com> wrote:
> > > > > >
> > > > > > > What's the use case of using the creation data and ticket in this
> > > > > > > context? Who gets the creationData and the ticket?
> > > > > > > Could a user supplied outsideInfo work? IIRC I saw some patches
> > > > > > > flying around where the sessions will get encrypted and presumably
> > > > > > > correctly as well. This would allow the transfer of that
> > > > > > > outsideInfo, like the NV Index PCR value to be included and
> > > > > > > integrity protected by the session HMAC.
> > > > > >
> > > > > > The goal is to ensure that the key was generated by the kernel. In
> > > > > > the absence of the creation data, an attacker could generate a
> > > > > > hibernation image using their own key and trick the kernel into
> > > > > > resuming arbitrary code. We don't have any way to pass secret data
> > > > > > from the hibernate kernel to the resume kernel, so I don't think
> > > > > > there's any easy way to do it with outsideinfo.
> > > > >
> > > > > Can we go back again to why you can't use locality?  It's exactly
> > > > > designed for this since locality is part of creation data.  Currently
> > > > > everything only uses locality 0, so it's impossible for anyone on Linux
> > > > > to produce a key with anything other than 0 in the creation data for
> > > > > locality.  However, the dynamic launch people are proposing that the
> > > > > Kernel should use Locality 2 for all its operations, which would allow
> > > > > you to distinguish a key created by the kernel from one created by a
> > > > > user by locality.
> > > > >
> > > > > I think the previous objection was that not all TPMs implement
> > > > > locality, but then not all laptops have TPMs either, so if you ever
> > > > > come across one which has a TPM but no locality, it's in a very similar
> > > > > security boat to one which has no TPM.
> > > >
> > > > Kernel could try to use locality 2 and use locality 0 as fallback.
> > >
> > > I don't think that would work for Matthew, they need something
> > > reliable to indicate key provenance.
> > >
> > > I was informed that all 5 localities should be supported starting
> > > with Gen 7 Kaby Lake launched in 2016. Don't know if this is
> > > still "too new".
> >
> > What about having opt-in flag that distributions can then enable?
>
> This is more intrusive but still worth of consideration: add opt-in
> kernel command-line flag for no locality. I.e. require locality support
> unless explicitly stated otherwise.
>
> I'd presume that legacy production cases are a rarity but really is
> something that is beyond me, and could potentially draw wrong conclusions.
>

One thing that was never answered for me, is that there was nowhere safe
to store some information about the expected key or a secret. That would
be the most obvious solution, so I am assuming that's a no.
