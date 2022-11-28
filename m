Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0033763AE5D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 18:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiK1REz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 12:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiK1REi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 12:04:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D3193FF
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 09:04:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 801F6B80E73
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 17:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F89C433C1;
        Mon, 28 Nov 2022 17:04:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BQIXzrXV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669655071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEcAf8oWfirYutQuXtTrij/KXM8eUyhVsFFW63Tr8ss=;
        b=BQIXzrXV7t9u9IjFw/izuKEixTwjcAXy6VFNGWOi3HOur9OeueZNTIYAs2QwYKWUUhKctz
        hhfQJCv+z1utN8NysLnLqp1WwOq7DGdEPIqEAcp8fuU1Pru5kSgOAU3m5Y7r1KjMVsU69l
        Da3zk25HXuERwet/clMwZnEE7FjaRaw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e0639bf7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 17:04:30 +0000 (UTC)
Date:   Mon, 28 Nov 2022 18:04:21 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jan =?utf-8?B?RMSFYnJvxZs=?= <jsd@semihalf.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/3] char: tpm: Protect tpm_pm_suspend with locks
Message-ID: <Y4TqFR71MitDHEEH@zx2c4.com>
References: <20221103145450.1409273-1-jsd@semihalf.com>
 <20221103145450.1409273-2-jsd@semihalf.com>
 <Y2f/pExGdDBGhNZA@kernel.org>
 <CAOtMz3MRyTVHEmoiR95jUCtEM-JXNMVLzE08HiENPhdpWL2LVA@mail.gmail.com>
 <Y2kzzf6XAy5SwJva@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2kzzf6XAy5SwJva@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On Mon, Nov 07, 2022 at 06:35:25PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 07, 2022 at 09:45:41AM +0100, Jan Dąbroś wrote:
> > niedz., 6 lis 2022 o 20:49 Jarkko Sakkinen <jarkko@kernel.org> napisał(a):
> > >
> > > On Thu, Nov 03, 2022 at 03:54:48PM +0100, Jan Dabros wrote:
> > > > Currently tpm transactions are executed unconditionally in
> > > > tpm_pm_suspend() function, what may lead to races with other tpm
> > > > accessors in the system.
> > > >
> > > > Add proper locking mechanisms by calling tpm_try_get_ops() which is a
> > > > wrapper on tpm_chip_start().
> > > >
> > > > Signed-off-by: Jan Dabros <jsd@semihalf.com>
> > >
> > > AFAIK processes are freezed before suspend callbacks are called, and
> > > the callbacks are called sequentially. I have no idea what is meant
> > > by "TPM accessor" here.
> > 
> > User space processes are freezed before suspend, but kernel threads
> > are not freezable by default. In my particular case it was a hwrng
> > thread started from drivers/char/hw_random/core.c - I was referring to
> > it as "TPM accessor". For sure I should be more precise in a commit
> > msg.
> 
> OK, great.
> 
> > 
> > > Please describe the concurrency scenario in the commit message where the
> > > race could happen, if it is hard to reproduce, and add an appropriate fixes
> > > tag.
> > 
> > I will describe my scenario in more detail in the next version.
> > Regarding the "fixes" tag - I'm not too familiar with it, but looking
> > at the kernel submission guide, "fixes" should be used either when
> > there was a particular commit in the past which introduced the bug or
> > if a patch fixes an already logged bug entry (so that one can paste
> > URL). In my case both are not applicable, so please advise what
> > exactly I should put after this tag?
> 
> It is 
> 
> Fixed: <12 character prefix of the hash> ("short summary")
> 
> It should point out to the commit, which introduced the issue/bug.

Somebody just reported a bug to me in hwrng stuff, which I traced down
to this lack of tpm_try_get_ops(), and then I coded up the exact same
patch as Jan's here, saw it fixed the problem, and then realized it was
already submitted in that exact form.

Because of some recent hwrng changes, this bug will be triggered more
often than it was before.

So, even though Jan hasn't submitted a v+1, do you think you could take
this 1/3 commit, fix up the commit message or whatever you need there,
and get this in for 6.1-rc8? It's an important fix.

Thanks,
Jason
