Return-Path: <linux-integrity+bounces-6122-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38598AA8497
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D2A178CEE
	for <lists+linux-integrity@lfdr.de>; Sun,  4 May 2025 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F861917D0;
	Sun,  4 May 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrrVGGpw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB3188A0C
	for <linux-integrity@vger.kernel.org>; Sun,  4 May 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746344672; cv=none; b=Q/eKZ8gUy/jR6ErxlLfG4dj/oZT23+4iyh5ZCpudrunEeTN1MvdWCkaTZyHngBNIJpF8gx3a+p92HF9RnklfwNFtCq7HaCfNmJzahdpEtTfdaOzMxUSKuKDXpqpjJ/Z4KMdXdtoTw0wE0VcUDdpkX9j1AdjDf0OTIGotFPG16D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746344672; c=relaxed/simple;
	bh=21mF7GGvhKxCxIsg7RdXbZxoyesIIBXLOxGvhhmiFpA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=t8ZmKEbnI1g87d0l5qDlOtW8MRCfV0Y9kS/izQqCnBzO46bmFvh4H0wwWDlyFkefBQjwKkVruogOnE3HGWY29tkqQp5XnWoU9rzp5QmXCywG74jO5B93V2BO86a7s8t0sKEXjIWWZHcfIWnVDhP75oJJXc+f6r7fGlXDzFXGmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrrVGGpw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746344669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfF7twt06sZ68owiim+5oeU+EgBX8tp+EfU5oHUZCxQ=;
	b=VrrVGGpwiSk87rHc3hYzLW4Vc4MVUl2RcNtY+XIkvMjuSGllAx4rO3vssT0EczJnMHwoRi
	O4C+q6ueK6Qqijr7XizpCKDxnwYeQ2HBSTS/epbxzgz2gfuJtP9mxwcgreuhLiEeIz6jFh
	EKbPr5Q50cHLee7DFTwNKvIAFqf6M3M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-dx-Gq_aEMMihiCglvzzivA-1; Sun,
 04 May 2025 03:44:24 -0400
X-MC-Unique: dx-Gq_aEMMihiCglvzzivA-1
X-Mimecast-MFC-AGG-ID: dx-Gq_aEMMihiCglvzzivA_1746344661
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4299195608C;
	Sun,  4 May 2025 07:44:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E623B1800352;
	Sun,  4 May 2025 07:44:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aBb833yQFY5EpEFx@gondor.apana.org.au>
References: <aBb833yQFY5EpEFx@gondor.apana.org.au> <aBYqlBoSq4FwiDKD@kernel.org> <20250430152554.23646-1-jarkko@kernel.org> <1121543.1746310761@warthog.procyon.org.uk> <aBa2bZGnJ2kRJJpa@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
    keyrings@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
    Ignat Korchagin <ignat@cloudflare.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    James Bottomley <James.Bottomley@hansenpartnership.com>,
    Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
    linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1131865.1746344653.1@warthog.procyon.org.uk>
Date: Sun, 04 May 2025 08:44:13 +0100
Message-ID: <1131866.1746344653@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> +	key->flags |= KEY_FLAG_DONT_GC_YET;

You need __set_bit() or 1<<N.

Also, don't really like the name, but that's just bikeshedding.  I think I'd
lean more to your initial suggestion of KEY_FLAG_ALIVE.

David


