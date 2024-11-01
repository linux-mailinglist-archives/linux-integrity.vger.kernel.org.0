Return-Path: <linux-integrity+bounces-3971-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48359B995F
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C22282766
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Nov 2024 20:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828CF1E2304;
	Fri,  1 Nov 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMqTJxHN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196491D7E52
	for <linux-integrity@vger.kernel.org>; Fri,  1 Nov 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492597; cv=none; b=fBZJUZ5zc1L4MyL9M85TabHNisHwcpazsdQebAUGKFqHifucU32DinZQVNWC/1cV1mtrrRiVOsZ642IXAix9e5c6V5lvEoH14JhNa8rCd6hubeOoYqLmoce95Kb1lXcSY9auLvyvl+kxP1c6F6jVPHXGMIIwNwkVXEyeRLyRwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492597; c=relaxed/simple;
	bh=WZhkCcdsofu4QIHz3gE1Rnefl/2DkGbEznDbjjYDYc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/imY9VIffGZ/bAJrex+2CI8iKpTjzmpQq25u0wRLg2ojV5BuRDIOCWMUCfWG4Tz8xdHZw9K/Us5vpRZeOo3X3t1vqQ+/PUcppYqUIBZtE7zguwW2zHsQoKQgb3NJOKj1ATX2OkGkKfNgR3K4D47UxfgBF+zg1EYyEHXLhnCY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMqTJxHN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730492594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANub1/K4e3v/MYOsC1JtMcjz48WvDQab142m5XRSVWc=;
	b=bMqTJxHNyPILM360uhqi5JqzOByYffbXjGvxNQtR9vDhf/dWjOQEuYfyAV5zxjE+hpVqBo
	rcG1ROoFoXPZqgxKz1HfEwZZNcT65nyDvdfYY9goJsvt2AWFVoRjooEk1yHXigfF4gbely
	ESO7hW73apOemMRkpVwlVDd9F2tq9Fc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-XrbsCP6eOcybGHX_0JVwKw-1; Fri, 01 Nov 2024 16:23:12 -0400
X-MC-Unique: XrbsCP6eOcybGHX_0JVwKw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b14cb9f6f5so369844385a.0
        for <linux-integrity@vger.kernel.org>; Fri, 01 Nov 2024 13:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492592; x=1731097392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANub1/K4e3v/MYOsC1JtMcjz48WvDQab142m5XRSVWc=;
        b=Pix/0yQixlmqmD9giBUWCTBvli/DaVkxYpLd6vqmTQcmHZsCb0thMjkUeRYAzbcg5+
         OobnCEK8zG9V0mUND3G9k1BdGQEfyTKC5f1KZAJOONSd794ZIonK+wNopR9yYsPn7XU6
         nhaURuBK7ycJdh6OZc0CAmbsRWn6oJEuzUDt6qQKURs8y8RDmYsaOkIE5YNCZmDH3d4O
         rMsA452yFRiWeWN7IYkzTsgWxGLQreCoNPKUA7Fds4ABHcDPxFBws/6cbX08KYUaR0Vd
         KQyJj0SQrOKsjoRwquuPTW9VDVNXWmHuGZ+KnbWou+vISmNE15C01PVyeg9h5SSSeiMj
         JHvA==
X-Forwarded-Encrypted: i=1; AJvYcCWUrLxJQiLXBfqUqEDiwJO1Zei8GiFoSJC/qvAIQV6RtuL5zcBQYpQTXY8Tut0d51DD9/M5PUH5+rmEM/I4648=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjfapHkbRKF8Q3u1VFdNsHVw7o5ly1dRVy5OHuWeTbN829z7X
	vEtppR7Suqu4/9g0AOm8ih+TZdbeM8x3VRo0GBtZPgQQaaKaAe5+5o743TsHQd6R2W7jjkfG6T5
	69accLFEMiyjtY+VdRyCm0JKlzQhJEjVMS/Xd02ms0/wz31tIBoKckZOaP2mh1bjIgA==
X-Received: by 2002:a05:620a:458e:b0:7af:cf07:905b with SMTP id af79cd13be357-7b193ee16efmr3456684985a.2.1730492592274;
        Fri, 01 Nov 2024 13:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9xVNPcq1jmK7aJ5QBENQFMna7+p8sUgLMxELKbukLjbWMZ4mTiKOGmCsnmG43Hqb4mVdQ6A==
