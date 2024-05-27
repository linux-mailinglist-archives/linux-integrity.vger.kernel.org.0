Return-Path: <linux-integrity+bounces-2660-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221868D09A0
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82844B2292D
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B22915F32D;
	Mon, 27 May 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="K6m8SmK/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gJMWGn1r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2615F321;
	Mon, 27 May 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832674; cv=none; b=lWZ+5DA0z9AvpKWkcuAKC9U2LelyTHMFBF2tHBqDzAkP7TNqO6tnk1q3kUbLNlm3vHq4AK6DvAfeG3HQvuR9PSbWROVHtqtY9xTMBqtUbgVkqhL1N4nnsiMrQ5vO6fEZRc+ipU5FqDuPUWCBrvKknmk52W1rWFq1pzAfjwLMdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832674; c=relaxed/simple;
	bh=FZiqIYHL7OFbeGR09eTWWfepRLNnXz92ZgMbdThGKMA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8gu43/oZPBLHm7uxMpkbv2Yv5U0v0ZMvlr94KLFg+8Ge6E9Rq5jzxdytzHOLxLx2ehmv7zaCkrbtC79TU1xMbc7gLiMbPy+LscdTqnac889bNV+pPc1Y5dzQ3pMagFaSXxRz4YCCxAG6znCoItvJ9/2s2X1qxzCJwadKvf/V/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=K6m8SmK/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gJMWGn1r; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716832672;
	bh=FZiqIYHL7OFbeGR09eTWWfepRLNnXz92ZgMbdThGKMA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=K6m8SmK/1gY2Usb4wZCvxlj2beULZ+pVpGXQ4G2uWqS8iWLz9IWyHT/PV5bACP+3h
	 QyVaSXaqbw5EkaCMag2bM/CPcbPD75u2cptzajA6NcLjxLmja1YY07IKaf6iLK9qyO
	 idovyveayDvksvhPrsHLVJ280l0e5c9Z28WPcmMw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 10C1C1287AD4;
	Mon, 27 May 2024 13:57:52 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id iuYWe4ta34Ei; Mon, 27 May 2024 13:57:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716832671;
	bh=FZiqIYHL7OFbeGR09eTWWfepRLNnXz92ZgMbdThGKMA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gJMWGn1rcsoVs8DmnILMg+KKxcdlPGOPKoDvB4ZrkRTT/nfmJTxCYlAqlGxkj0BOc
	 7BOm/vwWqvUbX920Uk1SRmOe4Ywl7lcqgq5hicU1bhaIBVQTp9w7vyEcSgUczOHEHa
	 7VIL/veaKJxvAxv+QMZP359+wCu38Ql2vvEubMRI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C66D51287AB5;
	Mon, 27 May 2024 13:57:50 -0400 (EDT)
