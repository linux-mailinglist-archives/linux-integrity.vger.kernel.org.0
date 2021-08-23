Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CD3F4FDE
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhHWRvz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhHWRvy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 13:51:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AD5C061575
        for <linux-integrity@vger.kernel.org>; Mon, 23 Aug 2021 10:51:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so520930pjt.0
        for <linux-integrity@vger.kernel.org>; Mon, 23 Aug 2021 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plb0F7/zgK9URg+TVDPgTOY+zfqlB9v4coJEI8iSXGQ=;
        b=sK+PNdpyJ9XMyiKYWAu4TIqV+1vRFwSaoOZRmbF+Skj6cP4PrU4PZdYKf5AajUCIea
         wGK1OHqe7oUdD/Zo+RKwiNdc9i/UqPMiQ0DT+qEMhAe6APYpLpOTQm8Lk41gSbaZkSaY
         jTs3jHS5v9nHua9DqauQ65P50OIYqT7C8dd0Fja6L0ZnLdc7rtZvy+qZ/mQr5a3wGIdq
         ur3WeoHlxl0uzl1F9sxQZm+wUvURGJibgLoRaGwP9bMBHhmI+gzVCmXkZgbIQN0wcWfd
         2X6edx6I85LU3jXjYoOxRgNIIY/HECn5clRVQ7vzmBUxKCqTZfc0YFZ8TQPAR+DkDg9R
         DO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plb0F7/zgK9URg+TVDPgTOY+zfqlB9v4coJEI8iSXGQ=;
        b=EKfXcX+fvyVBkujm9GMQhSe361HuVACZiBsIvKHDqrUM5ub1eYWj4C2ld2iPvjfJy0
         zmrGy+oPdramHNfkqX5BujvEA4U5j2+9tyX88jT+DiiBgWuOZfKxEPwQEWAedpZq7rt3
         eKdGO/b8NdEoh7Xg/Zj97R7Qy/apsNf4TNAollBqJQB/nKcI00g1JqQ95gGHNtiNWtiS
         WWMhktm6QZHvEBFpM/5AcUUkKjtP1WHfF9haNHm3GDqN7noMx5+47q96w3deFDNxshiV
         X9J7HuvPbVC8EwpEyneHWLcRxpMUvlBy8V+LCYBSAhSIzH2eX3VdQYQxxzz/Q5PJrvs+
         vJ+A==
X-Gm-Message-State: AOAM53130iY19xcB2iRoEdQ6uIPjez9U5VAZlL+pzmfc2dLDfh6BqeED
        wwXHC20C3Q0fkQ+7twy/QtrYc+/tUA7y61NFUU2cAaOxi9+jZ1B8
X-Google-Smtp-Source: ABdhPJz7sU7U/l28dRWAkNWhVh0xc6FGjq0zTlfKwHGl8NngmX721YvytAQQfiLf9gHDJ6KeOeXMvl7FgVGUDYnXKwI=
X-Received: by 2002:a17:902:a9c7:b029:12b:349:b318 with SMTP id
 b7-20020a170902a9c7b029012b0349b318mr29742335plr.13.1629741071409; Mon, 23
 Aug 2021 10:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <CAJ+vNU23cXPmiqKcKH_WAgD-ea+=pEJzGK+q7zOy=v2o0XU7kA@mail.gmail.com>
 <2b48a848-d70b-9c43-5ca0-9ab72622ed12@pengutronix.de> <CAJ+vNU225mgHHg00r67f1L6bEub+_h55hCBAMhCq2rd8kWU-qg@mail.gmail.com>
 <9200d46d-94a2-befd-e9b0-93036e56eb8a@pengutronix.de> <CAJ+vNU19z0syr0oHOrSGxL0cVW+Kjv76kmp6uvGc2akHbtX0Nw@mail.gmail.com>
 <fa530833-2bb9-f8f3-68c6-99423d29e2ca@pengutronix.de>
