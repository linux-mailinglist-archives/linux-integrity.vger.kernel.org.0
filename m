Return-Path: <linux-integrity+bounces-2579-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689158CD522
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D7DB23779
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7614B950;
	Thu, 23 May 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1LB9ruq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22F14AD17;
	Thu, 23 May 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472679; cv=none; b=dm5wwYbOH8HkRZRVpNscxb+N5aJQ/4NktCYzd5XzM7eEkGlP5PBaHZrDKEW5VaTlfoqrDd2lBUQnmLF0kA1LoBxD29+nky6vd5FGCdfz/5+Y0uElQXPKe5OwZyZ5P7TRBLkBvvgoFpdIONWsmTUJWoOE8QbNwQ+FdLDzdWkT390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472679; c=relaxed/simple;
	bh=wUzOBAOX+9O+l9O6ECannahrBqHm9nXvPZwXexU/1AE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xjj1GqAG/lfCTiFWr20sGouINsaaOvoE8tX4Y7WD2vEoSjuQRuFQgli8tUjeCL6ZS7Jc1GuJ2parYAfiLl8A5NkyJDbRDCWPcU3bCrnwjZ3psu5yi8P9H1mGEkwGPw0gFX3ad111whwkzd7MpF5vViS6oZQ1tg5bGqnOHxuVCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1LB9ruq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E18C32781;
	Thu, 23 May 2024 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716472679;
	bh=wUzOBAOX+9O+l9O6ECannahrBqHm9nXvPZwXexU/1AE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=O1LB9ruq/QZVg14GfunSnd5B0E1BwJgP4+vyJ+R6abbihZ4k2k6tH99mK7SyIwGt5
	 5xLQKOSGElfnipOXvnECikXkZbUAL6+QqLibO6TkQXqsDp/if1Pyb+cZxI9PF6thg6
	 RV1/TYY++ZdcnwTrtIAluoXcNmTdwS1/J2KmJ0GHgQXVFM3oBERKMaaVc7j370thpU
	 mrE4IC3qzqyPy1MMMrLLKWbPdoThXptyeYLoLe2tLIYpP0IYraTXnLX97oukMV78Y0
	 cI/VqDg7hNI4w8L69ExG+XWP2UKUb7SFklnlItqeyEPqAIkKRrmaxmemEhB3Mn1fsC
	 244h2b53fJiYQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 16:57:53 +0300
Message-Id: <D1H2S4HVRADC.297K3OZ53GVIN@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Use ASN.1 encoded OID
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ben Boeckel" <me@benboeckel.net>
X-Mailer: aerc 0.17.0
References: <20240523132341.32092-1-jarkko@kernel.org>
 <Zk9Hb-whVYvJrfLY@farprobe>
In-Reply-To: <Zk9Hb-whVYvJrfLY@farprobe>

On Thu May 23, 2024 at 4:41 PM EEST, Ben Boeckel wrote:
> On Thu, May 23, 2024 at 16:23:37 +0300, Jarkko Sakkinen wrote:
> > There's no reason to encode OID_TPMSealedData at run-time, as it never
> > changes.
> >=20
> > Replace it with the encoded version, which has exactly the same size:
> >=20
> > 	67 81 05 0A 01 05
>
> Is it the same size? It looks considerably smaller to me (6*4 bytes
> versus 8 bytes).

Not in that sense but in practice the old array stored byte values.
Forgot for that reason that it was actually u32 array.

I can change it to "same number of elements".

>
> > Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so that
> > the OID can be simply copied to the blob.
>
> An "epilogue" occurs at the end, but it seems to be at the beginning
> here (that would be a "prologue").

Yup, typo.

> > -static u32 tpm2key_oid[] =3D { 2, 23, 133, 10, 1, 5 };
> > +/* Encoded OID_TPMSealedData. */
> > +static u8 OID_TPMSealedData_ASN1[] =3D {0x06, 0x06, 0x67, 0x81, 0x05, =
0x0a, 0x01, 0x05};
>
> I'd say that a comment of what it encodes would be good to have for
> context, but the source tree has `OID_TPMSealedData` in a header with
> the value in a comment there, so that seems good enough to me.

OK. I named it this way to promote generation these from CSV file=20
(see my other response to James).


>
> > as it never changes.
>
> Should it, perhaps be `const` too?

Yup.

>
> --Ben

Thanks for the remarks!

BR, Jarkko

