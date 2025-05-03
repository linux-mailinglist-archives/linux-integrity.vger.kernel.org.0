Return-Path: <linux-integrity+bounces-6117-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618AAA812F
	for <lists+linux-integrity@lfdr.de>; Sat,  3 May 2025 17:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AEC167B6D
	for <lists+linux-integrity@lfdr.de>; Sat,  3 May 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149ED1E47BA;
	Sat,  3 May 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="EPyF7K1p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F713D2B2;
	Sat,  3 May 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746284635; cv=none; b=qdGvl35WgVmeWnzWseEQW5OL5+vcF4kpG3koWA8N97ojbDeOi67G48lSVy8/ALTndDVvLuIbKtDGzNd9DqrwwA8rwgakfqKDEWRoJyn+Dp9mpvvuxfz0PCpOFOm6EjMhXtRfKl8Zjyre6Hb2GAQbBlJEUyeUgF9dYgdxJKl6Dus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746284635; c=relaxed/simple;
	bh=Q3jU8IweIELp/HDBkk6uZDya1bMmeBf0l/cgr0nnCNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI5Hf2AOVo3WSGZgq66XuMbLUeinb3cNT8uZnap2f21/3BdSE6YXo6u1dEO6W1wQFz4tYKqutjwP4G4adbDtZUhn4BsprboET/tfpi4UqV9YGbZTf5KIXlyj2xwZXXkqiSXQ2TTtm5v3torIUlHiMu30l6TcpA2Nhr3b86MiuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=EPyF7K1p; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nKPltQjGoDVIk3pbHzoFoWY2la6WaztZx7qnAjKn3N8=; b=EPyF7K1p6cu7vOUr/XV11SRuxX
	7aiwUQ5Az3Atp+SbqrY4xIHYpWcrVfTshwHxizoSuhf1YyZPufpv3+LqeRXe0QrjJt8vK84GbIlmF
	+mv0/RkjM1H9BDZJcKXxoznb/VEQKqEaJKXdx8buuHw4sZmXpOEmIb0ytpYVkRD5VuQ/yO0VvMlrU
	/BRJ/xmIcmylVGlrrzU3oWm6dKpsafmMxmB34oXJGiVOMetjndtuPmIChzF/goULzg7Vqn5I13EHV
	XbD79L6ZpjDbpdLj2K509EfGVu4Mj97WeVaf3oSFNN0Vx7C4SXXoAJAZcn+tcIih9qbHQIADrX6Tn
	qIm/C5Cg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uBEOH-0034vl-1y;
	Sat, 03 May 2025 23:02:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 03 May 2025 23:02:57 +0800
Date: Sat, 3 May 2025 23:02:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
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
Message-ID: <aBYwIcy5JCOamAkj@gondor.apana.org.au>
References: <20250430152554.23646-1-jarkko@kernel.org>
 <aBYqlBoSq4FwiDKD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBYqlBoSq4FwiDKD@kernel.org>

On Sat, May 03, 2025 at 05:39:16PM +0300, Jarkko Sakkinen wrote:
> On Wed, Apr 30, 2025 at 06:25:53PM +0300, Jarkko Sakkinen wrote:
> > Rely only on the memory ordering of spin_unlock() when setting
> > KEY_FLAG_FINAL_PUT under key->user->lock in key_put().
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  security/keys/key.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index 7198cd2ac3a3..aecbd624612d 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -656,10 +656,12 @@ void key_put(struct key *key)
> >  				spin_lock_irqsave(&key->user->lock, flags);
> >  				key->user->qnkeys--;
> >  				key->user->qnbytes -= key->quotalen;
> > +				set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> >  				spin_unlock_irqrestore(&key->user->lock, flags);
> > +			} else {
> > +				set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> > +				smp_mb(); /* key->user before FINAL_PUT set. */
> >  			}
> > -			smp_mb(); /* key->user before FINAL_PUT set. */
> > -			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> 
> Oops, my bad (order swap), sorry. Should have been:
> 	
>  				spin_unlock_irqrestore(&key->user->lock, flags);
> 			} else {
> 				smp_mb(); /* key->user before FINAL_PUT set. */

You can use smp_mb__before_atomic here as it is equivalent to
smp_mb in this situation.

>  			}
> 			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> 
> Should spin_lock()/unlock() be good enough or what good does smp_mb() do
> in that branch? Just checking if I'm missing something before sending
> fixed version.

I don't think spin_unlock alone is enough to replace an smp_mb.
A spin_lock + spin_unlock would be enough though.

However, looking at the bigger picture this smp_mb looks bogus.
What exactly is it protecting against?

The race condition that this is supposed to fix should have been
dealt with by the set_bit/test_bit of FINAL_PUT alone.  I don't
see any point in having this smb_mb at all.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

