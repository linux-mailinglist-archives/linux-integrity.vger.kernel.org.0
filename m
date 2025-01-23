Return-Path: <linux-integrity+bounces-4620-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802CEA1A38C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 12:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D38C3A04AE
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E74020C016;
	Thu, 23 Jan 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBpNRLJO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA4381AF;
	Thu, 23 Jan 2025 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632980; cv=none; b=OSQwhdXQ8RA+EmwDtsq4Ys2XRBnebTRqk0u2bVehpo/EXpjeiV8SJPJHZzyRzjM6I8olupw95n5v99rabfGPjA5kRfpEnh+Kpqquef6m3bM90xLAJvK+3r13KqI/njDFdLUKowWXEDIOyxLP1IBfVeQe9SGXXqTzHz8I5bC3/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632980; c=relaxed/simple;
	bh=lFlA5nPeqcr7IAzxLL4Ty0VKrv/BapDencTPXZ5eCMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=KfoqEUW+KoU02L/mC2Orcy4Od1BnsfSEvvYwErOFqXlOesrLnkaJoBGQOW0p5r2EfTaxgv9NlKC9ehJjrwB49QL/xa41vH4xoPJqbSvREserBf7en1mV1XLyCRkXwJ6oZ4z7yDH9MOa9KhWvHguriXNf7SR2RFL9pPazrKIVObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBpNRLJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0271DC4CED3;
	Thu, 23 Jan 2025 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737632979;
	bh=lFlA5nPeqcr7IAzxLL4Ty0VKrv/BapDencTPXZ5eCMc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=pBpNRLJOgX9JhKcOa24hDu67KmB3gpV2dPZR3/6kjLQAiye7rH7S4CzCO4CfwwJSR
	 5tmMPBMwvPF4UCn34Xb8jzZ/Nu0Yyxwd7GmYohncPO22lLcov7fw9Fp3c9Z8tnbhNY
	 KKhWIuBml99mcCocRpRO/8PbCrPdEpVaGSVqEEns9ZAH3t/cAaIfLL3tt4w2q3HnGz
	 kEIsBtuK+bpj7SXCi4yhaiCoN5pyLudDDQ08ygIZ3Bt5s3ORfVIUkbhBR/RiqLTMfR
	 h0CpD2u6qLUAK41XOgdb+xWwbML7IQeoszW2l7wrBZd/R32kgZeU3biWqcKhmlKh/M
	 BXgSFbNzmpTXA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 13:49:34 +0200
Message-Id: <D79FHC9OB5WS.CCNDGUTDNG31@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefano Garzarella"
 <sgarzare@redhat.com>
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
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
 <D79FFA5JMK7J.1GD3PSB11COGC@kernel.org>
In-Reply-To: <D79FFA5JMK7J.1GD3PSB11COGC@kernel.org>

On Thu Jan 23, 2025 at 1:46 PM EET, Jarkko Sakkinen wrote:
> On Thu Jan 23, 2025 at 12:09 PM EET, Stefano Garzarella wrote:
> > On Thu, Jan 23, 2025 at 11:50:40AM +0200, Jarkko Sakkinen wrote:
> > >On Wed Jan 22, 2025 at 11:29 PM EET, Dionna Amalie Glaze wrote:
> > >> I can appreciate this viewpoint. It even surfaced Microsoft's fTPM
> > >> paper to me, which solves some interesting problems we need to solve
> > >> in SVSM too. So thanks for that.
> > >>
> > >> Just to clarify, you're not asking for SVSM to implement the TIS-MMI=
O
> > >> interface instead, but rather to use the fTPM stack, which could mak=
e
> > >> SVSM calls a TEE device operation?
> > >
> > >I don't really know what I'm asking because this is barely even a
> > >PoC, and I state it like this knowingly.
> > >
> > >You should make the argument, and the case for the solution. Then
> > >it is my turn to comment on that scheme.
> >
> > I'll check if I can use fTPM, in the meantime I had started to simplify
> > this series, avoiding the double stack and exposing some APIs from SEV
> > to probe the vTPM and to send the commands. The final driver in
> > drivers/char/tpm would be quite simple.
> >
> > But I'll try to see if reusing fTPM is a feasible way, I like the idea.
> >
> > >
> > >That said, I would not give high odds for acceptance of a duplicate
> > >TPM stack succeeding.
> >
> > Got it ;-)
> >
> > Thanks to everyone for the helpful feedbacks!
> >
> > I've been a bit messy these days and I'm in FOSDEM next week, so I hope
> > not to take too long for the v2.
>
> Yeah, OK one thing that I want to say.
>
> Nail the story. What is it about what is the problem what is the
> motivation to solve it etc. If you have all that properly written
> up then it is easier to forgive not that well nailed code and
> give reasonable arguments.
>
> And don't rush, I have all the time in the world ;-)

Here the point is that if I don't fully understand the context
(starting explaining the obvious like what is SVSM) I might=20
give some ridiculously wrong advice.

Then people come back to me and start blaming me on saying
opposite arguments. I hope you see where I'm standing here.
I neither don't want you to do useless and unproductive
work.

BR, Jarkko

