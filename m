Return-Path: <linux-integrity+bounces-2464-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA1A8C9363
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 06:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C295C1F2136A
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 04:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235248F49;
	Sun, 19 May 2024 04:20:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366B7492;
	Sun, 19 May 2024 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716092408; cv=none; b=slgJstm+pe9XNRN/ErVNZwcVdZMukmkXbHtwuXYDYOejFuPKYI+piPHjesvF15Ci5BjEJBZ/eU4WdAGgdX7TNs1ED9VP+Kzq/uVinaHnbnpKPQR8ZdAfIwkD9htUqKWZaTFhUQJfLPNhQ4XOarx6su6Fm7/4d6VozS934ftWRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716092408; c=relaxed/simple;
	bh=KSFNkUecnxYaZfX2XSP4Ln26Z+CZ5J+ihB7wjteqxRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaSzDhdguvN4f+YraR95uDiMo9ImddrSGIko9ap+2fEQo2JtBpePq04GxZWbo4Bv8Upq7AXwr7SSYsJOektk6DASYPNbdLNGn0/oO0Ocxqlyl3+5DOytv8Ax+WugtQkDEUFUdH/7U074xUXbN+6A24QrgasnIgVbISyRx9cibLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8Y1b-00HFcI-19;
	Sun, 19 May 2024 12:19:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 12:19:56 +0800
Date: Sun, 19 May 2024 12:19:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH] crypto: api - Do not load modules until algapi is ready
Message-ID: <Zkl97G-y7ZvTK5Pf@gondor.apana.org.au>
References: <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <D1CPYHVR94JS.1DIGZUQ2H3NCI@kernel.org>
 <Zkif-BI_OFnFbDhv@gondor.apana.org.au>
 <3A150785-8EE3-4B53-9E71-4DE49C6751B0@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A150785-8EE3-4B53-9E71-4DE49C6751B0@HansenPartnership.com>

On Sat, May 18, 2024 at 06:07:39AM -0700, James Bottomley wrote:
>
> I have a curiosity question: if Eric is right and it's looking for an optional hmac accelerator module, why don't I see this?  The only real config difference between what I tested and what Nicholas did is he's arm and I'm x86.

It depends on your kernel config.  Perhaps you didn't build the
TPM driver into the kernel?

It's not an issue with an optional algorithm that's not included.

It's the fact the Crypto API tries to load a module for any
algorithm that requires instantiation (anything with "()" in its
name).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

