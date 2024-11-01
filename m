Return-Path: <linux-integrity+bounces-3973-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365259B99D9
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 22:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED87F2830C8
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771271E260F;
	Fri,  1 Nov 2024 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzF/rnTW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995B1D0E15;
	Fri,  1 Nov 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495241; cv=none; b=K75Jn0dEb/V1UAAJQQfZFRDwVjEtV4khpKLpqgZVZre1kfUYCHdmJbo3kwk7+per7WsPUGdtlvpVIObEyTGkmAmNR0m0/nXIAjitmby3UfpJ0SNyvId3pGlqXY8fcy/pUOFYuqLKmCjc6sL8RUaiys5NkSC5M0c7uJj9dGK5aHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495241; c=relaxed/simple;
	bh=nOOQDnRRe7zTQ0O1OJOiYureb6D1VRmlyb9CrYesKFo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gGm01KplCxGshmXm23q+5XKmL+ElJBwyCWSrMZZHhfHw7c3+Sd6p7LWwWS68/QDl7Yj9wbeKzcOLklmg7ERI6LWR6a/mxSxTEAOekHoYuGsosvyibQC9fbd1FfPpNTGK5pOKnl/ANXR8moFiWRXj8+sB58Mg7U3aY7tsgITZjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzF/rnTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641FDC4CECD;
	Fri,  1 Nov 2024 21:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730495240;
	bh=nOOQDnRRe7zTQ0O1OJOiYureb6D1VRmlyb9CrYesKFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzF/rnTWUUL+UTgwBONYo/GpJuczPavqrgbgciMb17O0LrBJjX1E+Zp7D/UMZQWkz
	 aUfmv3kl17r/0QJ0+xeeqruVLhcXgZc3c4U8fm6hUHZcwMoc0k87mD+BWV3ZhEBUTj
	 BiRFoyYpHYtVX7TYV0utP3xA9+mok8xrSBRkBxd6NhZNgc+92DA+wb+3m+e4SxOHEp
	 XjpzImMZsTElWdNuzU7UqOlYbVPc7+SqOhDB+U3zjeow7N3vQzGsevfSx5P56VArSW
	 clwvsKMBeDCpt6cFbjRxNl2Lds87yc1hQdvfIrPBj9o0lTKofQTTDCtP4MgI2OsCfW
	 La+otSVMAcwRw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 23:07:15 +0200
Message-Id: <D5B5D47GLWWS.119EDSKMMGFVF@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jerry Snitselaar" <jsnitsel@redhat.com>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <stable@vger.kernel.org>, "Mike Seo" <mikeseohyungjin@gmail.com>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Lock TPM chip in tpm_pm_suspend() first
X-Mailer: aerc 0.18.2
References: <20241101002157.645874-1-jarkko@kernel.org>
 <ke4tjq5p43g7z3dy4wowagwsf6tzfhecexkdmgkizvqu6n5tvl@op3zhjmplntw>
In-Reply-To: <ke4tjq5p43g7z3dy4wowagwsf6tzfhecexkdmgkizvqu6n5tvl@op3zhjmplntw>

On Fri Nov 1, 2024 at 10:23 PM EET, Jerry Snitselaar wrote:
> On Fri, Nov 01, 2024 at 02:21:56AM +0200, Jarkko Sakkinen wrote:
> > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be r=
acy
> > according, as this leaves window for tpm_hwrng_read() to be called whil=
e
> > the operation is in progress. The recent bug report gives also evidence=
 of
> > this behaviour.
> >=20
> > Aadress this by locking the TPM chip before checking any chip->flags bo=
th
> > in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPENDED
> > check inside tpm_get_random() so that it will be always checked only wh=
en
> > the lock is reserved.
> >=20
> > Cc: stable@vger.kernel.org # v6.4+
> > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume"=
)
> > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v3:
> > - Check TPM_CHIP_FLAG_SUSPENDED inside tpm_get_random() so that it is
> >   also done under the lock (suggested by Jerry Snitselaar).
> > v2:
> > - Addressed my own remark:
> >   https://lore.kernel.org/linux-integrity/D59JAI6RR2CD.G5E5T4ZCZ49W@ker=
nel.org/
> > ---
> >  drivers/char/tpm/tpm-chip.c      |  4 ----
> >  drivers/char/tpm/tpm-interface.c | 32 ++++++++++++++++++++++----------
> >  2 files changed, 22 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 1ff99a7091bb..7df7abaf3e52 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -525,10 +525,6 @@ static int tpm_hwrng_read(struct hwrng *rng, void =
*data, size_t max, bool wait)
> >  {
> >  	struct tpm_chip *chip =3D container_of(rng, struct tpm_chip, hwrng);
> > =20
> > -	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
> > -	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
> > -		return 0;
> > -
> >  	return tpm_get_random(chip, data, max);
> >  }
> > =20
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-in=
terface.c
> > index 8134f002b121..b1daa0d7b341 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -370,6 +370,13 @@ int tpm_pm_suspend(struct device *dev)
> >  	if (!chip)
> >  		return -ENODEV;
> > =20
> > +	rc =3D tpm_try_get_ops(chip);
> > +	if (rc) {
> > +		/* Can be safely set out of locks, as no action cannot race: */
> > +		chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > +		goto out;
> > +	}
> > +
> >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> >  		goto suspended;
> > =20
> > @@ -377,21 +384,19 @@ int tpm_pm_suspend(struct device *dev)
> >  	    !pm_suspend_via_firmware())
> >  		goto suspended;
> > =20
> > -	rc =3D tpm_try_get_ops(chip);
> > -	if (!rc) {
> > -		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > -			tpm2_end_auth_session(chip);
> > -			tpm2_shutdown(chip, TPM2_SU_STATE);
> > -		} else {
> > -			rc =3D tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > -		}
> > -
> > -		tpm_put_ops(chip);
> > +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +		tpm2_end_auth_session(chip);
> > +		tpm2_shutdown(chip, TPM2_SU_STATE);
> > +		goto suspended;
> >  	}
> > =20
> > +	rc =3D tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > +
>
>
> I imagine the above still be wrapped in an else with the if (chip->flags =
& TPM_CHIP_FLAG_TPM2)
> otherwise it will call tpm1_pm_suspend for both tpm1 and tpm2 devices, ye=
s?
>
> So:
>
> 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> 		tpm2_end_auth_session(chip);
> 		tpm2_shutdown(chip, TPM2_SU_STATE);
> 		goto suspended;
> 	} else {
> 		rc =3D tpm1_pm_suspend(chip, tpm_suspend_pcr);
> 	}
>
>
> Other than that I think it looks good.

It should be fine because after tpm2_shutdown() is called there is "goto
suspended;". This is IMHO more readable as it matches the structure of
previous exits before it. In future if this needs to be improved it will
easier to move the logic to a helper function (e.g. __tpm_pm_suspend())
where gotos are substituted with return-statements.

BR, Jarkko