X-Received: by 2002:a05:620a:458e:b0:7af:cf07:905b with SMTP id af79cd13be357-7b193ee16efmr3456681685a.2.1730492591925;
        Fri, 01 Nov 2024 13:23:11 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a10a39sm203788285a.66.2024.11.01.13.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:23:11 -0700 (PDT)
Date: Fri, 1 Nov 2024 13:23:09 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	stable@vger.kernel.org, Mike Seo <mikeseohyungjin@gmail.com>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Lock TPM chip in tpm_pm_suspend() first
Message-ID: <ke4tjq5p43g7z3dy4wowagwsf6tzfhecexkdmgkizvqu6n5tvl@op3zhjmplntw>
References: <20241101002157.645874-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101002157.645874-1-jarkko@kernel.org>

On Fri, Nov 01, 2024 at 02:21:56AM +0200, Jarkko Sakkinen wrote:
> Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
> according, as this leaves window for tpm_hwrng_read() to be called while
> the operation is in progress. The recent bug report gives also evidence of
> this behaviour.
> 
> Aadress this by locking the TPM chip before checking any chip->flags both
> in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPENDED
> check inside tpm_get_random() so that it will be always checked only when
> the lock is reserved.
> 
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v3:
> - Check TPM_CHIP_FLAG_SUSPENDED inside tpm_get_random() so that it is
>   also done under the lock (suggested by Jerry Snitselaar).
> v2:
> - Addressed my own remark:
>   https://lore.kernel.org/linux-integrity/D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org/
> ---
>  drivers/char/tpm/tpm-chip.c      |  4 ----
>  drivers/char/tpm/tpm-interface.c | 32 ++++++++++++++++++++++----------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 1ff99a7091bb..7df7abaf3e52 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -525,10 +525,6 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  {
>  	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
>  
> -	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
> -	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
> -		return 0;
> -
>  	return tpm_get_random(chip, data, max);
>  }
>  
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 8134f002b121..b1daa0d7b341 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -370,6 +370,13 @@ int tpm_pm_suspend(struct device *dev)
>  	if (!chip)
>  		return -ENODEV;
>  
> +	rc = tpm_try_get_ops(chip);
> +	if (rc) {
> +		/* Can be safely set out of locks, as no action cannot race: */
> +		chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> +		goto out;
> +	}
> +
>  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>  		goto suspended;
>  
> @@ -377,21 +384,19 @@ int tpm_pm_suspend(struct device *dev)
>  	    !pm_suspend_via_firmware())
>  		goto suspended;
>  
> -	rc = tpm_try_get_ops(chip);
> -	if (!rc) {
> -		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -			tpm2_end_auth_session(chip);
> -			tpm2_shutdown(chip, TPM2_SU_STATE);
> -		} else {
> -			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> -		}
> -
> -		tpm_put_ops(chip);
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		tpm2_end_auth_session(chip);
> +		tpm2_shutdown(chip, TPM2_SU_STATE);
> +		goto suspended;
>  	}
>  
> +	rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> +


I imagine the above still be wrapped in an else with the if (chip->flags & TPM_CHIP_FLAG_TPM2)
otherwise it will call tpm1_pm_suspend for both tpm1 and tpm2 devices, yes?

So:

	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
		tpm2_end_auth_session(chip);
		tpm2_shutdown(chip, TPM2_SU_STATE);
		goto suspended;
	} else {
		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
	}


Other than that I think it looks good.


>  suspended:
>  	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> +	tpm_put_ops(chip);
>  
> +out:
>  	if (rc)
>  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
>  	return 0;
> @@ -440,11 +445,18 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>  	if (!chip)
>  		return -ENODEV;
>  
> +	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
> +	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED) {
> +		rc = 0;
> +		goto out;
> +	}
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		rc = tpm2_get_random(chip, out, max);
>  	else
>  		rc = tpm1_get_random(chip, out, max);
>  
> +out:
>  	tpm_put_ops(chip);
>  	return rc;
>  }
> -- 
> 2.47.0
> 


