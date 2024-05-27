Return-Path: <linux-integrity+bounces-2654-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D998D05BA
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E406D28029F
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D5615F30A;
	Mon, 27 May 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcB2e5iU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560415EFD0;
	Mon, 27 May 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822117; cv=none; b=JipZwg2Dz56NWbBS5IgVruHZxY+gw1sDQlH49r/zn5ibUoCWbcTrfdTJz804QUqVpQN2nwSgslwoy5+JAhqNZtlGJNz2jvap/yGX4qPEfcTdcITeWR/F0WKtxEC9pSey2DDbC8tKT68xsMg78LyWwgSwkN5D62VVSAYLRW/RSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822117; c=relaxed/simple;
	bh=K7M4dLSIKdMi6+X3XLgLzDWX09De+whRQvoqNYwdGJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=sYkGCuvdqZYcawqF6+esACqB188xJ6I4TZAw0bTQ76pzV0Un4nrytx8vFLveJF7FVg8RubVMe9j1MSVw+QmlQjyR13L8Y9GmaOzEjcYiznPApUEWZ01bV/H/pHcITh8N5b/2i89hGac5F6Jbv0ZPlhUjsVHjBHMc4k583RC1OaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcB2e5iU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50361C2BBFC;
	Mon, 27 May 2024 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716822117;
	bh=K7M4dLSIKdMi6+X3XLgLzDWX09De+whRQvoqNYwdGJQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=CcB2e5iUdnVk9MQsJmzq2v25j7KC1fepkTQUm3AAwdI1eZPy+H/I3WoELa9oWeF7v
	 SkuPGd1pzptmOPXquStexNdx9ZHHzuHXWfMMpvXn7eXFcxeJ2uvdeLTorua9sI5JIt
	 zw8JhvNs15RbLehKWb01skT3schgd4OLD0EUJFF/V0QaGtzqwRXNPkktoZD3SfacD6
	 P5YC5jV82KbeNQKjrN3k7KJGTw+MjH5LqaBaV5TLFpcUe0oIkZqIE/EyOSZ1DXYxcX
	 SW7v6XDNEChWzmZDJ9G6FTJ0AgacVcT5/mpLqjI/fwn7rNeU9Fuoq1h35pcbynLdLp
	 RpOMXwiFc9b7w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 18:01:52 +0300
Message-Id: <D1KINAE5E2MH.729CM4ABV5VN@kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Vitor Soares"
 <ivitro@gmail.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
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
In-Reply-To: <D1KIFPNBNGKH.IJKFRXH8WINU@kernel.org>

On Mon May 27, 2024 at 5:51 PM EEST, Jarkko Sakkinen wrote:
> On Thu May 23, 2024 at 10:59 AM EEST, Vitor Soares wrote:
> > On Wed, 2024-05-22 at 19:11 +0300, Jarkko Sakkinen wrote:
> > > On Wed May 22, 2024 at 5:58 PM EEST, Vitor Soares wrote:
> > > > I did run with ftrace, but need some more time to go through it.
> > > >=20
> > > > Here the step I did:
> > > > kernel config:
> > > > =C2=A0 CONFIG_FUNCTION_TRACER
> > > > =C2=A0 CONFIG_FUNCTION_GRAPH_TRACER
> > > >=20
> > > > ftrace:
> > > > =C2=A0 # set filters
> > > > =C2=A0 echo tpm* > set_ftrace_filter
> > > >=20
> > > > =C2=A0 # set tracer
> > > > =C2=A0 echo function_graph > current_tracer
> > > >=20
> > > > =C2=A0 # take the sample
> > > > =C2=A0 echo 1 > tracing_on; time modprobe tpm_tis_spi; echo 0 > tra=
cing_on
> > > >=20
> > > > regards,
> > > > Vitor Soares
> > >=20
> > > I'm now compiling distro kernel (OpenSUSE) for NUC7 with v6.10 conten=
ts.
> > >=20
> > > After I have that setup, I'll develop a perf test either with perf or
> > > bpftrace. I'll come back with the possible CONFIG_* that should be in
> > > place in your kernel. Might take up until next week as I have some
> > > conference stuff to prepare but I try to have stuff ready early next
> > > week.
> > >=20
> > > No need to rush with this as long as possible patches go to rc2 or rc=
3.
> > > Let's do a proper analysis instead.
> > >=20
> > > In the meantime you could check if you get perf and/or bpftrace to=20
> > > your image that use to boot up your device. Preferably both but
> > > please inform about this.
> > >=20
> >
> > I already have perf running, for the bpftrace I might not be able to he=
lp.
>
> The interesting function to look at with/without hmac is probably
> tpm2_get_random().
>
> I attached a patch that removes hmac shenigans out of tpm2_get_random()
> for the sake of proper comparative testing.

Other thing that we need to measure is to split the cost into
two parts:

1. Handshake, i.e. setting up and shutdowning a session.
2. Transaction, payload TPM command.

This could be done by setting up couple of kprobes_events:

  payload_event: tpm2_get_random() etc.
  hmac_event: tpm2_start_auth_session(), tpm2_end_auth_session() etc.

And just summing up the time for a boot to get a cost for hmac.

I'd use bootconfig for this:

https://www.kernel.org/doc/html/v6.9/trace/boottime-trace.html

So I've made up plans how measure the incident but not sure when I
have time to pro-actively work on a benchmark (thus sharing details).

So I think with just proper bootconfig wtih no other tools uses this
can be measured.

BR, Jarkko

