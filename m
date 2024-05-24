Return-Path: <linux-integrity+bounces-2621-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 568ED8CE6FD
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 16:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906C9B20B37
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE04586279;
	Fri, 24 May 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4OE4A8n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C257886262;
	Fri, 24 May 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560941; cv=none; b=hcATCuRX2zfK62jGAW7K9/PYTnVv7dlzG416v0jBIAQ8AarlOFrgUumJiuZkERawruMSaPc9ojAN7rlBsA850NA8PPoZwm12/2qXE5POqAO5dew45LHCZ0JhTM0dC4YQ2SnJlr4f+fc2rX3W2O8kQjijvVybHtcyStnM/LVqhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560941; c=relaxed/simple;
	bh=qP+QIHUAqIQ+G9J6+1L30GluLKN2YZ2B28I2YlJfJPA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=c/rCghdJi9SBjnDCfTIN3+kVqTFnZWdzsbduYuj8qgra+3ocK0jU43rGwtghsny0lJbeVpkyAB+/KUaKS2koX5VLOm0G9W64hNIbEayhYdsQJ8bSCHl7q85i51Q4I1/guw+sCEX+bGd+gpEF91J7uf/YdYJst9gDQiEg5k5h4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4OE4A8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC43C2BBFC;
	Fri, 24 May 2024 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716560941;
	bh=qP+QIHUAqIQ+G9J6+1L30GluLKN2YZ2B28I2YlJfJPA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=m4OE4A8nRaO09kWJZwvZiLIE/zinWbpZM8cYHPz7ay1f+vehq49MamI4nc7/Q0Bfm
	 PCEwBkuSdPnfrtltX7opc/qrXN+l1pLLv6y0aQp2os0i43eh1pjKKoVgHPnIAETBuw
	 +c9w16ph8NFbTSXBZWMJYELOQjoCg8I5mA7WruEF1dCnznEFtPZc97npfSUZJIGsxy
	 5twLgM0GJ5SDX6qh589cOTu/ZZsTfh9VODHbvi7ZP4R1igBd3fslp98kQwMu9jfAag
	 9TxDG5z7daKn7tMLNZBzaZNnjGwui39IQcWoz5dlUULaG89VAPTJQjgOf8OHDvrdhc
	 nlDqHhVdRWpgw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 17:28:58 +0300
Message-Id: <D1HY2GM17A5X.2TPBRF5Q7DI90@kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] lib/oid_registry: add ability to ASN.1 encode OIDs
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
 <20240524125955.20739-2-James.Bottomley@HansenPartnership.com>
 <D1HWWX4G4ZOO.2UBZQ3L4225UM@kernel.org>
 <7f37bebce37c4bb3b91899629b458762cd34d040.camel@HansenPartnership.com>
 <D1HY0TSQHEZB.3AURD2JXPK0L0@kernel.org>
In-Reply-To: <D1HY0TSQHEZB.3AURD2JXPK0L0@kernel.org>

