Return-Path: <linux-integrity+bounces-2282-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7ED8B65D1
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 00:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EFC282C55
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB413AEE;
	Mon, 29 Apr 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1kGXiM1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8D101E3;
	Mon, 29 Apr 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430231; cv=none; b=UlbmFX83VLlcahvSkQ9X4jEn1GETSamEkRLsZ1Ko5LKjl1+AVYOEIymOTandSvKOTntsKzgLsnlRjWWdlgiH1Angn3QSmPQGHsNPufdMiMlkvE/h78p81M9RVFFx9EdaG/7S2DjsvIHcEQpw2et/jpQPXRGjcOUejcFd+6aIzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430231; c=relaxed/simple;
	bh=uT7fnDycv9NkFMpFP5p3BJl/JgZemkawZR+V65LOqh0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qj+Kws+gIOZDgeuvBOVAf/R5RB80Y93l9Zw6YE6Z+vSBflCM8K8IVaO42vXCFflCZRFFj/f6Ie0qPdAxkF6XtmP4XD66FVcyamNVk0Snb7nsgTwu4skzWIL/59p9qI6DjkkzBsSZKRfHd3siHpWW61OWSg4Suj1q3MVI6ahVrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1kGXiM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB420C4AF17;
	Mon, 29 Apr 2024 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714430231;
	bh=uT7fnDycv9NkFMpFP5p3BJl/JgZemkawZR+V65LOqh0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=J1kGXiM1FehJHubY9Kpf8b5zvR6noV9EEslSApnUKzk3Jr9oL4EbqT72bZEi1j3cU
	 503CCsm4/Uan6OCUSECEHdPF1PpVlNw0WOoqkUpg4mJyTHVDvyI2kOX6Pf5oLZDxxD
	 6lhM2TOYrAABL91GWOko7gWskuxkOcYJRLTOrtQlJv69nI0K+9xR6g4JYVRrpqNBr0
	 bMQoXD/es/cM7kBdjx3plM0QIMi9LQohEBEFTXk7V2eJ0CADIrF/flxm6nX0YZ/A31
	 XM4SW5wxYQXDt8hH5zszmEJgc7Xnu1sjdZKN3mlJIfNjpG/v4TGId9PioXHgc1c20C
	 UIGCYuhastZSQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 01:37:07 +0300
Message-Id: <D0WYSLNYKAGO.3DDGCBF2DY5Q5@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 12/22] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-13-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240429202811.13643-13-James.Bottomley@HansenPartnership.com>

