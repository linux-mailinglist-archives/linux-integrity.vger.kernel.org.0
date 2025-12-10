Return-Path: <linux-integrity+bounces-7885-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D32CB195B
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 02:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DC7030225A2
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 01:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4F1E47C5;
	Wed, 10 Dec 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7E6xAvw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751962032D;
	Wed, 10 Dec 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765329339; cv=none; b=Q8czBOjsHN4FmVVEf2PPoKDRkXmqCLHXjpCcWs9x8bsPBR8yEHHk7UKq8qWfQu6oNkc6T+l3jCXdo6jxszctoiL/YttVqaUskA3nakegcOrkGTgp5ngd6nTxF1MPZ6Pwa6iIWh08a0+bGqWEn7nI+hQ1KD8jcSEr59hDm0Ufk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765329339; c=relaxed/simple;
	bh=qfCf0jZSwmNZ7QZUIDNQ2sTYMrRE6CST2dy2cbqolCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXSFvSPuho0VrA/USn2FXtr8mValZ1Mj672tsQDvWZ/Z3LjeGHj4BWYt9tsTiVEJ4ssj45KEzBX94uF1JvYlTIPepxC1TrD9rnfawasBJDNhF6rxonexirnqC6mh4RNq//l8iPbnt/R94Pi970hrv6uA4pbzJJKHlUmJqAojoZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7E6xAvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB128C4CEF5;
	Wed, 10 Dec 2025 01:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765329339;
	bh=qfCf0jZSwmNZ7QZUIDNQ2sTYMrRE6CST2dy2cbqolCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7E6xAvws2TEZjxKYuUsT3MOWDZJoMLbA/i/ul+RhoZ+WbnitDQ4HblsJxMIiGTQC
	 1u5ZtQhJocDXnN9fOcDq+p+xJiuwKM9LsguDJtshyHDN6WjnNenLmb2J1fGFdx2P0N
	 +Dklvtok3+4ndYqcgFJYUlO/rTO/7zLKpO8QP+PIorQd0tZxo5UZcXMEID4HQ6Y3Kx
	 rKjdXejEmF6AZ7/HtDBzY4NUOsVWhP8XBF3J9mfufxOVg7VE+EBM4wQUfEjIXTgWwc
	 nOUzi2f51wc9xeG7YFva6kEnSp2UYMXONCZ6Be5hCM1g8ZoytHpZKqtkD1hwIKiEoP
	 WYpyKBRW4MW3w==
Date: Wed, 10 Dec 2025 03:15:35 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 0/5] Streamline TPM2 HMAC sessions
Message-ID: <aTjJtw4mx9URFrE7@kernel.org>
References: <20251209100529.1700779-1-jarkko@kernel.org>
 <aThDeSWFhbI6GRgh@kernel.org>
 <aThdJwpDWD_-hhy6@kernel.org>
 <aThqCYgK1_zvk5UO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aThqCYgK1_zvk5UO@kernel.org>

