Return-Path: <linux-integrity+bounces-6120-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9AAAA8367
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 02:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13973B2FA0
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 00:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145576FBF;
	Sun,  4 May 2025 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="JsOR0Cby"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2E2F4A;
	Sun,  4 May 2025 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746318998; cv=none; b=omt/N8c910cRWyj758VjPQMhwQqeXS0TyUovPi6RmBKwSuPm6lAPdSY3GkrwOT2cURkW48S8h8H1KmnGk1hqYrA1j8n+BRDHHZr6UtYjpsae5DTxF5k0wuQy1uZPBUuVU0nDW97J/JjdBE8nyaqQXnEKc1ErkT8312QGwJ6v3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746318998; c=relaxed/simple;
	bh=9q2bSZpXNJiceHG8RiBSY7YSa+4PyS/nvF94+Yul2fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtFzn8Wgfy64GWhdVhXfUrx4bwj4qrnupz9L+bh5fQatsAmF0c9DH+hjEEiYkspcdzGzVMhSCMiP+LSplsBd0imHCLU4H8IwL0YJjgEKivlVJXKpuIoBWa/AenGlWNUxx8vBbp/dIA1XLBCHTykdKjErSVAitSnsyJKqzuC2I5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=JsOR0Cby; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pw8LoQd1KKj4VD/zq9vOqxGbrT4KdguiPvu2K5F4JBs=; b=JsOR0CbydP4HS0VKFy1/fr/vit
	aoEyezkZWi8WkiZfe8TNUkoOrmOX5YvQhnv9ratTyUhdutfL6QpmZa35e0LWXqiPCUHPGIMgT3sz1
	X7sEDHJQyFaJNV9S6nP03+ZClvTp2WaCtujhgc1l1OvbeXvw1Vf7EySEs3V64ZP8dnDHSgqGMU8o8
	8qqPEZdQFNeW9ok0lUI36yLSTD/WGKtafdDOtgGDnsJf/5MhYO6bXJk492qkjgKFY9P6lYpuyuq4l
	0QE1sIVgKc6Ug2LZQhHH/JnXHVaN7+nrhqovtC2MlvpHt3MmP1KxaHiP4Jq25/50A5e/SyD/MXTp8
	KuCavJfg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uBNKn-0039Wl-0v;
	Sun, 04 May 2025 08:35:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 04 May 2025 08:35:57 +0800
Date: Sun, 4 May 2025 08:35:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: Reduce smp_mb() calls in key_put()
Message-ID: <aBa2bZGnJ2kRJJpa@gondor.apana.org.au>
References: <aBYqlBoSq4FwiDKD@kernel.org>
 <20250430152554.23646-1-jarkko@kernel.org>
 <1121543.1746310761@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121543.1746310761@warthog.procyon.org.uk>

On Sat, May 03, 2025 at 11:19:21PM +0100, David Howells wrote:
>
> Possibly we only need smp_mb() in the IN_QUOTA branch in key_put().

Just change the smp_mb to smp_mb__before_atomic, at least on x86
it just disappears because set_bit is already a serialising operation.

Or even better, reverse the FINAL_PUT bit and call it ALIVE, so
that you can use test_bit_acquire and clear_bit_unlock.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

