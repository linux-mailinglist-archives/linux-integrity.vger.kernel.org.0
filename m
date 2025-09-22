Return-Path: <linux-integrity+bounces-7219-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30627B8FA90
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 10:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF5189D85F
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B6248F69;
	Mon, 22 Sep 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpOprXkw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FE1CAA92;
	Mon, 22 Sep 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531378; cv=none; b=rIf5JHM81+EcqsNZcPHPv9FTjFcCM8U/Z9XtGihez8HgtyxTw+J1Jedrtwc78ADw1ECzT4qrsI7zIO061O39YkJMSQSN4tsrlzant4fhSCuC7/2C6xNgJqLG0fRZEgLs7fAARiHxlhRrTOxZJS8xPpjBNl3T/1j7N5cjF14Lveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531378; c=relaxed/simple;
	bh=Ct8ZBWrET9bGw1pRRcUhL+ph5RhnyhRo4829imYMQd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2466SuPe5R+9755im5YhOk2yR8UliD3vLBBJCgVziVhc1hUMn7BWJvLMRfk4fcSZg1JtAz0rj5Bv8r70kuTzPV+e01xxK5JJlvRm7QCDGSW97dmubsWpI1R3qanzoZrrPnaF46xw6YgCKQT1jgNx7ak9vRvzwU398y24x5emjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpOprXkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D0C4CEF0;
	Mon, 22 Sep 2025 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758531377;
	bh=Ct8ZBWrET9bGw1pRRcUhL+ph5RhnyhRo4829imYMQd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpOprXkwmYuMKpbHPxEgj4eWDwEe7E1Ekfowu1wvKB36bRsmrGE7d9stAneGK1tt1
	 FvFOdj9BS9ou8qtIEiZNGMcxRB65MTsTwbiGoaj0NgGBS0aqS4sGcfZmTZdNxOV3Jy
	 TC8ziNKA0UM+RiW/w57Zpyz34cKDKCBy4a3/3pMlC2BWrWZwMt1nXEbj3pZIm7WFTZ
	 M/usxB4cK7xOhHRvJiG0wdef/Xp7MJkixjDNQe35QFioqDwMfChlqP7W0UMfScDSwZ
	 a2osUDwt7LBpB40BvmsGorbMNNhcD4/NJIFLYx10/6Gz0X/OEJTz2F5arqy+wqixii
	 BBBZUF6QmPSzg==
Date: Mon, 22 Sep 2025 11:56:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aNEPLsJlV6LjnAty@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
 <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
 <aMgnm1OkDj9XnStc@kernel.org>
 <aMhWHy1LQVqpyW5E@kernel.org>
 <8c2817f5bbf8202b50d93b6044d6595ea4b29b9a.camel@HansenPartnership.com>
 <aMwptnyYedvdqdHc@kernel.org>
 <aMxC6hU-UhCP2m6v@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMxC6hU-UhCP2m6v@kernel.org>

