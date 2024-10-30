Return-Path: <linux-integrity+bounces-3938-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FB9B7092
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 00:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496932825D1
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 23:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99D1E25EF;
	Wed, 30 Oct 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYMblBXG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22551CCB53;
	Wed, 30 Oct 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331411; cv=none; b=izWW03q8IeSfQgkKAHk+K1TVZZY3YTIFNDZiKzEjU7PDifUq6JFYcWXZlKJEyXNXh+1mNaWjBfAiYAg+VEyIMgDaniAn3OfXMxvU4BFRFGxJpoo/Q6EYgD+G//dSj7tjKPt+hBLC7rYLEJAQzigfnysUKn+dKocCclxXbZuSKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331411; c=relaxed/simple;
	bh=unxNl6vAvsReQL1kX4mCDIAfvq/vFGNPbPnhztQp0U8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DypWMfkko5O4kwS0ilWsw6aw7TYlquMqp7a1+4TZ2opdGewDH7D53NUjBtokUlfdqvPSFxDT9i0wPSeiI4qjbXpeE4oIgdIw1HzjE7XL8wD94V3s698nTsy5cbfdBgggD76p+uPgmI9i8lW4AaAo7WvZ/9497Qu1dSUlRJ7GB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYMblBXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9B3C4DE02;
	Wed, 30 Oct 2024 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730331411;
	bh=unxNl6vAvsReQL1kX4mCDIAfvq/vFGNPbPnhztQp0U8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SYMblBXG3Fg0iTjimrACSgPftvaPXObEcSk982F3K6yMiU9g51FLgnHtrZAixyZjA
	 ogvA5lWklolwwztI+axBO58hu9B1xL3jKAsY6chDYSgR8Lc35iAc0UTggvO+Q6qLdj
	 USdhls2K8RO4pt9rMfc3mgIkR3aClxJNlBCRG06cvXU2bAT+0ybIxdGqQaytw0drqY
	 4hcTQZR6Du9ncg1OoPijSrqfOBNiC5Rv0HjEdezIR61K6ZQXi5W2E4/GQOOkFIoXuY
	 uHdN42LPtJ/cRr9jVh3pi/EiPCmD+X6kxyJpgR/9mAL0KHGo4ONGuH96unrzew1lth
	 ks0z+IxI+0wUA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 01:36:46 +0200
Message-Id: <D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org>
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
In-Reply-To: <z4ggs22bzp76ire4yecy5cehlurlcll7hrf2bx4mksebtdmcmr@hpjardr6gwib>

On Wed Oct 30, 2024 at 10:09 PM EET, Jerry Snitselaar wrote:
> On Wed, Oct 30, 2024 at 12:36:47AM +0200, Jarkko Sakkinen wrote:
> > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be r=
acy
> > according to the bug report, as this leaves window for tpm_hwrng_read()=
 to
> > be called while the operation is in progress. Move setting of the flag
> > into the beginning.
> >=20
> > Cc: stable@vger.kernel.org # v6.4+
> > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume"=
)
> > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-in=
terface.c
> > index 8134f002b121..3f96bc8b95df 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
> >  	if (!chip)
> >  		return -ENODEV;
> > =20
> > +	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > +
> >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> >  		goto suspended;
> > =20
> > @@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
> >  	}
> > =20
> >  suspended:
> > -	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
> > -
> >  	if (rc)
> >  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
> >  	return 0;
> > --=20
> > 2.47.0
> >=20
>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks but I actually started to look at the function:

https://elixir.bootlin.com/linux/v6.11.5/source/drivers/char/tpm/tpm-interf=
ace.c#L365

The absolutely safe-play way considering concurrency would be
to do tpm_try_get_ops() before checking any flags. That way
tpm_hwrng_read() is guaranteed not conflict.

So the way I would fix this instead would be to (untested
wrote inline here):

int tpm_pm_suspend(struct device *dev)
{
	struct tpm_chip *chip =3D dev_get_drvdata(dev);
	int rc =3D 0;

	if (!chip)
		return -ENODEV;

	rc =3D tpm_try_get_ops(chip);
	if (rc) {
		chip->flags =3D |=3D TPM_CHIP_FLAG_SUSPENDED;
		return rc;
	}

	/* ... */

suspended:
	chip->flags |=3D TPM_CHIP_FLAG_SUSPENDED;
	tpm_put_ops(chip);

It does not really affect performance but guarantees that
tpm_hwrng_read() is guaranteed either fully finish or
never happens given that both sides take chip->lock.

So I'll put one more round of this and then this should be
stable and fully fixed.

BR, Jarkko

