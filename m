Return-Path: <linux-integrity+bounces-1423-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55128618B8
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 18:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECBB1F260C2
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2D1292C6;
	Fri, 23 Feb 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da9yC4NZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C572128391;
	Fri, 23 Feb 2024 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707768; cv=none; b=pn1l56b8HpTDa4uDBoHRZNjibNdRp+8RYkko33dtcFJuYA+Q13m/H7c2alldZTymyNWZ1/aX+bf55Zc3ohp89hC4A9pW3WHOENKyz73QonJK9cr94j7nHaRNfBqt9X9X85udmarg/T7xI+dfDZSjmYFs1NOX2K06aZbKfA0sPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707768; c=relaxed/simple;
	bh=tjWS1F6UAtbZEQBKNUGI+gsKszh9ZXKpuaXruXEk8zM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jo327AbywXcx0fVRbR0SG9pTPkK0V+HzNsZw1wPqWWGvgALa9JkcN0kVR+m39Y62VCZ6i0k3f6K87qX6E9ntB+azEk9nlaAVq8BXifMSDflYHG3uhzkd8/XAEE0weJR27CtyxJcAUJHF4e9Dr52nQ6ZRJknsnDEFd9MtrzMysc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da9yC4NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A37EC433C7;
	Fri, 23 Feb 2024 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708707768;
	bh=tjWS1F6UAtbZEQBKNUGI+gsKszh9ZXKpuaXruXEk8zM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=da9yC4NZLyOT441zwADOMsjJwVHgbdBKZXgScetWXtBGxYumBiIQfjh+AmF7bYXE0
	 NT4Awhmn01ej/j6UAvYD44fceRyvSQmfp4M5ylzEtSoOdC6f9Ljh4vvwP8DY6XCBIY
	 vN6vOtWrVOakLBbs9ebF5MIYwLgzmP/jV/qHrqNaQRTIXCsCEkGd8e3xOoKvQn64kR
	 vywgFQPGIUcq+h+LR96VyzXyGMkUrY20HEFNfv7p8d5J9SkHdeOPDMXh4DOtDMruBW
	 0kKxo7Da1+olkbZjXmF994f0XFENNOZBv9FieMEQ9rM6ryJMnfDnhq9nDoz0q2ZcMa
	 xnkgnVXajbZMA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 19:02:44 +0200
Message-Id: <CZCMCMKGO4VZ.1Y7FUSYH48DUR@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 13/21] tpm: Add HMAC session start and end functions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-14-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240213171334.30479-14-James.Bottomley@HansenPartnership.com>

