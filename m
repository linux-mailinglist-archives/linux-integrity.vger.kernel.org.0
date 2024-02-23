Return-Path: <linux-integrity+bounces-1421-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564286164B
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 16:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EE31F25898
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75F82C7E;
	Fri, 23 Feb 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIJK3Km4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389C8288F;
	Fri, 23 Feb 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703480; cv=none; b=UFXnPGgv0/MHq8uN8RVhmY3gZeIa/a+4JnPwpvamVfkjdLfOgwgeOI+BDUDTyCW2rnJj/GxvVp/Hf405P2T6874gqhTlzCfkN9RPSh1hF1M4K4Niy/9AOLGFEFD6e4nY2p/exLkHf3AVw7I/oYqavbg606zsJbolPdkkuu/BG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703480; c=relaxed/simple;
	bh=yujGdTXbiMO7zXVwAIVrsA48Z+lcBTqAUs3ROhvmWXg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=iQ3OrsTX/f4WuhitaXVupPYhx2nOLt8QcrA/6SGg7qdZYhGZCqS5Xl/WdUcD+m4hcCfhZfPxdOJM2cjpcb3Bj/pinbEdSixR1+rVIc7himj/MAf2BJbpjsbAQbakdy0FvZlOW5xK3RkXik3cMHyKZX4ObHigfW9cNMcX/KLdNVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIJK3Km4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E06C433F1;
	Fri, 23 Feb 2024 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708703480;
	bh=yujGdTXbiMO7zXVwAIVrsA48Z+lcBTqAUs3ROhvmWXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIJK3Km4ekhthkNHoFV9u7rZHv6Nw0EMV70orph/boX+yCCbaFCm7W+iWIbYmBHMo
	 /6NzUlokKM8JTMXNzZw1o+WfgkL7nR73wtIe6ZDpBFJi9JrHKEgrtqBKuOO6yA+fZk
	 sx5sQN4uzYU6TaRXGoiQkaVjSR65ovwTujvHXVzxIozSyw10xDOYceU6UDbvAjqDx2
	 sEq06Kp0RKZEgodfXDSHQ+HkyTa3ZfJKGJi6/CBTE/uEaVdGDI69XK3uiI1vBq/RQX
	 Qk8Tm7DJ0zLd4zNoe4SuzX4fHeYapaY9oiknwU5Mj95VSLB6YZykFvOI84SaDumyDG
	 zIOmVqA+R3kzw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 17:51:17 +0200
Message-Id: <CZCKTWU6ZCC9.2UTEQPEVICYHL@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
X-Mailer: aerc 0.15.2
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>

On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
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
> ---
>  drivers/char/tpm/Kconfig         |  11 ++
>  drivers/char/tpm/Makefile        |   1 +
>  drivers/char/tpm/tpm.h           |  10 ++
>  drivers/char/tpm/tpm2-cmd.c      |   5 +
>  drivers/char/tpm/tpm2-sessions.c | 276 +++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  49 ++++++
>  6 files changed, 352 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm2-sessions.c
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3..e3c39a83171b 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -27,6 +27,17 @@ menuconfig TCG_TPM
> =20
>  if TCG_TPM
> =20
> +config TCG_TPM2_HMAC
> +	bool "Use encrypted and HMACd transactions on the TPM bus"

How about simply "Use HMAC-encrypted transactions"

The details are anyway in the description.

> +	default y
> +	help
> +          Setting this causes us to deploy a scheme which uses request
          ~~~

extra spaces

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

I'm sorry but "sessions" and "init" are the worst possible terminology I
could every pick when trying to make a function that self-documents
itself :-)

I'd like to see here well-scoped name so that it is easy to connect
this to its purpose when reviewing some other patches.


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
> index 000000000000..9fc263ee02c2
> --- /dev/null
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
> + *

useless extra line in the commment

> + */
> +
> +#include "tpm.h"
> +

spurious newline

> +#include <asm/unaligned.h>

