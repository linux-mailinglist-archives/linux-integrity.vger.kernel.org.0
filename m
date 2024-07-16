Return-Path: <linux-integrity+bounces-3124-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 253ED9325F0
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 13:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D29E1F2252E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57F1993B8;
	Tue, 16 Jul 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua6oVTuG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD217C64;
	Tue, 16 Jul 2024 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130817; cv=none; b=juE09iEEEt2kbrOyQFevuoiryavm/g9PHSfui5EmlbfiuduvjIwiVQc2mvcyeLIHQy0hevWfKSXkg0JSg2PdS6yymJLGUA8ie0aS7t3ZHIFmRKlK0eUbLdOI1KTTpYDByBiOiTa8EAoc/u/lgU3g9zIrrD/nac19/JErHN6B/Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130817; c=relaxed/simple;
	bh=fCdgbhK0SowjADDjH8XxyTy+QEipYOeGb+0RUqWV8cQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=BiePpXsPm982AhOVwPduOzcpuAe0IDI78CEJm+Zf3SQFYDJBjQZ76YVV2BAg0B9yxBGs1Exay1WnyqZc5d3OURssLGLRgY+Nhlx9rdPfrliLjvxXlYv/XlvXErEmrh7IJr7oW074oBATZGia61u5coZkGsGWQ6KkaBS4MaZVDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua6oVTuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4D5C116B1;
	Tue, 16 Jul 2024 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721130817;
	bh=fCdgbhK0SowjADDjH8XxyTy+QEipYOeGb+0RUqWV8cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ua6oVTuGmvNKEApsWWhB89q/Q9gOPnXSKxxbfIiBYGMF16Lk9HLU1oRgueeYe73H/
	 eFdDVXTZDbUhdqLQb3q+gQkwRwmyOSSpN9FW/azQbeW1XX6Mys+6JLL8y/FBFL3A9O
	 vXtY+bmBSacM6dFql1GckyrzomVGTpfWfLDXU68/mT36l2BvuAONwjZ2IbjkJMlbF/
	 27vVX+zpiT/HitUF7knpbYVRF2ORX3PKqjvtMFemovcZW3xTeSwLElWj+x2ta2qzjJ
	 C6TCkk07wIXHZhyQ06xvFJ5DtvJ2R4ORPh6Wfw/TwaUE2mMkMfOXXglC0BckX+0O1U
	 xRR+HKT182EuA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 14:53:34 +0300
Message-Id: <D2QXYCVI47RK.GFOY8SNQHWW2@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 2/6] tpm: add policy sessions
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524130459.21510-3-James.Bottomley@HansenPartnership.com>

Please rewrite short summray to something understandable. Perhaps
"tpm: authenticated policy sessions for TPM2" would be more to
the point.

On Fri May 24, 2024 at 4:04 PM EEST, James Bottomley wrote:
> TPM security uses hmac sessions to implement data protection and
  TPM2 sessions use HMAC ...

