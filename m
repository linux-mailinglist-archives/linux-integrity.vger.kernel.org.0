Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE045A1F51
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Aug 2022 05:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiHZDLg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Aug 2022 23:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244984AbiHZDLB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Aug 2022 23:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636DCCD794
        for <linux-integrity@vger.kernel.org>; Thu, 25 Aug 2022 20:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD7261E53
        for <linux-integrity@vger.kernel.org>; Fri, 26 Aug 2022 03:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E353DC43470;
        Fri, 26 Aug 2022 03:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661483446;
        bh=rAJlcw1bxtQ+iLg9cH/q2XO3hKXwYdWL69BZBhMeu5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hb5HKuLI/Skl/5eMhPpFg2c83ufacuMSsGMw9N8AmK2xF7Nrc1YEG3c30DWNn3lIv
         mi0s++uuL1nTGI+aDEHx+kIWGIrbYXPayIQ6uiqyOc+gC0i5Z7g0xp5XMZCVDzVGFy
         IPFeEHTmn0qFMk2mYwKZIqo3psRJKcJU9NK/7VpE3Qv2GagFB2z8PzaF39J2sd/jBP
         ZhtoZML1HIDR3yJYGjcB/mMWaDYET6kRoffUYS9rOPpkbLU7SNUYcclJNLXfsXDUyK
         KPs6pKnsVOJF/2idAwfCeuNZWppI+AcK6EIxDI+UB3PvgYSstwcjCan1QkcpqQBpA7
         vYDBbNXzhJBkw==
Date:   Fri, 26 Aug 2022 06:10:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Anatol Pomozov <anatol.pomozov@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: tpm2_createprim blocked for more than 122 seconds
Message-ID: <Ywg5rwms2pfK0NcP@kernel.org>
References: <CAOMFOmXzmuGcnHJ7X-W1_Y+0m-kw=vgR6C57NGu7d5rj6VxFcA@mail.gmail.com>
 <YvupQ7gZRP1Yx2eJ@kernel.org>
 <CAOMFOmWNtMgqMy9ZjwYEOA3HK+jA6xdhiLhVeTUy=PSy2Dgv6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmWNtMgqMy9ZjwYEOA3HK+jA6xdhiLhVeTUy=PSy2Dgv6A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 16, 2022 at 09:29:29AM -0700, Anatol Pomozov wrote:
> Hi
> 
> On Tue, Aug 16, 2022 at 7:27 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon, Aug 15, 2022 at 06:07:00PM -0700, Anatol Pomozov wrote:
> > > Hello folks,
> > >
> > > I am running a tool that performs some basic operations (seal/unseal)
> > > with TPM. Most of my machines work fine. Though once in a while I see
> > > the following problem with my tool:
> > >
> > > [7955220.676259] INFO: task tpm2_createprim:258741 blocked for more
> > > than 122 seconds.
> > > [7955220.683837]       Not tainted 5.10.89-t3.el7.twitter.x86_64 #1
> > > [7955220.689848] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [7955220.697846] task:tpm2_createprim state:D stack:    0 pid:258741
> > > ppid:258724 flags:0x10000080
> > > [7955220.706454] Call Trace:
> > > [7955220.709088]  __schedule+0x266/0x840
> > > [7955220.712756]  schedule+0x46/0xb0
> > > [7955220.716073]  schedule_preempt_disabled+0xa/0x10
> > > [7955220.720780]  __mutex_lock.constprop.0+0x123/0x440
> > > [7955220.725660]  ? handle_mm_fault+0x168b/0x1ae0
> > > [7955220.730105]  tpm_try_get_ops+0x3c/0x90
> > > [7955220.734035]  tpm_common_write+0xfb/0x1c0
> > > [7955220.738141]  vfs_write+0xc0/0x260
> > > [7955220.741636]  ksys_write+0x4f/0xc0
> > > [7955220.745134]  do_syscall_64+0x33/0x40
> > > [7955220.748886]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [7955220.754111] RIP: 0033:0x7fbd13d446e0
> > > [7955220.757864] RSP: 002b:00007ffc77d004f8 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000001
> > > [7955220.765603] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> > > 00007fbd13d446e0
> > > [7955220.772910] RDX: 0000000000000043 RSI: 00005626520d33e8 RDI:
> > > 0000000000000003
> > > [7955220.780215] RBP: 00005626520d22f0 R08: 00007ffc77d004c4 R09:
> > > 00007ffc77d006b0
> > > [7955220.787519] R10: 00007ffc77cfff60 R11: 0000000000000246 R12:
> > > 00005626520d33e8
> > > [7955220.794827] R13: 0000000000000043 R14: 0000000000000000 R15:
> > > 00007ffc77d00780
> > > [7955290.222553] tpm tpm0: Operation Timed out
> > > [7955292.226513] tpm tpm0: tpm_try_transmit: send(): error -62
> > > [8311409.491438] tpm tpm0: tpm_try_transmit: send(): error -62
> > > [8311412.625426] tpm tpm0: tpm_try_transmit: send(): error -62
> > >
> > >
> > >
> > > The kernel is 5.10.89; CentOS7. I do not know how to reproduce the
> > > problem reliably. I know if I reboot the host it gets "fixed".
> > >
> > > Is it a known problem? If not what would be the best way to debug it?
> >
> > We really cannot give feedback on non-mainline issues.
> 
> The kernel that is used here is 5.10.89 compiled from the stable repo.
> So it is as mainline as a production kernel can be.
> 
> I also saw the same issues with 5.10.113 (also compiled from stable repo).

I'm sorry got the wrong impression from your original email.

It's not really a problem that can be fixed though.
Primary key creation just takes enough time to trigger
this warning.

For pure interest, do you get the same result with O_NONBLOCK?

BR, Jarkko
