Return-Path: <linux-integrity+bounces-1427-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 600DF8618EC
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A96B22F55
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7DB12C544;
	Fri, 23 Feb 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLNqaPgG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2442A99;
	Fri, 23 Feb 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708260; cv=none; b=tZMlETXJ96fZ24MxfprfJCGKHkbNFJpnA10SbXmt3xwj9XueWyWX++lzDOSLcm1n1B/Nx+bgiKuQdXaEKcXoE8vhNls71giC8/vFZ1LiEh+f4pyAc1RJiPI8Bpjh+jfk/VNyPeA3420sfkOp90UPpr/xdhjKQr0z/4K/2F46L4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708260; c=relaxed/simple;
	bh=OwT9O0jQdne2KUKIWONtWWKraJ199B6c2JoVLFX73Uo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=KFdzVIkl4o0fR2+uenQVZyDlsOEyeX3H29Bm33G7beYRIt0aBBQRd/y2uMfdIUn/mMPZMHNeY6oXeEf/TAiGjClFAGTpOdvQmQltkAhhBhy7irKPskQ/F8mgpLFgIIgqYPEMxeAOPm/f5XC1Yxb60Y7nfvl2XV+A1Tz7xgBPSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLNqaPgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0071C433F1;
	Fri, 23 Feb 2024 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708260;
	bh=OwT9O0jQdne2KUKIWONtWWKraJ199B6c2JoVLFX73Uo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=vLNqaPgG4MT7KdVCulXFxZlEpjUuBKYc2Y1D5dxtsO2SHVDwXNf4j0TKpJYMQQsSH
	 Mu0NTBd8t/eNbEaVRzu12RFGFVFpDMM/xvi/wtvBKiePAb+2sea4nSBFJgJJkufX8C
	 aE1fuTeTYE06BYGJma3eJ1nELaVJYo2ofyJGhNMfzD7Brh6pasvYL2zt84+MFaSbFo
	 4E1AkJcC5Jv4VEZKFpJYNBpMUQc2oYhnlMXt76tKB4lPA97EhpPgTNM3cChcommt+W
	 0EI5EMl0sPxdrCi2QdkhH/tn+sBtyvBhyY/EM4OiT8sESNcSm+pXcZrhwDKCPg7lgb
	 jy/OOj1DDrwLw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 19:10:57 +0200
Message-Id: <CZCMIX2HI730.2QBY5FZCYJGJX@suppilovahvero>
Subject: Re: [PATCH v7 17/21] tpm: add session encryption protection to
 tpm2_get_random()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-18-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240213171334.30479-18-James.Bottomley@HansenPartnership.com>

On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
> If some entity is snooping the TPM bus, they can see the random
> numbers we're extracting from the TPM and do prediction attacks
> against their consumers.  Foil this attack by using response
> encryption to prevent the attacker from seeing the random sequence.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> ---
> v7: add review
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

ditto

BR, Jarkko