On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
> Add session  based HMAC  authentication plus parameter  decryption and
> response encryption  using AES. The  basic design is to  segregate all
> the nasty crypto, hash and hmac code into tpm2-sessions.c and export a
> usable API.  The API first of all starts off by gaining a session with
> tpm2_start_auth_session() which  initiates a session with  the TPM and
> allocates  an  opaque  tpm2_auth   structure  to  handle  the  session
> parameters.  The  design is that  session use will be  single threaded
> from start to finish under the ops lock, so the tpm2_auth structure is
> stored in struct tpm2_chip to simpify the externally visible API.
>
> The session can be ended with tpm2_end_auth_session() which is
> designed only to be used in error legs.  Ordinarily the further
> session API (future patches) will end or continue the session
> appropriately without having to call this.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API part=
s
>
> ---
>
> v6: split into new patch, update config variable
> v7: add tpm2_ prefix and memzero_explicit
> ---
>  drivers/char/tpm/Kconfig         |   3 +
>  drivers/char/tpm/tpm-buf.c       |   1 +
>  drivers/char/tpm/tpm-chip.c      |   3 +
>  drivers/char/tpm/tpm2-sessions.c | 385 +++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  34 +++
>  5 files changed, 426 insertions(+)
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index e3c39a83171b..086cb8588493 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -30,6 +30,9 @@ if TCG_TPM
>  config TCG_TPM2_HMAC
>  	bool "Use encrypted and HMACd transactions on the TPM bus"
>  	default y
> +	select CRYPTO_ECDH
> +	select CRYPTO_LIB_AESCFB
> +	select CRYPTO_LIB_SHA256
>  	help
>            Setting this causes us to deploy a scheme which uses request
>  	  and response HMACs in addition to encryption for
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index bb81180495d1..274130398569 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -44,6 +44,7 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 or=
dinal)
>  	head->tag =3D cpu_to_be16(tag);
>  	head->length =3D cpu_to_be32(sizeof(*head));
>  	head->ordinal =3D cpu_to_be32(ordinal);
> +	buf->handles =3D 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_reset);
> =20
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 42b1062e33cd..d93937326b2e 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -275,6 +275,9 @@ static void tpm_dev_release(struct device *dev)
>  	kfree(chip->work_space.context_buf);
>  	kfree(chip->work_space.session_buf);
>  	kfree(chip->allocated_banks);
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +	kfree(chip->auth);
> +#endif
>  	kfree(chip);
>  }
> =20
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 9fc263ee02c2..c8792a6b8bd4 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -3,18 +3,399 @@
>  /*
>   * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
>   *
> + * Cryptographic helper routines for handling TPM2 sessions for
> + * authorization HMAC and request response encryption.
> + *
> + * The idea is to ensure that every TPM command is HMAC protected by a
> + * session, meaning in-flight tampering would be detected and in
> + * addition all sensitive inputs and responses should be encrypted.
> + *
> + * The basic way this works is to use a TPM feature called salted
> + * sessions where a random secret used in session construction is
> + * encrypted to the public part of a known TPM key.  The problem is we
> + * have no known keys, so initially a primary Elliptic Curve key is
> + * derived from the NULL seed (we use EC because most TPMs generate
> + * these keys much faster than RSA ones).  The curve used is NIST_P256
> + * because that's now mandated to be present in 'TCG TPM v2.0
> + * Provisioning Guidance'
> + *
> + * Threat problems: the initial TPM2_CreatePrimary is not (and cannot
> + * be) session protected, so a clever Man in the Middle could return a
> + * public key they control to this command and from there intercept
> + * and decode all subsequent session based transactions.  The kernel
> + * cannot mitigate this threat but, after boot, userspace can get
> + * proof this has not happened by asking the TPM to certify the NULL
> + * key.  This certification would chain back to the TPM Endorsement
> + * Certificate and prove the NULL seed primary had not been tampered
> + * with and thus all sessions must have been cryptographically secure.
> + * To assist with this, the initial NULL seed public key name is made
> + * available in a sysfs file.
> + *
> + * Use of these functions:
> + *
> + * The design is all the crypto, hash and hmac gunk is confined in this
> + * file and never needs to be seen even by the kernel internal user.  To
> + * the user there's an init function tpm2_sessions_init() that needs to
> + * be called once per TPM which generates the NULL seed primary key.
> + *
> + * These are the usage functions:
> + *
> + * tpm2_start_auth_session() which allocates the opaque auth structure
> + *	and gets a session from the TPM.  This must be called before
> + *	any of the following functions.  The session is protected by a
> + *	session_key which is derived from a random salt value
> + *	encrypted to the NULL seed.
> + * tpm2_end_auth_session() kills the session and frees the resources.
> + *	Under normal operation this function is done by
> + *	tpm_buf_check_hmac_response(), so this is only to be used on
> + *	error legs where the latter is not executed.
>   */
> =20
>  #include "tpm.h"
> =20
> +#include <linux/random.h>
> +#include <linux/scatterlist.h>
> +
>  #include <asm/unaligned.h>
> =20
>  #include <crypto/aes.h>
> +#include <crypto/kpp.h>
> +#include <crypto/ecdh.h>
> +#include <crypto/hash.h>
> +#include <crypto/hmac.h>
> =20
>  /* if you change to AES256, you only need change this */
>  #define AES_KEYBYTES	AES_KEYSIZE_128
> =20
>  #define AES_KEYBITS	(AES_KEYBYTES*8)
> +#define AUTH_MAX_NAMES	3
> +
> +/*
> + * This is the structure that carries all the auth information (like
> + * session handle, nonces, session key and auth) from use to use it is
> + * designed to be opaque to anything outside.
> + */
> +struct tpm2_auth {
> +	u32 handle;
> +	/*
> +	 * This has two meanings: before tpm_buf_fill_hmac_session()
> +	 * it marks the offset in the buffer of the start of the
> +	 * sessions (i.e. after all the handles).  Once the buffer has
> +	 * been filled it markes the session number of our auth
> +	 * session so we can find it again in the response buffer.
> +	 *
> +	 * The two cases are distinguished because the first offset
> +	 * must always be greater than TPM_HEADER_SIZE and the second
> +	 * must be less than or equal to 5.
> +	 */
> +	u32 session;
> +	/*
> +	 * the size here is variable and set by the size of our_nonce
> +	 * which must be between 16 and the name hash length. we set
> +	 * the maximum sha256 size for the greatest protection
> +	 */
> +	u8 our_nonce[SHA256_DIGEST_SIZE];
> +	u8 tpm_nonce[SHA256_DIGEST_SIZE];
> +	/*
> +	 * the salt is only used across the session command/response
           ~
	   T
=20

> +	 * after that it can be used as a scratch area
                                                     ~
						     a.

> +	 */
> +	union {
> +		u8 salt[EC_PT_SZ];
> +		/* scratch for key + IV */
> +		u8 scratch[AES_KEYBYTES + AES_BLOCK_SIkkkZE];
> +	};
> +	u8 session_key[SHA256_DIGEST_SIZE];
> +};
> +
> +/*
> + * It turns out the crypto hmac(sha256) is hard for us to consume
> + * because it assumes a fixed key and the TPM seems to change the key
> + * on every operation, so we weld the hmac init and final functions in
> + * here to give it the same usage characteristics as a regular hash
> + */
> +static void hmac_init(struct sha256_state *sctx, u8 *key, int keylen)

