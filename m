Return-Path: <linux-integrity+bounces-629-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C8823071
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E296B209AB
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6376E1A72A;
	Wed,  3 Jan 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cug1oTGG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449841A726;
	Wed,  3 Jan 2024 15:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3343BC433C7;
	Wed,  3 Jan 2024 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295332;
	bh=SWwJKf44RYSFm8qgxZw71G+sW0yUWREihM2r+tXdCL0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Cug1oTGG8qwxNop8kt3wl0uPwoyRMI/tOflu8kPEBytgN9L0HC3EzhkzWwbWIPKTg
	 kY5x4RkKMoMhK0umuMI2wq3d57TKhxKcXdAE64AQHs7SpPIR9dXT8wz8gnAccZTArV
	 LEyrIrYJSkbSO0Tt64nXr817gOI4E6ZXDC+o2+Yq7oi0FF9YVdEq1Ba0nPxR9SxOBY
	 q+5Ip1sCwibC1yUFDUokz1Kh1fT1ft+GVnMGEfTPwukUKbmyj7Nts5wr07Ksuv1Ud1
	 9O+PfRMUbOAjNdB+mbphgsAw/jDDcLKYWgOw2bcj1KPjeozQULpIIbDSMVGo0wquqm
	 kGcraHUHzH3TA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 17:22:09 +0200
Message-Id: <CY569TOUMYLT.1LQ6M7Q54WBZR@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 18/20] KEYS: trusted: Add session encryption
 protection to the seal/unseal path
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-19-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240102170408.21969-19-James.Bottomley@HansenPartnership.com>

On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
> If some entity is snooping the TPM bus, the can see the data going in
> to be sealed and the data coming out as it is unsealed.  Add parameter
> and response encryption to these cases to ensure that no secrets are
> leaked even if the bus is snooped.
>
> As part of doing this conversion it was discovered that policy
> sessions can't work with HMAC protected authority because of missing
> pieces (the tpm Nonce).  I've added code to work the same way as
> before, which will result in potential authority exposure (while still
> adding security for the command and the returned blob), and a fixme to
> redo the API to get rid of this security hole.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
>
> v2: fix unseal with policy and password
> v3: fix session memory leak
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 88 ++++++++++++++++-------
>  1 file changed, 61 insertions(+), 27 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index 97b1dfca2dba..dfeec06301ce 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -253,26 +253,26 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	if (rc)
>  		return rc;
> =20
> +	rc =3D tpm2_start_auth_session(chip);
> +	if (rc)
> +		goto out_put;
> +
>  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
>  	if (rc) {
> -		tpm_put_ops(chip);
> -		return rc;
> +		tpm2_end_auth_session(chip);
> +		goto out_put;
>  	}
> =20
>  	rc =3D tpm_buf_init_sized(&sized);
>  	if (rc) {
>  		tpm_buf_destroy(&buf);
> -		tpm_put_ops(chip);
> -		return rc;
> +		tpm2_end_auth_session(chip);
> +		goto out_put;
>  	}
> =20
> -	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
> -	tpm_buf_append_u32(&buf, options->keyhandle);
> -	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
> -			     NULL /* nonce */, 0,
> -			     0 /* session_attributes */,
> -			     options->keyauth /* hmac */,
> -			     TPM_DIGEST_SIZE);
> +	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
> +				    options->keyauth, TPM_DIGEST_SIZE);
> =20
>  	/* sensitive */
>  	tpm_buf_append_u16(&sized, options->blobauth_len);
> @@ -314,10 +314,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> =20
>  	if (buf.flags & TPM_BUF_OVERFLOW) {
>  		rc =3D -E2BIG;
> +		tpm2_end_auth_session(chip);
>  		goto out;
>  	}
> =20
> +	tpm_buf_fill_hmac_session(chip, &buf);
>  	rc =3D tpm_transmit_cmd(chip, &buf, 4, "sealing data");
> +	rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
>  	if (rc)
>  		goto out;
> =20
> @@ -348,6 +351,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	else
>  		payload->blob_len =3D blob_len;
> =20
> +out_put:
>  	tpm_put_ops(chip);
>  	return rc;
>  }
> @@ -417,25 +421,31 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	if (blob_len > payload->blob_len)
>  		return -E2BIG;
> =20
> -	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
> +	rc =3D tpm2_start_auth_session(chip);
>  	if (rc)
>  		return rc;
> =20
> -	tpm_buf_append_u32(&buf, options->keyhandle);
> -	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
> -			     NULL /* nonce */, 0,
> -			     0 /* session_attributes */,
> -			     options->keyauth /* hmac */,
> -			     TPM_DIGEST_SIZE);
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
> +	if (rc) {
> +		tpm2_end_auth_session(chip);
> +		return rc;
> +	}
> +
> +	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
> +				    TPM_DIGEST_SIZE);
> =20
>  	tpm_buf_append(&buf, blob, blob_len);
> =20
>  	if (buf.flags & TPM_BUF_OVERFLOW) {
>  		rc =3D -E2BIG;
> +		tpm2_end_auth_session(chip);
>  		goto out;
>  	}
> =20
> +	tpm_buf_fill_hmac_session(chip, &buf);
>  	rc =3D tpm_transmit_cmd(chip, &buf, 4, "loading blob");
> +	rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
>  	if (!rc)
>  		*blob_handle =3D be32_to_cpup(
>  			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
> @@ -473,20 +483,44 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  	u8 *data;
>  	int rc;
> =20
> -	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
> +	rc =3D tpm2_start_auth_session(chip);
>  	if (rc)
>  		return rc;
> =20
> -	tpm_buf_append_u32(&buf, blob_handle);
> -	tpm2_buf_append_auth(&buf,
> -			     options->policyhandle ?
> -			     options->policyhandle : TPM2_RS_PW,
> -			     NULL /* nonce */, 0,
> -			     TPM2_SA_CONTINUE_SESSION,
> -			     options->blobauth /* hmac */,
> -			     options->blobauth_len);
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
> +	if (rc) {
> +		tpm2_end_auth_session(chip);
> +		return rc;
> +	}
> +
> +	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
> +
> +	if (!options->policyhandle) {
> +		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
> +					    options->blobauth,
> +					    options->blobauth_len);
> +	} else {
> +		/*
> +		 * FIXME: The policy session was generated outside the
> +		 * kernel so we don't known the nonce and thus can't
> +		 * calculate a HMAC on it.  Therefore, the user can
> +		 * only really use TPM2_PolicyPassword and we must
> +		 * send down the plain text password, which could be
> +		 * intercepted.  We can still encrypt the returned
> +		 * key, but that's small comfort since the interposer
> +		 * could repeat our actions with the exfiltrated
> +		 * password.
> +		 */
> +		tpm2_buf_append_auth(&buf, options->policyhandle,
> +				     NULL /* nonce */, 0, 0,
> +				     options->blobauth, options->blobauth_len);
> +		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT,
> +						NULL, 0);
> +	}
> =20
> +	tpm_buf_fill_hmac_session(chip, &buf);
>  	rc =3D tpm_transmit_cmd(chip, &buf, 6, "unsealing");
> +	rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
>  	if (rc > 0)
>  		rc =3D -EPERM;
> =20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

