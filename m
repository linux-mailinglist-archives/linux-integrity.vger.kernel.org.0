Return-Path: <linux-integrity+bounces-2578-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE348CD510
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5821C22239
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5C14AD0D;
	Thu, 23 May 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayKX1bTr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4614A623;
	Thu, 23 May 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472448; cv=none; b=vF2AXGfx2R2laVAWdKF4af38abTMnDVSkOKE7728hVEg/8NoHBpVqlw0EpA865SnS52kjwqIrUPAaG9gnF7KqKbQXBVKJtIg8XrbtZKSTsVSF9vSEqmp/8nuPlqC6VabUULJc5pPKVTHjaE9HYF8YT3oupYxJwgXlMLKQpHz9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472448; c=relaxed/simple;
	bh=P+hLj/xeIZCtao3ZdxaW6Pa3wcEv0A+M9crGMZXsRZ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=msLhCMN70f9AC9UV1nucmM+5RV9erRWdSan3j6cXaiHwDtyPtrcZuagpYwc342TjX3MwRg+X9ng/9se3qU4NZ03M/RZfH3oCADijAiHE134+KntPOh2cMxTq+RWeSIDzItJY6a3Z6i5Vr3ubU/inNxV4kvYmooy9DS4MAtvg50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayKX1bTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D114C2BD10;
	Thu, 23 May 2024 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716472447;
	bh=P+hLj/xeIZCtao3ZdxaW6Pa3wcEv0A+M9crGMZXsRZ4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ayKX1bTreCUTqoASDyJPYr6TE6auh/UCZhEgX9iyrQ048n9MrNmMqI8bnIkveOVc9
	 QaIhEo6wh7Y5FDsOhpCqmt2qOHIVoCgmWkAhsEzqlFZMCienHNRGAutLrxJH6hu3aY
	 dJ36BDJY+07Q+4Gmw3lan86Zam2WO+X6JWltZ0N+8ZAVqaFZTAzI9July0mKXfSZG6
	 UL1fdhJa2vBqoR8rImFxT5c/gbiEJly4SpAeMAkfsn3HqSITRsC5IHYBNX+H6VStPp
	 +1+WvFXKpQ+uB5oY0bGGsKUydK/tti03cklTBbUZGlHc8z2Oa1cegL+3yNfi9Tz8qd
	 sNHXUH8+ytmxQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 16:54:02 +0300
Message-Id: <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
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
In-Reply-To: <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>

On Thu May 23, 2024 at 4:38 PM EEST, James Bottomley wrote:
> On Thu, 2024-05-23 at 16:19 +0300, Jarkko Sakkinen wrote:
> > There's no reason to encode OID_TPMSealedData at run-time, as it
> > never changes.
> >=20
> > Replace it with the encoded version, which has exactly the same size:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A067 81 05 0A 01 05
> >=20
> > Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so
> > that the OID can be simply copied to the blob.
>
> This is true, but if we're going to do this, we should expand the OID
> registry functions (in lib/oid_registry.c) to do something like
> encode_OID.  The registry already contains the hex above minus the two
> prefixes (which are easy to add).

Yes, I do agree with this idea, and I named variable the I named
it to make it obvious that generation is possible.

It would be best to have a single source, which could be just
a CSV file with entries like:

<Name>,<OID number>

And then in scripts/ there should be a script that takes this
source and generates oid_registry.gen.{h,c}. The existing
oid_registry.h should really just include oid_registry.gen.h
then to make this transparent change.

And then in the series where OID's are encoded per-subsystem
patch that takes pre-encoded OID into use.

Happy to review such patch set if it is pushed forward.

> > @ -51,8 +52,8 @@ static int tpm2_key_encode(struct
> > trusted_key_payload *payload,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!scratch)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0work =3D asn1_encode_oid(wor=
k, end_work, tpm2key_oid,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asn1_oid_len(tpm2key_oid));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0work =3D memcpy(work, OID_TP=
MSealedData_ASN1,
> > sizeof(OID_TPMSealedData_ASN1));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0work +=3D sizeof(OID_TPMSeal=
edData_ASN1);
>
> You lost the actually fits check.  This is somewhat irrelevant for TPM
> keys because the OID is first in the structure and thus will never
> overflow, but it might matter for other uses.

Yep, it is irrelevant IMHO, there is 8 bytes, and also its location
never changes.

> James

BR, Jarkko

