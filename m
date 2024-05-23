Return-Path: <linux-integrity+bounces-2586-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A6A8CD746
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 17:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DA1281D0A
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ADC1171D;
	Thu, 23 May 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUb2iX3o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613F125C9;
	Thu, 23 May 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478676; cv=none; b=Qaq8nw+JDAJt3OXISTzsDHn5iQIBHFGTweBhpp8PJDqf0+8+apbqxK0hq8JAnnvIXFophoKPmZXPGQ0epuJ/PcH0/EwcanN2Fff7OMncap2rFwhqYvTvf9pmCVnb2YVt7uds3nkszlr1zqH7YX/YAJKxy2lQr47m6rheBAlehhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478676; c=relaxed/simple;
	bh=3oAjIlkP7/L4zMK25MNZgmLkv0DGvWKMHVkhOywzgkc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rWVeGmS4D2QjZN3TlB3IlVjNWqQJQgNIHmRo3wyIzwRX6Fordp1kG/FCXDbK5t+2YGaSyAQGf0XZndjWjLsWiTC1sDMlJFBjE4D1DiPQLaUQpkSjt/yWEIMMhqVpbDnpA7sx4onHHndqZ5hyOcJZM5CLKnxa7OzTwwW/Lz9XToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUb2iX3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80E8C2BD10;
	Thu, 23 May 2024 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716478676;
	bh=3oAjIlkP7/L4zMK25MNZgmLkv0DGvWKMHVkhOywzgkc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GUb2iX3opnNDNylUyIPZiqg9aeN2XWexSm+KGpy+z0kDFp1iaWJjmnaf9lMLXv3W/
	 JG/6KcHtndYh6MSlkpZW5jK++7hQLalbGNuNBpXbTxGgoxyKJbcahz4SGxsjfBimeu
	 9IzSjiG/NJFULpv32Zo1/znQ+7xBAkMxyMmBxjmmWTYYhMfKMkLFe7pnUXBzDL+gst
	 NnMMVBOGbar4b2xJ8r6k/awsvltVaPjHmZukwXx88EXONXR1vkeq4ymBTQD3uAVKSK
	 ECraJF7aVPEIcCQagzG2E0MtJjBtJncBJSAaf5WiRMmR3ioPitT2SXUR8+bcecyjj9
	 53UbAGJU4/j1w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 18:37:51 +0300
Message-Id: <D1H4WNKWCB5K.2HJG7RMX7L33V@kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH RESEND] KEYS: trusted: Use ASN.1 encoded OID
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240523131931.22350-1-jarkko@kernel.org>
 <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>
 <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
 <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>
In-Reply-To: <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>

On Thu May 23, 2024 at 6:30 PM EEST, James Bottomley wrote:
> On Thu, 2024-05-23 at 16:54 +0300, Jarkko Sakkinen wrote:
> > On Thu May 23, 2024 at 4:38 PM EEST, James Bottomley wrote:
> > > On Thu, 2024-05-23 at 16:19 +0300, Jarkko Sakkinen wrote:
> > > > There's no reason to encode OID_TPMSealedData at run-time, as it
> > > > never changes.
> > > >=20
> > > > Replace it with the encoded version, which has exactly the same
> > > > size:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A067 81 05 0A 01 05
> > > >=20
> > > > Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue
> > > > so
> > > > that the OID can be simply copied to the blob.
> > >=20
> > > This is true, but if we're going to do this, we should expand the
> > > OID
> > > registry functions (in lib/oid_registry.c) to do something like
> > > encode_OID.=C2=A0 The registry already contains the hex above minus t=
he
> > > two
> > > prefixes (which are easy to add).
> >=20
> > Yes, I do agree with this idea, and I named variable the I named
> > it to make it obvious that generation is possible.
> >=20
> > It would be best to have a single source, which could be just
> > a CSV file with entries like:
> >=20
> > <Name>,<OID number>
> >=20
> > And then in scripts/ there should be a script that takes this
> > source and generates oid_registry.gen.{h,c}. The existing
> > oid_registry.h should really just include oid_registry.gen.h
> > then to make this transparent change.
> >=20
> > And then in the series where OID's are encoded per-subsystem
> > patch that takes pre-encoded OID into use.
> >=20
> > Happy to review such patch set if it is pushed forward.
>
> Heh, OK, since I'm the one who thinks it's quite easy, I'll give it a
> go.

I guess if it cleaned up multiple sites in kernel then it could
be considered useful. I'd guess that there is at least a few
locations that also encode OID.

BR, Jarkko

