Return-Path: <linux-integrity+bounces-4492-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1419FE2AF
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 06:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6481617A7
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 05:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA090166F3D;
	Mon, 30 Dec 2024 05:48:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D815DBBA
	for <linux-integrity@vger.kernel.org>; Mon, 30 Dec 2024 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735537684; cv=none; b=FuYlTfhwQY00eu6gqsocTONYYDRlZM3ju9qbYbsbkTUFUzUe87tuAddApaS7NSzQN7BLZr15jAp+kV8GA+tqURbg04fOGpr5iS9sR8fXs85bC00fNg3SKvMIiYjMKzU039MfF2R4B+m+qP9HG0e45yP9dFMb1ua7vvY3WTDRUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735537684; c=relaxed/simple;
	bh=X/pTaxeY9uxzixcgUNMI8spaGnMaud+VI8PLVKwD3QU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RHdaiuX/afG2E6ajDy1WWnq1116byk4+JUl9/ARZXeS9FfGXAgCteFzL1ME+ZM02YiQFvDqBDoyMFx0DMOM7IOFuyJNXUNxJZEOjW2P2ED0nKNyx6zG/Gjj9HNsUay8RQIlG18cQw8CUWFZh0ORZFY1+mnET3nIheJe4KCJ//Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844d02766f9so756331939f.1
        for <linux-integrity@vger.kernel.org>; Sun, 29 Dec 2024 21:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735537682; x=1736142482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEn0TNgC+Egj9+u1OPA67mOeXDAmTFT/Bzf3azKUXZE=;
        b=Ca3cPW2AfgU0WmPZ3m+jlbqpaN1pI3roZT3FDiHb7oc6qepvim1To2C4amGr5HbStl
         qABqJB9ei9xSvP4fQjv3PoB+Yz/YCIbZFDFuKOvVcunyjWQ1zgq/AFjzJoJciDSfv5DV
         MC1Pj19DwUTCKsvlzRciKHyQIiqZtRm+1stgH80P1AJTomj1d31dO6QHPw66HlXeOEbR
         8jn3m4JbeYZZwgFJn8da4aWFDzK63S1x7m15JWGqktu9PW/7LoKvv6Aj2fEAy75P8hoh
         PXH7Rt/KtRXW/LrrczgHxRQzpKhvJ9t4YyJ5ZGEoyPuzJCrrs2sBaYZydMRJD8EeEQh2
         NOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq1Ile/dSZf2wLppo0dI0cfAKN+NG7bVx1E1WPkCthvA6rgVECKkIzAr7GiJ3Skqws8pX+qlrH9LuhG5OlWIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLj83VDWDLcrrB91K/fEKPxBQzWzlxp+xr+yfT7O1I9HT7xj3s
	cL7+xFQxpYizIopbrnPW5k/T8PuNVv3eef6bGjQuFycXPD9RHfg0zAU9hnnUUktHoVeh+JtaAU1
	2sahjiBx+l3G/M1NHlUzUozJv9Pvw+aDJGa//dm2YhXYnN3fMeSCU1yw=
X-Google-Smtp-Source: AGHT+IHNSi+yiedUS+vS8rNLSbjMlJ+TTOLzwjGT3CV4B+A5XArc7fz0pVC+9I6xjxqhhAqh1llINQUlH7F7e8BJC+NA3MUyrTVG
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6004:b0:844:caac:ad61 with SMTP id
 ca18e2360f4ac-8499e6c4d75mr2967592739f.13.1735537682521; Sun, 29 Dec 2024
 21:48:02 -0800 (PST)
Date: Sun, 29 Dec 2024 21:48:02 -0800
In-Reply-To: <PUZPR04MB6316D814E4CF26B2A62EB24381092@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67723412.050a0220.226966.00cf.GAE@google.com>
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

commit:         fc033cf2 Linux 6.13-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155a6818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162126df980000

Note: testing is done by a robot and is best-effort only.

