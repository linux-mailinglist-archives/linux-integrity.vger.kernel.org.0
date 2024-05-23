Return-Path: <linux-integrity+bounces-2585-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AEA8CD718
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CEE28363C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70701BC49;
	Thu, 23 May 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="g43oAHcT";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qbWJ2rO4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CF17BA6;
	Thu, 23 May 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478253; cv=none; b=B83q2uG7U7oLI067W6Hhl1ZkXNCYZsw+k06w0JxBT64Bpr6PJhH0LHHHagA+IbLafODOCPz0eNfEMKAv2i38CQ0O8IgTyXpOY9oMlDOB5l+t9GWfbD5PVXq3rf/gWEub0KCkwuHs7jjdYLEkDokRt6GufF3zoPXVZLTK1sbeKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478253; c=relaxed/simple;
	bh=eRv++RtTMbGGKt3sM0Qg0vdSeba5nbe3+wVeKfd8zio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxHl+mV5AgsM/DJEzW6+BBz/bL++7ZZZVsPOgSC77LoblJIqRJFnmQ0T38QHI2eWbPvDQMTAcqZuVjmW2tp6YjHEnmXtJvffDQcCshp+Ngkg5m9HzPcjnsCSDlq8P0YSLx6s2G4SMg2xCo9xvpNcUoQV9W/TyZ0WojTQ5MCJmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=g43oAHcT; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=qbWJ2rO4; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716478251;
	bh=eRv++RtTMbGGKt3sM0Qg0vdSeba5nbe3+wVeKfd8zio=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=g43oAHcTcvfMrhAvQOkxeUKtwoHt3NN8Nc+/EQlAa72XQl7BpkFjR1uN36q9zeAbC
	 a/hJlF58ii8yi1g1dFRtTHIS/pcHYwDmDQlw2RNDz15o6YC7eqndPdyNABEF4QOaDc
	 bfW8eBZvYwlYUuSg6aPG0q1kc3Ou6KqyMi00/NXI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1AB811286D83;
	Thu, 23 May 2024 11:30:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id U16E3k5rrxQQ; Thu, 23 May 2024 11:30:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716478250;
	bh=eRv++RtTMbGGKt3sM0Qg0vdSeba5nbe3+wVeKfd8zio=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=qbWJ2rO4zA9JMpnSR2fBDKZhC7Ip/YnRTlLDUOztgsxh6L7fNhZf+1GJAHX2Zn6Vv
	 ceib3sMdsbSH2G4shd9g6boLBsIBKv2ohYC2ey7N7sZ5d/zo+eDwaoZBfVulI16RiB
	 kI0fUinUOLMQMt1PaEAFptlzseYD2CJkcdZZlo18=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A5F2E1286C23;
	Thu, 23 May 2024 11:30:49 -0400 (EDT)
Message-ID: <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND] KEYS: trusted: Use ASN.1 encoded OID
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Eric
 Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Andrew Morton
 <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, David
 Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Date: Thu, 23 May 2024 11:30:47 -0400
In-Reply-To: <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
References: <20240523131931.22350-1-jarkko@kernel.org>
	 <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>
	 <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-05-23 at 16:54 +0300, Jarkko Sakkinen wrote:
> On Thu May 23, 2024 at 4:38 PM EEST, James Bottomley wrote:
> > On Thu, 2024-05-23 at 16:19 +0300, Jarkko Sakkinen wrote:
> > > There's no reason to encode OID_TPMSealedData at run-time, as it
> > > never changes.
> > > 
> > > Replace it with the encoded version, which has exactly the same
> > > size:
> > > 
> > >         67 81 05 0A 01 05
> > > 
> > > Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue
> > > so
> > > that the OID can be simply copied to the blob.
> > 
> > This is true, but if we're going to do this, we should expand the
> > OID
> > registry functions (in lib/oid_registry.c) to do something like
> > encode_OID.  The registry already contains the hex above minus the
> > two
> > prefixes (which are easy to add).
> 
> Yes, I do agree with this idea, and I named variable the I named
> it to make it obvious that generation is possible.
> 
> It would be best to have a single source, which could be just
> a CSV file with entries like:
> 
> <Name>,<OID number>
> 
> And then in scripts/ there should be a script that takes this
> source and generates oid_registry.gen.{h,c}. The existing
> oid_registry.h should really just include oid_registry.gen.h
> then to make this transparent change.
> 
> And then in the series where OID's are encoded per-subsystem
> patch that takes pre-encoded OID into use.
> 
> Happy to review such patch set if it is pushed forward.

Heh, OK, since I'm the one who thinks it's quite easy, I'll give it a
go.

James


