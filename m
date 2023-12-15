Return-Path: <linux-integrity+bounces-486-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291CC8140B0
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Dec 2023 04:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59E6B1C208D8
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Dec 2023 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEB253A0;
	Fri, 15 Dec 2023 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJzRGe5z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F47D5382;
	Fri, 15 Dec 2023 03:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1666C433C7;
	Fri, 15 Dec 2023 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702611265;
	bh=pvggstVAuJtl46xlyPK3eOtyOXNJEfxiASZ0RXguL10=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tJzRGe5zueo5jDKnmjISkiPDNN/tg8VMHNjcdG/4O/wpnq40Q0V6CW44+p11719L6
	 9tIe1EzkH82uODQBeyLKoziTOOhLi93BCOli1N92QSP2koqjpRTFY3oYV/zfdDwp54
	 9nB2Tk+9wmh9Wg4oxUr8ZfteCAFdTUovczIAdk5wPvOyuRPG0NUGrF0YHI29r4615H
	 Y+k4CPyXEcgggJnvR0tUkqwmt+Z7CYN5wzpCVdM5JePrgLJUxsX6K/GMDgVx0EEfLo
	 Ck5rwyuYfxoe94tbG2f9F1jWlzTCWhZfI33uAPZrNmuWdjJ3JvdZ9GaY918kLcvJ48
	 bJkFK7qNhnjDA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Dec 2023 05:34:22 +0200
Message-Id: <CXOLBK5KCP3U.2UEBNXDHCOAJF@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v5 16/17] tpm: add the null key name as a sysfs export
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
 <20231127190854.13310-17-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20231127190854.13310-17-James.Bottomley@HansenPartnership.com>

On Mon Nov 27, 2023 at 9:08 PM EET, James Bottomley wrote:
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
>  drivers/char/tpm/tpm-sysfs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 54c71473aa29..403dffea4ea6 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,6 +309,21 @@ static ssize_t tpm_version_major_show(struct device =
*dev,
>  }
>  static DEVICE_ATTR_RO(tpm_version_major);
> =20
> +#ifdef CONFIG_TPM_BUS_SECURITY

After considering options TCG_TPM2_HMAC would be both dead obvious, i.e.
you cannot get it wrong and along the lines of existing config flags.

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
> +#ifdef CONFIG_TPM_BUS_SECURITY
> +	&dev_attr_null_name.attr,
> +#endif
>  	NULL
>  };
> =20

Otherwise, LGTM

BR, Jarkko

