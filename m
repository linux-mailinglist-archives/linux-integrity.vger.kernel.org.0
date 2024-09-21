Return-Path: <linux-integrity+bounces-3655-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8E797DDB3
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E18E1F21984
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D58155CA8;
	Sat, 21 Sep 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG9mNQC7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE326AC1;
	Sat, 21 Sep 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726933216; cv=none; b=r/rnQMAZ7JeVa4xyipwUZtlDGC1bRgwRFBjiwOVtFB/VzZwid80y8TbCwT6I/viRF0oVki+8QhZuK1afpPDXHXjo0Bdggur1/Pbwf1qn59p/TdbkkvdC0f5vmidS98YWeBYLzVEOEVMBgQeAAeCBSuyD6HF2ZcdOUbeDQrtZkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726933216; c=relaxed/simple;
	bh=4CxDI76mPU+av0PlDueKI0ZftQmM4Hg/wO91AfGb+BA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PtlP3vk+um/EU/6DVebNEGjGeYMOvmnqVBncZnnUjh14rEP1pvQXSjC5e6honFtHVy5epkmuT0QfeMq/lRwjylu4t5cyXBnwXand1TVw+jKP+NiMo3S9+cDHWhHtb7U1yfvilIg2qmgVObQc1FPF5cFQdpdHhzkK8XtyMso/q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG9mNQC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0FAC4CEC2;
	Sat, 21 Sep 2024 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726933216;
	bh=4CxDI76mPU+av0PlDueKI0ZftQmM4Hg/wO91AfGb+BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lG9mNQC7KEW0nXIn7zBz5m8fkpiHVe3caQ+vTqDQ94XVbQ/227S55P+MKY20GpX5H
	 4KU0o3f7qzva6l/UwbINxrjW5n1l5SrmdIDrv59UyVxsxuQWkvJ0Hh9Wbv+8mvn262
	 lntcnMyG4rNTn85JvYEliF9w8Qb4bCABaP2LOGEJZFdqPBJYulocBOBVVNYttNKIkP
	 /Fe8mTztkd0KlQcnpwaC186EHifE2hVJpWg9Ben3t+BAaWaHM94zeWFVf6ICM7gZ7j
	 xU+In4yGI/PJ/pGC9NJRpTMfhfQ1DuXi+qGSERgGBbCImYeJO/sidvktarMkrJHPZL
	 I5+N4x5jDYB4A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Sep 2024 18:40:12 +0300
Message-Id: <D4C2QDK9WGUH.KQCJ19C43ONW@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
 <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>
 <D46RE2BWMGJ4.25VA7IVYTJ8MO@kernel.org>
 <D46RWPQ211ZS.12EYKZY053BH@kernel.org>
 <0b22c2c4b4a998fb44bb08be60a359acb9ecb8da.camel@HansenPartnership.com>
 <D46XX6HNU686.50X57ZWI2GUX@kernel.org>
 <7586c7e6e6028a734a8cac3d4b1a8504e6cd4b21.camel@HansenPartnership.com>
 <D46ZV5RXW7Z9.26N1IRXNRLV9X@kernel.org>
In-Reply-To: <D46ZV5RXW7Z9.26N1IRXNRLV9X@kernel.org>

On Sun Sep 15, 2024 at 7:22 PM EEST, Jarkko Sakkinen wrote:
> On Sun Sep 15, 2024 at 6:00 PM EEST, James Bottomley wrote:
> > On Sun, 2024-09-15 at 17:50 +0300, Jarkko Sakkinen wrote:
> > > On Sun Sep 15, 2024 at 4:59 PM EEST, James Bottomley wrote:
> > > > On Sun, 2024-09-15 at 13:07 +0300, Jarkko Sakkinen wrote:
> > > > > On Sun Sep 15, 2024 at 12:43 PM EEST, Jarkko Sakkinen wrote:
> > > > > > When it comes to boot we should aim for one single
> > > > > > start_auth_session during boot, i.e. different phases would
> > > > > > leave that session open so that we don't have to load the
> > > > > > context every single time.=C2=A0 I think it should be doable.
> > > > >=20
> > > > > The best possible idea how to improve performance here would be
> > > > > to transfer the cost from time to space. This can be achieved by
> > > > > keeping null key permanently in the TPM memory during power
> > > > > cycle.
> > > >=20
> > > > No it's not at all.=C2=A0 If you look at it, the NULL key is only u=
sed
> > > > to encrypt the salt for the start session and that's the operating
> > > > taking a lot of time.=C2=A0 That's why the cleanest mitigation woul=
d be
> > > > to save and restore the session.=C2=A0 Unfortunately the timings yo=
u
> > > > already complain about still show this would be about 10x longer
> > > > than a no-hmac extend so I'm still waiting to see if IMA people
> > > > consider that an acceptable tradeoff.
> > >=20
> > > The bug report does not say anything about IMA issues. Please read
> > > the bug reports before commenting ;-) I will ignore your comment
> > > because it is plain misleading information.
> > >=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> >
> > Well, given that the kernel does no measured boot extends after the EFI
> > boot stub (which isn't session protected) finishes, what's your theory
> > for the root cause?
>
> I don't think there is a silver bullet. Based on benchmark which showed
> 80% overhead from throttling the context reducing number of loads and
> saves will cut a slice of the fat.
>
> Since it is the low-hanging fruit I'll start with that. In other words,
> I'm not going touch session loading and saving. I'll start with null
> key loading and saving.

"my theory" worked pretty well. It brought the boot time back to 8.7s,
which can be explained with encryption overhead pretty well.

I'd suggest reading the bug report next time before solving a problem
that did not exist. We care about users, not unfinished patch sets.

BR, Jarkko