spurious newline
> +
> +#include <crypto/aes.h>

spurious newline
> +
> +/* if you change to AES256, you only need change this */
> +#define AES_KEYBYTES	AES_KEYSIZE_128

AES_KEY_BYTES. Also the comment is talking about changing something
without documenting what it is. Even not having the comment at all
would be less confusing.

> +
spurious newline

> +#define AES_KEYBITS	(AES_KEYBYTES*8)

AES_KEY_BITS

Also, documentation missing.

> +

Documentation missing for "tpm2_parse_create_primary". It is a complex
function despite being not exported so definitely needs documentation.


> +static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_b=
uf *buf,
> +				     u32 *nullkey)
                                          ~~~~~~~
					  null_key

> +{
> +	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> +	off_t offset_r =3D TPM_HEADER_SIZE, offset_t;
> +	u16 len =3D TPM_HEADER_SIZE;
> +	u32 tot_len =3D be32_to_cpu(head->length);

no good reason to use more confusing namme "tot_len", instead of more
readable "total_len".

> +	u32 val, parm_len;
> +
> +	*nullkey =3D tpm_buf_read_u32(buf, &offset_r);
> +	parm_len =3D tpm_buf_read_u32(buf, &offset_r);
        ~~~~~~~~
	param_len

> +	/*
> +	 * parm_len doesn't include the header, but all the other
> +	 * lengths and offsets do, so add it to parm len to make
> +	 * the comparisons easier
> +	 */
> +	parm_len +=3D TPM_HEADER_SIZE;
> +
> +	if (parm_len + 8 > tot_len)
> +		return -EINVAL;
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	offset_t =3D offset_r;
> +	/* now we have the public area, compute the name of the object */
> +	put_unaligned_be16(TPM_ALG_SHA256, chip->null_key_name);
> +	sha256(&buf->data[offset_r], len, chip->null_key_name + 2);
> +
> +	/* validate the public key */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	/* key type (must be what we asked for) */
> +	if (val !=3D TPM_ALG_ECC)
> +		return -EINVAL;
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	/* name algorithm */
> +	if (val !=3D TPM_ALG_SHA256)
> +		return -EINVAL;
> +	val =3D tpm_buf_read_u32(buf, &offset_t);
> +	/* object properties */
> +	if (val !=3D (TPM2_OA_NO_DA |
> +		    TPM2_OA_FIXED_TPM |
> +		    TPM2_OA_FIXED_PARENT |
> +		    TPM2_OA_SENSITIVE_DATA_ORIGIN |
> +		    TPM2_OA_USER_WITH_AUTH |
> +		    TPM2_OA_DECRYPT |
> +		    TPM2_OA_RESTRICTED))

Please make define a mask constant for these bits and use it here
instead. There's just too many and make the code really unredable.
I'd even suggesting documenting that constant with some rationale
for the mask.

Here the logic is obviously to fix the primary key to the exact
chip and make unmovable (cannot be migrated), isn't it? That would
perfectly sufficient documentation for the constant, or along the
lines.


> +		return -EINVAL;
> +	/* auth policy (empty) */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D 0)
> +		return -EINVAL;

I'd add empty line betwen each of these checks to make it more
readable.

