Return-Path: <linux-integrity+bounces-623-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E49B823038
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421571C234FD
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9211B26E;
	Wed,  3 Jan 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kabnf1U9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264B1B268;
	Wed,  3 Jan 2024 15:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A50EC433C7;
	Wed,  3 Jan 2024 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704294691;
	bh=en1OtGkUIm4Qrlkr3bxu3fKr8DhQsjU4B2fAl5EmIOk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kabnf1U9waSjSQXDphoGB7bo5aoSZz6P8s+5e6z9Oj97xg45aaVUmqbkFQELYo3cL
	 b3YJo7+PV/g9WV6AlkVPFrkhHgUSaPH0Uu0/m7zO+wh6oOwEVTooNkIn0G3Bgyri0I
	 TX1BheDF36RVpY79lG4zxk9J75aS+tkpZPQmRNmTnN8bcYYVBVgcxrWBAobrtzISAY
	 KwyV+Hdb+pwtKJE1Vi9qpzrtxnX14U6HZpp96B/jGGpsk6OQQLKS9DdXN0cHYakCO0
	 +8o8YukqNYGr2xDFYH7HE5UPK4Hff8/SUA5FPMb8za/OiMR863Ap5cAvH554WettAQ
	 VLJ5g7rVY0AWA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 17:11:27 +0200
Message-Id: <CY561MZ9UH2Z.3PMLA57T4GKD2@suppilovahvero>
Subject: Re: [PATCH v6 12/20] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-13-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240102170408.21969-13-James.Bottomley@HansenPartnership.com>

On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
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
> +	default y
> +	help
> +          Setting this causes us to deploy a scheme which uses request
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
> index 000000000000..ef66c28bb332
> --- /dev/null
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
> + *
> + */
> +
> +#include "tpm.h"
> +
> +#include <asm/unaligned.h>
> +
> +#include <crypto/aes.h>
> +
> +/* if you change to AES256, you only need change this */
> +#define AES_KEYBYTES	AES_KEYSIZE_128
> +
> +#define AES_KEYBITS	(AES_KEYBYTES*8)
> +
> +static int parse_create_primary(struct tpm_chip *chip, struct tpm_buf *b=
uf,
> +				u32 *nullkey)

nit: i'd add tpm2_ in from as other functions.

> +{
> +	struct tpm_header *head =3D (struct tpm_header *)buf->data;
> +	off_t offset_r =3D TPM_HEADER_SIZE, offset_t;
> +	u16 len =3D TPM_HEADER_SIZE;
> +	u32 tot_len =3D be32_to_cpu(head->length);
> +	u32 val, parm_len;
> +
> +	*nullkey =3D tpm_buf_read_u32(buf, &offset_r);
> +	parm_len =3D tpm_buf_read_u32(buf, &offset_r);
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
> +	put_unaligned_be16(TPM_ALG_SHA256, chip->tpmkeyname);
> +	sha256(&buf->data[offset_r], len, chip->tpmkeyname + 2);
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
> +		return -EINVAL;
> +	/* auth policy (empty) */
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D 0)
> +		return -EINVAL;
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
> +	memcpy(chip->ec_point_x, &buf->data[offset_t], val);
> +	offset_t +=3D val;
> +	val =3D tpm_buf_read_u16(buf, &offset_t);
> +	if (val !=3D EC_PT_SZ)
> +		return -EINVAL;
> +	memcpy(chip->ec_point_y, &buf->data[offset_t], val);
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
> +	if (memcmp(chip->tpmkeyname, &buf->data[offset_r],
> +		   SHA256_DIGEST_SIZE + 2) !=3D 0) {
> +		dev_err(&chip->dev, "NULL Seed name comparison failed\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
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
> +		rc =3D parse_create_primary(chip, &buf, handle);
> +
> +	tpm_buf_destroy(&buf);
> +
> +	return rc;
> +}
> +
> +static int tpm2_create_null_primary(struct tpm_chip *chip)
> +{
> +	u32 nullkey;
> +	int rc;
> +
> +	rc =3D tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey);
> +
> +	if (rc =3D=3D TPM2_RC_SUCCESS) {
> +		unsigned int offset =3D 0; /* dummy offset for tpmkeycontext */
> +
> +		rc =3D tpm2_save_context(chip, nullkey, chip->tpmkeycontext,
> +				       sizeof(chip->tpmkeycontext), &offset);
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
> index 6be263509e81..bdb03c093914 100644
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
> +	u8 tpmkeycontext[TPM2_MAX_CONTEXT_SIZE]; /* context for NULL seed */
> +	u8 tpmkeyname[TPM2_NAME_SIZE];		 /* name of NULL seed */

these are bit convoluted imho.

Maybe simply name them as hmac_context and hmac_key_name? Then they
are somewhat self-documenting.


> +	u8 ec_point_x[EC_PT_SZ];
> +	u8 ec_point_y[EC_PT_SZ];

And also prefix these similarly with hmac.

I'm actually thinking that since there's 4 field already maybe we should
really have these all bundled to let's say "struct tpm_hmac_session" and
the parse function would take this as parameter?

Anyway at least the naming changes would be nice.

> +#endif
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
>  enum tpm2_session_attributes {
> @@ -373,6 +409,15 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32=
 pcr_idx,
>  extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>  extern struct tpm_chip *tpm_default_chip(void);
>  void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
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

Otherwise looking pretty good.

BR, Jarkko

