Return-Path: <linux-integrity+bounces-3869-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D911E9A423E
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Oct 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F84A1F28A14
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Oct 2024 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2326200CBF;
	Fri, 18 Oct 2024 15:23:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2820262A
	for <linux-integrity@vger.kernel.org>; Fri, 18 Oct 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264985; cv=none; b=AXpfXzCQqaS2lgNDybPYLbRT12E1hcuCaQ5bKP6aPfO/yr5dCElC4pWpweuy0uHmT3NGTKJzfwdVku9cZlU/Z/2OTzKVyo9bVOMq2q5qqPlDvpttcMc7rZNFUMX1NODQ/gfrloyYiQALWxWzObRts3Fwjur3PugcJnvXnzcS8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264985; c=relaxed/simple;
	bh=S2b8raoKO2jpMm+bStWmIYHe9iT0SxSMwT/23htQqKU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tyqfwcJrXqTv6mr0Gvnd7A4RMrdlcwYhktHEnPE0qxSXHfyG6uZLkZoUwppYDIGdQlE/R0ke7w6nfigI8jqkkZl4jtOPVhkE9qZFVtPP3uDwLXBdr9no/ZAZ7dlxmdQExSNMC08vcCgN8TbJZm9XCmb56dBYi4xvol69Vk4CBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso22802035ab.2
        for <linux-integrity@vger.kernel.org>; Fri, 18 Oct 2024 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729264983; x=1729869783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMasKnrStJmhL2WrAjeBgpPgH9uRvlMVH0mRvvyx83E=;
        b=Wvqeb/3tbtN0U5uYT4N4mUmbkGe0KBP39eujhXLnBXP4seofdbofrBKzwUj7MrifZw
         Sr4POwJdIaKZLaXDOUq+NveiBkJMv6eEg58/9YAPCLEI2qlvVEOLBgNJT+VNO5Cm57ak
         yon0QaB3YO//fizazmU0BYANa3ja9dCwXSa73mlc1O3zGUY4ObxP1GdhvfJx26ixmYVF
         e7AK4uM59UR1HjRQDcWH3v6bU3CLSpVBFkgX4gGbJ0rc7g6MKsNAfB4POSw++pGNX0Vk
         XxcPp0sAwLk27HqZhbB7H/7C35NPqYslLjf90+kr2gl4xmcB/bzn0SvNWGVeoFzuXsO9
         QlGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/c1rpRca4BvtKLo2bh2dPJCxWW/iS9/mfTSbqBYZB/RWJ0eGLrfpEJZXCNwyzLuyKzNsW8+jryZJa4RinfRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7ytzt7Tc+/aUQWgg+Pz8ohfZDKnLayqQZUV5TpZX9Y93e5zT
	Gxp0aTv8FcUrOczRQSao3/LXDKmj3LqcqFtPDumepBLr80KnpU5UbKY5U1MEoNaJHlh3AXf7tQW
	NE3cr4LtkL1L62VjSS9n9Jthw51eLyEkw/3p0wa0Z3luXWw9NzQmGORA=
X-Google-Smtp-Source: AGHT+IFaa43STGFMHe0/hOCzeExl2B3M5A5tpOKNGOU/pV3YF8Pp+q0cS6YasT/jYWn8gro3UAO0r1Ann3dOBmvYjNAqMsS6YWOP
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144a:b0:3a3:3e17:993f with SMTP id
 e9e14a558f8ab-3a3f405d064mr29660255ab.8.1729264982842; Fri, 18 Oct 2024
 08:23:02 -0700 (PDT)
Date: Fri, 18 Oct 2024 08:23:02 -0700
In-Reply-To: <46d8cfe7db6f381c99455159bff1c2220dff4aed.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67127d56.050a0220.10f4f4.0016.GAE@google.com>
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

commit:         31063ab7 mm: Split locks in remap_file_pages()
git tree:       https://github.com/robertosassu/linux.git remap-file-pages-locking-v1
console output: https://syzkaller.appspot.com/x/log.txt?x=15502240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b6f5c91e13aedf5
dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