> +	/* symmetric key parameters */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM_ALG_AES)
> +		return -EINVAL;
> +	/* symmetric key length */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D AES_KEYBITS)
> +		return -EINVAL;
> +	/* symmetric encryption scheme */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM_ALG_CFB)
> +		return -EINVAL;
> +	/* signing scheme */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM_ALG_NULL)
> +		return -EINVAL;
> +	/* ECC Curve */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM2_ECC_NIST_P256)
> +		return -EINVAL;
> +	/* KDF Scheme */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D TPM_ALG_NULL)
> +		return -EINVAL;
> +	/* x point */
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
> +	if (offset_r > parm_len)
> +		return -EINVAL;
> +	/* creation data (skip) */
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	offset_r +=3D len;
> +	if (offset_r > parm_len)
> +		return -EINVAL;
> +	/* creation digest (must be sha256) */
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	offset_r +=3D len;
> +	if (len !=3D SHA256_DIGEST_SIZE || offset_r > parm_len)
> +		return -EINVAL;
> +	/* TPMT_TK_CREATION follows */
> +	/* tag, must be TPM_ST_CREATION (0x8021) */
> +	val =3D tpm_buf_read_u16(buf, &offset_r);
> +	if (val !=3D TPM2_ST_CREATION || offset_r > parm_len)
> +		return -EINVAL;
> +	/* hierarchy (must be NULL) */
> +	val =3D tpm_buf_read_u32(buf, &offset_r);
> +	if (val !=3D TPM2_RH_NULL || offset_r > parm_len)
> +		return -EINVAL;
> +	/* the ticket digest HMAC (might not be sha256) */
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	offset_r +=3D len;
> +	if (offset_r > parm_len)
> +		return -EINVAL;
> +	/*
> +	 * finally we have the name, which is a sha256 digest plus a 2
> +	 * byte algorithm type
> +	 */
> +	len =3D tpm_buf_read_u16(buf, &offset_r);
> +	if (offset_r + len !=3D parm_len + 8)
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
>

documentation missing:

