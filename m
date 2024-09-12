Return-Path: <linux-integrity+bounces-3542-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE56976ABB
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F601C23ABA
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57E21AD262;
	Thu, 12 Sep 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjORBQBE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6F1AC459;
	Thu, 12 Sep 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148009; cv=none; b=EmqjuNnTWk8joQYsgFqllxHJBaGsdqm8GTJkx5PH7UTUKJlMwdqZOJPA2NDFcu7NPHGfv4CUBmO0yNPKQO0WgGMB71YZXbWiMaUZSNs1Tjo3i8oAkBUjq/fZCYhF+xBX7HFJCe7mvECh6AxAiR7Mm83ZPlLEwmS3sJ6MJp8e/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148009; c=relaxed/simple;
	bh=6z4sL3Q2vQ51GAFjH66UWeYKoPy1VOkfSaBNtywE1Xo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hM9Q20+0BtbCvzzyjP6jKKaFDRScHETK4zi7yayeAErtzJaY0B6PXHvwa7hEdZnXAW62x5/hVqunzJlzzs9QL/MZavGXVChgwCSOeULb+Kyrb+IogcuM7MiQ26x5sI3DfEGYeTCpF1Eo8rzWXUZkXF/glBQABt/i4aVUuXI7NEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjORBQBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1897C4CEC3;
	Thu, 12 Sep 2024 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726148009;
	bh=6z4sL3Q2vQ51GAFjH66UWeYKoPy1VOkfSaBNtywE1Xo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GjORBQBE6PrefR1ukxkFRq8fCKYQLz7MQAugI9bYv3iHYjJTDrcxvjCn0+n/MwQ1C
	 oy4MO9V4f60+vdb/68f59wN1mskL1gmRKM84z30TpT2HehHmG+J9yAkJM/zfnFtohv
	 lFc1d6JqKOQ1gj2zqc/wahsaqQNzP/qFcoW+ffxK1rU25wD08k4tDl9BTbiOcsgFTD
	 9CYtjt+ZW5wDzNbIDshILMD9Yz4lMNS51y+bzTt8j6vc8MdtW+1Pdub0m2D1ZJrHV0
	 5hXrHwcC4TzAEapvhtJRjiSeM++6xIIOrJzncMjrB4PXD3VUQdOkw5kL5zxDBc9Pl8
	 78EE0WLd3/+lQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Sep 2024 16:33:25 +0300
Message-Id: <D44CEEGVNROC.2X84S94NHI7K3@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <torvalds@linux-foundation.org>,
 "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v3 02/14] rsa: add parser of raw format
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
 <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.18.2
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
 <20240911122911.1381864-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240911122911.1381864-3-roberto.sassu@huaweicloud.com>

