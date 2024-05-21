Return-Path: <linux-integrity+bounces-2502-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA58CA8A3
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 09:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077C61F21F5C
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 07:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE714CDE0;
	Tue, 21 May 2024 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roUriWhA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3E4B5CD;
	Tue, 21 May 2024 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275643; cv=none; b=onrg7oI5seM80nlps25LsOQ+KD5cWbNCcPjWZbK51rq/6wS/7MsnlDRS51iB+PTjwejcAAyIbrpxMkPeZH0boZlkUu539fw/BHY+Idpx/+vQiZhQYdBZq4mUGDKPHZ/cqNV8MdK8NYye/RQ4hnbAp1AyWVrTK36zfGsxW623SE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275643; c=relaxed/simple;
	bh=GBp6YlGoBVoT9sV+NoIDXHp6U9g6yyUiX/O/7sbq4K4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DKDs0rdp71awPacf8sZKWg9qUsEJaaYnlReTuOzpVyjdQkzTZ8klhIuqj3uYEN6vVnEtNqnwvrG6SY9B8evp/5tQvUVcKpqiCiXUYOgD1xY0dvETCKcbz8p4ulCpifJIyF0skHq4PyqtpQEVA9RjMKZUl/eq2kv/lI4MHKf/jQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roUriWhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763BBC2BD11;
	Tue, 21 May 2024 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716275642;
	bh=GBp6YlGoBVoT9sV+NoIDXHp6U9g6yyUiX/O/7sbq4K4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=roUriWhAqPsmDa786hb8CpeIX0pzbH45YDWNFSKt+Ta85xrCQDfOtMnEW5uYLi5Q2
	 eTMFltKqN/Sw1ZVWzxe442fHdgRwvK6zbFkUZIvmedNniU5jS64y2K7Mryesxf5F95
	 CaRZz2m8js1GUUzrev2NpA+4oXNtxMXz6OKwJLqkfRAzNK77KiUnnXFBN/9JvNZ+K4
	 R58O9A3IrbkFN28uzd9bz+B2vMZpOhuPRceC9O6kqnV6tivZ6g+IOM9AEpnyKd6Mh7
	 pInvTPEr1XsNrnzLuGN6CPOEeIRenIYIAmzN9ExjgkYn8SvhPO5Ngx1WqihcvUheHn
	 gbT8zpqlgnrAw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 10:13:56 +0300
Message-Id: <D1F4XQT63H3G.2LXFQ4FCHU06G@kernel.org>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "Andreas.Fuchs@infineon.com" <Andreas.Fuchs@infineon.com>, "James
 Prestwood" <prestwoj@gmail.com>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "David S. Miller"
 <davem@davemloft.net>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH v2 5/6] tpm: tpm2_key: Extend parser to
 TPM_LoadableKey
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Bharat Bhushan" <bbhushan2@marvell.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-6-jarkko@kernel.org>
 <SN7PR18MB53140F4341BC441C1C11586EE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>
In-Reply-To: <
 <SN7PR18MB53140F4341BC441C1C11586EE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>

On Tue May 21, 2024 at 8:47 AM EEST, Bharat Bhushan wrote:
>
>
> > -----Original Message-----
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > Sent: Tuesday, May 21, 2024 8:47 AM
> > To: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: linux-integrity@vger.kernel.org; keyrings@vger.kernel.org;
> > Andreas.Fuchs@infineon.com; James Prestwood <prestwoj@gmail.com>;
> > David Woodhouse <dwmw2@infradead.org>; Eric Biggers
> > <ebiggers@kernel.org>; James Bottomley
> > <James.Bottomley@hansenpartnership.com>; Jarkko Sakkinen
> > <jarkko@kernel.org>; David S. Miller <davem@davemloft.net>; open
> > list:CRYPTO API <linux-crypto@vger.kernel.org>; open list <linux-
> > kernel@vger.kernel.org>; Peter Huewe <peterhuewe@gmx.de>; Jason
> > Gunthorpe <jgg@ziepe.ca>; James Bottomley
> > <James.Bottomley@HansenPartnership.com>; Mimi Zohar
> > <zohar@linux.ibm.com>; David Howells <dhowells@redhat.com>; Paul Moore
> > <paul@paul-moore.com>; James Morris <jmorris@namei.org>; Serge E. Hally=
n
> > <serge@hallyn.com>; open list:SECURITY SUBSYSTEM <linux-security-
> > module@vger.kernel.org>
> > Subject: [EXTERNAL] [PATCH v2 5/6] tpm: tpm2_key: Extend parser to
> > TPM_LoadableKey
> >=20
> > ----------------------------------------------------------------------
> > Extend parser to TPM_LoadableKey. Add field for oid to struct tpm2_key
> > so that callers can differentiate different key types.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  drivers/char/tpm/tpm2_key.c               | 14 +++++++++++---
> >  include/crypto/tpm2_key.h                 |  2 ++
> >  security/keys/trusted-keys/trusted_tpm2.c |  4 ++++
> >  3 files changed, 17 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm2_key.c b/drivers/char/tpm/tpm2_key.c
> > index 0112362e432e..59797dc232f1 100644
> > --- a/drivers/char/tpm/tpm2_key.c
> > +++ b/drivers/char/tpm/tpm2_key.c
> > @@ -32,16 +32,24 @@ int tpm2_key_type(void *context, size_t hdrlen,
> >  		  const void *value, size_t vlen)
> >  {
> >  	enum OID oid =3D look_up_OID(value, vlen);
> > -
> > -	if (oid !=3D OID_TPMSealedData) {
> > +	struct tpm2_key *key =3D context;
> > +
> > +	switch (oid) {
> > +	case OID_TPMSealedData:
> > +		pr_info("TPMSealedData\n");
> > +		break;
> > +	case OID_TPMLoadableKey:
> > +		pr_info("TPMLodableKey\n");

These should be pr_debug() (forgot to change).

> > +		break;
> > +	default:
> >  		char buffer[50];
> > -
> >  		sprint_oid(value, vlen, buffer, sizeof(buffer));
> >  		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
> >  			 buffer);
>
> Maybe extend this print to say "neither TPMSealedData nor TPMLodableKey"

Right, I tried to apply minimal delta to patches where existing code
needs to be carved to a new form :-)

I think it could be just "OID \"%s\" is unknown"?

BR, Jarkko