> +static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy, u32=
 *handle)
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
> +	 * key
> +	 */
> +
> +	/* key type */
> +	tpm_buf_append_u16(&template, TPM_ALG_ECC);
> +	/* name algorithm */
> +	tpm_buf_append_u16(&template, TPM_ALG_SHA256);
> +	/* object properties */
> +	tpm_buf_append_u32(&template, TPM2_OA_NO_DA |
> +			   TPM2_OA_FIXED_TPM |
> +			   TPM2_OA_FIXED_PARENT |
> +			   TPM2_OA_SENSITIVE_DATA_ORIGIN |
> +			   TPM2_OA_USER_WITH_AUTH |
> +			   TPM2_OA_DECRYPT |
> +			   TPM2_OA_RESTRICTED);
> +	/* sauth policy (empty) */
> +	tpm_buf_append_u16(&template, 0);
> +
> +	/* BEGIN parameters: key specific; for ECC*/
> +	/* symmetric algorithm */
> +	tpm_buf_append_u16(&template, TPM_ALG_AES);
> +	/* bits for symmetric algorithm */
> +	tpm_buf_append_u16(&template, 128);
> +	/* algorithm mode (must be CFB) */
> +	tpm_buf_append_u16(&template, TPM_ALG_CFB);
> +	/* scheme (NULL means any scheme) */
> +	tpm_buf_append_u16(&template, TPM_ALG_NULL);
> +	/* ECC Curve ID */
> +	tpm_buf_append_u16(&template, TPM2_ECC_NIST_P256);
> +	/* KDF Scheme */
> +	tpm_buf_append_u16(&template, TPM_ALG_NULL);
> +	/* unique: key specific; for ECC it is two points */
> +	tpm_buf_append_u16(&template, 0);
> +	tpm_buf_append_u16(&template, 0);
> +	/* END parameters */
> +
> +	/* primary handle */
> +	tpm_buf_append_u32(&buf, hierarchy);
> +	tpm_buf_append_empty_auth(&buf, TPM2_RS_PW);
> +	/* sensitive create size is 4 for two empty buffers */
> +	tpm_buf_append_u16(&buf, 4);
> +	/* sensitive create auth data (empty) */
> +	tpm_buf_append_u16(&buf, 0);
> +	/* sensitive create sensitive data (empty) */
> +	tpm_buf_append_u16(&buf, 0);
> +	/* the public template */
> +	tpm_buf_append(&buf, template.data, template.length);
> +	tpm_buf_destroy(&template);
> +	/* outside info (empty) */
> +	tpm_buf_append_u16(&buf, 0);
> +	/* creation PCR (none) */
> +	tpm_buf_append_u32(&buf, 0);
> +
> +	rc =3D tpm_transmit_cmd(chip, &buf, 0,
> +			      "attempting to create NULL primary");
> +
> +	if (rc =3D=3D TPM2_RC_SUCCESS)
> +		rc =3D tpm2_parse_create_primary(chip, &buf, handle);
> +
> +	tpm_buf_destroy(&buf);
> +
> +	return rc;
> +}
> +
> +static int tpm2_create_null_primary(struct tpm_chip *chip)
> +{
> +	u32 nullkey;
            ~~~~~~~
	    null_key
  =20

> +	int rc;
> +
> +	rc =3D tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey);
> +
> +	if (rc =3D=3D TPM2_RC_SUCCESS) {
> +		unsigned int offset =3D 0; /* dummy offset for null key context */
> +
> +		rc =3D tpm2_save_context(chip, nullkey, chip->null_key_context,
> +				       sizeof(chip->null_key_context), &offset);
> +		tpm2_flush_context(chip, nullkey);
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

isn't this exactly for HMAC authorization at least in the patch set
scope? plural confuses me here.

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
> +EXPORT_SYMBOL(tpm2_sessions_init);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 6be263509e81..3060ab794afb 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -35,12 +35,15 @@ struct trusted_key_options;
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
> @@ -49,6 +52,11 @@ enum tpm_algorithms {
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
> @@ -116,6 +124,20 @@ struct tpm_chip_seqops {
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
> @@ -170,6 +192,14 @@ struct tpm_chip {
> =20
>  	/* active locality */
>  	int locality;
> +
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +	/* details for communication security via sessions */
> +	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE]; /* context for NULL seed */

	/* Saved context of the null seed: */

I like the description on top because they suffer less alignment
issues and can have more verbose explanation. "context for NULL
seed" is good as no comment at all./

> +	u8 null_key_name[TPM2_NAME_SIZE];	 /* name of NULL seed */

	/* Digest of the public area: */

This is not totally accurate but way more documenting than the
current description, which is tautology, i.e. you are saying that
"name is name" in the comment leaving the reader questioning what
the heck is name.

Not totally accurate i.e. missing concatenated alg identifier but
good enough...


> +	u8 null_ec_key_x[EC_PT_SZ];
> +	u8 null_ec_key_y[EC_PT_SZ];
> +#endif

this is now very nice clean and udnerstandable:

I'd prefer tho this formatting:

	/* Name of the NULL seed: */
	u8 null_key_name[TPM2_NAME_SIZE];


>  };
> =20
>  #define TPM_HEADER_SIZE		10
> @@ -194,6 +224,7 @@ enum tpm2_timeouts {
>  enum tpm2_structures {
>  	TPM2_ST_NO_SESSIONS	=3D 0x8001,
>  	TPM2_ST_SESSIONS	=3D 0x8002,
> +	TPM2_ST_CREATION	=3D 0x8021,
>  };
> =20
>  /* Indicates from what layer of the software stack the error comes from =
*/
> @@ -243,6 +274,7 @@ enum tpm2_command_codes {
>  };
> =20
>  enum tpm2_permanent_handles {
> +	TPM2_RH_NULL		=3D 0x40000007,
>  	TPM2_RS_PW		=3D 0x40000009,
>  };
> =20
> @@ -318,7 +350,11 @@ struct tpm_buf {
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

Here would be a great place to declarate aforementioned mask.

>  enum tpm2_session_attributes {
> @@ -373,6 +409,15 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32=
 pcr_idx,
>  extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>  extern struct tpm_chip *tpm_default_chip(void);
>  void tpm2_flush_context(struct tpm_chip *chip, u32 handle);

please add empty line here.

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
> @@ -399,5 +444,9 @@ static inline struct tpm_chip *tpm_default_chip(void)
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

I skipped first eleven patches because they are completed. This patch
will be finished once all the numerous style issues have been fixed.
Approach is totally correct...

BR, Jarkko