tpm_*

there's too many hmac sites in the kernel so it would be nice to git
grep these easily in the future.

> +{
> +	u8 pad[SHA256_BLOCK_SIZE];
> +	int i;
> +
> +	sha256_init(sctx);
> +	for (i =3D 0; i < sizeof(pad); i++) {
> +		if (i < keylen)
> +			pad[i] =3D key[i];
> +		else
> +			pad[i] =3D 0;
> +		pad[i] ^=3D HMAC_IPAD_VALUE;
> +	}
> +	sha256_update(sctx, pad, sizeof(pad));
> +}
> +
> +static void hmac_final(struct sha256_state *sctx, u8 *key, int keylen, u=
8 *out)

tpm_*

> +{
> +	u8 pad[SHA256_BLOCK_SIZE];
> +	int i;
> +
> +	for (i =3D 0; i < sizeof(pad); i++) {
> +		if (i < keylen)
> +			pad[i] =3D key[i];
> +		else
> +			pad[i] =3D 0;
> +		pad[i] ^=3D HMAC_OPAD_VALUE;
> +	}
> +
> +	/* collect the final hash;  use out as temporary storage */
> +	sha256_final(sctx, out);
> +
> +	sha256_init(sctx);
> +	sha256_update(sctx, pad, sizeof(pad));
> +	sha256_update(sctx, out, SHA256_DIGEST_SIZE);
> +	sha256_final(sctx, out);
> +}
> +
> +/*
> + * assume hash sha256 and nonces u, v of size SHA256_DIGEST_SIZE but
      ~
      A

> + * otherwise standard KDFa.  Note output is in bytes not bits.
> + */
> +static void KDFa(u8 *key, int keylen, const char *label, u8 *u,
                                 ~~~~~~
				 key_len


tpm_* prefix

> +		 u8 *v, int bytes, u8 *out)

Why bytes is a signed type? Does it need to be multiple of
something?

> +{
> +	u32 counter;
> +	const __be32 bits =3D cpu_to_be32(bytes * 8);
> +
> +	for (counter =3D 1; bytes > 0; bytes -=3D SHA256_DIGEST_SIZE, counter++=
,
> +		     out +=3D SHA256_DIGEST_SIZE) {

Let's open code this:

	counter =3D 1;
	while (bytes > 0) {
		/* ... */

		bytes -=3D SHA256_DIGEST_SIZE;
		out +=3D SHA256_DIGEST_SIZE;
		counter++;
	}

I'd figure that this requires one index, not three. Others
have linear relation? The for-loop construc is too cryptic.

> +		struct sha256_state sctx;
> +		__be32 c =3D cpu_to_be32(counter);
> +
> +		hmac_init(&sctx, key, keylen);
> +		sha256_update(&sctx, (u8 *)&c, sizeof(c));
> +		sha256_update(&sctx, label, strlen(label)+1);
> +		sha256_update(&sctx, u, SHA256_DIGEST_SIZE);
> +		sha256_update(&sctx, v, SHA256_DIGEST_SIZE);
> +		sha256_update(&sctx, (u8 *)&bits, sizeof(bits));
> +		hmac_final(&sctx, key, keylen, out);
> +	}
> +}
> +
> +/*
> + * Somewhat of a bastardization of the real KDFe.  We're assuming
> + * we're working with known point sizes for the input parameters and
> + * the hash algorithm is fixed at sha256.  Because we know that the
> + * point size is 32 bytes like the hash size, there's no need to loop
> + * in this KDF.
> + */
> +static void KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
> +		 u8 *keyout)
 		     ~~~~~~~
		     the previous function had 'out'. why the name
		     change?

