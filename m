Return-Path: <linux-integrity+bounces-4395-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA09F2A28
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2024 07:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB627A206F
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2024 06:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243E1C878E;
	Mon, 16 Dec 2024 06:31:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B9156F53
	for <linux-integrity@vger.kernel.org>; Mon, 16 Dec 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330665; cv=none; b=azJrfvaJ1A215WOtP/m9o3H4aztXSJQ7jK2sYuVicEy/YQpdJ3cV5nhzNfpg+UrqGG2OdoxwYtV7caz4tIrFEJfJ/d8tjJ4Ay60Q1eff8z4MmXg1/GlMYKPhGlpO3M4i496gkL8F8RrANe1cB7iB0XtOR2IvYlQChinQ3MeqTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330665; c=relaxed/simple;
	bh=3E2pDLSWpHz+qKRsyOCvMIVk3xBO/le3IAkheabOoFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nadFhiYCPPafablJSb9eWzgcHitUitj//lh4rP37NxOGYpu02RSIfKGKQha+oEJsCb8VKjOfqTXIV7/5UMIrd8vtCdeDgxUhQgsPP1jP2r4QJjo54TB4WfPa4CZVtguehPDjL8pXfMawi4NLtf1rYw5huMsdbCcfK+l/KDVGQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9d195e6e5so38649675ab.2
        for <linux-integrity@vger.kernel.org>; Sun, 15 Dec 2024 22:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734330663; x=1734935463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGgwY9doc2BDYdLeq+Akm53OqV4dukJ6miTwWudPyro=;
        b=flYCSz/to1YBxWcDD5pfyfUta0Im22U6qwi1nI5DOX9wJQzN5sxFrYvo+nNyAi3HBB
         5UT9YTDevDQXIwe89/9TeESHH/OM1nV3kQ0CrxDEN3XOOCmUImqdx3e+q1QbQb6/PYVc
         Jz5upsfHrJ+rtHr/pBmDE18+x6+TVxU7rTe51lXw+esZyVAx24A4aYXFmkwKK8yZ1DIl
         AQCo80SJVqNZtANvbkKomrlCmnwipgKi2In80reZoabP9T2BKJWoDQmBIaKMq3n4GWBf
         9q6wyBec9KnB6iMxqOvSr+dAbzVQKi6aqMXWXetub1mYQ77SieEzeFJv9OCY7j5yDZ07
         Ufdg==
X-Forwarded-Encrypted: i=1; AJvYcCUXssqMrtB0JFqOZuBqfTX+aWLgdP3iLt0XnhKUVBdRLMdhn8djyLXbzchr8UMkBXZ4Rg8Ko9JxriT8lRUOz4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnG6i4dmM/PyrH2Uak8en9sQdy1/R9UY8Fw4M9DVc7S43Y0G8
	dofazNNsNvnF/XdRMMsX8BRvKJO9aS9qDphtO+TaLcfldcJPHinPDvxck9c4gMGHIxvE9S+W8bz
	smcyTIpMQKO0yzHMIx/A80q2gG3wQdB5eypjZwJfShjUzfIrQKtvqmnY=
X-Google-Smtp-Source: AGHT+IHqyW8xz9AMDJraQb4QIo+grq8CirvIaFyaiu/OxyxIYJNdfxD/b3iOyQaCcqMOivRLvs+i9Vhs3cxNSZWzH/wAGnEz188Q
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cd:b0:3a7:e592:55cd with SMTP id
 e9e14a558f8ab-3aff086d9admr103467895ab.14.1734330662864; Sun, 15 Dec 2024
 22:31:02 -0800 (PST)
Date: Sun, 15 Dec 2024 22:31:02 -0800
In-Reply-To: <PUZPR04MB6316F684BF023564B7DDD812813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fc926.050a0220.37aaf.0116.GAE@google.com>
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

commit:         78d4f34e Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11259ed7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe704d2356374ad
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105d1730580000

Note: testing is done by a robot and is best-effort only.

