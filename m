Return-Path: <linux-integrity+bounces-3947-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237FC9B7F8C
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D211C212DA
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F408513AA5F;
	Thu, 31 Oct 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPrwS70E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA313342F;
	Thu, 31 Oct 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390535; cv=none; b=kJ2tEJvXO7KdVSVnsbDflAp4MWZjWwDS/mr6fmafqN6DWPmtoEScGOBBKNsw4PexlMahxPuz9kDvmRMAksCDcdVhIksG9m2blDU4btXbx1sozslua5ahOXA779oiLi9q7EqO/ILSL6FxaVVPcijItD7HE7ZDnhOV4vVX1G+KOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390535; c=relaxed/simple;
	bh=x/0vgQMAuhbhB0FP+P7NtbACXslqb+QyJs1IMQ/n7X4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MNh1qS7kLxaCHLt0T9xFZ1Q07tci/WGD7AeZmgaBI4gMV3BUDCNG7DfVhTdYFp1jnNZ5GjuvLpG4Q+X149tBC3Y9i2fQlLQt4dP4EUeGxIVooe1RyUg6tzGFIsPYFN3rNuR4OdBG5Pj5tU49M2NtkqE2COrXpk57yMJIE1Bx9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPrwS70E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB5AC582A6;
	Thu, 31 Oct 2024 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730390535;
	bh=x/0vgQMAuhbhB0FP+P7NtbACXslqb+QyJs1IMQ/n7X4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kPrwS70E9f8nKGOMfHek9PylSBn/7f0MjaNThBNIznldG1YC79n2ilbggsJqXH9rh
	 RIfb7b+iNvriNfL5v8w4O/jJd37+58ioMFlR6P+ZeNXFq0LSuROzW3z1JVrk6REg4h
	 Crf8g+OW6THpqZ4sjnf9kxRHf7KVyVYx9qwv64mQCZMIZ9zPDXvy5np6dOoRW/HAXP
	 +7FRqK8ma+clWqEJhVB0JL7nhcxq9l8DW8ede4cHZlWkTC/xnYyhrLEn4GDFxLWWh5
	 p1Hw+3ss98hlqlhJE7qrS16jNXBBGu3wP8Kj80GkltKTdE+6i4WzmsCYK74PfM7DPm
	 OLw82TPqm9ilg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 18:02:10 +0200
Message-Id: <D5A48ZOMBQEG.29H8S6CK6AIVW@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <stable@vger.kernel.org>, "Mike Seo" <mikeseohyungjin@gmail.com>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: set TPM_CHIP_FLAG_SUSPENDED early
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241029223647.35209-1-jarkko@kernel.org>
 <z4ggs22bzp76ire4yecy5cehlurlcll7hrf2bx4mksebtdmcmr@hpjardr6gwib>
 <D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org>
 <iq5qsrnu4v5hvndg5hxmsplyuqqgypgzqqyfa5kzsblkvr6mua@u572yggxguez>
In-Reply-To: <iq5qsrnu4v5hvndg5hxmsplyuqqgypgzqqyfa5kzsblkvr6mua@u572yggxguez>

On Thu Oct 31, 2024 at 5:02 PM EET, Jerry Snitselaar wrote:
> On Thu, Oct 31, 2024 at 01:36:46AM +0200, Jarkko Sakkinen wrote:
> > On Wed Oct 30, 2024 at 10:09 PM EET, Jerry Snitselaar wrote:
> > > On Wed, Oct 30, 2024 at 12:36:47AM +0200, Jarkko Sakkinen wrote:
> > > > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can =
be racy
> > > > according to the bug report, as this leaves window for tpm_hwrng_re=
ad() to
> > > > be called while the operation is in progress. Move setting of the f=
lag
> > > > into the beginning.
> > > >=20
> > > > Cc: stable@vger.kernel.org # v6.4+
> > > > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during res=
ume")
> > > > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > >  drivers/char/tpm/tpm-interface.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tp=
m-interface.c
> > > > index 8134f002b121..3f96bc8b95df 100644
> > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > @@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
> > > >  	if (!chip)
> > > >  		return -ENODEV;
> > > > =20
> > > > +	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > > > +
> > > >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > > >  		goto suspended;
> > > > =20
> > > > @@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
> > > >  	}
> > > > =20
> > > >  suspended:
> > > > -	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > > > -
> > > >  	if (rc)
> > > >  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
> > > >  	return 0;
> > > > --=20
> > > > 2.47.0
> > > >=20
> > >
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >=20
> > Thanks but I actually started to look at the function:
> >=20
> > https://elixir.bootlin.com/linux/v6.11.5/source/drivers/char/tpm/tpm-in=
terface.c#L365
> >=20
> > The absolutely safe-play way considering concurrency would be
> > to do tpm_try_get_ops() before checking any flags. That way
> > tpm_hwrng_read() is guaranteed not conflict.
> >=20
> > So the way I would fix this instead would be to (untested
> > wrote inline here):
> >=20
> > int tpm_pm_suspend(struct device *dev)
> > {
> > 	struct tpm_chip *chip =3D dev_get_drvdata(dev);
> > 	int rc =3D 0;
> >=20
> > 	if (!chip)
> > 		return -ENODEV;
> >=20
> > 	rc =3D tpm_try_get_ops(chip);
> > 	if (rc) {
> > 		chip->flags =3D |=3D TPM_CHIP_FLAG_SUSPENDED;
> > 		return rc;
> > 	}
> >=20
> > 	/* ... */
> >=20
> > suspended:
> > 	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > 	tpm_put_ops(chip);
> >=20
> > It does not really affect performance but guarantees that
> > tpm_hwrng_read() is guaranteed either fully finish or
> > never happens given that both sides take chip->lock.
> >=20
> > So I'll put one more round of this and then this should be
> > stable and fully fixed.
> >=20
> > BR, Jarkko
>
> Ah, yeah better to set it while it has the mutex. That should still be
> 'if (!rc)' after the tpm_try_get_ops() right? (I'm assuming that is just
> a transcription error).

Can you check v2 of the patch? It misses the tpm_hwrng_read() change
that you suggested. I think rc is checked there correctly but it is
always possible that I overlook/ignore something...

So no tags for that since an update is still coming but just the
parts that are already in it make sense.

>
> Regards,
> Jerry

BR, Jarkko


