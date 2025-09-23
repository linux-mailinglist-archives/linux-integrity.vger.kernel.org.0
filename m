Return-Path: <linux-integrity+bounces-7236-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21540B964C8
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A969167533
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181332FB623;
	Tue, 23 Sep 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQSMVP4X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B22367D6;
	Tue, 23 Sep 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637550; cv=none; b=sFeaH4+3pMskrH/RqGkL8HSpQDDYfyPeV3SCbYFmIWmKopB3R7HI7P4gSmuuMLOrPTEFFTX6Vw/JMmzQBXThmk4dHwUX7sENznbO01KbW0SlSwRxYzlVUFC1RNPUH5mR0qMI8DTdxkep9U548f2aIj2I68cprWl9MRcVYd2Zx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637550; c=relaxed/simple;
	bh=YvGhdN47HkzPA4OqepWwyLiEzDovJrvgvOY0mP2klc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF9LVb6gUla0FKtMYw666MaSKESoAaiid4+ikA0UKGlYZlOCSRmCY/zmj0UvlDI2UJRnq95iTYQX6fZqcF/pIDo/zYgEQrf7ChAYLWHsw8o/MVKCBvDilPrE7oQ5esGdOdOchQAzIcnIM5KVBERiDMCqsw4wqti5Th0GizMuf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQSMVP4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C2CC113D0;
	Tue, 23 Sep 2025 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637550;
	bh=YvGhdN47HkzPA4OqepWwyLiEzDovJrvgvOY0mP2klc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQSMVP4XbskNgnA7WE7UuwjebYB4KU6Wk/C/Usf2H5W6v8V89igreeIvEHOfztaTF
	 1SajBrF9GuEvk3y8ynfTwV1X1m4SiRtAnSI8svWsyB4tR3/Z/x8gquDcAl2xUwk21g
	 7/1rZ+bEi10HOKWBdPyCvp8+PyEDs+bydk+rZdLvF8PAY9K/fgPyNMYzTXJxTjsV0c
	 DT6q+E834OTm5n2me+Y/UwZUXLsPkGBLBeddez/6ugfs7/qHkXLVEvcxqW4Z/cWS9q
	 sCOvQI80SoPbyj1itAkMXVBUs08IqOqjMA4lbgc3qYcAkUSA/0FfwJJejiZ/7W1N4c
	 H3dCzFTJkPudw==
Date: Tue, 23 Sep 2025 17:25:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aNKt6kjNnFvhgRW1@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
 <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
 <aMgnm1OkDj9XnStc@kernel.org>
 <aMhWHy1LQVqpyW5E@kernel.org>
 <8c2817f5bbf8202b50d93b6044d6595ea4b29b9a.camel@HansenPartnership.com>
 <aMwptnyYedvdqdHc@kernel.org>
 <aMxC6hU-UhCP2m6v@kernel.org>
 <aNEPLsJlV6LjnAty@kernel.org>
 <76504837de4d85c385d32f36b8340af0ccad2a09.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76504837de4d85c385d32f36b8340af0ccad2a09.camel@HansenPartnership.com>

