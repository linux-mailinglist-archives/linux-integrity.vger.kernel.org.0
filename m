Return-Path: <linux-integrity+bounces-3703-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B49861F0
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 17:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387F01C21385
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 15:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177BF1D5AD0;
	Wed, 25 Sep 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0uVq6Y0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECDA1D5AA5;
	Wed, 25 Sep 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275805; cv=none; b=HV5adYf0PDUY3XBAXBeXBl4mbI1QvnODyt5qKNcZxeqln5b7B+YtMkFejQ59kQrn+lEsU2Q/UiyrqsT41ZIt9XxBiphmioyGAPjRkiujE1VuQQWXHQmL7bc1DNaK37jhqqEjS3LEt/eKL2nAd0AdvQhylzRdMOxI2eZhd52tL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275805; c=relaxed/simple;
	bh=A6lHYYoIUTwCFHtjTkUyIQbcl7VrwYZCEI8SuBc97jw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nBR3+nGmbF/99avLJtZttW+LkR7dN2C7EXxuWnsWke99Sst86Oz71/pw35tY9sivBAFc+35f89/V/IOdz1g3cASxHE10e2HjNLHXVRPli3CQmovoS+BcWjbnf5n0hNYSq5Ty9yHk9DaIYj1zfeRfzbhpmqbNrtGn4klhL3J8UQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0uVq6Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80CBC4CEC3;
	Wed, 25 Sep 2024 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727275804;
	bh=A6lHYYoIUTwCFHtjTkUyIQbcl7VrwYZCEI8SuBc97jw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=h0uVq6Y0lWaLgbnioXk5aBimJVyq//okFg6gUgX8oPqOeFq1iC8LzP10h+DFPi8wi
	 NkKLf15Aw0rb9S89ZqfNxMQmnsYH8tY8Gt0gFvTmYxcOrYqovqJpgmostLmd0b8dky
	 UJa2WM3C7AjpKqE7vs/j/+ZVwv0Bpmcv/QnrcDCnyjvnyeDJJw16DvooBCXA46PNDG
	 rpLOMoc/vHFqVe+X1FlXxcHzok0XFjvBP7dUAyEv7qtBDJdosAbVgebQI10ICW+DO7
	 2mDImCRJjNW1wE2xeJeirG8I0EFVF06GFGgojuw/bL1aUqAzPKuDRny7fBMiwE6TXl
	 cBJjhDcLJdFPg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 17:50:00 +0300
Message-Id: <D4FG64CUKGV9.1PWCC0FHOW21P@kernel.org>
Cc: "Milan Broz" <gmazyland@gmail.com>, "Eric Biggers"
 <ebiggers@kernel.org>, "Mikulas Patocka" <mpatocka@redhat.com>,
 <luca.boccassi@gmail.com>, <dm-devel@lists.linux.dev>,
 <snitzer@kernel.org>, <wufan@linux.microsoft.com>, "David Howells"
 <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "Tycho Andersen" <tycho@tycho.ws>, "Mike McCracken" <mikmccra@cisco.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
X-Mailer: aerc 0.18.2
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
 <20240924215910.GA1585@sol.localdomain>
 <df791a04-feae-4708-865f-193360b35fad@gmail.com>
 <D4F8UQ7EQ1AH.28Y6BJIM287S1@kernel.org>
 <20240925125717.GA653365@mail.hallyn.com>
In-Reply-To: <20240925125717.GA653365@mail.hallyn.com>

On Wed Sep 25, 2024 at 3:57 PM EEST, Serge E. Hallyn wrote:
> On Wed, Sep 25, 2024 at 12:05:59PM +0300, Jarkko Sakkinen wrote:
> > On Wed Sep 25, 2024 at 11:03 AM EEST, Milan Broz wrote:
> > > >> Doesn't dm-verity have a maintainer?
> > >
> > > (This reminds me of a nice comment from Neil about "little walled
> > > gardens" between MD & DM.  Apparently it applies to other subsystems
> > > as well. Sorry, I couldn't resist to mention it :-)
> >=20
> > Np, it's just that last and only time I've ever read anything about
> > dm-verity was 2011 article :-)
> >=20
> > I will rephrase question: does dm-verity have a user? ;-)
>
> It gets used for integrity guarantees in certain containers, where
> the layers of tarballs are replaced by layers of squashfs, with the
> dmverity root hash for each layer listed in the signed manifest, e.g.
>
> github.com/project-stacker/stacker
> github.com/project-machine/atomfs
>
> This is used of course to verify container integrity, and also gets used =
by
> some projects and products to create an RFS from such images during initr=
d
>
> github.com/project-machine/mos

OK got it!

I did some studying and query and to put short it is a merkle tree
for rootfs for devices like phones and tablets for instance. I.e.
when you modify only on "system update".=20

So... let's check the mainatainers list:

=E2=9D=AF scripts/get_maintainer.pl drivers/md/dm-verity-verify-sig.c
Alasdair Kergon <agk@redhat.com> (maintainer:DEVICE-MAPPER  (LVM))
Mike Snitzer <snitzer@kernel.org> (maintainer:DEVICE-MAPPER  (LVM))
Mikulas Patocka <mpatocka@redhat.com> (maintainer:DEVICE-MAPPER  (LVM))
dm-devel@lists.linux.dev (open list:DEVICE-MAPPER  (LVM))
linux-kernel@vger.kernel.org (open list)

Mikulas, I guess you take care of this if I just ack the return value?

If that holds, and given that I actually know what verify_pkcs7_signature()
does, I think the code patch makes sense to me, and thus:

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

I.e. I think it uses API correctly.

>
> -serge

BR, Jarkko

