Return-Path: <linux-integrity+bounces-2561-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F78CCB7C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 06:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F531F22E2D
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 04:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265F31A67;
	Thu, 23 May 2024 04:50:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA733FE;
	Thu, 23 May 2024 04:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439811; cv=none; b=buqvtjHy2OeGONGOqDCyzVoS6+1ZVBniBdbExG3ESnsYi/+LcNuCQ3iG35i7wk4mOT0LRx6n1fDMJpSIehbnpZuFuYkLm4nMz5OnAv3yPZS1CGYDkBra6CvVY1wcT0zSR0lZ6ps4sRrFcZPjffK50iXV2+fSA07aOdl7hLUTtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439811; c=relaxed/simple;
	bh=jjn1jg+bSbVkvunIql0DVqZdwho4v/lxRgtyF8jVGGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi4Aqc3hUehlU93rCWzzYfR0MH5s/RzIwgS+pxBkVA7U6hiuqAn5GV2P4qRMQ/ACGlateOxIOGueT2rlWtXABUm+TNdnTJoAYIm9h9A5xJkjFnmizBFtVdn4vQIDprUklgHO+KUyJHcf36R/+woGQnSdMMG+/C0Yhmaw26m3E6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sA0Oi-001ETa-2b;
	Thu, 23 May 2024 12:49:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 May 2024 12:49:50 +0800
Date: Thu, 23 May 2024 12:49:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com,
	Tejun Heo <tj@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, Torsten Duwe <duwe@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [v3 PATCH] hwrng: core - Remove add_early_randomness
Message-ID: <Zk7K7hw-XIHmPs26@gondor.apana.org.au>
References: <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
 <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
 <07512097-8198-4a84-b166-ef9809c2913b@notapiano>
 <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
 <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>

On Wed, May 22, 2024 at 03:53:23PM -0700, Linus Torvalds wrote:
> 
> That said, looking at the code in question, there are other oddities
> going on. Even the "we found a favorite new rng" case looks rather
> strange. The thread we use - nice and asynchronous - seems to sleep
> only if the randomness source is emptied.
> 
> What if you have a really good source of hw randomness? That looks
> like a busy loop to me, but hopefully I'm missing something obvious.

Yes that does look strange.  So I dug up the original patch at

	https://lore.kernel.org/all/20140317165012.GC1763@lst.de/

and therein lies the answer.  It's relying on random.c to push back
when the amount of new entropy exceeds what it needs.  IOW we will
sleep via add_hwgenerator_randomness when random.c decides that
enough is enough.  In fact the rate is much less now compared to
when the patch was first applied.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