Message-ID: <ddbeb8111f48a8ddb0b8fca248dff6cc9d7079b2.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Vitor Soares <ivitro@gmail.com>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Mon, 27 May 2024 13:57:49 -0400
In-Reply-To: <D1KJBXOPFWT7.1F14BWQJO29FC@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-05-27 at 18:34 +0300, Jarkko Sakkinen wrote:
> On Mon May 27, 2024 at 6:12 PM EEST, Jarkko Sakkinen wrote:
> > On Mon May 27, 2024 at 6:01 PM EEST, Jarkko Sakkinen wrote:
> > > On Mon May 27, 2024 at 5:51 PM EEST, Jarkko Sakkinen wrote:
> > > > On Thu May 23, 2024 at 10:59 AM EEST, Vitor Soares wrote:
> > > > > On Wed, 2024-05-22 at 19:11 +0300, Jarkko Sakkinen wrote:
> > > > > > On Wed May 22, 2024 at 5:58 PM EEST, Vitor Soares wrote:
> > > > > > > I did run with ftrace, but need some more time to go
> > > > > > > through it.
> > > > > > > 
> > > > > > > Here the step I did:
> > > > > > > kernel config:
> > > > > > >   CONFIG_FUNCTION_TRACER
> > > > > > >   CONFIG_FUNCTION_GRAPH_TRACER
> > > > > > > 
> > > > > > > ftrace:
> > > > > > >   # set filters
> > > > > > >   echo tpm* > set_ftrace_filter
> > > > > > > 
> > > > > > >   # set tracer
> > > > > > >   echo function_graph > current_tracer
> > > > > > > 
> > > > > > >   # take the sample
> > > > > > >   echo 1 > tracing_on; time modprobe tpm_tis_spi; echo 0
> > > > > > > > tracing_on
> > > > > > > 
> > > > > > > regards,
> > > > > > > Vitor Soares
> > > > > > 
> > > > > > I'm now compiling distro kernel (OpenSUSE) for NUC7 with
> > > > > > v6.10 contents.
> > > > > > 
> > > > > > After I have that setup, I'll develop a perf test either
> > > > > > with perf or
> > > > > > bpftrace. I'll come back with the possible CONFIG_* that
> > > > > > should be in
> > > > > > place in your kernel. Might take up until next week as I
> > > > > > have some
> > > > > > conference stuff to prepare but I try to have stuff ready
> > > > > > early next
> > > > > > week.
> > > > > > 
> > > > > > No need to rush with this as long as possible patches go to
> > > > > > rc2 or rc3.
> > > > > > Let's do a proper analysis instead.
> > > > > > 
> > > > > > In the meantime you could check if you get perf and/or
> > > > > > bpftrace to 
> > > > > > your image that use to boot up your device. Preferably both
> > > > > > but
> > > > > > please inform about this.
> > > > > > 
> > > > > 
> > > > > I already have perf running, for the bpftrace I might not be
> > > > > able to help.
> > > > 
> > > > The interesting function to look at with/without hmac is
> > > > probably
> > > > tpm2_get_random().
> > > > 
> > > > I attached a patch that removes hmac shenigans out of
> > > > tpm2_get_random()
> > > > for the sake of proper comparative testing.
> > > 
> > > Other thing that we need to measure is to split the cost into
> > > two parts:
> > > 
> > > 1. Handshake, i.e. setting up and shutdowning a session.
> > > 2. Transaction, payload TPM command.
> > > 
> > > This could be done by setting up couple of kprobes_events:
> > > 
> > >   payload_event: tpm2_get_random() etc.
> > >   hmac_event: tpm2_start_auth_session(), tpm2_end_auth_session()
> > > etc.
> > > 
> > > And just summing up the time for a boot to get a cost for hmac.
> > > 
> > > I'd use bootconfig for this:
> > > 
> > > https://www.kernel.org/doc/html/v6.9/trace/boottime-trace.html
> > > 
> > > So I've made up plans how measure the incident but not sure when
> > > I
> > > have time to pro-actively work on a benchmark (thus sharing
> > > details).
> > > 
> > > So I think with just proper bootconfig wtih no other tools uses
> > > this
> > > can be measured.
> > 
> > 
> > I'll disable this for anything else than X86_64 by default, and put
> > such patch to my next pull request.
> > 
> > Someone needs to do the perf analysis properly based on the above
> > descriptions. I cannot commit my time to promise them to get the
> > perf regressions fixed by time. I can only commit on limiting the
> > feature ;-)
> > 
> > It is thus better be conservative and reconsider opt-in post 6.10.
> > X86_64 is safeplay because even in that 2018 NUC7 based on Celeron,
> > hmac is just fine.
> 
> While looking at code I started to wanted what was the reasoning
> for adding *undocumented* "TPM2_OA_TMPL" in include/linux/tpm.h.
> It should really be in tpm2-sessions.c and named something like
> TPM2_NULL_KEY_OA or similar.

Well, because you asked for it. I originally had all the flags spelled
out and I'm not a fan of this obscurity, but you have to do stuff like
this to get patches accepted:

https://lore.kernel.org/linux-integrity/CZCKTWU6ZCC9.2UTEQPEVICYHL@suppilovahvero/

James


