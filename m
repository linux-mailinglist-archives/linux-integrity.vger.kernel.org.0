Return-Path: <linux-integrity+bounces-2951-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC191E3F1
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932851C21C20
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0D167265;
	Mon,  1 Jul 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuSKZcGD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EB158D7F;
	Mon,  1 Jul 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847367; cv=none; b=KVbJbQwlUUNfYL2CBeEiNcs9Uqoe4gfq8N8HNNiztx388mxaxh3wi/ivSKJixF1N+IEiE4uaw4wllqt4iTcvc48zQfXgS8pBW+rP9IpXqgXNPdXZ30M3dkFapL6F2B+jAaMmX52wnba8HiBxuxzHH4EYKugX5m0U9kS66vczZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847367; c=relaxed/simple;
	bh=stsqNjcBtVTaNvoSI47EdoM4mGvxzLnZJvbW9mPkCtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKh/oXRiQCbXY73t/mrOtgg127Kr7glsBXi1E8+cYjMtoC34k3pfe9HbUHoVNQmFEuAUq8ntn+B4ConUChsG2t02ZarZ5NzXvlbYGVi6WDAPJoqrbingbu31R+OkzkEX9Pyyq3mMHRJvEYr4RGLsWw7vQZCFHex+IZVv++pAtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuSKZcGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A10C116B1;
	Mon,  1 Jul 2024 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719847366;
	bh=stsqNjcBtVTaNvoSI47EdoM4mGvxzLnZJvbW9mPkCtI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tuSKZcGD5JfgmUY/kbcDLt95zePIcfcCnlBKKRTLe7XtcyRXvFRlHYJGk4a7IAeXh
	 XSUlmOFMVjHf/Qgj9aCCuBO5RVyTLsuTxxB/Q1s7mlOGlZmnrXcbYvza6/YEmAZEvc
	 FlUEYTyOKWklRCGbf/GGXupL2TgmmwrV85x82iLokynwoQChODdTN/hfB18iJMi5+b
	 ir9tsoFZZVtME3DeGFHXsvljfzFWBlLkeKcW34s4VpGA1rmdoO/yEIHcHr8ZAwLkUV
	 DHTF5yRzeDe87GQ9SgvsOtQsCWBJZpkYp2Qrono1ohQ27yTZQvyTYozkssN+scvbwL
	 oIh9PyTcKgNIg==
Message-ID: <9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: naveen.n.rao@linux.ibm.com, linux-kernel@vger.kernel.org, Stefan Berger
	 <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Date: Mon, 01 Jul 2024 15:22:42 +0000
In-Reply-To: <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
	 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
	 <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-28 at 17:00 +0200, Linux regression tracking (Thorsten Leem=
huis) wrote:
> [CCing the regression list]
>=20
> On 20.06.24 00:34, Stefan Berger wrote:
> > Jarkko,
> > =C2=A0 are you ok with this patch?
>=20
> Hmmm, hope I did not miss anythng, but looks like nothing happened for
> about 10 days here. Hence:
>=20
> Jarkko, looks like some feedback from your side really would help to
> find a path to get this regression resolved before 6.10 is released.
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

Sorry for latency, and except a bit more slow phase also during
July because I'm most of this month on Holiday, except taking care
6.11 release.

This really is a bug in the HMAC code not in the IBM driver as=20
it should not break because of a new feature, i.e. this is only
correct conclusions, give the "no regressions" rule.

Since HMAC is by default only for x86_64 and it does not break
defconfig's, we should take time and fix the actual issue.

BR, Jarkko

