Return-Path: <linux-integrity+bounces-8232-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2342D1CB61
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 07:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7352A3004504
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 06:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15A436E476;
	Wed, 14 Jan 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIQRvHzN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2236E48D
	for <linux-integrity@vger.kernel.org>; Wed, 14 Jan 2026 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373255; cv=none; b=sti6nf6mexepw2AO0KSxySbULytAqS/qmLe0S67xWKG+vXjrVRLziWVxVnP4zmu3ZPRQS4IwdgjQ99zo/4qma5CX4+MK6bglIeG+xb5z2Y1Sa3GqQNvVMLqhk/8hARXsq13RGxQ45DrWB4s4zx/sog4pgsem0s1hEY3kAm4Ktlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373255; c=relaxed/simple;
	bh=TBHHnGIxzzkwg1wxZOSuUHNdDnSvfZxCBDkqSsYUnCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IArwlbsJIIWbseSA2SQeYt9ADYHsc/f44K6Etij0fASSdsPgsKgP1E/01wLOZerYVdZ4DDmZVNzIirhAIG0SPmTsj9XwYfZnNwcbCMqJi1trfGrl/Oh0gvckzT3tIQS0xVpO5Y2OM8YkoB70mnoYc+J4xeeoBqznT5CGrzed6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NIQRvHzN; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so5802401fac.2
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jan 2026 22:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768373240; x=1768978040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/IFSyOk01QbB7CX35WyvTWiC1BMCRnY3V611GTbMpw=;
        b=NIQRvHzN1mY4l6Gf1R7exU2hTTuKkpoaPj2xC2iC3OuCjnCwN46yPQjuCIoZLGTonD
         3nmBBfAqiHvduA9lks3PadIYGSeEghX01TlJ690FOlfToWcnfYkMhT3tOoOJDgzbzZoP
         aniuFNVm2jwE959ns6XGnnh/UZDujI2NMBf1PoBaF8Y7lx3LekJpAriNDmOhuINjIO5O
         mg4+kyr5vZuA7GWCk9D1deWl/ntI5H0zGa0z/9utifN76jEPnQO9l6ytaOs1jhgSfcXz
         lw0x5MXXJFZboMt5V/dymJhYr6/3FsjBPB1mbW1VmAe6NVjfAMzNVonV7P6PzjQIHc5j
         YVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373240; x=1768978040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d/IFSyOk01QbB7CX35WyvTWiC1BMCRnY3V611GTbMpw=;
        b=cNgOb7QKz4voc5PPmZVsOBOIyxnkCvIuxojANfhcwzCi1XWGkOcHV7cwAebO62DPc+
         mqM/3g1xW2Jtzm9tfcw1t1woYsm2UhQFqdCoVeKt83+cVc4ZSXUGihEIUaYAzG6YOKVn
         WJF1gAEex3Vd90dBxBdhgZtGfXq1MguTXksMB0RzJrh8BPPXOZYoIcZv+oB++WZHHJtt
         0BqKWpgIrrpytc5fdmVJlxLELzm+EfdkYsEfOxJB4q+KDfnAwy822ma5hJFXWM934otw
         xG8qxyKJ92cufKYPzE77dS7WRkwCcQ6mBxrEUKyVjNd3ErkkLArmIZoGJaOSSeKIW+4y
         pkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqf9abrrd+WyXEeidQdhgY1+qbV99FsTVrm0+/OFb9tIoCRhMmDP4HPyLQ5qCJOxzYNAMqOHb1Nacl6L/SSno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VWr/PbDx0rxw2cLrJQTqAB587qsADLubaFhFgQBPz5GWQfp1
	d0Q+L0q9FVTPoTpsPFSbEWazQphxjgXJv7cASjDg1RVnjOfMREoLVHyl9qUP71yWzXEOUF9DWSp
	aeYgiy/LNd7QyR+0wRyOT0zp8mi6+gZKWLZkD8gzrAQ==
X-Gm-Gg: AY/fxX6GmqkNpWmwwX94n44gXYIVVsm+GVEjQUHKagcB3Zh3s7T3033bITdnPdggoZ8
	1GZo4qOIuAtNZLjEcb4feLvsUtXGY0UjrWVL0rkPGCypzc8Ki/mL+ZlUpokEe5QBnPdeoKjx6fb
	NWsUVCI118NaLXaoea1xNQOQ8w5Ed2Q5M44euoIkIZsN0B1JqEn7tjXRSGruzixBg8ziSy8qyE3
	cJJhW76+nhRAfuNhcuKM2q+Wlek/6ZzwDGTTLQsyLeQTvpcv2ykCwsJOa6ZyupD5RsZrEYJw+WW
	WWKHqWKcnwXfXIHRXqRZVXhYUQ==
X-Received: by 2002:a05:6820:825:b0:65b:3641:bf79 with SMTP id
 006d021491bc7-6610097f882mr1135430eaf.77.1768373240386; Tue, 13 Jan 2026
 22:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 14 Jan 2026 07:47:09 +0100
X-Gm-Features: AZwV_QgNNoC11et3GlEoA2VND3sD4l0uCmTBU-5uG3zcrkw3Ed0Q8_zvuMOwhRI
Message-ID: <CAHUa44G+2PWzOnj6smTR9vES06hrwry-SaSj-FcPJgVccNTSXg@mail.gmail.com>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix kdoc after function renames
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 3:38=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Recently ftpm_tee_probe() and ftpm_tee_remove() grew a suffix in their
> function name but I failed to adapt the kernel doc when doing so. This
> change aligns the kernel doc to the actual function name (again).
>
> Fixes: 92fad96aea24 ("tpm/tpm_ftpm_tee: Make use of tee bus methods")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601132105.9lgSsC4U-lkp@i=
ntel.com/
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good to me. Jarkko, OK, if I also take this patch via my tree?

Cheers,
Jens

>
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_=
tee.c
> index 20294d1953a3..b82490439633 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -163,7 +163,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_da=
ta *ver, const void *data)
>  }
>
>  /**
> - * ftpm_tee_probe() - initialize the fTPM
> + * ftpm_tee_probe_generic() - initialize the fTPM
>   * @dev: the device description.
>   *
>   * Return:
> @@ -266,7 +266,7 @@ static int ftpm_plat_tee_probe(struct platform_device=
 *pdev)
>  }
>
>  /**
> - * ftpm_tee_remove() - remove the TPM device
> + * ftpm_tee_remove_generic() - remove the TPM device
>   * @dev: the device description.
>   *
>   * Return:
>
> base-commit: 92fad96aea24fc19abe1eae2249402b61de3a3e2
> --
> 2.47.3
>

