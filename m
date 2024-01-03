Return-Path: <linux-integrity+bounces-630-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C3823072
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E5F1F240B9
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70F1A72A;
	Wed,  3 Jan 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlaAVTyW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C191A720;
	Wed,  3 Jan 2024 15:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C2C433C8;
	Wed,  3 Jan 2024 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295347;
	bh=f8+oiTScj9ymtZzBWfOuQRoWTeGjhPdwOVmFnDTXFEI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qlaAVTyWXON2/zxgldmLEET6Nb47DgjbGtAAcU7AC7Y9PeK9ZfLaAS1u2LAd9psv6
	 IOd+brn24shskpDNTQ1gulocS7WvcfxJr8Ox51Zb9b2OQbpow1JTzlhL0GZz1zj4Bk
	 vtVLqpDtMyXckPIg4vQp8g0IMXgiTfiyzxeYeUl2I9p2HiSqPoVVQy3Tpi5gcZwLXl
	 1xkt30sI2Z6oPRN2uwM5t1FHBHdd8Gs8bOyOw9jW2J+yD3h83JwnTp/AqOXQhJ8Ffg
	 hkz41E8l7UUUT3h7fUmDLxulC8FGtT9TNX5jyrzIhDs41HjPoFsGrl14h95zNDyrGv
	 HYNQmDOVhJTPQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 17:22:24 +0200
Message-Id: <CY56A0P5ZK56.3XEVRY5GXP85@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 19/20] tpm: add the null key name as a sysfs export
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-20-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240102170408.21969-20-James.Bottomley@HansenPartnership.com>

On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
> This is the last component of encrypted tpm2 session handling that
> allows us to verify from userspace that the key derived from the NULL
> seed genuinely belongs to the TPM and has not been spoofed.
>
> The procedure for doing this involves creating an attestation identity
> key (which requires verification of the TPM EK certificate) and then
> using that AIK to sign a certification of the Elliptic Curve key over
> the NULL seed.  Userspace must create this EC Key using the parameters
> prescribed in TCG TPM v2.0 Provisioning Guidance for the SRK ECC; if
> this is done correctly the names will match and the TPM can then run a
> TPM2_Certify operation on this derived primary key using the newly
> created AIK.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
> v6: change config name
> ---
>  drivers/char/tpm/tpm-sysfs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 54c71473aa29..874c2c5fe79f 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,6 +309,21 @@ static ssize_t tpm_version_major_show(struct device =
*dev,
>  }
>  static DEVICE_ATTR_RO(tpm_version_major);
> =20
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +static ssize_t null_name_show(struct device *dev, struct device_attribut=
e *attr,
> +			      char *buf)
> +{
> +	struct tpm_chip *chip =3D to_tpm_chip(dev);
> +	int size =3D TPM2_NAME_SIZE;
> +
> +	bin2hex(buf, chip->tpmkeyname, size);
> +	size *=3D 2;
> +	buf[size++] =3D '\n';
> +	return size;
> +}
> +static DEVICE_ATTR_RO(null_name);
> +#endif
> +
>  static struct attribute *tpm1_dev_attrs[] =3D {
>  	&dev_attr_pubek.attr,
>  	&dev_attr_pcrs.attr,
> @@ -326,6 +341,9 @@ static struct attribute *tpm1_dev_attrs[] =3D {
> =20
>  static struct attribute *tpm2_dev_attrs[] =3D {
>  	&dev_attr_tpm_version_major.attr,
> +#ifdef CONFIG_TCG_TPM2_HMAC
> +	&dev_attr_null_name.attr,
> +#endif
>  	NULL
>  };
> =20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

