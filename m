Return-Path: <linux-integrity+bounces-7878-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BFFCB0D6B
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 19:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 493AB301DC73
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855CE2F3C1F;
	Tue,  9 Dec 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee4q71gg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BCC2E7653;
	Tue,  9 Dec 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304845; cv=none; b=MnJ7jTJ1J987qFv4GRTTVRgpsXmFIY8Gv41XA9mHZUztcv92+qG1Qolecd8MPF/J2yASPIIHI8SCHXzS5FizfUHZGX/YXP5dL43GurHHHOB0tLikua1aQKluGgjqbMRb0wvUv73ZMi6+rsQjT1MVfqhs/qX9tGOK4cI+9xEUOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304845; c=relaxed/simple;
	bh=Zl5u1a3GpQDX4mGUe2oRTt9rgp7JMmdOA5XWrWKB0RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klIGJMcRB2fC/yfLDyp5yprHTdUOrRf6h04RZugrlq3Ms9gBEoiSunZq4s05dLwOuyFXrdrl9NLrtzNWysR1ILUJzGYazCmaV0kj4IUMXFfPGahuk4mVwnQnjGUD4QU8XpkfZNH2aUaSTfSClxFLfazKD268N0c8UgIhzjSFN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee4q71gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADEFC4CEF5;
	Tue,  9 Dec 2025 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765304844;
	bh=Zl5u1a3GpQDX4mGUe2oRTt9rgp7JMmdOA5XWrWKB0RM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ee4q71ggbgIXL5QFmcfCeuY2A3FB2neqixGf85GP2oTGa8dpsDh51GMQ2DyUZv6A7
	 INxbcnzN6ZEyxXeGe/A+AoeD9HBI5OiyrPbBRc6BStA3a8LSHxmQqWYRXiv9Q0IOm2
	 yihjsGHDTkAeRs9oumo79w47zPJmLVXUY6kARdS/Qh7K7u4jgD72PtaGAs0u/mKGSB
	 ymf1LUgUcfsz+9AZby7GgeMlKhfapCK+N6FoS90oYw4g748Xii5mW/s8yJjMaytMaw
	 3CcqL10tDYXyEdPSuqssxYt1lCa3X0p84hSD2psf+yEhBub5dYnk+zfGK2hXlc3I8L
	 9wkFaTZmNarqg==
Date: Tue, 9 Dec 2025 20:27:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Streamline TPM2 HMAC sessions
Message-ID: <aThqCYgK1_zvk5UO@kernel.org>
References: <20251209100529.1700779-1-jarkko@kernel.org>
 <aThDeSWFhbI6GRgh@kernel.org>
 <aThdJwpDWD_-hhy6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aThdJwpDWD_-hhy6@kernel.org>

On Tue, Dec 09, 2025 at 07:32:27PM +0200, Jarkko Sakkinen wrote:
> On Tue, Dec 09, 2025 at 05:42:55PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Dec 09, 2025 at 12:05:23PM +0200, Jarkko Sakkinen wrote:
> > > Since we cannot at this point cache names of the keys given limitations
> > > of the ASN.1 file format, I'll start a fresh patch set. Let's fixup what
> > > we can right now.
> > > 
> > > This patch set addresses two major issues in the feature:
> > > 
> > > 1. Dynamic resolution without gain. All kernel sites have at most single
> > >    handle to authorize. Even if this changes some day this is how it is
> > >    as of today and we definitely do not want to dictate the future but
> > >    instead downscale code to the metrics that we have as of today.
> > > 2. Eliminate at least one unnnecessary tpm2_read_public() call.
> > > 
> > > Jarkko Sakkinen (5):
> > >   KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
> > >   tpm2-sessions: Define TPM2_NAME_MAX_SIZE
> > >   KEYS: trusted: Re-orchestrate tpm2_read_public() calls
> > >   tpm2-sessions: Remove AUTH_MAX_NAMES
> > >   tpm-buf: Remove tpm_buf_append_handle
> > > 
> > >  drivers/char/tpm/tpm-buf.c                |  25 ----
> > >  drivers/char/tpm/tpm-sysfs.c              |   2 +-
> > >  drivers/char/tpm/tpm2-cmd.c               |   9 +-
> > >  drivers/char/tpm/tpm2-sessions.c          | 130 ++++++---------------
> > >  include/linux/tpm.h                       |  49 +++++---
> > >  security/keys/trusted-keys/trusted_tpm2.c | 134 +++++++++++++---------
> > >  6 files changed, 155 insertions(+), 194 deletions(-)
> > > 
> > > -- 
> > > 2.52.0
> > > 
> > 
> > For hwrng we can e.g., calculate factor by timing tpm2_get_random() with
> > and without HMAC encryption. Then we can use this as frequency how often 
> > data is pulled.
> > 
> > The other angle to combine this is to maintain largeish FIFO of random 
> > bytes and fill this when it goes below a treshold. 
> > 
> > Probably some combination of these will provide answer to performance
> > and latency problem with hwrng when HMAC encryption is turned on:
> > 
> > 1. The first amortizes the overall quota.
> > 2. Second provides constant latency without major spikes.
> 
> Another perhaps more unorthodox idea:
> 
> 1. Calculate factor as said above. Let's call it N.
> 2. Every Nth step seed a pseudo rng from TPM.
> 3. On steps not divisible by N, pull from pseud rng.
> 
> I'm not a cryptographer but would randomness suffer from this? Then the
> seeds that woud come from TPM are HMAC encrypted at least without major 
> hits on performance.
> 
> Just enumerated this. Not sure about this idea yet by any means but I do 
> like simplicy of it (and that also makes me concerned about missed
> details).

Third option would be to have simply a kthread with a rate that fills a
pool and hwrng callbacks serves from that pool. If there is no bytes,
there is no bytes (which is fine as far as API is concerned).

This has optimal system latency properties I'd figure.

BR, Jarkko

