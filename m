Return-Path: <linux-integrity+bounces-6119-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838EAA8333
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 00:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0918189CF42
	for <lists+linux-integrity@lfdr.de>; Sat,  3 May 2025 22:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92601AED5C;
	Sat,  3 May 2025 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQnG6SK3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7D719992C
	for <linux-integrity@vger.kernel.org>; Sat,  3 May 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746310785; cv=none; b=SxdIGyoOkqMr1tWjmm30ABRPfHUJ3HugoIvJQby2YQ7zWeDBOtbVb2QQQhZZ5bXzMHkJcaHmGwusp95jKhRJuIx//gjLqK3YnfBueBwC7TMsWq95i/sEQw6/XmSL84F7lHOKzNfuvNUTkmFuTazuFyC82l209gpUJgzrzE/x+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746310785; c=relaxed/simple;
	bh=K7bpm3hmvNgfHOZKQIcgkQweXOrSWSr5prf6mDtV8Ps=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=lISKVtnbLDHccPcXOwG37lOiwo+odGw0qHQdZ8JXyLxZfmZOzXIqCZHn/FbmzJF+KbtjJf4Q38cOyEdFUMDGRP206hWCDLKk/WHG2Fgfsdjakm+g8NiUt9biY6DmSWBkIcJB9Z65Ap2q2PT/vcbOEdYgfobbMqTXcQJeGd9y8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQnG6SK3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746310780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/c3VdkF4DbF4Om460TBXja0mJFR59DDuAT798jGta4=;
	b=BQnG6SK3L4nQZwrIeZLRtYWYptksft0IOmrJwwfaaz1nfZm6RpEJ2MmQLyrzVHLE2pVU6O
	hsYbjhETvfsc2efMwEE3p9HC3SROa+QjKRbJnA1M3KdjZGjGs0ve8M05aOZWKW4uv0G7vJ
	vWAslCEjBoyA7dKXc0rLhvC9qXXtBD4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-mxxNZJgJOQeS8RMv7PlrJA-1; Sat,
 03 May 2025 18:19:35 -0400
X-MC-Unique: mxxNZJgJOQeS8RMv7PlrJA-1
X-Mimecast-MFC-AGG-ID: mxxNZJgJOQeS8RMv7PlrJA_1746310770
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA65E195608E;
	Sat,  3 May 2025 22:19:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 103E719560A3;
	Sat,  3 May 2025 22:19:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aBYqlBoSq4FwiDKD@kernel.org>
References: <aBYqlBoSq4FwiDKD@kernel.org> <20250430152554.23646-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Lukas Wunner <lukas@wunner.de>,
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
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1121542.1746310761.1@warthog.procyon.org.uk>
Date: Sat, 03 May 2025 23:19:21 +0100
Message-ID: <1121543.1746310761@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Oops, my bad (order swap), sorry. Should have been:
> 	
>  				spin_unlock_irqrestore(&key->user->lock, flags);
> 			} else {
> 				smp_mb(); /* key->user before FINAL_PUT set. */
>  			}
> 			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
> 
> Should spin_lock()/unlock() be good enough or what good does smp_mb() do
> in that branch? Just checking if I'm missing something before sending
> fixed version.

spin_unlock() is semi-permeable, so stuff after it can leak into the inside of
it up as far as the spin_lock().  With your change, the garbage collector can
no longer guarantee that key_put() will have done with accessing key->user
when it sees KEY_FLAG_FINAL_PUT is set.

So, NAK on this patch, I think.  If you want a second opinion, I'd suggest
waving it in front of Paul McKenney.

Possibly we only need smp_mb() in the IN_QUOTA branch in key_put().

David


