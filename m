Return-Path: <linux-integrity+bounces-3730-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5898EA62
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E20B24A8B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861B53370;
	Thu,  3 Oct 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is1GJMqA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA78F5C;
	Thu,  3 Oct 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940966; cv=none; b=gTIhyj4IZeKH4Qxl0yld1KaQzec0ufgFqf6+zSfidcFI77qNGXE42cMpWfTliRbkgXWoyNEByDdhtmx5JC1neY6J4xVIqsPtnXC3TuszLZjra8uEWBNSpvfMXRvUO1cL+KC9G9+Mofanb94F/B4td3OqhcPzxK7TskkfLyKGKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940966; c=relaxed/simple;
	bh=M7x3cWa977Oz9ozRtPmM2OrD4Iksba/Rz47mA4bO15A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfsJOA1dWYyOItyCmuBhaHOv7rTmUE7IvxKrqQmKGO0YgIdGOkvCaxt67PgZmgKzRlklzU4y7XoL5NNVDL3q77CT17Zg8iUePclvr8b1DyLRa+bSHKnphiwKBVopZb5JqTqzxLqTt+yIZQVvHsxng9GVWlEMHghJOXoU8yc8uG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is1GJMqA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398df2c871so573298e87.1;
        Thu, 03 Oct 2024 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727940963; x=1728545763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9oR8h0jcD+ASzHqwg5wRJecDB5ThsYQmaCFqLieUUys=;
        b=is1GJMqAgkJ2TwFpQ+/oJ71vMz2nu/Uerlqfhxx55ipKam7/4NRvUa4uxhiYGtcoyW
         R5IMBd4MU6G7m7/xCcfOtwD4xMt03isnk9+OfrIyBAGG7YsnDCNC45ayuDtSbu98HOh8
         YnagPHX2MmvvVbrXrWNX9iarIm0oCK+Lg7+wbFl04L7wzWQ8uX10/SNkQXnF6gioWwvS
         ME+UVodyH+8CumP9A+VamWclBoPra2JCRgnmzDuiuAP+z5Uv3SvhS4xTNOrwUqWep30J
         5nLPUp77G1hhgME9qkKOSpacGEPgB0qjS8FkOd4zq75VCjR5HfjuOJpz5mV/dRW2ugmm
         r/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727940963; x=1728545763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oR8h0jcD+ASzHqwg5wRJecDB5ThsYQmaCFqLieUUys=;
        b=bbxXvepvXuWoUwj72n86QGxU6n5IjAhDR3yDe4B6j3OI0LtVgptmn9l8HcEfoOk+uU
         5W3aEUIN3vMZ67s0whM9+TNsxBm1tYnkLboT5KzvejvwildHpIc2FIGRZVkG8r7qdq3Z
         NFi8SqTp8PCJkoVs39AhY7P88mR3JSx+R5EU900dEb0mqPeftkYZub8mj46+XsoAMEEG
         8WOGAszFifKoD4HP4BS6T4tisacUNB+XSYPLC0WCxdH/J1HSy4w2fq1NUOr63WXPttNT
         RSUWhHP/nsTll0KPHR4ntBmJsuhengztJi5zJMeGRtHlVWCOnK6S45CsbOqIPNjfAz33
         JgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjc1yBMl6SSVFgMuJ39E7c4/ySI+jxE8NShws/IucLjnVp+Ht1GXLV9ynypUlyL1JeqdVDt/kAlsR/y6SVDP8=@vger.kernel.org, AJvYcCXVg+kPLNb6NiimZ/PzsoD9RDUqi6uWteFw1iicTAZfhMSCCI4qiYHe3ybfAWWSdsLbKoJeF3FOMx5KOvUTtTCou9wccBDh@vger.kernel.org, AJvYcCXuOAgQi79LLPUuVWib3yxV+qBXwQj+oI5ep22ZxHlJANvzMRjO0vwQG86txgOy78ekDRVCVILblVsGCmoX@vger.kernel.org
X-Gm-Message-State: AOJu0YwimYxnr7bW5wGKn8BGR4IyFQqLlWYu6nDghdApvzkJeyE06xV3
	Ac3p3ThBT7nVAG/ct+RU/TD3aO9osZROy/8FTSFoxUIEXoFey5ySObhzsuwM4wvjvYAUVXHAm69
	3aZpyU7rc/XyqqrA1Y34aSkwHRe0=
X-Google-Smtp-Source: AGHT+IFv9AtG9mNjYdrEiVauqIlg0dzgZJCUwjpzJV+xaWeaunneTND2RuGD2CvAsi1FIHppDH85AjSwHwx2Tj0ajdk=
X-Received: by 2002:ac2:4c48:0:b0:52c:cc2e:1c45 with SMTP id
 2adb3069b0e04-539a0663300mr3041629e87.15.1727940962711; Thu, 03 Oct 2024
 00:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com> <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
 <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Thu, 3 Oct 2024 15:35:51 +0800
Message-ID: <CAHQche-HPzahcHea65f-caRBUSvr4WsRF5J8cqYGnjJvBNTX5g@mail.gmail.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
To: Paul Moore <paul@paul-moore.com>
Cc: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hughd@google.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	roberto.sassu@huawei.com, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

> My apologies for the delay on this, I was traveling for a bit and
> missed this issue while away.
>
> Looking quickly at the report, I don't believe this is a false positive.

This is the mistake I made when I first watched the report.

It should be a deadlock.

> Looking at the IMA code, specifically the process_measurement()
> function which is called from the security_mmap_file() LSM hook, I'm
> not sure why there is the inode_lock() protected region.  Mimi?
> Roberto?  My best guess is that locking the inode may have been
> necessary before we moved the IMA inode state into the inode's LSM
> security blob, but I'm not certain.
>
> Mimi and Roberto, can we safely remove the inode locking in
> process_measurement()?

It would be better if IMA could avoid acqurie inode_lock().

If not, then we may need to consider solutions I mentioned in my
previous reply.

