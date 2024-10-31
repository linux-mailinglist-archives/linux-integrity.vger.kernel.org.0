Return-Path: <linux-integrity+bounces-3943-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97CF9B7DBD
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 16:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0F6B225FA
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7401BC085;
	Thu, 31 Oct 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="er0eDu08"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3D1BC064
	for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386969; cv=none; b=nLhpjERcXd88qdrXXQ/wgbsaKx43ajR1VXIc8EocJDX0iqqu+D0Uf11IAh4ak33Sp5YOQx2pYxOFhMCmAJf4vEMPJCowW0+lk3IZOSNOkRreMQHqNVdfTVb/tNGAgheq3B31HnP75mdLo6/htLw6xYgm4orM0JLj+4h+X0zAbvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386969; c=relaxed/simple;
	bh=7PmYnNSE33pMLgqLKprtFGimRHDHf4swKQs7fKrK2Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBTFXqDJq70nsEakjN+3vMdoJVz4JMRFCfnK9vbnqu+oUNA4eMFbwrYoDOIZJovXuSUoBiQYfXQe7DszMGFJtWdkZufm5QqI2r9aazAxenqSM6GiK2PCDXcZQxXO4d6WQI/r22TO6GJxvfAcr1MLDKDJQdTOLCWxNLrXqK4bXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=er0eDu08; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730386966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcFK13ATabme+tLtm4zVQmDDr1yI6W8unq5xgqJPg/Q=;
	b=er0eDu08p196tVuzFiqWPXvlC4Yb69djUDCfgWk/7HeesjBCL+3FbJuWiXr3NBZ1jyXuMM
	5k5TpNvFdnPwjhcYmVnWxWRqYTlpzw6EDkJ6yfdmo+/Z0HbASSyZ0T+hdLk4aB9gOUiFHo
	U4ZiIRVMTswE8iKzJwrC7jlciBps1U0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-7vAB-U4qNjOVUDCZPrGY4A-1; Thu, 31 Oct 2024 11:02:40 -0400
X-MC-Unique: 7vAB-U4qNjOVUDCZPrGY4A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b1502ac352so119158385a.2
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2024 08:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386960; x=1730991760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcFK13ATabme+tLtm4zVQmDDr1yI6W8unq5xgqJPg/Q=;
        b=tOKa6e1Wjkpfii2pyrrODd1/s0gyO2yoMwnEwboZdKQHBVLWSgpK2/Cl/VQzIv361v
         zgIXnWgG4EkDKwg5wwpAgS2B1T3Lw9oZrSnM/o3/lUvD17cM4HX16bQvjR0uxZcDYStP
         zOV6OwmlXRMmLrugOJd0qf+bR8Ufy8sHQAVXlphZlSDP5J+P419aA+xePUxz610Exb3L
         IMd76VJ2T29ttjX+ki+opNvN0GoRPZI6k7ZDqerRZOCP173+HqCY9YSas0+tSmswgWCH
         cjnGp9GY2xopD0TJ+DBkkHuecRY1YjW535s2zJsawKHt++JbDDDZf/jn9e20vI2sRYi+
         UnuA==
X-Forwarded-Encrypted: i=1; AJvYcCXZElgTx02m4jtINTiZS3YFlPynTUisNcAfsmhwco2ItpYKHyVl5V6NXO4AIexMpMr5WxFAC8B8Tj0Bdy9b/eY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64I8wReJkwf6W6bWo9TvquVAOeZgwRy3DlYlMlWmXTpIM5871
	d5unJK+W9aeQzaXixhBxXQZZZqE1vvmkcL2n9uAe6fGxWmBxdwgDm3Peo3nM0vxbOv/Ac1K+3a+
	AQPEwbnQTQ7VEVyVwg7NGi2joQ8Ro77h4ZVhB/agLQovvLjBdAmDb4dCMSGuOzJUiSA==
X-Received: by 2002:a05:620a:4502:b0:7a9:bd59:8de6 with SMTP id af79cd13be357-7b193efdeb5mr2771728585a.27.1730386959854;
        Thu, 31 Oct 2024 08:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1hivVmOtGrfqa84wUWIrNvZrAc0fJ3j425hQSpQ1XjgoNQZ4xG703lqrMZJD5ClNDebedA==
X-Received: by 2002:a05:620a:4502:b0:7a9:bd59:8de6 with SMTP id af79cd13be357-7b193efdeb5mr2771724485a.27.1730386959467;
        Thu, 31 Oct 2024 08:02:39 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a0b548sm75639985a.54.2024.10.31.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:02:38 -0700 (PDT)
Date: Thu, 31 Oct 2024 08:02:37 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	stable@vger.kernel.org, Mike Seo <mikeseohyungjin@gmail.com>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: set TPM_CHIP_FLAG_SUSPENDED early
Message-ID: <iq5qsrnu4v5hvndg5hxmsplyuqqgypgzqqyfa5kzsblkvr6mua@u572yggxguez>
References: <20241029223647.35209-1-jarkko@kernel.org>
 <z4ggs22bzp76ire4yecy5cehlurlcll7hrf2bx4mksebtdmcmr@hpjardr6gwib>
 <D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org>

On Thu, Oct 31, 2024 at 01:36:46AM +0200, Jarkko Sakkinen wrote:
> On Wed Oct 30, 2024 at 10:09 PM EET, Jerry Snitselaar wrote:
> > On Wed, Oct 30, 2024 at 12:36:47AM +0200, Jarkko Sakkinen wrote:
> > > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
> > > according to the bug report, as this leaves window for tpm_hwrng_read() to
> > > be called while the operation is in progress. Move setting of the flag
> > > into the beginning.
> > > 
> > > Cc: stable@vger.kernel.org # v6.4+
> > > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> > > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  drivers/char/tpm/tpm-interface.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index 8134f002b121..3f96bc8b95df 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
> > >  	if (!chip)
> > >  		return -ENODEV;
> > >  
> > > +	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> > > +
> > >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > >  		goto suspended;
> > >  
> > > @@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
> > >  	}
> > >  
> > >  suspended:
> > > -	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> > > -
> > >  	if (rc)
> > >  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
> > >  	return 0;
> > > -- 
> > > 2.47.0
> > > 
> >
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Thanks but I actually started to look at the function:
> 
> https://elixir.bootlin.com/linux/v6.11.5/source/drivers/char/tpm/tpm-interface.c#L365
> 
> The absolutely safe-play way considering concurrency would be
> to do tpm_try_get_ops() before checking any flags. That way
> tpm_hwrng_read() is guaranteed not conflict.
> 
> So the way I would fix this instead would be to (untested
> wrote inline here):
> 
> int tpm_pm_suspend(struct device *dev)
> {
> 	struct tpm_chip *chip = dev_get_drvdata(dev);
> 	int rc = 0;
> 
> 	if (!chip)
> 		return -ENODEV;
> 
> 	rc = tpm_try_get_ops(chip);
> 	if (rc) {
> 		chip->flags = |= TPM_CHIP_FLAG_SUSPENDED;
> 		return rc;
> 	}
> 
> 	/* ... */
> 
> suspended:
> 	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> 	tpm_put_ops(chip);
> 
> It does not really affect performance but guarantees that
> tpm_hwrng_read() is guaranteed either fully finish or
> never happens given that both sides take chip->lock.
> 
> So I'll put one more round of this and then this should be
> stable and fully fixed.
> 
> BR, Jarkko

Ah, yeah better to set it while it has the mutex. That should still be
'if (!rc)' after the tpm_try_get_ops() right? (I'm assuming that is just
a transcription error).

Regards,
Jerry


