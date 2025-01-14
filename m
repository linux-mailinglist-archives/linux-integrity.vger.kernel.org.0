Return-Path: <linux-integrity+bounces-4562-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999ABA11461
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 23:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4985E3A5880
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853E20AF65;
	Tue, 14 Jan 2025 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJJWf6bm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73E1ADC6D;
	Tue, 14 Jan 2025 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894931; cv=none; b=JPqm9QT6E+E1pKeCxfTaCVXpEMDKKp8coVXhKi1tzZK1ByHy9dVbHVU7CTjwkVadBSAAQrvvz5J7QxkebSg3sFlgbSvuao7oBKmADetXzXhDgECJVe7/+x8NJ8TUx62xGHfpNsLcZAp5Ny1PgZWakYJP6J4eTRZaMa+rHjagnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894931; c=relaxed/simple;
	bh=iTizqvP4F0szlp/vLTIU9iJLb2yAeoao4VRjKde6nbE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lxmWhw9YicJc1fjuhDGMIK+/AqkcNuRYhNx8LlYM/fdbbCJ+8yUVXxv7MW3ZdXUf9jnfSTuRT63pRdvx+5ycqTyVxcQehise8/EpXkIiLvsA0j0y1yO3NP1ubrt2Xgozh/wDW6J2qBn9MWOuxHvd5q+RGWyxYewo7k4xIPOWTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJJWf6bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D2BC4CEDD;
	Tue, 14 Jan 2025 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736894931;
	bh=iTizqvP4F0szlp/vLTIU9iJLb2yAeoao4VRjKde6nbE=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=CJJWf6bmRdXZ/LnonzAMMP3jmHvUd6G+BK788ge/5VY6zSf3CrLio6bIA9JVNBbod
	 OA2qLIdhc2UDWhlISpS5xWw0Fb7AN80Y4Wz88o/+ZsUsuunBrirbRoeU9Hv6bK+U3N
	 EDfJGzVxA6u9eiNsaIgvwe8MXZj3bzKM7vonaOUddooQsJa9fMpju0dG01xBj3ETut
	 YG4iioXQNxCxnRgyS0JICZJ3ghlH+s79rwi+akLRA0ZFVifCj8v7zJ3rk8xTON9w/R
	 rqkuzMu44bERD+4Wjk06hQtOaZn+3RJfSpYuR/CfVGEgKuISIa4aadS61n2bLyp5v1
	 /Ujw2crz3S4bw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jan 2025 00:48:46 +0200
Message-Id: <D725V628UV87.31SUEYVF9IUUC@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefano Garzarella"
 <sgarzare@redhat.com>, "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
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
In-Reply-To: <D725TPWOVBUL.1DJAOZ0QL0RNH@kernel.org>

On Wed Jan 15, 2025 at 12:46 AM EET, Jarkko Sakkinen wrote:
> On Tue Jan 14, 2025 at 12:42 PM EET, Stefano Garzarella wrote:
> > Hi Jarkko,
> >
> > On Thu, 19 Dec 2024 at 17:07, Stefano Garzarella <sgarzare@redhat.com> =
wrote:
> > >
> > > On Thu, Dec 19, 2024 at 05:40:58PM +0200, Jarkko Sakkinen wrote:
> > > >On Thu Dec 19, 2024 at 5:35 PM EET, Stefano Garzarella wrote:
> > > >> So to use them directly in sev, we would have to move these defini=
tions
> > > >> into include/linux/tpm.h or some other file in inlcude/. Is this
> > > >> acceptable for TPM maintainers?
> > > >
> > > >There's only me.
> > > >
> > > >I don't know.
> > > >
> > > >What you want to put to include/linux/tpm.h anyway?
> > >
> > > At least tpmm_chip_alloc(), tpm2_probe(), and tpm_chip_register()
> > >
> > > >I have not followed this discussion.
> > >
> > > Let me try to summarize what we are doing: We are writing a small TPM
> > > driver to support AMD SEV-SNP SVSM. Basically SVSM defines some sort =
of
> > > hypercalls, which the guest OS can call to talk to the emulated vTPM.
> > >
> > > In the current version of this series, based on James' RFC, we have a=
n
> > > intermediate module (tpm_platform) and then another small driver
> > > (platform_device) in arch/x86/coco/sev/core.c that registers the
> > > callback to use.
> > >
> > > To avoid the intermediate driver (Jason correct me if I misunderstood=
),
> > > we want to register the `tpm_chip` with its `tpm_class_ops` directly =
in
> > > arch/x86/coco/sev/core.c where it's easy to use "SVSM calls" (i.e.
> > > svsm_perform_call_protocol()).
> > >
> > > And here I have this problem, so I was proposing to expose these APIs=
.
> > > BTW, we do have an alternative though that I proposed in the previous
> > > email that might avoid this.
> >
> > Any thought on this?
>
> A redundant super low-quality TPM stack driver implemtation to support
> only single vendor's vTPM with speculative generalization.
>
> It's a formula for destruction really.
>
> I don't know if I event want to comment on this. Figure out a better
> solution I guess that works together sound with existing stack.
>
> If that helps we could make the main TPM driver only Y/N (instead of
> tristate).

Also e.g. James' hmac encryption: not a single bug fixed by the author,
which does further reduce my ability to have any possible trust on this.

I do care quality over features, sorry.

BR, Jarkko

