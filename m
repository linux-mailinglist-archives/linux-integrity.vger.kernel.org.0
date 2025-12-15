Return-Path: <linux-integrity+bounces-7998-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D313BCBFBE5
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 21:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAA9D301AD30
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF22F0C76;
	Mon, 15 Dec 2025 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTp7RHDd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB549659;
	Mon, 15 Dec 2025 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830354; cv=none; b=uRkjWFYfT86NPCocxIssCYYDAmnqgduNB4CLKGMy7r2we3vynvPLwi0NXK3s3A1VQtZgRzWr2fN2seZ+i2e/B5QU4yG/WERWnQx5Lq0ITVYuA5T9gIumRtvZir5FB6hI0/JjYKd4cGSb5sThWWVQl8CverHoYzEhF/GGrnbfj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830354; c=relaxed/simple;
	bh=1Zs5iK+zp4mSNpNc63YlbrbF/AZQvpY/4eaBQSOF+J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+d3qtj5U04V2Q1tXZuuiRwKe5Kgl4xVWe5e+vjutTfrdxxnHpf90U3Mk62iYpkwxvLtusw/SzYNWkivd/N6AxRL3v25MDxNufHYufiLPwp5ZGpxS6igYaShzwAEnr02iLHrb9L6fue1l9joDfI3BiIuXXPnGrHqy1WRax2an/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTp7RHDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A69C4CEF5;
	Mon, 15 Dec 2025 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765830353;
	bh=1Zs5iK+zp4mSNpNc63YlbrbF/AZQvpY/4eaBQSOF+J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTp7RHDdErEXKyeZ5jp5jGnlhCMn1VhjAQzkclkM4A4wyyti1aFwf9Dk2RNvVF3rK
	 I3ZvWoPq6BwSjpY75C803/94gFOoeUhjyCbGOLJ+7Otgewb8NWgQ8VnR3diQLFiWu4
	 xejMPtnLrC1ZQmlYvstj9QtiHcGnFUyUfZv9980r7aoqbd4GoHJ3HgM/nFL3x/iTGG
	 k2mxPb8dPjmRfvCOY5ac8szfB2243iAuCGf/tvo9Hlku1i5+w9/L1s/efVIXVm+ZFJ
	 MjqCeF2T3oU+AYSIZv+N3eA/puEq01AD8V55i6j+u/wfNLFUud9UBeyOIAYN+C02k9
	 ZZuq7I8YrBrXQ==
Date: Mon, 15 Dec 2025 22:25:50 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <aUBuzsOx0x8EwatB@kernel.org>
References: <20251214213236.339586-1-jarkko@kernel.org>
 <64e3e4e0a92848fd3b02a213c754f096d2026463.camel@HansenPartnership.com>
 <aT-uHgyYw3XhFasi@kernel.org>
 <60cf8bd2afbad5e930119d73ccf069e95ee4fd9d.camel@HansenPartnership.com>
 <aT_Lh8l3E2yQJYI7@kernel.org>
 <aUBk2nUpd2V8p9qc@kernel.org>
 <5446f517848338b4ccac8d7bbedf4cc1ed315cb4.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5446f517848338b4ccac8d7bbedf4cc1ed315cb4.camel@HansenPartnership.com>

On Mon, Dec 15, 2025 at 09:01:49PM +0100, James Bottomley wrote:
> On Mon, 2025-12-15 at 21:43 +0200, Jarkko Sakkinen wrote:
> [...]
> > I think there is misunderstanding with FIPS.
> > 
> > Having FIPS certificated RNG in TPM matters but it only matters only
> > in the sense that callers can be FIPS certified as they use that RNG
> > as a source.
> > 
> > Using FIPS certified RNG does not magically make callers be FIPS 
> > ceritified actors. The data is contaminated in that sense at the
> > point when kernel acquires it.
> 
> I think FIPS certification is a red herring.  The point being made in
> the original thread is about RNG quality.  The argument essentially
> being that the quality of the TPM RNG is known at all points in time
> but the quality of the kernel RNG (particularly at start of day when
> the entropy pool is new) is less certain.

OK, that's fair point.

I.e., using TPM2_GetRandom here makes sense, not because of FIPS
certification per se but because it is guarantees matching entropy to
other types of keys generated with TPM2_Create (as everything uses the
same RNG).

I can buy this but think it would really make sense to add a comment to
the source code.

I was thinking something along the lines of:

/*
 * tpm_get_random() is used here directly instead of relying kernel's
 * RNG in order to match RNGs with objects generated by TPM internally.
 */

It does not mention FIPS explicitly because I think this is already
enforcing condition and thus enough. And e.g., applies also when one
uses an emulator (and thus useful tidbit for that use and purpose).

> 
> Regards,
> 
> James
> 

BR, Jarkko

