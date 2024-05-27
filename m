Return-Path: <linux-integrity+bounces-2662-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4428D0E77
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F2B1F2201D
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE315E5B0;
	Mon, 27 May 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlfzhBwf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC610A0C;
	Mon, 27 May 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716840076; cv=none; b=ZIWexDTqC6xu8VcrRKScNKLHZowvHmsnjp6zPEHy5EtqZJdaR7jpMMPVqO1w452EWm3QX6+48jfY2NosyhnDMtLLhK6qSnThF4iV90Jnr1Yw9CZ72TQeX051aMt4qrmmF5zOEaX0iP/Zx61LeNng5wnga7I7ajhfMTfQvzaSj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716840076; c=relaxed/simple;
	bh=OWQYNDegokhSObT7nbj0+hL6/tPHQ6m0GIe7RUwAVXA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bsOQQrXXCMFvgwRprD8pX4c0y8PJZ1+H5GGaEbIPsTMVnqwgqdSqimTi/Aog4E854PoLYie4FlTSZnM+Wn8ExfBM8dzoiXsv1X1grlrdT17Bq05LkRZS4IV7KyWmRh/e+WEXWoOoadFsHO8bdYxSlb7cX/SFyihGGvYdEzYeIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlfzhBwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526CFC2BBFC;
	Mon, 27 May 2024 20:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716840076;
	bh=OWQYNDegokhSObT7nbj0+hL6/tPHQ6m0GIe7RUwAVXA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qlfzhBwfdAG2mxxccilHj0avcjDtwuzZC/VAbeTRGdxMOHXZLzTa0zvFvwCT0kcy6
	 jbBKqvxVx8Z+tkgamv5EwVkSE6u3+pA99R6op1IyIeVuo33fMQdLXE4xPWJ0Btu8B7
	 pgpGHT02fLsct+B+mPQvgkenRuoQZZrVPsbC1ehoHPfN96uHrAGoCLIbd5YbNYGbbT
	 SdQT6fxlimLna1qC2L6p5A8XoB7Cdpsz/sDUHA0gGmmisxHoTYt4pcCOeFv6rBH4dC
	 bsuPvqKeT88Gz7lzpe5m1nwlQWmBfmnAChMOw/dT6M0swbMCnMKzA7PVxvTawsKiys
	 O7UPYq9sJmDRg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 23:01:11 +0300
Message-Id: <D1KP0GQGBREG.1L307RLJM4NAF@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Vitor Soares" <ivitro@gmail.com>,
 <linux-integrity@vger.kernel.org>
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
 <D1KJBXOPFWT7.1F14BWQJO29FC@kernel.org>
 <ddbeb8111f48a8ddb0b8fca248dff6cc9d7079b2.camel@HansenPartnership.com>
 <D1KOUVENRY80.2NXQW3P1K6Z2R@kernel.org>
In-Reply-To: <D1KOUVENRY80.2NXQW3P1K6Z2R@kernel.org>

