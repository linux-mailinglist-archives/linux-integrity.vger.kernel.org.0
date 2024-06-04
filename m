Return-Path: <linux-integrity+bounces-2784-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A978FBA3B
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D465F1F21FF9
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B6D14900F;
	Tue,  4 Jun 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMBRd5T7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E214431C;
	Tue,  4 Jun 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521837; cv=none; b=syGVlQECu25Z0221Z56UgkJmBJEdpFVKm48UodgZFnJ2MJ6WC7njM7IEc898uzaHznfezJMhuXaYi5rjjvxSLHS33hB4CGUxsJiytLdrXFyzZwQpcec+aYvWXxfUNmcu+8Oq3t7AemSfF+5sCRPoN+qhRKuSxZt3xhrs67rUu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521837; c=relaxed/simple;
	bh=3kgT6Sk5v04z/yQNVd4oaHeoKPsWkyHCa0V+u+actBI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nADucte/C02+WXXk9Woggq1MqvMkdhfg5bcsUnu7RQ2wQXlfCBiCbBYNBqImJyiD/PCSW+hBw4FvTdlua9J0+uT4vQXXlLXoMuyrlJWfJDIO1t6Tx9zuBRbJIdKFe0bT+z/e3g5so+9GrmWS+ovjdUoa9/cwsGw5xwd9gTnPN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMBRd5T7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB6CC2BBFC;
	Tue,  4 Jun 2024 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717521837;
	bh=3kgT6Sk5v04z/yQNVd4oaHeoKPsWkyHCa0V+u+actBI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WMBRd5T7xk//pr/ZqHuYvOnFy7JcfvSQKC+e3osM5W2fzH/N3GSn/KkwjlQj062A0
	 VIcgK7P/PeEdjwyThEFd1HNkw3Qu9DjIEpZXOt6L3Xq3H/3eUUSzYQ+UhGNAO2++T6
	 6jzKoIx1wnzkKyBOwNvkuw67E/K6AE8lhaGFg6bDE18LLcunJZc3D8fHm0yrL+jmA5
	 dqsLX7+9v+iksjJM/x9pQboiF/PfihJXdYiDurDla1B+tclg/W9NHwB2MMUZ7wh4ex
	 ELZHkAYfEK1wjxr86reqOFsFZS1wpL9Vj9taXf0H9iKFd2WX4VXTqtL+KsQElaKyiF
	 fyz8jgt4WUK0A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 20:23:51 +0300
Message-Id: <D1REOCZ2XHRY.4U47RZ20QET1@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Lennart Poettering" <lennart@poettering.net>, "David S. Miller"
 <davem@davemloft.net>, "open list" <linux-kernel@vger.kernel.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] crypto: tpm2_key: Introduce a TPM2 key type
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-4-jarkko@kernel.org>
 <97dd7485-51bf-4e47-83ab-957710fc2182@linux.ibm.com>
In-Reply-To: <97dd7485-51bf-4e47-83ab-957710fc2182@linux.ibm.com>

