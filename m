Return-Path: <linux-integrity+bounces-2530-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6828CB44D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 21:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945141F21EFB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA540757F6;
	Tue, 21 May 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5X8nQJ+M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07671DFE8;
	Tue, 21 May 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320245; cv=none; b=ioKlIqWdpZeT0efNIbrYanUotGVRN8sPaqNO0eE7+Zk3B1DGcJqC80HoAcGH56PZeGsHyxYtZDBNs7XN5Rgu/vVf28kbqzb/VjLD+Sx4ONAyPR6KHgG5q9rCO0tCD8/8o3CyVtOLvvLcpNqYBK0GZoXj/kiNqzc3Ro8+mBAZnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320245; c=relaxed/simple;
	bh=wXDcMa9BCYSyaXMMmTl9LN4ze2E6leCzM04dQwdFaRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObeN41Gc7xQyiaXkdT/Cp2UC5V48yl32HWeMY0R72cgxy1hSL7gX7M7rnn5Fqjc0qu/1G6WukNk+h0fFLPX/bF1PMWX5yMdzB9vw5toqtc/dUTgafi8Rf3lGl+RwtxX36dEu+mW8pZJvqvK8Ky8J36XOpR9TLLiVRnV9fpsqZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5X8nQJ+M; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716320241;
	bh=wXDcMa9BCYSyaXMMmTl9LN4ze2E6leCzM04dQwdFaRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5X8nQJ+MU7gpqCnK/j2pEAXml/E84t8yPhv1xQpdLoc8LPYVDKPFa5+M6n38NzU80
	 Z+j1/At6hOVYn8VmZls82EutWaY7Ehg2OYpdMykTy2cV7JvEzs8SqHBT2UpPRVDfNr
	 5iFDu/JCq3KkmiDCMBioXP3XC4g4bvuLjbusOcohr88wASA9NJZ30Tep5/AIOq2M8h
	 YTJZ0SWhHE+FDm5yZvE+Em2ioQ7ePT9r175ZagbbP6JMAxf0AnxGu0Jyb781LbEytZ
	 GVvqgRbFNw8QaxI19BZXaYArrw9Eatwxu+YreHu91wPwTVdwtzjrvUXKdBLJ9Ln3Ix
	 RKXLDTV7ZZCNQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 245963782183;
	Tue, 21 May 2024 19:37:18 +0000 (UTC)
Date: Tue, 21 May 2024 15:37:16 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] crypto: api - Do not load modules if called by async
 probing
Message-ID: <07512097-8198-4a84-b166-ef9809c2913b@notapiano>
References: <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
 <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>

On Tue, May 21, 2024 at 10:53:18AM +0800, Herbert Xu wrote:
> On Mon, May 20, 2024 at 11:49:56AM -0400, Nícolas F. R. A. Prado wrote:
> >
> > Unfortunately this patch didn't work either. The warning is still there
> > unchanged.
> 
> OK perhaps we can do it by calling current_is_async ourselves.
> But this is really a nasty hack because it basically defeats
> the whole point of loading optional algorithm by module.
> 
> Linus/Tejun, is it time perhaps to remove the warning introduced
> by commit 0fdff3ec6d87856cdcc99e69cf42143fdd6c56b4 since it's
> been ten years since the warning caused a real problem?
> 
> For the Crypto API, if it is called by some random driver via the
> async context, this warning stops us from loading any modules
> without printing a nasty warning that isn't relevant as the Crypto
> API never calls async_synchronize_full.
> 
> ---8<---
> Do not call request_module if this is the case or a warning will
> be printed.
> 
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  crypto/api.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/api.c b/crypto/api.c
> index 22556907b3bc..7c4b9f86c1ad 100644
> --- a/crypto/api.c
> +++ b/crypto/api.c
> @@ -10,6 +10,7 @@
>   * and Nettle, by Niels Möller.
>   */
>  
> +#include <linux/async.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/jump_label.h>
> @@ -280,7 +281,8 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
>  	mask &= ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
>  
>  	alg = crypto_alg_lookup(name, type, mask);
> -	if (!alg && !(mask & CRYPTO_NOLOAD)) {
> +	if (!alg && !(mask & CRYPTO_NOLOAD) &&
> +	    (!IS_BUILTIN(CONFIG_CRYPTO) || !current_is_async())) {
>  		request_module("crypto-%s", name);
>  
>  		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
> -- 
> 2.39.2

FWIW this patch fixes the warning. So feel free to add

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

if you choose to apply this patch (I'm happy to help test other patches too). In
any case, please also add the following trailers so the regression gets closed
automatically in regzbot:

Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
Link: https://lore.kernel.org/r/119dc5ed-f159-41be-9dda-1a056f29888d@notapiano/

Thanks,
Nícolas

