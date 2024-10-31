Return-Path: <linux-integrity+bounces-3945-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B907A9B7E7A
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6941C23342
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2024 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0033E1A286D;
	Thu, 31 Oct 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqwzKNt/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED61A262D
	for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388522; cv=none; b=ZpzobaOrVSr0wVVB0gi1Iapwd5vDRXMfCSo/S0NV258xseMq4YETDQNVfTj2EOOwRtSzti8VrExbN7M7heYxmL0M7l4FMFWVMDN/8d8ueNJChKNeY+cP+GShnVti39Fa59vRbKgmgQqlf+6M0I6tGPnoXRmTJh+voT4BxXXNFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388522; c=relaxed/simple;
	bh=XFRU4IqcSdgxVnw/JlvfzuG2Sl6A2N+nJCZq4YVo/3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8TuD/BMP3n7ARRk8Fdq//BoLL5zM1p0cGaYXBmm8ePt9N6IREXibllnEQKNevavEI/ZaZ3fu2SW/spT/w778AJzbnCHKemG/dpidMb+p8YshTz2uiRYboSkScynG0QIaZkqqu/pwiHdMx0hfw3iq/HRv+jZgDQwuMmpZ6xptGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqwzKNt/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730388519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7G1+Hqna3UU+Rn8kUUMeQiUy3fKER/ZEakrNHvj/D8=;
	b=IqwzKNt/jYWGlV+Wx15DwxlXXkooUeElXVyEYLXu1r/TNcpWDD0m/WzOjyrw65DMakJWcs
	HJos4N+f7JDpRTUJmnp/BdaWuJ+4jtIBPsCL+yTxxb0sbNAasCSs7AbkiWcpl8SwkAu7o9
	ZySLxMmB6yVXB7762fskzahJzLRef5U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-jhk6AVRMNCiT4sx1HvMc7g-1; Thu, 31 Oct 2024 11:28:38 -0400
X-MC-Unique: jhk6AVRMNCiT4sx1HvMc7g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbd12b8b60so47917486d6.0
        for <linux-integrity@vger.kernel.org>; Thu, 31 Oct 2024 08:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388517; x=1730993317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7G1+Hqna3UU+Rn8kUUMeQiUy3fKER/ZEakrNHvj/D8=;
        b=C9ms9I3tBq9i6kJgsnQeHSnnPWXb9FMPXnpduBuYVOkutbA+ozPxrRnDwdaAlVgMJc
         ew01Ww8OdZIzoFtYVyMuik+7fjYMvmZlyFtnuT7GPwlIFQl06aZNrU6+uGXWuvCL9aU4
         V4JUj4HrAK7fdDfO0lja/CGA227NvTGo7U9RKOzHItvuwAsIUOW+0k3vkdCR7lu/o6EI
         LYYhNeayqgQbULtpj3UxXZhqhChjbnNlNhdtZdgO2IzbsoA39IEDbu8p0zsn6w5XsLf1
         nbp/xedmwk50YJUfuwUGz/olwDtTA0ZjQDBYr7+L7H/sOfuPuLsTkLCES/O7PVIBpy4H
         sxsA==
X-Forwarded-Encrypted: i=1; AJvYcCVsdfbG/RRFGYZ4jPJEXtgph/pwQCHoNF7aFoa2vWL8y8ySxkHvZnRWMSo+DIIFUBVGjmDZR0/ltDG2IjiqRCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzur/2XOWjzfK3ZeuBfHKjJciaQ0n86+dhUqEMv8tkSlz8uU3OF
	0Ey0jYr8yT1W+9Ue+6ym8JxiZsM7xBlkvD5hy3dyLqNWkzW1fgwHyhoruZ4XRGReR7Tc8kfAiCR
	7y/cBZGMGVraoWn+HwLe0AD577Y7YFW7iUsO7zC8cuv8usqx68eMn+THgRq263qbRig==
X-Received: by 2002:a05:6214:1c0c:b0:6cb:e6f4:dc47 with SMTP id 6a1803df08f44-6d35b95111bmr6240286d6.16.1730388517345;
        Thu, 31 Oct 2024 08:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwOyhMftW7RcXuyK/YB23Xw24ly/AHcdk0qbn0+7j29lc+1ZoFz4KsukugEwbZiSbmu6km2Q==
