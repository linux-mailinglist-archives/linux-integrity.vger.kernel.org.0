Return-Path: <linux-integrity+bounces-3582-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EF97900B
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 12:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE3C284E0A
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0BE1CEAC3;
	Sat, 14 Sep 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd6HR18M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61671CDA1E;
	Sat, 14 Sep 2024 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726310542; cv=none; b=DErjJbJIlvesbGeY+rWQPQVQ7r1+0DQDsbX0Str/8T6HhSnniYHXeQ2UzsjU8bIJn5Xc4vCZjAfNKglH53JTGYEPhDzUnaa0/db87M4lXerU2U+BLoU2VZu8i/YO9pSKrrWmUHpAWPXJ2UcK3eKI39rAuGIj+RR072vUDKnUJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726310542; c=relaxed/simple;
	bh=aWMHIiSHiMRxPm0F/dSWHOU3B9Te3WROyoHtHtUHIA8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Deqgq9cd39s0N7yRckuORMMHGD37zhF0QTN6Q2EzoDVzBg4886KKCfrf8UmkzdZm6xM07hjQh4NZ4nwT+EtIVetjWuZkdvzlsxO3/B2GFX5FhHd2/W7cwkIe8RweUK8sQCjGADP7MpuxrUov09fG7sTaMQrdosiTmxzDL8x3Sdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd6HR18M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6126C4CEC0;
	Sat, 14 Sep 2024 10:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726310542;
	bh=aWMHIiSHiMRxPm0F/dSWHOU3B9Te3WROyoHtHtUHIA8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sd6HR18MNpAp99VPF6PDngPx3Wo4xHueOBZFNVpFtq06CiriLkvzDDDPovjsjUqwP
	 gTbrW0OW92VP5zzeY5jui+HVkSVR6ZkDNUHTgpOF25tL5g2YzxJeog/Wh1HjFBUnQW
	 AAZxNWxMTm2RLkChUrIpfJBztJ1L3NxrBudc2/mEcnPEF+nz4outlHlI5y9nUsy1sg
	 qs6A2nnlO6nMvXh+8X5/gTU9QhxbombTCWqjEzArXJPAwZ9LDnJ5RL6yVn5wNWt5UN
	 dADf8GtvssnrQ5rls9Dovbm0fsY44QJ6PchJPvkOay3eue2TmbGyevy34A5sFtA3by
	 gGdbK1TO8CWkw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Sep 2024 13:42:18 +0300
Message-Id: <D45Y0H3JRIJE.3LIRI1PEDTJE3@kernel.org>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Roberto
 Sassu" <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
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
In-Reply-To: <10ae7b8592af7bacef87e493e6d628a027641b8d.camel@HansenPartnership.com>

