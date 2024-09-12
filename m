Return-Path: <linux-integrity+bounces-3549-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD66976BF8
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016BC2847FE
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D511B12E8;
	Thu, 12 Sep 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqMSHt+f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745251B12E2;
	Thu, 12 Sep 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151178; cv=none; b=O+Vq6MqaEd77M+B/HbH1utIRZ2jiq27Glo0O5nctiYNoENu+LGnBRxRIw1CiBKvwAEY9ZQu8UApvjgC1AW6VYjU2pftFU577Ez3dzzsuYSup3eaqbFsM2qgSWrTECsZb1i09e/ebHLau9mTSYqrocDEzFXAOo8z9AQ+cqdMzh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151178; c=relaxed/simple;
	bh=lsy1Gv3SViMMRhiCTW8cg/MAslIojkvK7IrI2vdHuCI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Qbt6GtF8fP2BnBpn4a5uBwpKn7y8LaUrf8z7AKKp1RwXgpthf1NeIL1V7wXxIZdplv2Gym1Z1w/+U+7FLnoB779rievob0qhwYdkHMTGhGE7IS87a/wAYb2uToWzPxC6GKgpDgyOlDdlfCBOUrAlc8p0KdZrqL9cBuxncbwjytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqMSHt+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C186C4CECF;
	Thu, 12 Sep 2024 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726151178;
	bh=lsy1Gv3SViMMRhiCTW8cg/MAslIojkvK7IrI2vdHuCI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=IqMSHt+fn9WjUszoXbH8wAj7M/YiSSsgfSrbnLaVTqdSW6+1ceUvHRKDDm2rXKf4D
	 MaTpckvR9pXxzDKYRIU+348W/rgdEomTgCYMHMk3sFZTgKs+wIN2umaM9FPlck7Wau
	 hliAGKaEviMJzNoTSvBGJtkwWnYMXTj0pm95/6yiPEp1cxNoZRGbSI/raac9YwWnob
	 /vfYQP3KEkvRLPvI9eIcCDjc02uzL+lvXnJWEPHs1DOmAQt7SdVTVWKjA/GoZGajVs
	 rQ4/sB7KKbpr6xmOHeFUUbB8uHyzMkN5Xcj8otd27A2kka0mO5L8NK1T9IUDkeRhnp
	 oKWLQGhwSaV2Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Sep 2024 17:26:14 +0300
Message-Id: <D44DIUD9CDR7.2VE81HS08JEE0@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Roberto
 Sassu" <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <10ae7b8592af7bacef87e493e6d628a027641b8d.camel@HansenPartnership.com>
 <D44C19QB8IK1.OMUJP7N91HRN@kernel.org>
 <c47b129aeb95094aace5b174fc6d81bf0a7ecfbf.camel@HansenPartnership.com>
In-Reply-To: <c47b129aeb95094aace5b174fc6d81bf0a7ecfbf.camel@HansenPartnership.com>

On Thu Sep 12, 2024 at 4:26 PM EEST, James Bottomley wrote:
> On Thu, 2024-09-12 at 16:16 +0300, Jarkko Sakkinen wrote:
> > On Wed Sep 11, 2024 at 3:21 PM EEST, James Bottomley wrote:
> > > On Wed, 2024-09-11 at 10:53 +0200, Roberto Sassu wrote:
> [...]
> > > > I made few measurements. I have a Fedora 38 VM with TPM
> > > > passthrough.
> > > >=20
> > > > Kernels: 6.11-rc2+ (guest), 6.5.0-45-generic (host)
> > > >=20
> > > > QEMU:
> > > >=20
> > > > rc=C2=A0 qemu-kvm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:4.2-
> > > > 3ubuntu6.27
> > > > ii=C2=A0 qemu-system-x86=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1:6.2+dfsg-
> > > > 2ubuntu6.22
> > > >=20
> > > >=20
> > > > TPM2_PT_MANUFACTURER:
> > > > =C2=A0 raw: 0x49465800
> > > > =C2=A0 value: "IFX"
> > > > TPM2_PT_VENDOR_STRING_1:
> > > > =C2=A0 raw: 0x534C4239
> > > > =C2=A0 value: "SLB9"
> > > > TPM2_PT_VENDOR_STRING_2:
> > > > =C2=A0 raw: 0x36373000
> > > > =C2=A0 value: "670"
> > > >=20
> > > >=20
> > > > No HMAC:
> > > >=20
> > > > # tracer: function_graph
> > > > #
> > > > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > > > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > > > =C2=A00)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > > > =C2=A00)=C2=A0=C2=A0 1.112 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_append_hmac_session();
> > > > =C2=A00) # 6360.029 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > > > =C2=A00) # 6415.012 us |=C2=A0 }
> > > >=20
> > > >=20
> > > > HMAC:
> > > >=20
> > > > # tracer: function_graph
> > > > #
> > > > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > > > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > > > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > > > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm2_start_auth_session() {
> > > > =C2=A01) * 36976.99 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) * 84746.51 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) # 3195.083 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) @ 126795.1 us |=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A01)=C2=A0=C2=A0 2.254 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_append_hmac_session();
> > > > =C2=A01)=C2=A0=C2=A0 3.546 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_fill_hmac_session();
> > > > =C2=A01) * 24356.46 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > > > =C2=A01)=C2=A0=C2=A0 3.496 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_check_hmac_response();
> > > > =C2=A01) @ 151171.0 us |=C2=A0 }
> > >=20
> > > Well, unfortunately, that tells us that it's the TPM itself that's
> > > taking the time processing the security overhead.=C2=A0 The ordering =
of
> > > the commands in tpm2_start_auth_session() shows
> > >=20
> > > =C2=A037ms for context restore of null key
> > > =C2=A085ms for start session with encrypted salt
> > > =C2=A0 3ms to flush null key
> > > -----
> > > 125ms
> > >=20
> > > If we context save the session, we'd likely only bear a single 37ms
> > > cost to restore it (replacing the total 125ms).=C2=A0 However, there'=
s
> > > nothing we can do about the extend execution going from 6ms to
> > > 24ms, so I could halve your current boot time with security enabled
> > > (it's currently 149ms, it would go to 61ms, but it's still 10x
> > > slower than the unsecured extend at 6ms)
> > >=20
> > > James
> >=20
> > I'll hold for better benchmarks.
>
> Well, yes, I'd like to see this for a variety of TPMs.
>
> This one clearly shows it's the real time wait for the TPM (since it
> dwarfs the CPU time calculation there's not much optimization we can do
> on the kernel end).  The one thing that's missing in all of this is
> what was the TPM?  but even if it's an outlier that's really bad at
> crypto what should we do?  We could have a blacklist that turns off the
> extend hmac (or a whitelist that turns it on), but we can't simply say
> too bad you need a better TPM.
>
> James

I'm pasting here my yesterday's one-liner ;-)

sudo bpftrace -e 'k:tpm_transmit { @start[tid] =3D nsecs; } kr:tpm_transmit=
 { @[kstack, ustack, comm] =3D sum(nsecs - @start[tid]); delete(@start[tid]=
); } END { clear(@start); }'

If you have a fix candidate, snippet of the output before/after would
work as rationale too.

Looking into the data Roberto put me tomorrow.

BR, Jarkko

