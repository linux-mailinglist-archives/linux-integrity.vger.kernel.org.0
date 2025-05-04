Return-Path: <linux-integrity+bounces-6125-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8253AA8838
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ABF16906C
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0678F1E3775;
	Sun,  4 May 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYPp7SoF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD5D1E1DE7;
	Sun,  4 May 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746377763; cv=none; b=PkkSRO1BzNsgwPjF+gxwSa9uh01LnskU3w8ax080RpwCktwzbE1/XeDuQw8e3KnszupGYOo9S6gtisScXOT4UOrExol0P0cetXSo3x2yHBwGjbz9NPCCn8/E6m+0+tDtmESwWK41Xf62r7vDM6i99JVmbMXOdiSeVcpQxhF3ydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746377763; c=relaxed/simple;
	bh=7byS+mjeSFHrzb+IfI4pFxAaork3Tq6cUfMVQ3+Gz9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/9DCSi2a+0/oK92onh1dppDoyHKvChvO/WB1GUl9PjFD6V6pqtaURyLPmkKuQfVohKe7K+LCxrrymM1KMMUMdzwntrHSPQ2I/764zryNbkdB81/QpgzdCKeUWEPhQNUn4soQVrjvamnRBmifiaKEIfEj0B4sirGhbcJF2A7tmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYPp7SoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD47C4CEE7;
	Sun,  4 May 2025 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746377763;
	bh=7byS+mjeSFHrzb+IfI4pFxAaork3Tq6cUfMVQ3+Gz9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYPp7SoFQgkP8sahvG/Tei97RR/8zhOMj0Tn7BI3CCTOTpgJihq65Tic8HqBDtw0Z
	 HpbjfKZKMkyQbYT+x/m9OufNyXDhzdTmvo9lWAUn3ScsD6vXfrggpC2mU9jhHcMRXT
	 1HOGbKr8sjgIgZcPMjWQ+eehI3Ng3ZukcUqOnR+wc6ecsBUD0DVWmbRW8aOu/E0nn8
	 /QwUFwC94XFPjJVIzvyiQXU7XMGi46liIxxqTt/5pflc0qFXZm+QJZLWpFlh/VoOqn
	 WSHY1YBDsuHx8qA4R++lGTjRCYxgsAKRi/qFHuQ3y1AcMLnONfknytVSlW0HeK9pcU
	 vmxUuCeFjTGVw==
Date: Sun, 4 May 2025 19:55:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
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
Message-ID: <aBecHr6jBLWmJcyP@kernel.org>
References: <20250430152554.23646-1-jarkko@kernel.org>
 <aBYqlBoSq4FwiDKD@kernel.org>
 <aBYwIcy5JCOamAkj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBYwIcy5JCOamAkj@gondor.apana.org.au>

On Sat, May 03, 2025 at 11:02:57PM +0800, Herbert Xu wrote:
> On Sat, May 03, 2025 at 05:39:16PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Apr 30, 2025 at 06:25:53PM +0300, Jarkko Sakkinen wrote:
> > > Rely only on the memory ordering of spin_unlock() when setting
> > > KEY_FLAG_FINAL_PUT under key->user->lock in key_put().
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  security/keys/key.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > index 7198cd2ac3a3..aecbd624612d 100644
> > > --- a/security/keys/key.c
> > > +++ b/security/keys/key.c
> > > @@ -656,10 +656,12 @@ void key_put(struct key *key)
> > >  				spin_lock_irqsave(&key->user->lock, flags);
> > >  				key->user->qnkeys--;
> > >  				key->user->qnbytes -= key->quotalen;
> > > +				set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> > >  				spin_unlock_irqrestore(&key->user->lock, flags);
> > > +			} else {
> > > +				set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> > > +				smp_mb(); /* key->user before FINAL_PUT set. */
> > >  			}
> > > -			smp_mb(); /* key->user before FINAL_PUT set. */
> > > -			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> > 
> > Oops, my bad (order swap), sorry. Should have been:
> > 	
> >  				spin_unlock_irqrestore(&key->user->lock, flags);
> > 			} else {
> > 				smp_mb(); /* key->user before FINAL_PUT set. */
> 
> You can use smp_mb__before_atomic here as it is equivalent to
> smp_mb in this situation.
> 
> >  			}
> > 			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> > 
> > Should spin_lock()/unlock() be good enough or what good does smp_mb() do
> > in that branch? Just checking if I'm missing something before sending
> > fixed version.
> 
> I don't think spin_unlock alone is enough to replace an smp_mb.
> A spin_lock + spin_unlock would be enough though.
> 
> However, looking at the bigger picture this smp_mb looks bogus.
> What exactly is it protecting against?
> 
> The race condition that this is supposed to fix should have been
> dealt with by the set_bit/test_bit of FINAL_PUT alone.  I don't
> see any point in having this smb_mb at all.

smp_mb() there makes sure that key->user change don't spill between
key_put() and gc.

GC pairs smp_mb() in key_put() after FINAL_PUT to make sure that also
in its side key->user changes have been walled before moving the key
as part of unrefenced keys.

See also [1]. It cleared this up for me. Here user->lock easily misleads
to overlook the actual synchronization scheme.

> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

[1] https://lore.kernel.org/keyrings/1121543.1746310761@warthog.procyon.org.uk/

BR, Jarkko

