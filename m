Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7363B294
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 20:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiK1TzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 14:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiK1TzT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 14:55:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C3F205DA
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 11:55:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7E861374
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 19:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A61C433C1
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 19:55:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LtDn4H+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669665315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Pl1JNK1BTcxnrsG64h4SR9LNyusAuMYb8ywEaLKZW4=;
        b=LtDn4H+36PkPeBcvQHWT+fejAPDd+6L3u8uuLjA0E9PCknA9J0uvo3gPOE+HhR/31wnYFk
        E5EJrDda/Wf0uUxsnIvz3ouf9MCeXIsIIrIMsGspnOMHJMBVU6cguSH/r6DsUnThYDOkE8
        8Zz1/qkqAwVs+7Lxe9QfZU/TDHJvPiY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1de663bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-integrity@vger.kernel.org>;
        Mon, 28 Nov 2022 19:55:14 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id 124so11747221vsv.4
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 11:55:14 -0800 (PST)
X-Gm-Message-State: ANoB5pkywQ0dy9kClT5SZ1vN+4SKiYguNNEJ4kk+oVcx7EAT06mdmU4J
        0gUl12pLNJouYTpm/cvIb1yqb5JCLP/rbxcSDNg=
X-Google-Smtp-Source: AA0mqf4LuSalDpDi3DWwBZPJljMTSQ9stVEsuEMJ3uAgHICxX3v6j35mgd5vZj0CjBt7Dj1XK4MP5G/JuYoakNFOZjc=
X-Received: by 2002:a67:1d41:0:b0:3aa:3310:174 with SMTP id
 d62-20020a671d41000000b003aa33100174mr19878213vsd.70.1669665312200; Mon, 28
 Nov 2022 11:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20221103145450.1409273-1-jsd@semihalf.com> <20221103145450.1409273-2-jsd@semihalf.com>
 <Y2f/pExGdDBGhNZA@kernel.org> <CAOtMz3MRyTVHEmoiR95jUCtEM-JXNMVLzE08HiENPhdpWL2LVA@mail.gmail.com>
 <Y2kzzf6XAy5SwJva@kernel.org> <Y4TqFR71MitDHEEH@zx2c4.com>
 <CAHmME9qGEHPAPwQbTu_Xv4Vx79w-3BooiX9O5wR4MtfNrTOD5g@mail.gmail.com> <ba0ab8be-2bce-e78e-89df-5f8898506209@suse.cz>
In-Reply-To: <ba0ab8be-2bce-e78e-89df-5f8898506209@suse.cz>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Nov 2022 20:55:01 +0100
X-Gmail-Original-Message-ID: <CAHmME9o0QL1kh55UiRw9zDs_dZ2oGu4_3JKW7+_Sv18BvwxBLA@mail.gmail.com>
Message-ID: <CAHmME9o0QL1kh55UiRw9zDs_dZ2oGu4_3JKW7+_Sv18BvwxBLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] char: tpm: Protect tpm_pm_suspend with locks
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 28, 2022 at 8:46 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/28/22 18:07, Jason A. Donenfeld wrote:
> > On Mon, Nov 28, 2022 at 6:04 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >> > >
> >> > > > Please describe the concurrency scenario in the commit message where the
> >> > > > race could happen, if it is hard to reproduce, and add an appropriate fixes
> >> > > > tag.
> >> > >
> >> > > I will describe my scenario in more detail in the next version.
> >> > > Regarding the "fixes" tag - I'm not too familiar with it, but looking
> >> > > at the kernel submission guide, "fixes" should be used either when
> >> > > there was a particular commit in the past which introduced the bug or
> >> > > if a patch fixes an already logged bug entry (so that one can paste
> >> > > URL). In my case both are not applicable, so please advise what
> >> > > exactly I should put after this tag?
> >> >
> >> > It is
> >> >
> >> > Fixed: <12 character prefix of the hash> ("short summary")
> >> >
> >> > It should point out to the commit, which introduced the issue/bug.
> >>
> >> Somebody just reported a bug to me in hwrng stuff, which I traced down
> >> to this lack of tpm_try_get_ops(), and then I coded up the exact same
> >> patch as Jan's here, saw it fixed the problem, and then realized it was
> >> already submitted in that exact form.
> >>
> >> Because of some recent hwrng changes, this bug will be triggered more
> >> often than it was before.
> >>
> >> So, even though Jan hasn't submitted a v+1, do you think you could take
> >> this 1/3 commit, fix up the commit message or whatever you need there,
> >> and get this in for 6.1-rc8? It's an important fix.
> >>
> >> Thanks,
> >> Jason
> >
> > And if it helps, here's some more metadata:
> >
> > Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Reported-by: Vlastimil Babka <vbabka@suse.cz>
>
> You can make that:
> Reported-and-tested-by: Vlastimil Babka <vbabka@suse.cz>
>
> > Link: https://lore.kernel.org/all/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz/
> > Cc: stable@vger.kernel.org
>
> Not an expert here but looks like a valid Fixes: would be
> Fixes: e891db1a18bf ("tpm: turn on TPM on suspend for TPM 1.x")
>
> The 6.1-rc1 commit 3b006c439d58d ("hwrng: core - start hwrng kthread also
> for untrusted sources") likely exposed the bug in my case, but it wouldn't
> be the real root cause. But it makes it prudent to get the fix to 6.1.

Since this thread went dormant, and we're already pretty close to the
end of the cycle, I'm going to resend this with the commit message
fixed, as Jarkko asked at the beginning of the month.

Jan can then send whatever needs fixing in 2/3 and 3/3 whenever he
gets around to it.

I'll keep the original authorship intact of course.

Jason
