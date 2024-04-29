Return-Path: <linux-integrity+bounces-2285-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2648B65D9
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 00:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B231F22718
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14153179AF;
	Mon, 29 Apr 2024 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o05N/eXE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC713AEE;
	Mon, 29 Apr 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430340; cv=none; b=Z+AYV7RuOEb5BzFNjzIC78y7c3CHquC25zX3r7zy6NZcEDEsTnnJchFBHaRpcVr5nUhxOQMvmXzd0cAEOQzpO6M2IWq+9K4c6yctVXfxig/jFVjRUjNsY0aMRbmxn2iYnX2DNyiIc4lT0oAgWljNsgiMqJU/Y9+9nifZ1eqLvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430340; c=relaxed/simple;
	bh=9aqkKNOOBVkM8i3QFExkaS9khspphygJ8Z37BEI+olI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UnQvrAVfJ2sK/k/Dnlpy/iHidXvesb9r7KgWTfojknhC9dEWJwsnabqkKMfiTQKLKW1OVbdm74HyXX1rs9SqhoQTw6wXe8YAc5rQpKjEQDGWNf3o0+4mV0aIk4FOQ8uIWM85RYMWaQ/uSocc3x3W+a8//xw6Z2X/paj9IZEIuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o05N/eXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84521C113CD;
	Mon, 29 Apr 2024 22:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430339;
	bh=9aqkKNOOBVkM8i3QFExkaS9khspphygJ8Z37BEI+olI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=o05N/eXE5T+EsJjmnz7efbbQmQpl6I0HwsgmkaddyV/WgHCAUf/2YAumvavwF2PuU
	 PbllLWC6UvzecPtWEj7yEKzHwZdIKTHKKkDe+CEUBKj7r33vsJG7e7KyGSlaetSqPE
	 Axnj/8ZziOKVVnMYeRO83Np3RMM/jMwjxifmK8Hq4bIAITf8Zit/fcRHN2GKz0pv/F
	 WqfVw6Tg05r+Xo7Og7jrZSmVxF6Kpj7wpJ5Tw2WnHVJsLsO04xxCiDWLvYSCu+wcZF
	 lPGKK++bpYPw7GwzeWGPknuDVvYZ/ccBqxcvyTLD0cAD7HCch93y/w3gNHqOhc0M51
	 Xevc/a8tR5VFQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 01:38:56 +0300
Message-Id: <D0WYTZRBJN20.3LFMI68DA5LZD@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 15/22] tpm: Add HMAC session name/handle append
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-16-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240429202811.13643-16-James.Bottomley@HansenPartnership.com>

