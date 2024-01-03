Return-Path: <linux-integrity+bounces-628-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3282306F
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD791F23273
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83A01A72A;
	Wed,  3 Jan 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK+ZWoRr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1EC1A720;
	Wed,  3 Jan 2024 15:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BCCC433C7;
	Wed,  3 Jan 2024 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295310;
	bh=/D6HIpFh+oH/Hd4WshiVmxui6yXsgqVD/QLyEp+wHCQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=oK+ZWoRr1YGFmUdpccBMJ/OSBTNbmtZRjyRHTOot/qRz3RDdN9vBRkR2uSwCy7+Jn
	 o1w8w4LPhNil2nxvgkmtdGz4JX24ILjwp4fzq5AqcxNJAXW5kFtdPBEydWOkyzPpQ7
	 ZxH/0pX6YLrIJ9m8+5fjVZC4Iil/LORkgcNV94rx12N/icg8pTqv5K97kX7R0JtoCu
	 xo5Yia5VCUqPIh78v+rO+HH194q/fpDVkDAv3RGE3LjnIPIVihx19EqD/eey3EtBhn
	 qSlyFsCmkaKx1NtfWDJXrD61Lw/+mohY7qgo/a3Bv0+wz6a6hHKebmaTYTNwYGFfwh
	 vV2bvZZQY6c2Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 17:21:47 +0200
Message-Id: <CY569JIPC0JB.2FXL1JOK2MT1S@suppilovahvero>
Subject: Re: [PATCH v6 17/20] tpm: add session encryption protection to
 tpm2_get_random()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-18-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240102170408.21969-18-James.Bottomley@HansenPartnership.com>

On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
> If some entity is snooping the TPM bus, they can see the random
> numbers we're extracting from the TPM and do prediction attacks
> against their consumers.  Foil this attack by using response
> encryption to prevent the attacker from seeing the random sequence.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index a53a843294ed..0cdf892ec2a7 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -292,25 +292,35 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest=
, size_t max)
>  	if (!num_bytes || max > TPM_MAX_RNG_DATA)
>  		return -EINVAL;
> =20
> -	err =3D tpm_buf_init(&buf, 0, 0);
> +	err =3D tpm2_start_auth_session(chip);
>  	if (err)
>  		return err;
> =20
> +	err =3D tpm_buf_init(&buf, 0, 0);
> +	if (err) {
> +		tpm2_end_auth_session(chip);
> +		return err;
> +	}
> +
>  	do {
> -		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
> +		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
> +		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
> +						| TPM2_SA_CONTINUE_SESSION,
> +						NULL, 0);
>  		tpm_buf_append_u16(&buf, num_bytes);
> +		tpm_buf_fill_hmac_session(chip, &buf);
>  		err =3D tpm_transmit_cmd(chip, &buf,
>  				       offsetof(struct tpm2_get_random_out,
>  						buffer),
>  				       "attempting get random");
> +		err =3D tpm_buf_check_hmac_response(chip, &buf, err);
>  		if (err) {
>  			if (err > 0)
>  				err =3D -EIO;
>  			goto out;
>  		}
> =20
> -		out =3D (struct tpm2_get_random_out *)
> -			&buf.data[TPM_HEADER_SIZE];
> +		out =3D (struct tpm2_get_random_out *)tpm_buf_parameters(&buf);
>  		recd =3D min_t(u32, be16_to_cpu(out->size), num_bytes);
>  		if (tpm_buf_length(&buf) <
>  		    TPM_HEADER_SIZE +
> @@ -327,9 +337,12 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest,=
 size_t max)
>  	} while (retries-- && total < max);
> =20
>  	tpm_buf_destroy(&buf);
> +	tpm2_end_auth_session(chip);
> +
>  	return total ? total : -EIO;
>  out:
>  	tpm_buf_destroy(&buf);
> +	tpm2_end_auth_session(chip);
>  	return err;
>  }
> =20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

