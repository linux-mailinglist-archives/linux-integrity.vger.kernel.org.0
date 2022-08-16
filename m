Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC8D596033
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Aug 2022 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiHPQ35 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Aug 2022 12:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiHPQ3q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Aug 2022 12:29:46 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031BD7CB56
        for <linux-integrity@vger.kernel.org>; Tue, 16 Aug 2022 09:29:42 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id k2so10633585vsk.8
        for <linux-integrity@vger.kernel.org>; Tue, 16 Aug 2022 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5bYr2xrDTQAFYhHNXmzqapBxBWSsg1Z8lYOvHFUdzXM=;
        b=HP0fbXnpXK+G3yuEl7TnriMwAvHaWYR9lMptMCm9455uX7rwwaxwAhGeo85WHlwy5l
         KToy/uwwoxn5IdsnS7GA39kmq1GwTgmGqKCjErfqKG2SE6aBXEx5H7JCtN5gAxL6XdjJ
         neQbk7r6auXjbQutLyjIgGrp5oLhqWMq+KqdtkiREaqL6p4C8/f2U6WP/FgVpaWQE89h
         YyR7sZQdF7TvHljw20oDp9AiMzzOie3Sc2XyiQE5hAso3A2m/kryOh2z5yBKKoMrlE0K
         7AGC+RrP/g6FV7iWoD1K9+k9Mu2ZwLq//J3FtNhDXhqXFHPEP3HlZBMxzrr0GvnjQTE1
         xhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5bYr2xrDTQAFYhHNXmzqapBxBWSsg1Z8lYOvHFUdzXM=;
        b=Ck39Rl9p0hcLgLd/SVoKxdL1pEmMgInraYL/loNbUjydlhpCFOhvzZ9Eqldv5bxnBB
         l4R6Ch0opKNCPFaxTaqVX6TaPN4eJ1HjhTqZvr6lXUFYKqi2e7f6xRTe+Jzh0m1qcYCM
         Tm3snLhPx2QqtwaRhixdTclxhzZ4YoJ1pIbWZ0fMb0X1MrdiVY585PfcHNP+ofTZnaLn
         co8W90B+Xd7suVpA3sYm0g3TeatmPIp0hib5f4M66eVD07O/Sjtqc8iTucFZ3uEgJrgR
         Y165rg0iU0e60A5zZuqSoB+Uu+jXKVCsr4QY7FktqckqDqGjHkNhNJrjUMud1YFJld9J
         sTPQ==
X-Gm-Message-State: ACgBeo3mA/nLyD/hFUDIMJPKGwJ2DBO4verR42pTe8SFom14p0DeWxWd
        oB8F1tDIi2Qi2NaPEkapHpVRmB/N5vKRod6Qlfg=
X-Google-Smtp-Source: AA6agR6E3m16ZPieGCEdU5nzOU73GrVSaAjjnsJiutgtcaQAIhQkzaqXYOjwOFSeKjrtIYtc4lsiYoApHZTotRYoXx8=
X-Received: by 2002:a67:e243:0:b0:387:3666:4e67 with SMTP id
 w3-20020a67e243000000b0038736664e67mr8417932vse.47.1660667381267; Tue, 16 Aug
 2022 09:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMFOmXzmuGcnHJ7X-W1_Y+0m-kw=vgR6C57NGu7d5rj6VxFcA@mail.gmail.com>
 <YvupQ7gZRP1Yx2eJ@kernel.org>
In-Reply-To: <YvupQ7gZRP1Yx2eJ@kernel.org>
From:   Anatol Pomozov <anatol.pomozov@gmail.com>
Date:   Tue, 16 Aug 2022 09:29:29 -0700
Message-ID: <CAOMFOmWNtMgqMy9ZjwYEOA3HK+jA6xdhiLhVeTUy=PSy2Dgv6A@mail.gmail.com>
Subject: Re: tpm2_createprim blocked for more than 122 seconds
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

On Tue, Aug 16, 2022 at 7:27 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Mon, Aug 15, 2022 at 06:07:00PM -0700, Anatol Pomozov wrote:
> > Hello folks,
> >
> > I am running a tool that performs some basic operations (seal/unseal)
> > with TPM. Most of my machines work fine. Though once in a while I see
> > the following problem with my tool:
> >
> > [7955220.676259] INFO: task tpm2_createprim:258741 blocked for more
> > than 122 seconds.
> > [7955220.683837]       Not tainted 5.10.89-t3.el7.twitter.x86_64 #1
> > [7955220.689848] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [7955220.697846] task:tpm2_createprim state:D stack:    0 pid:258741
> > ppid:258724 flags:0x10000080
> > [7955220.706454] Call Trace:
> > [7955220.709088]  __schedule+0x266/0x840
> > [7955220.712756]  schedule+0x46/0xb0
> > [7955220.716073]  schedule_preempt_disabled+0xa/0x10
> > [7955220.720780]  __mutex_lock.constprop.0+0x123/0x440
> > [7955220.725660]  ? handle_mm_fault+0x168b/0x1ae0
> > [7955220.730105]  tpm_try_get_ops+0x3c/0x90
> > [7955220.734035]  tpm_common_write+0xfb/0x1c0
> > [7955220.738141]  vfs_write+0xc0/0x260
> > [7955220.741636]  ksys_write+0x4f/0xc0
> > [7955220.745134]  do_syscall_64+0x33/0x40
> > [7955220.748886]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [7955220.754111] RIP: 0033:0x7fbd13d446e0
> > [7955220.757864] RSP: 002b:00007ffc77d004f8 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000001
> > [7955220.765603] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> > 00007fbd13d446e0
> > [7955220.772910] RDX: 0000000000000043 RSI: 00005626520d33e8 RDI:
> > 0000000000000003
> > [7955220.780215] RBP: 00005626520d22f0 R08: 00007ffc77d004c4 R09:
> > 00007ffc77d006b0
> > [7955220.787519] R10: 00007ffc77cfff60 R11: 0000000000000246 R12:
> > 00005626520d33e8
> > [7955220.794827] R13: 0000000000000043 R14: 0000000000000000 R15:
> > 00007ffc77d00780
> > [7955290.222553] tpm tpm0: Operation Timed out
> > [7955292.226513] tpm tpm0: tpm_try_transmit: send(): error -62
> > [8311409.491438] tpm tpm0: tpm_try_transmit: send(): error -62
> > [8311412.625426] tpm tpm0: tpm_try_transmit: send(): error -62
> >
> >
> >
> > The kernel is 5.10.89; CentOS7. I do not know how to reproduce the
> > problem reliably. I know if I reboot the host it gets "fixed".
> >
> > Is it a known problem? If not what would be the best way to debug it?
>
> We really cannot give feedback on non-mainline issues.

The kernel that is used here is 5.10.89 compiled from the stable repo.
So it is as mainline as a production kernel can be.

I also saw the same issues with 5.10.113 (also compiled from stable repo).
