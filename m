Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAD7B9DD7
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Oct 2023 15:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJEN4C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Oct 2023 09:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244142AbjJENv3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Oct 2023 09:51:29 -0400
Received: from mail-oa1-x47.google.com (mail-oa1-x47.google.com [IPv6:2001:4860:4864:20::47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0419E22CA2
        for <linux-integrity@vger.kernel.org>; Thu,  5 Oct 2023 03:46:30 -0700 (PDT)
Received: by mail-oa1-x47.google.com with SMTP id 586e51a60fabf-1e1ad195cbbso1009176fac.2
        for <linux-integrity@vger.kernel.org>; Thu, 05 Oct 2023 03:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502789; x=1697107589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGwGxlTuATRVWE5UT3ZKJoT5MpU675X68ZbpYCN+7kY=;
        b=S7Nee8UIWxgKE4TdDPx98Ion49+ktgJEXERnsv6eE1yPRn4dgOi8CxZsjzTnnTLnoW
         e3ujfdXJWt+auL7fo+tokTIl0QZig5yzKQEPH7wO4QnMSnlGOM0y9OezN/z2d4/P7IKn
         7WpE/7DWS0L9y/tsQCtmeHwTWE5C47+YuJ4uILkEQu7eM8KRuURSAu7VxJZthKtbnO9o
         zuGzLNsSHYvlE96yQuervmQAe5w25gVuO9OfxihNsFJuRDWa1CHGi+Rs63y1QL0bgxdZ
         dvtcAwNneEdpc4V5y28GeCEzoEmj9Y+imFD8jh0UzAjSZtYiZ/nR8dULoHyqMjWWrNNE
         KjiA==
X-Gm-Message-State: AOJu0YyFnhlOJS/tsabEidxmfORkoNlYZMVptNSaKzEY2YRlfJME5JW4
        DLhWSTLlKGiTVQLAPDCrw2pItGAR+95YPqi1DcIpvQu4NO7s
X-Google-Smtp-Source: AGHT+IF6NXpW2zd+hCeIzElnwrg53MI5PnCCJL42D9bvk43rwJ1rmAHq/sIWi88y/rKUpfhhxrW+Yd6VgiNDyLe+SSuoEVFU4PnF
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1987:b0:1dc:768d:bf6b with SMTP id
 v7-20020a056870198700b001dc768dbf6bmr1900344oam.11.1696502788922; Thu, 05 Oct
 2023 03:46:28 -0700 (PDT)
Date:   Thu, 05 Oct 2023 03:46:28 -0700
In-Reply-To: <CAOQ4uxjw_XztGxrhR9LWtz_SszdURkM+Add2q8A9BAt0z901kA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001824660606f5d6ac@google.com>
Subject: Re: [syzbot] [integrity] [overlayfs] possible deadlock in
 mnt_want_write (2)
From:   syzbot <syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzbot@syzkalhler.appspotmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, zohar@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b42fe626038981fb7bfa@syzkaller.appspotmail.com

Tested on:

commit:         42555f30 ima: annotate iint mutex to avoid lockdep fal..
git tree:       https://github.com/amir73il/linux ima-ovl-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=16889486680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=b42fe626038981fb7bfa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
