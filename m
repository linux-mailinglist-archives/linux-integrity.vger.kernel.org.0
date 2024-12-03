Return-Path: <linux-integrity+bounces-4273-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD39E136C
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 07:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB1A160320
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 06:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D211862BD;
	Tue,  3 Dec 2024 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXz/mLSB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75741183CBE;
	Tue,  3 Dec 2024 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207887; cv=none; b=FqPjv6zyJCraBNa4IL3loPEblkJHYC7irXoz+XZ87UKb0slc+nVJoim2B6/JzcGnDr7ABcx4WCJTOliT5VbmlseQa9YZcYmcRyMZyIqvmV19nt6hm6dJmz/lZ3yd2ow4gOCFTj5hk/2M4BJXrcm3AugCyRQaDSZCcUxjkATcS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207887; c=relaxed/simple;
	bh=P1NNfEKNKNDLAevqjUa8oUcSnkwU53Z/TBjQw9BmQfo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VtfuHamUzOD79huX8DkXIcpQ3TsA4Yp+e9XudQclTwmcRJ1/q8U1UytpD8k8CDwWaw2Vv7SDrA5sz1RMjmvZbH4kj6M2nKefHouYsk6Wr1dkKZHF5o21L2B4+0iJ7FVt23F61PJlCEEaZWf3mKwEivNOoP4X+KEw/OkoGq9IOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXz/mLSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97683C4CECF;
	Tue,  3 Dec 2024 06:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733207887;
	bh=P1NNfEKNKNDLAevqjUa8oUcSnkwU53Z/TBjQw9BmQfo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tXz/mLSBpVjIekJQC5Bqibjiq0InYtSCGqxv3vOexPs++FgpI0y6TaGPFBxBLNM33
	 RgyFZRj0ChvDZUUw5j+Wtx4+Lo9nSzzImD1BF1I2kVjUMpfVARzQRRO95FHQ4MUlTL
	 XUP3YbmhZ46q9fhWilUOkV14HczBDgVV72GmJOZI7WSM7aOceo5dib5gXCgNZVYzPQ
	 Xs+i2B0d5RHyYtkTXHIOkxoogKrt72r92p6qaK4HSo3oGGu3xpucakWMQrAdVq9Xf4
	 GNvL4adbfV9jExE3Uqjrb0B4YsEI+J/Y0nPJT6N/oatCiDc0mqjp0EMBbRKRT6Zwi8
	 2WuqG097msy4g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Dec 2024 07:38:02 +0100
Message-Id: <D61UX1CMHLZ5.27V9844S1S1D0@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED] tpm: Popping noise in USB headphones
 since 1b6d7f9eb150
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Christian Heusel"
 <christian@heusel.eu>
X-Mailer: aerc 0.18.2
References: <7d052744-4bfa-40bc-ba06-1b4c47a5eb87@heusel.eu>
 <D54YWMOV7KOO.2X0N035UHEFBD@kernel.org>
 <b3a01060-f59b-430d-afcc-48c5ec628bcb@heusel.eu>
 <D5Z62H0XCOQM.J4V5ZDH9E7C7@kernel.org>
 <ce7fa562-7cb7-4adc-934a-560b94ce44f0@linux.ibm.com>
In-Reply-To: <ce7fa562-7cb7-4adc-934a-560b94ce44f0@linux.ibm.com>

On Mon Dec 2, 2024 at 11:15 PM CET, Stefan Berger wrote:
>
>
> On 11/29/24 9:44 PM, Jarkko Sakkinen wrote:
> > On Tue Nov 26, 2024 at 1:42 PM EET, Christian Heusel wrote:
> >> On 24/10/25 05:47PM, Jarkko Sakkinen wrote:
> >>> Yeah, this is on the list.
> >>>
> >>> See: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383#c5
> >>>
> >>> I had a fix for the AMD boot-time issue already over a month ago
> >>> but unfortunately took time to get enough feedback.
> >>>
> >>> BR, Jarkko
> >>
> >> I'm not sure if this is supposed to be fixed, but AFAIK we hoped that
> >> the patchset that was mentioned in bugzilla also helped this issue.
> >>
> >> The reporter said that the bug is still present in 6.12.1, so this mig=
ht
> >> need further poking =F0=9F=A4=94
> >=20
> > I'd suggest a workaround for the time being.
> >=20
> > In 6.12 we added this for (heavy) IMA use:
> >=20
> > tpm.disable_pcr_integrity=3D [HW,TPM]
> >                          Do not protect PCR registers from unintended p=
hysical
> >                          access, or interposers in the bus by the means=
 of
> >                          having an integrity protected session wrapped =
around
> >                          TPM2_PCR_Extend command. Consider this in a si=
tuation
> >                          where TPM is heavily utilized by IMA, thus pro=
tection
> >                          causing a major performance hit, and the space=
 where
> >                          machines are deployed is by other means guarde=
d.
> >=20
> > Similarly it might make sense to have "tpm.disable_random_integrity"
> > that disables the feature introduced by the failing commit.
> >=20
>
> I am wondering what could be the not-so-obvious root cause for this?=20
> Could it be due to a (TPM or RNG-related) lock? I guess the audio=20
> popping could occur if an application cannot meet timing requirements=20
> when it runs into some sort of blocking lock...

I'm travelling this week. I'll take a look in detail next weke. Obvious
thing is that latency has rised on getting the result for TPM2_GetRandom
but it should sleep while waiting. I.e. not sure what causes "busyness".

I think in general having disable_* for trusted keys, random and PCR
extension i.e. features that bus integrity protection touches would
be great for debugging these issues in all cases.

BR, Jarkko

