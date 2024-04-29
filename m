Return-Path: <linux-integrity+bounces-2287-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7780E8B65F5
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E337D1F21F5C
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F838DF2;
	Mon, 29 Apr 2024 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r162N89T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5F1E886;
	Mon, 29 Apr 2024 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431587; cv=none; b=Hr7rMCO+DuQzQTX3McyUSDVTbGw29JoLlyVj5a+IDxnf4IJlnFWKE2fNRzwIAq79ZgqAOX/i1o/7mTIFGsEHnPooi2zQa1Mm62pn8iZfojXgFsm9ygxntPdcAe5uzl8+fQ+qPIy6YybVR6B4uH2wjj/EUlcAyGeKYHzitv1UhfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431587; c=relaxed/simple;
	bh=TD6VKa2tVTUtmc0tgo5FSpb6Lfg9EK5J1/qodqxbXnw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GFdPc3BZwyQ5ZL97br1rhepeydqJnwJhI3a6oxzwr8Oi/udViY4ca0MpWw32Vv8PUWKT74T7phIihKvV26HL9nzB8d46RYoZGs0OKfawb+NGWlP8n9aGHMbgwI6HkzBZRPqCVkoc2aoZ/noYfOHAmpdH3Koo5vEeD92D07qq7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r162N89T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2ADC4AF18;
	Mon, 29 Apr 2024 22:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714431585;
	bh=TD6VKa2tVTUtmc0tgo5FSpb6Lfg9EK5J1/qodqxbXnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r162N89THD8vMuZRaz5q33v0LjvDQPX4eQL8HKy8Ec6yj7InPO1vqZqfRcv4WiNV9
	 idSxywJhs9x2udvcmAbpR17N4j9ckqmEzEWeDZmwAEAIzgDdu+pB1zxYg9V120qa66
	 bsh3EJbJ/NfPT5XM+rLKJvEF9Er711VpigRBktloFt/zda+VHDuBMA0UfLA9eRx5eF
	 40/uKik8C1uAHjWDlpdbSYE7iZNVQJ2ggi8NiqZExHUciQzKPq7Wqbx9+7xsSYDsYX
	 vZhV9NjvUhHgXnLcUR8CJGaYJZYd3ugksLXZGR4e4eEJ277n1yFxKKiFtnw+hzm/Vz
	 3IsmhEs517xrQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 01:59:43 +0300
Message-Id: <D0WZ9WCSQHOW.INP8LQ0KPRUO@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 22/22] tpm: disable the TPM if NULL name changes
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-23-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240429202811.13643-23-James.Bottomley@HansenPartnership.com>

