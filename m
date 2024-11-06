Return-Path: <linux-integrity+bounces-4027-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADAC9BE104
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 09:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0771C2326F
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36801D5CE0;
	Wed,  6 Nov 2024 08:33:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD721D3656
	for <linux-integrity@vger.kernel.org>; Wed,  6 Nov 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882005; cv=none; b=Yix7nOQcCmzwMz2R6swVxKyOfimt3GarqXpmmfSaXUDqbjc8nR2AoeCOvnCVQpmZ25jZal2NtZGXa/Qsb3ouhDFlupArz0AvT1iB2cIg658t8mTPCW8H4adGi02g1oqkPreiryjwFi09bbyjGs8JHjRnmAS2Txs97uKYYfD6j4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882005; c=relaxed/simple;
	bh=srY0MO3rROF+vBrxSFg9Wj/3PDJRSWSAUhQyqgFgbEU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CbiOHkU5PAtp1PradDyxdYayxozW+hhFn4hNBn1diGEV/phdY74rVfrtvo9wJraYNYbgGWZ+LVdLoIlVQNgGDSa0LHUL3lcZRrzDiQkNdHJUN+VXjZXoc+Fd0Ou6nRIkNOK0CW2GI8Ohn8x1vI6agJmQGXhhXiop8/dG28/sowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c48f1312so45737965ab.3
        for <linux-integrity@vger.kernel.org>; Wed, 06 Nov 2024 00:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882003; x=1731486803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDqGiM71xh6u3PCMqXYywGEC9WepRHBEgKYM5+6FC9M=;
        b=wxGqqQSSSlQV6VRqcgEBK6ggI+OsF0+YGMf/dy+X25dm/RVVRuS/dv0bgjz1kSQl9R
         rG9tSAlZNCCqkq7Wv6gPAJP3kID0VvOgbFyXnHG9rA+PE4ULHwawVKivddfZ+VTsPXX5
         uvgs40pOnkeTqDH/BFQmQJJxO/+xDnAV77CvHvTTS2WAowr296ifYkikwvXq0tW7B5fK
         TpqJAwiPwXRO/ljmVNPnS9SSbCbZg4zCF1mU+NI7RaGJl7wdxxtG6k4fRsuScEjtpH9X
         G+bXkms6UivPTAAiqKjB7H9O2WOJzKxMe5bHkC/zXSlpEbeGa9PnWrDy5njJhFpKGdlW
         esRw==
X-Gm-Message-State: AOJu0YyZKCv4K6SKwTdWQmKC5Q82CslvIJbdTbv2b4xVcVUlQp6wqGfr
	wcVKd2SBrAJO5pJsCJ4wHQMkqZA1Gstt6MGyssl5u5Cb1XaDZkMwYYWwKFPp1N+ShQi2QVHYVJg
	yf3+xxVSRfPH3HI7evcaVL+ZvgoCjTGcJvJuVdM6cCvjzPCPQZXHY/EU=
X-Google-Smtp-Source: AGHT+IE8KZeleEjuLmuInfhLaaZMkmgoez7AXY4X/DOyUbKT8c8IVtH+y5AxOjNtelvN4MnvmIOO1fs0SwC4tXMLFPmMU4fzUu/v
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a4:b0:3a6:c98d:86ac with SMTP id
 e9e14a558f8ab-3a6c98d8a5emr122268955ab.1.1730882003462; Wed, 06 Nov 2024
 00:33:23 -0800 (PST)
Date: Wed, 06 Nov 2024 00:33:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b29d3.050a0220.2a847.1ba5.GAE@google.com>
Subject: [syzbot] Monthly integrity report (Nov 2024)
From: syzbot <syzbot+list4e5402cbee6a192e1e9e@syzkaller.appspotmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello integrity maintainers/developers,

This is a 31-day syzbot report for the integrity subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/integrity

During the period, 1 new issues were detected and 1 were fixed.
In total, 3 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 403     No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 23      Yes   KMSAN: uninit-value in ima_add_template_entry (2)
                  https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
<3> 1       Yes   INFO: task hung in ima_file_free (4)
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

