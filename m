Return-Path: <linux-integrity+bounces-2619-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F798CE697
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 16:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B918B281F9B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C3B86636;
	Fri, 24 May 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Bo5v4HE7";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Bo5v4HE7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340F86255;
	Fri, 24 May 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559332; cv=none; b=KF/z15hv6rA6vTihTHvS3/fEZviXGaCi/qyzhKM+AHso624JGs6y0Xqr8DBpXpUyhsRMe281PPvHCHMYgn/3lZZxYX/4r+niBQNuCdrbkuZlNmBDtIvBlc8N2Rm5G1xSESbCcirGv5daRQIeHeKcGBWe733GDDpShCU3kCzMcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559332; c=relaxed/simple;
	bh=5OOU+ylEr+AfliAjWmkPcq32b+EP3ZzOOf55RfQSoRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tg2JN3XcV6tj6ZRLXe+sdkzec4yIYGfNgKC5usS7OgQF4FZ8ZQbJYvbCFqwKqJx0a/hyJAAOao0SE96Tu2xp/mJiDxIoWTgW7raFx0yxjS9IqKZ2agiAS5aO8EVC3nhoIRlSfxJzvVdQCmMw9K+2WHQxXLKXcs7QY1NVRvKOvr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Bo5v4HE7; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Bo5v4HE7; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716559330;
	bh=5OOU+ylEr+AfliAjWmkPcq32b+EP3ZzOOf55RfQSoRA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Bo5v4HE7dwuQLqBl8XziEehm88GkCH2G8PWj11VyzuT+udeLSOtnijB2e1A4rNhzy
	 iIpZ7Zx1b4UUIRijvXOVehZWcvrAkFVw5To4hDaG+8McDRo7A9iLl6ygmSs9iz+9l+
	 KpLpZsXCJyM504AVLhOzDkIC/bWcw/GzYE1uw2P0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5CCD6128741E;
	Fri, 24 May 2024 10:02:10 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 9dwCiE1V1Xen; Fri, 24 May 2024 10:02:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716559330;
	bh=5OOU+ylEr+AfliAjWmkPcq32b+EP3ZzOOf55RfQSoRA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Bo5v4HE7dwuQLqBl8XziEehm88GkCH2G8PWj11VyzuT+udeLSOtnijB2e1A4rNhzy
	 iIpZ7Zx1b4UUIRijvXOVehZWcvrAkFVw5To4hDaG+8McDRo7A9iLl6ygmSs9iz+9l+
	 KpLpZsXCJyM504AVLhOzDkIC/bWcw/GzYE1uw2P0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C3978128741B;
	Fri, 24 May 2024 10:02:09 -0400 (EDT)
Message-ID: <7f37bebce37c4bb3b91899629b458762cd34d040.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3] lib/oid_registry: add ability to ASN.1 encode OIDs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date: Fri, 24 May 2024 10:02:08 -0400
In-Reply-To: <D1HWWX4G4ZOO.2UBZQ3L4225UM@kernel.org>
References: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
	 <20240524125955.20739-2-James.Bottomley@HansenPartnership.com>
	 <D1HWWX4G4ZOO.2UBZQ3L4225UM@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-05-24 at 16:34 +0300, Jarkko Sakkinen wrote:
> On Fri May 24, 2024 at 3:59 PM EEST, James Bottomley wrote:
[...]
> > diff --git a/include/linux/oid_registry.h
> > b/include/linux/oid_registry.h
> > index 51421fdbb0ba..87a6bcb2f5c0 100644
> > --- a/include/linux/oid_registry.h
> > +++ b/include/linux/oid_registry.h
> > @@ -151,5 +151,6 @@ extern enum OID look_up_OID(const void *data,
> > size_t datasize);
> >  extern int parse_OID(const void *data, size_t datasize, enum OID
> > *oid);
> >  extern int sprint_oid(const void *, size_t, char *, size_t);
> >  extern int sprint_OID(enum OID, char *, size_t);
> > +extern ssize_t encode_OID(enum OID, u8 *, size_t);
> >  
> >  #endif /* _LINUX_OID_REGISTRY_H */
> > diff --git a/lib/oid_registry.c b/lib/oid_registry.c
> > index fe6705cfd780..adbc287875c1 100644
> > --- a/lib/oid_registry.c
> > +++ b/lib/oid_registry.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/bug.h>
> >  #include <linux/asn1.h>
> > +#include <linux/asn1_ber_bytecode.h>
> >  #include "oid_registry_data.c"
> >  
> >  MODULE_DESCRIPTION("OID Registry");
> > @@ -196,3 +197,31 @@ int sprint_OID(enum OID oid, char *buffer,
> > size_t bufsize)
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(sprint_OID);
> > +
> > +/**
> > + * encode_OID - embed an ASN.1 encoded OID in the provide buffer
> 
> nit: "encode_OID()"

will fix.

> https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
> 
> > + * @oid: The OID to encode
> > + * @buffer: The buffer to encode to
> > + * @bufsize: the maximum size of the buffer
> 
> Align with tab characters.

The kernel convention is to follow the style in the file, which isn't
currently tab aligned.

> Hmm just for sake of consistency s/the/The/

Yes, sure.

> > + *
> > + * Returns: negative error or encoded size in the buffer.
> 
> "Return:"
> 
> > + */
> > +ssize_t encode_OID(enum OID oid, u8 *buffer, size_t bufsize)
> > +{
> > +       int oid_size;
> > +
> > +       BUG_ON(oid >= OID__NR);
> 
> Please use neither WARN's nor BUG_ON's as some sort of assertions.
> 
> It neither need pr_err() given it has enum type which AFAIK will
> be detected by static analysis, but at most pr_err().

So this also is the style of the file.  It seems to be because the
internal OID enum is always a fed in constant from kernel code (no user
space exposure) so it's designed to trip in a developer test boot to
alert the developer to bad code.

> 
> 
> > +
> > +       oid_size = oid_index[oid + 1] - oid_index[oid];
> > +
> > +       if (bufsize < oid_size + 2)
> > +               return -EINVAL;
> 
> Hmm... maybe -E2BIG? It would overflow.

Technically it's an underflow (provided buffer is too small) and we
don't have an E2SMALL error ...

> Here it would make actually sense since it is not enum typed
> parameter to issue pr_err() because it is clearly a programming
> error.

Sure, I can add that.

> > +
> > +       buffer[0] = _tag(UNIV, PRIM, OID);
> > +       buffer[1] = oid_size;
> > +
> > +       memcpy(&buffer[2], &oid_data[oid_index[oid]], oid_size);
> > +
> > +       return oid_size + 2;
> > +}
> > +EXPORT_SYMBOL_GPL(encode_OID);
> 
> Yep, makes more sense than the old code for sure.

Thanks,

James


