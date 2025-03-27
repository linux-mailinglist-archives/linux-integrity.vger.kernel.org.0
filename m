Return-Path: <linux-integrity+bounces-5482-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47687A735B7
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B851D16E6AC
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11CB18FC67;
	Thu, 27 Mar 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T28tmUZn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627114900F
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089630; cv=none; b=XXP+AeB/vb+ya5GC4Gy2P7O9mqX7ONxNKjyZuovQZO3O1sM4MnA+HNFGiu2SG2/9LQdSqgds1R+DJJpRJnR2wLoVD5fGj33jsJUww4QjtFc7bn6WTh0CEmyRpF3GH0xhA5xjhVm1khaklEJ0pVyMUYgrVUStaAhrAhnYjv9zDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089630; c=relaxed/simple;
	bh=HQ0Ef72EnhxykKElz27nhTsC4zNkLX6xKFDXcXCafbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbFsAtDbWGMM+DypedAmqohj3IG2J5KLvsue3p9Hm+9dL0j4pR+Oqcu6vEHJUm3omI4Gz6qAgRbQ7wOAd6znoRJL3Ek7SL8r5aS3th17dEWfKO94R00vo79R7klitAFZr3O4ge5gG+JK3elqLUJaI/wao+Jb+GPA7hh5i64t40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T28tmUZn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743089627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2vfWjdPjd1igi+HrBJvoMOSZHPLNEOz1XXFk58tFSs=;
	b=T28tmUZnQ2VWVrdXS16POdbnzJhtVJ2YW9uoxXg2u9Go0NtnDRr/Q8Z0xsvrLw9vvTiPlN
	HwtX+lge3EWgcGazl82cq0/jCKe0WB2HSiEKuMqNk1pz9VePS5fIeB3moW7+rrySEcTLUg
	f3RQqYbj8AyYQz5V2/8d6guIQOoXjGI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-It7bcdfgNwmloCjesV3ytQ-1; Thu, 27 Mar 2025 11:33:45 -0400
X-MC-Unique: It7bcdfgNwmloCjesV3ytQ-1
X-Mimecast-MFC-AGG-ID: It7bcdfgNwmloCjesV3ytQ_1743089624
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913f97d115so590842f8f.0
        for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 08:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743089624; x=1743694424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2vfWjdPjd1igi+HrBJvoMOSZHPLNEOz1XXFk58tFSs=;
        b=sJN3dLlYBWsQZJxHbseYXsE+GnOcfA10OlCkhDprb5aDnnI3HKPSlxF1KOubwAUkfx
         R1tK2Ir5u9ZKWz+UyOUTAIQcT8FhalcNdAbqtXyuMVv7l93lmVxhmAvt3GkJY9ywpQ4K
         leCyOOVnryle0LnSP49TRAM8EIEYC1bfpyobo+DZ2TzpO80HnjF968f8p4Fbmt/Zb23V
         HNH+wspUWHfQX69+q5Fj/vcXMyFSkTXF4SIuJr0VpO+VVnuogsmp9RUyEh1LXoABvq6/
         lo4OIdnma2ZIUPWfeCA4dhsxhFf1O4/Je4X1dm4HDL9YRzllv6KzSViNYZrNovSqXASs
         cFVg==
X-Gm-Message-State: AOJu0YyJFzSa93At6vN0gIsm2qGmTOypwFuoXl7J+TYnKshXKXrhFRWH
	FDfV3mQkc2Hm9sFix9QJVHxnLOA4fchsShw7sAE4QX80dRKCHR70/8SRZ61Pbp7WLEnRYTqAFxo
	AE9atCp29KvtolQapSzPkpMdZOoPBTwwB6IKDv15r69fmdStBJnYvqO3hTN/Ts4KCVQ==
X-Gm-Gg: ASbGnctVFANPE90eaOnUPTNasSEGh03tqJyrsGWpwnJBUUiQbViBAxtH559UvDKPkLS
	LhQEV/gxpqFhA1K+Rhl3hnVJp0wccrNEwvZnTMSAY9u2mNf8zmkxyPwHMbiraO/KUvF4j5ZWvb9
	rh8jN1LTooIGYQ+wwmYVTAPRy4Rj81TFd/bEqpI/x7wMbNYJsUBLqfUK54647xOSV7I1U2MdvNd
	eHZEGvRNfYxlBtMNsF6C4j/aqTExMFoTZRz2I4prr2lJ7mq33Xcdgkspzy2qu4H8FtZmVNoL7NB
	s8Dsy4Ppmm7H6sqd4ccwoT3HOtCHOCPkQy0hp881+Vnz/Cwl06VOSNWLIXCa1JfY
