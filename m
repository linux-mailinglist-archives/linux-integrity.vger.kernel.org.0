Return-Path: <linux-integrity+bounces-7846-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C92CAB9F7
	for <lists+linux-integrity@lfdr.de>; Sun, 07 Dec 2025 22:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2BFC3011A7A
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Dec 2025 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FF29A33E;
	Sun,  7 Dec 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia3pvFpW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2C3AC39;
	Sun,  7 Dec 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765141597; cv=none; b=WNpKUF7Ey0zaqY+iDbMKsNNcLQN9EttbwoDm2VODEk5IU1cYYqNJ3KECZOkkMZFaRvUvOPUinGFtLau/yE5wDKXZjFY8qHC15hIlXROXLjFUz2hM+WDNH8s+VAAqTaQ8lSTJYAvINQsliRsFKs2Glnj0LE0B312YqK8RaOjumbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765141597; c=relaxed/simple;
	bh=Rznkc8cRl9dHTCsrZFYPQvWon62K1D+2Rw7YGmsTvvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIXWxM52TPLSDHoDbQmM2Z9IXxF1VdVNZc4XdUqOznPeGSgQUTnOFqclZIAuDQS4FIv8zNfY4NHCmXTI7mDAOd+rdUgSmYhh7aFdD41I3JlMAFHph/vJFVja07Xoep+LKDyY3i8vA79ocPXLxCFirp5Tr0gZISwPMjKoW2AV5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia3pvFpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4BDC4CEFB;
	Sun,  7 Dec 2025 21:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765141597;
	bh=Rznkc8cRl9dHTCsrZFYPQvWon62K1D+2Rw7YGmsTvvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ia3pvFpWv7h/ji/f0wnvB0k2Ln8FyYDl0raiRzisyGnY2efVxjYlAVFiCvnu5dR5z
	 k0LhYP1KosN7QWpSp+qKXeBavYqOWWjFZC2603GD0gPxHms1MufFt6U8vcnU4d+YDa
	 YGdPk+OROmkooV87btr7Mdjd9baQ2IbGPLQZP+HfO1dgNNLhKoLjvm1dgsx6kwCyjE
	 mk3TczzFSsWTShjAbPWghIhOgo3djiPiuDCwTXKsQKSEHGvCUqJfDzGUhLYknliT/+
	 hNNNdVgkgzTYhVE7NtSZesQFEFjQMcdqEqzgIZq7iYE4nlBFHoV7YdO8OFIX9OjJ/H
	 Io2SSq6e3eaSQ==
Date: Sun, 7 Dec 2025 23:06:32 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: tpm2@lists.linux.dev, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] KEYS: trusted: Store parent's name to the encoded
 keys
Message-ID: <aTXsWIGR1qA0B_5I@kernel.org>
References: <20251207173210.93765-1-jarkko@kernel.org>
 <20251207173210.93765-3-jarkko@kernel.org>
 <aTW_-fv8B6q6TAMx@kernel.org>
 <aTXelmqQ_y7zX-KZ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTXelmqQ_y7zX-KZ@kernel.org>

On Sun, Dec 07, 2025 at 10:07:55PM +0200, Jarkko Sakkinen wrote:
> On Sun, Dec 07, 2025 at 07:57:13PM +0200, Jarkko Sakkinen wrote:
> > On Sun, Dec 07, 2025 at 07:32:10PM +0200, Jarkko Sakkinen wrote:
> > > Extend TPMKey ASN.1 speciication [1] with an optional 'parentName'
> > > attribute containing TPM name of the parent key (in other words, TPMT_HA
> > > blob).
> > > 
> > > The life-cycle for trusted keys will now proceed as follows:
> > > 
> > > 1. Encode parent's name to the 'paretName' during tpm2_key_encode().
> > > 2. During tpm2_unseal_trusted, read parent's name from 'parentName'. When
> > >    the attribute is not available, fallback on doing tpm2_read_public().
> > > 
> > > In other words, in the common (i.e., not loading a legacy key blob),
> > > tpm2_read_public() will now only happen at the time when a key is first
> > > created.
> > > 
> > > In addition, move tpm2_read_public() to 'tpm2-cmd.c' and make its body
> > > unconditional so that the binary format of the saved keys is not dependent
> > > on kernel configuration.
> > > 
> > > [1] https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt
> > > 
> > > Cc: tpm2@lists.linux.dev
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > As an alternative workaround I think the following could be possibly
> > done (I need to trial it first though):
> > 
> > 1. Maintain a cache where a name gets added at the time of
> >    tpm2_seal_trusted(). It is from TPMT_HA to TPMT_HA mapping,
> >    mapping TPMT_HA of the key to the TPMT of the parent.
> > 2. At thet time tpm2_unseal_trusted() retrieve name of thet
> >    parent from the cache.
> > 
> > Capturing TPM2_CreatePrimary would be essentially duct taping the
> > spec but I guess this could be more generally applicable. It neither 
> > addresses persistent keys nor secondary parent keys, which we *have
> > to support*, as the kernel interface does.
> 
> I think it is better to focus on merging the first patch and continue
> this in the working groups mailing list first before implementing
> complex quirks to address flaws of the file format.

Storing the name of the parent to the key file has also some other
advantages such as enabling parent auto discovery, which is especially
useful with transient keys. Parent handle is not useful data as by
definition it has an ambiguous meaning.

It is neither "insecure" as child key is tied to one single parent but
at the same parent's handle is completely useless and irrelevant data.

There's nothing "niche" IMHO on storing parent's name at least, and
it is very limiting not to have it.

BR, Jarkko

