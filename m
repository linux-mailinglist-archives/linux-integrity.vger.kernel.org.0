Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4000561F9F4
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiKGQfh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 11:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGQff (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 11:35:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352602F5
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 08:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D83BBB815D5
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 16:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0927C433C1;
        Mon,  7 Nov 2022 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667838932;
        bh=6bb83dptQmljGFxVpRTTqTEkJ0GqQc1KxPnzbsd4DMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giwmIzJ5gtknr2VkIICwMHt+HDs+B/egswBxunXidc2IAyIrTmeRdbZVXHNVH0OLS
         k19BwLhx77TouEwXWbrDtSwS0oBTlFvwO+xl1n0tj3XKkdn9a/f1zEXvfw7PX6UgoX
         b4Lo+9UshCVr56aZgojenZTuGRYWGmTIt3ydbFGHiJrq5095IsLFoHiObvfuXl/kxv
         hbSOQGrG6qyrkl98SarQRAr1sM8NEhr0SaRgBY8Ezgmt1//m3qWVUYN4AvSMB7DYAl
         4WtbEUD6MGokdXWDOOYG6Xu6Cz0uaw5ZG576k9o1+a8sk0gQhtiiAHgYkueBRC+UGX
         8jIeNVY/Wtd7Q==
Date:   Mon, 7 Nov 2022 18:35:25 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jan =?utf-8?B?RMSFYnJvxZs=?= <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Subject: Re: [PATCH v2 1/3] char: tpm: Protect tpm_pm_suspend with locks
Message-ID: <Y2kzzf6XAy5SwJva@kernel.org>
References: <20221103145450.1409273-1-jsd@semihalf.com>
 <20221103145450.1409273-2-jsd@semihalf.com>
 <Y2f/pExGdDBGhNZA@kernel.org>
 <CAOtMz3MRyTVHEmoiR95jUCtEM-JXNMVLzE08HiENPhdpWL2LVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOtMz3MRyTVHEmoiR95jUCtEM-JXNMVLzE08HiENPhdpWL2LVA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 07, 2022 at 09:45:41AM +0100, Jan Dąbroś wrote:
> niedz., 6 lis 2022 o 20:49 Jarkko Sakkinen <jarkko@kernel.org> napisał(a):
> >
> > On Thu, Nov 03, 2022 at 03:54:48PM +0100, Jan Dabros wrote:
> > > Currently tpm transactions are executed unconditionally in
> > > tpm_pm_suspend() function, what may lead to races with other tpm
> > > accessors in the system.
> > >
> > > Add proper locking mechanisms by calling tpm_try_get_ops() which is a
> > > wrapper on tpm_chip_start().
> > >
> > > Signed-off-by: Jan Dabros <jsd@semihalf.com>
> >
> > AFAIK processes are freezed before suspend callbacks are called, and
> > the callbacks are called sequentially. I have no idea what is meant
> > by "TPM accessor" here.
> 
> User space processes are freezed before suspend, but kernel threads
> are not freezable by default. In my particular case it was a hwrng
> thread started from drivers/char/hw_random/core.c - I was referring to
> it as "TPM accessor". For sure I should be more precise in a commit
> msg.

OK, great.

> 
> > Please describe the concurrency scenario in the commit message where the
> > race could happen, if it is hard to reproduce, and add an appropriate fixes
> > tag.
> 
> I will describe my scenario in more detail in the next version.
> Regarding the "fixes" tag - I'm not too familiar with it, but looking
> at the kernel submission guide, "fixes" should be used either when
> there was a particular commit in the past which introduced the bug or
> if a patch fixes an already logged bug entry (so that one can paste
> URL). In my case both are not applicable, so please advise what
> exactly I should put after this tag?

It is 

Fixed: <12 character prefix of the hash> ("short summary")

It should point out to the commit, which introduced the issue/bug.

> Best Regards,
> Jan

BR, Jarkko
