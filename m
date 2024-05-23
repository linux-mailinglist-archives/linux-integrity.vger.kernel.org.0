Return-Path: <linux-integrity+bounces-2562-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356308CCB80
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669BB1C21645
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 04:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69187D095;
	Thu, 23 May 2024 04:50:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F431A67;
	Thu, 23 May 2024 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439826; cv=none; b=EEz2UeaBeFy+9gO/u6A9itkkiaPnRcuO2Lp9nXP7OpcMSJ+YyDsksVn/wg0V8CajxyaDtsZoczj8b+2Z6T15RyKD15jOAPM+HM49jAjzlBTLFjtlF9Url0o0h4CX629cVTvqVo3+ftkqq1ZTVKoRnSqq3QGsua/C7KVPR/BylNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439826; c=relaxed/simple;
	bh=uwSV27Ev4Jrn4+pHukkex0Ljo9ox+YtMBacU/RZjrM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDHgXZNGV8b7FQ5WDllok6V0njr3K1Yn9msAdg+JZBNDHvlpfQHQ9bDhqkAfiFJSjQ5/AL9sbCck6Mm5jweUucHA5wsz7jRD2UrgQjJupjCYtmTmwVA4fgglRtGiQGA1sCUEnRVmCqoMuSn4sXifXFtAjgxlQHm30w8ovtHLoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sA0PD-001ETo-0q;
	Thu, 23 May 2024 12:50:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 May 2024 12:50:20 +0800
Date: Thu, 23 May 2024 12:50:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [v3 PATCH] hwrng: core - Remove add_early_randomness
Message-ID: <Zk7LDPcDeunCwglt@gondor.apana.org.au>
References: <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
 <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
 <07512097-8198-4a84-b166-ef9809c2913b@notapiano>
 <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
 <D1G5GVUYCRZK.1G5UZ39NM96QJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1G5GVUYCRZK.1G5UZ39NM96QJ@kernel.org>

On Wed, May 22, 2024 at 02:51:36PM +0300, Jarkko Sakkinen wrote:
>
> What is the kthread doing this currently?

It's hwrng_fillfn.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

