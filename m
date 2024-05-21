Return-Path: <linux-integrity+bounces-2528-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44478CB368
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 20:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720FE1F22909
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B3A7EF18;
	Tue, 21 May 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="okvqzxgp";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="okvqzxgp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3F3D982;
	Tue, 21 May 2024 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315533; cv=none; b=mtMQFo6nbXzrXRPHbCit8oxyfbybC4MMV9JIEHxo/BXVjNJWmZqWxyJo/4cTIV0kF3uymLUiQiY6tuOyQbPfqUlilaw4DclQaV8derfmITmUAKoNjJdk76+YBM1su4ttKyiNcH0UvCXxcbkl66vWqRwEgSt6IqtqdhsOErHJ+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315533; c=relaxed/simple;
	bh=2/WNvNUaxZWBWFghnTzz7COI4nb5mN2JEaGF6GoBrSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ENw5Z1qCprjaqFu8l/O2VLE9PCXLg1/iIaKKCnSSudnRQLq2Dtmg8RNqaC3znQMj+tLilWfJg5PRuhcNa8W0LwvWXcPPh4Xzd3BDAORRYKc711DPEp+a/0QJ65H0hHL03hatcWYlfvnE/8Yp37l1iT7uzJRONsa5X/PFQKxheyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=okvqzxgp; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=okvqzxgp; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716315529;
	bh=2/WNvNUaxZWBWFghnTzz7COI4nb5mN2JEaGF6GoBrSg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=okvqzxgpTRIrIDxwVOWW9RZLReb/uwFXXxGhf6NhiUFe5cd2R2pAvrywW4gN1QBJG
	 GBilIfhWNh1rPu6RHKi88EY+5VrHB5atLe3SPchZiFN0RngFBaGRDfjkunvWK1/oFl
	 I8ho0o3LMZMWxf1NzcocsSDud8C2Ty/Yk6jDBDLk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8D54A1286DC8;
	Tue, 21 May 2024 14:18:49 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id JesuGFsTjEfu; Tue, 21 May 2024 14:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716315529;
	bh=2/WNvNUaxZWBWFghnTzz7COI4nb5mN2JEaGF6GoBrSg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=okvqzxgpTRIrIDxwVOWW9RZLReb/uwFXXxGhf6NhiUFe5cd2R2pAvrywW4gN1QBJG
	 GBilIfhWNh1rPu6RHKi88EY+5VrHB5atLe3SPchZiFN0RngFBaGRDfjkunvWK1/oFl
	 I8ho0o3LMZMWxf1NzcocsSDud8C2Ty/Yk6jDBDLk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BD1251286DBE;
	Tue, 21 May 2024 14:18:47 -0400 (EDT)
Message-ID: <cc3d952f8295b52b052fbffe009b796ffb45707a.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 4/6] KEYS: trusted: Move tpm2_key_decode() to the TPM
 driver
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Herbert Xu
	 <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
 Andreas.Fuchs@infineon.com, James Prestwood <prestwoj@gmail.com>, David
 Woodhouse <dwmw2@infradead.org>, Eric Biggers <ebiggers@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>,  open list <linux-kernel@vger.kernel.org>,
 Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar
 <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Date: Tue, 21 May 2024 14:18:45 -0400
In-Reply-To: <20240521031645.17008-5-jarkko@kernel.org>
References: <20240521031645.17008-1-jarkko@kernel.org>
	 <20240521031645.17008-5-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-21 at 06:16 +0300, Jarkko Sakkinen wrote:
[...]
> diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
> new file mode 100644
> index 000000000000..acf41b2e0c92
> --- /dev/null
> +++ b/include/crypto/tpm2_key.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __LINUX_TPM2_KEY_H__
> +#define __LINUX_TPM2_KEY_H__
> +
> +#include <linux/slab.h>
> +
> +/*
> + * TPM2 ASN.1 key
> + */
> +struct tpm2_key {
> +       u32 parent;
> +       const u8 *blob;
> +       u32 blob_len;
> +       const u8 *pub;
> +       u32 pub_len;
> +       const u8 *priv;
> +       u32 priv_len;
> +};
> +
> +int tpm2_key_decode(const u8 *src, u32 src_len, struct tpm2_key
> *key,
> +                   u32 max_key_len);

I don't think this is a good idea.  Trusted keys already have a pre-
defined max payload size (MAX_BLOB_SIZE in include/keys/trusted-type.h)
and I've already had to increase this several times because once you
get policy attached to a key, it can get pretty big (over a page). 
Exactly the same thing will happen to asymmetric keys as well, so it
does make sense that they share the same maximum (probably in a more
generic header, though).

Since the code already right sizes the allocation and all we check with
this is whether it's over a pre-defined maximum, it's way easier if
that maximum is defined in a header rather than passed in in several
places making increasing the maximum really hard because you have to
chase all the threading.

James


