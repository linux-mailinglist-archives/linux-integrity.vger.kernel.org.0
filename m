Return-Path: <linux-integrity+bounces-3123-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 220BE9324AD
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 13:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B78BB24220
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 11:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916FE1990A5;
	Tue, 16 Jul 2024 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akmv+xLt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C5197543;
	Tue, 16 Jul 2024 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128427; cv=none; b=LeUEnjAjzNf7lmbSoMLBHELkR6u1IC2xgCOqa/WwnSQ6T/gY6q1cyNDvV8lvHKY/npO7jwgU2qV7dG57WccYTLVzdXfl6PDLwwLR37wF8iKbWcHPYll6PKYIt2luPY7XRSMVn/U8djaOVLXNvb0dwD2TqDg3Xa/kWmouajP5u7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128427; c=relaxed/simple;
	bh=0vdbSu1OCtFKw0qJs8Rw+nkNJ7PcbDbwEAd5tcv14T0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U5Rxj0rLa1c3QARXVbyrQKsyRwWy1HWskCFbdaFhRJDDf4usA3MF0CNHcx1N//4ZvDD0j4WhvIygzVhKONGnShUQPAsdlcAmsB7rTOKJBuwV/FBBmf51Oej05yp20FcjU0SV+/zUlbWSNqAbFs0MuA6q2Q5TzVedmvciYD6srcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akmv+xLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62627C4AF09;
	Tue, 16 Jul 2024 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128427;
	bh=0vdbSu1OCtFKw0qJs8Rw+nkNJ7PcbDbwEAd5tcv14T0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=akmv+xLt6JNjS+Ii9gDW+b3EsweQoh5yuVYNnUITdW9pAPhwA/vqc8jXNzBhACFv3
	 kjB9oo+LXbiwFm/aGbSEmco2VdKD2HJFFWTDeHNdcpz8uUN0Oz/QRgM4eCdF4dgPyu
	 7AchizP8/3ZdEofN3Na5sbi1AowncUq+AhzdUngGDjecxACIT35Xv2Np3qEKAuZ3ol
	 glERXXfBLIMVzqLrsJx8PaeXu9K6fKcvItKYtbKFOoiR8wHUKsOAESz8CIbWzDNOo6
	 tac9j9R7tLDv8Km0+r/gkzZlF5m2DQb1N+/bfQwGYWLYXnmYPh9tHcrRoLu09g5Yer
	 8/O3BR6GwD6yw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 14:13:44 +0300
Message-Id: <D2QX3UY7MF0A.2GZRRAUVMT1ST@kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 1/6] tpm: consolidate TPM to crypto hash algorithm
 conversion
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524130459.21510-2-James.Bottomley@HansenPartnership.com>

Now I bandwidth to give this the first round.

On Fri May 24, 2024 at 4:04 PM EEST, James Bottomley wrote:
> linux crypto and the TPM use different numeric algorithm identifiers
> for hash (and other) functions.  The conversion array for this already

Please use exact names i.e. conversion is between enum tpm2_algorithms
and enum hash_info. Much easier to lookup later on.

> exists in two separate places.  The new policy sessions code would
> have to add a third copy, so instead of increasing the duplication,
> move the definition to a single consolidated place in tpm.h so the
> policy code can use it as is.

"the new policy session code" is not an artifact.

Instead, please say what needs the third instance and why. I don't
consume white paper text.

I'm fine if you just use merging two redundant copies together, with
no reference to the third copy. In this form this unconditional NAK
given that I have zero idea what the third copy is and where it is
located.

>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c               |  8 ----
>  include/linux/tpm.h                       | 52 ++++++++++++++++++++++-
>  security/keys/trusted-keys/trusted_tpm2.c | 20 +--------
>  3 files changed, 53 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 0cdf892ec2a7..f4428e715dd8 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -14,14 +14,6 @@
>  #include "tpm.h"
>  #include <crypto/hash_info.h>
> =20
> -static struct tpm2_hash tpm2_hash_map[] =3D {
> -	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> -	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> -	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> -	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
> -	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> -};
> -
>  int tpm2_get_timeouts(struct tpm_chip *chip)
>  {
>  	/* Fixed timeouts for TPM2 */
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index c17e4efbb2e5..07f532456a0c 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -418,11 +418,61 @@ enum tpm2_session_attributes {
>  	TPM2_SA_AUDIT			=3D BIT(7),
>  };
> =20
> -struct tpm2_hash {
> +static const struct {
>  	unsigned int crypto_id;
>  	unsigned int tpm_id;
> +} tpm2_hash_map[] =3D {
> +	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> +	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> +	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> +	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
> +	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
>  };
> =20
> +/**
> + * tpm2_crypto_to_alg() - convert a crypto hash to a TPM alg id
> + *
> + * @hash: the crypto subsystem view of the hash
> + *
> + * Return: TPM algorithm id or -1 if no mapping was found.
> + */
> +static inline int tpm2_crypto_to_alg(int hash)
> +{
> +	int i;
> +	int tpm_alg =3D -1;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> +		if (hash =3D=3D tpm2_hash_map[i].crypto_id) {
> +			tpm_alg =3D tpm2_hash_map[i].tpm_id;
> +			break;
> +		}
> +	}
> +
> +	return tpm_alg;
> +}
> +
> +/**
> + * tpm2_alg_to_crypto() - convert a TPM alg id to a crypto hash
> + *
> + * @hash: the TPM alg id view of the hash
> + *
> + * Return: TPM algorithm id or -1 if no mapping was found.
> + */
> +static inline int tpm2_alg_to_crypto(int hash)
> +{
> +	int i;
> +	int crypto_hash =3D -1;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> +		if (hash =3D=3D tpm2_hash_map[i].tpm_id) {
> +			crypto_hash =3D tpm2_hash_map[i].crypto_id;
> +			break;
> +		}
> +	}
> +
> +	return crypto_hash;
> +}
> +
>  int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
>  void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
>  int tpm_buf_init_sized(struct tpm_buf *buf);
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index dfeec06301ce..94ff9ccae66e 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -18,14 +18,6 @@
> =20
>  #include "tpm2key.asn1.h"
> =20
> -static struct tpm2_hash tpm2_hash_map[] =3D {
> -	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> -	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> -	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> -	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
> -	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> -};
> -
>  static u32 tpm2key_oid[] =3D { 2, 23, 133, 10, 1, 5 };
> =20
>  static int tpm2_key_encode(struct trusted_key_payload *payload,
> @@ -231,19 +223,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	off_t offset =3D TPM_HEADER_SIZE;
>  	struct tpm_buf buf, sized;
>  	int blob_len =3D 0;
> -	u32 hash;
> +	int hash =3D tpm2_crypto_to_alg(options->hash);

Please use reverse christmas tree order.

>  	u32 flags;
> -	int i;
>  	int rc;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> -		if (options->hash =3D=3D tpm2_hash_map[i].crypto_id) {
> -			hash =3D tpm2_hash_map[i].tpm_id;
> -			break;
> -		}
> -	}
> -
> -	if (i =3D=3D ARRAY_SIZE(tpm2_hash_map))
> +	if (hash < 0)
>  		return -EINVAL;
> =20
>  	if (!options->keyhandle)


BR, Jarkko

