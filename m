Return-Path: <linux-integrity+bounces-8245-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52249D2305C
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 09:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EBC83001FDB
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 08:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CC131355D;
	Thu, 15 Jan 2026 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWTZ5V3c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06D32B9BB
	for <linux-integrity@vger.kernel.org>; Thu, 15 Jan 2026 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464409; cv=none; b=H8pEIohUNXUgN+cV8q7RMD8HIPSIwL2RO+z7tB1bJKR9EHSEHJbcI4eQ55a5d0561iQWD91b3Hr4dt+x/43KqIqlA09mMUeArOvT8o+Bk8QbKfj01iODz2bRJsrEkNQBocFgTj3/ocEpCcZMFQGu5zT+xEPoTs7Tu2UJ8w8gWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464409; c=relaxed/simple;
	bh=SNm9tw10kSlkSYE8Dzjb7oI08w0c1l6b91zhzyCDjkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rX9IRyFZIyg8+tSFN5qGRdnll/LY61HQCs8gKLBU1E9QVjftm4IFwOG9KAcY3N1uQhZLbNYsPj+FvgrAQmiKJTr7PyC845KaRQ09vuMX5c3k4gYokzgAEC0m1+iQh5limSpWf7Qtfi5i0iv1MY14/4DyWetiD/Sd3WwexVrZlBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWTZ5V3c; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3f13043e2fdso229341fac.1
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jan 2026 00:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768464407; x=1769069207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9YVPvZw/xovO9u+b4eqssLt4dwUALwn+L4LhHPu9Ew=;
        b=PWTZ5V3cP2YYH3v9Ay7AOKfoY9bRrDV7ZYpgMdMLzqrlgYzhsLX6y8zlmcVPmGjPp2
         1qoGlz1MoVMJW7lOS50wErSJeblZCtsGeSiq1FHAlveVPtTbCBVF5DRBB+c1KvVj5ioZ
         q+yWCKpcFU744E/86rbRZQCT1jm0/+We+YdrEqvZeieUACIAd4Smm3R8TysKzHurs1zd
         FjyVoanJbu7ZakwgVirM+gATaptAq9exf+y6Vz8T43bUDvpoPb/sFVmBj5dHGRRoBSyD
         qZ5gDYedF/u2tRBvMiddzpK44U9iJ3BueUCf9/q1ntqEcevrxd7YwWlTNFx8KiFij5AD
         vAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768464407; x=1769069207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i9YVPvZw/xovO9u+b4eqssLt4dwUALwn+L4LhHPu9Ew=;
        b=JdT7aiSm42xXg4Z8GkgLXuBXJy9DDOcTdizM6ntPAkcY08X48Ur0HhWylr5nyJPIW/
         9rBf2f0y371iUqOdPVn7ZgjEnaLK1tEg47JkbH/f2zgMIiiFXNhQvpoteJNlmi4tdR5z
         wwze7WFo4kkreosq5XvBQ+VCMGyylVcj88QLcp+LR6OSCz9KzMu7sB3IW9nejCX0edP2
         ArLgRnl85ftGLoRy+UBArpFMy1Ythr8JlRzLg/+7+wpAgEESENmEaeRtvF4XCFxMaGU0
         wevd9jF+9c/596AwYZO1zzV2B1+TPIUiWG5Lonk7bwCEpZ9Ws3/friwHncH+sJ5BCa+A
         exzw==
X-Forwarded-Encrypted: i=1; AJvYcCX8tjwZ8DbVih8aiY6SG6lrVY5b1miiv00MUXP+jBY61SdOtu0jqmc5Q37ilataFHeYMCc69mGswl9M1J8dles=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMrtZJA73kR+oam3iHyo3d9RGh5SWVlebcVWeL8/qWo1UTZ51
	zVXw8oIToeylOy7G/WLg7FKWNHksEzs+yw2Z2W/S50eqj5PvblQf4RdO8iMYG9zYvE4yEp+BjH4
	dVKB5fWOge4LrPwA4I+fq5Iay2VQjY8Pi3ryC+AvY1A==
