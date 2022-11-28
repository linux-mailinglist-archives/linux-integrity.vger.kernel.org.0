Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DFF63AE7B
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 18:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiK1RI3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 12:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiK1RIG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 12:08:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6C52648D
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 09:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D21F9612A1
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 17:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D9DC43470
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 17:08:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ce9XD2iz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669655281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1a2Jyp5EUfntzO5PAsVKjlCQgBKfrgBVaLehlcMhV4=;
        b=Ce9XD2iz4qo7KiBUV49Bb0OqgDxSE571knnV68N8Yi13fS5FiTrS0o4HfmHdOFqk9ehO0Z
        yauTXCR2p6jb8c2cscFCzCPGuBJkAFwD7fm7K7BVbPj3dP10aiVRH98j4gQMOioKG7hfIL
        elkxqqRW0Y27M40z3mNEXYkFrAGDcz4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 89bab071 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-integrity@vger.kernel.org>;
        Mon, 28 Nov 2022 17:08:01 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id x24so4093786uaf.4
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 09:08:00 -0800 (PST)
X-Gm-Message-State: ANoB5pk4g40JCwrq85xzKNfvgDzPZmgbHVYqG3hFzGU6LWjXm9h83vdF
        Dfn4pIYFX3o8kVrihSS47gCMR8IJPS9Z89H9/6Q=
X-Google-Smtp-Source: AA0mqf7esb1FW6CHZ8yCAPss0tXh6tZP7Yl2vgH5yzKtDyaNhe16hgPCka+pm6tmi83T7Uc+DjJO6WD3kdKffrJcFSo=
X-Received: by 2002:ab0:3899:0:b0:419:1b4a:360b with SMTP id
 z25-20020ab03899000000b004191b4a360bmr4232695uav.102.1669655279670; Mon, 28
 Nov 2022 09:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20221103145450.1409273-1-jsd@semihalf.com> <20221103145450.1409273-2-jsd@semihalf.com>
 <Y2f/pExGdDBGhNZA@kernel.org> <CAOtMz3MRyTVHEmoiR95jUCtEM-JXNMVLzE08HiENPhdpWL2LVA@mail.gmail.com>
 <Y2kzzf6XAy5SwJva@kernel.org> <Y4TqFR71MitDHEEH@zx2c4.com>
In-Reply-To: <Y4TqFR71MitDHEEH@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Nov 2022 18:07:48 +0100
X-Gmail-Original-Message-ID: <CAHmME9qGEHPAPwQbTu_Xv4Vx79w-3BooiX9O5wR4MtfNrTOD5g@mail.gmail.com>
Message-ID: <CAHmME9qGEHPAPwQbTu_Xv4Vx79w-3BooiX9O5wR4MtfNrTOD5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] char: tpm: Protect tpm_pm_suspend with locks
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 28, 2022 at 6:04 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Jarkko,
>
> On Mon, Nov 07, 2022 at 06:35:25PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Nov 07, 2022 at 09:45:41AM +0100, Jan D=C4=85bro=C5=9B wrote:
> > > niedz., 6 lis 2022 o 20:49 Jarkko Sakkinen <jarkko@kernel.org> napisa=
=C5=82(a):
> > > >
> > > > On Thu, Nov 03, 2022 at 03:54:48PM +0100, Jan Dabros wrote:
> > > > > Currently tpm transactions are executed unconditionally in
> > > > > tpm_pm_suspend() function, what may lead to races with other tpm
> > > > > accessors in the system.
> > > > >
> > > > > Add proper locking mechanisms by calling tpm_try_get_ops() which =
is a
> > > > > wrapper on tpm_chip_start().
> > > > >
> > > > > Signed-off-by: Jan Dabros <jsd@semihalf.com>
> > > >
> > > > AFAIK processes are freezed before suspend callbacks are called, an=
d
> > > > the callbacks are called sequentially. I have no idea what is meant
> > > > by "TPM accessor" here.
> > >
> > > User space processes are freezed before suspend, but kernel threads
> > > are not freezable by default. In my particular case it was a hwrng
> > > thread started from drivers/char/hw_random/core.c - I was referring t=
o
> > > it as "TPM accessor". For sure I should be more precise in a commit
> > > msg.
> >
> > OK, great.
> >
> > >
> > > > Please describe the concurrency scenario in the commit message wher=
e the
> > > > race could happen, if it is hard to reproduce, and add an appropria=
te fixes
> > > > tag.
> > >
> > > I will describe my scenario in more detail in the next version.
> > > Regarding the "fixes" tag - I'm not too familiar with it, but looking
> > > at the kernel submission guide, "fixes" should be used either when
> > > there was a particular commit in the past which introduced the bug or
> > > if a patch fixes an already logged bug entry (so that one can paste
> > > URL). In my case both are not applicable, so please advise what
> > > exactly I should put after this tag?
> >
> > It is
> >
> > Fixed: <12 character prefix of the hash> ("short summary")
> >
> > It should point out to the commit, which introduced the issue/bug.
>
> Somebody just reported a bug to me in hwrng stuff, which I traced down
> to this lack of tpm_try_get_ops(), and then I coded up the exact same
> patch as Jan's here, saw it fixed the problem, and then realized it was
> already submitted in that exact form.
>
> Because of some recent hwrng changes, this bug will be triggered more
> often than it was before.
>
> So, even though Jan hasn't submitted a v+1, do you think you could take
> this 1/3 commit, fix up the commit message or whatever you need there,
> and get this in for 6.1-rc8? It's an important fix.
>
> Thanks,
> Jason

And if it helps, here's some more metadata:

Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/all/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse=
.cz/
Cc: stable@vger.kernel.org