On Mon Apr 29, 2024 at 11:28 PM EEST, James Bottomley wrote:
> Update tpm2_load_context() to return -EINVAL on integrity failures and
> use this as a signal when loading the NULL context that something
> might be wrong.  If the signal fails, check the name of the NULL
> primary against the one stored in the chip data and if there is a
> mismatch disable the TPM because it is likely to have suffered a reset
> attack.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm-chip.c      |  3 ++
>  drivers/char/tpm/tpm2-sessions.c | 77 +++++++++++++++++++++++++-------
>  drivers/char/tpm/tpm2-space.c    |  3 ++
>  include/linux/tpm.h              |  4 +-
>  4 files changed, 70 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index d93937326b2e..854546000c92 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -158,6 +158,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>  {
>  	int rc =3D -EIO;
> =20
> +	if (chip->flags & TPM_CHIP_FLAG_DISABLE)
> +		return rc;
> +
>  	get_device(&chip->dev);
> =20
>  	down_read(&chip->ops_sem);
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 3c97d3d5e00e..98819c9a0913 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -80,6 +80,9 @@
>  /* maximum number of names the TPM must remember for authorization */
>  #define AUTH_MAX_NAMES	3
> =20
> +static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
> +			       u32 *handle, u8 *name);
> +
>  /*
>   * This is the structure that carries all the auth information (like
>   * session handle, nonces, session key and auth) from use to use it is
> @@ -851,6 +854,37 @@ static int tpm2_parse_start_auth_session(struct tpm2=
_auth *auth,
>  	return 0;
>  }
> =20
> +static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
> +{
> +	int rc;
> +	unsigned int offset =3D 0; /* dummy offset for null seed context */
> +	u8 name[SHA256_DIGEST_SIZE + 2];
> +
> +	rc =3D tpm2_load_context(chip, chip->null_key_context, &offset,
> +			       null_key);
> +	if (rc !=3D -EINVAL)
> +		return rc;
> +
> +	/* an integrity failure may mean the TPM has been reset */
> +	dev_err(&chip->dev, "NULL key integrity failure!\n");
> +	/* check the null name against what we know */
> +	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
> +	if (memcmp(name, chip->null_key_name, sizeof(name)) =3D=3D 0)
> +		/* name unchanged, assume transient integrity failure */
> +		return rc;
> +	/*
> +	 * Fatal TPM failure: the NULL seed has actually changed, so
> +	 * the TPM must have been illegally reset.  All in-kernel TPM
> +	 * operations will fail because the NULL primary can't be
> +	 * loaded to salt the sessions, but disable the TPM anyway so
> +	 * userspace programmes can't be compromised by it.
> +	 */
> +	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interf=
erence\n");
> +	chip->flags |=3D TPM_CHIP_FLAG_DISABLE;
> +
> +	return rc;
> +}
> +
>  /**
>   * tpm2_start_auth_session() - create a HMAC authentication session with=
 the TPM
>   * @chip: the TPM chip structure to create the session with
> @@ -868,12 +902,9 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	struct tpm_buf buf;
>  	struct tpm2_auth *auth =3D chip->auth;
>  	int rc;
> -	/* null seed context has no offset, but we must provide one */
> -	unsigned int offset =3D 0;
> -	u32 nullkey;
> +	u32 null_key;
> =20
> -	rc =3D tpm2_load_context(chip, chip->null_key_context, &offset,
> -			       &nullkey);
> +	rc =3D tpm2_load_null(chip, &null_key);
>  	if (rc)
>  		goto out;
> =20
> @@ -884,7 +915,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  		goto out;
> =20
>  	/* salt key handle */
> -	tpm_buf_append_u32(&buf, nullkey);
> +	tpm_buf_append_u32(&buf, null_key);
>  	/* bind key handle */
>  	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
>  	/* nonce caller */
> @@ -908,7 +939,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
> =20
>  	rc =3D tpm_transmit_cmd(chip, &buf, 0, "start auth session");
> -	tpm2_flush_context(chip, nullkey);
> +	tpm2_flush_context(chip, null_key);
> =20
>  	if (rc =3D=3D TPM2_RC_SUCCESS)
>  		rc =3D tpm2_parse_start_auth_session(auth, &buf);
> @@ -930,19 +961,25 @@ EXPORT_SYMBOL(tpm2_start_auth_session);
>   * @buf:	The response buffer from the chip
>   * @handle:	pointer to be filled in with the return handle of the primar=
y
>   * @hierarchy:	The hierarchy the primary was created for
> + * @name:	pointer to be filled in with the primary key name
>   *
>   * @returns: 0 on success or a positive TPM or negative standard error
>   */
>  static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_b=
uf *buf,
> -				     u32 *handle, u32 hierarchy)
> +				     u32 *handle, u32 hierarchy, u8 *name)
>  {
>  	struct tpm_header *head =3D (struct tpm_header *)buf->data;
>  	off_t offset_r =3D TPM_HEADER_SIZE, offset_t;
>  	u16 len =3D TPM_HEADER_SIZE;
>  	u32 total_len =3D be32_to_cpu(head->length);
> -	u32 val, param_len;
> +	u32 val, param_len, keyhandle;
> +
> +	keyhandle =3D tpm_buf_read_u32(buf, &offset_r);
> +	if (handle)
> +		*handle =3D keyhandle;
> +	else
> +		tpm2_flush_context(chip, keyhandle);
> =20
> -	*handle =3D tpm_buf_read_u32(buf, &offset_r);
>  	param_len =3D tpm_buf_read_u32(buf, &offset_r);
>  	/*
>  	 * param_len doesn't include the header, but all the other
> @@ -955,9 +992,14 @@ static int tpm2_parse_create_primary(struct tpm_chip=
 *chip, struct tpm_buf *buf,
>  		return -EINVAL;
>  	len =3D tpm_buf_read_u16(buf, &offset_r);
>  	offset_t =3D offset_r;
> -	/* now we have the public area, compute the name of the object */
> -	put_unaligned_be16(TPM_ALG_SHA256, chip->null_key_name);
> -	sha256(&buf->data[offset_r], len, chip->null_key_name + 2);
> +	if (name) {
> +		/*
> +		 * now we have the public area, compute the name of
> +		 * the object
> +		 */
> +		put_unaligned_be16(TPM_ALG_SHA256, name);
> +		sha256(&buf->data[offset_r], len, name + 2);
> +	}
> =20
>  	/* validate the public key */
>  	val =3D tpm_buf_read_u16(buf, &offset_t);
> @@ -1086,6 +1128,7 @@ static int tpm2_parse_create_primary(struct tpm_chi=
p *chip, struct tpm_buf *buf,
>   * @chip:      the TPM chip to create under
>   * @hierarchy: The hierarchy handle to create under
>   * @handle:    The returned volatile handle on success
> + * @name:      The name of the returned key
>   *
>   * For platforms that might not have a persistent primary, this can be
>   * used to create one quickly on the fly (it uses Elliptic Curve not
> @@ -1097,7 +1140,7 @@ static int tpm2_parse_create_primary(struct tpm_chi=
p *chip, struct tpm_buf *buf,
>   * @returns: 0 on success or positive TPM or negative error.
>   */
>  static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
> -			       u32 *handle)
> +			       u32 *handle, u8 *name)
>  {
>  	int rc;
>  	struct tpm_buf buf;
> @@ -1187,7 +1230,8 @@ static int tpm2_create_primary(struct tpm_chip *chi=
p, u32 hierarchy,
>  			      "attempting to create NULL primary");
> =20
>  	if (rc =3D=3D TPM2_RC_SUCCESS)
> -		rc =3D tpm2_parse_create_primary(chip, &buf, handle, hierarchy);
> +		rc =3D tpm2_parse_create_primary(chip, &buf, handle, hierarchy,
> +					       name);
> =20
>  	tpm_buf_destroy(&buf);
> =20
> @@ -1199,7 +1243,8 @@ static int tpm2_create_null_primary(struct tpm_chip=
 *chip)
>  	u32 null_key;
>  	int rc;
> =20
> -	rc =3D tpm2_create_primary(chip, TPM2_RH_NULL, &null_key);
> +	rc =3D tpm2_create_primary(chip, TPM2_RH_NULL, &null_key,
> +				 chip->null_key_name);
> =20
>  	if (rc =3D=3D TPM2_RC_SUCCESS) {
>  		unsigned int offset =3D 0; /* dummy offset for null key context */
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.=
c
> index 24479a81c23c..4892d491da8d 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -105,6 +105,9 @@ int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
>  		*handle =3D 0;
>  		tpm_buf_destroy(&tbuf);
>  		return -ENOENT;
> +	} else if (tpm2_rc_value(rc) =3D=3D TPM2_RC_INTEGRITY) {
> +		tpm_buf_destroy(&tbuf);
> +		return -EINVAL;
>  	} else if (rc > 0) {
>  		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
>  			 __func__, rc);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index dd4d6a6158c4..c17e4efbb2e5 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -248,6 +248,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_SUCCESS		=3D 0x0000,
>  	TPM2_RC_HASH		=3D 0x0083, /* RC_FMT1 */
>  	TPM2_RC_HANDLE		=3D 0x008B,
> +	TPM2_RC_INTEGRITY	=3D 0x009F,
>  	TPM2_RC_INITIALIZE	=3D 0x0100, /* RC_VER1 */
>  	TPM2_RC_FAILURE		=3D 0x0101,
>  	TPM2_RC_DISABLED	=3D 0x0120,
> @@ -346,6 +347,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		=3D BIT(7),
>  	TPM_CHIP_FLAG_SUSPENDED			=3D BIT(8),
>  	TPM_CHIP_FLAG_HWRNG_DISABLED		=3D BIT(9),
> +	TPM_CHIP_FLAG_DISABLE			=3D BIT(10),
>  };
> =20
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> @@ -447,7 +449,7 @@ static inline bool tpm_is_firmware_upgrade(struct tpm=
_chip *chip)
> =20
>  static inline u32 tpm2_rc_value(u32 rc)
>  {
> -	return (rc & BIT(7)) ? rc & 0xff : rc;
> +	return (rc & BIT(7)) ? rc & 0xbf : rc;

Bit 6 is set for TPM2_RC_INTEGRITY and thus you needed to
mask it out, as it is set given the handle, right? Just
sanity checking that I understand the change.

>  }
> =20
>  #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)

BR, Jarkko

