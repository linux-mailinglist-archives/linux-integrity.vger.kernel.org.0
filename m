Return-Path: <linux-integrity+bounces-3580-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED547978B2E
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 00:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F473286FEA
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 22:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED2154435;
	Fri, 13 Sep 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzGDzkUi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D402F860;
	Fri, 13 Sep 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726265193; cv=none; b=LN2JIbTVgsB+6Xn0kWifHVvMEOr+ms3OjBnETz0CKD3/dcR6eeXkswJxJYjv25uX1vzYNsQ2fY+Xflmn7wtAeKV/C6gSU9bWD0QyyNcsdsyZgKbY3NGBXdHgj6cJhCJgDcMDr+7WQMMnDm7IRDu2UEIlfwUFvytRFXrdLf75FcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726265193; c=relaxed/simple;
	bh=OIOoMQzoCgZxzo2kXHIadr8YEc/Wuuwq+XO3aobvV+g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=vBHZhPzdfUszSGcOX9M7qa4C97LSWmwt34r/T9/5OdDZkWzpJ8eNR8gmdvVhY7g/EQztN3t5WBeHHLfGO3yl8elY0ntmL7sw5CixEDgHPEgT1nOBkpqNk78OEx7gLUIwfi+MQ6qv45HCX4tipCLyJqixKmZmkDAkgrPVAzj+3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzGDzkUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7C5C4CEC0;
	Fri, 13 Sep 2024 22:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726265192;
	bh=OIOoMQzoCgZxzo2kXHIadr8YEc/Wuuwq+XO3aobvV+g=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=WzGDzkUipADF6QvZNhGYsdfqcigisuYp2A/fTb+XXD4d3uUF2gyaeEB5aT0zgSM0J
	 HizPtwhsaHE+dqutdWdZUdelF75rgs+xcL1kNMDl/QZyuJmXR8CbBFTQPhE5cCelZ1
	 2SUvRit55lwhuTrRRY7fIyLA5FsVIVuFY4owYhelOzrVyEjOllIMinmGXkOJNetIfY
	 2lLUfGJ582v6PY+hb2t+s+FtjOA9Ee5OKf2pzPIyY5Ihu97n3KoymPcIRxmhTFHKFE
	 dtrMHm1CtdjAjhEfNsLsIPhCOh7PxKZsRNz3RtJM8jrzZ/8QgEGNmsDecJRDm7BLBD
	 GStQn80AcXIbw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Sep 2024 01:06:28 +0300
Message-Id: <D45HXRJ0LTFC.3VVF6QI3NGVXV@kernel.org>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
X-Mailer: aerc 0.17.0
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
 <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>
 <D45GBJ51SBNP.1WR34VCVNSN52@iki.fi>
In-Reply-To: <D45GBJ51SBNP.1WR34VCVNSN52@iki.fi>

On Fri Sep 13, 2024 at 11:50 PM EEST, Jarkko Sakkinen wrote:
> On Thu Sep 12, 2024 at 11:13 AM EEST, Roberto Sassu wrote:
> > On Wed, 2024-09-11 at 18:14 +0300, Jarkko Sakkinen wrote:
> > > On Wed Sep 11, 2024 at 11:53 AM EEST, Roberto Sassu wrote:
> > > > I made few measurements. I have a Fedora 38 VM with TPM passthrough=
.
> > >=20
> > > I was thinking more like
> > >=20
> > > sudo bpftrace -e 'k:tpm_transmit { @start[tid] =3D nsecs; } kr:tpm_tr=
ansmit { @[kstack, ustack, comm] =3D sum(nsecs - @start[tid]); delete(@star=
t[tid]); } END { clear(@start); }'
> > >=20
> > > For example when running "tpm2_createprimary --hierarchy o -G rsa2048=
 -c owner.txt", I get:
> >
> > Sure:
>
> Took couple of days to upgrade my BuildRoot environment to have bcc and
> bpftrace [1] but finally got similar figures (not the same test but doing
> extends).
>
> Summarizing your results looking at call before tpm_transmit:
>
> - HMAC management: 124 ms
> - extend with HMAC: 25 ms
> - extend without HMAC: 5.2 ms=20
>
> I'd see the only possible way to fix this would be refactor the HMAC
> implementation by making the caller always the orchestrator and thus
> allowing to use continueSession flag for TPM2_StartAuthSession to be
> used.
>
> For example if you do multiple extends there should not be good reason
> to setup and rollback session for each call separately right?
>
> [1] https://codeberg.org/jarkko/linux-tpmdd-test

Note that the timings are accumulated (not averaged). It would be easy
to fix this tho.

BR, Jarkko


