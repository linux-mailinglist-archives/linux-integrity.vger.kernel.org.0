Return-Path: <linux-integrity+bounces-8247-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9C1D23946
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 10:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB742302A3A9
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78749356A10;
	Thu, 15 Jan 2026 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrXTeQrp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F44346765
	for <linux-integrity@vger.kernel.org>; Thu, 15 Jan 2026 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469679; cv=none; b=KXXxmoyZFViTForVFENN4RRpgWbEuAdjnR63GjVMRUcxCx5479k+EB8ZShaIOxXxUJYvsjOAgEZjSBkjWkBEOIQXlT6eM2NSMBTEO1h5zSsMhDVrMszvewXFxJ4SpP6/m1V23sYVwVCzt1zGL3liPiPdS1I5fwK3JqnrYz/LLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469679; c=relaxed/simple;
	bh=DnUF7ApixbG8a5ZvG07BLcybqovhpdR1z//QNuJOgYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8t1C2VFKP1Jso8v0nwtom1EkSluMs+9opkZ5/h6jGwaSnMM1tv9GYunr4SEshuFKdIv2G9LCJ7KxFJ3mhoClTJb64R4r5GqVETozXfnR7SbRrs9z91AKoEIsOkScaAr/KvgbUJzPuIDVaXBoIRGIx8lrocEFAb8IgRimAKVFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JrXTeQrp; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40418578e28so267163fac.1
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jan 2026 01:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768469677; x=1769074477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPT/TwbGQJTxlfRmIS6EVw7qqqelh7bIe/2xDuerLG4=;
        b=JrXTeQrpnw/YpEpmTgiU6vphbzZMCNcOmOtCZNsiQsvJf/csB+3sLeTSGMgWaVKaXT
         4PNfTCc/T/Z7lAv5Q86X/+sGiXIT8jrjcU+addNdibP9sXx4ve/3DOxvf1iOq7v61yUh
         UZWBhFQ1i4KgPfpCVc1ARY6vyMjnUXrI9rrrUJhfVill4Kj7nWuqBC9/gIE0t0gXDoSZ
         xkDPROQTC2jl7GRm2hoxiG+XvMrGZKrs4vOYVf53IPS/OMbRl8Bjk+giPmsX0yYyczfG
         my1F3WrPlldTJt1DaOcBg+YB/aphO9n71bJPmfPLi3y039p/O9EEs9ZDr22YyRgy++rA
         9p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768469677; x=1769074477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPT/TwbGQJTxlfRmIS6EVw7qqqelh7bIe/2xDuerLG4=;
        b=qc5G3fX6rTVXuLA7Onmq+l7Q9kKoM7RCQjOMDstQA9aKyZsD8um6Vu0IiQDAmdshR7
         FJBDM37dFKNKK/tAMJcpN+1RI7rP/YfGIHw7xCY0RNcK9mbDMGh02vifMrrtelL7AoDB
         qsqlXwsGlPaVS3s2YxpTVKW7oibC008C+GH4+tUU1qTX99wI+2th/8N9kQMc3OyM/1aj
         PdO0APIkSidMJb+n8R79sY5NJr2ZRj1DFEN7+h7RcB3cd0940Fp42423rhax/33RoRU+
         zhjH30gDTtRvJk/eRHRhuDoZkXLkadq+A1Ntm4XtIiS4lCGcnL4TYsvRrkoPC60iTztr
         fEuA==
X-Forwarded-Encrypted: i=1; AJvYcCX0HG/gsnftxn1k0uGGF+8KW8tgoeVeBGShZ8/GgbNrjKbzJ9KF9+rn517L161tGMpSZZq2mUo599y0oCvQeMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qtE+NbDkQAyd5z+wq1kjfTJCJWsQEP/wswR2N2UwhMhggb2a
	KRYHMSdHMFxZFSHVVn03WsGWyXlH9VGGXNtdCJjGfr7TDCrmALOPwM1OYLx5uvSsGBkNLE4C7nK
	1qaea5vEqWZeARO4vINdrQVjGxEnyCFe4i2x4+Hp2SQ==
X-Gm-Gg: AY/fxX4TJd5xZXGJzO+iXoLQfaS9nGkAObzu2rCvVfGdKC9PeNeuyiqhWFOfTXj/gqk
	cxyidbEbb1a9aDN6jihztmns3dDT1uz42VUHikHAKN8TphsJlWjwbnUSpE5tbxa8RwkLDPIpqf1
	cQyAAStJNz0E76vN+N7z1X65oqC8cD5Lp5AAwjKndgt3hOcyCeVtGYeP5Trgt6rs3MXrVPVL/hQ
	FYpDKZWV7/jAOB35ClwidtIdJmdQ5CUe0KCgRae2159XPSYGoW/YKnYH52s3K1PjpRoJj5WBJDr
	/7Izb/4eHZHZdJD7jzx7hkIqJ40b3b9m/I5M
X-Received: by 2002:a05:6870:9724:b0:36d:287c:694f with SMTP id
 586e51a60fabf-4040719371fmr3977831fac.30.1768469676782; Thu, 15 Jan 2026
 01:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>
 <CAHUa44G+2PWzOnj6smTR9vES06hrwry-SaSj-FcPJgVccNTSXg@mail.gmail.com>
 <aWe9EzWskkSB0Sv-@kernel.org> <CAHUa44Fjdskx_5+=gugCwfqBOnF8+Hs2=enauLOExafxo5K3=w@mail.gmail.com>
 <yxbcy7rsteemywp4bcpvwuueqye64hhqxhgkvwj72oasd2ls5l@rqwpbumkzrdb>
In-Reply-To: <yxbcy7rsteemywp4bcpvwuueqye64hhqxhgkvwj72oasd2ls5l@rqwpbumkzrdb>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 15 Jan 2026 10:34:24 +0100
X-Gm-Features: AZwV_Qg3pz9TcoWTR6z_BvXDszVIH2nSSRfToD_J-6M6k7L-uL4b_3z_xZ5L_n0
Message-ID: <CAHUa44EaUkYHgAvb61j-Q=n_j3MU-cUxFxF=Ss4wjiKS7Y-mNQ@mail.gmail.com>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix kdoc after function renames
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 9:29=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> On Thu, Jan 15, 2026 at 09:06:35AM +0100, Jens Wiklander wrote:
> > On Wed, Jan 14, 2026 at 4:58=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.=
org> wrote:
> > >
> > > On Wed, Jan 14, 2026 at 07:47:09AM +0100, Jens Wiklander wrote:
> > > > On Tue, Jan 13, 2026 at 3:38=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > >
> > > > > Recently ftpm_tee_probe() and ftpm_tee_remove() grew a suffix in =
their
> > > > > function name but I failed to adapt the kernel doc when doing so.=
 This
> > > > > change aligns the kernel doc to the actual function name (again).
> > > > >
> > > > > Fixes: 92fad96aea24 ("tpm/tpm_ftpm_tee: Make use of tee bus metho=
ds")
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-kbuild-all/202601132105.9lgSsC=
4U-lkp@intel.com/
> > > > > ---
> > > > >  drivers/char/tpm/tpm_ftpm_tee.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > Looks good to me. Jarkko, OK, if I also take this patch via my tree=
?
> > >
> > > Works for me that way too with my r-by tag.
> >
> > Thanks, it's there now.
>
> Stephen pointed out that I forgot to add my S-o-b[1]. So I hereby certify
> that I created the patch and have the right to submit it under the GPL2.
>
> With that I think it's technically ok that the commit doesn't have my
> S-o-b. But if you are willing to rewrite the commit still, please add
> it:
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

I've updated it.

Thanks,
Jens