On Mon Apr 29, 2024 at 11:28 PM EEST, James Bottomley wrote:
> The session handling code uses a "salted" session, meaning a session
> whose salt is encrypted to the public part of another TPM key so an
> observer cannot obtain it (and thus deduce the session keys).  This
> patch creates and context saves in the tpm_chip area the primary key
> of the NULL hierarchy for this purpose.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
> v6: split out of original HMAC patch update config name
> v7: rename null seed parameters
> v8: format changes and move template to tpm.h
> ---
>  drivers/char/tpm/Kconfig         |  11 ++
>  drivers/char/tpm/Makefile        |   1 +
>  drivers/char/tpm/tpm.h           |  10 +
>  drivers/char/tpm/tpm2-cmd.c      |   5 +
>  drivers/char/tpm/tpm2-sessions.c | 316 +++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  69 +++++++
>  6 files changed, 412 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm2-sessions.c
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3..ab16d347579f 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -27,6 +27,17 @@ menuconfig TCG_TPM
> =20
>  if TCG_TPM
> =20
> +config TCG_TPM2_HMAC
> +	bool "Use HMAC and encrypted transactions on the TPM bus"
> +	default y
> +	help
> +	  Setting this causes us to deploy a scheme which uses request
> +	  and response HMACs in addition to encryption for
> +	  communicating with the TPM to prevent or detect bus snooping
> +	  and interposer attacks (see tpm-security.rst).  Saying Y
> +	  here adds some encryption overhead to all kernel to TPM
> +	  transactions.
> +
>  config HW_RANDOM_TPM
>  	bool "TPM HW Random Number Generator support"
>  	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=3Dy && HW_RANDOM=3Dm)
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index ad3594e383e1..4c695b0388f3 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -17,6 +17,7 @@ tpm-y +=3D eventlog/tpm1.o
>  tpm-y +=3D eventlog/tpm2.o
>  tpm-y +=3D tpm-buf.o
> =20
> +tpm-$(CONFIG_TCG_TPM2_HMAC) +=3D tpm2-sessions.o
>  tpm-$(CONFIG_ACPI) +=3D tpm_ppi.o eventlog/acpi.o
>  tpm-$(CONFIG_EFI) +=3D eventlog/efi.o
>  tpm-$(CONFIG_OF) +=3D eventlog/of.o
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index cbc9d1e2974d..6b8b9956ba69 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -321,4 +321,14 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
>  int tpm_dev_common_init(void);
>  void tpm_dev_common_exit(void);
> +
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +int tpm2_sessions_init(struct tpm_chip *chip);
> +#else
> +static inline int tpm2_sessions_init(struct tpm_chip *chip)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 93545be190a5..b0e72fb563d9 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -759,6 +759,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  		rc =3D 0;
>  	}
> =20
> +	if (rc)
> +		goto out;
> +
> +	rc =3D tpm2_sessions_init(chip);
> +
>  out:
>  	/*
>  	 * Infineon TPM in field upgrade mode will return no data for the numbe=
r
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-ses=
sions.c
> new file mode 100644
> index 000000000000..fc3f032df467
> --- /dev/null
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
> + *
> + */
> +
> +#include "tpm.h"
> +#include <asm/unaligned.h>
> +
> +/**
> + * tpm2_parse_create_primary() - parse the data returned from TPM_CC_CRE=
ATE_PRIMARY
> + *
> + * @chip:	The TPM the primary was created under
> + * @buf:	The response buffer from the chip
> + * @handle:	pointer to be filled in with the return handle of the primar=
y
> + * @hierarchy:	The hierarchy the primary was created for
> + *
> + * @returns: 0 on success or a positive TPM or negative standard error
> + */
> +static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_b=
uf *buf,
> +				     u32 *handle, u32 hierarchy)
> +{
> +	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> +	off_t offset_r =3D TPM_HEADER_SIZE, offset_t;
> +	u16 len =3D TPM_HEADER_SIZE;
> +	u32 total_len =3D be32_to_cpu(head->length);
> +	u32 val, param_len;
> +
> +	*handle =3D tpm_buf_read_u32(buf, &offset_r);
> +	param_len =3D tpm_buf_read_u32(buf, &offset_r);
> +	/*
> +	 * param_len doesn't include the header, but all the other
> +	 * lengths and offsets do, so add it to parm len to make
> +	 * the comparisons easier
> +	 */
> +	param_len +=3D TPM_HEADER_SIZE;
> +
> +	if (param_len + 8 > total_len)
> +		return -EINVAL;
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	offset_t =3D offset_r;
> +	/* now we have the public area, compute the name of the object */
> +	put_unaligned_be16(TPM_ALG_SHA256, chip->null_key_name);
> +	sha256(&buf->data[offset_r], len, chip->null_key_name + 2);
> +
> +	/* validate the public key */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +
> +	/* key type (must be what we asked for) */
> +	if (val !=3D TPM_ALG_ECC)
> +		return -EINVAL;
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +
> +	/* name algorithm */
> +	if (val !=3D TPM_ALG_SHA256)
> +		return -EINVAL;
> +	val =3D tpm_buf_read_u32(buf, &offset_t);
> +
> +	/* object properties */
> +	if (val !=3D TPM2_OA_TMPL)
> +		return -EINVAL;
> +
> +	/* auth policy (empty) */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D 0)
> +		return -EINVAL;
> +
> +	/* symmetric key parameters */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM_ALG_AES)
> +		return -EINVAL;
> +
> +	/* symmetric key length */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D AES_KEY_BITS)
> +		return -EINVAL;
> +
> +	/* symmetric encryption scheme */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM_ALG_CFB)
> +		return -EINVAL;
> +
> +	/* signing scheme */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM_ALG_NULL)
> +		return -EINVAL;
> +
> +	/* ECC Curve */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM2_ECC_NIST_P256)
> +		return -EINVAL;
> +
> +	/* KDF Scheme */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM_ALG_NULL)
> +		return -EINVAL;
> +
> +	/* extract public key (x and y points) */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D EC_PT_SZ)
> +		return -EINVAL;
> +	memcpy(chip->null_ec_key_x, &buf->data[offset_t], val);
> +	offset_t +=3D val;
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D EC_PT_SZ)
> +		return -EINVAL;
> +	memcpy(chip->null_ec_key_y, &buf->data[offset_t], val);
> +	offset_t +=3D val;
> +
> +	/* original length of the whole TPM2B */
> +	offset_r +=3D len;
> +
> +	/* should have exactly consumed the TPM2B public structure */
> +	if (offset_t !=3D offset_r)
> +		return -EINVAL;
> +	if (offset_r > param_len)
> +		return -EINVAL;
> +
> +	/* creation data (skip) */
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	offset_r +=3D len;
> +	if (offset_r > param_len)
> +		return -EINVAL;
> +
> +	/* creation digest (must be sha256) */
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	offset_r +=3D len;
> +	if (len !=3D SHA256_DIGEST_SIZE || offset_r > param_len)
> +		return -EINVAL;
> +
> +	/* TPMT_TK_CREATION follows */
> +	/* tag, must be TPM_ST_CREATION (0x8021) */
> +	val =3D tpm_buf_read_u16(buf, &offset_r);
> +	if (val !=3D TPM2_ST_CREATION || offset_r > param_len)
> +		return -EINVAL;
> +
> +	/* hierarchy */
> +	val =3D tpm_buf_read_u32(buf, &offset_r);
> +	if (val !=3D hierarchy || offset_r > param_len)
> +		return -EINVAL;
> +
> +	/* the ticket digest HMAC (might not be sha256) */
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	offset_r +=3D len;
> +	if (offset_r > param_len)
> +		return -EINVAL;
> +
> +	/*
> +	 * finally we have the name, which is a sha256 digest plus a 2
> +	 * byte algorithm type
> +	 */
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	if (offset_r + len !=3D param_len + 8)
> +		return -EINVAL;
> +	if (len !=3D SHA256_DIGEST_SIZE + 2)
> +		return -EINVAL;
> +
> +	if (memcmp(chip->null_key_name, &buf->data[offset_r],
> +		   SHA256_DIGEST_SIZE + 2) !=3D 0) {
> +		dev_err(&chip->dev, "NULL Seed name comparison failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * tpm2_create_primary() - create a primary key using a fixed P-256 temp=
late
> + *
> + * @chip:      the TPM chip to create under
> + * @hierarchy: The hierarchy handle to create under
> + * @handle:    The returned volatile handle on success
> + *
> + * For platforms that might not have a persistent primary, this can be
> + * used to create one quickly on the fly (it uses Elliptic Curve not
> + * RSA, so even slow TPMs can create one fast).  The template uses the
> + * TCG mandated H one for non-endorsement ECC primaries, i.e. P-256
> + * elliptic curve (the only current one all TPM2s are required to
> + * have) a sha256 name hash and no policy.
> + *
> + * @returns: 0 on success or positive TPM or negative error.
> + */
> +static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
> +			       u32 *handle)
> +{
> +	int rc;
> +	struct tpm_buf buf;
> +	struct tpm_buf template;
> +
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D tpm_buf_init_sized(&template);
> +	if (rc) {
> +		tpm_buf_destroy(&buf);
> +		return rc;
> +	}
> +
> +	/*
> +	 * create the template.  Note: in order for userspace to
> +	 * verify the security of the system, it will have to create
> +	 * and certify this NULL primary, meaning all the template
> +	 * parameters will have to be identical, so conform exactly to
> +	 * the TCG TPM v2.0 Provisioning Guidance for the SRK ECC
> +	 * key H template (H has zero size unique points)
> +	 */
> +
> +	/* key type */
> +	tpm_buf_append_u16(&template, TPM_ALG_ECC);
> +
> +	/* name algorithm */
> +	tpm_buf_append_u16(&template, TPM_ALG_SHA256);
> +
> +	/* object properties */
> +	tpm_buf_append_u32(&template, TPM2_OA_TMPL);
> +
> +	/* sauth policy (empty) */
> +	tpm_buf_append_u16(&template, 0);
> +
> +	/* BEGIN parameters: key specific; for ECC*/
> +
> +	/* symmetric algorithm */
> +	tpm_buf_append_u16(&template, TPM_ALG_AES);
> +
> +	/* bits for symmetric algorithm */
> +	tpm_buf_append_u16(&template, AES_KEY_BITS);
> +
> +	/* algorithm mode (must be CFB) */
> +	tpm_buf_append_u16(&template, TPM_ALG_CFB);
> +
> +	/* scheme (NULL means any scheme) */
> +	tpm_buf_append_u16(&template, TPM_ALG_NULL);
> +
> +	/* ECC Curve ID */
> +	tpm_buf_append_u16(&template, TPM2_ECC_NIST_P256);
> +
> +	/* KDF Scheme */
> +	tpm_buf_append_u16(&template, TPM_ALG_NULL);
> +
> +	/* unique: key specific; for ECC it is two zero size points */
> +	tpm_buf_append_u16(&template, 0);
> +	tpm_buf_append_u16(&template, 0);
> +
> +	/* END parameters */
> +
> +	/* primary handle */
> +	tpm_buf_append_u32(&buf, hierarchy);
> +	tpm_buf_append_empty_auth(&buf, TPM2_RS_PW);
> +
> +	/* sensitive create size is 4 for two empty buffers */
> +	tpm_buf_append_u16(&buf, 4);
> +
> +	/* sensitive create auth data (empty) */
> +	tpm_buf_append_u16(&buf, 0);
> +
> +	/* sensitive create sensitive data (empty) */
> +	tpm_buf_append_u16(&buf, 0);
> +
> +	/* the public template */
> +	tpm_buf_append(&buf, template.data, template.length);
> +	tpm_buf_destroy(&template);
> +
> +	/* outside info (empty) */
> +	tpm_buf_append_u16(&buf, 0);
> +
> +	/* creation PCR (none) */
> +	tpm_buf_append_u32(&buf, 0);
> +
> +	rc =3D tpm_transmit_cmd(chip, &buf, 0,
> +			      "attempting to create NULL primary");
> +
> +	if (rc =3D=3D TPM2_RC_SUCCESS)
> +		rc =3D tpm2_parse_create_primary(chip, &buf, handle, hierarchy);
> +
> +	tpm_buf_destroy(&buf);
> +
> +	return rc;
> +}
> +
> +static int tpm2_create_null_primary(struct tpm_chip *chip)
> +{
> +	u32 null_key;
> +	int rc;
> +
> +	rc =3D tpm2_create_primary(chip, TPM2_RH_NULL, &null_key);
> +
> +	if (rc =3D=3D TPM2_RC_SUCCESS) {
> +		unsigned int offset =3D 0; /* dummy offset for null key context */
> +
> +		rc =3D tpm2_save_context(chip, null_key, chip->null_key_context,
> +				       sizeof(chip->null_key_context), &offset);
> +		tpm2_flush_context(chip, null_key);
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * tpm2_sessions_init() - start of day initialization for the sessions c=
ode
> + * @chip: TPM chip
> + *
> + * Derive and context save the null primary and allocate memory in the
> + * struct tpm_chip for the authorizations.
> + */
> +int tpm2_sessions_init(struct tpm_chip *chip)
> +{
> +	int rc;
> +
> +	rc =3D tpm2_create_null_primary(chip);
> +	if (rc)
> +		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n=
", rc);
> +
> +	return rc;
> +}
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 6be263509e81..bc8c9a350e23 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -23,6 +23,7 @@
>  #include <linux/fs.h>
>  #include <linux/highmem.h>
>  #include <crypto/hash_info.h>
> +#include <crypto/aes.h>
> =20
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
>  #define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> @@ -35,12 +36,15 @@ struct trusted_key_options;
>  enum tpm_algorithms {
>  	TPM_ALG_ERROR		=3D 0x0000,
>  	TPM_ALG_SHA1		=3D 0x0004,
> +	TPM_ALG_AES		=3D 0x0006,
>  	TPM_ALG_KEYEDHASH	=3D 0x0008,
>  	TPM_ALG_SHA256		=3D 0x000B,
>  	TPM_ALG_SHA384		=3D 0x000C,
>  	TPM_ALG_SHA512		=3D 0x000D,
>  	TPM_ALG_NULL		=3D 0x0010,
>  	TPM_ALG_SM3_256		=3D 0x0012,
> +	TPM_ALG_ECC		=3D 0x0023,
> +	TPM_ALG_CFB		=3D 0x0043,
>  };
> =20
>  /*
> @@ -49,6 +53,11 @@ enum tpm_algorithms {
>   */
>  #define TPM_MAX_HASHES	5
> =20
> +enum tpm2_curves {
> +	TPM2_ECC_NONE		=3D 0x0000,
> +	TPM2_ECC_NIST_P256	=3D 0x0003,
> +};
> +
>  struct tpm_digest {
>  	u16 alg_id;
>  	u8 digest[TPM_MAX_DIGEST_SIZE];
> @@ -116,6 +125,20 @@ struct tpm_chip_seqops {
>  	const struct seq_operations *seqops;
>  };
> =20
> +/* fixed define for the curve we use which is NIST_P256 */
> +#define EC_PT_SZ	32
> +
> +/*
> + * fixed define for the size of a name.  This is actually HASHALG size
> + * plus 2, so 32 for SHA256
> + */
> +#define TPM2_NAME_SIZE	34
> +
> +/*
> + * The maximum size for an object context
> + */
> +#define TPM2_MAX_CONTEXT_SIZE 4096
> +
>  struct tpm_chip {
>  	struct device dev;
>  	struct device devs;
> @@ -170,6 +193,17 @@ struct tpm_chip {
> =20
>  	/* active locality */
>  	int locality;
> +
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +	/* details for communication security via sessions */
> +
> +	/* saved context for NULL seed */
> +	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
> +	 /* name of NULL seed */
> +	u8 null_key_name[TPM2_NAME_SIZE];
> +	u8 null_ec_key_x[EC_PT_SZ];
> +	u8 null_ec_key_y[EC_PT_SZ];
> +#endif
>  };
> =20
>  #define TPM_HEADER_SIZE		10
> @@ -194,6 +228,7 @@ enum tpm2_timeouts {
>  enum tpm2_structures {
>  	TPM2_ST_NO_SESSIONS	=3D 0x8001,
>  	TPM2_ST_SESSIONS	=3D 0x8002,
> +	TPM2_ST_CREATION	=3D 0x8021,
>  };
> =20
>  /* Indicates from what layer of the software stack the error comes from =
*/
> @@ -243,6 +278,7 @@ enum tpm2_command_codes {
>  };
> =20
>  enum tpm2_permanent_handles {
> +	TPM2_RH_NULL		=3D 0x40000007,
>  	TPM2_RS_PW		=3D 0x40000009,
>  };
> =20
> @@ -318,9 +354,28 @@ struct tpm_buf {
>  enum tpm2_object_attributes {
>  	TPM2_OA_FIXED_TPM		=3D BIT(1),
>  	TPM2_OA_FIXED_PARENT		=3D BIT(4),
> +	TPM2_OA_SENSITIVE_DATA_ORIGIN	=3D BIT(5),
>  	TPM2_OA_USER_WITH_AUTH		=3D BIT(6),
> +	TPM2_OA_NO_DA			=3D BIT(10),
> +	TPM2_OA_RESTRICTED		=3D BIT(16),
> +	TPM2_OA_DECRYPT			=3D BIT(17),
>  };
> =20
> +/*
> + * definitions for the canonical template.  These are mandated
> + * by the TCG key template documents
> + */
> +
> +#define AES_KEY_BYTES	AES_KEYSIZE_128
> +#define AES_KEY_BITS	(AES_KEY_BYTES*8)
> +#define TPM2_OA_TMPL	(TPM2_OA_NO_DA |			\
> +			 TPM2_OA_FIXED_TPM |			\
> +			 TPM2_OA_FIXED_PARENT |			\
> +			 TPM2_OA_SENSITIVE_DATA_ORIGIN |	\
> +			 TPM2_OA_USER_WITH_AUTH |		\
> +			 TPM2_OA_DECRYPT |			\
> +			 TPM2_OA_RESTRICTED)
> +
>  enum tpm2_session_attributes {
>  	TPM2_SA_CONTINUE_SESSION	=3D BIT(0),
>  };
> @@ -373,6 +428,16 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32=
 pcr_idx,
>  extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>  extern struct tpm_chip *tpm_default_chip(void);
>  void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> +
> +static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 ha=
ndle)
> +{
> +	/* simple authorization for empty auth */
> +	tpm_buf_append_u32(buf, 9);		/* total length of auth */
> +	tpm_buf_append_u32(buf, handle);
> +	tpm_buf_append_u16(buf, 0);		/* nonce len */
> +	tpm_buf_append_u8(buf, 0);		/* attributes */
> +	tpm_buf_append_u16(buf, 0);		/* hmac len */
> +}
>  #else
>  static inline int tpm_is_tpm2(struct tpm_chip *chip)
>  {
> @@ -399,5 +464,9 @@ static inline struct tpm_chip *tpm_default_chip(void)
>  {
>  	return NULL;
>  }
> +
> +static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 ha=
ndle)
> +{
> +}
>  #endif
>  #endif


Good enough!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