tpm_*

> +{
> +	struct sha256_state sctx;
> +	/*
> +	 * this should be an iterative counter, but because we know
> +	 *  we're only taking 32 bytes for the point using a sha256
> +	 *  hash which is also 32 bytes, there's only one loop
> +	 */
> +	__be32 c =3D cpu_to_be32(1);
> +
> +	sha256_init(&sctx);
> +	/* counter (BE) */
> +	sha256_update(&sctx, (u8 *)&c, sizeof(c));
> +	/* secret value */
> +	sha256_update(&sctx, z, EC_PT_SZ);
> +	/* string including trailing zero */
> +	sha256_update(&sctx, str, strlen(str)+1);
> +	sha256_update(&sctx, pt_u, EC_PT_SZ);
> +	sha256_update(&sctx, pt_v, EC_PT_SZ);
> +	sha256_final(&sctx, keyout);
> +}
> +
> +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *ch=
ip)
> +{
> +	struct crypto_kpp *kpp;
> +	struct kpp_request *req;
> +	struct scatterlist s[2], d[1];
> +	struct ecdh p =3D {0};
> +	u8 encoded_key[EC_PT_SZ], *x, *y;
> +	unsigned int buf_len;

i'd prefer the reverse christmas tree order

> +
> +	/* secret is two sized points */
> +	tpm_buf_append_u16(buf, (EC_PT_SZ + 2)*2);
> +	/*
> +	 * we cheat here and append uninitialized data to form
> +	 * the points.  All we care about is getting the two
> +	 * co-ordinate pointers, which will be used to overwrite
> +	 * the uninitialized data
> +	 */
> +	tpm_buf_append_u16(buf, EC_PT_SZ);
> +	x =3D &buf->data[tpm_buf_length(buf)];
> +	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
> +	tpm_buf_append_u16(buf, EC_PT_SZ);
> +	y =3D &buf->data[tpm_buf_length(buf)];
> +	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
> +	sg_init_table(s, 2);
> +	sg_set_buf(&s[0], x, EC_PT_SZ);
> +	sg_set_buf(&s[1], y, EC_PT_SZ);
> +
> +	kpp =3D crypto_alloc_kpp("ecdh-nist-p256", CRYPTO_ALG_INTERNAL, 0);
> +	if (IS_ERR(kpp)) {
> +		dev_err(&chip->dev, "crypto ecdh allocation failed\n");
> +		return;
> +	}
> +
> +	buf_len =3D crypto_ecdh_key_len(&p);
> +	if (sizeof(encoded_key) < buf_len) {
> +		dev_err(&chip->dev, "salt buffer too small needs %d\n",
> +			buf_len);
> +		goto out;
> +	}
> +	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
> +	/* this generates a random private key */
> +	crypto_kpp_set_secret(kpp, encoded_key, buf_len);
> +
> +	/* salt is now the public point of this private key */
> +	req =3D kpp_request_alloc(kpp, GFP_KERNEL);
> +	if (!req)
> +		goto out;
> +	kpp_request_set_input(req, NULL, 0);
> +	kpp_request_set_output(req, s, EC_PT_SZ*2);
> +	crypto_kpp_generate_public_key(req);
> +	/*
> +	 * we're not done: now we have to compute the shared secret
> +	 * which is our private key multiplied by the tpm_key public
> +	 * point, we actually only take the x point and discard the y
> +	 * point and feed it through KDFe to get the final secret salt
> +	 */
> +	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
> +	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
> +	kpp_request_set_input(req, s, EC_PT_SZ*2);
> +	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
> +	kpp_request_set_output(req, d, EC_PT_SZ);
> +	crypto_kpp_compute_shared_secret(req);
> +	kpp_request_free(req);
> +
> +	/*
> +	 * pass the shared secret through KDFe for salt. Note salt
> +	 * area is used both for input shared secret and output salt.
> +	 * This works because KDFe fully consumes the secret before it
> +	 * writes the salt
> +	 */
> +	KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
> +	     chip->auth->salt);