On Mon May 27, 2024 at 10:53 PM EEST, Jarkko Sakkinen wrote:
> On Mon May 27, 2024 at 8:57 PM EEST, James Bottomley wrote:
> > On Mon, 2024-05-27 at 18:34 +0300, Jarkko Sakkinen wrote:
> > > On Mon May 27, 2024 at 6:12 PM EEST, Jarkko Sakkinen wrote:
> > > > On Mon May 27, 2024 at 6:01 PM EEST, Jarkko Sakkinen wrote:
> > > > > On Mon May 27, 2024 at 5:51 PM EEST, Jarkko Sakkinen wrote:
> > > > > > On Thu May 23, 2024 at 10:59 AM EEST, Vitor Soares wrote:
> > > > > > > On Wed, 2024-05-22 at 19:11 +0300, Jarkko Sakkinen wrote:
> > > > > > > > On Wed May 22, 2024 at 5:58 PM EEST, Vitor Soares wrote:
> > > > > > > > > I did run with ftrace, but need some more time to go
> > > > > > > > > through it.
> > > > > > > > >=20
> > > > > > > > > Here the step I did:
> > > > > > > > > kernel config:
> > > > > > > > > =C2=A0 CONFIG_FUNCTION_TRACER
> > > > > > > > > =C2=A0 CONFIG_FUNCTION_GRAPH_TRACER
> > > > > > > > >=20
> > > > > > > > > ftrace:
> > > > > > > > > =C2=A0 # set filters
> > > > > > > > > =C2=A0 echo tpm* > set_ftrace_filter
> > > > > > > > >=20
> > > > > > > > > =C2=A0 # set tracer
> > > > > > > > > =C2=A0 echo function_graph > current_tracer
> > > > > > > > >=20
> > > > > > > > > =C2=A0 # take the sample
> > > > > > > > > =C2=A0 echo 1 > tracing_on; time modprobe tpm_tis_spi; ec=
ho 0
> > > > > > > > > > tracing_on
> > > > > > > > >=20
> > > > > > > > > regards,
> > > > > > > > > Vitor Soares
> > > > > > > >=20
> > > > > > > > I'm now compiling distro kernel (OpenSUSE) for NUC7 with
> > > > > > > > v6.10 contents.
> > > > > > > >=20
> > > > > > > > After I have that setup, I'll develop a perf test either
> > > > > > > > with perf or
> > > > > > > > bpftrace. I'll come back with the possible CONFIG_* that
> > > > > > > > should be in
> > > > > > > > place in your kernel. Might take up until next week as I
> > > > > > > > have some
> > > > > > > > conference stuff to prepare but I try to have stuff ready
> > > > > > > > early next
> > > > > > > > week.
> > > > > > > >=20
> > > > > > > > No need to rush with this as long as possible patches go to
> > > > > > > > rc2 or rc3.
> > > > > > > > Let's do a proper analysis instead.
> > > > > > > >=20
> > > > > > > > In the meantime you could check if you get perf and/or
> > > > > > > > bpftrace to=20
> > > > > > > > your image that use to boot up your device. Preferably both
> > > > > > > > but
> > > > > > > > please inform about this.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I already have perf running, for the bpftrace I might not be
> > > > > > > able to help.
> > > > > >=20
> > > > > > The interesting function to look at with/without hmac is
> > > > > > probably
> > > > > > tpm2_get_random().
> > > > > >=20
> > > > > > I attached a patch that removes hmac shenigans out of
> > > > > > tpm2_get_random()
> > > > > > for the sake of proper comparative testing.
> > > > >=20
> > > > > Other thing that we need to measure is to split the cost into
> > > > > two parts:
> > > > >=20
> > > > > 1. Handshake, i.e. setting up and shutdowning a session.
> > > > > 2. Transaction, payload TPM command.
> > > > >=20
> > > > > This could be done by setting up couple of kprobes_events:
> > > > >=20
> > > > > =C2=A0 payload_event: tpm2_get_random() etc.
> > > > > =C2=A0 hmac_event: tpm2_start_auth_session(), tpm2_end_auth_sessi=
on()
> > > > > etc.
> > > > >=20
> > > > > And just summing up the time for a boot to get a cost for hmac.
> > > > >=20
> > > > > I'd use bootconfig for this:
> > > > >=20
> > > > > https://www.kernel.org/doc/html/v6.9/trace/boottime-trace.html
> > > > >=20
> > > > > So I've made up plans how measure the incident but not sure when
> > > > > I
> > > > > have time to pro-actively work on a benchmark (thus sharing
> > > > > details).
> > > > >=20
> > > > > So I think with just proper bootconfig wtih no other tools uses
> > > > > this
> > > > > can be measured.
> > > >=20
> > > >=20
> > > > I'll disable this for anything else than X86_64 by default, and put
> > > > such patch to my next pull request.
> > > >=20
> > > > Someone needs to do the perf analysis properly based on the above
> > > > descriptions. I cannot commit my time to promise them to get the
> > > > perf regressions fixed by time. I can only commit on limiting the
> > > > feature ;-)
> > > >=20
> > > > It is thus better be conservative and reconsider opt-in post 6.10.
> > > > X86_64 is safeplay because even in that 2018 NUC7 based on Celeron,
> > > > hmac is just fine.
> > >=20
> > > While looking at code I started to wanted what was the reasoning
> > > for adding *undocumented* "TPM2_OA_TMPL" in include/linux/tpm.h.
> > > It should really be in tpm2-sessions.c and named something like
> > > TPM2_NULL_KEY_OA or similar.
> >
> > Well, because you asked for it. I originally had all the flags spelled
> > out and I'm not a fan of this obscurity, but you have to do stuff like
> > this to get patches accepted:
> >
> > https://lore.kernel.org/linux-integrity/CZCKTWU6ZCC9.2UTEQPEVICYHL@supp=
ilovahvero/
>
> I still think the constant does make sense.
>
> The current constant does not really imply that it is for the null key,
> it is defined in the wrong file and has no actual legit documentation
> to go with it.

Thus, being conservative and enabling only for x86_64 is pretty balanced
choice for v6.10. The feature really needs to mature before widening the
scope.

The only platform I'm confident is x86_64 because even the old NUC did
good job, so for that part I'm not too worried. Otherwise, it would be
pure guesswork to unconditionally eanble for all arch's.

Those who want to turn the feature  on,still can but we should not make
that decision for them. E.g. perhaps PowerPC could do this but I don't
have any hardware to test it out, and have zero usage reports.

Obviously can be reconsidered to future kernel versions but right now
this feels like the most legit way to act.

BR, Jarkko

