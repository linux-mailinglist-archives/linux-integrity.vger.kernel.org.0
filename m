Return-Path: <linux-integrity+bounces-7845-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A200DCAB998
	for <lists+linux-integrity@lfdr.de>; Sun, 07 Dec 2025 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80686300153B
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Dec 2025 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DEA2C0265;
	Sun,  7 Dec 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0fm/zZl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B97246BD5;
	Sun,  7 Dec 2025 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765138075; cv=none; b=o5Sz6l6Eq7AJT1OXzWbFwSS09Ve0z8SjrwPoqM0IuCYjXwWf0WDSLUOzTaBSDgpl+Ys5ALwktQM237ZuYZw7SBacJV8nYd9S2qexap5/W1N9JmHkh5K5tRh4RwAJa/OWh1uWJ4YZBjKYH3PjPIt2hOlzB4+ApapjPLqZx3bOfZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765138075; c=relaxed/simple;
	bh=1EmOTwSjuq4nnqRzt06BfrXpOoKsfcdF1tF0JFohVPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fswybt67BdGcrxyc+5xm+Ez7c7SEIsV0huCHxPbw4XtRC2AAPU8mCQekI2fYXmHEjxf/eFy2qg3gtGLvliDURmfqNlvicJBjEmfmL1msd/DswlOqsKJIeKXqfxJSGcsR4xf4ft97QTEkmHoUeOTDndeCzSjU9xBoO78u69oBINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0fm/zZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC53C4CEFB;
	Sun,  7 Dec 2025 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765138074;
	bh=1EmOTwSjuq4nnqRzt06BfrXpOoKsfcdF1tF0JFohVPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0fm/zZlKL8sdL+agi+NL/+FWICz9CsyXI3AWUemEC1o/vz+hVROEXbOPFqaw26up
	 0D5Phu0wYDoqkCxiSWduwEv0BbdqFlPXf7MhYaOFZNhcqiAO/QTt6gmsdm/tZ4J+PX
	 9NKJE2OsjjvCbT0cwLB6t/J9uxpwOMQbH3iy3zdUDAeQXe3/qQtXKlxUij1YWjE/tS
	 9SevbSBFYaDD3nYLPtA++f8A2C1yDUbBObSI1yT9k4YuYioN7sOEDFuapj0kg8FUz5
	 hohsckwtvd7yIacs/f2oADXrAGNQJwDpplYo5qhCEBRmKuMr5DWfNTrrFR1fI6bQLb
	 F5jZxpIsTyOqw==
Date: Sun, 7 Dec 2025 22:07:50 +0200
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
Message-ID: <aTXelmqQ_y7zX-KZ@kernel.org>
References: <20251207173210.93765-1-jarkko@kernel.org>
 <20251207173210.93765-3-jarkko@kernel.org>
 <aTW_-fv8B6q6TAMx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTW_-fv8B6q6TAMx@kernel.org>

On Sun, Dec 07, 2025 at 07:57:13PM +0200, Jarkko Sakkinen wrote:
> On Sun, Dec 07, 2025 at 07:32:10PM +0200, Jarkko Sakkinen wrote:
> > Extend TPMKey ASN.1 speciication [1] with an optional 'parentName'
> > attribute containing TPM name of the parent key (in other words, TPMT_HA
> > blob).
> > 
> > The life-cycle for trusted keys will now proceed as follows:
> > 
> > 1. Encode parent's name to the 'paretName' during tpm2_key_encode().
> > 2. During tpm2_unseal_trusted, read parent's name from 'parentName'. When
> >    the attribute is not available, fallback on doing tpm2_read_public().
> > 
> > In other words, in the common (i.e., not loading a legacy key blob),
> > tpm2_read_public() will now only happen at the time when a key is first
> > created.
> > 
> > In addition, move tpm2_read_public() to 'tpm2-cmd.c' and make its body
> > unconditional so that the binary format of the saved keys is not dependent
> > on kernel configuration.
> > 
> > [1] https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt
> > 
> > Cc: tpm2@lists.linux.dev
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> As an alternative workaround I think the following could be possibly
> done (I need to trial it first though):
> 
> 1. Maintain a cache where a name gets added at the time of
>    tpm2_seal_trusted(). It is from TPMT_HA to TPMT_HA mapping,
>    mapping TPMT_HA of the key to the TPMT of the parent.
> 2. At thet time tpm2_unseal_trusted() retrieve name of thet
>    parent from the cache.
> 
> Capturing TPM2_CreatePrimary would be essentially duct taping the
> spec but I guess this could be more generally applicable. It neither 
> addresses persistent keys nor secondary parent keys, which we *have
> to support*, as the kernel interface does.

I think it is better to focus on merging the first patch and continue
this in the working groups mailing list first before implementing
complex quirks to address flaws of the file format.

BR, Jarkko