On Wed Sep 11, 2024 at 3:21 PM EEST, James Bottomley wrote:
> On Wed, 2024-09-11 at 10:53 +0200, Roberto Sassu wrote:
> > On Tue, 2024-09-10 at 16:28 +0300, Jarkko Sakkinen wrote:
> > > On Tue Sep 10, 2024 at 3:57 PM EEST, James Bottomley wrote:
> > > > On Tue, 2024-09-10 at 15:48 +0300, Jarkko Sakkinen wrote:
> > > > > On Tue Sep 10, 2024 at 3:39 PM EEST, Jarkko Sakkinen wrote:
> > > > > > On Tue Sep 10, 2024 at 12:05 PM EEST, Roberto Sassu wrote:
> > > > > > > On Tue, 2024-09-10 at 11:01 +0200, Linux regression
> > > > > > > tracking
> > > > > > > (Thorsten
> > > > > > > Leemhuis) wrote:
> > > > > > > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > > > > > > >=20
> > > > > > > > James, Jarkoo, I noticed a report about a regression in
> > > > > > > > bugzilla.kernel.org that appears to be caused by this
> > > > > > > > change of
> > > > > > > > yours:
> > > > > > > >=20
> > > > > > > > 6519fea6fd372b ("tpm: add hmac checks to
> > > > > > > > tpm2_pcr_extend()")
> > > > > > > > [v6.10-rc1]
> > > > > > > >=20
> > > > > > > > As many (most?) kernel developers don't keep an eye on
> > > > > > > > the bug
> > > > > > > > tracker,
> > > > > > > > I decided to forward it by mail. To quote from
> > > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229=C2=A0:
> > > > > > > >=20
> > > > > > > > > When secureboot is enabled,
> > > > > > > > > the kernel boot time is ~20 seconds after 6.10 kernel.
> > > > > > > > > it's ~7 seconds on 6.8 kernel version.
> > > > > > > > >=20
> > > > > > > > > When secureboot is disabled,
> > > > > > > > > the boot time is ~7 seconds too.
> > > > > > > > >=20
> > > > > > > > > Reproduced on both AMD and Intel platform on ThinkPad
> > > > > > > > > X1 and
> > > > > > > > > T14.
> > > > > > > > >=20
> > > > > > > > > It probably caused autologin failure and micmute led
> > > > > > > > > not
> > > > > > > > > loaded on AMD platform.
> > > > > > > >=20
> > > > > > > > It was later bisected to the change mentioned above. See
> > > > > > > > the
> > > > > > > > ticket for
> > > > > > > > more details.
> > > > > > >=20
> > > > > > > Hi
> > > > > > >=20
> > > > > > > I suspect I encountered the same problem:
> > > > > > >=20
> > > > > > > https://lore.kernel.org/linux-integrity/b8a7b3566e6014ba102ab=
98e10ede0d574d8930e.camel@huaweicloud.com/
> > > > > > >=20
> > > > > > > Going to provide more info there.
> > > > > >=20
> > > > > > I suppose you are going try to acquire the tracing data I
> > > > > > asked?
> > > > > > That would be awesome, thanks for taking the troube.=C2=A0 Let'=
s
> > > > > > look
> > > > > > at the data and draw conclusions based on that.
> > > > > >=20
> > > > > > Workaround is pretty simple: CONFIG_TCG_TPM2_HMAC=3Dn to the
> > > > > > kernel
> > > > > > configuration disables the feature.
> > > > > >=20
> > > > > > For making decisions what to do with the=C2=A0 we are talking
> > > > > > about ~2
> > > > > > week window estimated, given the Vienna conference slows
> > > > > > things
> > > > > > down, so I hope my workaround is good enough before that.
> > > > >=20
> > > > > I can enumerate three most likely ways to address the issue:
> > > > >=20
> > > > > 1. Strongest: drop from defconfig.
> > > > > 2. Medium: leave to defconfig but add an opt-in kernel command-
> > > > > line
> > > > > =C2=A0=C2=A0 parameter.
> > > > > 3. Lightest: if we can based on tracing data nail the
> > > > > regression in
> > > > > =C2=A0=C2=A0 sustainable schedule, fix it.
> > > >=20
> > > > Actually, there's a fourth: not use sessions for the PCR extend
> > > > (if
> > > > we'd got the timings when I asked, this was going to be my
> > > > suggestion
> > > > if they came back problematic).=C2=A0 This seems only to be a probl=
em
> > > > for
> > > > IMA measured boot (because it does lots of extends).=C2=A0 If
> > > > necessary this
> > > > could even be wrapped in a separate config or boot option that
> > > > only
> > > > disables HMAC on extend if IMA (so we still get security for
> > > > things
> > > > like sd-boot)
> > >=20
> > > I can buy that but with a twist that make it an opt-in kernel
> > > command
> > > line option. We don't want to take already existing functionality
> > > away
> > > from those who might want to use it (given e.g. hardening
> > > requirements),
> > > and with that basis opt-in (by default disabled) would be more
> > > balanced
> > > way to address the issue.
> > >=20
> > > Please do a send a patch!
> >=20
> > I made few measurements. I have a Fedora 38 VM with TPM passthrough.
> >=20
> > Kernels: 6.11-rc2+ (guest), 6.5.0-45-generic (host)
> >=20
> > QEMU:
> >=20
> > rc=C2=A0 qemu-kvm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:4.2-
> > 3ubuntu6.27
> > ii=C2=A0 qemu-system-x86=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1:6.2+dfsg-
> > 2ubuntu6.22
> >=20
> >=20
> > TPM2_PT_MANUFACTURER:
> > =C2=A0 raw: 0x49465800
> > =C2=A0 value: "IFX"
> > TPM2_PT_VENDOR_STRING_1:
> > =C2=A0 raw: 0x534C4239
> > =C2=A0 value: "SLB9"
> > TPM2_PT_VENDOR_STRING_2:
> > =C2=A0 raw: 0x36373000
> > =C2=A0 value: "670"
> >=20
> >=20
> > No HMAC:
> >=20
> > # tracer: function_graph
> > #
> > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > =C2=A00)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > =C2=A00)=C2=A0=C2=A0 1.112 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm=
_buf_append_hmac_session();
> > =C2=A00) # 6360.029 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > =C2=A00) # 6415.012 us |=C2=A0 }
> >=20
> >=20
> > HMAC:
> >=20
> > # tracer: function_graph
> > #
> > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm2_start_auth_session() {
> > =C2=A01) * 36976.99 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd=
();
> > =C2=A01) * 84746.51 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd=
();
> > =C2=A01) # 3195.083 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd=
();
> > =C2=A01) @ 126795.1 us |=C2=A0=C2=A0=C2=A0 }
> > =C2=A01)=C2=A0=C2=A0 2.254 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm=
_buf_append_hmac_session();
> > =C2=A01)=C2=A0=C2=A0 3.546 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm=
_buf_fill_hmac_session();
> > =C2=A01) * 24356.46 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > =C2=A01)=C2=A0=C2=A0 3.496 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm=
_buf_check_hmac_response();
> > =C2=A01) @ 151171.0 us |=C2=A0 }
>
> Well, unfortunately, that tells us that it's the TPM itself that's
> taking the time processing the security overhead.  The ordering of the
> commands in tpm2_start_auth_session() shows
>
>  37ms for context restore of null key
>  85ms for start session with encrypted salt
>   3ms to flush null key
> -----
> 125ms
>
> If we context save the session, we'd likely only bear a single 37ms
> cost to restore it (replacing the total 125ms).  However, there's
> nothing we can do about the extend execution going from 6ms to 24ms, so
> I could halve your current boot time with security enabled (it's
> currently 149ms, it would go to 61ms, but it's still 10x slower than
> the unsecured extend at 6ms)

Please address how this discussion is related to https://bugzilla.kernel.or=
g/show_bug.cgi?id=3D219229

I just read the bug report nothing about IMA or PCR extend.

There's now tons of spam about performance issue in a patch set that is
not in the mainline and barely nothing about the original issue:

"
When secureboot is enabled,
the kernel boot time is ~20 seconds after 6.10 kernel.
it's ~7 seconds on 6.8 kernel version.

When secureboot is disabled,
the boot time is ~7 seconds too.

Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.

It probably caused autologin failure and micmute led not loaded on AMD plat=
form.

6.9 kernel version is not tested since not signed kernel found.
6.8, 6.10, 6.11 are tested, the first bad version is 6.10.
"

How is this going to help to fix this one?

I say this once and one: I zero care fixing code that is in the
mainline.

BR, Jarkko

