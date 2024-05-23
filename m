Return-Path: <linux-integrity+bounces-2565-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B68CCFC3
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 11:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33287284046
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0AE13D61E;
	Thu, 23 May 2024 09:59:07 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249F13D521;
	Thu, 23 May 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458347; cv=none; b=BKA/MHNuGDeRfpfO6n1wzfM8qF9bU/wvuW3jtR9ILZ5h20GiUqzTP0ewABHLuxTyWPliJ0Ia108Qt178+YtNWez5klZdahfr/GSn60Qyb8IHumeUFfd+Is2J/kzgYvjb9ccgps8PE+M6ZdS2khEByvuvrPhYi+/48SMd6BBNiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458347; c=relaxed/simple;
	bh=U2XlzDGvqBl/xtnZsazcyCvUucQHVzfGF3tyCr5r4RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kegloX2caYnKl4XIWoKJmIaJpMRsFVZh0+xg5tfwOyRQVu3UqYopTakSC/uuHjBLaspsCI5Km5sVMW+DSowSmUDMoco7EsDGK585ndBmU9GMVN5fAqRZKxgwLuR0cCr9K8qdXqCRUVcLtgQx8qhfynliUa7xKIC4nxt/X4eDg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sA5Dq-001Lgc-0d;
	Thu, 23 May 2024 17:58:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 May 2024 17:58:55 +0800
Date: Thu, 23 May 2024 17:58:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <Zk8TXz1hfA8_Uu9R@gondor.apana.org.au>
References: <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
 <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
 <07512097-8198-4a84-b166-ef9809c2913b@notapiano>
 <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
 <CAHk-=wi7vwgzD4hdBzMrt1u3L2JyoctB91B7NLq-kVHrYXoTGA@mail.gmail.com>
 <Zk7K7hw-XIHmPs26@gondor.apana.org.au>
 <D1GXKODMD4S8.1J12D4GOEQWPL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1GXKODMD4S8.1J12D4GOEQWPL@kernel.org>

On Thu, May 23, 2024 at 12:53:04PM +0300, Jarkko Sakkinen wrote:
>
> Just throwing something because came to mind, not a serious suggestion.
> 
> In crypto_larval_lookup I see statements like this:
> 
> 	request_module("crypto-%s", name);
> 
> You could potentially bake up a section/table to vmlinux which would
> have entries like:
> 
> 	"module name", 1/0
> 
> '1' would mean built-in. Then for early randomness use only stuff
> that is built-in.

This early random stuff is obsolete not just because we have a
kernel thread doing the same thing, but moreover random.c itself
has been modified so that it is no longer starved of entropy on
startup.  There is no reason to feed any early randomness.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

