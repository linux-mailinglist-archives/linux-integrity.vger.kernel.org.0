Return-Path: <linux-integrity+bounces-3483-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D2996F027
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 11:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38721C220B4
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D2156864;
	Fri,  6 Sep 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncbVky0z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157D13E898;
	Fri,  6 Sep 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616205; cv=none; b=IvJYerbCFW92A+V3hpDkP5TZvnbxlq8ImM66eq/UMTmrlRUqZT7IDIoUagYZpynHoXHEYLtemsIqeGjUHXmH/sfHM1xPANBjwmI5zsE3zbgXV90JUPHFbdo9ey/JpkAH7ihn8ypUK6xhWA02xDILcP9evvllmkQ//3r0+tpYs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616205; c=relaxed/simple;
	bh=lXvHBp54YUxLKQSB2EKHD1u86JDmiTdSh3t1tjcLZ8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Bh+hef9trZQHWyszsXa5Xqs+ApcsnpwzbY0qRB1dz9MUdEqBis3sggweO5xrd/u5VQjomQ44B4XqieaM658OrySPC0swwPkJdr89o5pbdRs12wwsp5NujSlfR109xIZinbWGuBjX8U6b8g0eLtp2UTlGTcE4mqMGc9gmVYjdL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncbVky0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA11C4CEC4;
	Fri,  6 Sep 2024 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725616204;
	bh=lXvHBp54YUxLKQSB2EKHD1u86JDmiTdSh3t1tjcLZ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncbVky0zz2r8jA0jqs3WdgVVZB1AG7ukJIj3iqppnrXNKgmPUi9D0naBCz+EtdKdP
	 92Nq64FVjKGF0aO6O2LlBpiQDtAo08jo7zPl44YbGO4L4bd//kqxzWWK/Ka+EdV88j
	 TAcNXpYbCyR4YJfm+Uh8r/KGat5+Cb32XpGA13Clc9uYJveKCk5JqWEaX7vxHlovDS
	 uO57oMj/LjqhZf9VPVHqSK8DzRCQvXwypQXAOxvO0XdLh4TFjF+sTubVc0hrSNpS1B
	 +9QgccFZXn6RbdXHzSOqS3H/tLJvzePJz8n6GMYMm66Ee2CcGHPt5vxFP+x7S8RyR7
	 GHAPRQjSoGnoQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Sep 2024 12:50:00 +0300
Message-Id: <D3Z3W2PZDU7C.4CBZUBZYY0RS@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Wahren" <wahrenst@gmx.net>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] tpm: tpm_tis: Provide error messages in
 tpm_tis_core_init
X-Mailer: aerc 0.18.2
References: <20240906060947.4844-1-wahrenst@gmx.net>
 <20240906060947.4844-3-wahrenst@gmx.net>
In-Reply-To: <20240906060947.4844-3-wahrenst@gmx.net>

On Fri Sep 6, 2024 at 9:09 AM EEST, Stefan Wahren wrote:
> In case of SPI wiring issues (e.g. MISO pin permanent high) the
> core init won't provide any error message on failure. Add some
> helpful error messages to tpm_tis_core_init(), which helps
> to better understand why the driver won't probe.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index fdef214b9f6b..830e331fcebe 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1133,8 +1133,10 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
>  	dev_set_drvdata(&chip->dev, priv);
>
>  	rc =3D tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read TPM_DID_VID register: %d\n", rc);
>  		return rc;
> +	}
>
>  	priv->manufacturer_id =3D vendor;
>
> @@ -1162,19 +1164,25 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>  		chip->ops->clk_enable(chip, true);
>
>  	if (wait_startup(chip, 0) !=3D 0) {
> +		dev_err(dev, "TPM device not accessible (0x%0x)\n",
> +			vendor);
>  		rc =3D -ENODEV;
>  		goto out_err;
>  	}
>
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read TPM_INT_ENABLE register: %d\n", rc);
>  		goto out_err;
> +	}
>
>  	/* Figure out the capabilities */
>  	rc =3D tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read TPM_INTF_CAPS register: %d\n", rc);
>  		goto out_err;
> +	}
>
>  	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
>  		intfcaps);
> @@ -1209,6 +1217,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>
>  	rc =3D tpm_tis_request_locality(chip, 0);
>  	if (rc < 0) {
> +		dev_err(dev, "Failed to request locality (0x%0x)\n", vendor);
>  		rc =3D -ENODEV;
>  		goto out_err;
>  	}
> --
> 2.34.1

No thanks. It not only adds helpful messages but has potential to add
unwanted merge conflicts.

BR, Jarkko

