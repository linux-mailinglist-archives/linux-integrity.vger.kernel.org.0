Return-Path: <linux-integrity+bounces-2655-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87158D05DC
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD611F2372A
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F015A859;
	Mon, 27 May 2024 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiOWSXTN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1EB15A851;
	Mon, 27 May 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822728; cv=none; b=IlRdSmlY7Kofy7jilCAewwuJeY7JR3srEfJc8BmbrGkwow+b86M4pG5gTwmj08zFfzjKAUplbxpiQ8x6UmcMLOdOlia5VgJ9sUFALSSM0G6/wlG23/Al4Q1mFIxf+GZscZfXKJDvDGMy8WsWZKisgDYRIT4HMLXFsQMuhknnSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822728; c=relaxed/simple;
	bh=NAAb16yR/ArobVcLNWX5cjRE7d7GGuta0KaqTwDkg38=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pRvkT9Xlu8RPKLKvSFczsZx2ljiMpAeCbfJPcPZ/tKGNKqqW+ObfJF0zT9SBBF/voWhn4qcUNIROsBkIiWwGQ+74gf32eS945dU5a1a89xOdokq4eg1vMW/J3WrgBUDPjAuvqStxe4B5Ac9gNEh9hrlkIU2vGmf9spjgUJcUHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiOWSXTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA938C4AF07;
	Mon, 27 May 2024 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716822727;
	bh=NAAb16yR/ArobVcLNWX5cjRE7d7GGuta0KaqTwDkg38=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FiOWSXTNkHJMdcov3wOpBg9gbEql8O8OWSYUpNlY+Y0zKJeWl+4oCITvh4TpMH1Cv
	 cil30D2EZGwl2UG9w2q+moo8K09o6nBviEY6vuCaIgAUaIZUl2ab7s+ItFQaX7g4+m
	 7GR7bcT7/kqkwjC33xZZEA4tDxXH3vnaB0ce9q2qVKuQnGs+V92ON1gH0dK/ISY7xZ
	 AeD6U+pRfxTJAw5uRKWMos3HSMTvssC8fUdMJRwrBr27HacwAncCbRgbaUswx5Pqtu
	 Zfbfqdd+emwbxNvuMFpHcZ4EcWti4ODajBtI6wSa21HdDiSgyYPjn69d0mEHyotb5S
	 jLzPp1UiH3hxg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 18:12:02 +0300
Message-Id: <D1KIV2Q682XH.1GCPYWMFZ8B6J@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Vitor Soares"
 <ivitro@gmail.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
 <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
 <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
 <0c12c9ea10aa97e246230fc33e6b35c571102b48.camel@gmail.com>
 <D1GAZSIOZVWW.2UZBFHASIG21U@kernel.org>
 <3e4bbd0f0fe9f57fd7555a3775e8d71031c0d6c5.camel@gmail.com>
 <D1KIFPNBNGKH.IJKFRXH8WINU@kernel.org>
 <D1KINAE5E2MH.729CM4ABV5VN@kernel.org>
In-Reply-To: <D1KINAE5E2MH.729CM4ABV5VN@kernel.org>

On Mon May 27, 2024 at 6:01 PM EEST, Jarkko Sakkinen wrote:
> On Mon May 27, 2024 at 5:51 PM EEST, Jarkko Sakkinen wrote:
> > On Thu May 23, 2024 at 10:59 AM EEST, Vitor Soares wrote:
> > > On Wed, 2024-05-22 at 19:11 +0300, Jarkko Sakkinen wrote:
> > > > On Wed May 22, 2024 at 5:58 PM EEST, Vitor Soares wrote:
> > > > > I did run with ftrace, but need some more time to go through it.
> > > > >=20
> > > > > Here the step I did:
> > > > > kernel config:
> > > > > =C2=A0 CONFIG_FUNCTION_TRACER
> > > > > =C2=A0 CONFIG_FUNCTION_GRAPH_TRACER
> > > > >=20
> > > > > ftrace:
> > > > > =C2=A0 # set filters
> > > > > =C2=A0 echo tpm* > set_ftrace_filter
> > > > >=20
> > > > > =C2=A0 # set tracer
> > > > > =C2=A0 echo function_graph > current_tracer
> > > > >=20
> > > > > =C2=A0 # take the sample
> > > > > =C2=A0 echo 1 > tracing_on; time modprobe tpm_tis_spi; echo 0 > t=
racing_on
> > > > >=20
> > > > > regards,
> > > > > Vitor Soares
> > > >=20
> > > > I'm now compiling distro kernel (OpenSUSE) for NUC7 with v6.10 cont=
ents.
> > > >=20
> > > > After I have that setup, I'll develop a perf test either with perf =
or
> > > > bpftrace. I'll come back with the possible CONFIG_* that should be =
in
> > > > place in your kernel. Might take up until next week as I have some
> > > > conference stuff to prepare but I try to have stuff ready early nex=
t
> > > > week.
> > > >=20
> > > > No need to rush with this as long as possible patches go to rc2 or =
rc3.
> > > > Let's do a proper analysis instead.
> > > >=20
> > > > In the meantime you could check if you get perf and/or bpftrace to=
=20
> > > > your image that use to boot up your device. Preferably both but
> > > > please inform about this.
> > > >=20
> > >
> > > I already have perf running, for the bpftrace I might not be able to =
help.
> >
> > The interesting function to look at with/without hmac is probably
> > tpm2_get_random().
> >
> > I attached a patch that removes hmac shenigans out of tpm2_get_random()
> > for the sake of proper comparative testing.
>
> Other thing that we need to measure is to split the cost into
> two parts:
>
> 1. Handshake, i.e. setting up and shutdowning a session.
> 2. Transaction, payload TPM command.
>
> This could be done by setting up couple of kprobes_events:
>
>   payload_event: tpm2_get_random() etc.
>   hmac_event: tpm2_start_auth_session(), tpm2_end_auth_session() etc.
>
> And just summing up the time for a boot to get a cost for hmac.
>
> I'd use bootconfig for this:
>
> https://www.kernel.org/doc/html/v6.9/trace/boottime-trace.html
>
> So I've made up plans how measure the incident but not sure when I
> have time to pro-actively work on a benchmark (thus sharing details).
>
> So I think with just proper bootconfig wtih no other tools uses this
> can be measured.


I'll disable this for anything else than X86_64 by default, and put
such patch to my next pull request.

Someone needs to do the perf analysis properly based on the above
descriptions. I cannot commit my time to promise them to get the
perf regressions fixed by time. I can only commit on limiting the
feature ;-)

It is thus better be conservative and reconsider opt-in post 6.10.
X86_64 is safeplay because even in that 2018 NUC7 based on Celeron,
hmac is just fine.

BR, Jarkko

