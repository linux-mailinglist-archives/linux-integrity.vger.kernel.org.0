Return-Path: <linux-integrity+bounces-4319-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDD29E95A8
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2024 14:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361DB166AA5
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EBD22ACE5;
	Mon,  9 Dec 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IztltQZe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B722ACE3;
	Mon,  9 Dec 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749119; cv=none; b=uVR/AKjCCb7om7ShQhU3qjC7282o09KCD7XvEcYrBpaRvCHJ09WwpZCG6hA7QE9ErnO5Vh4d7sJI3Z9jGTnkilnjRwjvtMUZUHdHUACTqtVXPewDpbtaUeSF3/C307OI5b8hnn3mbCGx/3k1FixaUH0+9fJoKnAQE5OXOGGA7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749119; c=relaxed/simple;
	bh=l6YxVhjjcPNXX3KSThtrFQnv9KW0AjVXF9OlJ6931KE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TyhJHGuV7y6kKX6njCQND4HqEIfnGwxoQ2pDBwPv6dPt9mosxMeHmTRHaFleRDWQV+rZyFZe+85DzhSpaLit4vB6Tn4ClLjLsyIzn6AUJCdvVLraZdQIc5ANsLIl7yfp+aS0dUHnaNyWP0ZE1Kss/lYFet8Lj30f+pOZEsdAP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IztltQZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A72C4CED1;
	Mon,  9 Dec 2024 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733749118;
	bh=l6YxVhjjcPNXX3KSThtrFQnv9KW0AjVXF9OlJ6931KE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IztltQZeEnfq3iGifVzcriBgdPEb0+E6XtU55bFpXDEhSP3M7o9rZrzcL9SRsLPx/
	 yxspvMGP9HJ+Sw449LZVeq782KIwxU1t7Ll1WkILEoCUPO92LU+ymmXNdEtiLOCjyr
	 AGTOudAaNcWNIC5D2LbV1Af5f6A3e5PMoNzOUzjPgJJ1jOO2hpzA2EQ0FUUFJ0Yflv
	 A00+fDQnz6EEer1inW3rFY4OeO0rhYoP40SrR/yprV9+AhanRVRJq+oBcn0mjS/jq0
	 7/1q4zPHI59e8VktfH4m/1gv5hAZ/YQJrOX9rF3dXdV89jRNj2gBGoX0uc7DmD1GSM
	 cqKrM2te6hf/w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Dec 2024 14:58:33 +0200
Message-Id: <D676RN3ZW2H1.2JNMSLG0WGS3V@kernel.org>
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

On Tue Dec 3, 2024 at 12:15 AM EET, Stefan Berger wrote:
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

The problem is that we don't know yet but we do know that it previously
worked.

Or more importantly: that is the hypothesis. So it would be in all cases
useful to create such patch for A/B testing at minimum.

BR, Jarkko

