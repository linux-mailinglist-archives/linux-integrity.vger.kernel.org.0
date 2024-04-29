Return-Path: <linux-integrity+bounces-2284-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17D8B65D6
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 00:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9391F22586
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1613AEE;
	Mon, 29 Apr 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyLK6Z9b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7D364;
	Mon, 29 Apr 2024 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430316; cv=none; b=cdj5J7gk1EKmbnmEFay/UKQULX4rMnNOzOisSYyWGvy6lyWCvQoXjym+W9C6X6MndXhaOwV+e4IknRRQ34ONwHA+7U/PKT88821//dYZYAIAOmCx1scXosjDo/2D0TDS15OVkNnlghdLnIQ6SJMAoQcyBVOuWJxa5eUMJRz2ESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430316; c=relaxed/simple;
	bh=RuaVaY/vtjcXibRYSWXbHXhV9WbAK08d8eSe1j+EK6k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IiIIlekXZbx7MEsPRqTbH1bvX+PtUDGDjIMDTQjvr3A7t3Iy5fUNWdsijrRgjpNiygkWb8BoShNfTmIP55SBYhoEe2esi0h+x4zhGdAl50xs6UZa56r96IL7wCCCeaoUJW+PCroxEFlZpGXg7LGihxH7l2V9O4A8yg2mZ3f1rgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyLK6Z9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6B6C113CD;
	Mon, 29 Apr 2024 22:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430315;
	bh=RuaVaY/vtjcXibRYSWXbHXhV9WbAK08d8eSe1j+EK6k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WyLK6Z9bOYWmf9FTuNwdyLZa6mgHK/9QnUM1zCL7GpE/R7f+eFlqjv9QEU/WMgc+E
	 MzElyLcZlgm10sWsWRnaXZfnRbs0dpFxyqHk88ACXNnaTG/ut+/8HLZ41RaNvSZGMt
	 ZtwC5K5wvlCjCqlJpRLc7vFW4uEwB+yBikpfK+36p8w59KbPBNnXRfTuKMsa4GdXXO
	 8Gn1LTlOgpAHsuKuO62UKctrtaqcQSZ4JDAN6k4NenF/EDZRylFOEkbZ+OwdY4hTdu
	 zaE6u0rO93GoOjyGik9wY3D9qSvj3aO86Qz3EtM7XA1/MdsikIXrjNZOLmJRHbIK3P
	 rIDi4u0exfxXg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 01:38:32 +0300
Message-Id: <D0WYTOKL09CG.1DUNVLEQWLA07@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 14/22] tpm: Add HMAC session start and end functions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-15-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240429202811.13643-15-James.Bottomley@HansenPartnership.com>

On Mon Apr 29, 2024 at 11:28 PM EEST, James Bottomley wrote:
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
> v8: cosmetic changes, split out KDFe and KDFa
> ---
>  drivers/char/tpm/Kconfig         |   2 +
>  drivers/char/tpm/tpm-buf.c       |   1 +
>  drivers/char/tpm/tpm-chip.c      |   3 +
>  drivers/char/tpm/tpm2-sessions.c | 285 +++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  34 ++++
>  5 files changed, 325 insertions(+)
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 4873e6eae255..cecf617c9c90 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -30,6 +30,8 @@ if TCG_TPM
>  config TCG_TPM2_HMAC
>  	bool "Use HMAC and encrypted transactions on the TPM bus"
>  	default y
> +	select CRYPTO_ECDH
> +	select CRYPTO_LIB_AESCFB
>  	select CRYPTO_LIB_SHA256
>  	help
>  	  Setting this causes us to deploy a scheme which uses request
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
> index 8429e596f1eb..71b3c0e75760 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -3,13 +3,101 @@
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
> +#include <linux/random.h>
> +#include <linux/scatterlist.h>
>  #include <asm/unaligned.h>
> +#include <crypto/kpp.h>
> +#include <crypto/ecdh.h>
>  #include <crypto/hash.h>
>  #include <crypto/hmac.h>
> =20
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
> +	 * after that it can be used as a scratch area
> +	 */
> +	union {
> +		u8 salt[EC_PT_SZ];
> +		/* scratch for key + IV */
> +		u8 scratch[AES_KEY_BYTES + AES_BLOCK_SIZE];
> +	};
> +	u8 session_key[SHA256_DIGEST_SIZE];
> +};
> +
>  /*
>   * It turns out the crypto hmac(sha256) is hard for us to consume
>   * because it assumes a fixed key and the TPM seems to change the key
> @@ -113,6 +201,199 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *s=
tr, u8 *pt_u, u8 *pt_v,
>  	sha256_final(&sctx, out);
>  }
> =20
> +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *ch=
ip)
> +{
> +	struct crypto_kpp *kpp;
> +	struct kpp_request *req;
> +	struct scatterlist s[2], d[1];
> +	struct ecdh p =3D {0};
> +	u8 encoded_key[EC_PT_SZ], *x, *y;
> +	unsigned int buf_len;
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
> +	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
> +		  chip->auth->salt);
> +
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
> +	tpm2_KDFa(auth->salt, sizeof(auth->salt), "ATH", auth->tpm_nonce,
> +		  auth->our_nonce, sizeof(auth->session_key),
> +		  auth->session_key);
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
> +	/* null seed context has no offset, but we must provide one */
> +	unsigned int offset =3D 0;
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
> +	tpm_buf_append_u16(&buf, AES_KEY_BITS);
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
> +
>  /**
>   * tpm2_parse_create_primary() - parse the data returned from TPM_CC_CRE=
ATE_PRIMARY
>   *
> @@ -417,5 +698,9 @@ int tpm2_sessions_init(struct tpm_chip *chip)
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
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index bc8c9a350e23..81b5a70ff80d 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -31,6 +31,14 @@
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
> @@ -203,6 +211,7 @@ struct tpm_chip {
>  	u8 null_key_name[TPM2_NAME_SIZE];
>  	u8 null_ec_key_x[EC_PT_SZ];
>  	u8 null_ec_key_y[EC_PT_SZ];
> +	struct tpm2_auth *auth;
>  #endif
>  };
> =20
> @@ -266,6 +275,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
>  	TPM2_CC_CONTEXT_SAVE	        =3D 0x0162,
>  	TPM2_CC_FLUSH_CONTEXT	        =3D 0x0165,
> +	TPM2_CC_START_AUTH_SESS		=3D 0x0176,
>  	TPM2_CC_VERIFY_SIGNATURE        =3D 0x0177,
>  	TPM2_CC_GET_CAPABILITY	        =3D 0x017A,
>  	TPM2_CC_GET_RANDOM	        =3D 0x017B,
> @@ -349,16 +359,21 @@ struct tpm_buf {
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
>  /*
> @@ -378,6 +393,11 @@ enum tpm2_object_attributes {
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
> @@ -469,4 +489,18 @@ static inline void tpm_buf_append_empty_auth(struct =
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

This is IMHO now also good enough.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

