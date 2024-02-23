Return-Path: <linux-integrity+bounces-1447-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058AE861BF0
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 19:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5261C22DA0
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 18:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7B78526C;
	Fri, 23 Feb 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug+WXsMN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663081AA8;
	Fri, 23 Feb 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713836; cv=none; b=kfl6G/XoqhV8KNQF9OdtD7pSk80mHCV8UT2A3AqDFTocVkmbfsPR5SVdtSWe694m7OX0tUvMk3cLJ9UjRv0cTk7di7vLu/1MLTUwm6tDWlZJJLGohZeY/vgsoLoX8VRDsJ7p3WeDtcTyCH1q+uJ/fxfzifE2PCMR6dhr+piGoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713836; c=relaxed/simple;
	bh=YfWAo3EqderPOEAYV79eNa6KhB2Moqx4NTs1Yq+sYp0=;
	h=Mime-Version:Content-Type:Date:Subject:From:To:Cc:Message-Id:
	 References:In-Reply-To; b=gA3c5nW1rD4M8Eza6pHUTNDxHmUI5qND5zKNhXpTiujUlv246t5yqTCPfZLHA7CH3F6O2ZTmo+cwuFSBb9vjXU0yfirk6QvG+vWGxy1tZB2c2Fi6JZUINkJTa7z9HYWIITosTI+pAFv10jW7vrOzIZHNrLdC2Z8FqrV5RTHZ6bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug+WXsMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DECC433F1;
	Fri, 23 Feb 2024 18:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713835;
	bh=YfWAo3EqderPOEAYV79eNa6KhB2Moqx4NTs1Yq+sYp0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ug+WXsMNgPY40m17kLULlil16ORQk5S3TEqA34cWvx9g6HGmUu2VIn6lOuEljAufj
	 r8KtbzfAepJlpIRqYfSVWGPvzprrFb6YPZAvlnKLV5DPzK4k6C3fvDY5EOD29gzIkX
	 ZJYCoUyvqTJr1Cu6ux9skM8Dh8DVOrEH1PBe3oyynf8kyb2ndMstVL8SjZPkTU2O8H
	 8z3FMErdbLfRgxh33jN7+Qxf5TLFNgu1RpROiiYfBI4MXXB7i6QecPRvy4L8u8W0pb
	 DiSTo1Bx5PgGZetAWOsmmEMBGxzoLr7MdPZ3mwpwL0195P8KDSDMkhQ9EEbCdWsKhB
	 EbQfiZZ+AiwJQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 20:43:52 +0200
Subject: Re: [PATCH v7 21/21] tpm: disable the TPM if NULL name changes
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Message-Id: <CZCOH70NUR62.39WX6X6UJQ2A8@suppilovahvero>
X-Mailer: aerc 0.15.2
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-22-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240213171334.30479-22-James.Bottomley@HansenPartnership.com>

On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
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
>  drivers/char/tpm/tpm2-sessions.c | 65 ++++++++++++++++++++++++++------
>  drivers/char/tpm/tpm2-space.c    |  3 ++
>  include/linux/tpm.h              |  4 +-
>  4 files changed, 62 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index d93937326b2e..854546000c92 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -158,6 +158,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>  {
>  	int rc =3D -EIO;
> =20

Inline comment here as a reminder of the purpose of the check:

> +	if (chip->flags & TPM_CHIP_FLAG_DISABLE)
> +		return rc;
> +
>  	get_device(&chip->dev);
> =20
>  	down_read(&chip->ops_sem);
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> index 9d6da0c9652f..60a1a8746563 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -87,6 +87,9 @@
>  #define AES_KEYBITS	(AES_KEYBYTES*8)
>  #define AUTH_MAX_NAMES	3
> =20
> +static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
> +			       u32 *handle, u8 *name);

Should be ordered in the way that this declaration is not required.

> +
>  /*
>   * This is the structure that carries all the auth information (like
>   * session handle, nonces, session key and auth) from use to use it is
> @@ -847,6 +850,37 @@ static int tpm2_parse_start_auth_session(struct tpm2=
_auth *auth,
>  	return 0;
>  }
> =20
> +static int tpm2_load_null(struct tpm_chip *chip, u32 *nullkey)
> +{
> +	int rc;
> +	unsigned int offset =3D 0; /* dummy offset for null seed context */
> +	u8 name[SHA256_DIGEST_SIZE + 2];
> +
> +	rc =3D tpm2_load_context(chip, chip->null_key_context, &offset,
> +			       nullkey);
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
> +	 * userspace programms can't be compromised by it.
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
> @@ -864,11 +898,9 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	struct tpm_buf buf;
>  	struct tpm2_auth *auth =3D chip->auth;
>  	int rc;
> -	unsigned int offset =3D 0; /* dummy offset for null seed context */
>  	u32 nullkey;
> =20
> -	rc =3D tpm2_load_context(chip, chip->null_key_context, &offset,
> -			       &nullkey);
> +	rc =3D tpm2_load_null(chip, &nullkey);
>  	if (rc)
>  		goto out;
> =20
> @@ -919,15 +951,19 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  EXPORT_SYMBOL(tpm2_start_auth_session);
> =20
>  static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_b=
uf *buf,
> -				     u32 *nullkey)
> +				     u32 *handle, u8 *name)

