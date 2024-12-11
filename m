Return-Path: <linux-integrity+bounces-4342-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E088A9EC305
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 04:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBA516160C
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 03:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A730E207A0C;
	Wed, 11 Dec 2024 03:14:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89C1FCFD2
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886844; cv=none; b=LlNwxMiWlNZobxC5fKTEDKfiH4SBuFk0ctjGoikV6AughTi8OGWz8vicp4v8njjLdav9fDdzku4Et6LZvYiw9DIB98YaQBt4n16tVw+j3xY4RNScSfdAKN/MxZDNLo1tY70G5TriWcDa9Fv5HA4LsWPLJEQi2IINWjEofYV/QzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886844; c=relaxed/simple;
	bh=uNdsxOh6w/4q4YhOO6WgmJHWeXojlmXswW8c1T2NVtE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dJbNnVsboPcvRM7WR/AlVECUwYWR9hFooMJeQuHoAC9X+gvwqD6T90li8KthatLLkLNhaW0friJ1o0V7yM7hO6J93smXX7qizpttiGyD39cKKQxLQGNyGW0x7d6lR5sqdeobEHGb6+/IZMwIFhbn1y+E+TxB0+zkrJgET0Z82z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so29366085ab.1
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 19:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733886842; x=1734491642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0W94+kQ3tRQ+O3QZLf8SyKmRW6RQEhoTIJ7U4RDgHI=;
        b=XfM8B7xGgeZluNQFKIhuH5mbQABGsVbleWCUffbLJlTpslIx/HjnOhNloaBrg95f7W
         f9SGYgJKXwEz5pyC+X9z8AaWrroivMGBR918VWsp/gG36TGS9UOvLfp4KfQccShoXzUP
         4XF9u2tLZD59rq1yE2RstfE7fPgdImTmrpcK6/Iass6EE3ANnB4D4AZitR8t9BGbvnhX
         /9/ABpFKQPja9RanoCyDSUXzB+T800b8NUgNEifhoyuIaPVbN8cjA5da0SKHkGLaivSk
         r0FZkXl77RIFFxk54MsFkbMnoUgkjdMLJIqNJOEsggbRPKA4sCtdnzEznqpyycCa5sPM
         iRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYhpT1hF0XNPjeIdNILPtvvbqDSGcc8S5XBScMCnnGuLyQ+vbMMHAsvFQ1H4epUZ5+qGDWzGbkf6N402yS1aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5X0uKSItd5zKWAuTPnpWl9Eop3X0666WGrOGPuNDHbfHBPoVf
	2VqoWqO4u3bwMEahaL+KNrSU721nSkppTDqG+W8Mg1/T4nfaZosY+0kWE04VVrA7Lq70/pdvrVU
	MfNBfiqxnRQqa1minmEGS7Z/JZpuLwT7qNNTwkPUvYkFoNM3+BEB1Xk0=
X-Google-Smtp-Source: AGHT+IGIjOZIyxdMur+PVZfSAqXCP92gYPE7/Et8+cFS4YQe79jNleZ88XKKmsCw4p4nuoFGSWy5higCF1W0Wiq3ByYVRpfaL8pK
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e08:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3aa08f66f18mr11666915ab.17.1733886842313; Tue, 10 Dec 2024
 19:14:02 -0800 (PST)
Date: Tue, 10 Dec 2024 19:14:02 -0800
In-Reply-To: <PUZPR04MB6316E053BBAA0B434A32A147813E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759037a.050a0220.17f54a.0003.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com

Tested on:

commit:         f92f4749 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12034cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179da544580000

Note: testing is done by a robot and is best-effort only.

