Return-Path: <linux-integrity+bounces-7232-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518AFB9367F
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 23:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382647AFBF3
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 21:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F532EDD51;
	Mon, 22 Sep 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MpKMTw3m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932328AAE6
	for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577988; cv=none; b=TVCUnyaFucQeOii9/UmZMotdIhP7jg8YiPxHFrJA87vjJL0CJtCILO+B1iULRW94fQgpsi3XGdCXHDsKdYKc/lX974Namt6VZiDGHrmNLSVQE8QzZMm8CXxOVDe8Gc90fvg3H05SNgGI+7aMnKN1jcBfrDGMzZeTQdw1k2f126w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577988; c=relaxed/simple;
	bh=NrxcGV9SRKTH90U9r9TiQBRjMm9wgcBgK/JoZCvLbI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpwihThjMQlGh5PaD+bkkwJ+Lim4ASowDVsB6xDX6gqXYXA+iroxNhRS0KcsFUN9Lyio46yPV2VnvX/4ihhSHqjLJE99k8jzVbDQcQdWBKjjbcQOAV5QHpFH/ABG4BKOU5yRlF7HJDlv44cm62MS0kEQUNUAlVAzbbFIbJoA7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MpKMTw3m; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so3581671a91.2
        for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758577986; x=1759182786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBCpPhJ55NBZXeBegJaYDf1Vz3ukosPuvPoKyErH30U=;
        b=MpKMTw3mB8cS+wLKmM8B/FN/L+1iE0pQQmRWOZVXGS4mSCm0K1pU1gDJEVuXtxVxXo
         uuMqijoX2yPKTU1SBmZueh5b+sdLN7pZhuv3kLaRjZKGkXSOAC9C6ESuyUwF7clq173b
         yJ5+EDg9rdkHiJpIiH2w8y83fZllQkrhUxph1nzJ6HHpN1IXyUdfWT5KaRdNq89s93H/
         s4E3t3++vYp9s4hsJ7Gfua+d6FrHIhfJh5A1HbKlOc0yW2LG5bobwoUgQN7S0HOCniAv
         j8qU/IC82212UsrQDCFGVWpN80TV1jKgkAsCMjorxmHvBUCWKKFn8l6dizk8iES8rIOW
         zlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577986; x=1759182786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBCpPhJ55NBZXeBegJaYDf1Vz3ukosPuvPoKyErH30U=;
        b=AW/+OojZon+tQcE0sSLYCaEG4agSLhdy/Pu3pu2v4vOswN/FwXZAt7ZYBodFD1+NCL
         Yw3Ecd5kHE3w1cB7kp6CYJ2acAOCDEewhgSXnPhuozVK0e4l9Wj4j+jrP/cQD8CfU/WC
         D9LWXgrMg3QKamUDyOpnb38MarixjTk0EtNpb1hKfPW6wy1XJEh1Qm3ZioOi2R46rOs8
         5cJjpWfo1LuGAen/y6ifRtnkwO0a9+SycR+jUdFiWe9XV9YkZSkv7cyT3edUoD9nqRr7
         vj3uQzG2/h++ZYvpaE9iE1ruUiu1nzMsCBjjJLQf36AbvawPz2/Y4jGMUeh4V2Sb56PD
         muQQ==
X-Forwarded-Encrypted: i=1; AJvYcCULNiXxflEAcv5S5BVLwj2gwktMz7rm9hNGDEO/+BS896LQwZwP6jtU6CE6xLvhHJn66xgmOzBVzaHt38uwbUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmk6urw+3fRq6S1axV+piu26BIVk7GOVUdoh0hWxP36nRVClxQ
	CQc9g++11Lr5/nxVJWNLaPPGU6m7jkBSx5x9TIab/J79pbjW62yDILV09rb3UV4bE0Hy17MHiWv
	cG4GSszFaYxarRZIwAJ5qqno6PcfrhI34zwNNFIRE
X-Gm-Gg: ASbGnctWz89GhoqorDmwCcyEGZsKuT52Fkz5Sp/ccCeXMLf1jUJP0Vx1asQChN0cTuP
	2jwULph5ee11AScHIXPoN0pNFAqM+I7m12457hUye59rxWo1DEA+K5Iv/6EbBq6WRXAUWsGxbK/
	K28UTxSc94YgycwpIhpAU4txSLPWdp63kOX6Rnhgtj4wjloKe2wI0HiBWQqLfngwVjlLR/XheU4
	IB08lQ=
X-Google-Smtp-Source: AGHT+IEIQWA5rKW43P5Fcmt7zmtt/MYBDfabS+vBWJKdvNBhoSvEK2C+yUTl6EB3o0bQhS1oiKlOiaKg1oXWzn0OcwI=
X-Received: by 2002:a17:90b:540f:b0:327:734a:ae7a with SMTP id
 98e67ed59e1d1-332a92da6ebmr455889a91.11.1758577986004; Mon, 22 Sep 2025
 14:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916220355.252592-36-paul@paul-moore.com> <20250916220355.252592-47-paul@paul-moore.com>
 <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
 <CAHC9VhSOhaB86yEV0+2HWRc3oYgZmLX+Nz3ERbohGRHeroKThA@mail.gmail.com> <63cf73f5ed8ceda0d68df416c2ba18334e7a9b83.camel@linux.ibm.com>
In-Reply-To: <63cf73f5ed8ceda0d68df416c2ba18334e7a9b83.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Sep 2025 17:52:54 -0400
X-Gm-Features: AS18NWCouzv17lHS4hgSMPjWiUR_MwHmSY1fDXCtAlsYtCf1VWHhUgu34JpGZtw
Message-ID: <CAHC9VhR94kuqcwP6DcdG+QpcruU8dMnP55CmTXiQ-k+u5yOT1Q@mail.gmail.com>
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

On Mon, Sep 22, 2025 at 6:53=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Sun, 2025-09-21 at 15:23 -0400, Paul Moore wrote:
> > On Fri, Sep 19, 2025 at 3:16=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > >
> > > On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > > > The LSM currently has a lot of code to maintain a list of the curre=
ntly
> > > > active LSMs in a human readable string, with the only user being th=
e
> > > > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > > > generate the string on first use and then cache it for subsequent u=
se.
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > FYI, checkpatch.pl complains of unbalanced braces, otherwise
> >
> > Looks good to me?
> >
> > % stg export --stdout lsm-lsm_names_cleanup | ./scripts/checkpatch.pl -
> > total: 0 errors, 0 warnings, 139 lines checked
> >
> > Your patch has no obvious style problems and is ready for submission.
>
> Try adding "--strict", which enforces
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-b=
races-and-spaces

Ah, yes, sure.  FWIW, I view checkpatch's findings mostly as
"advisory"; oftentimes it can help catch important things, other times
I think it's kinda silly (and no, I don't have a list of each, so
please don't ask).  I often tell people new to kernel development that
it is generally better to follow checkpatch's suggestions if you are
uncertain, however don't be surprised if a maintainer prefers
something slightly different.

For those reasons I don't ever bother with the "strict" checkpatch mode.

--=20
paul-moore.com