In-Reply-To: <fa530833-2bb9-f8f3-68c6-99423d29e2ca@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 23 Aug 2021 10:50:59 -0700
Message-ID: <CAJ+vNU0iRTagc5_qvsG4jvt=B_wruj=1O2ZRixqWek8JTN=aeg@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 6:29 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Tim,
>
> On 20.08.21 23:19, Tim Harvey wrote:
> > On Fri, Aug 20, 2021 at 1:36 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>
> >> On 20.08.21 22:20, Tim Harvey wrote:
> >>> On Fri, Aug 20, 2021 at 9:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>> On 20.08.21 17:39, Tim Harvey wrote:
> >>>>> Thanks for your work!
> >>>>>
> >>>>> I've been asked to integrate the capability of using CAAM to
> >>>>> blob/deblob data to an older 5.4 kernel such as NXP's downstream
> >>>>> vendor kernel does [1] and I'm trying to understand how your series
> >>>>> works. I'm not at all familiar with the Linux Key Management API's or
> >>>>> trusted keys. Can you provide an example of how this can be used for
> >>>>> such a thing?
> >>>>
> >>>> Here's an example with dm-crypt:
> >>>>
> >>>>   https://lore.kernel.org/linux-integrity/5d44e50e-4309-830b-79f6-f5d888b1ef69@pengutronix.de/
> >>>>
> >>>> dm-crypt is a bit special at the moment, because it has direct support for
> >>>> trusted keys. For interfacing with other parts of the kernel like ecryptfs
> >>>> or EVM, you have to create encrypted keys rooted to the trusted keys and use
> >>>> those. The kernel documentation has an example:
> >>>>
> >>>>   https://www.kernel.org/doc/html/v5.13/security/keys/trusted-encrypted.html
> >>>>
> >>>> If you backport this series, you can include the typo fix spotted by David.
> >>>>
> >>>> I'll send out a revised series, but given that a regression fix I want to
> >>>> rebase on hasn't been picked up for 3 weeks now, I am not in a hurry.
> >>>>
> >>> Thanks for the reference.
> >>>
> >>> I'm still trying to understand the keyctl integration with caam. For
> >>> the 'data' param to keyctl you are using tings like 'new <len>' and
> >>> 'load <data>'. Where are these 'commands' identified?
> >>
> >> Search for match_table_t in security/keys/trusted-keys/trusted_core.c
> >>
> >>> I may still be missing something. I'm using 4.14-rc6 with your series
> >>> and seeing the following:
> >>
> >> That's an odd version to backport stuff to..
> >>
> >>> # cat /proc/cmdline
> >>> trusted.source=caam
> >>> # keyctl add trusted mykey 'new 32' @s)# create new trusted key named
> >>> 'mykey' of 32 bytes in the session keyring
> >>> 480104283
> >>> # keyctl print 480104283 # dump the key
> >>> keyctl_read_alloc: Unknown error 126
> >>> ^^^ not clear what this is
> >>
> >> Not sure what returns -ENOKEY for you. I haven't been using trusted
> >> keys on v4.14, but you can try tracing the keyctl syscall.
> >
> > yikes... that would be painful. I typo'd and meant 5.14-rc6 :)
>
> ^^
>
> > I'm working with mainline first to make sure I understand everything. If I
> > backport this it would be to 5.4 but that looks to be extremely
> > painful. It looks like there was a lot of activity around trusted keys
> > in 5.13.
>
> Ye. It used to be limited to TPM before that.
>
> > It works for a user keyring but not a session keyring... does that
> > explain anything?
> > # keyctl add trusted mykey 'new 32' @u
> > 941210782
> > # keyctl print 941210782
> > 83b7845cb45216496aead9ee2c6a406f587d64aad47bddc539d8947a247e618798d9306b36398b5dc2722a4c3f220a3a763ee175f6bd64758fdd49ca4db597e8ce328121b60edbba9b8d8d55056be896
> > # keyctl add trusted mykey 'new 32' @s
> > 310571960
> > # keyctl print 310571960
> > keyctl_read_alloc: Unknown error 126
>
> Both sequences work for me.
>
> My getty is started by systemd. I think systemd allocates a new session
> keyring for the getty that's inherited by the shell and the commands I run
> it in. If you don't do that, each command will get its own session key.
>
> > Sorry, I'm still trying to wrap my head around the differences in
> > keyrings and trusted vs user keys.
>
> No problem. HTH.

Ahmad,

Ok that explains it - my testing is using a very basic buildroot
ramdisk rootfs. If I do a 'keyctl new_session' first I can use the
system keyring fine as well.

Thanks - hoping to see this merged soon!

Tim
