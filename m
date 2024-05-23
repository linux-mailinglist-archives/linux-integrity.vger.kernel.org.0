Return-Path: <linux-integrity+bounces-2589-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571948CD8DA
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 19:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A052822E5
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E26E60F;
	Thu, 23 May 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnFeYTQ/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B0AD2C;
	Thu, 23 May 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483789; cv=none; b=KRLS3LXHcqJvOD6d4merDUsxqHq3BAKS+PyHHNj6R+rV4O1W2TmbePGfXW+qR+tUUrOx0zvB5CZPVdG5L2ofSKp2jrFvJlVOpuqLQ8AeucZeemev8oa0GJFgQwWogCvPy+N6lkcolRJTlnYy3UEcZkCiOCS0Eys2VBVU0u8EBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483789; c=relaxed/simple;
	bh=TPIiHymDivYK+505g1ZXFIowtVhYD5MQi73bkIsZX80=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=r+8mrxnIwtaU7ZI682KYggVCVMaFgEYZydGFZfAWeVTFyHkCEX6pgY96e3WiDPgBCVGEjpQHmOipY7UVasVKH6zANAOTrXdVAORMt8UfEU5cgwDzwsRdaeMhVyG7EwmNMLtg/LsiEQWMafRtFIw+6/cVVXBCnHF+Yn120dUMnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnFeYTQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B94C2BD10;
	Thu, 23 May 2024 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716483789;
	bh=TPIiHymDivYK+505g1ZXFIowtVhYD5MQi73bkIsZX80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnFeYTQ/wYo2O8RrJilNL/Z9eWolf9sV07k6ANJAi+PFOxO0i3b8e9EG9s6oKCAg2
	 WuTNsAuaeoB3RcJhw3ESriM3iV+vOxpTL7kCKx+c9KX9ssz3JK/qL2sej0gXOropl+
	 UIWKwj7HT/YVqWtGCxljuC/5kaTZVsWakYdQul6UDHNtWs0Jjd3zD8ukim2879LKka
	 pdJgrRHZ9+gMLgpQB4EOwIAdC0ijjOnXnRiiYhFj+j3XcMuw2mjEEagGSowA+5SFiR
	 egQ4s6voaIRWyCnb+kR/ZrhXNVvcu36f72fy5PJbcGW7hKceSAFAGpHpjOikmcY/3W
	 azOjBtNo0Zcag==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 20:03:03 +0300
Message-Id: <D1H6PWDP0EPE.1PD74CKI5KKCP@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>
Subject: Re: [PATCH RESEND] KEYS: trusted: Use ASN.1 encoded OID
X-Mailer: aerc 0.17.0
References: <20240523131931.22350-1-jarkko@kernel.org>
 <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>
 <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
 <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>
 <D1H4WNKWCB5K.2HJG7RMX7L33V@kernel.org>
 <4d33654876b91a954e581727b6eb2c5e94128cb1.camel@HansenPartnership.com>
 <D1H5A2BM6RBM.1RHCXHHO1SKDX@kernel.org>
In-Reply-To: <D1H5A2BM6RBM.1RHCXHHO1SKDX@kernel.org>

On Thu May 23, 2024 at 6:55 PM EEST, Jarkko Sakkinen wrote:
> I was already considering do we need the encoder at all but I think
> for dynamic assets like octect strings and variable size integers
> it has its place. Obviously is not very mature at this point.

Also, I've been opening up discussion of opt-in and *experimental*
ASN1_RUST feature.

I think it is inevident that it needs to be done at some point because
for ASN.1 like format this would have benefits, and also given that it
used to process security sensitive data.

So metrics for this would something along the lines:

- Depending on ASN1_RUST setting, the C API's would be implemented
  either C or Rust.
- OID database could be shared from C-side to Rust simply with
  bindgen.
- C API should be streamline and matured a bit to cover mostly
  dynamic assets (integers, octect strings and such). Since the
  number of call sites is small improving should be easy.
- After tpm2_key_rsa is landed as it is now as per how buffer
  processing goes it can be brought to use encoder.
- I'd consider have just a single ASN1 flag instead of a separate
  ASN1_ENCODER flag. It simplifies thing and is not significant
  cost for vmlinux size so not worth it IMHO.

As for sending patches for e.g. improving OID database, I'd like to
land the current tpm2_key_rsa first because then in possible OID
series that can be also applied to it (and encoder). It does stuff
that affects all this work. And as said we need also tpm2_key_ecdsa.

Right, there's also

https://datatracker.ietf.org/doc/draft-woodhouse-cert-best-practice/

I checked from David that this TPM2 asymmetric key work is relevant
for this spec although I readily know some applications for it, and=20
he acknowledged that. I should probably link that to the next
version.

Asymmetric keys essentially make TPM2 a peer in x.509 ecosystem,
which has bunch of especially enterprise and data center type
of use cases.

I guess this summarizes the big picture. I've been messing around
mailing lists and developed these thoughts but this along the
lines how I see big picture, including integration to the Rust
ecosystem (in non-intrusive way).

But yeah, tpm2_key_rsa needs to be the first step.

I don't have an employer for kernel development at the moment (probably
at some point I do, my contract researcher sabbatical ends at end of
Sep) no money to come to the plumbers to discuss about all this at the
boot-time security mc so I need to spam my input for that I guess ;-)

BR, Jarkko