On Wed Sep 11, 2024 at 3:28 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Parse the RSA key with RAW format if the ASN.1 parser returns an error, t=
o
> avoid passing somehow the key format as parameter.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  crypto/rsa.c                  | 14 ++++--
>  crypto/rsa_helper.c           | 83 ++++++++++++++++++++++++++++++++++-
>  include/crypto/internal/rsa.h |  6 +++
>  3 files changed, 97 insertions(+), 6 deletions(-)
>
> diff --git a/crypto/rsa.c b/crypto/rsa.c
> index d9be9e86097e..66d42974d47d 100644
> --- a/crypto/rsa.c
> +++ b/crypto/rsa.c
> @@ -272,8 +272,11 @@ static int rsa_set_pub_key(struct crypto_akcipher *t=
fm, const void *key,
>  	rsa_free_mpi_key(mpi_key);
> =20
>  	ret =3D rsa_parse_pub_key(&raw_key, key, keylen);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		ret =3D rsa_parse_pub_key_raw(&raw_key, key, keylen);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	mpi_key->e =3D mpi_read_raw_data(raw_key.e, raw_key.e_sz);
>  	if (!mpi_key->e)
> @@ -311,8 +314,11 @@ static int rsa_set_priv_key(struct crypto_akcipher *=
tfm, const void *key,
>  	rsa_free_mpi_key(mpi_key);
> =20
>  	ret =3D rsa_parse_priv_key(&raw_key, key, keylen);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		ret =3D rsa_parse_priv_key_raw(&raw_key, key, keylen);
> +		if (ret)
> +			return ret;
> +	}
> =20
>  	mpi_key->d =3D mpi_read_raw_data(raw_key.d, raw_key.d_sz);
>  	if (!mpi_key->d)
> diff --git a/crypto/rsa_helper.c b/crypto/rsa_helper.c
> index 94266f29049c..40a17ebc972f 100644
> --- a/crypto/rsa_helper.c
> +++ b/crypto/rsa_helper.c
> @@ -9,6 +9,7 @@
>  #include <linux/export.h>
>  #include <linux/err.h>
>  #include <linux/fips.h>
> +#include <linux/mpi.h>
>  #include <crypto/internal/rsa.h>
>  #include "rsapubkey.asn1.h"
>  #include "rsaprivkey.asn1.h"
> @@ -148,6 +149,42 @@ int rsa_get_qinv(void *context, size_t hdrlen, unsig=
ned char tag,
>  	return 0;
>  }
> =20

/*
 * Please, document me.
 */
> +typedef int (*rsa_get_func)(void *, size_t, unsigned char,
> +			    const void *, size_t);
> +
> +static int rsa_parse_key_raw(struct rsa_key *rsa_key,
> +			     const void *key, unsigned int key_len,
> +			     rsa_get_func *func, int n_func)
> +{
> +	unsigned int nbytes, len =3D key_len;
> +	const void *key_ptr =3D key;
> +	int ret, i;
> +
> +	for (i =3D 0; i < n_func; i++) {
> +		if (key_len < 2)
> +			return -EINVAL;
> +
> +		ret =3D mpi_key_length(key_ptr, len, NULL, &nbytes);
> +		if (ret < 0)
> +			return ret;
> +
> +		key_ptr +=3D 2;
> +		key_len -=3D 2;
> +
> +		if (key_len < nbytes)
> +			return -EINVAL;
> +
> +		ret =3D func[i](rsa_key, 0, 0, key_ptr, nbytes);
> +		if (ret < 0)
> +			return ret;
> +
> +		key_ptr +=3D nbytes;
> +		key_len -=3D nbytes;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * rsa_parse_pub_key() - decodes the BER encoded buffer and stores in th=
e
>   *                       provided struct rsa_key, pointers to the raw ke=
y as is,
> @@ -157,7 +194,7 @@ int rsa_get_qinv(void *context, size_t hdrlen, unsign=
ed char tag,
>   * @key:	key in BER format
>   * @key_len:	length of key
>   *
> - * Return:	0 on success or error code in case of error
> + * Return:	0 on success or error code in case of error.
>   */
>  int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
>  		      unsigned int key_len)
> @@ -166,6 +203,27 @@ int rsa_parse_pub_key(struct rsa_key *rsa_key, const=
 void *key,
>  }
>  EXPORT_SYMBOL_GPL(rsa_parse_pub_key);
> =20
> +/**
> + * rsa_parse_pub_key_raw() - parse the RAW key and store in the provided=
 struct
> + *                           rsa_key, pointers to the raw key as is, so =
that
> + *                           the caller can copy it or MPI parse it, etc=
.
> + *
> + * @rsa_key:	struct rsa_key key representation
> + * @key:	key in RAW format
> + * @key_len:	length of key
> + *
> + * Return:	0 on success or error code in case of error.
> + */
> +int rsa_parse_pub_key_raw(struct rsa_key *rsa_key, const void *key,
> +			  unsigned int key_len)
> +{
> +	rsa_get_func pub_func[] =3D {rsa_get_n, rsa_get_e};
> +
> +	return rsa_parse_key_raw(rsa_key, key, key_len,
> +				 pub_func, ARRAY_SIZE(pub_func));
> +}
> +EXPORT_SYMBOL_GPL(rsa_parse_pub_key_raw);
> +
>  /**
>   * rsa_parse_priv_key() - decodes the BER encoded buffer and stores in t=
he
>   *                        provided struct rsa_key, pointers to the raw k=
ey
> @@ -176,7 +234,7 @@ EXPORT_SYMBOL_GPL(rsa_parse_pub_key);
>   * @key:	key in BER format
>   * @key_len:	length of key
>   *
> - * Return:	0 on success or error code in case of error
> + * Return:	0 on success or error code in case of error.
>   */
>  int rsa_parse_priv_key(struct rsa_key *rsa_key, const void *key,
>  		       unsigned int key_len)
> @@ -184,3 +242,24 @@ int rsa_parse_priv_key(struct rsa_key *rsa_key, cons=
t void *key,
>  	return asn1_ber_decoder(&rsaprivkey_decoder, rsa_key, key, key_len);
>  }
>  EXPORT_SYMBOL_GPL(rsa_parse_priv_key);
> +
> +/**
> + * rsa_parse_priv_key_raw() - parse the RAW key and store in the provide=
d struct
> + *                            rsa_key, pointers to the raw key as is, so=
 that
> + *                            the caller can copy it or MPI parse it, et=
c.

This belongs after the parameters, here a one-liner would be a better
choice:

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

Try to avoid "etc" in documentation because then I have no choice than
stop reading your documentation and read source code instead.

Just enumerate everything that makes sense, no aim for perfection but
it is like a stamp that I tried my best, and then we will refine the
description.

"etc" in the documentation encompasses also all the future changes,
which does not encourage accuracy :-) Imcompleteness is less of a
devil than entropy, or at least that is how I weight these matters.

> + *
> + * @rsa_key:	struct rsa_key key representation
> + * @key:	key in RAW format
> + * @key_len:	length of key
> + *
> + * Return:	0 on success or error code in case of error.
> + */
> +int rsa_parse_priv_key_raw(struct rsa_key *rsa_key, const void *key,
> +			   unsigned int key_len)
> +{
> +	rsa_get_func priv_func[] =3D {rsa_get_n, rsa_get_e, rsa_get_d};
> +
> +	return rsa_parse_key_raw(rsa_key, key, key_len,
> +				 priv_func, ARRAY_SIZE(priv_func));
> +}
> +EXPORT_SYMBOL_GPL(rsa_parse_priv_key_raw);
> diff --git a/include/crypto/internal/rsa.h b/include/crypto/internal/rsa.=
h
> index e870133f4b77..7141e806ceea 100644
> --- a/include/crypto/internal/rsa.h
> +++ b/include/crypto/internal/rsa.h
> @@ -50,8 +50,14 @@ struct rsa_key {
>  int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
>  		      unsigned int key_len);
> =20
> +int rsa_parse_pub_key_raw(struct rsa_key *rsa_key, const void *key,
> +			  unsigned int key_len);
> +
>  int rsa_parse_priv_key(struct rsa_key *rsa_key, const void *key,
>  		       unsigned int key_len);
> =20
> +int rsa_parse_priv_key_raw(struct rsa_key *rsa_key, const void *key,
> +			   unsigned int key_len);
> +
>  extern struct crypto_template rsa_pkcs1pad_tmpl;
>  #endif


BR, Jarkko

