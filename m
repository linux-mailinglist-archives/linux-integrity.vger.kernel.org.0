Return-Path: <linux-integrity+bounces-5846-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C46A8676A
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 22:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943749C0E07
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C6284B52;
	Fri, 11 Apr 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAn5rWNY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BC78F45;
	Fri, 11 Apr 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404104; cv=none; b=cSUq82QcP1CL/dBjFjxbRIZ5lXniwfLoczwrJZOKiXbtG+topQl1bryFPfWL1WQHGunp7FjmjYjy5JjT1s8XkGfqQ9fUvK6teRd/rtzVAv7XpGLrcB5FA9YIy1Qy8vhlXjmONXoIZF5qycGc+umbaUu2AzNNooS3H8J0pKNPxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404104; c=relaxed/simple;
	bh=k26H15Ik1Kmm3cA4tCIzG2ROtOvMozU7PH44mwjktQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDqPz9z191cN8LzGSA1vVQq3U9uMqRZwhDUspB9ZjXAUNJSAQcqaEvXJ0Ir1zKzjGJkvIbJO/JXe2nRP9Lz15ZhiZpm377q+PXK3pacHYJalar0x2CdpX3sQzE/SgkIIC0SrswhlxpGTZDqA28QsZt0BBI0aONL1fVRFQjPOrd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAn5rWNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73ABFC4CEE2;
	Fri, 11 Apr 2025 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744404104;
	bh=k26H15Ik1Kmm3cA4tCIzG2ROtOvMozU7PH44mwjktQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAn5rWNYUDU7QTNjxNZAvaVrOSAWaOaEQxYOLWtvQc8FPTujo5wLnIXT88/X3N7Sk
	 SiYe/4ERefrOgzR4yN3/HPGByXkg75yHtzQnLnNP2iVioOS3BJ3OSAdYxky4SQW94Z
	 rKWU/Co6Ddhg8FQhC0YeG5wvylbyuCsrwzhK4+EChzNypkGtptlTyLsAlXKZKPhC07
	 ucrJnZhNAhc702if0uHBTIq6JT21svg2CsdHUr7Zclj2ARxKRpF9LU+VYNM0dRxkOe
	 zJZI0i/ve0DuTFQuT1SkZfctugCYX46s2pID023lZRvCXl2RF7xgT/dKWEe6GHoeMk
	 2tu+tPRwgaGTA==
Date: Fri, 11 Apr 2025 23:41:38 +0300
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
Message-ID: <Z_l-gjmdztcvkBWZ@kernel.org>
References: <20250407125801.40194-1-jarkko@kernel.org>
 <2426186.1744387151@warthog.procyon.org.uk>
 <Z_l9f45aO3CqYng_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_l9f45aO3CqYng_@kernel.org>

On Fri, Apr 11, 2025 at 11:37:25PM +0300, Jarkko Sakkinen wrote:
> > This is going to enable and disable interrupts twice and that can be
> > expensive, depending on the arch.  I wonder if it would be better to do:
> > 
> > 			local_irq_save(flags);
> > 			spin_lock(&key_graveyard_lock);
> > 			list_add_tail(&key->graveyard_link, &key_graveyard);
> > 			spin_unlock(&key_graveyard_lock);
> > 			schedule_work(&key_gc_work);
> > 			local_irq_restore(flags);
> 
> I like this but shouldn't this also comprehend the quota update before
> (just asking for completeness sake)?

"This brings me on to another though:  Should key_serial_lock be a seqlock?
And should the gc use RCU + read_seqlock() and insertion
write_seqlock()?"
https://lore.kernel.org/keyrings/797521.1743602083@warthog.procyon.org.uk/

I think that should be done too (because it made whole a lot of sense)
as a separate patch. I'd just prefer move slowly and in baby steps for
better quality, and keep that as a separate follow-up patch.

It makes obviously sense given rare writes.

BR, Jarkko

