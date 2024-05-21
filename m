Return-Path: <linux-integrity+bounces-2531-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92908CB552
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 23:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822012837EA
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9381256440;
	Tue, 21 May 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3KCaWSK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B151EB2F;
	Tue, 21 May 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716326239; cv=none; b=qTKQRJsgpk5DBHpoOG6HbkrT6+d0QhRb+KVHMPFV3cRyLDJ5Me3+xpVrJzsiA/OSICQwHPYukm2FJNGhnnA9zrqb0v0scsKpyRoh1JFpGRlojcwfnEyDZGt+ZxdAccEiZgcNWLGVtuviOWD9aVWmGM5Ryc2MIqxomH2YWFkKanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716326239; c=relaxed/simple;
	bh=RJqD7WEQOpBw7+L+o4xmUJtf1B8VRQenxyV5ITvcpK0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BFaaqwQrGA17kk2QYZLbO9SyllT4XkoeJIuazDrXbrvxx04vKvRa7kxm6a6SaETCd5eO6+Jng01saU9i1fTjEGylf+cbUUvYfiy6kuSbF9T0Y/H/C2byZdQWas/CDqInm1YxnNnna9qBCTFvfP+oOlYqFhNPzJz2tW7G/DzCXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3KCaWSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23775C2BD11;
	Tue, 21 May 2024 21:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716326239;
	bh=RJqD7WEQOpBw7+L+o4xmUJtf1B8VRQenxyV5ITvcpK0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=k3KCaWSKyNRQJDQWJHQ6BKqd3OAvMvZxvcQ9PjaWUkf64mzmIdVQS4ebKpqgJAVis
	 FvBVM7OOm1jmD3f4g8B40mH049E+XFeiwKb3GWoFufozpfb+SY8ZqUkeS3PFIfisoW
	 ZPXTSmL8BPlGCZuXKlVLdewwoCho+bYJbuU5MG60NcOpMk7AvXXVLPeywWc7WCKfgh
	 rlvL76Yqhmp/HBdYLH/yhM8qsuV09xjKPlDzjffDABxHuDhm1YYhTzGjOTcougTI/L
	 uWGKKTVBfuJ6vXTihW8buKM/cMZI8iJhfkBfBrOrtroRxk1kSUtaCK+CkFJWUuAeL7
	 OZqKT+eXZoqOw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 00:17:13 +0300
Message-Id: <D1FMVEJWGLEW.14QGHPAYPHQG1@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "David S. Miller" <davem@davemloft.net>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] KEYS: trusted: Move tpm2_key_decode() to the TPM
 driver
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-5-jarkko@kernel.org>
 <cc3d952f8295b52b052fbffe009b796ffb45707a.camel@HansenPartnership.com>
In-Reply-To: <cc3d952f8295b52b052fbffe009b796ffb45707a.camel@HansenPartnership.com>

On Tue May 21, 2024 at 9:18 PM EEST, James Bottomley wrote:
> On Tue, 2024-05-21 at 06:16 +0300, Jarkko Sakkinen wrote:
> [...]
> > diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
> > new file mode 100644
> > index 000000000000..acf41b2e0c92
> > --- /dev/null
> > +++ b/include/crypto/tpm2_key.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __LINUX_TPM2_KEY_H__
> > +#define __LINUX_TPM2_KEY_H__
> > +
> > +#include <linux/slab.h>
> > +
> > +/*
> > + * TPM2 ASN.1 key
> > + */
> > +struct tpm2_key {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 parent;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const u8 *blob;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 blob_len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const u8 *pub;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 pub_len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const u8 *priv;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 priv_len;
> > +};
> > +
> > +int tpm2_key_decode(const u8 *src, u32 src_len, struct tpm2_key
> > *key,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 max_key_len);
>
> I don't think this is a good idea.  Trusted keys already have a pre-
> defined max payload size (MAX_BLOB_SIZE in include/keys/trusted-type.h)
> and I've already had to increase this several times because once you
> get policy attached to a key, it can get pretty big (over a page).=20
> Exactly the same thing will happen to asymmetric keys as well, so it
> does make sense that they share the same maximum (probably in a more
> generic header, though).

ECDSA and RSA have different space requirements. With that solution you
actually max out space requirements given same cap for everything.

Even tpm2_key_ecdsa should use a different value than tpm2_key_rsa to
save memory.

> Since the code already right sizes the allocation and all we check with
> this is whether it's over a pre-defined maximum, it's way easier if
> that maximum is defined in a header rather than passed in in several
> places making increasing the maximum really hard because you have to
> chase all the threading.

You don't save a single byte of memory with any constant that dictates
the size requirements for multiple modules in two disjoint subsystems.

You are maximizing the use of memory.

> James

BR, Jarkko