X-Received: by 2002:a05:6214:1c0c:b0:6cb:e6f4:dc47 with SMTP id 6a1803df08f44-6d35b95111bmr6239986d6.16.1730388516994;
        Thu, 31 Oct 2024 08:28:36 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3541782desm8836856d6.112.2024.10.31.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:28:36 -0700 (PDT)
Date: Thu, 31 Oct 2024 08:28:35 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	stable@vger.kernel.org, Mike Seo <mikeseohyungjin@gmail.com>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: set TPM_CHIP_FLAG_SUSPENDED early
Message-ID: <cspzjpjurwlpgd7n45mt224saf5p3dq3nrhkmhbyhmnq7iky4q@ahc66xqfnnab>
References: <20241029223647.35209-1-jarkko@kernel.org>
 <z4ggs22bzp76ire4yecy5cehlurlcll7hrf2bx4mksebtdmcmr@hpjardr6gwib>
 <D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org>
 <iq5qsrnu4v5hvndg5hxmsplyuqqgypgzqqyfa5kzsblkvr6mua@u572yggxguez>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iq5qsrnu4v5hvndg5hxmsplyuqqgypgzqqyfa5kzsblkvr6mua@u572yggxguez>

On Thu, Oct 31, 2024 at 08:02:37AM -0700, Jerry Snitselaar wrote:
> On Thu, Oct 31, 2024 at 01:36:46AM +0200, Jarkko Sakkinen wrote:
> > On Wed Oct 30, 2024 at 10:09 PM EET, Jerry Snitselaar wrote:
> > > On Wed, Oct 30, 2024 at 12:36:47AM +0200, Jarkko Sakkinen wrote:
> > > > Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
> > > > according to the bug report, as this leaves window for tpm_hwrng_read() to
> > > > be called while the operation is in progress. Move setting of the flag
> > > > into the beginning.
> > > > 
> > > > Cc: stable@vger.kernel.org # v6.4+
> > > > Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> > > > Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > >  drivers/char/tpm/tpm-interface.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > > index 8134f002b121..3f96bc8b95df 100644
> > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > @@ -370,6 +370,8 @@ int tpm_pm_suspend(struct device *dev)
> > > >  	if (!chip)
> > > >  		return -ENODEV;
> > > >  
> > > > +	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> > > > +
> > > >  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > > >  		goto suspended;
> > > >  
> > > > @@ -390,8 +392,6 @@ int tpm_pm_suspend(struct device *dev)
> > > >  	}
> > > >  
> > > >  suspended:
> > > > -	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> > > > -
> > > >  	if (rc)
> > > >  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
> > > >  	return 0;
> > > > -- 
> > > > 2.47.0
> > > > 
> > >
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Thanks but I actually started to look at the function:
> > 
> > https://elixir.bootlin.com/linux/v6.11.5/source/drivers/char/tpm/tpm-interface.c#L365
> > 
> > The absolutely safe-play way considering concurrency would be
> > to do tpm_try_get_ops() before checking any flags. That way
> > tpm_hwrng_read() is guaranteed not conflict.
> > 
> > So the way I would fix this instead would be to (untested
> > wrote inline here):
> > 
> > int tpm_pm_suspend(struct device *dev)
> > {
> > 	struct tpm_chip *chip = dev_get_drvdata(dev);
> > 	int rc = 0;
> > 
> > 	if (!chip)
> > 		return -ENODEV;
> > 
> > 	rc = tpm_try_get_ops(chip);
> > 	if (rc) {
> > 		chip->flags = |= TPM_CHIP_FLAG_SUSPENDED;
> > 		return rc;
> > 	}
> > 
> > 	/* ... */
> > 
> > suspended:
> > 	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> > 	tpm_put_ops(chip);
> > 
> > It does not really affect performance but guarantees that
> > tpm_hwrng_read() is guaranteed either fully finish or
> > never happens given that both sides take chip->lock.
> > 
> > So I'll put one more round of this and then this should be
> > stable and fully fixed.
> > 
> > BR, Jarkko
> 
> Ah, yeah better to set it while it has the mutex. That should still be
> 'if (!rc)' after the tpm_try_get_ops() right? (I'm assuming that is just
> a transcription error).
> 
> Regards,
> Jerry
> 

It has been a while since I've looked at TPM code. Since
tpm_hwrng_read doesn't check the flag with the mutex held is there a
point later where it will bail out if the suspend has occurred? I'm
wondering if the check for the suspend flag in tpm_hwrng_read should
be after the tpm_find_get_ops in tpm_get_random.

Regards,
Jerry


