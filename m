Return-Path: <linux-integrity+bounces-5845-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62925A8674B
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 22:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5919C0B95
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 20:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7989280CD9;
	Fri, 11 Apr 2025 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeJnRkc3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793078F45;
	Fri, 11 Apr 2025 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403845; cv=none; b=GEHKeD6C/0V9B6qqSrs8VMKzOpGw7zaRZASjHPfKrr3RcriBNL6JNlQ3juTVxbuAGGwZJwoDkuO1+J8P9LOwS9FxAyBnSdBFzYSDahZRuc7YNrzCbbu3/o4Pd6YMk1JhE3xMOuCEGolwVOHlA9APs3yFQ8ggP8hk5JbaMevLQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403845; c=relaxed/simple;
	bh=exZwru58LVotG272Mvo+05uK9XNLnHfaNNEeiFcpt3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqpLduRNkim2TVjKPxuNi9UsY9GPW2Wg+wu7hWerelsYsqH9gNzG7uSsM8pG34i3jPp2YOmWtkaCWvIp4HcPRIMytc1PCtALhWbpiGMnvcoaenBo47NHShH9m4hY7vSV975M2VoU4Cxf1GlHvTewBOhDkaUJFgaD58j9UVjabyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeJnRkc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACDDC4CEE2;
	Fri, 11 Apr 2025 20:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744403844;
	bh=exZwru58LVotG272Mvo+05uK9XNLnHfaNNEeiFcpt3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeJnRkc3zG3wy2mgbzvrgxwQsRfVNaGaoFQFiXfU5HkA5wNoiuWd9b49GgqcPC3DQ
	 funKMNx+TdQU8HGqNvf95xspfm6X5W12pQb9E5ONPSpUJil+2IA67zJ8kJ6DHJ076L
	 FBJav3c6rmR875bfzcB6iGRqL8bTX+xYbJtIimWilvwG76Mx567YYyUD5nf22YBocq
	 U0kiL//sRUdblcQ4VWjLRxVIC2ln9JrrT5UX1KmBMJBXiNEh0XKCxFdBWWS6nkowAi
	 VfPs0nA9Vy9WTZS87uXlMqPwVLlKqgOz+WPzFd1HI4uWepWCx4+lqFZw4qYeRVr24y
	 6Amlaiw6Vp9QA==
Date: Fri, 11 Apr 2025 23:37:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
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
Subject: Re: [PATCH v8] KEYS: Add a list for unreferenced keys
Message-ID: <Z_l9f45aO3CqYng_@kernel.org>
References: <20250407125801.40194-1-jarkko@kernel.org>
 <2426186.1744387151@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2426186.1744387151@warthog.procyon.org.uk>

On Fri, Apr 11, 2025 at 04:59:11PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > +	spin_lock_irqsave(&key_graveyard_lock, flags);
> > +	list_splice_init(&key_graveyard, &graveyard);
> > +	spin_unlock_irqrestore(&key_graveyard_lock, flags);
> 
> I would wrap this bit in a check to see if key_graveyard is empty so that we
> can avoid disabling irqs and taking the lock if the graveyard is empty.

Can do, and does make sense.

> 
> > +		if (!refcount_inc_not_zero(&key->usage)) {
> 
> Sorry, but eww.  You're going to wangle the refcount twice on every key on the
> system every time the gc does a pass.  Further, in some cases inc_not_zero is
> not the fastest op in the world.

One could alternatively "test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) &&
!refcount_inc_not_zero(&key->usage))" without mb() on either side and
set_bit() could be at the beginning of key_put().

Race at worst would be an extra refcount_inc_not_zero() but not often.

> 
> > +			spin_lock_irqsave(&key_graveyard_lock, flags);
> > +			list_add_tail(&key->graveyard_link, &key_graveyard);
> > +			spin_unlock_irqrestore(&key_graveyard_lock, flags);
> >  			schedule_work(&key_gc_work);
> 
> This is going to enable and disable interrupts twice and that can be
> expensive, depending on the arch.  I wonder if it would be better to do:
> 
> 			local_irq_save(flags);
> 			spin_lock(&key_graveyard_lock);
> 			list_add_tail(&key->graveyard_link, &key_graveyard);
> 			spin_unlock(&key_graveyard_lock);
> 			schedule_work(&key_gc_work);
> 			local_irq_restore(flags);

I like this but shouldn't this also comprehend the quota update before
(just asking for completeness sake)?

> 
> David
> 
> 

BR, Jarkko

