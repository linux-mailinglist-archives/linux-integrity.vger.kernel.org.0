Return-Path: <linux-integrity+bounces-2534-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0912B8CB58C
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 23:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A9A282B2D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A175149C49;
	Tue, 21 May 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GGY3zSRZ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GGY3zSRZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D392487B0;
	Tue, 21 May 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328764; cv=none; b=KDxOxDwjVWKW9TpkhJ+8SSPYuObyaIJ+nf0LpMOUb5QJqhRf7gu7sVJlS/ifoTbc5uftk77UBo2G/wDMpYHF+zNIyvMOzjDSSks1GnYtPb5Wd5CoOr5A5PyRxFS98UUDF6mvl4alGtZlvI6dHCcB5nQskjVwpQL9i0NrCRK7HBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328764; c=relaxed/simple;
	bh=ExRaYfsiZeEOmvmtCvC4K/IJ1+lTsHOUpjawdxFpOgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyrclqEFaa9FHy3pk9DtrYsHEsDwkzWrNynrlzKaCTAGuNQ2AKI31yKC6Nzr6QmrkkCva7PTZ0HhtlwD3xThr1i4r5EraomhOxLE9QP/0uF4WLNNEdXznihD0rDebgYWH/GdiCRU9A620hMHe7Syph0fIqEKqdVPsrnx2xIIxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=GGY3zSRZ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=GGY3zSRZ; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716328761;
	bh=ExRaYfsiZeEOmvmtCvC4K/IJ1+lTsHOUpjawdxFpOgA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=GGY3zSRZBXRAVTF0VPyPtMh0JOhRXt0t/96tI+v3rBLKPPakAXq2XfLmnRItO59p0
	 MWW+fTE2TaKFjwLTa1yNwcRuShBGKnFWEu+trlwZeNjenZ4WEP6wTyDmJTYIT9k4uy
	 Ka81hxz3oMEOG7upCvQKNuUQVLat+Or+bwLQmJvI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8ADAD1286FF7;
	Tue, 21 May 2024 17:59:21 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id wXRn9UmN3dKw; Tue, 21 May 2024 17:59:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716328761;
	bh=ExRaYfsiZeEOmvmtCvC4K/IJ1+lTsHOUpjawdxFpOgA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=GGY3zSRZBXRAVTF0VPyPtMh0JOhRXt0t/96tI+v3rBLKPPakAXq2XfLmnRItO59p0
	 MWW+fTE2TaKFjwLTa1yNwcRuShBGKnFWEu+trlwZeNjenZ4WEP6wTyDmJTYIT9k4uy
	 Ka81hxz3oMEOG7upCvQKNuUQVLat+Or+bwLQmJvI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DF2F31286DFB;
	Tue, 21 May 2024 17:59:19 -0400 (EDT)
Message-ID: <239a52eb5ed3a6c891382b63d08fe7b264850d38.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 4/6] KEYS: trusted: Move tpm2_key_decode() to the TPM
 driver
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 linux-integrity@vger.kernel.org,  keyrings@vger.kernel.org,
 Andreas.Fuchs@infineon.com, James Prestwood <prestwoj@gmail.com>, David
 Woodhouse <dwmw2@infradead.org>, Eric Biggers <ebiggers@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar
 <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Date: Tue, 21 May 2024 17:59:18 -0400
In-Reply-To: <336755.1716327854@warthog.procyon.org.uk>
References: <D1FMVEJWGLEW.14QGHPAYPHQG1@kernel.org>
	 <20240521031645.17008-1-jarkko@kernel.org>
	 <20240521031645.17008-5-jarkko@kernel.org>
	 <cc3d952f8295b52b052fbffe009b796ffb45707a.camel@HansenPartnership.com>
	 <336755.1716327854@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-05-21 at 22:44 +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > On Tue May 21, 2024 at 9:18 PM EEST, James Bottomley wrote:
> > ...
> > You don't save a single byte of memory with any constant that
> > dictates the size requirements for multiple modules in two disjoint
> > subsystems.
> 
> I think James is just suggesting you replace your limit argument with
> a constant not that you always allocate that amount of memory.

Exactly.  All we use it for is the -E2BIG check to ensure user space
isn't allowed to run away with loads of kernel memory.

> What the limit should be, OTOH, is up for discussion, but PAGE_SIZE
> seems not unreasonable.

A page is fine currently (MAX_BLOB_SIZE is 512).  However, it may be
too small for some of the complex policies when they're introduced. 
I'm not bothered about what it currently is, I just want it to be able
to be increased easily when the time comes.

James