On Fri May 24, 2024 at 5:26 PM EEST, Jarkko Sakkinen wrote:
> On Fri May 24, 2024 at 5:02 PM EEST, James Bottomley wrote:
> > On Fri, 2024-05-24 at 16:34 +0300, Jarkko Sakkinen wrote:
> > > On Fri May 24, 2024 at 3:59 PM EEST, James Bottomley wrote:
> > [...]
> > > > diff --git a/include/linux/oid_registry.h
> > > > b/include/linux/oid_registry.h
> > > > index 51421fdbb0ba..87a6bcb2f5c0 100644
> > > > --- a/include/linux/oid_registry.h
> > > > +++ b/include/linux/oid_registry.h
> > > > @@ -151,5 +151,6 @@ extern enum OID look_up_OID(const void *data,
> > > > size_t datasize);
> > > > =C2=A0extern int parse_OID(const void *data, size_t datasize, enum =
OID
> > > > *oid);
> > > > =C2=A0extern int sprint_oid(const void *, size_t, char *, size_t);
> > > > =C2=A0extern int sprint_OID(enum OID, char *, size_t);
> > > > +extern ssize_t encode_OID(enum OID, u8 *, size_t);
> > > > =C2=A0
> > > > =C2=A0#endif /* _LINUX_OID_REGISTRY_H */
> > > > diff --git a/lib/oid_registry.c b/lib/oid_registry.c
> > > > index fe6705cfd780..adbc287875c1 100644
> > > > --- a/lib/oid_registry.c
> > > > +++ b/lib/oid_registry.c
> > > > @@ -12,6 +12,7 @@
> > > > =C2=A0#include <linux/errno.h>
> > > > =C2=A0#include <linux/bug.h>
> > > > =C2=A0#include <linux/asn1.h>
> > > > +#include <linux/asn1_ber_bytecode.h>
> > > > =C2=A0#include "oid_registry_data.c"
> > > > =C2=A0
> > > > =C2=A0MODULE_DESCRIPTION("OID Registry");
> > > > @@ -196,3 +197,31 @@ int sprint_OID(enum OID oid, char *buffer,
> > > > size_t bufsize)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > > =C2=A0}
> > > > =C2=A0EXPORT_SYMBOL_GPL(sprint_OID);
> > > > +
> > > > +/**
> > > > + * encode_OID - embed an ASN.1 encoded OID in the provide buffer
> > >=20
> > > nit: "encode_OID()"
> >
> > will fix.
> >
> > > https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
> > >=20
> > > > + * @oid: The OID to encode
> > > > + * @buffer: The buffer to encode to
> > > > + * @bufsize: the maximum size of the buffer
> > >=20
> > > Align with tab characters.
> >
> > The kernel convention is to follow the style in the file, which isn't
> > currently tab aligned.
> >
> > > Hmm just for sake of consistency s/the/The/
> >
> > Yes, sure.
> >
> > > > + *
> > > > + * Returns: negative error or encoded size in the buffer.
> > >=20
> > > "Return:"
> > >=20
> > > > + */
> > > > +ssize_t encode_OID(enum OID oid, u8 *buffer, size_t bufsize)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int oid_size;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(oid >=3D OID__NR)=
;
> > >=20
> > > Please use neither WARN's nor BUG_ON's as some sort of assertions.
> > >=20
> > > It neither need pr_err() given it has enum type which AFAIK will
> > > be detected by static analysis, but at most pr_err().
> >
> > So this also is the style of the file.  It seems to be because the
> > internal OID enum is always a fed in constant from kernel code (no user
> > space exposure) so it's designed to trip in a developer test boot to
> > alert the developer to bad code.
> >
> > >=20
> > >=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0oid_size =3D oid_index[o=
id + 1] - oid_index[oid];
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (bufsize < oid_size +=
 2)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > >=20
> > > Hmm... maybe -E2BIG? It would overflow.
> >
> > Technically it's an underflow (provided buffer is too small) and we
> > don't have an E2SMALL error ...
>
> Let's stick to -EINVAL.
>
> >
> > > Here it would make actually sense since it is not enum typed
> > > parameter to issue pr_err() because it is clearly a programming
> > > error.
> >
> > Sure, I can add that.
> >
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buffer[0] =3D _tag(UNIV,=
 PRIM, OID);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buffer[1] =3D oid_size;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(&buffer[2], &oid_=
data[oid_index[oid]], oid_size);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return oid_size + 2;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(encode_OID);
> > >=20
> > > Yep, makes more sense than the old code for sure.
> >
> > Thanks,
> >
> > James
>
> Yeah, this is definitely something that can be picked as soon as
> it is done!

Yeah, and other series definitely worth of *eventually* taking in
most likely :-) Don't mean to be impolite but I think it is more
fair to say that you're ignoring something now, than just ignore
it.

BR, Jarkko

