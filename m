Return-Path: <linux-integrity+bounces-2533-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D7B8CB57A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FAF28228D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CAE14A088;
	Tue, 21 May 2024 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxGrrBwV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B9149DE5
	for <linux-integrity@vger.kernel.org>; Tue, 21 May 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716327867; cv=none; b=cTC8I39QntNWs2mpUbTSJP7zwaHbT4j2mt/WJ60KUs0dXby1cVKnyGv/eaTPsjHvao2bxqKmBsmaY0FfffZWvhfQ3hnjHmXCstsTVzCPovi+qf750eltAgFW39CaoxBytSaSPqPC15RIktfzztoN5R4ZDX39n1JZGKOWgDVqTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716327867; c=relaxed/simple;
	bh=4nYyyCd0npKEcPTjE/tiKnDxq9X/Y9evMSw7H3OMOEk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=iZPsVxm/XSUfL4K9C+n5wxbSRd1YThIV1IcXXX5GJZxio32i1DmGQtY1UdeXelya9UGYK+KvJYWH+7ptJV/fixv8CaCauVbWZ32TSRwpMk34IciGUvGcY7ixeXEPAndXcMX/3wDqnqIk8WFZFbxIzQhENtMwG/zdyKOQzSn6dJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxGrrBwV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716327864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=as6GIYyNEq+8SDN+ioFBfL9KQ8xlH4pzpn2Hhey21Rg=;
	b=fxGrrBwVSANjwNvZ/qEUNsBeJhlBQY8khoXa9rIOtx4znx2SNGPk/m80/6sTTlrNKUd3e2
	wQuviI2nuw9xg0t2GfElkySFVpiysclq9kRAGVp0QA8Sx/tETvgStVCg+SAWJHeGkLvCD0
	8i/uCQd7XBqzIjFxDGvW90RK0RW9N7U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-7uKOREwjNPi_uWS0Qvm4mg-1; Tue, 21 May 2024 17:44:19 -0400
X-MC-Unique: 7uKOREwjNPi_uWS0Qvm4mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4236E81101C;
	Tue, 21 May 2024 21:44:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C5ED51BF;
	Tue, 21 May 2024 21:44:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <D1FMVEJWGLEW.14QGHPAYPHQG1@kernel.org>
References: <D1FMVEJWGLEW.14QGHPAYPHQG1@kernel.org> <20240521031645.17008-1-jarkko@kernel.org> <20240521031645.17008-5-jarkko@kernel.org> <cc3d952f8295b52b052fbffe009b796ffb45707a.camel@HansenPartnership.com>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: dhowells@redhat.com,
    "James Bottomley" <James.Bottomley@HansenPartnership.com>,
    "Herbert Xu" <herbert@gondor.apana.org.au>,
    linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
    Andreas.Fuchs@infineon.com, "James Prestwood" <prestwoj@gmail.com>,
    "David
 Woodhouse" <dwmw2@infradead.org>,
    "Eric Biggers" <ebiggers@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
    "open list" <linux-kernel@vger.kernel.org>,
    "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
    "Mimi
 Zohar" <zohar@linux.ibm.com>,
    "Paul
 Moore" <paul@paul-moore.com>,
    "James Morris" <jmorris@namei.org>,
    "Serge E.
 Hallyn" <serge@hallyn.com>,
    "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] KEYS: trusted: Move tpm2_key_decode() to the TPM driver
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <336754.1716327854.1@warthog.procyon.org.uk>
Date: Tue, 21 May 2024 22:44:14 +0100
Message-ID: <336755.1716327854@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> On Tue May 21, 2024 at 9:18 PM EEST, James Bottomley wrote:
> ...
> You don't save a single byte of memory with any constant that dictates
> the size requirements for multiple modules in two disjoint subsystems.

I think James is just suggesting you replace your limit argument with a
constant not that you always allocate that amount of memory.  What the limit
should be, OTOH, is up for discussion, but PAGE_SIZE seems not unreasonable.

David