X-Received: by 2002:a05:6000:2ab:b0:39a:c9ae:a198 with SMTP id ffacd0b85a97d-39c0999ce73mr930201f8f.1.1743089624176;
        Thu, 27 Mar 2025 08:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbW6gDJheuO35EEv4q38v+8yZH1/WUMW1a7B/qNPyI6GOHHawUBbYyx6/8xdWkIjzghJsuoA==
X-Received: by 2002:a05:6000:2ab:b0:39a:c9ae:a198 with SMTP id ffacd0b85a97d-39c0999ce73mr930152f8f.1.1743089623522;
        Thu, 27 Mar 2025 08:33:43 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e835fesm41649215e9.10.2025.03.27.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 08:33:42 -0700 (PDT)
Date: Thu, 27 Mar 2025 16:33:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>, 
	Jens Wiklander <jens.wiklander@linaro.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt
Message-ID: <gknnbjutmstexcitncmpyapwu6eo2qarvjkknkpzdurc4dffxw@onqqs5x2raug>
References: <20250326161838.123606-1-jarkko@kernel.org>
 <exzxzomw7wcobjuoje37x6i2ta54xzx5ho74t3atd7g74xltlb@ymw2pn3yo27b>
 <Z-VRWy8jLkA0cpow@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-VRWy8jLkA0cpow@kernel.org>

On Thu, Mar 27, 2025 at 03:23:39PM +0200, Jarkko Sakkinen wrote:
>On Thu, Mar 27, 2025 at 10:58:00AM +0100, Stefano Garzarella wrote:
>> On Wed, Mar 26, 2025 at 06:18:38PM +0200, Jarkko Sakkinen wrote:
>> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>> >
>> > tpm_ftpm_tee does not require chip->status, chip->cancel and
>> > chip->req_canceled. Make them optional.
>> >
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>> > ---
>> > drivers/char/tpm/tpm-interface.c | 31 ++++++++++++++++++++++++++++---
>> > drivers/char/tpm/tpm_ftpm_tee.c  | 20 --------------------
>> > 2 files changed, 28 insertions(+), 23 deletions(-)
>> >
>> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> > index f62f7871edbd..10ba47a882d8 100644
>> > --- a/drivers/char/tpm/tpm-interface.c
>> > +++ b/drivers/char/tpm/tpm-interface.c
>> > @@ -58,6 +58,30 @@ unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>> > }
>> > EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
>> >
>> > +static void tpm_chip_cancel(struct tpm_chip *chip)
>> > +{
>> > +	if (!chip->ops->cancel)
>> > +		return;
>> > +
>> > +	chip->ops->cancel(chip);
>> > +}
>> > +
>> > +static u8 tpm_chip_status(struct tpm_chip *chip)
>> > +{
>> > +	if (!chip->ops->status)
>> > +		return 0;
>> > +
>> > +	return chip->ops->status(chip);
>> > +}
>> > +
>> > +static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
>> > +{
>> > +	if (!chip->ops->req_canceled)
>> > +		return false;
>> > +
>> > +	return chip->ops->req_canceled(chip, status);
>> > +}
>> > +
>> > static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>> > {
>> > 	struct tpm_header *header = buf;
>> > @@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>> > 	ssize_t len = 0;
>> > 	u32 count, ordinal;
>> > 	unsigned long stop;
>> > +	u8 status;
>>
>> Why move `status` out of the do/while block?
>
>I'm not a huge fan of stack allocations inside blocks, unless there is
>a particular reason to do so.
>
>
>>
>> >
>> > 	if (bufsiz < TPM_HEADER_SIZE)
>> > 		return -EINVAL;
>> > @@ -104,12 +129,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>> >
>>
>> What about doing an early return avoiding also calling
>> tpm_calc_ordinal_duration()?
>>
>> I mean something like this:
>>
>>                 rc = 0;
>>         }
>>
>> -       if (chip->flags & TPM_CHIP_FLAG_IRQ)
>> +       if (!chip->ops->status || chip->flags & TPM_CHIP_FLAG_IRQ)
>>                 goto out_recv;
>>
>>
>> Anyway, those are small things, the patch LGTM and it's a great cleanup
>> for ftpm and the svsm driver I'm developing!
>
>If you refined send() and had that the sync flag, this would become:
>
>	if (chip->flags & (TPM_CHIP_FLAG_IRQ | TPM_CHIP_FLAG_SYNC))
>		goto out_recv;

Yep, good point!

>
>>
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Thank you.

You're welcome!
Stefano


