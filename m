Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB63F6180
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Aug 2021 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhHXPY3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Aug 2021 11:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbhHXPY2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Aug 2021 11:24:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4365CC0613CF
        for <linux-integrity@vger.kernel.org>; Tue, 24 Aug 2021 08:23:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fz10so3076683pjb.0
        for <linux-integrity@vger.kernel.org>; Tue, 24 Aug 2021 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlWf418OhmiZZMN2ujHNQZWc18fzFQ+ab1INkCf29Dg=;
        b=h9B4MYL0ZHRCwtAFt9WLYquuLvRZY3ZCCd0XIomoYvZ/jkoNVJdc55k62FFnuwd1r7
         KLVHJ+ivYOKxQrgspcN15/GAG+WeLPPJioIeu8kDX54oEdLsMc/JZNEdqZ/SYYbK8f/V
         dd4Td0t3+cqb3J819AV3cgKAch6vromBXLeFAxkK8rhiUa64HUXUrBYx8mimYFdFfHEr
         +EHk2SA9hz8QZIMc5JdR6bknuXL2VZRYGm1aVlobZlv/qwoE4gBtuJQoSDriV11cXUZk
         hXIFqqZX0mmem3uOXznck4OCoDYL3CDtoesGzW8jRiWOrAbAM4CrGYRtg6npSuOR+iPp
         ejvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlWf418OhmiZZMN2ujHNQZWc18fzFQ+ab1INkCf29Dg=;
        b=GoWc62CBFpKAXP+NF7l5JXYobyLZixZZUXJ/BZ99IXdt8Mbke8reA65jB6XnmtfKpQ
         /aq0daXoEeRYmBDJDlKnEOVd/ETst3VD6z8bpku5Ir0AUTrfHWcBeprMsUkjqoh2W9Pi
         d3W8qXodbb2qy3cBkyvwfYr/MytEFR0wWxn2HMtfpAaabTpT9rkdpI7EJ/iEL/W2o2Cu
         v2orakBFVnKHXycAA0tlgxCHSNOAKTpg3Y1JzHRmXyqxrQW32G1vvgsaE/w3CGC8jVPL
         akmfAlwQF0TMiJW7ImcvGgLvs2ciAgIxVjvVfhtZ7sva33NcCSaspFwW3kdbpvMBGCQc
         4ytg==
X-Gm-Message-State: AOAM531XuVAkvzyfWHmATq59oPHVLdoUdDXdU+yFVvSjFyiREjjQmMcV
        Mo/RDhBJV/Rsh2nMKPgkoQE/Wv85Ez0ox48mH3qmQA==
X-Google-Smtp-Source: ABdhPJxwlxA/ggkzhnXhTxNIIF8d5nI4NsBBRTBHNjWOZLC0rAevPRz+KC1lxMKEVQGfdXwnNpQqQIxZMl/dJ3MDtBc=
X-Received: by 2002:a17:902:bd81:b029:12c:b6fb:feef with SMTP id
 q1-20020a170902bd81b029012cb6fbfeefmr33981892pls.84.1629818623699; Tue, 24
 Aug 2021 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <CAJ+vNU23cXPmiqKcKH_WAgD-ea+=pEJzGK+q7zOy=v2o0XU7kA@mail.gmail.com>
 <2b48a848-d70b-9c43-5ca0-9ab72622ed12@pengutronix.de> <CAJ+vNU225mgHHg00r67f1L6bEub+_h55hCBAMhCq2rd8kWU-qg@mail.gmail.com>
 <9200d46d-94a2-befd-e9b0-93036e56eb8a@pengutronix.de> <CAJ+vNU19z0syr0oHOrSGxL0cVW+Kjv76kmp6uvGc2akHbtX0Nw@mail.gmail.com>
 <fa530833-2bb9-f8f3-68c6-99423d29e2ca@pengutronix.de> <CAJ+vNU0iRTagc5_qvsG4jvt=B_wruj=1O2ZRixqWek8JTN=aeg@mail.gmail.com>
 <8b559c9c-a4c0-d335-5e54-40b9acc08707@pengutronix.de>
In-Reply-To: <8b559c9c-a4c0-d335-5e54-40b9acc08707@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 24 Aug 2021 08:23:32 -0700
Message-ID: <CAJ+vNU2q_KCi8nNv56s0ip7CZaAE=YgObwFUyzuGa_T1Ywp-wQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] KEYS: trusted: Introduce support for NXP CAAM-based
 trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     David Gstir <david@sigma-star.at>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>, keyrings@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-security-module@vger.kernel.org,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        David Howells <dhowells@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        linux-integrity@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 24, 2021 at 12:33 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> On 23.08.21 19:50, Tim Harvey wrote:
> > On Mon, Aug 23, 2021 at 6:29 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >> On 20.08.21 23:19, Tim Harvey wrote:
> >>> On Fri, Aug 20, 2021 at 1:36 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>> On 20.08.21 22:20, Tim Harvey wrote:
> >>> It works for a user keyring but not a session keyring... does that
> >>> explain anything?
> >>> # keyctl add trusted mykey 'new 32' @u
> >>> 941210782
> >>> # keyctl print 941210782
> >>> 83b7845cb45216496aead9ee2c6a406f587d64aad47bddc539d8947a247e618798d9306b36398b5dc2722a4c3f220a3a763ee175f6bd64758fdd49ca4db597e8ce328121b60edbba9b8d8d55056be896
> >>> # keyctl add trusted mykey 'new 32' @s
> >>> 310571960
> >>> # keyctl print 310571960
> >>> keyctl_read_alloc: Unknown error 126
> >>
> >> Both sequences work for me.
> >>
> >> My getty is started by systemd. I think systemd allocates a new session
> >> keyring for the getty that's inherited by the shell and the commands I run
> >> it in. If you don't do that, each command will get its own session key.
> >>
> >>> Sorry, I'm still trying to wrap my head around the differences in
> >>> keyrings and trusted vs user keys.
> >>
> >> No problem. HTH.
> >
> > Ahmad,
> >
> > Ok that explains it - my testing is using a very basic buildroot
> > ramdisk rootfs. If I do a 'keyctl new_session' first I can use the
> > system keyring fine as well.
>
> Great. Does this mean I can get your Tested-by: ? :)
>

Absolutely,

For the series:

I tested this series on top of v5.14.rc-7 on a Gateworks
imx8mm-venice-gw73xx board with kernel param trusted.source=caam and
keyutils-1.6:
# keyctl new_session
22544757
# keyctl add trusted mykey 'new 32' @s
160701809
# keyctl print 160701809
990e03aa4515aee420eede17e26a58d0c5568c8bd2c9c2ee2f22a0583181d20d4f65cf9cb1f944a3cc92c0e3184a44a29a7e511f0a55a6af11a70ac2b2924514002475e73ae09820042896b9ee00a5ec

Tested-By: Tim Harvey <tharvey@gateworks.com>

One more question: I've got a user that wants to blob/deblob generic
data. They can use the caam_encap_blob/caam_decap_blob functions in
kernel code but could you give me a suggestion for how they could use
this in:
a) userspace code (using the keyctl syscall I assume)
b) userspace cmdline (via keyutils I assume)

Many thanks,

Tim
