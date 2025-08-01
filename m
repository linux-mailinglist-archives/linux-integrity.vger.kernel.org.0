Return-Path: <linux-integrity+bounces-6759-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62396B17B5C
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 05:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159743BBA12
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Aug 2025 03:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234716D9C2;
	Fri,  1 Aug 2025 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8iyhB4o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC378F58;
	Fri,  1 Aug 2025 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754017384; cv=none; b=QkPBOT0fnfsKKofKFdvN1OaQrKyqFYfU8JRFw4qMKr8WhJqrXYB+khQcu71NVkc5kD4rnsypkKXLwNrJVab2I5sRNJ+fU20XnnwY8Lw9E5I/oJW+24WThG9oHzxRwXZLOl+Ym/Y6g/Y3tzn87YePq3erS/xKMbueauj6BsTQKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754017384; c=relaxed/simple;
	bh=quGH+SvR7bXJv9qhJhzkeJz0csmh9NaqTLDZAMtDyhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjK8PQduiwBxn4c8McUtYn3oXg7+TEpSdrMOhmiJdyz9QozSQkD1KWMgSQokN14YYRX0fBQVhre0EUoFXYSej3w0qt9r5YcrEK3+P6GLRColOJ2ltP/NHqi2ZEZfgLe2Ys14yanlybw+5zFsKwuKiJypuqGdZlURzWil6Zr5E4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8iyhB4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21974C4CEEF;
	Fri,  1 Aug 2025 03:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754017384;
	bh=quGH+SvR7bXJv9qhJhzkeJz0csmh9NaqTLDZAMtDyhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8iyhB4oTyqGaY7X2P10uIIfCZQ9q+1IfCwuPgZytOaF4cqxuLtSrPLQ2DrY+P56r
	 g7gRwmCkzX8Vvd/Gndu5NgRsEGkAwh27/bwep13Wc+ZnbtRH0ixVcsRYBGOpz1J9un
	 6FRdMRoTPLtSStfjivwD4nbWgAaeL46ThOrBdqwsd9K9cpRb6ZY4UNHSF05o/A9iCS
	 ginIPFYPWTPCNCp1VhXxlNzKDnjA8/CCdEh7A5j12fmcQZj7+cEc4yIS0cXOWiZmij
	 eYarmWO5yCxhBwaRi33fQkQuXriw9gHndwc/f/AqtA3ja5AKJfdMiqk4aJoZWD0zAD
	 ZS5N9aoeDO0Jw==
Date: Thu, 31 Jul 2025 20:02:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: Compare HMAC values in constant time
Message-ID: <20250801030210.GA1495@sol>
References: <20250731215255.113897-1-ebiggers@kernel.org>
 <20250731215255.113897-2-ebiggers@kernel.org>
 <3ed1ae7e7f52afe53ce2ff00f362ed153b3eec20.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ed1ae7e7f52afe53ce2ff00f362ed153b3eec20.camel@HansenPartnership.com>

On Thu, Jul 31, 2025 at 10:28:49PM -0400, James Bottomley wrote:
> On Thu, 2025-07-31 at 14:52 -0700, Eric Biggers wrote:
> > To prevent timing attacks, HMAC value comparison needs to be constant
> > time.  Replace the memcmp() with the correct function,
> > crypto_memneq().
> 
> Um, OK, I'm all for more security but how could there possibly be a
> timing attack in the hmac final comparison code?  All it's doing is
> seeing if the HMAC the TPM returns matches the calculated one.  Beyond
> this calculation, there's nothing secret about the HMAC key.

I'm not sure I understand your question.  Timing attacks on MAC
validation are a well-known issue that can allow a valid MAC to be
guessed without knowing the key.  Whether it's practical in this
particular case for some architecture+compiler+kconfig combination is
another question, but there's no reason not to use the constant-time
comparison function that solves this problem.

Is your claim that in this case the key is public, so the MAC really
just serves as a checksum (and thus the wrong primitive is being used)?

- Eric