> integrity.  The hash algorithm of these sessions isn't exposed to the
> user (and doesn't depend on the object being authorized) so it is

Either remove the text in parentheses or rewrite it as a separate
sentence if it is relevant.

> currently fixed at a safe sha256.  Policy sessions may also be used
                            SHA-256

> for the same purpose and in addition, they can be used to express a
> rich policy language.  However, the session hash of policy sessions is
> defined to be the same as the name algorithm of the TPM object they're
> operating on, so we must update the session code to allow a variable

No information about the TPM object in question, which means no
rationale to bundle variable digest size to this patch. I know that
null key uses SHA-256 as name algorithm:

	/* name algorithm */
	if (val !=3D TPM_ALG_SHA256)
		return -EINVAL;
	val =3D tpm_buf_read_u32(buf, &offset_t);

Please state what other TPM object might be in question.

Also, describe your changes in imperative form. This is also stated in
SubmittingPatches.

> hash algorithm instead of the fixed sha256 one.  Note that while this
> affects most of the code, the KDFe algorithm still uses a fixed sha256
> algorithm because it is define to follow the name algorithm of the
> salt encryption key (which is a key we derive from the null seed and
> set its name algorithm to sha256).

Split the long description to two paragraphs: one that describes the
motivation and one that describes the solution.

>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm2-sessions.c | 307 +++++++++++++++++++------------
>  include/linux/tpm.h              |   6 +
>  2 files changed, 200 insertions(+), 113 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index ea8860661876..63c175b2165c 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -105,10 +105,10 @@ struct tpm2_auth {
>  	/*
>  	 * the size here is variable and set by the size of our_nonce
>  	 * which must be between 16 and the name hash length. we set
> -	 * the maximum sha256 size for the greatest protection
> +	 * the maximum hash size for the greatest protection
>  	 */
> -	u8 our_nonce[SHA256_DIGEST_SIZE];
> -	u8 tpm_nonce[SHA256_DIGEST_SIZE];
> +	u8 our_nonce[HASH_MAX_DIGESTSIZE];
> +	u8 tpm_nonce[HASH_MAX_DIGESTSIZE];
>  	/*
>  	 * the salt is only used across the session command/response
>  	 * after that it can be used as a scratch area
> @@ -119,17 +119,15 @@ struct tpm2_auth {
>  		u8 scratch[AES_KEY_BYTES + AES_BLOCK_SIZE];
>  	};
>  	/*
> -	 * the session key and passphrase are the same size as the
> -	 * name digest (sha256 again).  The session key is constant
> -	 * for the use of the session and the passphrase can change
> -	 * with every invocation.
> -	 *
> -	 * Note: these fields must be adjacent and in this order
> -	 * because several HMAC/KDF schemes use the combination of the
> -	 * session_key and passphrase.
> +	 * The session_key and passphrase must be next to each other
> +	 * to allow us to hash them as a unit.  With a variable hash,
> +	 * this means that the passphrase must occur exactly one hash
> +	 * size after the session_key, so make session_key house both
> +	 * and passphrase is a pointer into where the passphrase
> +	 * begins in session_key.
>  	 */
> -	u8 session_key[SHA256_DIGEST_SIZE];
> -	u8 passphrase[SHA256_DIGEST_SIZE];
> +	u8 session_key[2*HASH_MAX_DIGESTSIZE];
> +	u8 *passphrase;
>  	int passphrase_len;
>  	struct crypto_aes_ctx aes_ctx;
>  	/* saved session attributes: */
> @@ -142,7 +140,8 @@ struct tpm2_auth {
>  	 * we must compute and remember
>  	 */
>  	u32 name_h[AUTH_MAX_NAMES];
> -	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
> +	u8 name[AUTH_MAX_NAMES][2 + HASH_MAX_DIGESTSIZE];
> +	struct crypto_shash *tfm;
>  };
> =20
>  /*
> @@ -161,34 +160,36 @@ static u8 name_size(const u8 *name)
>  }
> =20
>  /*
> - * It turns out the crypto hmac(sha256) is hard for us to consume
> + * It turns out the crypto hmac(shaX) is hard for us to consume
>   * because it assumes a fixed key and the TPM seems to change the key
>   * on every operation, so we weld the hmac init and final functions in
>   * here to give it the same usage characteristics as a regular hash
>   */
> -static void tpm2_hmac_init(struct sha256_state *sctx, u8 *key, u32 key_l=
en)
> +static void tpm2_hmac_init(struct shash_desc *sdesc, u8 *key, u32 key_le=
n)
>  {
> -	u8 pad[SHA256_BLOCK_SIZE];
> +	const int block_size =3D crypto_shash_blocksize(sdesc->tfm);
> +	u8 pad[SHA512_BLOCK_SIZE];
>  	int i;
> =20
> -	sha256_init(sctx);
> -	for (i =3D 0; i < sizeof(pad); i++) {
> +	crypto_shash_init(sdesc);
> +	for (i =3D 0; i < block_size; i++) {
>  		if (i < key_len)
>  			pad[i] =3D key[i];
>  		else
>  			pad[i] =3D 0;
>  		pad[i] ^=3D HMAC_IPAD_VALUE;
>  	}
> -	sha256_update(sctx, pad, sizeof(pad));
> +	crypto_shash_update(sdesc, pad, block_size);
>  }
> =20
> -static void tpm2_hmac_final(struct sha256_state *sctx, u8 *key, u32 key_=
len,
> +static void tpm2_hmac_final(struct shash_desc *sdesc, u8 *key, u32 key_l=
en,
>  			    u8 *out)
>  {
> -	u8 pad[SHA256_BLOCK_SIZE];
> +	const int block_size =3D crypto_shash_blocksize(sdesc->tfm);
> +	u8 pad[SHA512_BLOCK_SIZE];
>  	int i;
> =20
> -	for (i =3D 0; i < sizeof(pad); i++) {
> +	for (i =3D 0; i < block_size; i++) {
>  		if (i < key_len)
>  			pad[i] =3D key[i];
>  		else
> @@ -197,35 +198,42 @@ static void tpm2_hmac_final(struct sha256_state *sc=
tx, u8 *key, u32 key_len,
>  	}
> =20
>  	/* collect the final hash;  use out as temporary storage */
> -	sha256_final(sctx, out);
> +	crypto_shash_final(sdesc, out);
> =20
> -	sha256_init(sctx);
> -	sha256_update(sctx, pad, sizeof(pad));
> -	sha256_update(sctx, out, SHA256_DIGEST_SIZE);
> -	sha256_final(sctx, out);
> +	crypto_shash_init(sdesc);
> +	crypto_shash_update(sdesc, pad, block_size);
> +	crypto_shash_update(sdesc, out, crypto_shash_digestsize(sdesc->tfm));
> +	crypto_shash_final(sdesc, out);
>  }
> =20
>  /*
> - * assume hash sha256 and nonces u, v of size SHA256_DIGEST_SIZE but
> + * assume hash sha256 and nonces u, v of hash digest size but
>   * otherwise standard tpm2_KDFa.  Note output is in bytes not bits.
>   */
>  static void tpm2_KDFa(u8 *key, u32 key_len, const char *label, u8 *u,
> -		      u8 *v, u32 bytes, u8 *out)
> +		      u8 *v, u32 bytes, u8 *out, struct shash_desc *sdesc)
>  {
>  	u32 counter =3D 1;
>  	const __be32 bits =3D cpu_to_be32(bytes * 8);
> +	const int digest_size =3D crypto_shash_digestsize(sdesc->tfm);
> =20
>  	while (bytes > 0) {
> -		struct sha256_state sctx;
>  		__be32 c =3D cpu_to_be32(counter);
> =20
> -		tpm2_hmac_init(&sctx, key, key_len);
> -		sha256_update(&sctx, (u8 *)&c, sizeof(c));
> -		sha256_update(&sctx, label, strlen(label)+1);
> -		sha256_update(&sctx, u, SHA256_DIGEST_SIZE);
> -		sha256_update(&sctx, v, SHA256_DIGEST_SIZE);
> -		sha256_update(&sctx, (u8 *)&bits, sizeof(bits));
> -		tpm2_hmac_final(&sctx, key, key_len, out);
> +		tpm2_hmac_init(sdesc, key, key_len);
> +		crypto_shash_update(sdesc, (u8 *)&c, sizeof(c));
> +		crypto_shash_update(sdesc, label, strlen(label)+1);
> +		crypto_shash_update(sdesc, u, digest_size);
> +		crypto_shash_update(sdesc, v, digest_size);
> +		crypto_shash_update(sdesc, (u8 *)&bits, sizeof(bits));
> +		if (bytes < digest_size) {
> +			u8 buf[HASH_MAX_DIGESTSIZE];
> +
> +			tpm2_hmac_final(sdesc, key, key_len, buf);
> +			memcpy(out, buf, bytes);
> +		} else {
> +			tpm2_hmac_final(sdesc, key, key_len, out);
> +		}
> =20
>  		bytes -=3D SHA256_DIGEST_SIZE;
>  		counter++;
> @@ -236,9 +244,9 @@ static void tpm2_KDFa(u8 *key, u32 key_len, const cha=
r *label, u8 *u,
>  /*
>   * Somewhat of a bastardization of the real KDFe.  We're assuming
>   * we're working with known point sizes for the input parameters and
> - * the hash algorithm is fixed at sha256.  Because we know that the
> - * point size is 32 bytes like the hash size, there's no need to loop
> - * in this KDF.
> + * the hash algorithm is fixed at sha256 (name algorithm of the
> + * encrypting key).  Because we know that the point size is 32 bytes
> + * like the hash size, there's no need to loop in this KDF.
>   */
>  static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_=
v,
>  		      u8 *out)
> @@ -370,9 +378,10 @@ void tpm_buf_append_hmac_session(struct tpm_chip *ch=
ip, struct tpm_buf *buf,
>  				 u8 attributes, u8 *passphrase,
>  				 int passphrase_len)
>  {
> -	u8 nonce[SHA256_DIGEST_SIZE];
> +	u8 nonce[HASH_MAX_DIGESTSIZE];
>  	u32 len;
>  	struct tpm2_auth *auth =3D chip->auth;
> +	const int digest_size =3D crypto_shash_digestsize(auth->tfm);
> =20
>  	/*
>  	 * The Architecture Guide requires us to strip trailing zeros
> @@ -384,8 +393,14 @@ void tpm_buf_append_hmac_session(struct tpm_chip *ch=
ip, struct tpm_buf *buf,
> =20
>  	auth->attrs =3D attributes;
>  	auth->passphrase_len =3D passphrase_len;
> -	if (passphrase_len)
> +	if (passphrase_len) {
> +		/*
> +		 * place the passphrase immediately adjacent to
> +		 * the session key
> +		 */
> +		auth->passphrase =3D auth->session_key + digest_size;
>  		memcpy(auth->passphrase, passphrase, passphrase_len);
> +	}
> =20
>  	if (auth->session !=3D tpm_buf_length(buf)) {
>  		/* we're not the first session */
> @@ -396,23 +411,23 @@ void tpm_buf_append_hmac_session(struct tpm_chip *c=
hip, struct tpm_buf *buf,
>  		}
> =20
>  		/* add our new session */
> -		len +=3D 9 + 2 * SHA256_DIGEST_SIZE;
> +		len +=3D 9 + 2 * digest_size;
>  		put_unaligned_be32(len, &buf->data[auth->session]);
>  	} else {
> -		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
> +		tpm_buf_append_u32(buf, 9 + 2 * digest_size);
>  	}
> =20
>  	/* random number for our nonce */
> -	get_random_bytes(nonce, sizeof(nonce));
> -	memcpy(auth->our_nonce, nonce, sizeof(nonce));
> +	get_random_bytes(nonce, digest_size);
> +	memcpy(auth->our_nonce, nonce, digest_size);
>  	tpm_buf_append_u32(buf, auth->handle);
>  	/* our new nonce */
> -	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
> -	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
> +	tpm_buf_append_u16(buf, digest_size);
> +	tpm_buf_append(buf, nonce, digest_size);
>  	tpm_buf_append_u8(buf, auth->attrs);
>  	/* and put a placeholder for the hmac */
> -	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
> -	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
> +	tpm_buf_append_u16(buf, digest_size);
> +	tpm_buf_append(buf, nonce, digest_size);
>  }
>  EXPORT_SYMBOL(tpm_buf_append_hmac_session);
> =20
> @@ -443,8 +458,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip=
, struct tpm_buf *buf)
>  	off_t offset_s =3D TPM_HEADER_SIZE, offset_p;
>  	u8 *hmac =3D NULL;
>  	u32 attrs;
> -	u8 cphash[SHA256_DIGEST_SIZE];
> -	struct sha256_state sctx;
> +	const int digest_size =3D crypto_shash_digestsize(auth->tfm);
> +	u8 cphash[HASH_MAX_DIGESTSIZE];
> +	SHASH_DESC_ON_STACK(sdesc, auth->tfm);
> +
> +	sdesc->tfm =3D auth->tfm;
> =20
>  	/* save the command code in BE format */
>  	auth->ordinal =3D head->ordinal;
> @@ -515,10 +533,10 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chi=
p, struct tpm_buf *buf)
>  		u16 len;
> =20
>  		/* need key and IV */
> -		tpm2_KDFa(auth->session_key, SHA256_DIGEST_SIZE
> +		tpm2_KDFa(auth->session_key, digest_size
>  			  + auth->passphrase_len, "CFB", auth->our_nonce,
>  			  auth->tpm_nonce, AES_KEY_BYTES + AES_BLOCK_SIZE,
> -			  auth->scratch);
> +			  auth->scratch, sdesc);
> =20
>  		len =3D tpm_buf_read_u16(buf, &offset_p);
>  		aes_expandkey(&auth->aes_ctx, auth->scratch, AES_KEY_BYTES);
> @@ -529,9 +547,10 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip=
, struct tpm_buf *buf)
>  		offset_p -=3D 2;
>  	}
> =20
> -	sha256_init(&sctx);
> +	crypto_shash_init(sdesc);
>  	/* ordinal is already BE */
> -	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
> +	crypto_shash_update(sdesc, (u8 *)&head->ordinal,
> +			    sizeof(head->ordinal));
>  	/* add the handle names */
>  	for (i =3D 0; i < handles; i++) {
>  		enum tpm2_mso_type mso =3D tpm2_handle_mso(auth->name_h[i]);
> @@ -539,27 +558,27 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chi=
p, struct tpm_buf *buf)
>  		if (mso =3D=3D TPM2_MSO_PERSISTENT ||
>  		    mso =3D=3D TPM2_MSO_VOLATILE ||
>  		    mso =3D=3D TPM2_MSO_NVRAM) {
> -			sha256_update(&sctx, auth->name[i],
> -				      name_size(auth->name[i]));
> +			crypto_shash_update(sdesc, auth->name[i],
> +					    name_size(auth->name[i]));
>  		} else {
>  			__be32 h =3D cpu_to_be32(auth->name_h[i]);
> =20
> -			sha256_update(&sctx, (u8 *)&h, 4);
> +			crypto_shash_update(sdesc, (u8 *)&h, 4);
>  		}
>  	}
>  	if (offset_s !=3D tpm_buf_length(buf))
> -		sha256_update(&sctx, &buf->data[offset_s],
> -			      tpm_buf_length(buf) - offset_s);
> -	sha256_final(&sctx, cphash);
> +		crypto_shash_update(sdesc, &buf->data[offset_s],
> +				    tpm_buf_length(buf) - offset_s);
> +	crypto_shash_final(sdesc, cphash);
> =20
>  	/* now calculate the hmac */
> -	tpm2_hmac_init(&sctx, auth->session_key, sizeof(auth->session_key)
> +	tpm2_hmac_init(sdesc, auth->session_key, digest_size
>  		       + auth->passphrase_len);
> -	sha256_update(&sctx, cphash, sizeof(cphash));
> -	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
> -	sha256_update(&sctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
> -	sha256_update(&sctx, &auth->attrs, 1);
> -	tpm2_hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
> +	crypto_shash_update(sdesc, cphash, digest_size);
> +	crypto_shash_update(sdesc, auth->our_nonce, digest_size);
> +	crypto_shash_update(sdesc, auth->tpm_nonce, digest_size);
> +	crypto_shash_update(sdesc, &auth->attrs, 1);
> +	tpm2_hmac_final(sdesc, auth->session_key, digest_size
>  			+ auth->passphrase_len, hmac);
>  }
>  EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
> @@ -695,12 +714,15 @@ int tpm_buf_check_hmac_response(struct tpm_chip *ch=
ip, struct tpm_buf *buf,
>  	struct tpm_header *head =3D (struct tpm_header *)buf->data;
>  	struct tpm2_auth *auth =3D chip->auth;
>  	off_t offset_s, offset_p;
> -	u8 rphash[SHA256_DIGEST_SIZE];
> +	const int digest_size =3D crypto_shash_digestsize(auth->tfm);
> +	u8 rphash[HASH_MAX_DIGESTSIZE];
>  	u32 attrs;
> -	struct sha256_state sctx;
>  	u16 tag =3D be16_to_cpu(head->tag);
>  	u32 cc =3D be32_to_cpu(auth->ordinal);
>  	int parm_len, len, i, handles;
> +	SHASH_DESC_ON_STACK(sdesc, auth->tfm);
> +
> +	sdesc->tfm =3D auth->tfm;
> =20
>  	if (auth->session >=3D TPM_HEADER_SIZE) {
>  		WARN(1, "tpm session not filled correctly\n");
> @@ -739,7 +761,7 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip=
, struct tpm_buf *buf,
>  	len =3D tpm_buf_read_u16(buf, &offset_s);
>  	if (offset_s + len > tpm_buf_length(buf))
>  		goto out;
> -	if (len !=3D SHA256_DIGEST_SIZE)
> +	if (len !=3D digest_size)
>  		goto out;
>  	memcpy(auth->tpm_nonce, &buf->data[offset_s], len);
>  	offset_s +=3D len;
> @@ -747,32 +769,32 @@ int tpm_buf_check_hmac_response(struct tpm_chip *ch=
ip, struct tpm_buf *buf,
>  	len =3D tpm_buf_read_u16(buf, &offset_s);
>  	if (offset_s + len !=3D tpm_buf_length(buf))
>  		goto out;
> -	if (len !=3D SHA256_DIGEST_SIZE)
> +	if (len !=3D digest_size)
>  		goto out;
>  	/*
>  	 * offset_s points to the HMAC. now calculate comparison, beginning
>  	 * with rphash
>  	 */
> -	sha256_init(&sctx);
> +	crypto_shash_init(sdesc);
>  	/* yes, I know this is now zero, but it's what the standard says */
> -	sha256_update(&sctx, (u8 *)&head->return_code,
> -		      sizeof(head->return_code));
> +	crypto_shash_update(sdesc, (u8 *)&head->return_code,
> +			    sizeof(head->return_code));
>  	/* ordinal is already BE */
> -	sha256_update(&sctx, (u8 *)&auth->ordinal, sizeof(auth->ordinal));
> -	sha256_update(&sctx, &buf->data[offset_p], parm_len);
> -	sha256_final(&sctx, rphash);
> +	crypto_shash_update(sdesc, (u8 *)&auth->ordinal, sizeof(auth->ordinal))=
;
> +	crypto_shash_update(sdesc, &buf->data[offset_p], parm_len);
> +	crypto_shash_final(sdesc, rphash);
> =20
>  	/* now calculate the hmac */
> -	tpm2_hmac_init(&sctx, auth->session_key, sizeof(auth->session_key)
> +	tpm2_hmac_init(sdesc, auth->session_key, digest_size
>  		       + auth->passphrase_len);
> -	sha256_update(&sctx, rphash, sizeof(rphash));
> -	sha256_update(&sctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
> -	sha256_update(&sctx, auth->our_nonce, sizeof(auth->our_nonce));
> -	sha256_update(&sctx, &auth->attrs, 1);
> +	crypto_shash_update(sdesc, rphash, digest_size);
> +	crypto_shash_update(sdesc, auth->tpm_nonce, digest_size);
> +	crypto_shash_update(sdesc, auth->our_nonce, digest_size);
> +	crypto_shash_update(sdesc, &auth->attrs, 1);
>  	/* we're done with the rphash, so put our idea of the hmac there */
> -	tpm2_hmac_final(&sctx, auth->session_key, sizeof(auth->session_key)
> +	tpm2_hmac_final(sdesc, auth->session_key, digest_size
>  			+ auth->passphrase_len, rphash);
> -	if (memcmp(rphash, &buf->data[offset_s], SHA256_DIGEST_SIZE) =3D=3D 0) =
{
> +	if (memcmp(rphash, &buf->data[offset_s], digest_size) =3D=3D 0) {
>  		rc =3D 0;
>  	} else {
>  		dev_err(&chip->dev, "TPM: HMAC check failed\n");
> @@ -782,10 +804,10 @@ int tpm_buf_check_hmac_response(struct tpm_chip *ch=
ip, struct tpm_buf *buf,
>  	/* now do response decryption */
>  	if (auth->attrs & TPM2_SA_ENCRYPT) {
>  		/* need key and IV */
> -		tpm2_KDFa(auth->session_key, SHA256_DIGEST_SIZE
> +		tpm2_KDFa(auth->session_key, digest_size
>  			  + auth->passphrase_len, "CFB", auth->tpm_nonce,
>  			  auth->our_nonce, AES_KEY_BYTES + AES_BLOCK_SIZE,
> -			  auth->scratch);
> +			  auth->scratch, sdesc);
> =20
>  		len =3D tpm_buf_read_u16(buf, &offset_p);
>  		aes_expandkey(&auth->aes_ctx, auth->scratch, AES_KEY_BYTES);
> @@ -799,6 +821,7 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip=
, struct tpm_buf *buf,
>  		if (rc)
>  			/* manually close the session if it wasn't consumed */
>  			tpm2_flush_context(chip, auth->handle);
> +		crypto_free_shash(auth->tfm);
>  		memzero_explicit(auth, sizeof(*auth));
>  	} else {
>  		/* reset for next use  */
> @@ -821,8 +844,11 @@ EXPORT_SYMBOL(tpm_buf_check_hmac_response);
>   */
>  void tpm2_end_auth_session(struct tpm_chip *chip)
>  {
> -	tpm2_flush_context(chip, chip->auth->handle);
> -	memzero_explicit(chip->auth, sizeof(*chip->auth));
> +	struct tpm2_auth *auth =3D chip->auth;
> +
> +	tpm2_flush_context(chip, auth->handle);
> +	crypto_free_shash(auth->tfm);
> +	memzero_explicit(auth, sizeof(*auth));
>  }
>  EXPORT_SYMBOL(tpm2_end_auth_session);
> =20
> @@ -833,23 +859,26 @@ static int tpm2_parse_start_auth_session(struct tpm=
2_auth *auth,
>  	u32 tot_len =3D be32_to_cpu(head->length);
>  	off_t offset =3D TPM_HEADER_SIZE;
>  	u32 val;
> +	const int digest_size =3D crypto_shash_digestsize(auth->tfm);
> +	SHASH_DESC_ON_STACK(sdesc, auth->tfm);
> +
> +	sdesc->tfm =3D auth->tfm;
> =20
>  	/* we're starting after the header so adjust the length */
>  	tot_len -=3D TPM_HEADER_SIZE;
> =20
>  	/* should have handle plus nonce */
> -	if (tot_len !=3D 4 + 2 + sizeof(auth->tpm_nonce))
> +	if (tot_len !=3D 4 + 2 + digest_size)
>  		return -EINVAL;
> =20
>  	auth->handle =3D tpm_buf_read_u32(buf, &offset);
>  	val =3D tpm_buf_read_u16(buf, &offset);
> -	if (val !=3D sizeof(auth->tpm_nonce))
> +	if (val !=3D digest_size)
>  		return -EINVAL;
> -	memcpy(auth->tpm_nonce, &buf->data[offset], sizeof(auth->tpm_nonce));
> +	memcpy(auth->tpm_nonce, &buf->data[offset], digest_size);
>  	/* now compute the session key from the nonces */
>  	tpm2_KDFa(auth->salt, sizeof(auth->salt), "ATH", auth->tpm_nonce,
> -		  auth->our_nonce, sizeof(auth->session_key),
> -		  auth->session_key);
> +		  auth->our_nonce, digest_size, auth->session_key, sdesc);
> =20
>  	return 0;
>  }
> @@ -885,24 +914,23 @@ static int tpm2_load_null(struct tpm_chip *chip, u3=
2 *null_key)
>  	return rc;
>  }
> =20
> -/**
> - * tpm2_start_auth_session() - create a HMAC authentication session with=
 the TPM
> - * @chip: the TPM chip structure to create the session with
> - *
> - * This function loads the NULL seed from its saved context and starts
> - * an authentication session on the null seed, fills in the
> - * @chip->auth structure to contain all the session details necessary
> - * for performing the HMAC, encrypt and decrypt operations and
> - * returns.  The NULL seed is flushed before this function returns.
> - *
> - * Return: zero on success or actual error encountered.
> - */
> -int tpm2_start_auth_session(struct tpm_chip *chip)
> +static int __tpm2_start_session(struct tpm_chip *chip, u8 type, u16 hash=
)
>  {
>  	struct tpm_buf buf;
>  	struct tpm2_auth *auth =3D chip->auth;
>  	int rc;
>  	u32 null_key;
> +	int tpm_hash =3D tpm2_crypto_to_alg(hash);
> +	int digest_size;
> +
> +	if (tpm_hash < 0)
> +		return -EINVAL;
> +
> +	auth->tfm =3D crypto_alloc_shash(hash_algo_name[hash], 0, 0);
> +	if (IS_ERR(auth->tfm))
> +		return PTR_ERR(auth->tfm);
> +
> +	digest_size =3D crypto_shash_digestsize(auth->tfm);
> =20
>  	rc =3D tpm2_load_null(chip, &null_key);
>  	if (rc)
> @@ -919,14 +947,14 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	/* bind key handle */
>  	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
>  	/* nonce caller */
> -	get_random_bytes(auth->our_nonce, sizeof(auth->our_nonce));
> -	tpm_buf_append_u16(&buf, sizeof(auth->our_nonce));
> -	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
> +	get_random_bytes(auth->our_nonce, digest_size);
> +	tpm_buf_append_u16(&buf, digest_size);
> +	tpm_buf_append(&buf, auth->our_nonce, digest_size);
> =20
>  	/* append encrypted salt and squirrel away unencrypted in auth */
>  	tpm_buf_append_salt(&buf, chip);
>  	/* session type (HMAC, audit or policy) */
> -	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
> +	tpm_buf_append_u8(&buf, type);
> =20
>  	/* symmetric encryption parameters */
>  	/* symmetric algorithm */
> @@ -936,7 +964,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	/* symmetric algorithm mode (must be CFB) */
>  	tpm_buf_append_u16(&buf, TPM_ALG_CFB);
>  	/* hash algorithm for session */
> -	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
> +	tpm_buf_append_u16(&buf, tpm_hash);
> =20
>  	rc =3D tpm_transmit_cmd(chip, &buf, 0, "start auth session");
>  	tpm2_flush_context(chip, null_key);
> @@ -949,11 +977,64 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	if (rc)
>  		goto out;
> =20
> +	return rc;
> +
>   out:
> +	crypto_free_shash(auth->tfm);
> +	auth->tfm =3D NULL;
> +
>  	return rc;
>  }
> +
> +/**
> + * tpm2_start_auth_session() - create a HMAC authentication session with=
 the TPM
> + * @chip: the TPM chip structure to create the session with
> + *
> + * This function loads the NULL seed from its saved context and starts
> + * an authentication session on the null seed, fills in the
> + * @chip->auth structure to contain all the session details necessary
> + * for performing the HMAC, encrypt and decrypt operations and
> + * returns.  The NULL seed is flushed before this function returns.
> + *
> + * Return: zero on success or actual error encountered.
> + */
> +int tpm2_start_auth_session(struct tpm_chip *chip)
> +{
> +	return __tpm2_start_session(chip, TPM2_SE_HMAC, HASH_ALGO_SHA256);
> +}
>  EXPORT_SYMBOL(tpm2_start_auth_session);
> =20
> +/**
> + * tpm2_start_policy_session - create a policy session with the TPM
> + * @chip: the TPM chip structure to create the session with
> + * @handle: the policy session handle
> + * @hash: the crypto subsystem hash algorithm for the policy
> + *
> + * This function loads the NULL seed from its saved context and starts
> + * a policy session on the null seed, fills in the @chip->auth
> + * structure to contain all the session details necessary for
> + * performing the HMAC, encrypt and decrypt operations and returns.
> + * The NULL seed is flushed before this function returns.
> + *
> + * Note the hash algorthim has to match the name algorithm of the TPM
> + * object the policy will be used to authorize.
> + *
> + * Return: zero on success or actual error encountered.
> + */
> +int tpm2_start_policy_session(struct tpm_chip *chip, u32 *handle, u8 has=
h)
> +{
> +	int rc;
> +
> +	rc =3D __tpm2_start_session(chip, TPM2_SE_POLICY, hash);
> +	if (rc)
> +		return rc;
> +
> +	*handle =3D chip->auth->handle;
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL(tpm2_start_policy_session);
> +
>  /**
>   * tpm2_parse_create_primary() - parse the data returned from TPM_CC_CRE=
ATE_PRIMARY
>   *
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 07f532456a0c..dc2dd98cf104 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -560,6 +560,7 @@ static inline void tpm_buf_append_empty_auth(struct t=
pm_buf *buf, u32 handle)
>  #ifdef CONFIG_TCG_TPM2_HMAC
> =20
>  int tpm2_start_auth_session(struct tpm_chip *chip);
> +int tpm2_start_policy_session(struct tpm_chip *chip, u32 *handle, u8 has=
h);
>  void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  			 u32 handle, u8 *name);
>  void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *=
buf,
> @@ -585,6 +586,11 @@ static inline int tpm2_start_auth_session(struct tpm=
_chip *chip)
>  {
>  	return 0;
>  }
> +static inline int tpm2_start_policy_session(struct tpm_chip *chip, u32 *=
handle,
> +					    u8 hash)
> +{
> +	return -EINVAL;
> +}
>  static inline void tpm2_end_auth_session(struct tpm_chip *chip)
>  {
>  }


BR, Jarkko