On Fri May 31, 2024 at 3:35 AM EEST, Stefan Berger wrote:
>
>
> On 5/28/24 17:08, Jarkko Sakkinen wrote:
> > TPM2 ASN.1 format is required for trusted keys and asymmetric keys. Mov=
e it
> > to crypto in order to make it available for both. Implement validation =
with
> > coverage of all TPMT_PUBLIC shared fields. Key type specific fields mus=
t be
> > covered by the different subsystems using this.
> >=20
> > A Kconfig option CRYPTO_TPM2_KEY can be used to select the feature, whi=
ch
> > depends only crypto subsystem itself and ASN.1 parser.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v6:
> > * Relocate to crypto. Validate the shared part and provide
> >    accessor functions. Use a fixed buffer size.
> > v2:
> > * Do not allocate blob twice. Use the one inside struct tpm2_key.
> > ---
> >   crypto/Kconfig                            |   7 ++
> >   crypto/Makefile                           |   6 +
> >   crypto/tpm2_key.asn1                      |  11 ++
> >   crypto/tpm2_key.c                         | 134 ++++++++++++++++++++
> >   include/crypto/tpm2_key.h                 |  46 +++++++
> >   security/keys/trusted-keys/Kconfig        |   2 +-
> >   security/keys/trusted-keys/Makefile       |   2 -
> >   security/keys/trusted-keys/tpm2key.asn1   |  11 --
> >   security/keys/trusted-keys/trusted_tpm2.c | 141 +++++----------------=
-
> >   9 files changed, 235 insertions(+), 125 deletions(-)
> >   create mode 100644 crypto/tpm2_key.asn1
> >   create mode 100644 crypto/tpm2_key.c
> >   create mode 100644 include/crypto/tpm2_key.h
> >   delete mode 100644 security/keys/trusted-keys/tpm2key.asn1
> >=20
> > diff --git a/crypto/Kconfig b/crypto/Kconfig
> > index 5688d42a59c2..c8989bc71f57 100644
> > --- a/crypto/Kconfig
> > +++ b/crypto/Kconfig
> > @@ -5,6 +5,13 @@
> >   config XOR_BLOCKS
> >   	tristate
> >  =20
> > +config CRYPTO_TPM2_KEY
> > +	bool
> > +	depends on CRYPTO
> > +	select ASN1
> > +	select OID_REGISTRY
> > +	default n
> > +
> >   #
> >   # async_tx api: hardware offloaded memory transfer/transform support
> >   #
> > diff --git a/crypto/Makefile b/crypto/Makefile
> > index edbbaa3ffef5..d932fdb72319 100644
> > --- a/crypto/Makefile
> > +++ b/crypto/Makefile
> > @@ -216,3 +216,9 @@ obj-$(CONFIG_CRYPTO_SIMD) +=3D crypto_simd.o
> >   # Key derivation function
> >   #
> >   obj-$(CONFIG_CRYPTO_KDF800108_CTR) +=3D kdf_sp800108.o
> > +
> > +ifdef CONFIG_CRYPTO_TPM2_KEY
> > +$(obj)/tpm2_key.asn1.o: $(obj)/tpm2_key.asn1.h $(obj)/tpm2_key.asn1.c
> > +$(obj)/tpm2_key.o: $(obj)/tpm2_key.asn1.h
> > +obj-y +=3D tpm2_key.o tpm2_key.asn1.o
> > +endif
> > diff --git a/crypto/tpm2_key.asn1 b/crypto/tpm2_key.asn1
> > new file mode 100644
> > index 000000000000..b235d02ab78e
> > --- /dev/null
> > +++ b/crypto/tpm2_key.asn1
> > @@ -0,0 +1,11 @@
> > +---
> > +--- ASN.1 for TPM 2.0 keys
> > +---
> > +
> > +TPMKey ::=3D SEQUENCE {
> > +	type		OBJECT IDENTIFIER ({tpm2_key_get_type}),
> > +	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> > +	parent		INTEGER ({tpm2_key_get_parent}),
> > +	pubkey		OCTET STRING ({tpm2_get_public}),
> > +	privkey		OCTET STRING ({tpm2_get_private})
> > +	}
> > diff --git a/crypto/tpm2_key.c b/crypto/tpm2_key.c
> > new file mode 100644
> > index 000000000000..78f55478d046
> > --- /dev/null
> > +++ b/crypto/tpm2_key.c
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <crypto/tpm2_key.h>
> > +#include <linux/oid_registry.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <asm/unaligned.h>
> > +#include "tpm2_key.asn1.h"
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) "tpm2_key: "fmt
> > +
> > +struct tpm2_key_decoder_context {
> > +	u32 parent;
> > +	const u8 *pub;
> > +	u32 pub_len;
> > +	const u8 *priv;
> > +	u32 priv_len;
> > +	enum OID oid;
> > +};
> > +
> > +int tpm2_key_get_parent(void *context, size_t hdrlen,
> > +			unsigned char tag,
> > +			const void *value, size_t vlen)
> > +{
> > +	struct tpm2_key_decoder_context *decoder =3D context;
> > +	const u8 *v =3D value;
> > +	int i;
> > +
> > +	decoder->parent =3D 0;
> > +	for (i =3D 0; i < vlen; i++) {
> > +		decoder->parent <<=3D 8;
> > +		decoder->parent |=3D v[i];
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int tpm2_key_get_type(void *context, size_t hdrlen,
> > +		      unsigned char tag,
> > +		      const void *value, size_t vlen)
> > +{
> > +	struct tpm2_key_decoder_context *decoder =3D context;
> > +
> > +	decoder->oid =3D look_up_OID(value, vlen);
> > +	return 0;
> > +}
> > +
> > +static inline bool tpm2_key_is_valid(const void *value, size_t vlen)
> > +{
> > +	if (vlen < 2 || vlen > TPM2_KEY_BYTES_MAX)
> > +		return false;
> > +
> > +	if (get_unaligned_be16(value) !=3D vlen - 2)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +int tpm2_get_public(void *context, size_t hdrlen, unsigned char tag,
> > +		    const void *value, size_t vlen)
> > +{
> > +	struct tpm2_key_decoder_context *decoder =3D context;
> > +
> > +	if (!tpm2_key_is_valid(value, vlen))
> > +		return -EBADMSG;
> > +
> > +	if (sizeof(struct tpm2_key_desc) > vlen - 2)
> > +		return -EBADMSG;
> > +
> > +	decoder->pub =3D value;
> > +	decoder->pub_len =3D vlen;
> > +	return 0;
> > +}
> > +
> > +int tpm2_get_private(void *context, size_t hdrlen, unsigned char tag,
> > +		     const void *value, size_t vlen)
> > +{
> > +	struct tpm2_key_decoder_context *decoder =3D context;
> > +
> > +	if (!tpm2_key_is_valid(value, vlen))
> > +		return -EBADMSG;
> > +
> > +	decoder->priv =3D value;
> > +	decoder->priv_len =3D vlen;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * tpm_key_decode() - Decode TPM2 ASN.1 key
> > + * @src:	ASN.1 source.
> > + * @src_len:	ASN.1 source length.
> > + *
> > + * Decodes the TPM2 ASN.1 key and validates that the public key data h=
as all
> > + * the shared fields of TPMT_PUBLIC. This is full coverage of the memo=
ry that
> > + * can be validated before doing any key type specific validation.
>
> I am not sure what the last sentence means.

I think the whole paragraph should be rewritten.

So what it does is that it takes the private and public parts and
concanates them together so maybe just write:

"Load TPMT_PUBLIC and TPMT_PRIVATE from ASN.1 file, and concatenate the
blobs together as a single blob, as this is expected format for the TPM2
commands. In addition, validate TPMT_PUBLIC fields so that they make
sense for trusted and asymmetric keys."

What you think of this?


>
> > + *
> > + * Return:
> > + * - TPM2 ASN.1 key on success.
> > + * - -EBADMSG when decoding fails.
> > + * - -ENOMEM when OOM while allocating struct tpm2_key.
> > + */
> > +struct tpm2_key *tpm2_key_decode(const u8 *src, u32 src_len)
> > +{
> > +	struct tpm2_key_decoder_context decoder;
> > +	struct tpm2_key *key;
> > +	u8 *data;
> > +	int ret;
> > +
> > +	memset(&decoder, 0, sizeof(decoder));
> > +	ret =3D asn1_ber_decoder(&tpm2_key_decoder, &decoder, src, src_len);
> > +	if (ret < 0) {
> > +		if (ret !=3D -EBADMSG)
> > +			pr_info("Decoder error %d\n", ret);
> > +
> > +		return ERR_PTR(-EBADMSG);
> > +	}
> > +
> > +	key =3D kzalloc(sizeof(*key), GFP_KERNEL);
> > +	if (!key)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	data =3D &key->data[0];
> > +	memcpy(&data[0], decoder.priv, decoder.priv_len);
> > +	memcpy(&data[decoder.priv_len], decoder.pub, decoder.pub_len);
> > +
> > +	key->oid =3D decoder.oid;
> > +	key->priv_len =3D decoder.priv_len;
> > +	key->pub_len =3D decoder.pub_len;
> > +	key->parent =3D decoder.parent;
> > +	key->desc =3D (struct tpm2_key_desc *)&data[decoder.priv_len + 2];
> > +	return key;
> > +}
> > +EXPORT_SYMBOL_GPL(tpm2_key_decode);
> > diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
> > new file mode 100644
> > index 000000000000..74debaf707bf
> > --- /dev/null
> > +++ b/include/crypto/tpm2_key.h
> > @@ -0,0 +1,46 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __LINUX_TPM2_KEY_H__
> > +#define __LINUX_TPM2_KEY_H__
> > +
> > +#include <linux/oid_registry.h>
> > +#include <linux/slab.h>
> > +
> > +#define TPM2_KEY_BYTES_MAX 1024
> > +
> > +/*  TPM2 Structures 12.2.4: TPMT_PUBLIC */
> > +struct tpm2_key_desc {
> > +	__be16 type;
> > +	__be16 name_alg;
> > +	__be32 object_attributes;
> > +	__be16 policy_size;
> > +} __packed;
> > +
> > +/* Decoded TPM2 ASN.1 key. */
> > +struct tpm2_key {
> > +	u8 data[2 * TPM2_KEY_BYTES_MAX];
> > +	struct tpm2_key_desc *desc;
> > +	u16 priv_len;
> > +	u16 pub_len;
> > +	u32 parent;
> > +	enum OID oid;
> > +	char oid_str[64];
> > +};
> > +
> > +struct tpm2_key *tpm2_key_decode(const u8 *src, u32 src_len);
> > +
> > +static inline const void *tpm2_key_data(const struct tpm2_key *key)
> > +{
> > +	return &key->data[0];
> > +}
> > +
> > +static inline u16 tpm2_key_type(const struct tpm2_key *key)
> > +{
> > +	return be16_to_cpu(key->desc->type);
> > +}
> > +
> > +static inline int tpm2_key_policy_size(const struct tpm2_key *key)
> > +{
> > +	return be16_to_cpu(key->desc->policy_size);
> > +}
> > +
> > +#endif /* __LINUX_TPM2_KEY_H__ */
> > diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted=
-keys/Kconfig
> > index 1fb8aa001995..00d9489384ac 100644
> > --- a/security/keys/trusted-keys/Kconfig
> > +++ b/security/keys/trusted-keys/Kconfig
> > @@ -9,9 +9,9 @@ config TRUSTED_KEYS_TPM
> >   	select CRYPTO_HMAC
> >   	select CRYPTO_SHA1
> >   	select CRYPTO_HASH_INFO
> > +	select CRYPTO_TPM2_KEY
> >   	select ASN1_ENCODER
> >   	select OID_REGISTRY
> > -	select ASN1
> >   	select HAVE_TRUSTED_KEYS
> >   	help
> >   	  Enable use of the Trusted Platform Module (TPM) as trusted key
> > diff --git a/security/keys/trusted-keys/Makefile b/security/keys/truste=
d-keys/Makefile
> > index f0f3b27f688b..2674d5c10fc9 100644
> > --- a/security/keys/trusted-keys/Makefile
> > +++ b/security/keys/trusted-keys/Makefile
> > @@ -7,9 +7,7 @@ obj-$(CONFIG_TRUSTED_KEYS) +=3D trusted.o
> >   trusted-y +=3D trusted_core.o
> >   trusted-$(CONFIG_TRUSTED_KEYS_TPM) +=3D trusted_tpm1.o
> >  =20
> > -$(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
> >   trusted-$(CONFIG_TRUSTED_KEYS_TPM) +=3D trusted_tpm2.o
> > -trusted-$(CONFIG_TRUSTED_KEYS_TPM) +=3D tpm2key.asn1.o
> >  =20
> >   trusted-$(CONFIG_TRUSTED_KEYS_TEE) +=3D trusted_tee.o
> >  =20
> > diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/tr=
usted-keys/tpm2key.asn1
> > deleted file mode 100644
> > index f57f869ad600..000000000000
> > --- a/security/keys/trusted-keys/tpm2key.asn1
> > +++ /dev/null
> > @@ -1,11 +0,0 @@
> > ----
> > ---- ASN.1 for TPM 2.0 keys
> > ----
> > -
> > -TPMKey ::=3D SEQUENCE {
> > -	type		OBJECT IDENTIFIER ({tpm2_key_type}),
> > -	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> > -	parent		INTEGER ({tpm2_key_parent}),
> > -	pubkey		OCTET STRING ({tpm2_key_pub}),
> > -	privkey		OCTET STRING ({tpm2_key_priv})
> > -	}
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/=
trusted-keys/trusted_tpm2.c
> > index 06c8fa7b21ae..b9e505e99e8c 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -13,11 +13,10 @@
> >  =20
> >   #include <keys/trusted-type.h>
> >   #include <keys/trusted_tpm.h>
> > +#include <crypto/tpm2_key.h>
> >  =20
> >   #include <asm/unaligned.h>
> >  =20
> > -#include "tpm2key.asn1.h"
> > -
> >   static struct tpm2_hash tpm2_hash_map[] =3D {
> >   	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> >   	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> > @@ -98,106 +97,6 @@ static int tpm2_key_encode(struct trusted_key_paylo=
ad *payload,
> >   	return ret;
> >   }
> >  =20
> > -struct tpm2_key_context {
> > -	u32 parent;
> > -	const u8 *pub;
> > -	u32 pub_len;
> > -	const u8 *priv;
> > -	u32 priv_len;
> > -};
> > -
> > -static int tpm2_key_decode(struct trusted_key_payload *payload,
> > -			   struct trusted_key_options *options,
> > -			   u8 **buf)
> > -{
> > -	int ret;
> > -	struct tpm2_key_context ctx;
> > -	u8 *blob;
> > -
> > -	memset(&ctx, 0, sizeof(ctx));
> > -
> > -	ret =3D asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
> > -			       payload->blob_len);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> > -		return -E2BIG;
> > -
> > -	blob =3D kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> > -	if (!blob)
> > -		return -ENOMEM;
> > -
> > -	*buf =3D blob;
> > -	options->keyhandle =3D ctx.parent;
> > -
> > -	memcpy(blob, ctx.priv, ctx.priv_len);
> > -	blob +=3D ctx.priv_len;
> > -
> > -	memcpy(blob, ctx.pub, ctx.pub_len);
> > -
> > -	return 0;
> > -}
> > -
> > -int tpm2_key_parent(void *context, size_t hdrlen,
> > -		  unsigned char tag,
> > -		  const void *value, size_t vlen)
> > -{
> > -	struct tpm2_key_context *ctx =3D context;
> > -	const u8 *v =3D value;
> > -	int i;
> > -
> > -	ctx->parent =3D 0;
> > -	for (i =3D 0; i < vlen; i++) {
> > -		ctx->parent <<=3D 8;
> > -		ctx->parent |=3D v[i];
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -int tpm2_key_type(void *context, size_t hdrlen,
> > -		unsigned char tag,
> > -		const void *value, size_t vlen)
> > -{
> > -	enum OID oid =3D look_up_OID(value, vlen);
> > -
> > -	if (oid !=3D OID_TPMSealedData) {
> > -		char buffer[50];
> > -
> > -		sprint_oid(value, vlen, buffer, sizeof(buffer));
> > -		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
> > -			 buffer);
> > -		return -EINVAL;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -int tpm2_key_pub(void *context, size_t hdrlen,
> > -	       unsigned char tag,
> > -	       const void *value, size_t vlen)
> > -{
> > -	struct tpm2_key_context *ctx =3D context;
> > -
> > -	ctx->pub =3D value;
> > -	ctx->pub_len =3D vlen;
> > -
> > -	return 0;
> > -}
> > -
> > -int tpm2_key_priv(void *context, size_t hdrlen,
> > -		unsigned char tag,
> > -		const void *value, size_t vlen)
> > -{
> > -	struct tpm2_key_context *ctx =3D context;
> > -
> > -	ctx->priv =3D value;
> > -	ctx->priv_len =3D vlen;
> > -
> > -	return 0;
> > -}
> > -
> >   /**
> >    * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
> >    *
> > @@ -387,22 +286,43 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> >   			 struct trusted_key_options *options,
> >   			 u32 *blob_handle)
> >   {
> > -	struct tpm_buf buf;
> >   	unsigned int private_len;
> >   	unsigned int public_len;
> >   	unsigned int blob_len;
> > -	u8 *blob, *pub;
> > -	int rc;
> > +	struct tpm2_key *key;
> > +	const u8 *blob, *pub;
> > +	struct tpm_buf buf;
> >   	u32 attrs;
> > +	int rc;
> >  =20
> > -	rc =3D tpm2_key_decode(payload, options, &blob);
> > -	if (rc) {
> > -		/* old form */
> > +	key =3D tpm2_key_decode(payload->blob, payload->blob_len);
> > +	if (IS_ERR(key)) {
> > +		/* Get the error code and reset the pointer to the key: */
> > +		rc =3D PTR_ERR(key);
> > +		key =3D NULL;
> > +
> > +		if (rc =3D=3D -ENOMEM)
> > +			return -ENOMEM;
> > +
> > +		/* A sanity check, as only -EBADMSG or -ENOMEM are expected: */
> > +		if (rc !=3D -EBADMSG)
> > +			pr_err("tpm2_key_decode(): spurious error code %d\n", rc);
>
> tpm2_key_decode seems simple enough that it only returns key, -ENOMEM or=
=20
> EBADMSG.

So what is your suggestion here?

The reasoning here is that asymmetric keys use -EBADMSG not only as
error but also iterator, when probing which can load a specific key.

>
> > +
> > +		/* Fallback to the legacy format: */
> >   		blob =3D payload->blob;
> >   		payload->old_format =3D 1;
> > +	} else {
> > +		blob =3D tpm2_key_data(key);
> > +		if (key->oid !=3D OID_TPMSealedData) {
> > +			kfree(key);
> > +			return -EBADMSG;
> > +		}
> >   	}
> >  =20
> > -	/* new format carries keyhandle but old format doesn't */
> > +	/*
> > +	 * Must be non-zero here, either extracted from the ASN.1 for the new
> > +	 * format or specified on the command line for the old.
>
> sentence seems incomplete: ... for the old one.  OR  ... for the old form=
at.

Yep, I think it is a plain mistake.

>
> > +	 */
> >   	if (!options->keyhandle)
> >   		return -EINVAL;
> >  =20
> > @@ -464,8 +384,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> >   			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
> >  =20
> >   out:
> > -	if (blob !=3D payload->blob)
> > -		kfree(blob);
> > +	kfree(key);
> >   	tpm_buf_destroy(&buf);
> >  =20
> >   	if (rc > 0)

Thanks for the feedback.

BR, Jarkko

