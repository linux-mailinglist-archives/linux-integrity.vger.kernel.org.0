Return-Path: <linux-integrity+bounces-3946-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672BB9B7F7B
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C821C23D42
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C04513AA5F;
	Thu, 31 Oct 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6bUhdE0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95533F7;
	Thu, 31 Oct 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390388; cv=none; b=K4NFSG3kd98VSEq0pdVeFaOl/+ZTbl45weAXmnUucQc7oONteG3nZ0p7dcZ70kjPxuB3t7ZL0qPfqyvhFxXFKTHZK7/f14FpCAzxytnfltJ2XpHX0lQfLaLgAk+ikq2r4QgyOGEi4FYvPmGNtcg4FZ9ayoXPIpB9X8clClj1MR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390388; c=relaxed/simple;
	bh=tOO12zl0RJpVtTYagj3aN+QvKwGTYQJmTPx4jLOOHxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=g8CUDTPl7Ozk0NWli0V29/Fuh5ZYfH6H+RTCWpFmi77AhBQDvtUj0YObbY2BOjLkXkOaPFxNtrnoeYADYnRaZXJktg1+7ewfaY59fiYMST5smVQB6yk2EUkZUOR9wJa8rLroJbqebJnYkiWMAto+DORCjcXcPZRhLiL+hn1qZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6bUhdE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39986C567F2;
	Thu, 31 Oct 2024 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730390387;
	bh=tOO12zl0RJpVtTYagj3aN+QvKwGTYQJmTPx4jLOOHxg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=M6bUhdE0HCz29KhcwN7FyCrOPaDlO/hgxjbmkwyvWlhgaWIN/bmV+Ir6h8hh4MqI6
	 GL368qwJzmvfyikfoK1AMuiMNdDMn/pmhMF5/x+PkWNBe82zmjmNSEnOFjJefPiSbk
	 46Ys9Gu6yBHCatM6+6bh6znWM/eSlC1Qx8Ltb3bnADGZ/EvW3KgeGH1jbbKHJe8ex8
	 F93AxORwrGVwX5FX6/aPTutebG5NK+y9uT3IxRj+Cgez65GffgUQUnd8XuYdGUYom6
	 QwbN8Y0UbVR3ro71EEwxAtIySLL3HxQBcizXUW12tN7ZjCJpKzMXw8QdYZ3vNSMr/Z
	 0+kvuL56NeZkw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 17:59:43 +0200
Message-Id: <D5A473YHVE8A.W40YN3RC5BYN@kernel.org>
Subject: Re: [PATCH] tpm: set TPM_CHIP_FLAG_SUSPENDED early
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jerry Snitselaar" <jsnitsel@redhat.com>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <stable@vger.kernel.org>, "Mike Seo" <mikeseohyungjin@gmail.com>, "open
 list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241029223647.35209-1-jarkko@kernel.org>
 <z4ggs22bzp76ire4yecy5cehlurlcll7hrf2bx4mksebtdmcmr@hpjardr6gwib>
 <D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org>
 <iq5qsrnu4v5hvndg5hxmsplyuqqgypgzqqyfa5kzsblkvr6mua@u572yggxguez>
 <cspzjpjurwlpgd7n45mt224saf5p3dq3nrhkmhbyhmnq7iky4q@ahc66xqfnnab>
In-Reply-To: <cspzjpjurwlpgd7n45mt224saf5p3dq3nrhkmhbyhmnq7iky4q@ahc66xqfnnab>

On Thu Oct 31, 2024 at 5:28 PM EET, Jerry Snitselaar wrote:
> On Thu, Oct 31, 2024 at 08:02:37AM -0700, Jerry Snitselaar wrote:
> > On Thu, Oct 31, 2024 at 01:36:46AM +0200, Jarkko Sakkinen wrote:
> > > On Wed Oct 30, 2024 at 10:09 PM EET, Jerry Snitselaar wrote:
> > > > On Wed, Oct 30, 2024 at 12:36:47AM +0200, Jarkko Sakkinen wrote:
> > > > > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() ca=
n be racy
> > > > > according to the bug report, as this leaves window for tpm_hwrng_=
read() to
> > > > > be called while the operation is in progress. Move setting of the=
 flag
> > > > > into the beginning.
> > > > >=20
> > > > > Cc: stable@vger.kernel.org # v6.4+
> > > > > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during r=
esume")
> > > > > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > ---
> > > > >  drivers/char/tpm/tpm-interface.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/=
tpm-interface.c
> > > > > index 8134f002b121..3f96bc8b95df 100644
> > > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > > @@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
> > > > >  	if (!chip)
> > > > >  		return -ENODEV;
> > > > > =20
> > > > > +	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > > > > +
> > > > >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > > > >  		goto suspended;
> > > > > =20
> > > > > @@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
> > > > >  	}
> > > > > =20
> > > > >  suspended:
> > > > > -	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > > > > -
> > > > >  	if (rc)
> > > > >  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
> > > > >  	return 0;
> > > > > --=20
> > > > > 2.47.0
> > > > >=20
> > > >
> > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > >=20
> > > Thanks but I actually started to look at the function:
> > >=20
> > > https://elixir.bootlin.com/linux/v6.11.5/source/drivers/char/tpm/tpm-=
interface.c#L365
> > >=20
> > > The absolutely safe-play way considering concurrency would be
> > > to do tpm_try_get_ops() before checking any flags. That way
> > > tpm_hwrng_read() is guaranteed not conflict.
> > >=20
> > > So the way I would fix this instead would be to (untested
> > > wrote inline here):
> > >=20
> > > int tpm_pm_suspend(struct device *dev)
> > > {
> > > 	struct tpm_chip *chip =3D dev_get_drvdata(dev);
> > > 	int rc =3D 0;
> > >=20
> > > 	if (!chip)
> > > 		return -ENODEV;
> > >=20
> > > 	rc =3D tpm_try_get_ops(chip);
> > > 	if (rc) {
> > > 		chip->flags =3D |=3D TPM_CHIP_FLAG_SUSPENDED;
> > > 		return rc;
> > > 	}
> > >=20
> > > 	/* ... */
> > >=20
> > > suspended:
> > > 	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > > 	tpm_put_ops(chip);
> > >=20
> > > It does not really affect performance but guarantees that
> > > tpm_hwrng_read() is guaranteed either fully finish or
> > > never happens given that both sides take chip->lock.
> > >=20
> > > So I'll put one more round of this and then this should be
> > > stable and fully fixed.
> > >=20
> > > BR, Jarkko
> >=20
> > Ah, yeah better to set it while it has the mutex. That should still be
> > 'if (!rc)' after the tpm_try_get_ops() right? (I'm assuming that is jus=
t
> > a transcription error).
> >=20
> > Regards,
> > Jerry
> >=20
>
> It has been a while since I've looked at TPM code. Since
> tpm_hwrng_read doesn't check the flag with the mutex held is there a
> point later where it will bail out if the suspend has occurred? I'm
> wondering if the check for the suspend flag in tpm_hwrng_read should
> be after the tpm_find_get_ops in tpm_get_random.

Right, I ignored that side in v2. Yeah, I agree that in both cases
it would be best that all checks are done when the lock is taken.

It means open-coding tpm2_get_random() but I think it is anyway
good idea (as tpm_get_random() is meant for outside callers).

> Regards,
> Jerry

BR, Jarkko

