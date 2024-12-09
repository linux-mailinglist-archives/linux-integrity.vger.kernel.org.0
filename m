Return-Path: <linux-integrity+bounces-4320-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9509E99DC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2024 16:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6588D282BD0
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2024 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A791E9B18;
	Mon,  9 Dec 2024 15:02:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512001C5CD1
	for <linux-integrity@vger.kernel.org>; Mon,  9 Dec 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756525; cv=none; b=ccGIcHGM/3ZR6EvpuGYdhHIG0w9Rv4g40UMzwSdHern91aS91QzwwAH6y2N2uupY2xtsp5uXuqIkxdk8x5QQKje5OBeI5Wi+Z6yWMS7kafEa+5p4/n0RTO46VUEnUbKlDtFbo4bodhMMS6Qcqlu1DbO+7tBACOZqZEa+zOyodak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756525; c=relaxed/simple;
	bh=B9vCo6F2T9+u26g8w2gYtFYxPMZXNfMUdvNWm9sd/3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iLeM45ym376lz7eYCHGaUdskwfQV0GFSec2mBXpvyw3Mni4xdP7lAoo4n+Mva3DGm2JwtVXzhkITJkIsHLEWTf/S0cFN9bp36m4PUZxvQ8PRl7sVUW+JNo2NFsqKl4VyIxlMP2fcW5gEZMtmE17DiyJsVRj7J7GaMzPwcqZ2I6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841a54a6603so822601939f.2
        for <linux-integrity@vger.kernel.org>; Mon, 09 Dec 2024 07:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756523; x=1734361323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7dxMIMKDt3gcnaZaUT4OJRPNLlt1pmTTMSZqablmuo=;
        b=aFUSuY8Yw0/jvn1a+Ds9sPiYx/Ai2VTJ0WCKcvNinttw/fttYiBXPYsXEdhG1NKMgr
         1oQ10QjSMqInCyEmEUUdr956/HBTU4TpqQS61OLTjm99L23QmgYoJTyHJiDpzastTB/B
         EruLK6/x8A8iOUu4Og7rGZl0k+4kerRA0gg8Lswg/FcbjoXa6wkvPWT2ByAzUVMn11eJ
         nMAtXXRO8iNQKfBiOb88YBYF/37Nr71N95UhDL4lEglIMjdZHJZPThqBAS6gl3iswR7H
         Iwyz463MZhIZk1AH5W2Xo2McSXIi2IJKTanoZvSdA5JqNIKhQb5RVZg8HSEPOba/hlNs
         Fy2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjYP+n7eBnBFvHjNsinwx0ZRLXHROIVAvYtX6WkmWMCl4g144icztUZIfy6jmAbSZANyDLvayVdtQP+PugTdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtkDvMpSwCPjPhl/4YEBzNgu5HDMOEZWumqTfFE7uBVcq5jD4
	ej5h81Mp42WxfYF46o+m2dWAFzRNVY+ZQ96LzKJ35YihMGyismuyqP7JrAci54iL47JHy6JRpJJ
	iC3LxHJK5S9kZpEwlg1nbPpLY4Kz6emV9KvA8sF8RzUZsLtfY6A4y234=
X-Google-Smtp-Source: AGHT+IG5EZZkKQl19WgC0D4C2LkJ6p6XjW5sCN2xk5PuMegB5QYhkucX1Ulr+XYUmcB3kitlouArvVWSFe0dfVvl6kteP9HNI4Vr
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6001:b0:843:eaee:287a with SMTP id
 ca18e2360f4ac-8447e3e4383mr1406808039f.15.1733756523454; Mon, 09 Dec 2024
 07:02:03 -0800 (PST)
Date: Mon, 09 Dec 2024 07:02:03 -0800
In-Reply-To: <00000000000065deef0604e8fe03@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6757066b.050a0220.a30f1.01a5.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hpa@zytor.com, jmorris@namei.org, 
	linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mingo@redhat.com, paul@paul-moore.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, wataru.aoyama@sony.com, x86@kernel.org, 
	yuezhang.mo@sony.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f55c096f62f100aa9f5f48d86e1b6846ecbd67e7
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Tue May 30 09:35:00 2023 +0000

    exfat: do not zero the extended part

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15275944580000
start commit:   b5f217084ab3 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17275944580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13275944580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126a8820580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153e70f8580000

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Fixes: f55c096f62f1 ("exfat: do not zero the extended part")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

