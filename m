Return-Path: <linux-integrity+bounces-1794-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47338806D4
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 22:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06F8282279
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Mar 2024 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62483FB9F;
	Tue, 19 Mar 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7lWRWHU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B463EA77
	for <linux-integrity@vger.kernel.org>; Tue, 19 Mar 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884293; cv=none; b=cwgRva5Bfjp1dbAo69Xm06mhIsFCrEfeNzbnxOCbqincuSB1fNOuPt2NJEEFiZP3BS6q2mmhkus0JXhchyWkbNjSW5sviPPWyBmyRuPHrOI0SnFcRbzmKqWdE711f0udWrs2IHkA/jUJXoPapITEsrnWvGgQxbPIRM2cgVI6O7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884293; c=relaxed/simple;
	bh=16SJgNKmijffl1cnAmVSvsXjGGY1XhMwMnVdf3nMdH0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ukGmxFhW+A+SQXuYuB/yCq/QWnrRq+BtmWBPBFWK6WTxhM5vY9d/A3a6eKm4tNydi+hhmBf8k9ow88lLU24a4xfJBbuzrPGJY2q2lZxLzzfznZ7o6FNJRn0aAbtVWYX5AEg86Ajj7QRLnK9xDBOkijX90qTPpaRsfJjioEJYcj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7lWRWHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0621DC433C7;
	Tue, 19 Mar 2024 21:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710884293;
	bh=16SJgNKmijffl1cnAmVSvsXjGGY1XhMwMnVdf3nMdH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7lWRWHURrd8ZL0lt/3trIZjog42L6i63wy1YC+rtN+e4XNdqGEWXuuxoCGki13nW
	 tTlYIPTQY3ySlcEpv7mCpSb00eJFdxuqNIsJqXaYOi626k3gNaIBD8xrP01PSq53zA
	 qbbCCGbGALTvLHm5dZkUwsuceFG5E91K4jdLloMADDkHbvYObYzNsyJw4tNVH5W+oE
	 JAu4HmuZ8R7mIDBOhwe9BQrlq+wnl63Ykj3vfGoo6QBxj4wQLbBUvEHv/k7xptqXTL
	 Kyu4Lh5pSEtPptyvjpKP0j1vZxrQklUJ1a8fs82g1hY7u/YEZ0JWYJz2CYxuzK4A7Z
	 dv7Of3Jnce1yA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 23:38:10 +0200
Message-Id: <CZY1V4JMNR4U.3GTTNERY5MA6K@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Adam Alves" <adamoa@gmail.com>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Fix suspend/shutdown on some boards by
 preserving chip Locality
X-Mailer: aerc 0.15.2
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
 <20240307224957.29432-1-adamoa@gmail.com>
 <CZR6VBRUEPKW.26B7HTOJZ0ANX@kernel.org>
 <CAHwaaX8bWOFW2bi6tKpxgf2Cp_vKg5Eqhq618VEur98s+OmD=A@mail.gmail.com>
 <CZXZQ544YVAZ.UHT0KAH0B7J2@kernel.org>
In-Reply-To: <CZXZQ544YVAZ.UHT0KAH0B7J2@kernel.org>

On Tue Mar 19, 2024 at 9:57 PM EET, Jarkko Sakkinen wrote:
> On Wed Mar 13, 2024 at 7:02 PM EET, Adam Alves wrote:
> > Hi Jarkko,
> >
> > Thank you very much for kindly reviewing this proposal.
> >
> > After one week without any issues with my PC hanging, it happened
> > again. It seems that the fix I am proposing is not final (it only
> > reduced the frequency since it always happened when I shutdown after
> > couple hours of power up time and now it only happened after two weeks
> > with a similar usage rate).
> >
> > I will share with you the data you requested below.
>
> Thanks I'll definitely check these in detail.
>
> Any possible bug fix (if we decide to fix anything) is tpm_crb.c
> including possible kernel command-line parameters or whatever. The
> current proposal affects all the possible pieces of TPM hardware so
> in all cases it is unacceptable.
>
> Do you have dmesg/journactl transcript? Did you try to update the
> firmware?

OK so I do have ASUS motherboard and my TPM2 ACPI table is almost the
same match but:

BIOS Information
        Vendor: American Megatrends Inc.
        Version: 2212
        Release Date: 12/13/2022
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 24 MB

Where as in you dmidecode.txt:

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 1601
	Release Date: 02/11/2022
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 16 MB

So at least the BIOS version is older. Can you update BIOS and see if
that could possibly fix the issue?

Make sure that it contains update for both BIOS and Management Engine.

BR, Jarkko