empty line missing before the label

> + out:
> +	crypto_free_kpp(kpp);
> +}
> +/**
> + * tpm2_end_auth_session() - kill the allocated auth session
> + * @chip: the TPM chip structure
> + *
> + * ends the session started by tpm2_start_auth_session and frees all
> + * the resources.  Under normal conditions,
> + * tpm_buf_check_hmac_response() will correctly end the session if
> + * required, so this function is only for use in error legs that will
> + * bypass the normal invocation of tpm_buf_check_hmac_response().
> + */
> +void tpm2_end_auth_session(struct tpm_chip *chip)
> +{
> +	tpm2_flush_context(chip, chip->auth->handle);
> +	memzero_explicit(chip->auth, sizeof(*chip->auth));
> +}
> +EXPORT_SYMBOL(tpm2_end_auth_session);
> +
> +static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
> +					 struct tpm_buf *buf)
> +{
> +	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> +	u32 tot_len =3D be32_to_cpu(head->length);
> +	off_t offset =3D TPM_HEADER_SIZE;
> +	u32 val;
> +
> +	/* we're starting after the header so adjust the length */
> +	tot_len -=3D TPM_HEADER_SIZE;
> +
> +	/* should have handle plus nonce */
> +	if (tot_len !=3D 4 + 2 + sizeof(auth->tpm_nonce))
> +		return -EINVAL;
> +
> +	auth->handle =3D tpm_buf_read_u32(buf, &offset);
> +	val =3D tpm_buf_read_u16(buf, &offset);
> +	if (val !=3D sizeof(auth->tpm_nonce))
> +		return -EINVAL;
> +	memcpy(auth->tpm_nonce, &buf->data[offset], sizeof(auth->tpm_nonce));
> +	/* now compute the session key from the nonces */
> +	KDFa(auth->salt, sizeof(auth->salt), "ATH", auth->tpm_nonce,
> +	     auth->our_nonce, sizeof(auth->session_key), auth->session_key);
> +
> +	return 0;
> +}
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
> +	struct tpm_buf buf;
> +	struct tpm2_auth *auth =3D chip->auth;
> +	int rc;
> +	unsigned int offset =3D 0; /* dummy offset for null seed context */

What does the comment is trying to say to me? Should be
in its own line.

> +	u32 nullkey;
> +
> +	rc =3D tpm2_load_context(chip, chip->null_key_context, &offset,
> +			       &nullkey);
> +	if (rc)
> +		goto out;
> +
> +	auth->session =3D TPM_HEADER_SIZE;
> +
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS)=
;
> +	if (rc)
> +		goto out;
> +
> +	/* salt key handle */
> +	tpm_buf_append_u32(&buf, nullkey);
> +	/* bind key handle */
> +	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
> +	/* nonce caller */
> +	get_random_bytes(auth->our_nonce, sizeof(auth->our_nonce));
> +	tpm_buf_append_u16(&buf, sizeof(auth->our_nonce));
> +	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
> +
> +	/* append encrypted salt and squirrel away unencrypted in auth */
> +	tpm_buf_append_salt(&buf, chip);
> +	/* session type (HMAC, audit or policy) */
> +	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
> +
> +	/* symmetric encryption parameters */
> +	/* symmetric algorithm */
> +	tpm_buf_append_u16(&buf, TPM_ALG_AES);
> +	/* bits for symmetric algorithm */
> +	tpm_buf_append_u16(&buf, AES_KEYBITS);
> +	/* symmetric algorithm mode (must be CFB) */
> +	tpm_buf_append_u16(&buf, TPM_ALG_CFB);
> +	/* hash algorithm for session */
> +	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
> +
> +	rc =3D tpm_transmit_cmd(chip, &buf, 0, "start auth session");
> +	tpm2_flush_context(chip, nullkey);
> +
> +	if (rc =3D=3D TPM2_RC_SUCCESS)
> +		rc =3D tpm2_parse_start_auth_session(auth, &buf);
> +
> +	tpm_buf_destroy(&buf);
> +
> +	if (rc)
> +		goto out;
> +
> + out:
> +	return rc;
> +}
> +EXPORT_SYMBOL(tpm2_start_auth_session);
> =20
>  static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_b=
uf *buf,
>  				     u32 *nullkey)
	=09

