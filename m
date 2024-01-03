Return-Path: <linux-integrity+bounces-627-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D02282306D
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B231F21772
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCDC1A730;
	Wed,  3 Jan 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsKGt5xA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF471A727;
	Wed,  3 Jan 2024 15:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BA9C433C7;
	Wed,  3 Jan 2024 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295282;
	bh=WPWvXSbWDL0mOust/t7HCZVHoSr6OX/2CEgKCJItMVU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KsKGt5xAn7cequPYb9ViFHu1iVlTkTLYvXgfdqzzzlF0mUNMNU9kNUDrqqhcaongp
	 hBgNcksW2yP51OgdxfWVXuJCNhNzn+jgTtLOLqP7vpSkgXcVRYCaDAhZKiWan991tz
	 WZuDWiqwPHlGJ0ooTWuD09r0aSHzicaiiQ5vebOR1ye1iHJuZhrzwK8OtnujMZdqLk
	 EVm/u8eW/jzWShwfwkwABwUPCM/t5MH/6beYTxrw2GvfC5/8Gg0nmB3JVneOA+v0dj
	 C0AJCejM6GEdUG3W6ZWwrj67X71EKVg//vC1wb3WiY5x2sKEAxe98E/mAwpFXr4XJZ
	 Jt1W55GlaRStQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 17:21:19 +0200
Message-Id: <CY5696OHUNVY.2AB8WQ6CPZ0HN@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 16/20] tpm: add hmac checks to tpm2_pcr_extend()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-17-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240102170408.21969-17-James.Bottomley@HansenPartnership.com>

On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
> tpm2_pcr_extend() is used by trusted keys to extend a PCR to prevent a
> key from being re-loaded until the next reboot.  To use this
> functionality securely, that extend must be protected by a session
> hmac.  This patch adds HMAC protection so tampering with the
> tpm2_pcr_extend() command in flight is detected.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index b0e72fb563d9..a53a843294ed 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -216,13 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx=
,
>  	return rc;
>  }
> =20
> -struct tpm2_null_auth_area {
> -	__be32  handle;
> -	__be16  nonce_size;
> -	u8  attributes;
> -	__be16  auth_size;
> -} __packed;
> -
>  /**
>   * tpm2_pcr_extend() - extend a PCR value
>   *
> @@ -236,24 +229,22 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_=
idx,
>  		    struct tpm_digest *digests)
>  {
>  	struct tpm_buf buf;
> -	struct tpm2_null_auth_area auth_area;
>  	int rc;
>  	int i;
> =20
> -	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +	rc =3D tpm2_start_auth_session(chip);
>  	if (rc)
>  		return rc;
> =20
> -	tpm_buf_append_u32(&buf, pcr_idx);
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> +	if (rc) {
> +		tpm2_end_auth_session(chip);
> +		return rc;
> +	}
> =20
> -	auth_area.handle =3D cpu_to_be32(TPM2_RS_PW);
> -	auth_area.nonce_size =3D 0;
> -	auth_area.attributes =3D 0;
> -	auth_area.auth_size =3D 0;
> +	tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
> =20
> -	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
> -	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
> -		       sizeof(auth_area));
>  	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> =20
>  	for (i =3D 0; i < chip->nr_allocated_banks; i++) {
> @@ -262,7 +253,9 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_id=
x,
>  			       chip->allocated_banks[i].digest_size);
>  	}
> =20
> +	tpm_buf_fill_hmac_session(chip, &buf);
>  	rc =3D tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value")=
;
> +	rc =3D tpm_buf_check_hmac_response(chip, &buf, rc);
> =20
>  	tpm_buf_destroy(&buf);
> =20

This is so obvious that I can give

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

