Return-Path: <linux-integrity+bounces-4315-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE89E808C
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Dec 2024 17:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72F3188329B
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Dec 2024 16:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FB14C59B;
	Sat,  7 Dec 2024 16:13:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182EC1448DF
	for <linux-integrity@vger.kernel.org>; Sat,  7 Dec 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588008; cv=none; b=E4GQYqGEYpni3ooPvkZGkLMJuqOneeDRLFIWHVl/Q4UG7MZBXt50x9GIgvf1fvbpeXisNNx01Vl8rUJ8sL0jinsro91sxpnJGCg93z0wRItypJqadFpvGyRfJ2xWWgFh2AxBMR6lEBTnhlfzBQP1bJ9sx8cLiSd4GjoiIyEIaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588008; c=relaxed/simple;
	bh=XUHSZQQSYkDoekv/qHj+HpewJonX3WiLq814271Dryk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z+L6Q4o4xi2Yx2S0ztXE30agKO0AbqfHNOzDW8mLIlVDk/FiJv9gg9ihaIoOGJbbdCK+vW+2XTL2sCar0+1fBhLp1b2hB3cNOcK7dFs2O8Prf5CcLgz8P7doEjpxaWv1MRM//gwfoFQcYs4YA8xAxombIn85lLR1uMo9LOSRUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso12389505ab.1
        for <linux-integrity@vger.kernel.org>; Sat, 07 Dec 2024 08:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588005; x=1734192805;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhzxDwbCKq+JPBpgwoXjwLiPNtdks5c8N/aqFvEki9k=;
        b=CDvKp/oesRb3vp5pYflHXuis9kvjlKa4PT0V0LWTEcz9IOT2YcmjPU/zutbBJzC98S
         glOrpFdxVYBO1eGN234tE+Cq7WxazN4WnFHYcbzPSasSJFj0+6H1lkoYdMjjbXtvMWmR
         fL9gsV/aZa2Mc4xtlDSAuWoyAGo2V6xuR86CBKxgwPrq63mOEubzW6q9GDVUd5Q0P5Z8
         YvMZ1x6EgsZS9aJ+YwO8VsWsv/7yx5/VTqoXPwyYrE2bGXYfaVSA8BFgItDFzwjo9Rzw
         qPao4GFdtp5b9EbV4DGuPIZz2Qukiv3evmXgvWs8tHK34pg90cyiMzd3wsDVw5sjjJR4
         744g==
X-Gm-Message-State: AOJu0YxVS84HZzZ/KjVssWGrHf6A0ooD+CVG2ubxUrxHuYPrhwt4v29N
	x9HaXhNMxW3ruG5/+mVKfrmwPDwKKhJa3Qv297qgHk0D/Rnc1FvUZULDmxZ/UUl6VxaDt6HrXyQ
	K6oZhP2hKNihMQ9A6L0I6ZKb/1WoSqzHKQq2RkOg2SGKEzfpAt/t0tjU=
X-Google-Smtp-Source: AGHT+IFEATkXgz2VvopKjAnmUJQ9g8FTzvOI4HKq+jh61iR/WN1sLq9AcM63t8f5v134v7ygI5kH9sH4oAi9R8unKpHc57zwGXtE
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3a7:e732:472e with SMTP id
 e9e14a558f8ab-3a811c616c0mr80851425ab.4.1733588005325; Sat, 07 Dec 2024
 08:13:25 -0800 (PST)
Date: Sat, 07 Dec 2024 08:13:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67547425.050a0220.2477f.0019.GAE@google.com>
Subject: [syzbot] Monthly integrity report (Dec 2024)
From: syzbot <syzbot+list2eccd137a466e6acfa54@syzkaller.appspotmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello integrity maintainers/developers,

This is a 31-day syzbot report for the integrity subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/integrity

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 433     No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 32      Yes   KMSAN: uninit-value in ima_add_template_entry (2)
                  https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
<3> 2       Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

