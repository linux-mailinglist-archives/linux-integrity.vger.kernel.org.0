Return-Path: <linux-integrity+bounces-4363-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045C9EE4E5
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 12:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273F71886BEF
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB581C5497;
	Thu, 12 Dec 2024 11:21:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C6210F6B
	for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002465; cv=none; b=pZ5qpX+QnuPfixXMpPuHDMJBUeIUtizcX4wJTo8TQygsxh7LAmFgPqZBshKxh4IYrEGGlQ/Ujn/JffJjfqARpClzSSg+f2DA5wSJ/0ntM3GQhovg45S0ioJR0Q+W3b1geVKqeGbTNl9bvRYOcqes5OAQReDeFE2cB7kkLuamm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002465; c=relaxed/simple;
	bh=Y4XI4Ells3mnYGRwVSRKFnxFRULix5bUEreIKmF5zqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EK5adTV7ye7iyLYjUWdqZMXGltMvPWs2AMtlnmozOsHNnOUeeNb61HFMGyYwDeAD0k7/A/NsFmpxTDwrpoo7Ca3+buEXVnDwnNUcjhHMnmx6bcVO/gY7pbVHW8klZSq5FRxGn0sE3uasHrV18u3PNZ1ugCcDbh45Rg3W7sthsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844c99801dbso39449039f.0
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 03:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734002463; x=1734607263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efoVXz7q0jZIiG+6cenIdyRJUBuEPqT6nO/eaTRVO+A=;
        b=nEx5V79b8jthfWUaX3QVZzUmQLonj4rJJtWLOkLeACg9wyzKpEEqR5zCt2DiIjFpyt
         3OS2fH5/4w02+Sta0MyaEaJFZ6L50CmNWUcf2I+rbdTo718jL9owfUHNLOSzDdg2YZ4a
         PO5vXlkiZiggh1I7LMLUlEoA2j9Sh1f/6w+DX1jHuEC7aed1+/+DeEodRAbrMfwC+/IT
         fzq93BuICNlUfQENElJUl8/fb33VPybUWVoacRCe3N88ertJURxgofEzMQAZ5pi1lT1C
         t3YKVYyxAArMWNqemQwE4zR1b2iD40vGaViPycZO0dVWA+UeIBWc9VjjD/XrdRGP8cZ0
         SUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2abj+9fPD/9bHLzsf3LQydmZX+bpmOHOAm0r/VJAoVx5E2VqUqaBGUeJQ9kmb6qWPY8NqqK6GyA8JcspkFDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlUXVZSwkI3o4PjotS4zzngdTbcuTWcTW8n4/uOzMMi6Ww7T7
	D7yj5/HUyiZtx5+3PZK5ymCO/FhO4p4YGFkzgtNuM01dnZcLXqOfJz5yWJDveTuaW1QkglAR8H5
	tMMI5s0hRO0iCVa3pDznxtbI4p5EJ4lk9URCOJkV8YWaFuHdr7lIfNb8=
X-Google-Smtp-Source: AGHT+IGaaDO3YVXqZI6iELV8/LOtGxjLYb6+FlxKhT4QZJSL0KbR4UQseJ8xjs+4CBrXQw0L7MIhbZIugmVDrByK6corfJLZHVNH
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8f:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3ac4b436698mr22783755ab.18.1734002463268; Thu, 12 Dec 2024
 03:21:03 -0800 (PST)
Date: Thu, 12 Dec 2024 03:21:03 -0800
In-Reply-To: <PUZPR04MB631619A22F03DDBDC97905DD813F2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ac71f.050a0220.20c8bc.0002.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (2)
From: syzbot <syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, yuezhang.mo@sony.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
Tested-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com

Tested on:

commit:         231825b2 Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b56cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d5bd2f63a4859d
dashboard link: https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133e6cdf980000

Note: testing is done by a robot and is best-effort only.

