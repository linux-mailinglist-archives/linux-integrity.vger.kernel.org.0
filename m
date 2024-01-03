Return-Path: <linux-integrity+bounces-622-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786382302A
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16802286592
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FDC1A717;
	Wed,  3 Jan 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b12rgbcJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472881A70D;
	Wed,  3 Jan 2024 15:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F833C433C7;
	Wed,  3 Jan 2024 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704294088;
	bh=JUVQPNueie8/ffvGR1774iUJL+eH/Xi0L+Rh6ephnbA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=b12rgbcJ+1VRTinSBgGUagFa5bb2XMGdoWGZTbot5v7wfhfQMN4hl7OzGWEQTX3iY
	 l2mDDNA3zaLmoWfOKeJAEcACNAGfp+yZkmC5amTsTgmOtOVhX0gtxmoYhNsd5MU3y5
	 aEkkpL9/C5kme9onqLEazBpiC8Z3Ls9AJCzgKq7b9pb3XKGaVVgeqZuZfZcTyl4ceM
	 AZfped+X60PAAvGn36kemfb1EHpDIrY18c25HECPpR+d21EwGaYH3p2ZIjJq8WV8nh
	 Krhmmrt5xGazhno6cRHPFnEoxRhYiZKya0+ReqMq18tDYIPmxCHEtIpCbwWoKQztpg
	 2PqRZuzeL5yEQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 17:01:25 +0200
Message-Id: <CY55TY4IRQVN.2ZV2U35WPTRL3@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 11/20] tpm: export the context save and load commands
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-12-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240102170408.21969-12-James.Bottomley@HansenPartnership.com>

On Tue Jan 2, 2024 at 7:03 PM EET, James Bottomley wrote:
> The TPM2 session HMAC and encryption handling code needs to save and
> restore a single volatile context for the elliptic curve version of
> the NULL seed, so export the APIs which do this for internal use.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
> ---
>
> v5: add review
> ---
>  drivers/char/tpm/tpm.h        | 4 ++++
>  drivers/char/tpm/tpm2-space.c | 8 ++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 61445f1dc46d..cbc9d1e2974d 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -312,6 +312,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct =
tpm_space *space, void *buf,
>  		      size_t *bufsiz);
>  int tpm_devs_add(struct tpm_chip *chip);
>  void tpm_devs_remove(struct tpm_chip *chip);
> +int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> +		      unsigned int buf_size, unsigned int *offset);
> +int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> +		      unsigned int *offset, u32 *handle);
> =20
>  void tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.=
c
> index 363afdd4d1d3..24479a81c23c 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -68,8 +68,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_s=
pace *space)
>  	kfree(space->session_buf);
>  }
> =20
> -static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> -			     unsigned int *offset, u32 *handle)
> +int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> +		      unsigned int *offset, u32 *handle)
>  {
>  	struct tpm_buf tbuf;
>  	struct tpm2_context *ctx;
> @@ -119,8 +119,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u=
8 *buf,
>  	return 0;
>  }
> =20
> -static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> -			     unsigned int buf_size, unsigned int *offset)
> +int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> +		      unsigned int buf_size, unsigned int *offset)
>  {
>  	struct tpm_buf tbuf;
>  	unsigned int body_size;

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