On Mon, Sep 22, 2025 at 05:31:24PM -0400, James Bottomley wrote:
> On Mon, 2025-09-22 at 11:56 +0300, Jarkko Sakkinen wrote:
> > On Thu, Sep 18, 2025 at 08:35:38PM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Sep 18, 2025 at 06:48:06PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Sep 16, 2025 at 10:33:43PM -0400, James Bottomley wrote:
> > > > > On Mon, 2025-09-15 at 21:08 +0300, Jarkko Sakkinen wrote:
> > > > > > On Mon, Sep 15, 2025 at 05:50:07PM +0300, Jarkko Sakkinen
> > > > > > wrote:
> > > > > > > On Sun, Sep 14, 2025 at 11:24:24PM -0400, James Bottomley
> > > > > > > wrote:
> > > > > > > > On Sun, 2025-09-14 at 19:08 +0300, Jarkko Sakkinen wrote:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > In practice, while implementing tpm2sh and its self-
> > > > > > > > > contained TPM emulator called "MockTPM", I've noticed
> > > > > > > > > that 'tpm2key.asn1.' has a major bottleneck, but
> > > > > > > > > luckily it is easy to squash.
> > > > > > > > > 
> > > > > > > > > Parent handle should never be persisted, as it defies
> > > > > > > > > the existential reason of having a file format in the
> > > > > > > > > first place.
> > > > > > > > 
> > > > > > > > Actually, if you read the spec:it describes how to handle
> > > > > > > > non-persistent parents by defining the exact form of the
> > > > > > > > P256 parent you derive from the permanent handle in
> > > > > > > > section 3.1.8:
> > > > > > > > 
> > > > > > > > https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
> > > > > > > > 
> > > > > > > > This is the way all the implementations (well except the
> > > > > > > > kernel, but that's fixable) do it.
> > > > > > > 
> > > > > > > Even if you fix it to persistent handle, the problem does
> > > > > > > not go magically go away. Read public attributes are
> > > > > > > ubiquitos and cryptographically correct way to do the
> > > > > > > binding.
> > > > > > > 
> > > > > > > > 
> > > > > > > > > To address this issue I just added couple of optional
> > > > > > > > > fields to
> > > > > > > > > TPMKey:
> > > > > > > > > 
> > > > > > > > >   parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
> > > > > > > > >   parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> > > > > > > > 
> > > > > > > > So that's a bit redundant, since if you know the key, you
> > > > > > > > know
> > > > > > > > its name.
> > > > > > > 
> > > > > > > What I know is irrelevant here :-)
> > > > > > > 
> > > > > > > > 
> > > > > > > > > By persisting this information TPM2_GetCapability +
> > > > > > > > > TPM2_ReadPublic can be used to acquire an appropriate
> > > > > > > > > handle.
> > > > > > > > 
> > > > > > > > It can, how?  If the parent is a primary, you can't
> > > > > > > > insert it from a public key, you have to derive it and if
> > > > > > > > it's non-primary, you need its parent to do the
> > > > > > > > insertion.
> > > > > > > 
> > > > > > > Transient handle is like file handle and persistent handle
> > > > > > > is like inode number. Neither unambigiuously (and this is
> > > > > > > dead obvious) does not identify any possible key.
> > > > > > > 
> > > > > > > Further by binding key correctly, the requirement of being
> > > > > > > persistent key goes away, which is a limiting factor.
> > > > > > > 
> > > > > > > > 
> > > > > > > > > I'd highly recommend to add this quirk to anything that
> > > > > > > > > processes this ASN.1 format.
> > > > > > > > 
> > > > > > > > Well, patches to the standard are accepted:
> > > > > > > > 
> > > > > > > > https://groups.io/g/openssl-tpm2-engine/topics
> > > > > > 
> > > > > > Further there is two options:
> > > > > > 
> > > > > > 1. Either remove TPM2 key ASN.1 support from kernel entirely.
> > > > > > 2. Fix the 0day bug.
> > > > > 
> > > > > Can you please explain in technical terms what you see as a
> > > > > zero day bug in the current implementation?
> > > > 
> > > > It's essentially ambiguity problem in my opinion that locks in
> > > > the creator TPM if you know the expected parent. 0day might be
> > > > overstatement yes, but it is essentially the immutable reference
> > > > in this scheme. If you want to scope it, it's essentially a great
> > > > way to add some defence in depth to the scheme.
> > > > 
> > > > > 
> > > > > > It is unacceptable to make strong binding to a random open
> > > > > > source project. I zero care what OpenSSL TPM2 engine does
> > > > > > with the file format.
> > > 
> > > The way I see it, a "random project" would apply to any project
> > > that a format is locked in, and it is quite obvious that fixing
> > > handle as the anchor is exactly fit for exactly for this project,
> > > and within those exact limits it is probably a sustainable choice.
> > > 
> > > Being able to fix key into cryptographic  identity is somewhat sane
> > > addition because not only does it lock-in the creator but it also
> > > allows to use offline stored keys with the same scheme i.e.,
> > > non-endorsement hierarchy derived keys created with TPM2_Create or
> > > TPM2_Import.
> > > 
> > > In the context of OpenSSL TPM2 engine, perhaps the current scheme
> > > is fine but in the context of supporting a "ecosystem" as a kernel
> > > feature it's not in its current form robust enough.
> > > 
> > > And how else I can describe it other than I don't care about the
> > > project, if the file format enforces me align with it?
> > 
> > The ASN.1 definition limits types of keys while there's no any good
> > reasons to disregard transient keys. 
> 
> As I explained in the bit you quote above, the spec covers volatile
> parents.
> 
> > It also enforces handle numbers, which is not very robust approach.
> 
> I think if you read the spec, you'll find it only requires handle
> numbers for persistent keys ... specific handle numbers being a feature
> of those keys required by TPM spec.
> 
> > I've neither seen any cryptographic object in my life, which uses
> > ambiguous data as part of the identity no matter how hypothetical
> > the possible threat scenarios are. It's a bad security practice
> > plain and simple.
> 
> This contains no actionable technical content.  However, it is possible
> the spec doesn't cover your use case, it's just you haven't actually
> outlined what your use case is, so no-one who knows the spec can
> actually confirm or deny this.

I revisited the issue and this is how I see the situation.

I think the most feasible approch especially for volatile keys would be
to store all structures included in TPM2_Create response, instead of 
only storing the first two response parameters. Rest of the blobs
can be e.g. optional. It's the most bottleneck free way to address
any issues.

Creation data contains indefinitive information about parent and this
also enable the use of tickets.

> 
> Regards,
> 
> James
> 

