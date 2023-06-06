Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3D723CAE
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjFFJMw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjFFJMr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 05:12:47 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FFF10C7
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 02:12:36 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7770a902912so501085539f.0
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jun 2023 02:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042756; x=1688634756;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKjEJ+NhJxp2P/83FzouzrqL0ri1MzUuYoHzC3XIwgQ=;
        b=eac1cmKwv/u1cmeYEnE7IgKA5gYdcZnybMCr6Y86KvcCJ0JO4n5Pn5qoWXZoKNU4Md
         c0tNsRiGl4Gi3VpdN1alaRPZW9v3bh2aRJQXaMsiF6JJfvcWAPWxJl/D1Ai9H1bDIZbn
         lVtGTVTyyJVKwIb87OM7K5SNcBVLqhz21tCnKiN8ZyDghXfNTzMKHxt0CA+Pm0puTPgA
         mJczA7FdHETLusP1LE44eAX6w8sOneZLRh22VwVQTK6Wda9J+1yQd5MuMnOZ7qFI3gdi
         kPoNOaf4syfGdrg8fkvd1QZWBgl9H9infrOut9+fDa7at53WvQi9u08mMOoVAco/ftyi
         TqJA==
X-Gm-Message-State: AC+VfDwbPH0UZKrNpFn0kHjQ1moAzd3CJaXDQHah1JrNpeYw7+flC91p
        LDZ3bPrWf4GW1AsPxcuU8o3oYJSyM4oS6cxA+Cf+XtVJdAcR
X-Google-Smtp-Source: ACHHUZ4hPLNKpE1IYP8UTPjo59Z0ZEP2JEaW0grC8Ojb0fa/yI50EDSv8JRCXB1vPNR0sMhFHlh+lv1sqSuhYH9RxbYGnWQNiPFz
MIME-Version: 1.0
X-Received: by 2002:a02:b0c6:0:b0:41c:feac:7a9c with SMTP id
 w6-20020a02b0c6000000b0041cfeac7a9cmr587850jah.6.1686042756304; Tue, 06 Jun
 2023 02:12:36 -0700 (PDT)
Date:   Tue, 06 Jun 2023 02:12:36 -0700
In-Reply-To: <CAJfpegtzZnzW506AHyw_5Bqn-thhrd3-_t-qJ5OJBzP-z3O6Fg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090dbc405fd726b57@google.com>
Subject: Re: [syzbot] possible deadlock in mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
To:     miklos@szeredi.hu
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> #syz set subsystems: intergrity, overlayfs

The specified label value is incorrect.
"intergrity" is not among the allowed values.
Please use one of the supported label values.

The following labels are suported:
missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

