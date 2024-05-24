Return-Path: <linux-integrity+bounces-2620-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA28CE6F8
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9181C21F89
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 14:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58C12C483;
	Fri, 24 May 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei72uug9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A112C47B;
	Fri, 24 May 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560813; cv=none; b=euJdgM2Lj1NC4xKBOgxJ8nlZDTNQkP+TonjxHGWp/Oe8FAOFq17XLMVlLtcHI6GaAfItIyK69fOXov1pxRdNkRXveRjT41IeBWFHPOH64No1qFrEUQ+7r6+/CwGLCxFil8aH8grFKTuWUgGBp6KfmLMmwzlA7UOL2W/A1ESrgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560813; c=relaxed/simple;
	bh=fyGguf2QSklsKqQW3WSwI1b/KXzOE9uFeE8xqww9giY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=o3pxM0pRnWFVHHdvmVhR5rGFgsvCYoWJDWIgGICj4sBlqS4wQfII0DC2Airk7a5vMU7CUJlFXelTaJag5lN7puWxVVA477VnKxkqjAohSMCKb/fE6I86N7WtkdFnUfrTSIeC7BUYA27jza3MtryvRw6wHC9KthaXX4UbNd9PDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei72uug9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B0AC2BBFC;
	Fri, 24 May 2024 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716560812;
	bh=fyGguf2QSklsKqQW3WSwI1b/KXzOE9uFeE8xqww9giY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ei72uug9Bxzfih0L6yeNPodUHTfLCuNhJ9CQKKKeZaLaSdn43pxsyQq5hKY5VeHNh
	 Wql8L8yz3qG9eoIUwt9GXa9xpoWoSW+g/X2HbXt7iFtUK/JGlSJdlv+AngtgZSL/aE
	 dVUVqoV6eyH36RQH7qCD6uNC8oi/Wn1Nz9CNTw+FIqnXcDN5mLAiVM9UDII5tLUcBC
	 H8nvI7SIyAKv1YRiX0J3MbQi6MygJqUfz6hYMjYOT2U6wKZT1z4RjBdUvY2t2VBoDM
	 ZvXmKleWmVvdXCY+P/fjMQ9wb+MSorz6ppHFXV3WG243U4gtfZ6hx9zrYY2F4UK+0E
	 4uP2Pu0eARQvg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 17:26:50 +0300
Message-Id: <D1HY0TSQHEZB.3AURD2JXPK0L0@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] lib/oid_registry: add ability to ASN.1 encode OIDs
X-Mailer: aerc 0.17.0
References: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
 <20240524125955.20739-2-James.Bottomley@HansenPartnership.com>
 <D1HWWX4G4ZOO.2UBZQ3L4225UM@kernel.org>
 <7f37bebce37c4bb3b91899629b458762cd34d040.camel@HansenPartnership.com>
In-Reply-To: <7f37bebce37c4bb3b91899629b458762cd34d040.camel@HansenPartnership.com>

On Fri May 24, 2024 at 5:02 PM EEST, James Bottomley wrote:
> On Fri, 2024-05-24 at 16:34 +0300, Jarkko Sakkinen wrote:
> > On Fri May 24, 2024 at 3:59 PM EEST, James Bottomley wrote:
> [...]
> > > diff --git a/include/linux/oid_registry.h
> > > b/include/linux/oid_registry.h
> > > index 51421fdbb0ba..87a6bcb2f5c0 100644
> > > --- a/include/linux/oid_registry.h
> > > +++ b/include/linux/oid_registry.h
> > > @@ -151,5 +151,6 @@ extern enum OID look_up_OID(const void *data,
> > > size_t datasize);
> > > =C2=A0extern int parse_OID(const void *data, size_t datasize, enum OI=
D
> > > *oid);
> > > =C2=A0extern int sprint_oid(const void *, size_t, char *, size_t);
> > > =C2=A0extern int sprint_OID(enum OID, char *, size_t);
> > > +extern ssize_t encode_OID(enum OID, u8 *, size_t);
> > > =C2=A0
> > > =C2=A0#endif /* _LINUX_OID_REGISTRY_H */
> > > diff --git a/lib/oid_registry.c b/lib/oid_registry.c
> > > index fe6705cfd780..adbc287875c1 100644
> > > --- a/lib/oid_registry.c
> > > +++ b/lib/oid_registry.c
> > > @@ -12,6 +12,7 @@
> > > =C2=A0#include <linux/errno.h>
> > > =C2=A0#include <linux/bug.h>
> > > =C2=A0#include <linux/asn1.h>
> > > +#include <linux/asn1_ber_bytecode.h>
> > > =C2=A0#include "oid_registry_data.c"
> > > =C2=A0
> > > =C2=A0MODULE_DESCRIPTION("OID Registry");
> > > @@ -196,3 +197,31 @@ int sprint_OID(enum OID oid, char *buffer,
> > > size_t bufsize)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_GPL(sprint_OID);
> > > +
> > > +/**
> > > + * encode_OID - embed an ASN.1 encoded OID in the provide buffer
> >=20
> > nit: "encode_OID()"
>
> will fix.
>
> > https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
> >=20
> > > + * @oid: The OID to encode
> > > + * @buffer: The buffer to encode to
> > > + * @bufsize: the maximum size of the buffer
> >=20
> > Align with tab characters.
>
> The kernel convention is to follow the style in the file, which isn't
> currently tab aligned.
>
> > Hmm just for sake of consistency s/the/The/
>
> Yes, sure.
>
> > > + *
> > > + * Returns: negative error or encoded size in the buffer.
> >=20
> > "Return:"
> >=20
> > > + */
> > > +ssize_t encode_OID(enum OID oid, u8 *buffer, size_t bufsize)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int oid_size;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(oid >=3D OID__NR);
> >=20
> > Please use neither WARN's nor BUG_ON's as some sort of assertions.
> >=20
> > It neither need pr_err() given it has enum type which AFAIK will
> > be detected by static analysis, but at most pr_err().
>
> So this also is the style of the file.  It seems to be because the
> internal OID enum is always a fed in constant from kernel code (no user
> space exposure) so it's designed to trip in a developer test boot to
> alert the developer to bad code.
>
> >=20
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0oid_size =3D oid_index[oid=
 + 1] - oid_index[oid];
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bufsize < oid_size + 2=
)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> >=20
> > Hmm... maybe -E2BIG? It would overflow.
>
> Technically it's an underflow (provided buffer is too small) and we
> don't have an E2SMALL error ...

Let's stick to -EINVAL.

>
> > Here it would make actually sense since it is not enum typed
> > parameter to issue pr_err() because it is clearly a programming
> > error.
>
> Sure, I can add that.
>
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buffer[0] =3D _tag(UNIV, P=
RIM, OID);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buffer[1] =3D oid_size;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(&buffer[2], &oid_da=
ta[oid_index[oid]], oid_size);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return oid_size + 2;
> > > +}
> > > +EXPORT_SYMBOL_GPL(encode_OID);
> >=20
> > Yep, makes more sense than the old code for sure.
>
> Thanks,
>
> James

Yeah, this is definitely something that can be picked as soon as
it is done!

BR, Jarkko

