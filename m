Return-Path: <linux-integrity+bounces-1428-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E18618F1
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 18:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB6F1C23DB5
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90912BF0E;
	Fri, 23 Feb 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ5WuGCW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827D12BE98;
	Fri, 23 Feb 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708298; cv=none; b=M5b2+MR/ABYvTe1qDT8CCR6KityUC7WmxL0vVwTYAifmRo2gMF46tE5fVeGYqds6axB+VUgT6xTr7Gaqee0hcb/ApbzSOjfS7RBROBY6GFBAjVqn3PrWxN9p5hWlOFXJgUl+E82GDl9HGZ4p90bHB/m8QRg0JPkLp5VdHMzfG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708298; c=relaxed/simple;
	bh=g5byIcPH6nWlfWK7V+L1T7A+f2DfWNtZsU+Qsb9NTpQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZL7CURq7e/bcXGuKDDYndHfPrSOKFMx5KSBB3L1McpborNnl5sfB5t6NhUfHOFk4qpplv291zlMYnX8lMHM7p0EnJvvkivWbKIsvr+DR98wvivU3GGTJ8MZilxk5W9S+p+TWCyjyaYUP+XQq56BKlRO15iPXAfsP9aJqE24xn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ5WuGCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53845C43390;
	Fri, 23 Feb 2024 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708298;
	bh=g5byIcPH6nWlfWK7V+L1T7A+f2DfWNtZsU+Qsb9NTpQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=lZ5WuGCWsPpKF47iIbNdwuwd4BJCmBtkFPx5emFPNqTfKeMmRkZyR+yWIGv8RK+UY
	 nSyiF2edZvmaSqJ5FhmWaulPkDAs5aTh7pPj2jaK+Xe1yGNFsABL0FvLLSgSkOtu0G
	 nn3DR9AdHlPdtmvb8oBhQgLCzwDCOnq/B7upfhkDFScLacsTS8zc0eIl3kdsvXsTqu
	 PQ5pyE0/Bgo2j4z7PEFU4NsxQx3Yap+ZJe4CHDVlF4aAAEUAJF6VOyBkk6iUnKlcKi
	 THunRcqPCHzbg/8g7AgZ2T5vQVgfwzMs8n4nw1f4OzLXHb6x9FvtjiDemFuLjmicrh
	 paHVHr0qPL/OA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 19:11:35 +0200
Message-Id: <CZCMJE7GNAE7.1WM551SZTJ54D@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 18/21] KEYS: trusted: Add session encryption
 protection to the seal/unseal path
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-19-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240213171334.30479-19-James.Bottomley@HansenPartnership.com>

On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
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
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> ---
> v2: fix unseal with policy and password
> v3: fix session memory leak
> v7: add review
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


ditto

BR, Jarkko

