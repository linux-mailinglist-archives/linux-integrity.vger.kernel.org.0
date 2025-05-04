Return-Path: <linux-integrity+bounces-6124-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6307AA881C
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0338E188E86B
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515EC1DF254;
	Sun,  4 May 2025 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os9fQfoE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025581DEFC8;
	Sun,  4 May 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746376935; cv=none; b=i102xsWRFT6+3ijGdtNtDOzHhxMoCN9hd+Jl63dEKl2e0/3SBWJTD70xDpQyGaMFs50r4KWcl9Tf27az0Xpt4UGPdZwysE1AolhT1yXY2s7C7xmulxq6BEmCM+e8CAxm8ZQaSQIdXL8tf7IVcLa13Tb8JdEXLMfHywU4cGAOn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746376935; c=relaxed/simple;
	bh=+M5mmT0UHIqtM31POEFwoPqf8yaTarHCNYDnaixSjfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG3q2FSkgF5uVbCQ5PRK2uUZC2FzGtRq1GGgVWMejvweX4xQf3eP3TSnKDjfXfdjCXfeCXfb2LDiRnDcLm26bJKqivTfjiXAO6OWAxdVnTMiGhBTv92UQpFaSPOLzTIaz33tHxrtw5Z59zVI2B5I1qUa4OCowTqQ881bq6X510A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os9fQfoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD9EC4CEE7;
	Sun,  4 May 2025 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746376934;
	bh=+M5mmT0UHIqtM31POEFwoPqf8yaTarHCNYDnaixSjfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=os9fQfoE8F+obXtE5buent0qyDUUHXnYR5Ti8LJDJaWfc1+jmnkk6QuTZ+CkEcUVh
	 WTrwSGw2aJMA7iNWadyheGJY19QUKoV6X0StwE+41jPr4zKZXj2wcPnqzWkzM4/eys
	 GiZSe8mgJFe5U7oEadKrv6ThTLIB0CTZ1MBxkPf7lk3S2fcISTMv+qXoTEnN6dWyAz
	 Vp7P0yQxCS46wkMayYJzgaZXva56yOay/bjlVBWAlctE32N3h+hhmTsGquOG+i5qhz
	 oo++6IJrcuaEI4+FC8GrubTY4IedpaDXedwNgMkce1BfkaIla4sYsUdBjpYQoCV4c+
	 URnXf6g5MkbOg==
Date: Sun, 4 May 2025 19:42:09 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: Reduce smp_mb() calls in key_put()
Message-ID: <aBeY4d3eC2aOthx-@kernel.org>
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
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > Oops, my bad (order swap), sorry. Should have been:
> > 	
> >  				spin_unlock_irqrestore(&key->user->lock, flags);
> > 			} else {
> > 				smp_mb(); /* key->user before FINAL_PUT set. */
> >  			}
> > 			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> > 
> > Should spin_lock()/unlock() be good enough or what good does smp_mb() do
> > in that branch? Just checking if I'm missing something before sending
> > fixed version.
> 
> spin_unlock() is semi-permeable, so stuff after it can leak into the inside of
> it up as far as the spin_lock().  With your change, the garbage collector can
> no longer guarantee that key_put() will have done with accessing key->user
> when it sees KEY_FLAG_FINAL_PUT is set.
> 
> So, NAK on this patch, I think.  If you want a second opinion, I'd suggest
> waving it in front of Paul McKenney.

Fair enough.

If I revisit this in a way or another,  I'll cc to him for comments but
for this I'll buy what you said.

> 
> Possibly we only need smp_mb() in the IN_QUOTA branch in key_put().
> 
> David

Thank you for the comments.

BR, Jarkko

