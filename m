Return-Path: <linux-integrity+bounces-3545-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A97976B52
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C34D1F22AB0
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB3E1AB6CB;
	Thu, 12 Sep 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRjZywS+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8EF17966F;
	Thu, 12 Sep 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149458; cv=none; b=g6ia/xLpn3AAt7RfsJc6pXekfBPemGDKHu8BiD6ue2qaejnxS14jDNtzKwXVl7N53yuYmLc/tFyirHYt1eTYteDhj2Kv0/Z+73/DGuZRgX/l+et4leBrpR2s8lr+o/VEyzwa0mdGBe1w4u+Kz3zdzCBwE8P8jY8FtJhUyMMsC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149458; c=relaxed/simple;
	bh=hpnmLUdj6I9Xqg7VTdRTBOJb3Q4SwLfnBPYrP2ZXgkA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=OrM5t+zHonVkkVB3YhxBzDXncDibH42oouJP7O/pqMEwXbdS1oqKe5u1cL8XSxkzOO3zmZ25qT8jzpbsbSez59tNOZA2lc5QFrQLcT47vvXHo9B84RrSlTEiq1zR+MtoubaC7dhAUXf8HIfqi/OhZO+/ignPnF/bPiSccwBktHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRjZywS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE00C4CEC3;
	Thu, 12 Sep 2024 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726149457;
	bh=hpnmLUdj6I9Xqg7VTdRTBOJb3Q4SwLfnBPYrP2ZXgkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRjZywS+WodpHyR2ZTTHa1WAmT1D5Gq6+2fkHV8dJHvxt1zPTKdS9h5kyFexLl34J
	 iwtr2QdqKjiAXhxXeXbigV3e4ByeW+8pT3daWAt7P2O9FMfavgIQHMVzfFdxYEU0xz
	 Xw+h28VlrlIFHx6zS7eX4sXEP66fBK4VCZIM6Ik/pONtKVEx5nLz9akKbJx1iBpRxH
	 gqaihUkZltBpowCGUUqvTuQDZeikiwH4RSSeoGZVLljvjKPzNgH87ek8aA91ix2YJH
	 /6X4jc2olP35HIvUXqCGtQt8ScmSEwiRYbHw2ZR77rPArbk1d2bM3VmoYK1zqyXU/n
	 6cYvqsKQO1OTQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Sep 2024 16:57:34 +0300
Message-Id: <D44CWVY4FZ00.2C7VG1HOAMQLD@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
 <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <torvalds@linux-foundation.org>,
 "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v3 04/14] PGPLIB: Basic packet parser
X-Mailer: aerc 0.18.2
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
 <20240911122911.1381864-5-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240911122911.1381864-5-roberto.sassu@huaweicloud.com>

