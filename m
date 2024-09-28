Return-Path: <linux-integrity+bounces-3715-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7509890FF
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Sep 2024 20:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0736F2815E3
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Sep 2024 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA6D149C6A;
	Sat, 28 Sep 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNeyrAbW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981863C0C;
	Sat, 28 Sep 2024 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727546883; cv=none; b=cuIWrh3Vm2ZVP+zUro/bo4WuuY8dbqTX6cZoLACbW1wC/wO1xmkjXYeselxOQn/M6pBNDo4QVfC6kZLixg7gWsUy1o0An2MJYOlmbsBP3A2P07bC/QitIJ7OZbc9PgSQEhXNziucd8fQrdxepZR+tGJ+YT8B2eRq3uJg+CyvPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727546883; c=relaxed/simple;
	bh=4rqWLjYuai7cfKpnkWeDQNh9AmqL1eAP/dgFhclyNuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Blw8hEkIHkkdCI/mcLe3GZ/U/S4XId5ok7ef0Os98Xa8QrkXOPTrNTe9ybVuwu44TO5B1D7BxMJaCU741m6nKBgyqqYSDzFTMgkB4WxxOgC4GYolx9Ssjq8cC3Ryos0+edBwT8LVCeDDruPKtDQP6meg8S9PHehoHy71BMAlTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNeyrAbW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso21322931fa.1;
        Sat, 28 Sep 2024 11:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727546880; x=1728151680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKzeRt3cZsRqbJmwfzDXtTwI6KtcqI0hnC8kaq1Fnag=;
        b=PNeyrAbWFB7UibjsQRzP99XFI1tttqHthop3UtaTSpBdpck2GbdyYwyk+FD8wu2NgZ
         20qHMOGq+/yB8Y0776kTJy7SljZRtHaliRjG4LQ6mD43XXFkvSw9VQWMnj1hPclFsVTe
         pwix55YgkfwXMjM07ZKGqavzv6l6A5mMKH8XdigSzOPOnZsAqQRuIPGALjk95Fm5ZmIg
         8ltt8q3etD8kuC66naa829kSyaYfqokhgeese54+MG7EXxQEVcsyFHO0vRqUvbvioJQO
         pERiZtsi4wTnkBH6FFIew4hxKqJpKDYMARIR6IpCzeXphWbqrfXAt7D7wf0irGbWPJWn
         mTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727546880; x=1728151680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKzeRt3cZsRqbJmwfzDXtTwI6KtcqI0hnC8kaq1Fnag=;
        b=fKFXBrCMT8ZPOtKzlvddenBT9tmYcSnNZeJ1KMrfh1UK30A0Dw51s45KOAiMw0jYpP
         P7LyqvMVLqSbWIv8kjdhLZvvy2GSZ/Beoigq0oOJW3GjtfQLb3/UIKSDOGIi8ObTqhy8
         0sXQiInH0PcKMTCbWSPYZ8oC3jgbRyKh6bMTW1gNMxhfH/jxI0En6qBDgBlL06uvjXAV
         zEtREbAjssNPI9LfgoYlIUIkIvqJlLDiw/IkKgMUN8kqErihbEuF4uU7+pWtYNi4aHd6
         93BQ7tAsAkmJlOmZ3MjoGX58lX9Q0yokGNuYks7lLMP62lcEQRot8foxPSG6zjs49feg
         YCaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvnLasvO3DTIX5C1DsPYfJcUgCav6I5J4cxrwQIZqKoWx+sXmXf2kJjREYJDtN8kLuR23Uv0Vz0leohWlL@vger.kernel.org, AJvYcCW4dywiUFm4GRXU/SV4hhQf4CzC7Iumd9xAI5EA+q0HTkU0gQpTXcsiZ2ikjrvghVuINQz8bpEGPQxwQ0fqVQY=@vger.kernel.org, AJvYcCXKa1GU+olX3eyPMXLC2wK/hFyBUn0adSBc0TlI8s1RD6xMGrpHm2cyIMae6y4JjWqkIFsLNCIMT3n/REPcS/iq/viZHcE9@vger.kernel.org
X-Gm-Message-State: AOJu0YwbX+OHTpdjBdywgRkdEFt2cH9LS2v3FTPwRUfGajlppzsaLRtw
	fGhJ9yYLSSsxaKKIpyXvqfphAfoDggJk46ZuZ3i/DXSrmOJ8xwm7PwFW2Zh0kJbR4DDMK7dUFL7
	rV8TfNQOGBMEu/ckWvgnzZNq+RYU=
X-Google-Smtp-Source: AGHT+IEHtJbAYaY5EIQkY1zTXt6zA874QpVFjKS1zKSC/F3APB4uGQGUuz33Th8SwOiUeFGc8eDxsTfTsTynmonlvGA=
X-Received: by 2002:a05:6512:3e05:b0:52c:cd77:fe03 with SMTP id
 2adb3069b0e04-5389fc3bd31mr4795623e87.14.1727546879336; Sat, 28 Sep 2024
 11:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
In-Reply-To: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Sun, 29 Sep 2024 02:07:47 +0800
Message-ID: <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
To: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hughd@google.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

> ======================================================
> WARNING: possible circular locking dependency detected
> 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> ------------------------------------------------------
> syz-executor369/5231 is trying to acquire lock:
> ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
> ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
>
> but task is already holding lock:
> ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
> ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap_file_pages mm/mmap.c:1649 [inline]
> ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap_file_pages+0x22d/0xa50 mm/mmap.c:1624
>
> which lock already depends on the new lock.

This issue (if not a false positive?) is due to the possible `prot`
change caused by the processing logic for READ_IMPLIES_EXEC in do_mmap(),
so the remap_file_pages() must perform LSM check before calling do_mmap(),
this is what the previous commit want to do.

The LSM check is required to know what the `prot` is, but `prot` must be
obtained after holding the `mmap_write_lock`.

If the `mmap_write_lock` is released after getting the `prot` and before
the LSM call in remap_file_pages(), it may cause TOCTOU.

So, possible solutions may include:
1. Remove the security check by removing the the possibility of the `prot`
   change:
1.1. move the the processing logic for READ_IMPLIES_EXEC out of the
     do_mmap(). This also ensures that such missing checks which the
     previous commit fixes will not occur again(suggested).
     See the RFC PATCH
     https://lore.kernel.org/all/20240928180044.50-1-ebpqwerty472123@gmail.com/
1.2. Replace do_mmap() in remap_file_pages() to mmap_region(), which do
     the actually memory mapping without the respect to READ_IMPLIES_EXEC.
     But this requires other checks in do_mmap() is performed in
     remap_file_pages(), such as the `file_mmap_ok`(may complex).
2. Perform operations similar to updating a value by CAS(may slow):
for (;;) {
    mmap_write_lock();
    prot = get_prot();
    mmap_write_unlock();
    if (!call_lsm(prot)) return;
    mmap_write_lock();
    if (prot != get_prot()) continue;
    do_mmap();
    mmap_write_unlock();
}