On Mon Apr 29, 2024 at 11:28 PM EEST, James Bottomley wrote:
> Add tpm2_append_name() for appending to the handle area of the TPM
> command.  When TPM_BUS_SECURITY is enabled and HMAC sessions are in
> use this adds the standard u32 handle to the buffer but additionally
> records the name of the object which must be used as part of the HMAC
> computation.  The name of certain object types (volatile and permanent
> handles and NV indexes) is a hash of the public area of the object.
> Since this hash is not known ahead of time, it must be requested from
> the TPM using TPM2_ReadPublic() (which cannot be HMAC protected, but
> if an interposer lies about it, the HMAC check will fail and the
> problem will be detected).
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto API part=
s
>
> ---
>
> v6: split into new patch, update config variable
> v7: add tpm2_ prefix
> v8: minor updates
> ---
>  drivers/char/tpm/tpm2-sessions.c | 129 +++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  26 +++++++
>  2 files changed, 155 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 71b3c0e75760..99eb048f18c8 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -49,6 +49,11 @@
>   *	Under normal operation this function is done by
>   *	tpm_buf_check_hmac_response(), so this is only to be used on
>   *	error legs where the latter is not executed.
> + * tpm_buf_append_name() to add a handle to the buffer.  This must be
> + *	used in place of the usual tpm_buf_append_u32() for adding
> + *	handles because handles have to be processed specially when
> + *	calculating the HMAC.  In particular, for NV, volatile and
> + *	permanent objects you now need to provide the name.
>   */
> =20
>  #include "tpm.h"
> @@ -60,6 +65,9 @@
>  #include <crypto/hash.h>
>  #include <crypto/hmac.h>
> =20
> +/* maximum number of names the TPM must remember for authorization */
> +#define AUTH_MAX_NAMES	3
> +
>  /*
>   * This is the structure that carries all the auth information (like
>   * session handle, nonces, session key and auth) from use to use it is
> @@ -96,8 +104,31 @@ struct tpm2_auth {
>  		u8 scratch[AES_KEY_BYTES + AES_BLOCK_SIZE];
>  	};
>  	u8 session_key[SHA256_DIGEST_SIZE];
> +
> +	/*
> +	 * memory for three authorization handles.  We know them by
> +	 * handle, but they are part of the session by name, which
> +	 * we must compute and remember
> +	 */
> +	u32 name_h[AUTH_MAX_NAMES];
> +	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
>  };
> =20
> +/*
> + * Name Size based on TPM algorithm (assumes no hash bigger than 255)
> + */
> +static u8 name_size(const u8 *name)
> +{
> +	static u8 size_map[] =3D {
> +		[TPM_ALG_SHA1] =3D SHA1_DIGEST_SIZE,
> +		[TPM_ALG_SHA256] =3D SHA256_DIGEST_SIZE,
> +		[TPM_ALG_SHA384] =3D SHA384_DIGEST_SIZE,
> +		[TPM_ALG_SHA512] =3D SHA512_DIGEST_SIZE,
> +	};
> +	u16 alg =3D get_unaligned_be16(name);
> +	return size_map[alg] + 2;
> +}
> +
>  /*
>   * It turns out the crypto hmac(sha256) is hard for us to consume
>   * because it assumes a fixed key and the TPM seems to change the key
> @@ -277,6 +308,104 @@ static void tpm_buf_append_salt(struct tpm_buf *buf=
, struct tpm_chip *chip)
>   out:
>  	crypto_free_kpp(kpp);
>  }
> +
> +static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
> +{
> +	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> +	off_t offset =3D TPM_HEADER_SIZE;
> +	u32 tot_len =3D be32_to_cpu(head->length);
> +	u32 val;
> +
> +	/* we're starting after the header so adjust the length */
> +	tot_len -=3D TPM_HEADER_SIZE;
> +
> +	/* skip public */
> +	val =3D tpm_buf_read_u16(buf, &offset);
> +	if (val > tot_len)
> +		return -EINVAL;
> +	offset +=3D val;
> +	/* name */
> +	val =3D tpm_buf_read_u16(buf, &offset);
> +	if (val !=3D name_size(&buf->data[offset]))
> +		return -EINVAL;
> +	memcpy(name, &buf->data[offset], val);
> +	/* forget the rest */
> +	return 0;
> +}
> +
> +static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *nam=
e)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_append_u32(&buf, handle);
> +	rc =3D tpm_transmit_cmd(chip, &buf, 0, "read public");
> +	if (rc =3D=3D TPM2_RC_SUCCESS)
> +		rc =3D tpm2_parse_read_public(name, &buf);
> +
> +	tpm_buf_destroy(&buf);
> +
> +	return rc;
> +}
> +
> +/**
> + * tpm_buf_append_name() - add a handle area to the buffer
> + * @chip: the TPM chip structure
> + * @buf: The buffer to be appended
> + * @handle: The handle to be appended
> + * @name: The name of the handle (may be NULL)
> + *
> + * In order to compute session HMACs, we need to know the names of the
> + * objects pointed to by the handles.  For most objects, this is simply
> + * the actual 4 byte handle or an empty buf (in these cases @name
> + * should be NULL) but for volatile objects, permanent objects and NV
> + * areas, the name is defined as the hash (according to the name
> + * algorithm which should be set to sha256) of the public area to
> + * which the two byte algorithm id has been appended.  For these
> + * objects, the @name pointer should point to this.  If a name is
> + * required but @name is NULL, then TPM2_ReadPublic() will be called
> + * on the handle to obtain the name.
> + *
> + * As with most tpm_buf operations, success is assumed because failure
> + * will be caused by an incorrect programming model and indicated by a
> + * kernel message.
> + */
> +void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> +			 u32 handle, u8 *name)
> +{
> +	enum tpm2_mso_type mso =3D tpm2_handle_mso(handle);
> +	struct tpm2_auth *auth =3D chip->auth;
> +	int slot;
> +
> +	slot =3D (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
> +	if (slot >=3D AUTH_MAX_NAMES) {
> +		dev_err(&chip->dev, "TPM: too many handles\n");
> +		return;
> +	}
> +	WARN(auth->session !=3D tpm_buf_length(buf),
> +	     "name added in wrong place\n");
> +	tpm_buf_append_u32(buf, handle);
> +	auth->session +=3D 4;
> +
> +	if (mso =3D=3D TPM2_MSO_PERSISTENT ||
> +	    mso =3D=3D TPM2_MSO_VOLATILE ||
> +	    mso =3D=3D TPM2_MSO_NVRAM) {
> +		if (!name)
> +			tpm2_read_public(chip, handle, auth->name[slot]);
> +	} else {
> +		if (name)
> +			dev_err(&chip->dev, "TPM: Handle does not require name but one is spe=
cified\n");
> +	}
> +
> +	auth->name_h[slot] =3D handle;
> +	if (name)
> +		memcpy(auth->name[slot], name, name_size(name));
> +}
> +EXPORT_SYMBOL(tpm_buf_append_name);
>  /**
>   * tpm2_end_auth_session() - kill the allocated auth session
>   * @chip: the TPM chip structure
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 81b5a70ff80d..31c2065fcd35 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -275,6 +275,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
>  	TPM2_CC_CONTEXT_SAVE	        =3D 0x0162,
>  	TPM2_CC_FLUSH_CONTEXT	        =3D 0x0165,
> +	TPM2_CC_READ_PUBLIC		=3D 0x0173,
>  	TPM2_CC_START_AUTH_SESS		=3D 0x0176,
>  	TPM2_CC_VERIFY_SIGNATURE        =3D 0x0177,
>  	TPM2_CC_GET_CAPABILITY	        =3D 0x017A,
> @@ -292,6 +293,21 @@ enum tpm2_permanent_handles {
>  	TPM2_RS_PW		=3D 0x40000009,
>  };
> =20
> +/* Most Significant Octet for key types  */
> +enum tpm2_mso_type {
> +	TPM2_MSO_NVRAM		=3D 0x01,
> +	TPM2_MSO_SESSION	=3D 0x02,
> +	TPM2_MSO_POLICY		=3D 0x03,
> +	TPM2_MSO_PERMANENT	=3D 0x40,
> +	TPM2_MSO_VOLATILE	=3D 0x80,
> +	TPM2_MSO_PERSISTENT	=3D 0x81,
> +};
> +
> +static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
> +{
> +	return handle >> 24;
> +}
> +
>  enum tpm2_capabilities {
>  	TPM2_CAP_HANDLES	=3D 1,
>  	TPM2_CAP_COMMANDS	=3D 2,
> @@ -492,6 +508,8 @@ static inline void tpm_buf_append_empty_auth(struct t=
pm_buf *buf, u32 handle)
>  #ifdef CONFIG_TCG_TPM2_HMAC
> =20
>  int tpm2_start_auth_session(struct tpm_chip *chip);
> +void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> +			 u32 handle, u8 *name);
>  void tpm2_end_auth_session(struct tpm_chip *chip);
>  #else
>  static inline int tpm2_start_auth_session(struct tpm_chip *chip)
> @@ -501,6 +519,14 @@ static inline int tpm2_start_auth_session(struct tpm=
_chip *chip)
>  static inline void tpm2_end_auth_session(struct tpm_chip *chip)
>  {
>  }
> +static inline void tpm_buf_append_name(struct tpm_chip *chip,
> +				       struct tpm_buf *buf,
> +				       u32 handle, u8 *name)
> +{
> +	tpm_buf_append_u32(buf, handle);
> +	/* count the number of handles in the upper bits of flags */
> +	buf->handles++;
> +}
>  #endif	/* CONFIG_TCG_TPM2_HMAC */
> =20
>  #endif

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


