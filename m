Return-Path: <linux-integrity+bounces-2972-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9140924CCD
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 02:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA31285339
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 00:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701BC2107;
	Wed,  3 Jul 2024 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Hwzk1ORC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1AB1FB4;
	Wed,  3 Jul 2024 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719966865; cv=pass; b=A2sGz7aPH2iuvow8MAZRI/qKiZN0T7DzZOym0tMZuKDQTt1sfpj1n5rSy/r2VZ97wjL6CvDNX9GWN5pYwLRyeo50mOrcIkahxiQR8VBDPHXGETjR2Veq1SCrEKmVzc9iGCNOHfaJfQD2bkBfDFsixFE024wEr6IcQdTOFkuQJ/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719966865; c=relaxed/simple;
	bh=ywzEqGjjGM7mIn1VawbrZuz00V7sB9FTsYmYjFiztFQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=QqOjblOdkwK45AqFsxGu86Bz/lPnHFECfgH5AKXXsXelLS4pms6nm3kYK4/01p71eQojwlgABCdM+mH/SWjwY0ePuIVhDlsHMZmem5Yu2pHVihhJ5en50/2KEvm15cwHkEvHoeazDl2J8lMhf34+yu8V87BQoSnx60WAGbQJzHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Hwzk1ORC; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WDLPn43c7z49PwY;
	Wed,  3 Jul 2024 03:34:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1719966861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaV4tuk1WbugWdGR34mCTzuCrF1HR/X8Zy5U2pP20mY=;
	b=Hwzk1ORCDLDo+ZiLXJZ9VZDcBs7xVnOnpn2RghTPQxZfI25659jdF6jLTsfX00r63/BfUK
	4LJpl2qkg+FsZzTi6qEj7aJZ+qm+T3Q8QG08lI9lpRhGYIid5OcV9mk9dhF5fKgG5cAb+r
	fOJEmy8yHRDQ23Vo27z6NynYLgwq3IUaJkTe7bAw4ek5Qe/33BCx2b2pveBwT/BVLlChT+
	SRxjiCB9EixM2pioAv2iotHdA1II0Mt9DbC4uGjOW/vyoPOM2mUUykK7UJIhSr7WzrAqF4
	vIvoYYMuxgqWZ/0OmKOUJElMv3Hc1HTYrq3uBKU1m+Qj0+zfJSR+r5JjUG1Fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1719966861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaV4tuk1WbugWdGR34mCTzuCrF1HR/X8Zy5U2pP20mY=;
	b=r0a24xe0CGr61iBcz2UuPxJCeXSNlnpKlc2FHYz2NFz2gAk1FYG+s7W0I+0Vyyo4Y9gDBX
	sE/pwlTG1yW3ijfHKJI6XsbchMT68iiEDm1djjK4WI2XX2EWsztLDnsqKgCnxd0oed7BOU
	FMH2F9TXYvdseY0vdsxthj5JIXYUhOUr3PkgACLFE80nMRaXnGzwmu8fNeGUZPdd+1fm41
	six+W33Kc1zTdF76mrSrF4ErWJHJ1pd0C4nqzmwmNeEgBXnQYeOTUOskUFN3LeTuZQxQMI
	PKTkAcTtfQuHdyAMiDbtuiAha0SUQQs0lMrgUWfHFAW5/hn3Q+D1/xx7/2bQlQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1719966861; a=rsa-sha256;
	cv=none;
	b=Vu1Tcl6h9Orp81BbUjw627PbKr6gMUDh/2r3b4xEIAn2hDle019jRr3F6WBTIPEv3lah3I
	6/0AdEeDW2sxRnvNFbE6UP90xd21TXSR4dPWn0HN3fU8ejGP826iWNmDmsei6oxby5Y058
	kLk/cSbUN2JukeWIZHt5qZiZFRHd8WqMG04T2WD7KvlMaEKBRixgP2RZYav3GztbSwg8L8
	2vOY25jM8l5yC90/mvjOYiojzXDbi4Qy5gnko3qORWiEc/HuBk7T591AvyE00GoUGANF4D
	yfD+D3zH1zV3mHH2JEOW19bV3R1I8s7BXPooVyDvdzuBWY++Kl8DY9EuSLWKUw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jul 2024 03:34:21 +0300
Message-Id: <D2FHD82R8YAC.YBL9FAIVMBWL@iki.fi>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <naveen.n.rao@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.17.0
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
 <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
 <9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org>
 <53d96a8b-26ef-46a3-9b68-3d791613e47c@linux.ibm.com>
 <D2EFNJTR80JS.1RW91OVY1UH1N@iki.fi>
 <e7db74a0-cd5c-4394-b87e-c31ea0861ea1@linux.ibm.com>
 <b7559dbb323d16fb334f8f8f35b8fda3fb6e481c.camel@iki.fi>
 <85f882ff079554c41a73d8ad4275072c5229f716.camel@iki.fi>
In-Reply-To: <85f882ff079554c41a73d8ad4275072c5229f716.camel@iki.fi>

On Wed Jul 3, 2024 at 2:57 AM EEST, Jarkko Sakkinen wrote:
> On Wed, 2024-07-03 at 02:48 +0300, Jarkko Sakkinen wrote:
> > On Mon, 2024-07-01 at 15:14 -0400, Stefan Berger wrote:
> > > Applying it is probably the better path forward than restricting HMAC=
 to=20
> > > x86_64 now and enabling it on a per-architecture basis afterwards ...
> >=20
> > Why is this here and not in the associated patch?
> >=20
> > Any, what argue against is already done for v6.10.
> >=20
> > The actual bug needs to be fixed before anything
> > else.
> >=20
> > I can look at the patch when in August (back from
> > holiday) but please response to the correct patch
> > next time, thanks.
>
> Next steps forward:
>
> 1  Comment out sessions_init().
> 2. See what happens on x86 in QEMU.
> 3. All errors were some sort size errors, so look into failing
>    sites and fixup the use of hmac shenanigans.

For anything "fast" or "quick" I think this really the only
possible sane thing to do right now:

https://lore.kernel.org/linux-integrity/20240703003033.19057-1-jarkko@kerne=
l.org/T/#u

There's also bunch of other drivers than tpm_ibmvtpm so better
to limit it to known good drivers.

I can take at the actual issue in August and will review any
possible patches then. This one I'll send after my current PR
for TPM has been merged.

BR, Jarkko

