Return-Path: <linux-integrity+bounces-6519-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4200AE85E9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9DE7A31C1
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AF714A639;
	Wed, 25 Jun 2025 14:15:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AB1DF26A
	for <linux-integrity@vger.kernel.org>; Wed, 25 Jun 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860930; cv=none; b=pOF1apJW0EtYuk9SKBtdHV6DvS28LipPBYcdf60Y5dEg23i6JmVZlthtNcTVa8C34gQcz3oihWJRcluOwkSa4KdZKgL8KT/lLn3iQkwgb8AR9yMKi2LUl1HQTTPD+6ZJbBzhVN3n1bMMIPshu0BNv6G83xVbQhbCGE1J0SilWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860930; c=relaxed/simple;
	bh=htkrJrR5CZT5OOui0gtS3RttV+j+vFcqYMYuKAHYOCY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qzV22nJ6xFrsfsp+Ly/Ps3+WzoL1GEL8Pg/ATMlZtgYV9QZKDe5Eb714XfidYwSCZTii84s4a4xOfduCmsSCsWpE3nEpr+ouGcOGRliqwneVhl9zFodT82Kb8MapvAQatdPOjcLRPLM/iW9SYfwSfhUFsCr6s0srKPjoyIVnTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87313ccba79so1036652239f.2
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jun 2025 07:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860928; x=1751465728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MEin4t/ziIjLNPi47j67uD/WUkbw/RxekKaFXQiDx0=;
        b=biMljUW+WSO1xkY4KrgOIBsT6x6/HWwLZL/Jmx1YlTRyQbad8ooOgaYZmMjv0FUwRR
         K2Oe3dvXDgkThjOUdS66kJaRg4WngD8QgYcvFQKnE2WHgIgYAthpqkm64X5yXKglvK+M
         iex784qaun6C23E+Z18i7eO+OC/OVY42C4P2jTXzjT6Avdx/ilrAMmwKRwIgJP58la+8
         nitw3ps1Px+oviH8mJdW8vR5sN9DNnLmcGw3IlDRXu5Yfe9CxzjwCsAZ8IZ67/tBeciK
         iUGjbP63Fe3RSz8r4Gx4gpvMptEk6+EFfZCeTk/xSbZo9aI4V98LNxZWg8RUq0HJs6sm
         VpNg==
X-Gm-Message-State: AOJu0YzwAy3eFlwmfh/3pZsgPB9Y2yczmCEOd0VBYrKHoUzh0Jwr+Bj1
	nlqbN3JDmgTevgrvjZwFwgje6k1hZsh44uRpdycPCLXSb60NSTsNSKs/P+Zka5sN9wd6YajzcKN
	4MJOvB4QU9e0uTzL3R6729Zv+v13/5kCXJpOUudOFgaJpGVkqE0ZS/dX59II=
X-Google-Smtp-Source: AGHT+IGlbAs8Qgq0kF4FQvO4dHFusdSL2Bk35rEbfP8CSA6+6jXl842u4d6OyaVp3mQ6hXDQFXkrbKHFfVNZwsHvhPw8m5fqJ0oe
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3de:1244:e7bc with SMTP id
 e9e14a558f8ab-3df32922375mr42246435ab.3.1750860927957; Wed, 25 Jun 2025
 07:15:27 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:15:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c047f.a00a0220.2e5631.00d0.GAE@google.com>
Subject: [syzbot] Monthly integrity report (Jun 2025)
From: syzbot <syzbot+listfc8d7b7995dd788237fc@syzkaller.appspotmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello integrity maintainers/developers,

This is a 31-day syzbot report for the integrity subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/integrity

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 10 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11      Yes   INFO: task hung in process_measurement (3)
                  https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
<2> 7       Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944
<3> 5       No    possible deadlock in process_measurement (5)
                  https://syzkaller.appspot.com/bug?extid=6529afa25091aee8536c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