What if this was simply tpm2_create_primary?


> @@ -271,6 +652,10 @@ int tpm2_sessions_init(struct tpm_chip *chip)
>  	if (rc)
>  		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n=
", rc);
> =20
> +	chip->auth =3D kmalloc(sizeof(*chip->auth), GFP_KERNEL);
> +	if (!chip->auth)
> +		return -ENOMEM;
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL(tpm2_sessions_init);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 3060ab794afb..444f0a83682a 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -30,6 +30,14 @@
>  struct tpm_chip;
>  struct trusted_key_payload;
>  struct trusted_key_options;
> +/* opaque structure, holds auth session parameters like the session key =
*/
> +struct tpm2_auth;
> +
> +enum tpm2_session_types {
> +	TPM2_SE_HMAC	=3D 0x00,
> +	TPM2_SE_POLICY	=3D 0x01,
> +	TPM2_SE_TRIAL	=3D 0x02,
> +};
> =20
>  /* if you add a new hash to this, increment TPM_MAX_HASHES below */
>  enum tpm_algorithms {
> @@ -199,6 +207,7 @@ struct tpm_chip {
>  	u8 null_key_name[TPM2_NAME_SIZE];	 /* name of NULL seed */
>  	u8 null_ec_key_x[EC_PT_SZ];
>  	u8 null_ec_key_y[EC_PT_SZ];
> +	struct tpm2_auth *auth;
>  #endif
>  };
> =20
> @@ -262,6 +271,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
>  	TPM2_CC_CONTEXT_SAVE	        =3D 0x0162,
>  	TPM2_CC_FLUSH_CONTEXT	        =3D 0x0165,
> +	TPM2_CC_START_AUTH_SESS		=3D 0x0176,
>  	TPM2_CC_VERIFY_SIGNATURE        =3D 0x0177,
>  	TPM2_CC_GET_CAPABILITY	        =3D 0x017A,
>  	TPM2_CC_GET_RANDOM	        =3D 0x017B,
> @@ -345,20 +355,30 @@ struct tpm_buf {
>  	u32 flags;
>  	u32 length;
>  	u8 *data;
> +	u8 handles;
>  };
> =20
>  enum tpm2_object_attributes {
>  	TPM2_OA_FIXED_TPM		=3D BIT(1),
> +	TPM2_OA_ST_CLEAR		=3D BIT(2),
>  	TPM2_OA_FIXED_PARENT		=3D BIT(4),
>  	TPM2_OA_SENSITIVE_DATA_ORIGIN	=3D BIT(5),
>  	TPM2_OA_USER_WITH_AUTH		=3D BIT(6),
> +	TPM2_OA_ADMIN_WITH_POLICY	=3D BIT(7),
>  	TPM2_OA_NO_DA			=3D BIT(10),
> +	TPM2_OA_ENCRYPTED_DUPLICATION	=3D BIT(11),
>  	TPM2_OA_RESTRICTED		=3D BIT(16),
>  	TPM2_OA_DECRYPT			=3D BIT(17),
> +	TPM2_OA_SIGN			=3D BIT(18),
>  };
> =20
>  enum tpm2_session_attributes {
>  	TPM2_SA_CONTINUE_SESSION	=3D BIT(0),
> +	TPM2_SA_AUDIT_EXCLUSIVE		=3D BIT(1),
> +	TPM2_SA_AUDIT_RESET		=3D BIT(3),
> +	TPM2_SA_DECRYPT			=3D BIT(5),
> +	TPM2_SA_ENCRYPT			=3D BIT(6),
> +	TPM2_SA_AUDIT			=3D BIT(7),
>  };
> =20
>  struct tpm2_hash {
> @@ -449,4 +469,18 @@ static inline void tpm_buf_append_empty_auth(struct =
tpm_buf *buf, u32 handle)
>  {
>  }
>  #endif
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +
> +int tpm2_start_auth_session(struct tpm_chip *chip);
> +void tpm2_end_auth_session(struct tpm_chip *chip);
> +#else
> +static inline int tpm2_start_auth_session(struct tpm_chip *chip)
> +{
> +	return 0;
> +}
> +static inline void tpm2_end_auth_session(struct tpm_chip *chip)
> +{
> +}
> +#endif	/* CONFIG_TCG_TPM2_HMAC */
> +
>  #endif


BR, Jarkko