X-Gm-Gg: AY/fxX7zc765ubiuazigI4wuzI7woR6/jIwayeTCuxfF88mt5i5PQqUTJOfNE/KuxkT
	1JXlq51DxzpAeVKEPVqeRQ6CL6w62jpno33+kQckdeNLX8CKTjUEVUfAA6pY8g3BP3EAqXZowHN
	HJEU9Tgsgt0jIyQxsQIi5u8Jqyamm0Lz6yUPEFtz95lR8/Fnr2nihz1ticNdXUMQtNFyeE0dl7T
	7GRQ1luFlKhWeLJPSA1X4pKaSfwWld90Yo+ws8oSR5OShfLoDGIHiRldlZ+jcgZkQC2EdeASxoG
	n35u+zEjns24wh9ekUd8UW7PqQ==
X-Received: by 2002:a05:6820:1c97:b0:659:9a49:90b5 with SMTP id
 006d021491bc7-66102db55b3mr3137993eaf.52.1768464407156; Thu, 15 Jan 2026
 00:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>
 <CAHUa44G+2PWzOnj6smTR9vES06hrwry-SaSj-FcPJgVccNTSXg@mail.gmail.com> <aWe9EzWskkSB0Sv-@kernel.org>
In-Reply-To: <aWe9EzWskkSB0Sv-@kernel.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 15 Jan 2026 09:06:35 +0100
X-Gm-Features: AZwV_QgHKNmW8L6ATB_GnL8-Ngslu0I0TONumS62816xCi5y4tweJwAPReV9JIY
Message-ID: <CAHUa44Fjdskx_5+=gugCwfqBOnF8+Hs2=enauLOExafxo5K3=w@mail.gmail.com>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix kdoc after function renames
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 4:58=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Jan 14, 2026 at 07:47:09AM +0100, Jens Wiklander wrote:
> > On Tue, Jan 13, 2026 at 3:38=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > Recently ftpm_tee_probe() and ftpm_tee_remove() grew a suffix in thei=
r
> > > function name but I failed to adapt the kernel doc when doing so. Thi=
s
> > > change aligns the kernel doc to the actual function name (again).
> > >
> > > Fixes: 92fad96aea24 ("tpm/tpm_ftpm_tee: Make use of tee bus methods")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202601132105.9lgSsC4U-l=
kp@intel.com/
> > > ---
> > >  drivers/char/tpm/tpm_ftpm_tee.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Looks good to me. Jarkko, OK, if I also take this patch via my tree?
>
> Works for me that way too with my r-by tag.

Thanks, it's there now.

Cheers,
Jens

>
> >
> > Cheers,
> > Jens
> >
> > >
> > > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_f=
tpm_tee.c
> > > index 20294d1953a3..b82490439633 100644
> > > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > > @@ -163,7 +163,7 @@ static int ftpm_tee_match(struct tee_ioctl_versio=
n_data *ver, const void *data)
> > >  }
> > >
> > >  /**
> > > - * ftpm_tee_probe() - initialize the fTPM
> > > + * ftpm_tee_probe_generic() - initialize the fTPM
> > >   * @dev: the device description.
> > >   *
> > >   * Return:
> > > @@ -266,7 +266,7 @@ static int ftpm_plat_tee_probe(struct platform_de=
vice *pdev)
> > >  }
> > >
> > >  /**
> > > - * ftpm_tee_remove() - remove the TPM device
> > > + * ftpm_tee_remove_generic() - remove the TPM device
> > >   * @dev: the device description.
> > >   *
> > >   * Return:
> > >
> > > base-commit: 92fad96aea24fc19abe1eae2249402b61de3a3e2
> > > --
> > > 2.47.3
> > >
>
> BR, Jarkko

