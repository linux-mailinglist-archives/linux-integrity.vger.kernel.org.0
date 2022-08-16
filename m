Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192EB595296
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Aug 2022 08:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiHPGge (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Aug 2022 02:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiHPGgV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Aug 2022 02:36:21 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFBA1A8635
        for <linux-integrity@vger.kernel.org>; Mon, 15 Aug 2022 18:07:13 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id q15so8826498vsr.0
        for <linux-integrity@vger.kernel.org>; Mon, 15 Aug 2022 18:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=SqOUkzJFjo9CDD72Kqr0xegQjaUL3ZjgAa+x3OMac1U=;
        b=eTXUxxWQRhwTw6n1mxo940Cn2KCQVpnucyby41SrkrK1Iwa4YrzGTiTfi3hsyv9nar
         Q4rAXujV7drFJNK9jHAM+57eRlzfLkO6BW434STe4jWXpBsrcD9r+5VkVPYlcydN/FHE
         np2H8PSrJewTR9/nvVAqvP9CshQUucA9uvQ3QGXrQ49PWySR3FBiDSrkaJCbR4Ws3uF1
         Rxtc6JbTaLf3zsA9wkg3zIbjHUfdzx/CqOJtl+9Y28HBbHIdiIrSwxLrMkbdhP1ICd1E
         OjV9pSYFBCI7vVi2ip986TqKAGrbYK7MZ+6Yz5YM+mSvB7ZiWI/rE/dmgArDM3mZZI20
         dPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=SqOUkzJFjo9CDD72Kqr0xegQjaUL3ZjgAa+x3OMac1U=;
        b=CNiY1nSH11xEDzLe/RjMZTs5B2pplHW8cBfLyzLIN43zQxuAOKtVexfcGJx1HE26dy
         I3RMvTi+9+xMiq3SJwqtPRspWgdifiYpjDJILhzcawol4VTgbT5EfgZJgytAbQ/8lnbW
         X8zHF2k+Xdd9GQ+5bXQ+Eyse0xR3L40BO4AOjpIMcQuFx6AL7K7YX2ZVa/WgOZL1yRF1
         IrVxujGBK/1fhVqAQtOMn6aCFrk0MeVD+VjyfMRq1R92SllsP7RcoqjczaYoUlB3Kown
         wFmIuVzPm+bCgwNQBvbMbljafIHVoJfAv7dKjlj8SYftGa5CyM2ro8aabque9k4QiUD0
         XJrg==
X-Gm-Message-State: ACgBeo2OURWhlsOjyT4/Y7nDSgC2+vvGnxIDWkAP3Fd24lorRKIHRbGB
        ohL6fQJCa7I4M8Vz5WngdWUofkFRHzTZEIYNDzOjFUKNoJs=
X-Google-Smtp-Source: AA6agR5unR2ZP028lNBOaEvDfkRqjGM+f8B9jt7vWCBLsoDOi+W2p8aj7EqsS4NEzWkOZXdcVsxPNxnUvMx7RVPrFrU=
X-Received: by 2002:a67:ee12:0:b0:385:7059:ac88 with SMTP id
 f18-20020a67ee12000000b003857059ac88mr7482576vsp.85.1660612032053; Mon, 15
 Aug 2022 18:07:12 -0700 (PDT)
MIME-Version: 1.0
From:   Anatol Pomozov <anatol.pomozov@gmail.com>
Date:   Mon, 15 Aug 2022 18:07:00 -0700
Message-ID: <CAOMFOmXzmuGcnHJ7X-W1_Y+0m-kw=vgR6C57NGu7d5rj6VxFcA@mail.gmail.com>
Subject: tpm2_createprim blocked for more than 122 seconds
To:     linux-integrity@vger.kernel.org
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

Hello folks,

I am running a tool that performs some basic operations (seal/unseal)
with TPM. Most of my machines work fine. Though once in a while I see
the following problem with my tool:

[7955220.676259] INFO: task tpm2_createprim:258741 blocked for more
than 122 seconds.
[7955220.683837]       Not tainted 5.10.89-t3.el7.twitter.x86_64 #1
[7955220.689848] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[7955220.697846] task:tpm2_createprim state:D stack:    0 pid:258741
ppid:258724 flags:0x10000080
[7955220.706454] Call Trace:
[7955220.709088]  __schedule+0x266/0x840
[7955220.712756]  schedule+0x46/0xb0
[7955220.716073]  schedule_preempt_disabled+0xa/0x10
[7955220.720780]  __mutex_lock.constprop.0+0x123/0x440
[7955220.725660]  ? handle_mm_fault+0x168b/0x1ae0
[7955220.730105]  tpm_try_get_ops+0x3c/0x90
[7955220.734035]  tpm_common_write+0xfb/0x1c0
[7955220.738141]  vfs_write+0xc0/0x260
[7955220.741636]  ksys_write+0x4f/0xc0
[7955220.745134]  do_syscall_64+0x33/0x40
[7955220.748886]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[7955220.754111] RIP: 0033:0x7fbd13d446e0
[7955220.757864] RSP: 002b:00007ffc77d004f8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[7955220.765603] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007fbd13d446e0
[7955220.772910] RDX: 0000000000000043 RSI: 00005626520d33e8 RDI:
0000000000000003
[7955220.780215] RBP: 00005626520d22f0 R08: 00007ffc77d004c4 R09:
00007ffc77d006b0
[7955220.787519] R10: 00007ffc77cfff60 R11: 0000000000000246 R12:
00005626520d33e8
[7955220.794827] R13: 0000000000000043 R14: 0000000000000000 R15:
00007ffc77d00780
[7955290.222553] tpm tpm0: Operation Timed out
[7955292.226513] tpm tpm0: tpm_try_transmit: send(): error -62
[8311409.491438] tpm tpm0: tpm_try_transmit: send(): error -62
[8311412.625426] tpm tpm0: tpm_try_transmit: send(): error -62



The kernel is 5.10.89; CentOS7. I do not know how to reproduce the
problem reliably. I know if I reboot the host it gets "fixed".

Is it a known problem? If not what would be the best way to debug it?
