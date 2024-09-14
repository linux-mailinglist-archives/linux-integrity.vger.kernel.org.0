Return-Path: <linux-integrity+bounces-3584-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E4D979030
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585DF1F2113A
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C731CEEB3;
	Sat, 14 Sep 2024 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="T7LnGA1f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9D1CEE8E;
	Sat, 14 Sep 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311544; cv=pass; b=g9CzG4UVRBZu2dBJi0/zace8N9TtkRuHLVojpIIMKA6+V9F4wFQ5u6qpZlAObZoPpNNuf3TdJ9F0FkIBVhcwCSbzkXbXPvg8bj9d+GAhMjMthgLCnKW1K/kDvYhupDaYl8bPAAmf82XMY87iz/Db5ubv8fFbHbtCtYZ4G9TN39E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311544; c=relaxed/simple;
	bh=MopOd+GgFp2V0/yGn2I6vzv3wFMcNeqzp3sbBMr+yCk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dFLAr/p1FgHb/iUGjZfBQXO4JBbvzpTR6awTCBvsHO6waE/d+JaEaX8JFyHeJcGwJdhy76t4y8emeUWwl/s/hbhBPwAwpKBTF0BLUsziGEAqPG1gj3HyOmlcKJCIQLJ1HAsCMuGAOi63Jt9FGTbxQdndHY9E8bYUYI4GU15Al0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=T7LnGA1f; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-106.elisa-laajakaista.fi [83.245.197.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4X5Spr2qKxz49Pwm;
	Sat, 14 Sep 2024 13:59:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1726311541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MopOd+GgFp2V0/yGn2I6vzv3wFMcNeqzp3sbBMr+yCk=;
	b=T7LnGA1fsNe0UyNOLDQbuCj14Djh1g3PsiwUTb9ZYyt14ki1LnLaLYygDLLyGpuw5iDrt2
	15Fc9vSN8ldGouw/YDxmzlHNpOweCG5kapkdFhICbp9arJ9IIORkWlOrf4MM/upTRIzwGv
	WYkYQak7TV1/ED6ZHulilm7TTQPTJJ4k2fgT4nSdFi855zVNubg2CRi7yMmKPah5nTztKp
	QaIO4w/cs6sSuqzueUPJdxfHRnCz7yMQ2V0S7gPfA9TN/tyfLgbKcpC/jDXiCV7QFO96Rx
	KEOBcKoPQuwZ5aaDgZTeGRJVugENX6Bsyt9BZ20P61vR86v28ptXr+bAYr7g5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1726311541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MopOd+GgFp2V0/yGn2I6vzv3wFMcNeqzp3sbBMr+yCk=;
	b=AaPQAsNbFrrayXOMMh3W2cV+2j4HMMOHkkpsATPhwxjgmG0+znldXwETrkE3fH2n36hkgz
	rjpVt+wHCgnXApWMbF8nLvqCD8ww6DJ4IKD68ebtxeWlGOhmX+nEG/VN+DnXEM795RQ25E
	f7qFgDcUaVdFl+nUwlXy4wnOxxAcu84eUHU+MvWbpixpzFomyzyo8jyorsHBtnY9rjt+2/
	IaA5IDtYGK0ucDT4IVt/WTdQneO7LhdBLUpIO2RwencFH7S9p5Yw/IiAZ/S/imuTgRw00s
	LiFRLzRK6NugUrKPSjdbHAX6eC3Cp/OWSefms/wVNDJaP6XMPa0SOEStsstI5Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1726311541; a=rsa-sha256;
	cv=none;
	b=qw+H+7CTKU39L3V2xy5KQH91gwYvSLFc+l7+fAi2ZZgAsLpNud9V9NsueHFD+RbT54rchv
	WTLmZ7ARsd7YZWAV5yD1idPguqB2P0L0KkFjQrLHW0ExilVJ5OeQOH8eia4DRJPyfBh/kV
	bc4tnHKLqvSuaT7vqRaZ8tE0ft+QfG2BAzJW/e/bKigB5+3e4DQ2IQ8NMrAYVl6pCdp9HB
	Mdh+UV5bRlUeJ8pCGNmJOoj3lwBHSh+yLBznO77RLPZm3cvl7gBiAFzsLqRDUKWkPIr+18
	uWVyX30ywNsvL8ATvR26A3fY/tI1De6cjQgWuONEztAY5UB4Tataj7RPqgbMVw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Sep 2024 13:58:59 +0300
Message-Id: <D45YD8TVSHUH.227AS0RCL2DP3@iki.fi>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <10ae7b8592af7bacef87e493e6d628a027641b8d.camel@HansenPartnership.com>
 <D45Y0H3JRIJE.3LIRI1PEDTJE3@kernel.org> <D45Y78TPNUC3.VPF1BWS5EI0Q@iki.fi>
In-Reply-To: <D45Y78TPNUC3.VPF1BWS5EI0Q@iki.fi>

On Sat Sep 14, 2024 at 1:51 PM EEST, Jarkko Sakkinen wrote:
> On Sat Sep 14, 2024 at 1:42 PM EEST, Jarkko Sakkinen wrote:
> > Please address how this discussion is related to https://bugzilla.kerne=
l.org/show_bug.cgi?id=3D219229
> >
> > I just read the bug report nothing about IMA or PCR extend.
> >
> > There's now tons of spam about performance issue in a patch set that is
> > not in the mainline and barely nothing about the original issue:
> >
> > "
> > When secureboot is enabled,
> > the kernel boot time is ~20 seconds after 6.10 kernel.
> > it's ~7 seconds on 6.8 kernel version.
> >
> > When secureboot is disabled,
> > the boot time is ~7 seconds too.
> >
> > Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.
> >
> > It probably caused autologin failure and micmute led not loaded on AMD =
platform.
> >
> > 6.9 kernel version is not tested since not signed kernel found.
> > 6.8, 6.10, 6.11 are tested, the first bad version is 6.10.
> > "
> >
> > How is this going to help to fix this one?
> >
> > I say this once and one: I zero care fixing code that is in the
> > mainline.

"not in the mainline" (oops)

>
> How do we now that bug is anything to do with IMA? I'm having a weekend
> now but on Monday I'll ask the kconfig from the reporter. I think
> important thing is to then revisit how many times the session is setup
> during boot and make conclusions from that.
>
> It is plain wrong and immoral to convolute a regression with marketing
> a new kernel feature. These topics should be brought up in the topic
> (i.e. patch set comments), not here. It misleads everyone.
>
> Please explain me how this is going to help the reporter in any
> possible?=20

I will check the original reporters kconfig once I get it. Based on
that I can reverse TPM call sequences. Based on those I check if
anything can be orchestrated.

If this leads no results I just send a patch that makes the whole
feature as an opt-in kernel command-line option and call it a day.

I think we can the full next week timeline for this not going to
hold longer than that.

Any comments that are related to Roberto's unfinished patch set
take them elsewhere.

BR, Jarkko

