Return-Path: <linux-integrity+bounces-6764-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D27B18770
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 20:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186B07AEE4E
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A27728D821;
	Fri,  1 Aug 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tstNHemc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8628CF64;
	Fri,  1 Aug 2025 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754073682; cv=none; b=BxeWve87iBMHa7MaLg5j0Y7ZCRJg9hykntQ4Ftj7meBGMT82KWHMDJIb0Tsqg85YM1at6FYynmw3381URg6f4hWol1rC0W/Bz+Vi3SK+7H1gawpJEow8JERWXZE+XaoGThSXgVzCe3MdjdV4PbCABUZ0nWdyZWsG6kWj7Z/NtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754073682; c=relaxed/simple;
	bh=ei95QW6esLuBX+yTa/X+N5Vy762EMZeY8mtY2NZ88fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+1a5mnTv4RFOuikYoy/Gg+bN3GF0+0kp5S5Zr+p7XEuJfcYJBTu6Ae6zOlBdZCJuJD5YZNF9J0y294v0o6u2BL2o7CAELmoV9M7RsnDS1FdZMwUP56PCJPjqz9WTtvhKiABy/Va9t1kdd1zXVAcB6Y8eICpofF1+sXSdzdDNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tstNHemc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D49C4CEF6;
	Fri,  1 Aug 2025 18:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754073680;
	bh=ei95QW6esLuBX+yTa/X+N5Vy762EMZeY8mtY2NZ88fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tstNHemcd5wzcjRC/QD1CLK+sbGY2MszjBJp+M5ZqIAv1Air0jU6XOPB/qtzR04ku
	 5CErO6fgW0zcKViGmXXnHd6mI/pGUXIyZuoG0tAmulzh7DqafBWyhfxC35q+WXBVah
	 e82lprQcQDTYOvs1jJMwoB5or7J65KVVvIS6tLAB2vzLNWx6I6wV0IolxVsBKix9m1
	 ofTXyXtoM1XXN9K4k075U/QbDH39v4DqJozpwrZtuhp1UhFH1mhUqK5/k9g151klc6
	 Hmg78rut2UaCPmLqEZY72VFOxdQqU7ib2FZzsR/1GjmadwF4uOi2JP/jgm+T3Q/vGL
	 L3NUDE81dUGiw==
Date: Fri, 1 Aug 2025 11:40:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: Compare HMAC values in constant time
Message-ID: <20250801184026.GB1274@sol>
References: <20250731215255.113897-1-ebiggers@kernel.org>
 <20250731215255.113897-2-ebiggers@kernel.org>
 <3ed1ae7e7f52afe53ce2ff00f362ed153b3eec20.camel@HansenPartnership.com>
 <20250801030210.GA1495@sol>
 <ca85bbe8a3235102707da3b24dba07a8649c3771.camel@HansenPartnership.com>
 <20250801171125.GA1274@sol>
 <2da3f6d36dccb86f19292015ea48e5d7a89e3171.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da3f6d36dccb86f19292015ea48e5d7a89e3171.camel@HansenPartnership.com>

On Fri, Aug 01, 2025 at 02:03:47PM -0400, James Bottomley wrote:
> On Fri, 2025-08-01 at 10:11 -0700, Eric Biggers wrote:
> > On Fri, Aug 01, 2025 at 07:36:02AM -0400, James Bottomley wrote:
> > > On Thu, 2025-07-31 at 20:02 -0700, Eric Biggers wrote:
> > > > On Thu, Jul 31, 2025 at 10:28:49PM -0400, James Bottomley wrote:
> > > > > On Thu, 2025-07-31 at 14:52 -0700, Eric Biggers wrote:
> > > > > > To prevent timing attacks, HMAC value comparison needs to be
> > > > > > constant time.  Replace the memcmp() with the correct
> > > > > > function, crypto_memneq().
> > > > > 
> > > > > Um, OK, I'm all for more security but how could there possibly
> > > > > be a timing attack in the hmac final comparison code?  All it's
> > > > > doing is seeing if the HMAC the TPM returns matches the
> > > > > calculated one.  Beyond this calculation, there's nothing
> > > > > secret about the HMAC key.
> > > > 
> > > > I'm not sure I understand your question.  Timing attacks on MAC
> > > > validation are a well-known issue that can allow a valid MAC to
> > > > be guessed without knowing the key.  Whether it's practical in
> > > > this particular case for some architecture+compiler+kconfig
> > > > combination is another question, but there's no reason not to use
> > > > the constant-time comparison function that solves this problem.
> > > > 
> > > > Is your claim that in this case the key is public, so the MAC
> > > > really just serves as a checksum (and thus the wrong primitive is
> > > > being used)?
> > > 
> > > The keys used for TPM HMAC calculations are all derived from a
> > > shared secret and updating parameters making them one time ones
> > > which are never reused, so there's no benefit to an attacker
> > > working out after the fact what the key was.
> > 
> > MAC timing attacks forge MACs; they don't leak the key.
> 
> > It's true that such attacks don't work with one-time keys.  But here
> > it's not necessarily a one-time key.  E.g., tpm2_get_random() sets a
> > key, then authenticates multiple messages using that key.
> 
> The nonces come one from us and one from the TPM.  I think ours doesn't
> change if the session is continued although it could, whereas the TPM
> one does, so the HMAC key is different for every communication of a
> continued session.

Again, tpm2_get_random() sets a HMAC key once and then uses it multiple
times.

> > I guses I'm struggling to understand the point of your comments.
> 
> Your commit message, still quoted above, begins "To prevent timing
> attacks ..." but I still don't think there are any viable timing
> attacks against this code.  However, that statement gives the idea that
> it's fixing a crypto vulnerablility and thus is going to excite the AI
> based CVE producers.
> 
> >   Even if in a follow-up message you're finally able to present a
> > correct argument for why memcmp() is okay, it's clearly subtle enough
> > that we should just use crypto_memneq() anyway, just like everywhere
> > else in the kernel that validates MACs.  If you're worried about
> > performance, you shouldn't be: it's a negligible difference that is
> > far outweighed by all the optimizations I've been making to
> > lib/crypto/.
> 
> So if you change the justification to something like "crypto people
> would like to update hmac compares to be constant time everywhere to
> avoid having to check individual places for correctness" I think I'd be
> happy.

Sure, provided that memcmp() is actually secure here.  So far, it hasn't
been particularly convincing when each argument you've given for it
being secure has been incorrect.

But I do see that each call to tpm_buf_check_hmac_response() is paired
with a call to tpm_buf_append_hmac_session() which generates a fresh
nonce.  That nonce is then sent to the other endpoint (the one that
claims to be a TPM) and then implicitly becomes part of the response
message (but is not explicitly transmitted back in it).  That may be the
real reason: messages are guaranteed to not be repeated, so a MAC timing
attack can't be done.  Do you agree that is the actual reason?

- Eric

