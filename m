Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F03F35F8
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbhHTVU2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbhHTVU1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 17:20:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE9C061756
        for <linux-integrity@vger.kernel.org>; Fri, 20 Aug 2021 14:19:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 18so9718204pfh.9
        for <linux-integrity@vger.kernel.org>; Fri, 20 Aug 2021 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBTMAWGQBBiObCm1jTl9uvsUH1RWm/SH7P0VcEqIt98=;
        b=Oe4UKgd1fXOxRlRf3wPkglvi1/jg5q68upuxv0zakaw9OzDI+FudmRHI+xn7RoE4Xb
         tqxIpnDZIgs5xNQE19SP58rJ4IozRaPALfH9vfjcVlrjaNQUIm6IGSZYrdzW8q26UfQH
         8gLc04P5xB2dQHVWn0YKcfGYsU9j4i9bf/q+AvLE0Mi+rlIdsBI8ZZxfroJlFuHdQ7b5
         q11PpX5cHPvU/dkEsD/w/GkK1Lf0evUIPRzJHt4BRCAuZ5beNEhf9Vcru5asv034o21C
         ZNQb65yILae8Uha7B7BA/M6gHRDih42F78ydMsomD+jya70EErQ/jU/wnbaCJsoGTZEx
         azQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBTMAWGQBBiObCm1jTl9uvsUH1RWm/SH7P0VcEqIt98=;
        b=gPles8keRG6p7qtFsw6tckBVheIg2F1VhSpqx4S2l86dHCPqInPfZpscR/gkC58FEN
         Iqblkl4FoOhD7shV35A4PsmXX4BbOClrGv/yJ6uUq26x9ewvXi0TAyerPOXX4bp/lE+q
         KQ10z9VyODkvlxCYRqeO14ZacodVwaEZdRzJnuM8p0tzLxbrVX65qXybzWuw2+oTSb4w
         /UOs695dtebwtqAp/SOsM12J7AXRm+8Dw7iS1Cwbb3v3BU9C4BEFGjCw8KEydXTt37hg
         yTCikkTyiOcGKYwvrR28d56yn7SIb2V02Pf7ur9/RkAgIbcZltcJHw2ZQr6VEN+MALN6
         cdvg==
X-Gm-Message-State: AOAM533A2gQrJXW6bODLGJzNFuSJyZE2SSnJdUSDQI6zGKem6HzYXJv/
        NoD042BQP5bfg0DmNW2J1xwMdRziZXKCtz+PjDk5Ng==
X-Google-Smtp-Source: ABdhPJzD06fzioZkY4v4ZMjF8wZri1QRL6xum4iAtOOc6AOx8ZTf941G2JYybtFiZ6JLyej0b/tnWBpmrax13726ZzQ=
X-Received: by 2002:a63:db4a:: with SMTP id x10mr6624779pgi.30.1629494389132;
 Fri, 20 Aug 2021 14:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <CAJ+vNU23cXPmiqKcKH_WAgD-ea+=pEJzGK+q7zOy=v2o0XU7kA@mail.gmail.com>
 <2b48a848-d70b-9c43-5ca0-9ab72622ed12@pengutronix.de> <CAJ+vNU225mgHHg00r67f1L6bEub+_h55hCBAMhCq2rd8kWU-qg@mail.gmail.com>
 <9200d46d-94a2-befd-e9b0-93036e56eb8a@pengutronix.de>
In-Reply-To: <9200d46d-94a2-befd-e9b0-93036e56eb8a@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 20 Aug 2021 14:19:37 -0700
Message-ID: <CAJ+vNU19z0syr0oHOrSGxL0cVW+Kjv76kmp6uvGc2akHbtX0Nw@mail.gmail.com>
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

On Fri, Aug 20, 2021 at 1:36 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> On 20.08.21 22:20, Tim Harvey wrote:
> > On Fri, Aug 20, 2021 at 9:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >> On 20.08.21 17:39, Tim Harvey wrote:
> >>> Thanks for your work!
> >>>
> >>> I've been asked to integrate the capability of using CAAM to
> >>> blob/deblob data to an older 5.4 kernel such as NXP's downstream
> >>> vendor kernel does [1] and I'm trying to understand how your series
> >>> works. I'm not at all familiar with the Linux Key Management API's or
> >>> trusted keys. Can you provide an example of how this can be used for
> >>> such a thing?
> >>
> >> Here's an example with dm-crypt:
> >>
> >>   https://lore.kernel.org/linux-integrity/5d44e50e-4309-830b-79f6-f5d888b1ef69@pengutronix.de/
> >>
> >> dm-crypt is a bit special at the moment, because it has direct support for
> >> trusted keys. For interfacing with other parts of the kernel like ecryptfs
> >> or EVM, you have to create encrypted keys rooted to the trusted keys and use
> >> those. The kernel documentation has an example:
> >>
> >>   https://www.kernel.org/doc/html/v5.13/security/keys/trusted-encrypted.html
> >>
> >> If you backport this series, you can include the typo fix spotted by David.
> >>
> >> I'll send out a revised series, but given that a regression fix I want to
> >> rebase on hasn't been picked up for 3 weeks now, I am not in a hurry.
> >>
> > Thanks for the reference.
> >
> > I'm still trying to understand the keyctl integration with caam. For
> > the 'data' param to keyctl you are using tings like 'new <len>' and
> > 'load <data>'. Where are these 'commands' identified?
>
> Search for match_table_t in security/keys/trusted-keys/trusted_core.c
>
> > I may still be missing something. I'm using 4.14-rc6 with your series
> > and seeing the following:
>
> That's an odd version to backport stuff to..
>
> > # cat /proc/cmdline
> > trusted.source=caam
> > # keyctl add trusted mykey 'new 32' @s)# create new trusted key named
> > 'mykey' of 32 bytes in the session keyring
> > 480104283
> > # keyctl print 480104283 # dump the key
> > keyctl_read_alloc: Unknown error 126
> > ^^^ not clear what this is
>
> Not sure what returns -ENOKEY for you. I haven't been using trusted
> keys on v4.14, but you can try tracing the keyctl syscall.

yikes... that would be painful. I typo'd and meant 5.14-rc6 :) I'm
working with mainline first to make sure I understand everything. If I
backport this it would be to 5.4 but that looks to be extremely
painful. It looks like there was a lot of activity around trusted keys
in 5.13.

It works for a user keyring but not a session keyring... does that
explain anything?
# keyctl add trusted mykey 'new 32' @u
941210782
# keyctl print 941210782
83b7845cb45216496aead9ee2c6a406f587d64aad47bddc539d8947a247e618798d9306b36398b5dc2722a4c3f220a3a763ee175f6bd64758fdd49ca4db597e8ce328121b60edbba9b8d8d55056be896
# keyctl add trusted mykey 'new 32' @s
310571960
# keyctl print 310571960
keyctl_read_alloc: Unknown error 126

Sorry, I'm still trying to wrap my head around the differences in
keyrings and trusted vs user keys.

Tim
