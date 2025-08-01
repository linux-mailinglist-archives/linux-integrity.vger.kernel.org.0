Return-Path: <linux-integrity+bounces-6768-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A0AB18802
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5361691FE
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 20:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48160205ABF;
	Fri,  1 Aug 2025 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlkK79AR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643C77111;
	Fri,  1 Aug 2025 20:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079350; cv=none; b=sErRCzF3hwbjUrVJo+fZU6bedrtdajOEcB92cNakew+8sMTeq88PMeOLLTr1KOYS4gEHDaYbpJ4viX1a6oMGEagpQM1guHxvZDVAzw9PTpRI0hMAyqboTGkSziPw6I/GmS0yvOPCbJYeJ2qk+2IgE3YpwbTVjDTngKuyKoNB+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079350; c=relaxed/simple;
	bh=KCGSw5/Bp54la2qDUzQm9jnwIIRKcCH/zxZ0U6jbIC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shxKqJmm7hjxHdpOe8DWIPtYsbwWlP0o1NqIm2APFa63c+f1T2owuL8PinaeUYZXFMFtfRLodkHZ19R1pctMM8E5yXVUlDbg4S99F07NDCIVanDnkmnIbFOV3o6xAJW1t8mQ75QHGjbRmmEBUW3vZnr9SV31tsz1oo7BoJlRLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlkK79AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC67C4CEE7;
	Fri,  1 Aug 2025 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754079349;
	bh=KCGSw5/Bp54la2qDUzQm9jnwIIRKcCH/zxZ0U6jbIC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlkK79ARWGVT7sIpq4cFnVEYopFRn9V64rTfUBF9rZ4DqjNvenubWMhvAMblR8ep1
	 PEAjCh2ESWglpx0z6UJbG4BTRCr1803jOCJynTEKEFpI1cOoKjEB/NrdnZKjooG4lJ
	 tIOhfwm94wq+GSDSVpjeNYfxaLJo3ewoUqMCCZwAZlobtoOhxwaOr66BDv4DbklN1O
	 Z20L5WHfIR6PRmOVCpFUvKojlzFJgPv+otICGnZ6UqKj3d9eYaWEnLKombzirRlNpn
	 Z/s6w6EyDqsRfQk0Vhz8EAEUAEFCVjbW5F+Og885OPck4wf/7OqCf0Gh2r4qIYOmIu
	 ktuE87gs/RbAw==
Date: Fri, 1 Aug 2025 13:14:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: Compare HMAC values in constant time
Message-ID: <20250801201455.GA5141@sol>
References: <20250731215255.113897-2-ebiggers@kernel.org>
 <3ed1ae7e7f52afe53ce2ff00f362ed153b3eec20.camel@HansenPartnership.com>
 <20250801030210.GA1495@sol>
 <ca85bbe8a3235102707da3b24dba07a8649c3771.camel@HansenPartnership.com>
 <20250801171125.GA1274@sol>
 <2da3f6d36dccb86f19292015ea48e5d7a89e3171.camel@HansenPartnership.com>
 <20250801184026.GB1274@sol>
 <321c09c7cb2edb113ce9a829d37c0ae5c835e17f.camel@HansenPartnership.com>
 <20250801190331.GC1274@sol>
 <605314b70efde2e31f9e6a34a6bb0ea0060e0c67.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <605314b70efde2e31f9e6a34a6bb0ea0060e0c67.camel@HansenPartnership.com>

On Fri, Aug 01, 2025 at 03:20:52PM -0400, James Bottomley wrote:
> On Fri, 2025-08-01 at 12:03 -0700, Eric Biggers wrote:
> > On Fri, Aug 01, 2025 at 02:53:09PM -0400, James Bottomley wrote:
> > > On Fri, 2025-08-01 at 11:40 -0700, Eric Biggers wrote:
> > > > On Fri, Aug 01, 2025 at 02:03:47PM -0400, James Bottomley wrote:
> > > > > On Fri, 2025-08-01 at 10:11 -0700, Eric Biggers wrote:
> > > [...]
> > > > > > It's true that such attacks don't work with one-time keys. 
> > > > > > But here it's not necessarily a one-time key.  E.g.,
> > > > > > tpm2_get_random() sets a key, then authenticates multiple
> > > > > > messages using that key.
> > > > > 
> > > > > The nonces come one from us and one from the TPM.  I think ours
> > > > > doesn't change if the session is continued although it could,
> > > > > whereas the TPM one does, so the HMAC key is different for
> > > > > every communication of a continued session.
> > > > 
> > > > Again, tpm2_get_random() sets a HMAC key once and then uses it
> > > > multiple times.
> > > 
> > > No it doesn't.  If you actually read the code, you'd find it does
> > > what I say above.  Specifically  tpm_buf_fill_hmac_session() which
> > > is called inside that loop recalculates the hmac key from the
> > > nonces.  This recalculated key is what is used in
> > > tpm_buf_check_hmac_response(), and which is where the new tpm nonce
> > > is collected for the next
> > > iteration.
> > 
> > tpm_buf_fill_hmac_session() computes a HMAC value, but it doesn't
> > modify the HMAC key.  tpm2_parse_start_auth_session() is the only
> > place where the HMAC key is changed.  You may be confusing HMAC
> > values with keys.
> 
> Is this simply a semantic quibble about what gets called a key?  For
> each TPM command we compute a cphash across all the command parameters
> (and for each return a rphash).  This hash then forms a
> hmac(session_key, cphash | our_nonce | tpm_nonce | attrs).  The point
> being that although session_key is fixed across the session, the
> our_nonce and tpm_nonce can change with every iteration.  Since the
> cphash is over the ciphertext, it's the only bit you get to vary with a
> chosen ciphertext attack, so the other parameters effectively key the
> hmac.

No, it's not "simply a semantic quibble".  You're just wrong.

As I said earlier, our_nonce (which is not a key) does appear to make
MAC timing attacks not possible.  All the other fields appear to be
attacker-controlled, contrary to what you're claiming above.

Anyway, point taken: I'll drop the Fixes and Cc stable from the commit,
and include my own analysis of why MAC timing attacks don't appear to be
possible with this protocol.  Everything else in this thread has just
been a pointless distraction.

- Eric

