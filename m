Return-Path: <linux-integrity+bounces-378-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A028092BE
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Dec 2023 21:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F91F20FAF
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Dec 2023 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245BF481BC;
	Thu,  7 Dec 2023 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkbbgWZj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439710947;
	Thu,  7 Dec 2023 20:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A465CC433C8;
	Thu,  7 Dec 2023 20:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982141;
	bh=EuVP1XLpy4xj3vh40AqpvZ7wht1836EEQh/ytHofEsw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KkbbgWZjee/KlLSnirPtAF41DgYBmBZbyVwtMclEll7Z2tWp1R9lhvbSalyzbKNBP
	 594RR/S/SUZjvlTao5AYJzuLyfNwVGpGro2PxmI7bDYdT6okV0s7GD7O5urbEUMeeo
	 Xt88xx+Tjw6aUGRlSk7YHdil2a8VCCizeHrG5eBP1MceibW1TAR0tZ2hIkWKPNA/w/
	 w0EPgCjwSrybqPnWRvItUb/kIMgLAv0BrBqMR0PiS4uR5i9/F0EIvKD3ORTzetTPWV
	 xiAhH4o9FhNelN3u3NhA0aAysS96k+0JkQ++/Zp/b8HonpHLnhx9MPDW/AxSjbdKTY
	 quoZMYk/l3CSQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Dec 2023 22:48:58 +0200
Message-Id: <CXIEBCF9573Q.239OKGM1LTIS6@suppilovahvero>
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
> +static ssize_t null_name_show(struct device *dev, struct device_attribut=
e *attr,
> +			      char *buf)
> +{
> +	struct tpm_chip *chip =3D to_tpm_chip(dev);
> +	int size =3D TPM2_NAME_SIZE;
> +
> +	bin2hex(buf, chip->tpmkeyname, size);

"tpmkeyname" is not very descriptive name.

Why not chip->null_name?

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

I'm able to verify this in QEMU:

# cat /sys/class/tpm/tpm0/null_name
000b66ec5f9ad1fa46c01707c5a8e67745147695901310e80438ff8f1b66dcf84bf2

I used swtpm in tis mode.

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

It is not possible to give tested-by to earlier patches before there's
some split to smaller pieces.

BR, Jarkko

