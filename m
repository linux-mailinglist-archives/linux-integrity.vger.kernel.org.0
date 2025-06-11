Return-Path: <linux-integrity+bounces-6422-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E67AD5E7D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 20:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4F91E04E6
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A318787A;
	Wed, 11 Jun 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA2P3ApY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F91922DC
	for <linux-integrity@vger.kernel.org>; Wed, 11 Jun 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667525; cv=none; b=EQwJ+TChm0+AY6jCPKh7RYvHOHomwBe+OiH63+VqZgcNHXG8UI9FQK9u2csUL/pPzF1mvW8/XZk867qXCdQ6QURh/CQUS91KCUVmWpTOk8pv5ceadkN8xGzAYNSjgCN/sxAhF8qcnWDB9E66xeocy5+eq8eGMulalvGvcLbJx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667525; c=relaxed/simple;
	bh=aDUrDsc2gJpGpvTSC5QyIq7leA7jeiSS/kItt8u3E4k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=O+t67LpQJvhiv+GsmbMTolqZSdh27eiHhoduoX6h/tTZB8xvWOFIkHddb7fOm+vSfSBHiLwaRTNIVTI287p49/tCDltwM5RbSsK30mOtX6l+PhL1n/GG5DK4eALA6MlmXKTxkFREUa+t0CzBk1s8kHsIq8Ok3kpMIypsMKK7vgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DA2P3ApY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749667523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDUrDsc2gJpGpvTSC5QyIq7leA7jeiSS/kItt8u3E4k=;
	b=DA2P3ApYYnKnC3oJhv0dtJCgof7srpFf3o40eJimrQhfwB+b6HdhvTr/rxDlKtkG7Xjk0b
	VUH9TFfa5N2RHzapigveuG2wLvYJg4/EakyoBJeYq4cOGROvDBlXj94WpsgWiDOcLg1Pgn
	W8Orc4ahuGFc10qugWg/LpjiWZNSg1g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-FSxMpdz1MduW-tiucdZZ4g-1; Wed,
 11 Jun 2025 14:45:21 -0400
X-MC-Unique: FSxMpdz1MduW-tiucdZZ4g-1
X-Mimecast-MFC-AGG-ID: FSxMpdz1MduW-tiucdZZ4g_1749667520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D81DA19560A2;
	Wed, 11 Jun 2025 18:45:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6B1419560AF;
	Wed, 11 Jun 2025 18:45:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com>
References: <CAHk-=wjY7b0gDcXiecsimfmOgs0q+aUp_ZxPHvMfdmAG_Ex_1Q@mail.gmail.com> <301015.1748434697@warthog.procyon.org.uk> <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Paul Moore <paul@paul-moore.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
    linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org,
    linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <382105.1749667515.1@warthog.procyon.org.uk>
Date: Wed, 11 Jun 2025 19:45:15 +0100
Message-ID: <382106.1749667515@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I guess I can still take it if people just say "do it".

Do you want a signed tag and git pull for it?

David


