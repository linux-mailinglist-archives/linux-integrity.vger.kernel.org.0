Return-Path: <linux-integrity+bounces-3977-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815F9B9A28
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 22:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D271C21438
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 21:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D31E32A4;
	Fri,  1 Nov 2024 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9+AHDrb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA01E282A;
	Fri,  1 Nov 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496302; cv=none; b=ErFPbORJnUEbIb/Z3caTLYzpwk44IlDdu61YSMx09C2vYoB6RXgk/901E4Aqj5Ix8C4KuyR+hAAoSGp+XrlTtEzt7rKtnuLHgQ3pKfcIfv0ScNbBVQ2Z07LydZnkpUP4VHgDywUG7DtKM3Zbfwiby5IZ1N/7AMA10ePzjwxch/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496302; c=relaxed/simple;
	bh=Qe4XvEAZM9xKaxt/DCYUEtueSQuxX7qKGNYJMTtf8nA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iVoEMxkcKTCKCj2n4iC2YmCMCSt9p7F31IRLkpiwXsUKnpAMb2pMRmIX2rz3iWVeYbHPcxfZFtkoZjHUbiPO4vMQM/BPDqNuJsSIpCNjIilHOd0e9+J3nZnD2Ezl1wk7NSt8mjke9AiDLqOOfk0Z76/7rdYjDA1FZb9uhYeWed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9+AHDrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF173C4CECD;
	Fri,  1 Nov 2024 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730496302;
	bh=Qe4XvEAZM9xKaxt/DCYUEtueSQuxX7qKGNYJMTtf8nA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=A9+AHDrb7iEc06JOVyhKzUj3EhlyVYGIczbHYRs20n6DAC2LLbzD+qH+ADIa+OKIx
	 1Sz6o023/Cg4+L9/IHKf98EkKhyA63vqlHbffpdA9xEQ3HMbxybTi3E+IG22+w/JM4
	 2k1zUZO31oYc5XJqwkicZwsyBBWQXE7ImyjCvEcu6pfzwupQ6erFBVXhKlT9fmqkUT
	 odjQJcF4KyRkdeOyvPvOSLyDjVSHMALfnia8ncVjpnNYg/og4d8elfFNoIj/jux5iM
	 SW+D5P9sLrzk28SzvIkGZp75vqzEQlvRUhmztGhyH95yFNVC+ZcpUxl18XfnerPd/S
	 /5W+faBwPQQQQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 23:24:58 +0200
Message-Id: <D5B5QOI1GA38.26CWPZMPXP6S9@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <stable@vger.kernel.org>, "Mike Seo" <mikeseohyungjin@gmail.com>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Lock TPM chip in tpm_pm_suspend() first
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241101002157.645874-1-jarkko@kernel.org>
 <ke4tjq5p43g7z3dy4wowagwsf6tzfhecexkdmgkizvqu6n5tvl@op3zhjmplntw>
 <D5B5D47GLWWS.119EDSKMMGFVF@kernel.org>
 <7pc2uu52wamyvhzfc27qnws546yxt33utfibtsjd7uv2djfxdt@jlyn3n55qkfx>
In-Reply-To: <7pc2uu52wamyvhzfc27qnws546yxt33utfibtsjd7uv2djfxdt@jlyn3n55qkfx>

