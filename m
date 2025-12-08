Return-Path: <linux-integrity+bounces-7857-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E2CAE081
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 19:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADAB2306FD84
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408352D131A;
	Mon,  8 Dec 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdFAXEVj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB72C2365;
	Mon,  8 Dec 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220172; cv=none; b=eEiQOaTdRpa00+NnI+7H2R/iO5u3m3qAIKBf2onnCjvwdBXgw4XjbJfwVZ7ZY5MJ7+ifHitUR74AubMeUztyhs5ALVqBiBvWoQo4+4E1nLGNCHn60c+zxbOwztlKCNVN/BN89MgeuJH7sH3Ej9kTeyS1GZkL48i1BgU7U0zjcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220172; c=relaxed/simple;
	bh=yQMkfGmn0MOXTC4BAMSxuYNjJ80JoP30OtHtPXabo6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtvKPXgEZ0wjqyt4bWrP43fm11Kz9GpzT0f9T/NPoqG3Al5KNSAh5w/aH1C9ZrJXS4THFcG+HJJLu88gVPuMecL/YYjyMEG1W0x2iqBPlr4Bpi6G6E8y6SxZLZUyvauB2mcV8D33G2gi0KZguNCfT341eBS1wWuavhtJ97qQPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdFAXEVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C71C4CEF1;
	Mon,  8 Dec 2025 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765220171;
	bh=yQMkfGmn0MOXTC4BAMSxuYNjJ80JoP30OtHtPXabo6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdFAXEVjl5OULedlzxVMx6JKk0KMl3W5YAR9g2/8KPMj+1JX/D9WwDKyDbwKXrPCo
	 9Q3tYKtPyDI3Zubbem74QQ0+fKQS7z+l++ZnDSmgKuguXfYpzqqizetPArDBxDcDot
	 1nVrm1t4UWi4jwpMGz85Hl4nes3MW/Zv3aY/6SUkeqF8+n+LFSeF2m6SWUjU0fQOZm
	 n8hohOwDRi5ONP73RxneEaRrrFIlRZRUi6LCHSX3p5pDztD+JRuWnX/w/S4QL3OAUk
	 7KXxrB3WOiQ7lO8E2Yp19KqLcvRJwni2qOONp8QoVwvikDsZOzhvzxJSRxgBby/NRX
	 dBS0fZr95fGqA==
Date: Mon, 8 Dec 2025 20:56:08 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Fix overwrite of keyhandle parameter
Message-ID: <aTcfSGdPUWbt2785@kernel.org>
References: <20251208145436.21519-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208145436.21519-1-jarkko@kernel.org>

On Mon, Dec 08, 2025 at 04:54:35PM +0200, Jarkko Sakkinen wrote:
> tpm2_key_decode() overrides the explicit keyhandle parameter, which can
> lead to problems, if the loaded parent handle does not match the handle
> stored to the key file. This can easily happen as handle by definition
> is an ambiguous attribute.
> 
> Cc: stable@vger.kernel.org # v5.13+
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

What this means in practice is that sometimes you need either to:

1. Binary patch the key file.
2. Decompose/compose a key file

BR, Jarkko

