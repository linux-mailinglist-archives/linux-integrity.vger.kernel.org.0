Return-Path: <linux-integrity+bounces-3937-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D61CF9B6D49
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 21:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7861C2154D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88381D1502;
	Wed, 30 Oct 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y06cLp9y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D01D12ED
	for <linux-integrity@vger.kernel.org>; Wed, 30 Oct 2024 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318963; cv=none; b=OPVwi3xyC9714dlrTvlVkMEZVsc/3rXtwEWYLL0eXb8M4kqSwL82hXYf7vMZYEffIi2ZMh0yBIbd5FY1gu8GIq3X4RHuN4MTXX5k82iVzJ4uD+PVRhOUMqOKVTPXuzTw9A5O+hW9Km/yZNQqHo7Wk8IP9b9uXLHgp9KPRn0qt64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318963; c=relaxed/simple;
	bh=3GoHIUWOXuWToSJdXx7r5+OSBW9SUiHpsppQuFb0JkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCbG/7mmHzfyXkReTWLG4E8SE4qivbVN/4zJ60ERo2kI9B0JtyIXie62gIvhHgcQdnt+WPvP423u0JI1sisa2HnnEkFEIkwfnPi8jsuLbF7Y5mGJV0IrfkXCCeDn3eVKlqmT8Se9Okbsc59qcpoUvUh0XnBKrYJOkWF7hyt5z5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y06cLp9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730318960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWAhOKy8AaoE6kjDoU5Y+aFbm5DQKBGPLCE/gtj6bSE=;
	b=Y06cLp9ywpM/bcppsBYuavbbk+Fz8wxMx8SSXuVbtglq8mZvmMqx63Tbk9lgno61DjC0p3
	1ba5PSrhe4nj7y7wQzqAavkGyKqsvQXxGGyLDPCoV/ZTCzBv7eYMcQxG3RdzIv5qpMzziY
	/J6Oea9pehqHJ1PJeZkoNB4OH69yNug=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-QbGDM1NUP2qDShVyng4TMg-1; Wed, 30 Oct 2024 16:09:19 -0400
X-MC-Unique: QbGDM1NUP2qDShVyng4TMg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b14cb9f6f5so33474585a.0
        for <linux-integrity@vger.kernel.org>; Wed, 30 Oct 2024 13:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318958; x=1730923758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWAhOKy8AaoE6kjDoU5Y+aFbm5DQKBGPLCE/gtj6bSE=;
        b=ZkaQRttgWD/VZl/5RR11rP2vmv0EkFUguW96Wb8NZy6GIELDLE2OH5hY6D0P5noom5
         GEwXYX/uW2xFvEyvxFqt56GCGTuPgjPsi+MNkF/eN8Ebrsf8vZ/+JANWE7I9HvNjbbIW
         nffKcy0U2IcRo1mvlTqdgypwpwv3FVRpu3q3G1IqzQHR4Wz+MwJa1NYCPuO2sVO2RQ+M
         VCWHUjtGqfaoaVfLOfAETRhTgqjl2XOArUOE7HpvmlZbQUmXWD9UtY4rnhrCd7jOVK+L
         hhRy7gG/67Pi7rZpyqCZiE2HqQf6+nQSqttzbkxblvJxReT3JymavAQIHbt7CgJw3QqK
         pGQA==
X-Forwarded-Encrypted: i=1; AJvYcCU1dQfsKRANcJiQQZx3/5UGxQnlvGdCsTZlJSIbIptJ4mT0ma79C247xE7gVFN/d/zjh/FD5rObY4fGAu0/UmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kfHziZE7QsLir2dRvLEG7oMIXrVZYjhSX7JgOZnkyzvP+J/n
	XWJx1sgJKmG1drNomckHFJWeMKb2Yx6wgonEqM9URIPdNkG+X0gzVO3AMNTTVzDXb05xQr2rulg
	2ScbUEJiVgB90HAMaRa1nGjEwqqRhDQLMWVBBLFaTQKaBu0Aj39yBF985Qtyc9IlvAA==
X-Received: by 2002:a05:620a:4449:b0:7b1:3bf8:b3cc with SMTP id af79cd13be357-7b193efa025mr2481313085a.17.1730318957922;
        Wed, 30 Oct 2024 13:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESiC+ZBshjKIPN+xWOccI73zuzKl0nIkRotTScN/UA0F/oksFRqHkq6WeD3OlPrRtZpSE0bw==
X-Received: by 2002:a05:620a:4449:b0:7b1:3bf8:b3cc with SMTP id af79cd13be357-7b193efa025mr2481310785a.17.1730318957629;
        Wed, 30 Oct 2024 13:09:17 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7be9sm400085a.33.2024.10.30.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:09:16 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:09:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	stable@vger.kernel.org, Mike Seo <mikeseohyungjin@gmail.com>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: set TPM_CHIP_FLAG_SUSPENDED early
Message-ID: <z4ggs22bzp76ire4yecy5cehlurlcll7hrf2bx4mksebtdmcmr@hpjardr6gwib>
References: <20241029223647.35209-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029223647.35209-1-jarkko@kernel.org>

On Wed, Oct 30, 2024 at 12:36:47AM +0200, Jarkko Sakkinen wrote:
> Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
> according to the bug report, as this leaves window for tpm_hwrng_read() to
> be called while the operation is in progress. Move setting of the flag
> into the beginning.
> 
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-interface.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 8134f002b121..3f96bc8b95df 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
>  	if (!chip)
>  		return -ENODEV;
>  
> +	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>  		goto suspended;
>  
> @@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
>  	}
>  
>  suspended:
> -	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> -
>  	if (rc)
>  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
>  	return 0;
> -- 
> 2.47.0
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


