Return-Path: <linux-integrity+bounces-625-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDB82305D
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5014C1C23782
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288D1C68E;
	Wed,  3 Jan 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdMDMPtY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57921C68A;
	Wed,  3 Jan 2024 15:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65655C433C8;
	Wed,  3 Jan 2024 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295161;
	bh=+xCWsWJT/6cPUIGgf2VR5nt+Q/6qnyQ90gkh+OU+Fvc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QdMDMPtYqZOwL3sYbNdHJcIRjfJIHeWSHyv8hEVutb2LM0VcCyaOmO5EUSCTFNeyT
	 vSN+0anx6pamjNg2NGyCCoJTam+AEfVO8joKSWshxDkhLqRgGJuQpQo2DA2nnuLL04
	 u/8W5i8qh3RlhaEtm5rpBPVWP7A6lefuC5Y/q6pdYnGOclOVpFgiiDX9OMDZLSohqL
	 dZRoH88oLrsSur4VXx6E6hXIUMmFfR+QiM1c+scsFFHxAjEqve4eN39F0gh5HRHGL7
	 neS5u4/RfFZCj5MD8HnJIsLb3Mmbc19WuLACufib1PWXcSrdVx4uVjvFDG+3NrwNre
	 Su9qTwUbrD0LA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 17:19:18 +0200
Message-Id: <CY567N12GYC9.8IQ7JU0404A4@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 14/20] tpm: Add HMAC session name/handle append
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-15-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240102170408.21969-15-James.Bottomley@HansenPartnership.com>

On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
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
> ---
>  drivers/char/tpm/tpm2-sessions.c | 121 +++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  26 +++++++
>  2 files changed, 147 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index bca6fe3ebb10..3fc43870792a 100644
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
> @@ -106,8 +111,26 @@ struct tpm2_auth {
>  		u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
>  	};
>  	u8 session_key[SHA256_DIGEST_SIZE];
> +	/* 3 names of handles: name_h is handle, name is name of handle */
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
> @@ -281,6 +304,104 @@ static void tpm_buf_append_salt(struct tpm_buf *buf=
, struct tpm_chip *chip)
>   out:
>  	crypto_free_kpp(kpp);
>  }
> +
> +static int parse_read_public(char *name, struct tpm_buf *buf)

same nit about prefix as earlier

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
> +static int tpm2_readpublic(struct tpm_chip *chip, u32 handle, char *name=
)
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
> +		rc =3D parse_read_public(name, &buf);
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
> + * objects pointed to by the handles.  For most objects, this is simly
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
> +	int slot;
> +	enum tpm2_mso_type mso =3D tpm2_handle_mso(handle);
> +	struct tpm2_auth *auth =3D chip->auth;
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
> +			tpm2_readpublic(chip, handle, auth->name[slot]);
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
> index b83269bd851c..cb8e3625da89 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -271,6 +271,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
>  	TPM2_CC_CONTEXT_SAVE	        =3D 0x0162,
>  	TPM2_CC_FLUSH_CONTEXT	        =3D 0x0165,
> +	TPM2_CC_READ_PUBLIC		=3D 0x0173,
>  	TPM2_CC_START_AUTH_SESS		=3D 0x0176,
>  	TPM2_CC_VERIFY_SIGNATURE        =3D 0x0177,
>  	TPM2_CC_GET_CAPABILITY	        =3D 0x017A,
> @@ -288,6 +289,21 @@ enum tpm2_permanent_handles {
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
> @@ -472,6 +488,8 @@ static inline void tpm_buf_append_empty_auth(struct t=
pm_buf *buf, u32 handle)
>  #ifdef CONFIG_TCG_TPM2_HMAC
> =20
>  int tpm2_start_auth_session(struct tpm_chip *chip);
> +void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
> +			 u32 handle, u8 *name);
>  void tpm2_end_auth_session(struct tpm_chip *chip);
>  #else
>  static inline int tpm2_start_auth_session(struct tpm_chip *chip)
> @@ -481,6 +499,14 @@ static inline int tpm2_start_auth_session(struct tpm=
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

Otherwise, looking pretty good

BR, Jarkko


