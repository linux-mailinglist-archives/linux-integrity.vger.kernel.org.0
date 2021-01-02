Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CA72E8945
	for <lists+linux-integrity@lfdr.de>; Sun,  3 Jan 2021 00:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbhABXIs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 2 Jan 2021 18:08:48 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:34411 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbhABXIs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 2 Jan 2021 18:08:48 -0500
Received: by mail-il1-f200.google.com with SMTP id c72so23421074ila.1
        for <linux-integrity@vger.kernel.org>; Sat, 02 Jan 2021 15:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xiEz0zPMyUpnKzLhYUnlv16mJTBk47GYHjbMemvYGag=;
        b=nXdn6OsgHM5ERZk6+qOaYDolv8gQJKmkqtmdglNaaXznkomDQj9uuZ1jrC2FhFH4rx
         QrYV4epksQU2pd+gAZ2NYJar80Rgc7H6D8y5uueLZQ+CGgU6lFwSMYlzljY7SkTW00xj
         jSyfcei8aCMoE8GAHztzuZ6BfrVpS9WLKKv1bUV8m/4I7HHB6J+YyS76wDr3UlIjzh7S
         eWsRSAQ0otUOjxhLpr1ZEuY2cH2sS0bKuXHqR8BCBnp1kbAjmXj5BKL9I7MG6O/gJbdX
         a2WvKEudqJg/XHKUax5oLsqG2QQy6Ol62d83gAD3PApJDHoKnEJDokiDF3xznnlCNcbm
         RKDA==
X-Gm-Message-State: AOAM533bo+KV+u67LFq5pc1ZDrJ8PwJKzg9HZMPYCO0u+6bZhiGOtit5
        WK4dRh7kc1AMQXPjSEkJlowxsC/KggaOpaAL7GUeSCRYPP5G
X-Google-Smtp-Source: ABdhPJw5aPB63tv+UKyWH6P3GLw1/joSnocDf9Va4zkVn9W6ovN0OmH9m4h5GDMUABDOGXo/PpQv9dQg0Tviuv4SPWoyM7fs5DD8
MIME-Version: 1.0
X-Received: by 2002:a92:1508:: with SMTP id v8mr37962807ilk.162.1609628887224;
 Sat, 02 Jan 2021 15:08:07 -0800 (PST)
Date:   Sat, 02 Jan 2021 15:08:07 -0800
In-Reply-To: <000000000000880dcc0598bcfac9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b157705b7f2eefd@google.com>
Subject: Re: possible deadlock in process_measurement (2)
From:   syzbot <syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bhe@redhat.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mike.kravetz@oracle.com,
        richard.weiyang@linux.alibaba.com, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 15a8d68e9dc23dc9def4bd7e9563db60f4f86580
Author: Wei Yang <richard.weiyang@linux.alibaba.com>
Date:   Tue Oct 13 23:56:33 2020 +0000

    mm/hugetlb: a page from buddy is not on any list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13612350d00000
start commit:   1590a2e1 Merge tag 'acpi-5.8-rc3' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=18a1619cceea30ed45af
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c79dbb100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169bba3d100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/hugetlb: a page from buddy is not on any list

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
