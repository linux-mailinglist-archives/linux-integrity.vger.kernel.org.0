Return-Path: <linux-integrity+bounces-4007-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E89BB332
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE77281D62
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DC1B3949;
	Mon,  4 Nov 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuFL8XKO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBF1B21AF;
	Mon,  4 Nov 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719110; cv=none; b=AkHFf9EKglwfMbY7uXUxqEc49wShkQnwpXq7gFC2Vpbn0TLP1h/n9csyagj7iuWqQ8US5hmCZEb1z714p4/voHfFvGgGUPNDpGTWWeELcUaWGaswqdMEuE1K1uexuWhCb2f0q86r3Dg94wslBmrLAxFvlB52rplJpkXVs/NquOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719110; c=relaxed/simple;
	bh=yUN4pTjgAt/teXpZDdhqqndU+bpx+GiXtlAi/NpFemw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qsGFe1sOd/8DWogHIY0Mp/YSMI10+3mSwvAoNrchAmjqAGq+Tp6aKX86rK/TvDaYvTPW85cVJ+hoCPdeA4Qfr0X0FLCWKCY4fZHx1plGOoxFBNnhNf1ZWXH+edyjwrV3Ib8KgWNGISc9c7eS0R3CtiTEyGIfuVxGNbceHLplm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuFL8XKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1113AC4CED1;
	Mon,  4 Nov 2024 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730719109;
	bh=yUN4pTjgAt/teXpZDdhqqndU+bpx+GiXtlAi/NpFemw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZuFL8XKO6l25NJVkLEpOurQM27n7HkOKi6bFE+mzCOv2zT/o+ME9rKN6ci1WCEiF6
	 3Q3xji/Xd47dCxwGANHvK+boinpUQTVKWHpBeQBgDRx8sPL2exEoUh7C5FmuOeAouH
	 it3mme1YwrC9SACsZRcMOQ+otAw0BkdXOYj4HEA3N9d6TVVE966ERwq+dXxFebT12T
	 wJq+05GNfn9cvwnO+Fk39ock4Onr7wk7stLa1PQIx3w351VGnBKdJO1ONut1kLVT9B
	 2Gil0AiKLYb7hl0mJ3o7KliB7CwjcPbcH0sOWXDie1iVcr58Pz9mHK6w8FjV/00GDc
	 +A7GWjY72mToQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Nov 2024 13:18:24 +0200
Message-Id: <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
Cc: <x86@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
X-Mailer: aerc 0.18.2
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
In-Reply-To: <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>

On Mon Nov 4, 2024 at 12:57 PM EET, Daniel P. Smith wrote:
> On 11/2/24 14:00, Jarkko Sakkinen wrote:
> > On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
> >> It is not really my problem but I'm also wondering how the
> >> initialization order is managed. What if e.g. IMA happens to
> >> initialize before slmodule?
> >=20
> > The first obvious observation from Trenchboot implementation is that it
> > is 9/10 times worst idea ever to have splitted root of trust. Here it
> > is realized by an LKM for slmodule.
>
> First, there is no conflict between IMA and slmodule. With your change=20
> to make locality switching a one shot, the only issue would be if IMA=20
> were to run first and issue a locality switch to Locality 0, thus=20
> blocking slmodule from switching to Locality 2. As for PCR usage, IMA=20
> uses the SRTM PCRs, which are completely accessible under Locality 2.

Just pointing out a possible problem (e.g. with  TPM2_PolicyLocality).

> Honestly, a better path forward would be to revisit the issue that is
> driving most of that logic existing, which is the lack of a TPM
> interface code in the setup kernel. As a reminder, this issue is due to
> the TPM maintainers position that the only TPM code in the kernel can be
> the mainline driver. Which, unless something has changed, is impossible
> to compile into the setup kernel due to its use of mainline kernel
> constructs not present in the setup kernel.

I don't categorically reject adding some code to early setup. We have
some shared code EFI stub but you have to explain your changes
proeprly. Getting rejection in some early version to some approach,
and being still pissed about that years forward is not really way
to go IMHO.

> v/r,
> dps

BR, Jarkko


