Return-Path: <linux-integrity+bounces-2588-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF8C8CD7CF
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719BEB228BB
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA612B89;
	Thu, 23 May 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBWxgsZL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9F125DE;
	Thu, 23 May 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479727; cv=none; b=JY+PDavdeGg/u2fLyk6Uca0H3xIkNaqnyZXZ9e3E70Z+WpSNDgUwVy0tdi14HAqvhv0orCuoAey6SE/LoUVWz4lSKqQmg7Z78R5uIVE4StN9/zqceTm8dZ1pOaqZnAvNyzDBwDlxyZUNJOJoD3GEmJdSRRoJtGv++N5R/GgxwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479727; c=relaxed/simple;
	bh=54+b4cyegsL99qAcG8FhAJJnqbtwB/M+afVJhDobI/k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pAnkzKwO/2TnmrO2ZRlYfv4bq+qa9ebztT/3BphK3vPQrRx5zTcxhSI7+DPdven1Kvd6vlLWVVI69iJCOY2LUSzIE12jjXn6NVGrx6RRNBBfJ8Hy4p6SD37Zn1T2KHVtAYfu8LYJYhA+TrF6TlKlWZQM9tFj9J/0YOiwPMVxa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBWxgsZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4114C3277B;
	Thu, 23 May 2024 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716479726;
	bh=54+b4cyegsL99qAcG8FhAJJnqbtwB/M+afVJhDobI/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBWxgsZLdnHrqucLI1ShGVZFmnRG0ZRU7v5DJNOvNu8jZaXZbtAOL0+ZQgM2C0b6+
	 u9GSflyGWJUi5/nGTyaWp0YQAruE2uyEytQgB8OQ75McNLDcwBlTQB3QfidY1/kZGy
	 mO0bJpAodvMQcwr56OCdKKyGlFOEmuWAmwNiq60/HyeaJVK7BfYJAvI1njD/dJ56zv
	 GzZXG6VMJwnbnw2E2/fQkD0vsh1a8O6fQcnNy7OWikHK9wDKYu8QaObGDYWeo9tbak
	 0nc6d1jUWb6nyfuI9hpououUX0Vok4uOahDNT7Zir6wThRuJiM0uMsTHkaOpE40Eio
	 yOwz9jD221WcQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 18:55:21 +0300
Message-Id: <D1H5A2BM6RBM.1RHCXHHO1SKDX@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
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
X-Mailer: aerc 0.17.0
References: <20240523131931.22350-1-jarkko@kernel.org>
 <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>
 <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
 <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>
 <D1H4WNKWCB5K.2HJG7RMX7L33V@kernel.org>
 <4d33654876b91a954e581727b6eb2c5e94128cb1.camel@HansenPartnership.com>
In-Reply-To: <4d33654876b91a954e581727b6eb2c5e94128cb1.camel@HansenPartnership.com>

On Thu May 23, 2024 at 6:43 PM EEST, James Bottomley wrote:
> On Thu, 2024-05-23 at 18:37 +0300, Jarkko Sakkinen wrote:
> > On Thu May 23, 2024 at 6:30 PM EEST, James Bottomley wrote:
> > > On Thu, 2024-05-23 at 16:54 +0300, Jarkko Sakkinen wrote:
> > > > On Thu May 23, 2024 at 4:38 PM EEST, James Bottomley wrote:
> > > > > On Thu, 2024-05-23 at 16:19 +0300, Jarkko Sakkinen wrote:
> > > > > > There's no reason to encode OID_TPMSealedData at run-time, as
> > > > > > it never changes.
> > > > > >=20
> > > > > > Replace it with the encoded version, which has exactly the
> > > > > > same size:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A067 81 05 0A 01 =
05
> > > > > >=20
> > > > > > Include OBJECT IDENTIFIER (0x06) tag and length as the
> > > > > > epilogue so that the OID can be simply copied to the blob.
> > > > >=20
> > > > > This is true, but if we're going to do this, we should expand
> > > > > the OID registry functions (in lib/oid_registry.c) to do
> > > > > something like encode_OID.=C2=A0 The registry already contains th=
e
> > > > > hex above minus the two prefixes (which are easy to add).
> > > >=20
> > > > Yes, I do agree with this idea, and I named variable the I named
> > > > it to make it obvious that generation is possible.
> > > >=20
> > > > It would be best to have a single source, which could be just
> > > > a CSV file with entries like:
> > > >=20
> > > > <Name>,<OID number>
> > > >=20
> > > > And then in scripts/ there should be a script that takes this
> > > > source and generates oid_registry.gen.{h,c}. The existing
> > > > oid_registry.h should really just include oid_registry.gen.h
> > > > then to make this transparent change.
> > > >=20
> > > > And then in the series where OID's are encoded per-subsystem
> > > > patch that takes pre-encoded OID into use.
> > > >=20
> > > > Happy to review such patch set if it is pushed forward.
> > >=20
> > > Heh, OK, since I'm the one who thinks it's quite easy, I'll give it
> > > a go.
> >=20
> > I guess if it cleaned up multiple sites in kernel then it could
> > be considered useful. I'd guess that there is at least a few
> > locations that also encode OID.
>
> This should be the only one currently.  The ASN.1 encoding was added to
> the kernel to support the trusted keys pipe use case.  However, if you
> want the kernel to construct and pipe out asymmetric keys, that would
> be the second use case.

Yes, we definitely need tpm2_key_ecdsa, and that is actually probably
more important than RSA but I think both are needed. It was easier to
use RSA to carve stuff to fit as there some off-the-shelf code that
could be modified for the purpose.

I was already considering do we need the encoder at all but I think
for dynamic assets like octect strings and variable size integers
it has its place. Obviously is not very mature at this point.

I think I keep the "dump" strategy for RSA keys at least for first
to keep the series as tight as possible but at least v3 included
already a patch to make asn1_encode_integer() eat variable size
stuff:

https://lore.kernel.org/linux-integrity/20240521152659.26438-3-jarkko@kerne=
l.org/

So my proposal here is that I land RSA keys without using encoder
but that said it can take them into use in ECDSA keys when the
encoder has been carved up properly. There's already bunch of
things changed in v4, so thus I did not want to keep this
in that series:

https://lore.kernel.org/linux-integrity/20240522005252.17841-1-jarkko@kerne=
l.org/

I.e. the dump can be considered as first iteration. There's
bunch of uses for these keys, e.g. WIFI passwords, Ethereum
keypairs (requires ECDSA) and many others. It is really awesome
application feature for TPM2.

BR, Jarkko

