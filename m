Return-Path: <linux-integrity+bounces-4563-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C943FA1151C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 00:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8897162DDE
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 23:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04420F973;
	Tue, 14 Jan 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPi/+o8k"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB41DFED;
	Tue, 14 Jan 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896352; cv=none; b=W1/lz6eZFo+NyRuzl3UMdiEyVAa4+N53nJuU7jhZVwr3byR535X64M144y86Nr04lTBnYHqALieQH9YJ/YfKWL+BoPIV1T+sMb2dazGsBUzvkc8yapVZAh5h0I0RN3iPydbvFR0WtmniRnongm2PlpIv5QGv3I3DUxNc9wRgfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896352; c=relaxed/simple;
	bh=+6fYoIfCVbeKXbf6l/445oQAzOlZv0eDKIAIpz8w7lQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=amareFSla8p1IrjBGKFAukhD5UOVnqTcITmfxMnQUZlYGBfuKOjasRiGMZ0E58vspJ9YUywFOg1akMahVFrgRARzOP/sLW0TSdjsHdR4yq6SXmem1yazTXnJLQ2xtfKBmc9vuzHZGA09eucJkey4fo7gj2xH2+rkSpgIshBOnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPi/+o8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE81C4CEE1;
	Tue, 14 Jan 2025 23:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736896352;
	bh=+6fYoIfCVbeKXbf6l/445oQAzOlZv0eDKIAIpz8w7lQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gPi/+o8kwi5ao1NAIsO/ZXHG/yliKoGn7I84K/hz2mNZrss3rhGimoVOfad4MGyVZ
	 Y0ZvLoRNoZs8OH99DpOuiQpg8P0Ph1Ys6jVb25Sb6Czi63/Pmpln5rwYZMddYeF4qO
	 uNzf1e8XRcNq1uzhz9cKnxcViyxOhJWKKaszrX8qsgSF69+C77UoYSbnWABw1S4IvI
	 C1IXetoJ/UHAQoFSKb1cvQMJwL3QLsLfVvFFV4mVGcePQqTVwPOaARURcbfspM3DM0
	 yoU7FBj454lkoJFr+yIcqHQz7RmpWRyT1sNvGd1fihl0GJRgicXVWQMFmfiBcxgF1X
	 /LOFpFcBRY95g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jan 2025 01:12:28 +0200
Message-Id: <D726DAWHLOGW.3TR2LCJ936OG7@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <james.bottomley@hansenpartnership.com>, <linux-coco@lists.linux.dev>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Peter Huewe" <peterhuewe@gmx.de>, "H. Peter
 Anvin" <hpa@zytor.com>, <linux-integrity@vger.kernel.org>,
 <x86@kernel.org>, "Joerg Roedel" <jroedel@suse.de>,
 <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Claudio Carvalho"
 <cclaudio@linux.ibm.com>, "Dov Murik" <dovmurik@linux.ibm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefano Garzarella"
 <sgarzare@redhat.com>, "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
X-Mailer: aerc 0.18.2
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
 <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
 <D725TPWOVBUL.1DJAOZ0QL0RNH@kernel.org>
 <D725V628UV87.31SUEYVF9IUUC@kernel.org>
In-Reply-To: <D725V628UV87.31SUEYVF9IUUC@kernel.org>

On Wed Jan 15, 2025 at 12:48 AM EET, Jarkko Sakkinen wrote:
> On Wed Jan 15, 2025 at 12:46 AM EET, Jarkko Sakkinen wrote:
> > On Tue Jan 14, 2025 at 12:42 PM EET, Stefano Garzarella wrote:
> > > Hi Jarkko,
> > >
> > > On Thu, 19 Dec 2024 at 17:07, Stefano Garzarella <sgarzare@redhat.com=
> wrote:
> > > >
> > > > On Thu, Dec 19, 2024 at 05:40:58PM +0200, Jarkko Sakkinen wrote:
> > > > >On Thu Dec 19, 2024 at 5:35 PM EET, Stefano Garzarella wrote:
> > > > >> So to use them directly in sev, we would have to move these defi=
nitions
> > > > >> into include/linux/tpm.h or some other file in inlcude/. Is this
> > > > >> acceptable for TPM maintainers?
> > > > >
> > > > >There's only me.
> > > > >
> > > > >I don't know.
> > > > >
> > > > >What you want to put to include/linux/tpm.h anyway?
> > > >
> > > > At least tpmm_chip_alloc(), tpm2_probe(), and tpm_chip_register()
> > > >
> > > > >I have not followed this discussion.
> > > >
> > > > Let me try to summarize what we are doing: We are writing a small T=
PM
> > > > driver to support AMD SEV-SNP SVSM. Basically SVSM defines some sor=
t of
> > > > hypercalls, which the guest OS can call to talk to the emulated vTP=
M.
> > > >
> > > > In the current version of this series, based on James' RFC, we have=
 an
> > > > intermediate module (tpm_platform) and then another small driver
> > > > (platform_device) in arch/x86/coco/sev/core.c that registers the
> > > > callback to use.
> > > >
> > > > To avoid the intermediate driver (Jason correct me if I misundersto=
od),
> > > > we want to register the `tpm_chip` with its `tpm_class_ops` directl=
y in
> > > > arch/x86/coco/sev/core.c where it's easy to use "SVSM calls" (i.e.
> > > > svsm_perform_call_protocol()).
> > > >
> > > > And here I have this problem, so I was proposing to expose these AP=
Is.
> > > > BTW, we do have an alternative though that I proposed in the previo=
us
> > > > email that might avoid this.
> > >
> > > Any thought on this?
> >
> > A redundant super low-quality TPM stack driver implemtation to support
> > only single vendor's vTPM with speculative generalization.
> >
> > It's a formula for destruction really.
> >
> > I don't know if I event want to comment on this. Figure out a better
> > solution I guess that works together sound with existing stack.
> >
> > If that helps we could make the main TPM driver only Y/N (instead of
> > tristate).
>
> Also e.g. James' hmac encryption: not a single bug fixed by the author,
> which does further reduce my ability to have any possible trust on this.
>
> I do care quality over features, sorry.

One more rant.

It's engineering problem to find **a fit** for the existing art. For
You can set the constraint here as "no two TPM stacks".

I know also almost nothing about SVSM. E.g. I don't understand why a
vTPM cannot be seen as fTPM by the guest, and why this needs user
space exported device (please do not answer here, do a better job
instead).

Even if I wanted to say how this should be changed, I could not
because it too far away to make any possible sense to begin with.
And I don't want to take the risk of those words being used as an
argument later on, when I don't even know what I'm looking.

BR, Jarkko

