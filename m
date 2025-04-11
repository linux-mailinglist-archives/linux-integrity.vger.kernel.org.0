Return-Path: <linux-integrity+bounces-5841-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646D6A862A8
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 18:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BB4E0B2E
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE1021B9C9;
	Fri, 11 Apr 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IL/SIY/g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A421A453
	for <linux-integrity@vger.kernel.org>; Fri, 11 Apr 2025 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387169; cv=none; b=fP9gbGlF+vu4F325Ixdh+mA2l8Fv47gwAYKMfumltRDb9TAhkt0YDZUcazONtEbKRbOKcB8877X5aK5/IiWtKBSasFRbwyEg64+f0hBTG0JJzCy4O5XaQNjV8YK+Ybr23ROLZDEGt2/nN7XrAQyVi+YNX6CLjOVJ5r8jYWv5gL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387169; c=relaxed/simple;
	bh=fZlIPKzYCfS3JWZkzUhx6xvi3UjrSnLayoxpbPfvozY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JwEDDNQ0y6Thg+QFIuMPcBgYhBrANz61fRwxrC00JZ7aLBNt46qPl9FGxiqy7dlkFJwIkpgpmmI5rHJn3wDmtQp0+64SnHw1h47vw201i5xOESHIDYnOCSbISzV5n1VnZbb4mZtpmFAKq/LmlN+eF+5maOU9W4+jrviddwthoq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IL/SIY/g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744387166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YGwsbANdm5+UipwPPrI05eTBmxw+TZxLni/YQ7Hx4Q=;
	b=IL/SIY/g3kzpdAXIkl74EWFUklhozEz4GQiU51RNAIp9qt+dSBkl6FJib9ehbj2yhPGbI7
	om3O0Wp/VyXiraisA9PFwdGBbgUQJLGtf5huTvyAlkVgXR7+p2NDKwEKj1tMW7WLPeu0bG
	uUoODAOvQRZv8b1LxH07TLOn/n5UFzc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-1LNp5UCTODWVVEnUWP054A-1; Fri,
 11 Apr 2025 11:59:23 -0400
X-MC-Unique: 1LNp5UCTODWVVEnUWP054A-1
X-Mimecast-MFC-AGG-ID: 1LNp5UCTODWVVEnUWP054A_1744387160
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 743D21801A00;
	Fri, 11 Apr 2025 15:59:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62EF11808882;
	Fri, 11 Apr 2025 15:59:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250407125801.40194-1-jarkko@kernel.org>
References: <20250407125801.40194-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
    stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
    Ignat Korchagin <ignat@cloudflare.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    "David S. Miller" <davem@davemloft.net>,
    Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E.
 Hallyn" <serge@hallyn.com>,
    James Bottomley <James.Bottomley@HansenPartnership.com>,
    Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
    linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8] KEYS: Add a list for unreferenced keys
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2426185.1744387151.1@warthog.procyon.org.uk>
Date: Fri, 11 Apr 2025 16:59:11 +0100
Message-ID: <2426186.1744387151@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> +	spin_lock_irqsave(&key_graveyard_lock, flags);
> +	list_splice_init(&key_graveyard, &graveyard);
> +	spin_unlock_irqrestore(&key_graveyard_lock, flags);

I would wrap this bit in a check to see if key_graveyard is empty so that we
can avoid disabling irqs and taking the lock if the graveyard is empty.

> +		if (!refcount_inc_not_zero(&key->usage)) {

Sorry, but eww.  You're going to wangle the refcount twice on every key on the
system every time the gc does a pass.  Further, in some cases inc_not_zero is
not the fastest op in the world.

> +			spin_lock_irqsave(&key_graveyard_lock, flags);
> +			list_add_tail(&key->graveyard_link, &key_graveyard);
> +			spin_unlock_irqrestore(&key_graveyard_lock, flags);
>  			schedule_work(&key_gc_work);

This is going to enable and disable interrupts twice and that can be
expensive, depending on the arch.  I wonder if it would be better to do:

			local_irq_save(flags);
			spin_lock(&key_graveyard_lock);
			list_add_tail(&key->graveyard_link, &key_graveyard);
			spin_unlock(&key_graveyard_lock);
			schedule_work(&key_gc_work);
			local_irq_restore(flags);

David


