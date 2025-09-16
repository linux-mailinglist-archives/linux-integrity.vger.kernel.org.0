Return-Path: <linux-integrity+bounces-7097-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6931B58BC8
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 04:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F6B188583D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 02:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F47221FD0;
	Tue, 16 Sep 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDD7dtGv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6D20F09C;
	Tue, 16 Sep 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989196; cv=none; b=h+o1cwrRzNT2ekzTgYhAKg0seS1xc0zcly+cwrZdS4khoGt8CCuUbz8nl2K+j2vqWpQqnWwF33GP0THX8ym/TEfLswn9/gZ1kpe3nCcf/JXpk5EeMPxNO8TM4ReLxLYcXfMYmMP1aFJS9WF1DDQwkyUb4p4DiJhkO8mdRg8oy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989196; c=relaxed/simple;
	bh=BaZkl8+hDIWVbBK4c8Ej5/4dWiTm0eHRDuANIumQJN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc4GnusfadEB4DtZESpM52evpd8vtHMBcJwjlQuYfLDunLhHuzIRtAIhr0xbRfEd5JtZ39hefk4PGWzn3fuFfS4uhJym4lx0Vtn+3f75wj2ihDZ2jZp935aK5uzwOOwkL7uHPyYJxvTFZhyOlA3jRFTbOtnJUO7QTGkFLpePhFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDD7dtGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BD2C4CEF1;
	Tue, 16 Sep 2025 02:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757989195;
	bh=BaZkl8+hDIWVbBK4c8Ej5/4dWiTm0eHRDuANIumQJN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDD7dtGvArXeQudSjzUxMEFdROlNwyZV7CJhUGR2oymqPXIEHjhJzObifAtW0Ga+F
	 mBkNBbJp7Y6SvmikCL6CDR5fyOm1Ek4cObwz9SfddomBMFSApDFzpf+iyqmo0AE6f5
	 BJxkSx8pvtWwa1vSGeZBYLf7NpB9tgqIyu8oOHRUCps7V/2FgNd7/YTSnNyqjM3xeX
	 Y1TXzz4FiuY5Yp0t9OWyRnp5UxkYx/OpOlbe26sNvj0Kz7kWIj7ts2gtfUMplDiY4Y
	 T83nUU2hJwZfe745abZ148I2+B4XVlBeZq7PTb3bwfuZXHW8hCgC5bi3XGoY2tAxfU
	 wIjswbuB7/vlA==
Date: Tue, 16 Sep 2025 05:19:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aMjJR-3BJmVONjOi@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
 <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
 <aMgnm1OkDj9XnStc@kernel.org>
 <aMhWHy1LQVqpyW5E@kernel.org>
 <aMjG-oisGOgEWHWz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMjG-oisGOgEWHWz@kernel.org>

On Tue, Sep 16, 2025 at 05:10:06AM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 15, 2025 at 09:08:31PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 15, 2025 at 05:50:07PM +0300, Jarkko Sakkinen wrote:
> > > On Sun, Sep 14, 2025 at 11:24:24PM -0400, James Bottomley wrote:
> > > > On Sun, 2025-09-14 at 19:08 +0300, Jarkko Sakkinen wrote:
> > > > > Hi,
> > > > > 
> > > > > In practice, while implementing tpm2sh and its self-contained TPM
> > > > > emulator called "MockTPM", I've noticed that 'tpm2key.asn1.' has a
> > > > > major bottleneck, but luckily it is easy to squash.
> > > > > 
> > > > > Parent handle should never be persisted, as it defies the existential
> > > > > reason of having a file format in the first place.
> > > > 
> > > > Actually, if you read the spec:it describes how to handle non-
> > > > persistent parents by defining the exact form of the P256 parent you
> > > > derive from the permanent handle in section 3.1.8:
> > > > 
> > > > https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
> > > > 
> > > > This is the way all the implementations (well except the kernel, but
> > > > that's fixable) do it.
> > > 
> > > Even if you fix it to persistent handle, the problem does not go
> > > magically go away. Read public attributes are ubiquitos and
> > > cryptographically correct way to do the binding.
> > > 
> > > > 
> > > > > To address this issue I just added couple of optional fields to
> > > > > TPMKey:
> > > > > 
> > > > >   parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
> > > > >   parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> > > > 
> > > > So that's a bit redundant, since if you know the key, you know its
> > > > name.
> > > 
> > > What I know is irrelevant here :-)
> > > 
> > > > 
> > > > > By persisting this information TPM2_GetCapability + TPM2_ReadPublic
> > > > > can be used to acquire an appropriate handle.
> > > > 
> > > > It can, how?  If the parent is a primary, you can't insert it from a
> > > > public key, you have to derive it and if it's non-primary, you need its
> > > > parent to do the insertion.
> > > 
> > > Transient handle is like file handle and persistent handle is like inode
> > > number. Neither unambigiuously (and this is dead obvious) does not 
> > > identify any possible key.
> > > 
> > > Further by binding key correctly, the requirement of being persistent
> > > key goes away, which is a limiting factor.
> > > 
> > > > 
> > > > > I'd highly recommend to add this quirk to anything that processes
> > > > > this ASN.1 format.
> > > > 
> > > > Well, patches to the standard are accepted:
> > > > 
> > > > https://groups.io/g/openssl-tpm2-engine/topics
> > 
> > Further there is two options:
> > 
> > 1. Either remove TPM2 key ASN.1 support from kernel entirely.
> > 2. Fix the 0day bug.
> > 
> > It is unacceptable to make strong binding to a random open source
> > project. I zero care what OpenSSL TPM2 engine does with the file
> > format.
> 
> OK, so obviously the binding exists that if the key matches the whatever
> is in that persistent handle it will be loaded. However, that has still
> ambiguity concern given that any pair of parent and child key matching
> will do. It's much better if you can require a specific parent based
> on its cryptographic stamp.
> 
> So what I'll do for my project is that I just add those as optional
> while adding parent handle for backward compatibility but users
> of tpm2sh still get the benefit of enhanced security.

E.g., for kernel you could have them as kernel command-line parameter,
and by having known stamps for legit parents also adds a bit interposer
protection i.e., it disables capability from interposer to generate
child keys effectively (with low cost as this requires only extra
readpublic).

I'll see how it works in my tools, gain experience and submit a kernel
patch so that the feature gets semi-standardized.

BR, Jarkko

