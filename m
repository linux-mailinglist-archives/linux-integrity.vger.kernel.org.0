Return-Path: <linux-integrity+bounces-8141-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4CCE497B
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Dec 2025 07:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10116300F318
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Dec 2025 06:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784B25A2A2;
	Sun, 28 Dec 2025 06:29:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD923ED6A
	for <linux-integrity@vger.kernel.org>; Sun, 28 Dec 2025 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766903344; cv=none; b=C4P3ae9hS4g8AV+xGg3P4BA47UW819TOs8U4m9aYB7zI1yJA2hqW3dm0Jzb+YcGsEDUaKlnLWVluCpJ22ti7NFWojDJT5n6zR7R36XAMQ0MoFQUVkFOlmzUA4TDUlQX2EyFIo+8Layu5R2bn70mg31EnWkIhFq2PoJg91teUoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766903344; c=relaxed/simple;
	bh=Inljx6UOoK9th0Yw9ul8xLEL3W4o8tpjYeNnAkDOmxk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NwKCelxWTa5eEkzBsT1cZifEZDt4Akogwvd4DwX522imLZ3vhSJeLqbP3Xw0BupQsKV2OWbtM7oSWta7sl8wbk+QE7kHGUzZAwNCTkAGfdeof5GRr66l2KrT11lv9Zgl/yUyqfu/LLBvY1lX1+rQvEZMGxHhlmGSKAHKDYTNImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65eb49dd974so8631958eaf.1
        for <linux-integrity@vger.kernel.org>; Sat, 27 Dec 2025 22:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766903341; x=1767508141;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqWaYjXGpL0SCXHVfAwZczGoXfLd9iZju3rBMa/XlsI=;
        b=IiOzpf9Fa5B42+KgW8I7tLQqDs3Cb2hrY34YY9ZkEGlusMS5MLi9drbvA9+tcHme06
         JUNT1hgepV1veiHYqjQikEMw6ZAeVMPQvdU7RghFh2xoRvdcwFP6oVi/6Pcd0Zv3NdQx
         GB2Y0erPvH6U7cSBx2ffjBdW8KfdYYfhBEVaD611cANEVQaXkHEZSj7xjxleJuxRVfBi
         FnpjH9k84LtAY5iYAsQdOzKr+1/Xd6pHkkfXUWi1TrunbOcNX62ujGa/WcSj2LhgTrXU
         RioYDsp8Nv+CEhgBwOOzWwS8Ga08FgCDO8ROowrvrNxSb1Q9AtMcCKdXqR2NKlsQp6/d
         HdoA==
X-Forwarded-Encrypted: i=1; AJvYcCXfuc4oiGDXoovbRoBktMUILEuPb8eRbAV2W2FolEf6EbmeKFWSAb4e67/mDEKU/rj/RWGJFnl4WIXuShrF3fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1bhtptoWxTAZ/bZdNlv/0VPHcgwvhofADBy+XeHm13L15nD5
	yC2x8k0h+cUVcBcxJ57Gtc/fXxbr7ABXpgL/AOo3tFcdk77UVYzk4xd/umWafvI91LdBxWImZL1
	pwXAoTRqfL7RGEFmBtWCCF57AxbeJxEUuqO+SxNSa0euRQnYOp57MmOyOcL8=
X-Google-Smtp-Source: AGHT+IEoS0rAjcG/+fGcGmjafzr1ie5EibCfjAHuWQ1bamSqVqpqVq5pUPYA4JV9/ivc0D0yU9QEcaQ+4125sqT5bkop/MWm91yt
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d744:0:b0:65c:f062:bdde with SMTP id
 006d021491bc7-65cfe799322mr10615394eaf.36.1766903341612; Sat, 27 Dec 2025
 22:29:01 -0800 (PST)
Date: Sat, 27 Dec 2025 22:29:01 -0800
In-Reply-To: <682e11b1.050a0220.ade60.09e5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6950ce2d.a70a0220.c527.0006.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [integrity?] INFO: task hung in
 process_measurement (3)
From: syzbot <syzbot+cb9e66807bcb882cd0c5@syzkaller.appspotmail.com>
To: bfoster@redhat.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10499e2a580000
start commit:   172a9d94339c Merge tag '6.15-rc6-smb3-client-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea35e429f965296e
dashboard link: https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16836e70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1617a2d4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

