Return-Path: <linux-integrity+bounces-2656-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE97B8D06D8
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 17:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2305B2BD0C
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE5F61FE3;
	Mon, 27 May 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9LQcvId"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73717E8EE;
	Mon, 27 May 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824049; cv=none; b=atqtR8K52oKolUXgJozRgAvMvVOFAyXQIhWtZN4q1siRbe+cyCqiPZZ53oLV5L7jHR74fgVmuPindEmTVesUXOnnpmxvvK+nxp1B0wP5Np2c8zMoEjqpHlIuSCQ24B1LFKTWdz+Pt46H8iAwxifloh11TWsvT+tddPFTNK/g9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824049; c=relaxed/simple;
	bh=9Z8aW8EOSlQCc9328Ru+wW9mtQVAXa7pMChCkwHdm2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EpO56oKHj6IIzQx5QhK7iNGW2HbkGdbs7cOL7T/k17Nld/UkEYnjwZoC61plniCYzAvZxEctcqNwfcPABfn2krZRvb7JlJ6W6Bt7BJqBKK7eW3oRRxgl37b1qkgMTWw+aIUrFFLhIy6W2H/be+xD8zlYerAhZAZgsQOE8szufJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9LQcvId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA671C4AF07;
	Mon, 27 May 2024 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716824048;
	bh=9Z8aW8EOSlQCc9328Ru+wW9mtQVAXa7pMChCkwHdm2g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=S9LQcvIdN654rNWQLGatJnNi//JKdlKhGRJPVr/+1HYI8v8ARsZxMPDM1fBxTR3f/
	 VZ6MuU65+YbJzLSwbIe/aVoaQu5WkYrYnGSLkwme/ltHVAbkRIK3OevYhoQH2GqAh1
	 XML8Xdmwvbio+Tzo8HwHkuJ+yMquvXPZCDAFzITBEp7HINM37f98He1lV+sNVihUzQ
	 /ldhnPm62C2z5eLMHEWhtZFYh6OlF5sUEm5PzSIDzvdQ+ilHUwabk+k4KU2U9cqdFJ
	 8YMbQ6zisfA3yNkNuuwXzfChnL3ArEhonC2BhGjVYXqoc9M1ETgrx5jO0l6D4XWQ26
	 n4s/2lShs/Y0g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 18:34:03 +0300
Message-Id: <D1KJBXOPFWT7.1F14BWQJO29FC@kernel.org>
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
 <D1KIV2Q682XH.1GCPYWMFZ8B6J@kernel.org>
In-Reply-To: <D1KIV2Q682XH.1GCPYWMFZ8B6J@kernel.org>

On Mon May 27, 2024 at 6:12 PM EEST, Jarkko Sakkinen wrote:
> On Mon May 27, 2024 at 6:01 PM EEST, Jarkko Sakkinen wrote:
> > On Mon May 27, 2024 at 5:51 PM EEST, Jarkko Sakkinen wrote:
> > > On Thu May 23, 2024 at 10:59 AM EEST, Vitor Soares wrote:
> > > > On Wed, 2024-05-22 at 19:11 +0300, Jarkko Sakkinen wrote:
> > > > > On Wed May 22, 2024 at 5:58 PM EEST, Vitor Soares wrote:
> > > > > > I did run with ftrace, but need some more time to go through it=
.
> > > > > >=20
> > > > > > Here the step I did:
> > > > > > kernel config:
> > > > > > =C2=A0 CONFIG_FUNCTION_TRACER
> > > > > > =C2=A0 CONFIG_FUNCTION_GRAPH_TRACER
> > > > > >=20
> > > > > > ftrace:
> > > > > > =C2=A0 # set filters
> > > > > > =C2=A0 echo tpm* > set_ftrace_filter
> > > > > >=20
> > > > > > =C2=A0 # set tracer
> > > > > > =C2=A0 echo function_graph > current_tracer
> > > > > >=20
> > > > > > =C2=A0 # take the sample
> > > > > > =C2=A0 echo 1 > tracing_on; time modprobe tpm_tis_spi; echo 0 >=
 tracing_on
> > > > > >=20
> > > > > > regards,
> > > > > > Vitor Soares
> > > > >=20
> > > > > I'm now compiling distro kernel (OpenSUSE) for NUC7 with v6.10 co=
ntents.
> > > > >=20
> > > > > After I have that setup, I'll develop a perf test either with per=
f or
> > > > > bpftrace. I'll come back with the possible CONFIG_* that should b=
e in
> > > > > place in your kernel. Might take up until next week as I have som=
e
> > > > > conference stuff to prepare but I try to have stuff ready early n=
ext
> > > > > week.
> > > > >=20
> > > > > No need to rush with this as long as possible patches go to rc2 o=
r rc3.
> > > > > Let's do a proper analysis instead.
> > > > >=20
> > > > > In the meantime you could check if you get perf and/or bpftrace t=
o=20
> > > > > your image that use to boot up your device. Preferably both but
> > > > > please inform about this.
> > > > >=20
> > > >
> > > > I already have perf running, for the bpftrace I might not be able t=
o help.
> > >
> > > The interesting function to look at with/without hmac is probably
> > > tpm2_get_random().
> > >
> > > I attached a patch that removes hmac shenigans out of tpm2_get_random=
()
> > > for the sake of proper comparative testing.
> >
> > Other thing that we need to measure is to split the cost into
> > two parts:
> >
> > 1. Handshake, i.e. setting up and shutdowning a session.
> > 2. Transaction, payload TPM command.
> >
> > This could be done by setting up couple of kprobes_events:
> >
> >   payload_event: tpm2_get_random() etc.
> >   hmac_event: tpm2_start_auth_session(), tpm2_end_auth_session() etc.
> >
> > And just summing up the time for a boot to get a cost for hmac.
> >
> > I'd use bootconfig for this:
> >
> > https://www.kernel.org/doc/html/v6.9/trace/boottime-trace.html
> >
> > So I've made up plans how measure the incident but not sure when I
> > have time to pro-actively work on a benchmark (thus sharing details).
> >
> > So I think with just proper bootconfig wtih no other tools uses this
> > can be measured.
>
>
> I'll disable this for anything else than X86_64 by default, and put
> such patch to my next pull request.
>
> Someone needs to do the perf analysis properly based on the above
> descriptions. I cannot commit my time to promise them to get the
> perf regressions fixed by time. I can only commit on limiting the
> feature ;-)
>
> It is thus better be conservative and reconsider opt-in post 6.10.
> X86_64 is safeplay because even in that 2018 NUC7 based on Celeron,
> hmac is just fine.

While looking at code I started to wanted what was the reasoning
for adding *undocumented* "TPM2_OA_TMPL" in include/linux/tpm.h.
It should really be in tpm2-sessions.c and named something like
TPM2_NULL_KEY_OA or similar.

Obfuscation *on purpose* by definition... Since I see such spots (liked
e.g. tpm_buf_parameters() to name another instance) sprinkled, I've
pretty much locked in the decision to limit hmac to x86_64. It is right
thing to do given not so great maturity level.

Whatever on x86_64 I'm confident we can fix for sure any issue but
cannot make such analysis on other platforms.

BR, Jarkko

