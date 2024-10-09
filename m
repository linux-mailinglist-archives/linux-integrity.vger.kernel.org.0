Return-Path: <linux-integrity+bounces-3776-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69927997561
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 21:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0733EB24702
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE51E1A30;
	Wed,  9 Oct 2024 19:05:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D51E1037
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500706; cv=none; b=I8mXgnkHE99QzxG5f49X20kXDa7tvQWekAyEBouTmHZEA5+3DIGu030t2qwCIH8vwyUD6Sfgsa7XzcQTRb1NJbX/Gd/R8GuPAbQ7k7SZTsNNy6iFrRnq4H/BimPZ2/sbO6z2EXLfmzSrEzEtmfOgwqadAGBDKren+Rpn07c3n+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500706; c=relaxed/simple;
	bh=gvl753cmd6Kx9Rt2yRzrebyZBHezlGiPW3rpihqJy7I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tw4cCWWwQPEGsKk+IXM7IXVoC3d4LNf0xhzQwDeEPz1q2e34Qv38Ri9tkSX/DHWVcOMp5gKvP9npXGgtKeUi7K5MX7UrHy+XL4kZj217Rx2B3OxniDczEJxuznwRrucMaF9zaHtyFV4hQm1uN4Zq4uYrr4R9R/deKPzhbVHM+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a392e9a8a4so2334075ab.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Oct 2024 12:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500704; x=1729105504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u95iXJ49Igp9OpSFm4zZV4sLy87CGukgyLqm7BVOA1s=;
        b=cl73BNeOYQg/ifDMmdL9cTDkLfYrmN0lwTuF+zc0UPbxT+ij5TPrg1GXG4OUNlr6yv
         ihvyNIBdCBTjWmyq6brG3lyO1LxeqDRX4B1RWnnCk6q1+ILAtFrCqdNgWzy5XMQ66ZrZ
         vaA4nVjPXmXX+A6GMriwBu6lFGdhqwxwiC/9cNXfiOvDu2MlUyhgYrqJF69gGszddAWN
         wHSZwuDi861XSxLeY4Wy9FIxkwcIR7c0no9D5/jkx0tf93VgWcxY14hlfLRDpdLP6Fdv
         N5dTadxSc1GDE42txn+UzrY+xq7CfZv4Rpot14+Lq+aTxasF1unOTRcj5Vv+XIiqTr3o
         emSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWnxhkRAnyjJECI74gdt6mY5XYDK0ubYycLYHEbeRAD/CzOdKXdK732qemUVbXRjmqy9KqMTY8HHHhlMY2vGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAsIDxySWWE+aeITqfdREsdkZg4tElDzr2foXMxzM+o69SPOzI
	PfWLECtRO6/ypr3b575DDEdVv5EYz/2lvFif0luRDiDC6SuDgfgZzAmXjeK5UwJF4lFusXcknkJ
	I7dv6vzF0QGK4NI9iVM2ku2Se/Dcuh6WOQ6zG5+mOJvQ78oN8mhJIBJI=
X-Google-Smtp-Source: AGHT+IFCPf66BkaFYbH2fymxFQd+vTQzRMgzpdKXDeJtc+D0Seb1RxcQ7Yx9MemFqc+6V2V4zIZssVNRJ7q4oSGwgJPuJ44k0O9q
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3a2:f7b1:2f70 with SMTP id
 e9e14a558f8ab-3a397d2b458mr35000385ab.21.1728500703772; Wed, 09 Oct 2024
 12:05:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 12:05:03 -0700
In-Reply-To: <1a1d106ea8bba8abc1d3f3cd6fdd71d03edcf764.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706d3df.050a0220.67064.0051.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
From: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	ebpqwerty472123@gmail.com, eric.snowberg@oracle.com, hughd@google.com, 
	jmorris@namei.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com

Tested on:

commit:         0438fbb6 ima: Mark concurrent accesses to the iint poi..
git tree:       https://github.com/robertosassu/linux.git ima-remove-inode-lock-v1
console output: https://syzkaller.appspot.com/x/log.txt?x=15ead780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74c522fa0761706b
dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