Right sorry for my earlier comment this obviously cannot
tpm2_create_primary :-)

So tpm2_read_primary is probably in the ballpark given
that other more primitive functions are also "read".

>  {
>  	struct tpm_header *head =3D (struct tpm_header *)buf->data;
>  	off_t offset_r =3D TPM_HEADER_SIZE, offset_t;
>  	u16 len =3D TPM_HEADER_SIZE;
>  	u32 tot_len =3D be32_to_cpu(head->length);
> -	u32 val, parm_len;
> +	u32 val, parm_len, keyhandle;
> +	keyhandle =3D tpm_buf_read_u32(buf, &offset_r);
> +	if (handle)
> +		*handle =3D keyhandle;
> +	else
> +		tpm2_flush_context(chip, keyhandle);
> =20
> -	*nullkey =3D tpm_buf_read_u32(buf, &offset_r);
>  	parm_len =3D tpm_buf_read_u32(buf, &offset_r);
>  	/*
>  	 * parm_len doesn't include the header, but all the other
> @@ -940,9 +976,12 @@ static int tpm2_parse_create_primary(struct tpm_chip=
 *chip, struct tpm_buf *buf,
>  		return -EINVAL;
>  	len =3D tpm_buf_read_u16(buf, &offset_r);
>  	offset_t =3D offset_r;
> -	/* now we have the public area, compute the name of the object */
> -	put_unaligned_be16(TPM_ALG_SHA256, chip->null_key_name);
> -	sha256(&buf->data[offset_r], len, chip->null_key_name + 2);
> +	if (name) {
> +		/* now we have the public area, compute the name of
> +		 * the object */
> +		put_unaligned_be16(TPM_ALG_SHA256, name);
> +		sha256(&buf->data[offset_r], len, name + 2);
> +	}
> =20
>  	/* validate the public key */
>  	val =3D tpm_buf_read_u16(buf, &offset_t);
> @@ -1054,7 +1093,8 @@ static int tpm2_parse_create_primary(struct tpm_chi=
p *chip, struct tpm_buf *buf,
>  	return 0;
>  }
> =20
> -static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy, u32=
 *handle)
> +static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
> +			       u32 *handle, u8 *name)
>  {
>  	int rc;
>  	struct tpm_buf buf;
> @@ -1133,7 +1173,7 @@ static int tpm2_create_primary(struct tpm_chip *chi=
p, u32 hierarchy, u32 *handle
>  			      "attempting to create NULL primary");
> =20
>  	if (rc =3D=3D TPM2_RC_SUCCESS)
> -		rc =3D tpm2_parse_create_primary(chip, &buf, handle);
> +		rc =3D tpm2_parse_create_primary(chip, &buf, handle, name);
> =20
>  	tpm_buf_destroy(&buf);
> =20
> @@ -1145,7 +1185,8 @@ static int tpm2_create_null_primary(struct tpm_chip=
 *chip)
>  	u32 nullkey;
>  	int rc;
> =20
> -	rc =3D tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey);
> +	rc =3D tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey,
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
> index 9c608fac8935..4474dabfb69d 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -244,6 +244,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_SUCCESS		=3D 0x0000,
>  	TPM2_RC_HASH		=3D 0x0083, /* RC_FMT1 */
>  	TPM2_RC_HANDLE		=3D 0x008B,
> +	TPM2_RC_INTEGRITY	=3D 0x009F,
>  	TPM2_RC_INITIALIZE	=3D 0x0100, /* RC_VER1 */
>  	TPM2_RC_FAILURE		=3D 0x0101,
>  	TPM2_RC_DISABLED	=3D 0x0120,
> @@ -342,6 +343,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		=3D BIT(7),
>  	TPM_CHIP_FLAG_SUSPENDED			=3D BIT(8),
>  	TPM_CHIP_FLAG_HWRNG_DISABLED		=3D BIT(9),
> +	TPM_CHIP_FLAG_DISABLE			=3D BIT(10),
>  };
> =20
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> @@ -428,7 +430,7 @@ static inline bool tpm_is_firmware_upgrade(struct tpm=
_chip *chip)
> =20
>  static inline u32 tpm2_rc_value(u32 rc)
>  {
> -	return (rc & BIT(7)) ? rc & 0xff : rc;
> +	return (rc & BIT(7)) ? rc & 0xbf : rc;

What is this change?

>  }
> =20
>  #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)

BR, Jarkko

