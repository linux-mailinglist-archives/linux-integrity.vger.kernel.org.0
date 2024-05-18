Return-Path: <linux-integrity+bounces-2449-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC408C90D7
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 14:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E1B1C2138F
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E59028379;
	Sat, 18 May 2024 12:33:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015E1DA23;
	Sat, 18 May 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716035585; cv=none; b=ifDV7RCd2X2lfTlmH9YGWLQIWgdm8OOjSFkoFLTHVA2DjUtrYmAX6i0d/sFu14h3cXOSPcdsSEqXrDPSRKcuVPGzOCKQsctKvefbCC/2lih5gnbjhhzm6UoYTuotb3zj6HB4cMcmwRAajE5yZUUvOmwtMrJbUZ6bOwnDElzs64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716035585; c=relaxed/simple;
	bh=zhyc49WKREdH5z9pCpm49QRprPToV3ef7TJKDWg15/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBet+Tt+5yoyj3DRExL7ayMSdt5gYJn5uDjcpTFbOd0Fatpvf82ndi5Khynt8mcufPvQOuz3K4w5eCM9TmXB+Vy8ga8T5n8Ydmxr5z389ViaBTUEkghMc/nxjoEI0JeYKL7p6g6HLeNzgfN2Xaw5aeosgeGBk4zY+5QJWgYkzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8JF9-00H5d9-1x;
	Sat, 18 May 2024 20:32:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 May 2024 20:32:56 +0800
Date: Sat, 18 May 2024 20:32:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH] crypto: api - Do not load modules until algapi is ready
Message-ID: <Zkif-BI_OFnFbDhv@gondor.apana.org.au>
References: <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <D1CPYHVR94JS.1DIGZUQ2H3NCI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1CPYHVR94JS.1DIGZUQ2H3NCI@kernel.org>

On Sat, May 18, 2024 at 02:04:18PM +0300, Jarkko Sakkinen wrote:
>
> Right does this mean for TPM driver that a crypto API invocation not
> having everthing needed loaded will block until this is not the case?

All this does is disable module loading by the Crypto API (because
there is no point and it may deadlock) until such a point where
all/most drivers have finished loading.

So if the algorithm is missing (which shouldn't happen because of
Kconfig selects), then it will simply fail.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

