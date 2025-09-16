Return-Path: <linux-integrity+bounces-7096-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDBB58BB7
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 04:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48CD3A0FBE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 02:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA720010A;
	Tue, 16 Sep 2025 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVuqun/3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B81F7575;
	Tue, 16 Sep 2025 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988606; cv=none; b=nHrHEF5lrXDKhoKw8sNvjS9l4r1iDlhceCoKMVhdTAGw/ETu2iJVl3eTzpzlghy8M9xAzUjPbeySBlSRjIs6X7ZsUjXSd4ICNLpeL62TyCJggOK9opEe+RyVmWGc8AvufofFdamNWar/YsbZXFgEBXOeQRWvcFyl28Lqdbf/2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988606; c=relaxed/simple;
	bh=+OpeJICayBTFTt6pHRloGR6FN4LGH4aD9SJncHGRA1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHlWdFFXUeKSJAnZtgfOnW1iN31ugPm2MM7PrZwWK0bdPT3Bh7G/wrFCqBS95hoEW3MvdEPJazILkA6SwOY75Oyp2kwIExxRYaIb1Ihllk2LStKq8PdEoAjeDkeMqiaOBz/MWYYkFeVM8gm9gv1KrlMxTWLnzlvkFqov71DG4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVuqun/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508D8C4CEF5;
	Tue, 16 Sep 2025 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757988605;
	bh=+OpeJICayBTFTt6pHRloGR6FN4LGH4aD9SJncHGRA1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVuqun/3IsK+hLKFB4IUigZXpnGIUSAYg3OhCMvIBPx3ZJskACgmWdBJgUFRjCnWV
	 yRReGT7YSpaSIvNRy2EiiYKZt/g+EXlzR3FUYXDfQMCKHuK+QexiYOxQdk9Vz6sLhE
	 t3N+1Vz4Nrif2UBzF8yPH4WkAhzMbQWclPdeQ9ab5pNJr3nqsjpctnZBQo7nNzlLu7
	 rIA1rySVFb4lZbV2ExqOjeKwQxR3j8GBsGWgIKZNV5BKajhf8l+/3u6Ccl/DwA41Ko
	 7jBeucVh3FqAHvGVBhIjYjnXR81lFpTO/8t8iYEjhDPPBGF6PNB8QwigzTaxdIcCS9
	 MvYdZN1FSV2eA==
Date: Tue, 16 Sep 2025 05:10:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aMjG-oisGOgEWHWz@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
 <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
 <aMgnm1OkDj9XnStc@kernel.org>
 <aMhWHy1LQVqpyW5E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMhWHy1LQVqpyW5E@kernel.org>

On Mon, Sep 15, 2025 at 09:08:31PM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 15, 2025 at 05:50:07PM +0300, Jarkko Sakkinen wrote:
> > On Sun, Sep 14, 2025 at 11:24:24PM -0400, James Bottomley wrote:
> > > On Sun, 2025-09-14 at 19:08 +0300, Jarkko Sakkinen wrote:
> > > > Hi,
> > > > 
> > > > In practice, while implementing tpm2sh and its self-contained TPM
> > > > emulator called "MockTPM", I've noticed that 'tpm2key.asn1.' has a
> > > > major bottleneck, but luckily it is easy to squash.
> > > > 
> > > > Parent handle should never be persisted, as it defies the existential
> > > > reason of having a file format in the first place.
> > > 
> > > Actually, if you read the spec:it describes how to handle non-
> > > persistent parents by defining the exact form of the P256 parent you
> > > derive from the permanent handle in section 3.1.8:
> > > 
> > > https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
> > > 
> > > This is the way all the implementations (well except the kernel, but
> > > that's fixable) do it.
> > 
> > Even if you fix it to persistent handle, the problem does not go
> > magically go away. Read public attributes are ubiquitos and
> > cryptographically correct way to do the binding.
> > 
> > > 
> > > > To address this issue I just added couple of optional fields to
> > > > TPMKey:
> > > > 
> > > >   parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
> > > >   parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> > > 
> > > So that's a bit redundant, since if you know the key, you know its
> > > name.
> > 
> > What I know is irrelevant here :-)
> > 
> > > 
> > > > By persisting this information TPM2_GetCapability + TPM2_ReadPublic
> > > > can be used to acquire an appropriate handle.
> > > 
> > > It can, how?  If the parent is a primary, you can't insert it from a
> > > public key, you have to derive it and if it's non-primary, you need its
> > > parent to do the insertion.
> > 
> > Transient handle is like file handle and persistent handle is like inode
> > number. Neither unambigiuously (and this is dead obvious) does not 
> > identify any possible key.
> > 
> > Further by binding key correctly, the requirement of being persistent
> > key goes away, which is a limiting factor.
> > 
> > > 
> > > > I'd highly recommend to add this quirk to anything that processes
> > > > this ASN.1 format.
> > > 
> > > Well, patches to the standard are accepted:
> > > 
> > > https://groups.io/g/openssl-tpm2-engine/topics
> 
> Further there is two options:
> 
> 1. Either remove TPM2 key ASN.1 support from kernel entirely.
> 2. Fix the 0day bug.
> 
> It is unacceptable to make strong binding to a random open source
> project. I zero care what OpenSSL TPM2 engine does with the file
> format.

OK, so obviously the binding exists that if the key matches the whatever
is in that persistent handle it will be loaded. However, that has still
ambiguity concern given that any pair of parent and child key matching
will do. It's much better if you can require a specific parent based
on its cryptographic stamp.

So what I'll do for my project is that I just add those as optional
while adding parent handle for backward compatibility but users
of tpm2sh still get the benefit of enhanced security.

BR, Jarkko