On Tue, Dec 09, 2025 at 08:27:25PM +0200, Jarkko Sakkinen wrote:
> On Tue, Dec 09, 2025 at 07:32:27PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Dec 09, 2025 at 05:42:55PM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Dec 09, 2025 at 12:05:23PM +0200, Jarkko Sakkinen wrote:
> > > > Since we cannot at this point cache names of the keys given limitations
> > > > of the ASN.1 file format, I'll start a fresh patch set. Let's fixup what
> > > > we can right now.
> > > > 
> > > > This patch set addresses two major issues in the feature:
> > > > 
> > > > 1. Dynamic resolution without gain. All kernel sites have at most single
> > > >    handle to authorize. Even if this changes some day this is how it is
> > > >    as of today and we definitely do not want to dictate the future but
> > > >    instead downscale code to the metrics that we have as of today.
> > > > 2. Eliminate at least one unnnecessary tpm2_read_public() call.
> > > > 
> > > > Jarkko Sakkinen (5):
> > > >   KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
> > > >   tpm2-sessions: Define TPM2_NAME_MAX_SIZE
> > > >   KEYS: trusted: Re-orchestrate tpm2_read_public() calls
> > > >   tpm2-sessions: Remove AUTH_MAX_NAMES
> > > >   tpm-buf: Remove tpm_buf_append_handle
> > > > 
> > > >  drivers/char/tpm/tpm-buf.c                |  25 ----
> > > >  drivers/char/tpm/tpm-sysfs.c              |   2 +-
> > > >  drivers/char/tpm/tpm2-cmd.c               |   9 +-
> > > >  drivers/char/tpm/tpm2-sessions.c          | 130 ++++++---------------
> > > >  include/linux/tpm.h                       |  49 +++++---
> > > >  security/keys/trusted-keys/trusted_tpm2.c | 134 +++++++++++++---------
> > > >  6 files changed, 155 insertions(+), 194 deletions(-)
> > > > 
> > > > -- 
> > > > 2.52.0
> > > > 
> > > 
> > > For hwrng we can e.g., calculate factor by timing tpm2_get_random() with
> > > and without HMAC encryption. Then we can use this as frequency how often 
> > > data is pulled.
> > > 
> > > The other angle to combine this is to maintain largeish FIFO of random 
> > > bytes and fill this when it goes below a treshold. 
> > > 
> > > Probably some combination of these will provide answer to performance
> > > and latency problem with hwrng when HMAC encryption is turned on:
> > > 
> > > 1. The first amortizes the overall quota.
> > > 2. Second provides constant latency without major spikes.
> > 
> > Another perhaps more unorthodox idea:
> > 
> > 1. Calculate factor as said above. Let's call it N.
> > 2. Every Nth step seed a pseudo rng from TPM.
> > 3. On steps not divisible by N, pull from pseud rng.
> > 
> > I'm not a cryptographer but would randomness suffer from this? Then the
> > seeds that woud come from TPM are HMAC encrypted at least without major 
> > hits on performance.
> > 
> > Just enumerated this. Not sure about this idea yet by any means but I do 
> > like simplicy of it (and that also makes me concerned about missed
> > details).
> 
> Third option would be to have simply a kthread with a rate that fills a
> pool and hwrng callbacks serves from that pool. If there is no bytes,
> there is no bytes (which is fine as far as API is concerned).
> 
> This has optimal system latency properties I'd figure.

OK so the very first thing that should be done with hwrng is this: it 
should be opportunistic instead of being committing (to X number of 
bytes). Further optimizations should be considered only after changing
this heuristics.

That guarantees that when hwrng's thread queries bytes from TPM driver
it is guaranteed to cause always exactly one TPM2_GetRandom transaction.

How this can be done is to first re-orchestrate tpm_get_random() along 
the lines (out of top of my head, did not even compile this):

int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
{
	u32 num_bytes = max;
	u8 *out_ptr = out;
	int retries = 5;
	int total = 0;
	int rc;

	if (!out || !max || max > TPM_MAX_RNG_DATA)
		return -EINVAL;

	if (!chip)
		return -ENODEV;

	rc = tpm_try_get_ops(chip);
	if (rc)
		return rc;

	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
		rc = tpm2_start_auth_session(chip);
		if (rc)
			return rc;
	}

	do {
		if (chip->flags & TPM_CHIP_FLAG_TPM2)
			rc = tpm2_get_random(chip, out_ptr, num_bytes);
		else
			rc = tpm1_get_random(chip, out_ptr, num_bytes);

		if (rc < 0)
			goto err;

		out_ptr += rc;
		total += rc;
		num_bytes -= rc;
	} while (retries-- && total < max);

	tpm_put_ops(chip);
	return total ? total : -EIO;

err:
	if (chip->flags & TPM_CHIP_FLAG_TPM2)
		tpm2_end_auth_session(chip);

	tpm_put_ops(chip);
	return rc;
}
EXPORT_SYMBOL_GPL(tpm_get_random);

{tpm1,tpm2}_get_random() are changed to do exactly single transaction
and on success they return how many bytes were read.

hwrng code should also use {tpm1,tpm2}_get_random() and use the
requested size as a hint not as something that we commit into.

I think this will benefit kernel even without HMAC encryption because
it objectively makes things a bit more deterministic.

BR, Jarkko