On Fri Nov 1, 2024 at 11:09 PM EET, Jerry Snitselaar wrote:
> On Fri, Nov 01, 2024 at 11:07:15PM +0200, Jarkko Sakkinen wrote:
> > On Fri Nov 1, 2024 at 10:23 PM EET, Jerry Snitselaar wrote:
> > > On Fri, Nov 01, 2024 at 02:21:56AM +0200, Jarkko Sakkinen wrote:
> > > > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can =
be racy
> > > > according, as this leaves window for tpm_hwrng_read() to be called =
while
> > > > the operation is in progress. The recent bug report gives also evid=
ence of
> > > > this behaviour.
> > > >=20
> > > > Aadress this by locking the TPM chip before checking any chip->flag=
s both
> > > > in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPEN=
DED
> > > > check inside tpm_get_random() so that it will be always checked onl=
y when
> > > > the lock is reserved.
> > > >=20
> > > > Cc: stable@vger.kernel.org # v6.4+
> > > > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during res=
ume")
> > > > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > > v3:
> > > > - Check TPM_CHIP_FLAG_SUSPENDED inside tpm_get_random() so that it =
is
> > > >   also done under the lock (suggested by Jerry Snitselaar).
> > > > v2:
> > > > - Addressed my own remark:
> > > >   https://lore.kernel.org/linux-integrity/D59JAI6RR2CD.G5E5T4ZCZ49W=
@kernel.org/
> > > > ---
> > > >  drivers/char/tpm/tpm-chip.c      |  4 ----
> > > >  drivers/char/tpm/tpm-interface.c | 32 ++++++++++++++++++++++------=
----
> > > >  2 files changed, 22 insertions(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chi=
p.c
> > > > index 1ff99a7091bb..7df7abaf3e52 100644
> > > > --- a/drivers/char/tpm/tpm-chip.c
> > > > +++ b/drivers/char/tpm/tpm-chip.c
> > > > @@ -525,10 +525,6 @@ static int tpm_hwrng_read(struct hwrng *rng, v=
oid *data, size_t max, bool wait)
> > > >  {
> > > >  	struct tpm_chip *chip =3D container_of(rng, struct tpm_chip, hwrn=
g);
> > > > =20
> > > > -	/* Give back zero bytes, as TPM chip has not yet fully resumed: *=
/
> > > > -	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
> > > > -		return 0;
> > > > -
> > > >  	return tpm_get_random(chip, data, max);
> > > >  }
> > > > =20
> > > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tp=
m-interface.c
> > > > index 8134f002b121..b1daa0d7b341 100644
> > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > @@ -370,6 +370,13 @@ int tpm_pm_suspend(struct device *dev)
> > > >  	if (!chip)
> > > >  		return -ENODEV;
> > > > =20
> > > > +	rc =3D tpm_try_get_ops(chip);
> > > > +	if (rc) {
> > > > +		/* Can be safely set out of locks, as no action cannot race: */
> > > > +		chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > > > +		goto out;
> > > > +	}
> > > > +
> > > >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > > >  		goto suspended;
> > > > =20
> > > > @@ -377,21 +384,19 @@ int tpm_pm_suspend(struct device *dev)
> > > >  	    !pm_suspend_via_firmware())
> > > >  		goto suspended;
> > > > =20
> > > > -	rc =3D tpm_try_get_ops(chip);
> > > > -	if (!rc) {
> > > > -		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > > > -			tpm2_end_auth_session(chip);
> > > > -			tpm2_shutdown(chip, TPM2_SU_STATE);
> > > > -		} else {
> > > > -			rc =3D tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > > > -		}
> > > > -
> > > > -		tpm_put_ops(chip);
> > > > +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > > > +		tpm2_end_auth_session(chip);
> > > > +		tpm2_shutdown(chip, TPM2_SU_STATE);
> > > > +		goto suspended;
> > > >  	}
> > > > =20
> > > > +	rc =3D tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > > > +
> > >
> > >
> > > I imagine the above still be wrapped in an else with the if (chip->fl=
ags & TPM_CHIP_FLAG_TPM2)
> > > otherwise it will call tpm1_pm_suspend for both tpm1 and tpm2 devices=
, yes?
> > >
> > > So:
> > >
> > > 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > > 		tpm2_end_auth_session(chip);
> > > 		tpm2_shutdown(chip, TPM2_SU_STATE);
> > > 		goto suspended;
> > > 	} else {
> > > 		rc =3D tpm1_pm_suspend(chip, tpm_suspend_pcr);
> > > 	}
> > >
> > >
> > > Other than that I think it looks good.
> >=20
> > It should be fine because after tpm2_shutdown() is called there is "got=
o
> > suspended;". This is IMHO more readable as it matches the structure of
> > previous exits before it. In future if this needs to be improved it wil=
l
> > easier to move the logic to a helper function (e.g. __tpm_pm_suspend())
> > where gotos are substituted with return-statements.
> >=20
> > BR, Jarkko
> >=20
>
> Heh, yep.
>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks!

BR, Jarkko

