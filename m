Return-Path: <linux-integrity+bounces-2516-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC628CB0E8
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8151C21F64
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82217535B7;
	Tue, 21 May 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Awd0Bh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC814A8E;
	Tue, 21 May 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303679; cv=none; b=rc+7Ma09vlBG94GqnGgRzubIOnSqIe7qU+bJG5DM93vn39YCiL9rJi4MzWOQdsW0dpiHNQiitq83MxmcFFKKspR/Af2Me37AkcoCICFp6BfGiBwpYcy60Om8n4Mpa4PID7IXfLHT3CJNSMv/SIVk3skASaQTMOHdW5tg26HUYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303679; c=relaxed/simple;
	bh=yGL1b5jDn2L0XbTPDWxQIH214UessiBnvjxazrUzlj4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eUm+zR60Gpd7W9E6gZFPcDJxeBQvcrPu+Er20xhUqWKZXlP5AGNOTdSHgXA0Xb7Nx7nINhaSbeJKMCE/xFlhBnyCRs183MbI9dx8rtDPn1WUPyIHqNE5lIXEcX38rbCqUnN+SIhmYJdvepaBcQjekntXMn/4kPug6uYO8f+v5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Awd0Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A618C32786;
	Tue, 21 May 2024 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716303678;
	bh=yGL1b5jDn2L0XbTPDWxQIH214UessiBnvjxazrUzlj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/Awd0BhJdtU2Yi4LJvaYBBW6Ua1Yvtvc3AWUhHGrRs/dOMJAXA8/GhdqMxyDEawl
	 AWC8JG0wtbbxB8j8YvHjV9wD6uVTMh82oQ/CpPoUKTdWoms9oxaKNOcb7IgUomrFbl
	 NPfgWGgppkzVudXAHnyX9xno43pga2E5vxG9zQn4bia8lqVrmXa0luHbF0bisZl/cy
	 sUjJHQhb9HATp9Jsm2LuffcWwk40aCWgH0syWicGBwL2xitfnt//g/5jleXYPGA4c8
	 U3Hvw6CLiM8LmsWofVFA3A9GcCLiHNGY5C/Gpu4WyhLVW8zWA4oMOIgOGknSoLHAwc
	 lHwF4lvQ2bB2g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 18:01:14 +0300
Message-Id: <D1FEVJ7DO7PS.NL5BCC4RSE1A@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
X-Mailer: aerc 0.17.0
References: <20240521130921.15028-1-jarkko@kernel.org>
 <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>
 <D1FDMULT5YRK.GZOPJ9FZ325R@kernel.org>
 <854fa2e1634eb116b979dab499243e40917c637c.camel@HansenPartnership.com>
 <D1FE58VX0KL4.70F6U9Y6HPQC@kernel.org>
 <D1FEC6TB7660.2XD9X21W46X7V@kernel.org>
In-Reply-To: <D1FEC6TB7660.2XD9X21W46X7V@kernel.org>

On Tue May 21, 2024 at 5:35 PM EEST, Jarkko Sakkinen wrote:
> On Tue May 21, 2024 at 5:26 PM EEST, Jarkko Sakkinen wrote:
> > On Tue May 21, 2024 at 5:13 PM EEST, James Bottomley wrote:
> > > On Tue, 2024-05-21 at 17:02 +0300, Jarkko Sakkinen wrote:
> > > > Secondly, it also roots to the null key if a parent is not given. S=
o
> > > > it covers all the basic features of the HMAC patch set.
> > >
> > > I don't think that can work.  The key file would be wrapped to the
> > > parent and the null seed (and hence the wrapping) changes with every
> > > reboot.  If you want a permanent key, it has to be in one of the
> > > accessible permanent hierarchies (storage ideally or endorsement).
> >
> > I'm fully aware that null seed is randomized per power cycle.
> >
> > The fallback was inherited from James Prestwood's original code and I
> > decided to keep it as a testing feature, and also to test HMAC changes.
> >
> > If you look at the testing transcript in the cover letter, it should be
> > obvious that a primary key is created in my basic test.
>
> I think what could be done to it in v3 would be to return -EOPNOTSUPP
> if parent is not defined. I.e. rationale here is that this way the
> empty option is still usable for something in future kernel releases.

It was actually like this: if you explicitly set handle to RH_NULL.
Have not used it a lot so did not recall this.

That said I'd actually just take away any special substitution logic
and use any handle given by the user space as it is.

BR, Jarkko