On Thu, Sep 18, 2025 at 08:35:38PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 18, 2025 at 06:48:06PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 16, 2025 at 10:33:43PM -0400, James Bottomley wrote:
> > > On Mon, 2025-09-15 at 21:08 +0300, Jarkko Sakkinen wrote:
> > > > On Mon, Sep 15, 2025 at 05:50:07PM +0300, Jarkko Sakkinen wrote:
> > > > > On Sun, Sep 14, 2025 at 11:24:24PM -0400, James Bottomley wrote:
> > > > > > On Sun, 2025-09-14 at 19:08 +0300, Jarkko Sakkinen wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > In practice, while implementing tpm2sh and its self-contained
> > > > > > > TPM emulator called "MockTPM", I've noticed that
> > > > > > > 'tpm2key.asn1.' has a major bottleneck, but luckily it is easy
> > > > > > > to squash.
> > > > > > > 
> > > > > > > Parent handle should never be persisted, as it defies the
> > > > > > > existential reason of having a file format in the first place.
> > > > > > 
> > > > > > Actually, if you read the spec:it describes how to handle non-
> > > > > > persistent parents by defining the exact form of the P256 parent
> > > > > > you derive from the permanent handle in section 3.1.8:
> > > > > > 
> > > > > > https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
> > > > > > 
> > > > > > This is the way all the implementations (well except the kernel,
> > > > > > but that's fixable) do it.
> > > > > 
> > > > > Even if you fix it to persistent handle, the problem does not go
> > > > > magically go away. Read public attributes are ubiquitos and
> > > > > cryptographically correct way to do the binding.
> > > > > 
> > > > > > 
> > > > > > > To address this issue I just added couple of optional fields to
> > > > > > > TPMKey:
> > > > > > > 
> > > > > > >   parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
> > > > > > >   parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> > > > > > 
> > > > > > So that's a bit redundant, since if you know the key, you know
> > > > > > its name.
> > > > > 
> > > > > What I know is irrelevant here :-)
> > > > > 
> > > > > > 
> > > > > > > By persisting this information TPM2_GetCapability +
> > > > > > > TPM2_ReadPublic can be used to acquire an appropriate handle.
> > > > > > 
> > > > > > It can, how?  If the parent is a primary, you can't insert it
> > > > > > from a public key, you have to derive it and if it's non-primary,
> > > > > > you need its parent to do the insertion.
> > > > > 
> > > > > Transient handle is like file handle and persistent handle is like
> > > > > inode number. Neither unambigiuously (and this is dead obvious)
> > > > > does not identify any possible key.
> > > > > 
> > > > > Further by binding key correctly, the requirement of being
> > > > > persistent key goes away, which is a limiting factor.
> > > > > 
> > > > > > 
> > > > > > > I'd highly recommend to add this quirk to anything that
> > > > > > > processes this ASN.1 format.
> > > > > > 
> > > > > > Well, patches to the standard are accepted:
> > > > > > 
> > > > > > https://groups.io/g/openssl-tpm2-engine/topics
> > > > 
> > > > Further there is two options:
> > > > 
> > > > 1. Either remove TPM2 key ASN.1 support from kernel entirely.
> > > > 2. Fix the 0day bug.
> > > 
> > > Can you please explain in technical terms what you see as a zero day
> > > bug in the current implementation?
> > 
> > It's essentially ambiguity problem in my opinion that locks in the
> > creator TPM if you know the expected parent. 0day might be overstatement
> > yes, but it is essentially the immutable reference in this scheme.
> > If you want to scope it, it's essentially a great way to add some defence
> > in depth to the scheme.
> > 
> > > 
> > > > It is unacceptable to make strong binding to a random open source
> > > > project. I zero care what OpenSSL TPM2 engine does with the file
> > > > format.
> 
> The way I see it, a "random project" would apply to any project that a
> format is locked in, and it is quite obvious that fixing handle as the
> anchor is exactly fit for exactly for this project, and within those
> exact limits it is probably a sustainable choice.
> 
> Being able to fix key into cryptographic  identity is somewhat sane
> addition because not only does it lock-in the creator but it also allows
> to use offline stored keys with the same scheme i.e., non-endorsement
> hierarchy derived keys created with TPM2_Create or TPM2_Import.
> 
> In the context of OpenSSL TPM2 engine, perhaps the current scheme is
> fine but in the context of supporting a "ecosystem" as a kernel feature
> it's not in its current form robust enough.
> 
> And how else I can describe it other than I don't care about the
> project, if the file format enforces me align with it?

The ASN.1 definition limits types of keys while there's no any good
reasons to disregard transient keys. 

It also enforces handle numbers, which is not very robust approach.

I've neither seen any cryptographic object in my life, which uses
ambiguous data as part of the identity no matter how hypothetical
the possible threat scenarios are. It's a bad security practice
plain and simple.

BR, Jarkko


