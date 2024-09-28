Return-Path: <linux-integrity+bounces-3714-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4E0988F8B
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Sep 2024 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769E5B20D88
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Sep 2024 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38508187FE0;
	Sat, 28 Sep 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kzEGu3Gn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4A125DE;
	Sat, 28 Sep 2024 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531782; cv=none; b=KJMyxtB//0j6vcWOJnkxQ1/mzt/R/zFnG4Pw2NwRo+YSD3hTARs5mu4ENUi8LEly5n8txLfck0rAHqrGMPRSfmG/kn5jZ5hHHyY/nKOLm9meK/2cNmuyBhAU98fjvw1MQur926++yOmtYjHT4dEkSb2cUyHds2HycLKFQ3u0z1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531782; c=relaxed/simple;
	bh=V0bC7nOSX6cbrcwlTI9Og+ymNfrAjTZQ4KChMguz4Xg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DAmf1F3lZnDCQd6JHNgJXYX/Mq0b7bMJqOnGZorj9D5yg/o3vzDVNvm/oLktcASNG5QkN0zzXZgDWxlO3xYNP5erAjjLOLs2sFjbg9fls2zL+eKNJbZUg/+Aa6jUkJ33Jjft2yozZcTRPSeQ7p7EPXkE/Y8WAwcj0SgiS9Eg+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kzEGu3Gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BB5C4CEC3;
	Sat, 28 Sep 2024 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727531781;
	bh=V0bC7nOSX6cbrcwlTI9Og+ymNfrAjTZQ4KChMguz4Xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kzEGu3GndeI7HhP/4+w3f8WhO9zIibC2nDGGxqHpGYgQpITxyhAX8E4+FYF5ywplQ
	 TKGM4CAIFsHFs3ybovgU9nGj0/lMuMxT6e8j27OK26RBvVZNzgYGCR6theqj7iQMAE
	 OaHkR78sw1jmTmQTttJ11vJEzUXPiTII/olsG0Tg=
Date: Sat, 28 Sep 2024 06:56:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
Cc: dmitry.kasatkin@gmail.com, ebpqwerty472123@gmail.com,
 eric.snowberg@oracle.com, hughd@google.com, jmorris@namei.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com,
 stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com,
 zohar@linux.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@kernel.org
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
Message-Id: <20240928065620.7abadb2d8552f03d785c77c9@linux-foundation.org>
In-Reply-To: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Sep 2024 00:32:30 -0700 syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:

Thanks.

> HEAD commit:    97d8894b6f4c Merge tag 'riscv-for-linus-6.12-mw1' of git:/..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14138a80580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
> dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118fd2a9980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1038299f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f181c147328d/disk-97d8894b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b8b0160d9b09/vmlinux-97d8894b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c5dab0d4f811/bzImage-97d8894b.xz
> 
> The issue was bisected to:
> 
> commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2
> Author: Shu Han <ebpqwerty472123@gmail.com>
> Date:   Tue Sep 17 09:41:04 2024 +0000
> 
>     mm: call the security_mmap_file() LSM hook in remap_file_pages()

That commit has cc:stable.

Can I suggest that you change sysbot so it includes a cc:stable if the
faulty commit had cc:stable?  If Greg agrees that would be useful?



