Return-Path: <linux-integrity+bounces-6783-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA4B1B96E
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 19:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF4B6276CF
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Aug 2025 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE39F296141;
	Tue,  5 Aug 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnX8WX8U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D901DE89B;
	Tue,  5 Aug 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415206; cv=none; b=TCLJEDl1PAsL1Rcx2jD9D4nBDnPuJY3UmnYPt6gmoExlZm1QwZ8qAdrSzncCJPQ/UNHXsOVbj+8FkYodvv9JOowdB8B6x+MFPMw6/ikosupYpiQqV1yAepnETJ2L9QGataZg5vbWgC01NY1N4LN2jP8rNRTVsBgRkv83trK8UfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415206; c=relaxed/simple;
	bh=xKLTaPmkGXBFvXl3XUKTl88pEWQVbIeYja/4V79uWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwf1JfZ5B1ZNOmB2LGvCdg20V557KD0i1mviy/CTxIaUeJTFYL58eIWKd6NFJuPy6n89cKZjsZRqQuDRki7BKAqiM0Vx5x/nb7G7YNt57Nr/KMtwgXnDjZ2THVVD0kFnPu7+L5tyi/MaAh+5sT826r59ZjsL3ERZLukZKeK1SlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnX8WX8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02D3C4CEF0;
	Tue,  5 Aug 2025 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754415206;
	bh=xKLTaPmkGXBFvXl3XUKTl88pEWQVbIeYja/4V79uWxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnX8WX8UrmWeremNroW2pK3wWSrvLnmYhB5iQN2eYGUi2XTBxUqjL/ThFsoUsvHva
	 OIH7l9xIj4T5Kf+kt5rhF1+foSLbAu5Kwqu/H7Nf++9khug34Qebx0q0NT73uv8k5L
	 NtmYCMTT04r6D9ubFrbbfe8Dg0EWAsY+pCfCXANCE9iMKMc5+1FKAL8FwxtREK721e
	 DRyYJMIZSmPvg6u4y/J7qocmguvL1+jPTNIDi7jeHQTnQjR3OA65DFKLyaqAFFxTb4
	 s799vYtdnbhAWKNKflohtVCfaCZkwTpeDsZwZX9dU3hdvFRfFXMMHjOgMTwkmP7vHM
	 sfer+5deMI8ug==
Date: Tue, 5 Aug 2025 10:32:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] KEYS: trusted_tpm1: Compare HMAC values in constant
 time
Message-ID: <20250805173227.GD1286@sol>
References: <20250731212354.105044-1-ebiggers@kernel.org>
 <20250731212354.105044-2-ebiggers@kernel.org>
 <aJIKu7uD-nYQERKW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJIKu7uD-nYQERKW@kernel.org>

On Tue, Aug 05, 2025 at 04:44:27PM +0300, Jarkko Sakkinen wrote:
> On Thu, Jul 31, 2025 at 02:23:52PM -0700, Eric Biggers wrote:
> > To prevent timing attacks, HMAC value comparison needs to be constant
> > time.  Replace the memcmp() with the correct function, crypto_memneq().
> > 
> > Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> Was crypto_memneq() available at the time?

No.  The Fixes commit is still correct, though, as it's the commit that
introduced the memcmp().  Technically it was still a bug at that time,
even if there wasn't a helper function available yet.

- Eric

