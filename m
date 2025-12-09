Return-Path: <linux-integrity+bounces-7877-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA5CB0BDB
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 18:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0552E3089E62
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13532AAC1;
	Tue,  9 Dec 2025 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLIYJfFV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029E3002B9;
	Tue,  9 Dec 2025 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765301548; cv=none; b=I+eV1dFhvEIS56cGvmHWty1hxa8ds732N8y2lr3BQtwLVCU1zXg4XRREBmkQFWLWR4pqQ7BtUlORKz9ewARlMVn6EW3RGeaASksU4clBwcKPFmBmlKWnt9x/wz+2svguDsylHGf716HQ5WOZi1Zm6ztu25JmLFzzIitthqPOFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765301548; c=relaxed/simple;
	bh=59gQy7kWjCrF1zl/Trpoli5Pqycta3SxUWtJLeqYViE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMwXGE1a64U8Tjex1jVo50GDyUSqkAsWzrOqiAB4yqx3M/ejoYGHlug1t7R/StS+VWDCGeQwFVm2QE8DN8p/rDD0tFu84Ms2TZIV4kdUN2u5Xs0zKD6e5WyayHhOZJU9E36waT4kAvgOQW6nsJ2uJOZmDWNm+xqWsEUDjfeW71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLIYJfFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A5FC4CEFB;
	Tue,  9 Dec 2025 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765301547;
	bh=59gQy7kWjCrF1zl/Trpoli5Pqycta3SxUWtJLeqYViE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLIYJfFVVlt7iWFuJQwaLUJgSp4J2g0a56ItkuGv0cNf8F5qvBvuIqzTY9eYKY2G4
	 kjYFX9veYZFx8VRX2NnhFaklUPCOtx4S1G99e0hBJsx/3OCJ8d4I2Zu4MOXRFtnDrZ
	 CMt45NQPZLQdDTpMwPApY+LjjAn0j590XMnpWVdj5CDaToeehqzG6zcbyELM5i+HLI
	 hyNCqD3AEJRCVYcIufAs+bNDabxDxJXWhySf3gYJcrSj39rWppNaya4pW9gI2FytNd
	 +kVJmJZa9bYElxphb/j4IAYcqGeLrQx2MDq8mdcyh/NlW8UFPD4ynVh6aNC7bB7F4m
	 lKTxEsr7pmE7Q==
Date: Tue, 9 Dec 2025 19:32:23 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Streamline TPM2 HMAC sessions
Message-ID: <aThdJwpDWD_-hhy6@kernel.org>
References: <20251209100529.1700779-1-jarkko@kernel.org>
 <aThDeSWFhbI6GRgh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aThDeSWFhbI6GRgh@kernel.org>

On Tue, Dec 09, 2025 at 05:42:55PM +0200, Jarkko Sakkinen wrote:
> On Tue, Dec 09, 2025 at 12:05:23PM +0200, Jarkko Sakkinen wrote:
> > Since we cannot at this point cache names of the keys given limitations
> > of the ASN.1 file format, I'll start a fresh patch set. Let's fixup what
> > we can right now.
> > 
> > This patch set addresses two major issues in the feature:
> > 
> > 1. Dynamic resolution without gain. All kernel sites have at most single
> >    handle to authorize. Even if this changes some day this is how it is
> >    as of today and we definitely do not want to dictate the future but
> >    instead downscale code to the metrics that we have as of today.
> > 2. Eliminate at least one unnnecessary tpm2_read_public() call.
> > 
> > Jarkko Sakkinen (5):
> >   KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
> >   tpm2-sessions: Define TPM2_NAME_MAX_SIZE
> >   KEYS: trusted: Re-orchestrate tpm2_read_public() calls
> >   tpm2-sessions: Remove AUTH_MAX_NAMES
> >   tpm-buf: Remove tpm_buf_append_handle
> > 
> >  drivers/char/tpm/tpm-buf.c                |  25 ----
> >  drivers/char/tpm/tpm-sysfs.c              |   2 +-
> >  drivers/char/tpm/tpm2-cmd.c               |   9 +-
> >  drivers/char/tpm/tpm2-sessions.c          | 130 ++++++---------------
> >  include/linux/tpm.h                       |  49 +++++---
> >  security/keys/trusted-keys/trusted_tpm2.c | 134 +++++++++++++---------
> >  6 files changed, 155 insertions(+), 194 deletions(-)
> > 
> > -- 
> > 2.52.0
> > 
> 
> For hwrng we can e.g., calculate factor by timing tpm2_get_random() with
> and without HMAC encryption. Then we can use this as frequency how often 
> data is pulled.
> 
> The other angle to combine this is to maintain largeish FIFO of random 
> bytes and fill this when it goes below a treshold. 
> 
> Probably some combination of these will provide answer to performance
> and latency problem with hwrng when HMAC encryption is turned on:
> 
> 1. The first amortizes the overall quota.
> 2. Second provides constant latency without major spikes.

Another perhaps more unorthodox idea:

1. Calculate factor as said above. Let's call it N.
2. Every Nth step seed a pseudo rng from TPM.
3. On steps not divisible by N, pull from pseud rng.

I'm not a cryptographer but would randomness suffer from this? Then the
seeds that woud come from TPM are HMAC encrypted at least without major 
hits on performance.

Just enumerated this. Not sure about this idea yet by any means but I do 
like simplicy of it (and that also makes me concerned about missed
details).

BR, Jarkko

