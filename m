Return-Path: <linux-integrity+bounces-5680-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1CA81EFF
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 10:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E492B7B2F0A
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A4E25A656;
	Wed,  9 Apr 2025 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O++mKewz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E7C25522C
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185578; cv=none; b=XvG0c1SCz/y+6l6px+Rh+mxQUmD/ryIg/arfOHheLBSBqd4xKynzQfTN2/vY1j9evbWGBx3XqyZ/NaAVPNQJKrNJMiRL2+J9kZovBsO6Llb2MPVNkDYFnmAZIUE5yc0tvRWb+wnDQmTZWDgLZdqR1ccjKD3xfPDKmkKefHS/9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185578; c=relaxed/simple;
	bh=O4/0h2fD+v/2WoxppgtWGiHs4q3dWjGQQNeMm8b4TDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph/ndO+zcIX0Q6twXJtOlF2cxKVKFBIVV+tohSWbP55LkGuR1qEAz93HQJaQJQOKC+nk6gL7xhU9KIq6Tf96I83yx8UMiOSCMQTcFDjspTOeg/cLNeFsStnmUGfOMfso9gygy0+cayhECSkLupCrRVYWAtMZaUiYOrrPAtzdq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O++mKewz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744185575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dT/1hWKYGtk5tJHR2fAw0xNnMbEghxXKOJUzMLmSe3U=;
	b=O++mKewzRp4OfcVuA6/hoouzBp1YlRoVKpYaEQhBu55tuD8y2QvlNo4eovafs/LU4WGZtk
	8deg0ldsD2kaqs59jpeyfLQIwBhM9MK2Z+KyPq/1lmX1MJkYVUtnBBIjiw/KpGtF41oT1K
	ePgpXCrd69I2oUMh7Sq4t6PMrCAA5wg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-0xk6Vt3bOkyaCPo17kiQYA-1; Wed, 09 Apr 2025 03:59:34 -0400
X-MC-Unique: 0xk6Vt3bOkyaCPo17kiQYA-1
X-Mimecast-MFC-AGG-ID: 0xk6Vt3bOkyaCPo17kiQYA_1744185573
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab397fff5a3so47670266b.1
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 00:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744185573; x=1744790373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT/1hWKYGtk5tJHR2fAw0xNnMbEghxXKOJUzMLmSe3U=;
        b=V58khO9mHcdZb9IlDwWAMe5CtqWcwclejLSA9i/1Iw9RCBd4GEvt2GnPPQjj4FF3z4
         n8ZkNlZalV4gsY4rbgHmHDkpnKals++c3B1t4EesAL2CaoebBZ0xCQdbuWncw7uU7isx
         bQz1yBTaicQ//ks5gsG85Ljt8t+juC2DyPN01dQVmgQddRZo4ZlcSWIEVyjNhK3FMczo
         IRHTpWx1qvZnjfO+/70SEesTTXn/v6SB8jRv9lyqOvfgNymOtjZQ6xn4/fqcQGm/UEDq
         3I666W0b8oqyI8I+ti12EPnSAUJNnd3lg5krli+pETnmb9hq47rIlzAraGAFuZ/gLg8q
         9JVA==
X-Forwarded-Encrypted: i=1; AJvYcCXOe9YIMOzNuOHbtb6rnoqrd2Jt53iiiL/A6+mYPCoHn+mqb8xtC38ZHtykn0JdzPMF2/AqTtkOKWVI+DWC9MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsgZkkXI+d2yajHLchVeUi432iX7LXGMKJaUDNUCfNT2KEPGhc
	2yywp7m+f4S8wOrAyQPfg6Aqdqnklt8JoghCeNYVJ4RjWcSceHXhlt9Sfwvcafi8k5whE1X88G0
	D7jvb+tzCX782M3Y2TgvW5JW+4uhfG4zyHndvMxY5gQuYOmvE8gMJ2dqJ6DL8sHKVkQ==
