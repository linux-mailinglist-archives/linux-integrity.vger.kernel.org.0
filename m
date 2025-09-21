Return-Path: <linux-integrity+bounces-7214-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3FB8E40D
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 21:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8753BA02B
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670F23D29A;
	Sun, 21 Sep 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ql3SP0xd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD2221F15
	for <linux-integrity@vger.kernel.org>; Sun, 21 Sep 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482595; cv=none; b=G81fZoggxqQQgCcawR6kydyPuvZp6PQG84hJ19F1pL48Bhanrb6JukZl+MUwu0RX2EdU5KupypSY91M1+M8SHz/30daC16xY3LlNSh6p0f8iHsfFAgNvrbXY4EmMzEqEZ64Jb7yjxJKKLxNXaX+M6AxnI8/IQknaW7Qlu0nAu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482595; c=relaxed/simple;
	bh=zLZm2FgE4O0YYFCxnnlKENyYOeEJXDIvxEM1W1Wmm2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXQEn7WFWL9v4T17l5qTOhXJdbIZO6H7M9c2zqT1g7ybwB33VAbU7/Tgt5j+gghlYsjr+IqjAGhYPFzHfis2phpeoThPRv55rKPd5SlJBzPPjPDWJgHi+Djcm5w6zZNVOZ0Dh/6qj0A1XECXeXs/48wRdW4AGECO0eGGKQ1E6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ql3SP0xd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so2925449a91.1
        for <linux-integrity@vger.kernel.org>; Sun, 21 Sep 2025 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758482593; x=1759087393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejP95JhTFso+EjCzhC/+xR4WsqrG0IwVs1drcrs6+RE=;
        b=Ql3SP0xdL/hIgOz2HjGqF2XJ/+Z35VQM+IHDX5lVIE7XhkbUeqnGGLR8jptROnDRiF
         7wzAFcpw2D46JkB7Hebq+pfVQ6R3Dc5iLsYs3noPceTNxahFd5w2DKeQJHEFJPC99q1M
         C8eUFEVBX6Ru1mFCM7YpKlOfybwZz6bZ3P+nA+9/JtB7zXl5eT6Up/HuT5gPQT6yiXl0
         i9gy4c8rwqkE27IjbizKJeNGNslONlSDdcxtONwGz4+r0PixIx7lWuEKWVi/0nc0TioJ
         nJ+eff6H0HNcR6QpOx+1IzaxFGH+3rO8n3Nrb/ygjlsBp8uM3o6UsIKCPMWiuFoWseyU
         j/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758482593; x=1759087393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejP95JhTFso+EjCzhC/+xR4WsqrG0IwVs1drcrs6+RE=;
        b=WvGiE4MqvBbfkN1bdEG5S34+yiSjb8eJRgQU6+hr5Qk2PUalMJsy+kllbTf/H39UfY
         ptPAEfedI1WyJx1Q8mpJPOtACxT2eSzqYozqR6MIJ7QUiaijXqSuVnOc62goC7d9hsfr
         mEdS3OOH0zeBJ/7H0OzcEYz2TmNxtcHnjcd75uhHjX0nCs2TPYwuluiJvUQ0X2Ei4nri
         Gm6gP8x/PUlJv54XGYpWBTuUi2tbfjMTi/r75I9GRLVTpqfg2r/2Q7EzExKh0KTHTWN+
         38nQ96c9qoYtDKbMgDRQhbyHryrSRKWS8a8UmC4/aI7xF9ssIaA5/iYUyJrMO2zPhm1t
         FDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRCrzkzvmNLWyUKPbzgzYk5d7yWnLmbO6Gbk0TBGuefi9GANfcm31vzXtqm/jrLpR5WSwYHw8dbCdCgUu7EBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9c5U4UMfK48m8Ccm4L05vtqsu2LIlWWyZzTUMzdjzEpQNbiXD
	bL4hQOwy+MPDO0UdoGGWrM3kGkAVK/F5egkJCFNy6Qsewo8kd4AYfxdplF2Pl+cav1/OoKH7mVz
	1A+HVlO4h2Wt5dFyEwm6gomeRgQECMx+GFjkd078u
X-Gm-Gg: ASbGncuPoaxNnfsS197bBAHvydfxEYcavhdIr5nLnCTpbp5m1qjwsELft8MPFyQqKcH
	kzoeJAU4JyFjQlMBK70zT/zJggqCMI9D3eygOHFe0VKO/enNBsBK1kyqSkHpYOTm5XNQTD4Uu5o
	wNB4xx7e7tf5hVdlX4g6mHiZsQCBPvJZnIxOmc2WcqwTW6833QaapD1q0/lNggS/70/3+JEJcD1
	QTTxYs=
X-Google-Smtp-Source: AGHT+IHXhcLkRhAm67NgddyngyEIqPvNnk06vbCHqpqFsCVyupjnItG+4hoPBhdKiQIQbiQv7gdx/QcSiBDizlzfeWY=
X-Received: by 2002:a17:90b:5623:b0:32e:ca03:3ba with SMTP id
 98e67ed59e1d1-3309834c0afmr11873963a91.22.1758482593127; Sun, 21 Sep 2025
 12:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-47-paul@paul-moore.com>
 <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
In-Reply-To: <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 21 Sep 2025 15:23:00 -0400
X-Gm-Features: AS18NWDmwzVP09o3NHo4I0wry9IMJ1KHEvCCSo5QOX7Cyiha1nfbdeqh7GS064g
Message-ID: <CAHC9VhSOhaB86yEV0+2HWRc3oYgZmLX+Nz3ERbohGRHeroKThA@mail.gmail.com>
Subject: Re: [PATCH v4 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:16=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > The LSM currently has a lot of code to maintain a list of the currently
> > active LSMs in a human readable string, with the only user being the
> > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > generate the string on first use and then cache it for subsequent use.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> FYI, checkpatch.pl complains of unbalanced braces, otherwise

Looks good to me?

% stg export --stdout lsm-lsm_names_cleanup | ./scripts/checkpatch.pl -
total: 0 errors, 0 warnings, 139 lines checked

Your patch has no obvious style problems and is ready for submission.

--=20
paul-moore.com

