Return-Path: <linux-integrity+bounces-6762-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E7B18658
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 19:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D8A1722BF
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8D1DDC33;
	Fri,  1 Aug 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn/Z396P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3C19C546;
	Fri,  1 Aug 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068340; cv=none; b=c4GEuHsr5Fqc9b9JN3POPq+leo7yIrlkiND73oSZ6hIx54Swg7EU4OtfIwhHlDcrwj7bx9b7/fTJlswNzlYNHEM3KWzhNLTabMfKQ7Kz7E3H5pcOI0SK/bA7xum8q/H23hz9YBdLfFwjDNj5hs0VFARDfvlZ5hvBRg4sJXeLlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068340; c=relaxed/simple;
	bh=LI+9vIXQyXYMQ5l69iISjUVlyZxD27Q/G66vKtq+D0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+KXrTGw15jV5wYYam8SBUQOohuToCZ5kW7MnTrSxiCA67WZDKDEfpw4sMNidh13BjK0BOKH0pziUuvaGEZiODwou0oPBwYyTsZgaTLKh9tU7PrJU/fchSSV79IOTnAEZRS4nlFtV78LxYUS76BQJx7aZ4FDDD62ze3x0jXadfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn/Z396P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7D0C4CEE7;
	Fri,  1 Aug 2025 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754068340;
	bh=LI+9vIXQyXYMQ5l69iISjUVlyZxD27Q/G66vKtq+D0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fn/Z396POMAzluy05EDt3/mitj7A2mSjGV6fe1IwLfSb9TAThrQ8/9N2RDo79d/fW
	 TM/Jk8MAu+0Owi6MtDIIY2lLD1NB3vqXG3N5hQNda8DCDO2SLvEwmoyhVIhJEPQu3F
	 I0UVP1j1X71uPUnw4Gez6yxVyGUHxU2aR8hdUGIgDHSoMpO8eMgKjyK384taV8/URt
	 /XfwIcQBm3I5JD6r4fMrsYGPaT1zQ+iVkMqQFiZXblnfgw9T05/UymLuXTjSS+AziS
	 nJR/yaCELOyphJ1fwkxzSw6gj7VXk/Aa1LH0+owC2EDaMWwHPyOigs/1nlBLAjLrOI
	 0eFVF+PwpBjEg==
Date: Fri, 1 Aug 2025 10:11:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: Compare HMAC values in constant time
Message-ID: <20250801171125.GA1274@sol>
References: <20250731215255.113897-1-ebiggers@kernel.org>
 <20250731215255.113897-2-ebiggers@kernel.org>
 <3ed1ae7e7f52afe53ce2ff00f362ed153b3eec20.camel@HansenPartnership.com>
 <20250801030210.GA1495@sol>
 <ca85bbe8a3235102707da3b24dba07a8649c3771.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca85bbe8a3235102707da3b24dba07a8649c3771.camel@HansenPartnership.com>

On Fri, Aug 01, 2025 at 07:36:02AM -0400, James Bottomley wrote:
> On Thu, 2025-07-31 at 20:02 -0700, Eric Biggers wrote:
> > On Thu, Jul 31, 2025 at 10:28:49PM -0400, James Bottomley wrote:
> > > On Thu, 2025-07-31 at 14:52 -0700, Eric Biggers wrote:
> > > > To prevent timing attacks, HMAC value comparison needs to be
> > > > constant time.  Replace the memcmp() with the correct function,
> > > > crypto_memneq().
> > > 
> > > Um, OK, I'm all for more security but how could there possibly be a
> > > timing attack in the hmac final comparison code?  All it's doing is
> > > seeing if the HMAC the TPM returns matches the calculated one. 
> > > Beyond this calculation, there's nothing secret about the HMAC key.
> > 
> > I'm not sure I understand your question.  Timing attacks on MAC
> > validation are a well-known issue that can allow a valid MAC to be
> > guessed without knowing the key.  Whether it's practical in this
> > particular case for some architecture+compiler+kconfig combination is
> > another question, but there's no reason not to use the constant-time
> > comparison function that solves this problem.
> > 
> > Is your claim that in this case the key is public, so the MAC really
> > just serves as a checksum (and thus the wrong primitive is being
> > used)?
> 
> The keys used for TPM HMAC calculations are all derived from a shared
> secret and updating parameters making them one time ones which are
> never reused, so there's no benefit to an attacker working out after
> the fact what the key was.

MAC timing attacks forge MACs; they don't leak the key.

It's true that such attacks don't work with one-time keys.  But here
it's not necessarily a one-time key.  E.g., tpm2_get_random() sets a
key, then authenticates multiple messages using that key.

I guses I'm struggling to understand the point of your comments.  Even
if in a follow-up message you're finally able to present a correct
argument for why memcmp() is okay, it's clearly subtle enough that we
should just use crypto_memneq() anyway, just like everywhere else in the
kernel that validates MACs.  If you're worried about performance, you
shouldn't be: it's a negligible difference that is far outweighed by all
the optimizations I've been making to lib/crypto/.

- Eric