X-Gm-Gg: ASbGncsmWEi70NIbqm6RHGFb4f1Ylk+pST0F+ckSN09aIQN/39AmMbTv/fBRbxo7faL
	nvzJAUYEkuzOWQKaRFWLgMubn5M+JrHQI9ajoZxA85+7Gm7ijgyN9tmldzqlTfK+RNCBYftW2Td
	WaNpAQFKFGlcFPWTERieYWOC4Milv5oQktNR9S9icou0qJ+abikqERivKwlAu8PYlgnAlo0PjsF
	Z5IqLDsqaq2Z99ioaQugt2jchEh8SW5+pye4UhApjl6c7uIDPzRtNJvBYHd2CX78kSBOoY9jTgw
	X4DPgnpZIEWCEMiNyNwFkIa5GVf1/XDlvc+2MlN2BE9S8l7kR6zXKWrt/Emj
X-Received: by 2002:a17:907:2d89:b0:aca:95ed:b9d1 with SMTP id a640c23a62f3a-aca95edc220mr253162666b.21.1744185572792;
        Wed, 09 Apr 2025 00:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDGZE5I848zF3RheNhsp0sylIGxiaPLv5p9KJ9kMUR0mVwOrwhhqxo8Y8n3wVy8ROJPh9oSw==
X-Received: by 2002:a17:907:2d89:b0:aca:95ed:b9d1 with SMTP id a640c23a62f3a-aca95edc220mr253159466b.21.1744185572086;
        Wed, 09 Apr 2025 00:59:32 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7322sm50505266b.164.2025.04.09.00.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:59:31 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:59:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-arm-kernel@lists.infradead.org, 
	Jens Wiklander <jens.wiklander@linaro.org>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Sumit Garg <sumit.garg@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Peter Huewe <peterhuewe@gmx.de>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v2 2/4] tpm: support devices with synchronous send()
Message-ID: <uhqvn5w5ziuzvp3u72kztkfbtkrb2g6ieejup4e2ufun4ywtko@4hcytxdrfues>
References: <20250408083208.43512-1-sgarzare@redhat.com>
 <20250408083208.43512-3-sgarzare@redhat.com>
 <Z_VBUozuHvbxdyB3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z_VBUozuHvbxdyB3@kernel.org>

On Tue, Apr 08, 2025 at 06:31:30PM +0300, Jarkko Sakkinen wrote:
>On Tue, Apr 08, 2025 at 10:32:06AM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Some devices do not support interrupts and provide a single synchronous
>> operation to send the command and receive the response on the same buffer.
>>
>> Currently, these types of drivers must use an internal buffer where they
>> temporarily store the response between .send() and recv() calls.
>>
>> Introduce a new flag (TPM_CHIP_FLAG_SYNC) to support synchronous send().
>> If that flag is set by the driver, tpm_try_transmit() will use the send()
>> callback to send the command and receive the response on the same buffer
>> synchronously. In that case send() return the number of bytes of the
>> response on success, or -errno on failure.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/linux/tpm.h              |  1 +
>>  drivers/char/tpm/tpm-interface.c | 18 +++++++++++++++---
>>  2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 2e38edd5838c..0e9746dc9d30 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -350,6 +350,7 @@ enum tpm_chip_flags {
>>  	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
>>  	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
>>  	TPM_CHIP_FLAG_DISABLE			= BIT(10),
>> +	TPM_CHIP_FLAG_SYNC			= BIT(11),
>>  };
>>
>>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index 3b6ddcdb4051..9fbe84b5a131 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -114,8 +114,17 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>  		return rc;
>>  	}
>>
>> -	/* A sanity check. send() should just return zero on success e.g.
>> -	 * not the command length.
>> +	/* Synchronous devices return the response directly during the send()
>> +	 * call in the same buffer.
>> +	 */
>
>Nit:
>
>/*
> * ...
>
>It's wrong in the existing comment.

Yep, I'll fix.

>
>> +	if (chip->flags & TPM_CHIP_FLAG_SYNC) {
>> +		len = rc;
>> +		rc = 0;
>> +		goto out_send_sync;
>> +	}
>> +
>> +	/* A sanity check. send() of asynchronous devices should just return

And I'll fix also this of course.

>> +	 * zero on success e.g. not the command length.
>>  	 */
>>  	if (rc > 0) {
>>  		dev_warn(&chip->dev,
>> @@ -151,7 +160,10 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>  	if (len < 0) {
>>  		rc = len;
>>  		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
>> -	} else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
>> +		return rc;
>> +	}
>> +out_send_sync:
>
>out_sync would be sufficient

sure, I'll fix in v3.

Thanks,
Stefano