On Wed Sep 11, 2024 at 3:29 PM EEST, Roberto Sassu wrote:
> From: David Howells <dhowells@redhat.com>
>
> Provide a simple parser that extracts the packets from a PGP packet blob
> and passes the desirous ones to the given processor function:
>
> 	struct pgp_parse_context {
> 		u64 types_of_interest;
> 		int (*process_packet)(struct pgp_parse_context *context,
> 				      enum pgp_packet_tag type,
> 				      u8 headerlen,
> 				      const u8 *data,
> 				      size_t datalen);
> 	};
>
> 	int pgp_parse_packets(const u8 *data, size_t datalen,
> 			      struct pgp_parse_context *ctx);
>
> This is configured on with CONFIG_PGP_LIBRARY.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  crypto/asymmetric_keys/Kconfig       |   6 +
>  crypto/asymmetric_keys/Makefile      |   5 +
>  crypto/asymmetric_keys/pgp_library.c | 262 +++++++++++++++++++++++++++
>  crypto/asymmetric_keys/pgplib.h      |  33 ++++
>  4 files changed, 306 insertions(+)
>  create mode 100644 crypto/asymmetric_keys/pgp_library.c
>  create mode 100644 crypto/asymmetric_keys/pgplib.h
>
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kcon=
fig
> index e1345b8f39f1..8215e3fcd8db 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -103,4 +103,10 @@ config FIPS_SIGNATURE_SELFTEST_ECDSA
>  	depends on CRYPTO_SHA256=3Dy || CRYPTO_SHA256=3DFIPS_SIGNATURE_SELFTEST
>  	depends on CRYPTO_ECDSA=3Dy || CRYPTO_ECDSA=3DFIPS_SIGNATURE_SELFTEST
> =20
> +config PGP_LIBRARY
> +	tristate "PGP parsing library"
> +	help
> +	  This option enables a library that provides a number of simple
> +	  utility functions for parsing PGP (RFC 9580) packet-based messages.
> +
>  endif # ASYMMETRIC_KEY_TYPE
> diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Mak=
efile
> index bc65d3b98dcb..055b28207111 100644
> --- a/crypto/asymmetric_keys/Makefile
> +++ b/crypto/asymmetric_keys/Makefile
> @@ -79,3 +79,8 @@ verify_signed_pefile-y :=3D \
> =20
>  $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
>  $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
> +
> +#
> +# PGP handling
> +#
> +obj-$(CONFIG_PGP_LIBRARY) +=3D pgp_library.o
> diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_key=
s/pgp_library.c
> new file mode 100644
> index 000000000000..1b87f8af411b
> --- /dev/null
> +++ b/crypto/asymmetric_keys/pgp_library.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* PGP packet parser (RFC 9580)
/*=20
 * PGP packet parser (RFC 9580)

> + *
> + * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#define pr_fmt(fmt) "PGPL: "fmt
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "pgplib.h"
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("PGP library");
> +
> +const char *const pgp_hash_algorithms[PGP_HASH__LAST] =3D {
> +	[PGP_HASH_MD5]			=3D "md5",
> +	[PGP_HASH_SHA1]			=3D "sha1",
> +	[PGP_HASH_RIPE_MD_160]		=3D "rmd160",
> +	[PGP_HASH_SHA256]		=3D "sha256",
> +	[PGP_HASH_SHA384]		=3D "sha384",
> +	[PGP_HASH_SHA512]		=3D "sha512",
> +	[PGP_HASH_SHA224]		=3D "sha224",
> +	[PGP_HASH_SHA3_256]		=3D "sha3-256",
> +	[PGP_HASH_SHA3_512]		=3D "sha3-512",
> +};
> +EXPORT_SYMBOL_GPL(pgp_hash_algorithms);
> +
> +/**
> + * pgp_parse_packet_header - Parse a PGP packet header
> + * @_data: Start of the PGP packet (updated to PGP packet data)
> + * @_datalen: Amount of data remaining in buffer (decreased)
> + * @_type: Where the packet type will be returned
> + * @_headerlen: Where the header length will be returned
> + *
> + * Parse a set of PGP packet header [RFC 9580: 4.2].
> + *
> + * Return: Packet data size on success; non-zero on error.  If successfu=
l,
> + * *_data and *_datalen will have been updated and *_headerlen will be s=
et to
> + * hold the length of the packet header.
> + */
> +static ssize_t pgp_parse_packet_header(const u8 **_data, size_t *_datale=
n,
> +				       enum pgp_packet_tag *_type,
> +				       u8 *_headerlen)
> +{
> +	enum pgp_packet_tag type;
> +	const u8 *data =3D *_data;
> +	size_t size, datalen =3D *_datalen;

Move the last declaration as the first declaration, makes more
readable (reverse christmas tree order).

I don't have time to go this patch fully for this round but I
saw some other similar nits below.

> +
> +	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
> +
> +	if (datalen < 2)
> +		goto short_packet;
> +
> +	pr_devel("pkthdr %02x, %02x\n", data[0], data[1]);
> +
> +	type =3D *data++;
> +	datalen--;
> +	if (!(type & 0x80)) {
> +		pr_debug("Packet type does not have MSB set\n");
> +		return -EBADMSG;
> +	}
> +	type &=3D ~0x80;
> +
> +	if (type & 0x40) {
> +		/* New packet length format */
> +		type &=3D ~0x40;
> +		pr_devel("new format: t=3D%u\n", type);
> +		switch (data[0]) {
> +		case 0x00 ... 0xbf:
> +			/* One-byte length */
> +			size =3D data[0];
> +			data++;
> +			datalen--;
> +			*_headerlen =3D 2;
> +			break;
> +		case 0xc0 ... 0xdf:
> +			/* Two-byte length */
> +			if (datalen < 2)
> +				goto short_packet;
> +			size =3D (data[0] - 192) * 256;
> +			size +=3D data[1] + 192;
> +			data +=3D 2;
> +			datalen -=3D 2;
> +			*_headerlen =3D 3;
> +			break;
> +		case 0xff:
> +			/* Five-byte length */
> +			if (datalen < 5)
> +				goto short_packet;
> +			size =3D  data[1] << 24;
> +			size |=3D data[2] << 16;
> +			size |=3D data[3] << 8;
> +			size |=3D data[4];
> +			data +=3D 5;
> +			datalen -=3D 5;
> +			*_headerlen =3D 6;
> +			break;
> +		default:
> +			pr_debug("Partial body length packet not supported\n");
> +			return -EBADMSG;
> +		}
> +	} else {
> +		/* Old packet length format */
> +		u8 length_type =3D type & 0x03;
> +
> +		type >>=3D 2;
> +		pr_devel("old format: t=3D%u lt=3D%u\n", type, length_type);
> +
> +		switch (length_type) {
> +		case 0:
> +			/* One-byte length */
> +			size =3D data[0];
> +			data++;
> +			datalen--;
> +			*_headerlen =3D 2;
> +			break;
> +		case 1:
> +			/* Two-byte length */
> +			if (datalen < 2)
> +				goto short_packet;
> +			size  =3D data[0] << 8;
> +			size |=3D data[1];
> +			data +=3D 2;
> +			datalen -=3D 2;
> +			*_headerlen =3D 3;
> +			break;
> +		case 2:
> +			/* Four-byte length */
> +			if (datalen < 4)
> +				goto short_packet;
> +			size  =3D data[0] << 24;
> +			size |=3D data[1] << 16;
> +			size |=3D data[2] << 8;
> +			size |=3D data[3];
> +			data +=3D 4;
> +			datalen -=3D 4;
> +			*_headerlen =3D 5;
> +			break;
> +		default:
> +			pr_debug("Indefinite length packet not supported\n");
> +			return -EBADMSG;
> +		}
> +	}
> +
> +	pr_devel("datalen=3D%zu size=3D%zu\n", datalen, size);
> +	if (datalen < size)
> +		goto short_packet;
> +	if (size > INT_MAX)
> +		goto too_big;
> +
> +	*_data =3D data;
> +	*_datalen =3D datalen;
> +	*_type =3D type;
> +	pr_devel("Found packet type=3D%u size=3D%zd\n", type, size);
> +	return size;
> +
> +short_packet:
> +	pr_debug("Attempt to parse short packet\n");
> +	return -EBADMSG;
> +too_big:
> +	pr_debug("Signature subpacket size >2G\n");
> +	return -EMSGSIZE;
> +}
> +
> +/**
> + * pgp_parse_packets - Parse a set of PGP packets
> + * @data: Data to be parsed (updated)
> + * @datalen: Amount of data (updated)
> + * @ctx: Parsing context
> + *
> + * Parse a set of PGP packets [RFC 9580: 4].
> + *
> + * Return: 0 on successful parsing, a negative value otherwise.
> + */
> +int pgp_parse_packets(const u8 *data, size_t datalen,
> +		      struct pgp_parse_context *ctx)
> +{
> +	enum pgp_packet_tag type;
> +	ssize_t pktlen;
> +	u8 headerlen;
> +	int ret;
> +
> +	while (datalen > 2) {
> +		pktlen =3D pgp_parse_packet_header(&data, &datalen, &type,
> +						 &headerlen);
> +		if (pktlen < 0)
> +			return pktlen;
> +
> +		if ((ctx->types_of_interest >> type) & 1) {
> +			ret =3D ctx->process_packet(ctx, type, headerlen,
> +						  data, pktlen);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		data +=3D pktlen;
> +		datalen -=3D pktlen;
> +	}
> +
> +	if (datalen !=3D 0) {
> +		pr_debug("Excess octets in packet stream\n");
> +		return -EBADMSG;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pgp_parse_packets);
> +
> +/**
> + * pgp_parse_public_key - Parse the common part of a PGP pubkey packet
> + * @_data: Content of packet (updated)
> + * @_datalen: Length of packet remaining (updated)
> + * @pk: Public key data
> + *
> + * Parse the common data struct for a PGP pubkey packet [RFC 9580: 5.5.2=
].
> + *
> + * Return: 0 on successful parsing, a negative value otherwise.
> + */
> +int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
> +			 struct pgp_parse_pubkey *pk)
> +{
> +	const u8 *data =3D *_data;
> +	size_t datalen =3D *_datalen;
> +	unsigned int tmp;
> +
> +	if (datalen < 12) {
> +		pr_debug("Public key packet too short\n");
> +		return -EBADMSG;
> +	}
> +
> +	pk->version =3D *data++;
> +	switch (pk->version) {
> +	case PGP_KEY_VERSION_4:
> +		break;
> +	default:
> +		pr_debug("Public key packet with unhandled version %d\n",
> +			 pk->version);
> +		return -EBADMSG;
> +	}
> +
> +	tmp  =3D *data++ << 24;
> +	tmp |=3D *data++ << 16;
> +	tmp |=3D *data++ << 8;
> +	tmp |=3D *data++;
> +	pk->creation_time =3D tmp;
> +	if (pk->version =3D=3D PGP_KEY_VERSION_4)
> +		pk->expires_at =3D 0; /* Have to get it from the selfsignature */
> +
> +	pk->pubkey_algo =3D *data++;
> +	datalen -=3D 6;
> +
> +	pr_devel("%x,%x,%lx,%lx\n",
> +		 pk->version, pk->pubkey_algo, pk->creation_time,
> +		 pk->expires_at);
> +
> +	*_data =3D data;
> +	*_datalen =3D datalen;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pgp_parse_public_key);
> diff --git a/crypto/asymmetric_keys/pgplib.h b/crypto/asymmetric_keys/pgp=
lib.h
> new file mode 100644
> index 000000000000..3ec4b408a11e
> --- /dev/null
> +++ b/crypto/asymmetric_keys/pgplib.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* PGP library definitions (RFC 9580)
> + *
> + * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include "pgp.h"
> +
> +/*
> + * PGP library packet parser
> + */
> +struct pgp_parse_context {
> +	u64 types_of_interest;
> +	int (*process_packet)(struct pgp_parse_context *context,
> +			      enum pgp_packet_tag type,
> +			      u8 headerlen,
> +			      const u8 *data,
> +			      size_t datalen);
> +};
> +
> +extern int pgp_parse_packets(const u8 *data, size_t datalen,
> +			     struct pgp_parse_context *ctx);
> +
> +struct pgp_parse_pubkey {
> +	enum pgp_key_version version : 8;
> +	enum pgp_pubkey_algo pubkey_algo : 8;
> +	__kernel_old_time_t creation_time;
> +	__kernel_old_time_t expires_at;
> +};
> +
> +extern int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
> +				struct pgp_parse_pubkey *pk);


BR, Jarkko

