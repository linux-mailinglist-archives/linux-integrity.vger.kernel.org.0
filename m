Return-Path: <linux-integrity+bounces-4619-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC2A1A387
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 12:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718CB3A5387
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E820DD51;
	Thu, 23 Jan 2025 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgqUt2mU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B76A20C49F;
	Thu, 23 Jan 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632819; cv=none; b=Mieafa0Nz/DtpvzH7TNFODJiStQenjmyog7gGdxQNBooOoxKJHgktGdi1JOSEbHjAFtQL/McnzzqVCrDJSclNJmMfag3lQfARxjAqJZZ8LR7dkqOceD1zhOnm75AtQuQ6MmuTzSqFVtAuZd+rGfZmeqfjIsaVfG3mAp0sujGk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632819; c=relaxed/simple;
	bh=3Y9Wd8o3xKMFin8MsP1o+KstiVcQryHoKlgP+hrm6g0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mMSTgVF/S6CYBVRqSMBOkZD7oI0PbSxVD9lnOfpXC5tB57Ul1nty/ks8uZVn+Dk1JmhFoTVzj/fbGspaY5PnycUzkcZBXuNXWQ3RNbEigPz7e/bCO57aFp0Sz+/uaxYH0bFPZlYRLV/MRp1e7vDg+nZv008XBkJwj5pjffbvLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgqUt2mU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D342DC4CED3;
	Thu, 23 Jan 2025 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737632818;
	bh=3Y9Wd8o3xKMFin8MsP1o+KstiVcQryHoKlgP+hrm6g0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fgqUt2mUprF222uk4U3mmxJ4DJ8sZm3brktNNCxdeCkHXUpHWSm529CUPmsFNR9GY
	 mXcLikpTHieyX63gVThqU8X7KEQpd+fvrsE2wALIcBNnbaRSM/KhLGJr4FCttBYRAF
	 EaAgEqpz5xIgMorOTFmh0jC0/vkDHj2InnJiH03NgZmKtBmZNhSc9MQTRnF8lwn0tA
	 IUlT+ngMw7MQF5gtLdwhon7/y6R0dBfgveLnGXwah+Xt+lwXF8AVKCqdOAQUKjHOfZ
	 YwTaqaM5HYJQOfI4k2WFCZEruxHb/1D42KwS8mJWQxVHo9clxp0AwYy5LX6Q0/iIrf
	 y6HM+yNS5ZXsg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 13:46:52 +0200
Message-Id: <D79FFA5JMK7J.1GD3PSB11COGC@kernel.org>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefano Garzarella" <sgarzare@redhat.com>
Cc: "Dionna Amalie Glaze" <dionnaglaze@google.com>, "Jarkko Sakkinen"
 <jarkko.sakkinen@iki.fi>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <james.bottomley@hansenpartnership.com>,
 <linux-coco@lists.linux.dev>, "Borislav Petkov" <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Peter Huewe" <peterhuewe@gmx.de>,
 "H. Peter Anvin" <hpa@zytor.com>, <linux-integrity@vger.kernel.org>,
 <x86@kernel.org>, "Joerg Roedel" <jroedel@suse.de>,
 <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Claudio Carvalho"
 <cclaudio@linux.ibm.com>, "Dov Murik" <dovmurik@linux.ibm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>
X-Mailer: aerc 0.18.2
References: <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
 <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
 <D725TPWOVBUL.1DJAOZ0QL0RNH@kernel.org>
 <D725V628UV87.31SUEYVF9IUUC@kernel.org>
 <D726DAWHLOGW.3TR2LCJ936OG7@kernel.org>
 <CAAH4kHYy7=OZsHnOBiQug0Y__bNHt6i+bop0xaxQjpWQ6aQr1Q@mail.gmail.com>
 <D79CYAVX0LAZ.1MIYNOM6J7MMM@kernel.org>
 <sf5zezwsokmz7lkl7fdl5z5q6lipeqd5d4sws2hpi6pznyvdap@tjfv5p5uty7y>
In-Reply-To: <sf5zezwsokmz7lkl7fdl5z5q6lipeqd5d4sws2hpi6pznyvdap@tjfv5p5uty7y>

On Thu Jan 23, 2025 at 12:09 PM EET, Stefano Garzarella wrote:
> On Thu, Jan 23, 2025 at 11:50:40AM +0200, Jarkko Sakkinen wrote:
> >On Wed Jan 22, 2025 at 11:29 PM EET, Dionna Amalie Glaze wrote:
> >> I can appreciate this viewpoint. It even surfaced Microsoft's fTPM
> >> paper to me, which solves some interesting problems we need to solve
> >> in SVSM too. So thanks for that.
> >>
> >> Just to clarify, you're not asking for SVSM to implement the TIS-MMIO
> >> interface instead, but rather to use the fTPM stack, which could make
> >> SVSM calls a TEE device operation?
> >
> >I don't really know what I'm asking because this is barely even a
> >PoC, and I state it like this knowingly.
> >
> >You should make the argument, and the case for the solution. Then
> >it is my turn to comment on that scheme.
>
> I'll check if I can use fTPM, in the meantime I had started to simplify
> this series, avoiding the double stack and exposing some APIs from SEV
> to probe the vTPM and to send the commands. The final driver in
> drivers/char/tpm would be quite simple.
>
> But I'll try to see if reusing fTPM is a feasible way, I like the idea.
>
> >
> >That said, I would not give high odds for acceptance of a duplicate
> >TPM stack succeeding.
>
> Got it ;-)
>
> Thanks to everyone for the helpful feedbacks!
>
> I've been a bit messy these days and I'm in FOSDEM next week, so I hope
> not to take too long for the v2.

Yeah, OK one thing that I want to say.

Nail the story. What is it about what is the problem what is the
motivation to solve it etc. If you have all that properly written
up then it is easier to forgive not that well nailed code and
give reasonable arguments.

And don't rush, I have all the time in the world ;-)

> Stefano

BR, Jarkko

