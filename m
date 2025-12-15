Return-Path: <linux-integrity+bounces-7986-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA277CBD080
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 09:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E12C23027D9C
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E23328E6;
	Mon, 15 Dec 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/YmHZDC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6093328FC;
	Mon, 15 Dec 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788555; cv=none; b=u1m1CWOVBEOelRAIid4+CFlXW2iKJbf9+miZTaXPc7uUAnyBLmjK4Au/COpOjybWF4zqH0E1XKcUpCB7c5YnZlzAaLfwwyKL/py3UqwEZjFpvC3IbidjlpZHg8TCzcIkGmpeeP5jVZbKFYnc80j1FcoFaDkPJKD0n86I6kW0Bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788555; c=relaxed/simple;
	bh=NYVGG4tmiyG5B75OmUic/U7JhbC5UuDSz+EfTWu3c4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqt2I9zuSX0REOY++GSZ5446mwXPOmGPuVUdMJCD8jMh21ZIgZgH4vHf0ClLXfZr596S5UQEDgGmWRbVe5X1GoX0vp0Z1HMHxNShjthUBjb78ZptTjZHtgSHs6dfZeMGdjiQ6zvsAIBgkJVuSoQ+XcAqGSywz1SUBskFFplGuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/YmHZDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED97C19421;
	Mon, 15 Dec 2025 08:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765788554;
	bh=NYVGG4tmiyG5B75OmUic/U7JhbC5UuDSz+EfTWu3c4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/YmHZDCgxWso/NlIPXQynhY7Rtohue2QWgWnThqaOCeFD21ko+QmOccxcWKvIWPo
	 vhGuE2i853otCl5yA8I/xX3SIeM9ZVUFzDEcQpDDicRjxTaWROaUxXGz1AI5GXDLN5
	 r3F2ZAbcCNZS30rAv8knV8Xi/+s576PvVvcTT5cn9bKkHKmvpcK9T2nMt5gXQa3Zrk
	 YaAvkveHQoXO+MoKHpBassTrhWZsJo+1naP2nUOS5k2U5epy9dlJ1gY8u3JJsYoVM5
	 TRQ0KugOJ4IGEr0BJKgqPHtMp4Qr+A2ZAuBnzCwmiBdoz+qIiQ8AhWLXRJ8JNTxW/T
	 XcHQFZT0DKVWA==
Date: Mon, 15 Dec 2025 10:49:11 +0200
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
Message-ID: <aT_Lh8l3E2yQJYI7@kernel.org>
References: <20251214213236.339586-1-jarkko@kernel.org>
 <64e3e4e0a92848fd3b02a213c754f096d2026463.camel@HansenPartnership.com>
 <aT-uHgyYw3XhFasi@kernel.org>
 <60cf8bd2afbad5e930119d73ccf069e95ee4fd9d.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60cf8bd2afbad5e930119d73ccf069e95ee4fd9d.camel@HansenPartnership.com>

On Mon, Dec 15, 2025 at 04:55:58PM +0900, James Bottomley wrote:
> On Mon, 2025-12-15 at 08:43 +0200, Jarkko Sakkinen wrote:
> > On Mon, Dec 15, 2025 at 07:18:41AM +0900, James Bottomley wrote:
> > > On Sun, 2025-12-14 at 23:32 +0200, Jarkko Sakkinen wrote:
> > > > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and
> > > > thus its use should be pooled rather than directly used. This
> > > > both reduces latency and improves its predictability.
> > > > 
> > > > 2. Linux is better off overall if every subsystem uses the same
> > > > source for the random bistream as the de-facto choice, unless
> > > > *force majeure* reasons point to some other direction.
> > > > 
> > > > In the case, of TPM there is no reason for trusted keys to invoke
> > > > TPM directly.
> > > 
> > > That assertion isn't correct: you seem to have forgotten we had
> > > this argument six or seven years ago, but even that was a reprise
> > > of an even earlier one.  Lore doesn't go back far enough for the
> > > intermediate one on the tpm list, but the original was cc'd to
> > > lkml:
> > > 
> > > https://lore.kernel.org/all/1378920168.26698.64.camel@localhost/
> > > 
> > > The decision then was to use the same random source as the key
> > > protection.  Unfortunately most of the active participants have
> > > moved on from IBM and I don't have their current email addresses,
> > > but the bottom line is there were good reasons to do trusted keys
> > > this way that your assertions above don't overcome.  I'm not saying
> > > we shouldn't reconsider the situation, but we need a reasoned
> > > debate rather than simply doing it by fiat.
> > 
> > The way I see this is that given that kernel is not running inside
> > TPM, FIPS certification of the RNG does not have any measurable
> > value.
> > 
> > Random data generation should happen as part of object creation
> > process i.e. should be fully self-contained process within the TPM in
> > order for FIPS to matter.
> 
> In FIPS terms, there's no distinction between keeping the whole
> generation process internal to the TPM and using the FIPS certified rng
> of the TPM to source the contents of a kernel protected key.  Both
> provide equally valid, and FIPS certified data.

I understand being "FIPS certified" embedding the premise that kernel
is also FIPS certified, which covers also crypto etc. This is the case
with enterprise kernels.

I have understanding FIPS certification dies at the point when random
data is acquired by a kernel, which is not FIPS certified. It's not 
really a safe closure.

Using same code path for RNG universally should actually help with any
certification processes.

> 
> > In the case of sealed data objects, this not the case.
> 
> FIPS is concerned with origins and provenance, so it most certainly is
> the case even for trusted keys.  However, if the Kernel RNG is fips
> certified (as can happen with certain FIPS modules) it is the case that
> either the Kernel or TPM RNG would satisfy the FIPS requirement.  The
> question for trusted key users is really do they always want the TPM
> FIPS RNG or should we allow mixing with the kernel RNG even in the non-
> FIPS case.

I don't disagree on benefits of FIPS certification.

> 
> Perhaps, rather than getting hung up on FIPS sources and to facilitate
> debating the bedrock requirements, we could turn this around and ask
> what the use case you have for using the in-kernel RNG is?

Generally removing any non-mandatory TPM traffic is a feasible idea.

This was just something low-hanging fruit that I spotted while working
on larger patch set.

BR, Jarkko

> 
> Regards,
> 
> James
> 
> 
> 

BR, Jarkko

