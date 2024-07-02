Return-Path: <linux-integrity+bounces-2970-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC94924C79
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 01:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B64A1C22002
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 23:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5FB17DA06;
	Tue,  2 Jul 2024 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qamueW1+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313017A5B8;
	Tue,  2 Jul 2024 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964645; cv=pass; b=bRhrvS4Wq4sMjOsrh93N6YRb7nzDFO1tDyEQedubmxkbF1GcM4Zjfr0GgV0ITHxmU5ssyT5jNrBtiOJj4EbFGmkSh40XcRCYF+EYGAwndBIdxu/hGoK+GTJiLmMfE37J6XMtntp+rusD+68N1806wTSZrpgAChaszp38eUwzv3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964645; c=relaxed/simple;
	bh=fH5bbDhEXvtMJL7qCu+hVIBvgWhvFakxFwuRo7NuQWA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IfIvFRiDnb79gQFq/VrFph+roC9UsbHKwmtU9DWFkK1atIhbp2rDId8NcYBkh6zBLc7YdImmBnWIxV2elS9ZSlwzqhDaTSPzpgakDEG6rH6M6i/I/6PYbsUKM5Dyj+EzkjFifOsOzYU+ZIssrCrMTsCa9IgoXRDPZgXZe/PCADE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qamueW1+; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WDKZz5vNwz49Pxq;
	Wed,  3 Jul 2024 02:57:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1719964636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae2vVQG57Q2h/mntUgu3XIHv6iZuHpnmF7N11wBhPI4=;
	b=qamueW1+pPabdyRKgBxC7qWrdRKjykyDIwMIfbFs913fDpOZsYUTA/42GBC8eO3c+c13oc
	5tBbt0NeNqzccGG6jI0ktw1yvpNlZKNJZQAk6GnTjA3paumehxdYPYcNcnbHSkVmds0Tzd
	eTrFPsGw7dy3Wb85zYtXUySHmEt+PbvkAYp3wArDZ8yv64Z5Lg8naeO801P7N07ltdpmgb
	UCsOu+yD9ZHvKVZ4JThrKy/YK1QBE75sXuvqjHWHJI2wrJCwFRjs9bL6Id6P2iKGrvx+Uf
	XeA+EJPqFqX0pnyYtYMg6C3OQU/Vr160YOMnv3irfZ8C/sqR5/nffBt6zZ63eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1719964636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae2vVQG57Q2h/mntUgu3XIHv6iZuHpnmF7N11wBhPI4=;
	b=XttoVwwjlGfFZXD2ZlDbbzUeMhKlHN0r1R+zoJ8h30c364lpxi1UIGExZesxoPsLsN2hJf
	2/1FgSx1DuurRSPuTPbpQqdIOhNRjmbu4c3lNE3IC0Tc68QDxf0vNjk4ETS6satC7kc2Ct
	sCK9yY+pOHnTxKKWsci9wHqfaM2gGk7Nggxao/tGNc7POWH1RMtwosCz5qxzpm+NGuZlxb
	orF/RTMk09KWYrwhDKVzy5NnLvNmaquuTSA8P+DfZ8fwP/SVpRIK8OS9Vm0g1NrlnJXhgX
	a6IktxzbZOt1WkrUkXT6kD17UCfxF1J3JDQhBpGVOS0f7s0sFU8N7GnK1pxXtw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1719964636; a=rsa-sha256;
	cv=none;
	b=VTg+xNP14IPNLh13ojFJr1rF45cHQdvj5jiTOYgV5MnHHvovJ45SF7nWY0F1ld9J/MsxaM
	fKNVymTdkQ1RHy9SbQwGzMeQxk+m6EUcWt2Owhm/StEEOdKo46kg5CM0P2jFqV/IdLZef0
	xir+o7algRklWUgVBTwPKqqpOJtHqPihxsAkbWL7516jJlRWY5uNIGbIUD6xID/bI/+L3Z
	NKZsCH8GohGH4ri04BZNLhjC86hn6/RsVZhuzZfdE300Bks1oFbBgF+vDmqqE9b6eZQeuS
	qOztWgPFO60Vg0E/5dKXm8HMvsrWsGQNhiRBLc2/dPXnhHiTBYfvhKlgYQN0xQ==
Message-ID: <85f882ff079554c41a73d8ad4275072c5229f716.camel@iki.fi>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Stefan Berger <stefanb@linux.ibm.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: naveen.n.rao@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 03 Jul 2024 02:57:14 +0300
In-Reply-To: <b7559dbb323d16fb334f8f8f35b8fda3fb6e481c.camel@iki.fi>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
	 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
	 <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
	 <9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org>
	 <53d96a8b-26ef-46a3-9b68-3d791613e47c@linux.ibm.com>
	 <D2EFNJTR80JS.1RW91OVY1UH1N@iki.fi>
	 <e7db74a0-cd5c-4394-b87e-c31ea0861ea1@linux.ibm.com>
	 <b7559dbb323d16fb334f8f8f35b8fda3fb6e481c.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 02:48 +0300, Jarkko Sakkinen wrote:
> On Mon, 2024-07-01 at 15:14 -0400, Stefan Berger wrote:
> > Applying it is probably the better path forward than restricting HMAC t=
o=20
> > x86_64 now and enabling it on a per-architecture basis afterwards ...
>=20
> Why is this here and not in the associated patch?
>=20
> Any, what argue against is already done for v6.10.
>=20
> The actual bug needs to be fixed before anything
> else.
>=20
> I can look at the patch when in August (back from
> holiday) but please response to the correct patch
> next time, thanks.

Next steps forward:

1  Comment out sessions_init().
2. See what happens on x86 in QEMU.
3. All errors were some sort size errors, so look into failing
   sites and fixup the use of hmac shenanigans.

BR, Jarkko

