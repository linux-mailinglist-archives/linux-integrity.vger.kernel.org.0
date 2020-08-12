Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B392428E8
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Aug 2020 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHLLxH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Aug 2020 07:53:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49484 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgHLLxG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Aug 2020 07:53:06 -0400
Received: by mail-io1-f70.google.com with SMTP id c1so1332400ioh.16
        for <linux-integrity@vger.kernel.org>; Wed, 12 Aug 2020 04:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=B2XBYhisqp6tEPr1SWV7r0qTPPRBG8RGgFOkZIhiErs=;
        b=R90Wcw+bfxUMSuWItSpKRp5tomaXv/3lPGiUyo4lsyVm2GuEtdiTEshMxD8tQH3oBP
         qsqonm0ADTH621+yOfwXuuj9HelOU43tvYYJiZvgJcBDnvmVa2UEjvO4iMUpVbKLVWo0
         AjYeQSjZjNhAviArJ95f4fa63kf4UwWPkO+KSJjh/bi6m5h13f07VWKKtwVXxbzvFEOK
         eXRPr7YbZFzaSGfHZZJa+QGaSPkbPfeybOzG19icJgfQh6JEyLEwbjbQeezXbEsC5Mui
         JjFDDW1eUbmX/5fNH4VDgxyYUWafP8k5yJvfOkYDKhYpClzpIpUgWiqvKwMzAYAwsrl1
         VHVA==
X-Gm-Message-State: AOAM532yoS6ctlBcFfNj/NgU4NmThOMpiYvYMIFdlcCj1hSjkdr4QJkE
        FvPv4AOMDUToJ/k6R312exSFxB+OMz+3442u/4qdaa73kK1/
X-Google-Smtp-Source: ABdhPJwSPrkgCaup1SjOCAR16Fo+u9HMyTY31ucZoFvU9HtaLXAhs87kgh1Bhqar1P+Xvom82jDtrsssjIXd6DO1+zkiyXhX5nt2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c7:: with SMTP id i7mr32115461jaj.52.1597233185871;
 Wed, 12 Aug 2020 04:53:05 -0700 (PDT)
Date:   Wed, 12 Aug 2020 04:53:05 -0700
In-Reply-To: <000000000000d411cf05a8ffc4a6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aae24a05acacd485@google.com>
Subject: Re: WARNING: suspicious RCU usage in tipc_l2_send_msg
From:   syzbot <syzbot+47bbc6b678d317cccbe0@syzkaller.appspotmail.com>
To:     arnd@arndb.de, davem@davemloft.net, gregkh@linuxfoundation.org,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, jmaloy@redhat.com,
        jsnitsel@redhat.com, kuba@kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, peterhuewe@gmx.de,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

syzbot has bisected this issue to:

commit 786a2aa281f4c4ba424ea8b8ea1e85ab62c4a57c
Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon Jul 6 20:53:42 2020 +0000

    Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102")

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12fc36d6900000
start commit:   4437dd6e Merge tag 'io_uring-5.8-2020-07-12' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11fc36d6900000
console output: https://syzkaller.appspot.com/x/log.txt?x=16fc36d6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=47bbc6b678d317cccbe0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c005af100000

Reported-by: syzbot+47bbc6b678d317cccbe0@syzkaller.appspotmail.com
Fixes: 786a2aa281f4 ("Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102")")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
