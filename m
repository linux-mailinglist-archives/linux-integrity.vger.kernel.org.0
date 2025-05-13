Return-Path: <linux-integrity+bounces-6189-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B7AB56AF
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 16:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F933B7D02
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA727FB39;
	Tue, 13 May 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoaiehQV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56251531E1
	for <linux-integrity@vger.kernel.org>; Tue, 13 May 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144995; cv=none; b=PMrVOKgqkbOMgQQQialVMV63t9VXJJ8ijMUHBhIdZyiGqqhIp6R9v3D+pm5jpxbRZa+ZlpkcfXjY4inYW8jTtIF9/7ciE8CdXWNE6p6eY4eSnnIZQw6rNQIJHVwnLU+s8oZj30eFNpZmmxHoZqq3g7/cx2SczQHp9/+ozKnS6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144995; c=relaxed/simple;
	bh=KEdSRubqpS8TbP99Zzsm1oW/njWyuN0g9rA8Oc6xKG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJuivEPrQov7vNwXNOiMQRGskInklhtuAn1y5IHpfYqPkz0fYhzKM0FWlei1yYUNFF+f03leE5nriNCZV+Bj8wTU+EmUTmVeyEOUMjbpox4cGHbMeGlPDNhnWSw3VlED//+fEo9D7721phr3EH6Aq0eh9rB5Ol5b0GUeuwpnbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoaiehQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747144992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CZBKCEKg6MIgb42M1L3z+fSuwPIFwgQItnKgPnpedw=;
	b=XoaiehQVjeme8/BcpwgFfFHwjikx4uz5dfadeolOCgJDW/EjKnYmga5B45hM4IezipD7KO
	R2eNo5ckVR4kwZFXgnoez9LcB9WihdmpHkwUI+UAUr0g0My/NQ9IznQFxL0oV4cX3gP+Fx
	sgznKQ913MZ0N3v3oh7RM9i69UQAC8c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-mpwU5LsBNIO92yn-wyGocg-1; Tue, 13 May 2025 10:03:11 -0400
X-MC-Unique: mpwU5LsBNIO92yn-wyGocg-1
X-Mimecast-MFC-AGG-ID: mpwU5LsBNIO92yn-wyGocg_1747144990
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so36436975e9.2
        for <linux-integrity@vger.kernel.org>; Tue, 13 May 2025 07:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144990; x=1747749790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CZBKCEKg6MIgb42M1L3z+fSuwPIFwgQItnKgPnpedw=;
        b=KRZFKmFXQKJPeJGG2MXSEWM9mHP7QnJey1kIsxpOw5JSz3+eNrwzap5KOGBSiovnyj
         cq/uC8xpNZJvoKLSTXlMntT4IpUNodPVQlF/kpuFYecJf5DnYSBRsiUqhBiDwiSLvKyj
         dCfAoLKBcmMUtmJp12RUVh4myL4Ue8DpyDDYmyHiZSPUuK26EP0EK2XBRsmOMZVUOJfC
         SNjBBivZQh2UrQu/ARb8O4+7tsfZ54vtRCO9MTitVF9cQCFGS4g4WTYCSq2tlVPPWieA
         jod3yEHW7//bbxlNVHj5pln+acwVVOc+wPuSQRtUGCBoXVNz9ZeJ+eKyPOkd4bvqyAPc
         drBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQe9VTbvv4OAndIP79Ot7Jn+Tlz1+BeS6lsLd+0N+fuiMzCgCGY6GPCV+roc9RKCpDOvTgO0jN6Habfzwp/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIrDd/q+ZdgP+qgUorhgPD5iDbEY94M5WktZayvPeVJOGax9S
	jtptHbo2e6Q5rr504XV9K8cGXoQl9H5ix8+mUkRghePbats19V7tbiwQGx6LpSXQweqkX9xZomh
	KMdDBDLectbrX7pASl4nElDziNfv4iPWvIJEbK9cov/9biIykBwNRwan8EI3d51Bc4g==
X-Gm-Gg: ASbGncttMqZam6r1KC5I2lrcRMIU0+Nq91qv/Qqm7F7NakVN/sYLhnGEzIpoKgzDOdX
	1y9ezR7FgvnwT5EsweOnImilwuLI7e7GUA/e9DLxYcC859awFzClCa61cF2C1YgSUCGuAkhK/n8
	mTM/Ha03n0MVn59muNawl6UZmij9zpikQnXNdXwYHEMamig96PAiYPDi8c1Cc96MC1iAL0m4aIw
	qfPIiE8rkbChaqL8qq1heXp4FLr0qy51eFBfkLusOqDWbdZUsBi6C7Fp6GKFy/hytwoEAq7GXel
	LwTowf4MDzHxtxM=
X-Received: by 2002:a05:600c:3b0e:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-442d6ddea12mr180192435e9.31.1747144987570;
        Tue, 13 May 2025 07:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8ZEKfjvThnHZ+qakwjJU5Vxx01h+as7nBLYm3yQHV3qHfmOsUVNBWy0KLHWObtc49rSNQEg==
X-Received: by 2002:a05:600c:3b0e:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-442d6ddea12mr180190615e9.31.1747144986468;
        Tue, 13 May 2025 07:03:06 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f33b5sm16661205f8f.54.2025.05.13.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:03:05 -0700 (PDT)
Date: Tue, 13 May 2025 16:02:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Peter Huewe <peterhuewe@gmx.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Naveen N Rao <naveen@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, linux-integrity@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Nicholas Piggin <npiggin@gmail.com>, Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 1/4] tpm: add buf_size parameter in the .send callback
Message-ID: <vasgjrd5s3km4vdhyimcqq6etf7rvi2r54zrajrwioebrxl7o5@xyi5h2yxk36z>
References: <20250509085713.76851-1-sgarzare@redhat.com>
 <20250509085713.76851-2-sgarzare@redhat.com>
 <aB8D5syofPSqjzns@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aB8D5syofPSqjzns@kernel.org>

On Sat, May 10, 2025 at 10:44:38AM +0300, Jarkko Sakkinen wrote:
>On Fri, May 09, 2025 at 10:57:10AM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Add a new `buf_size` parameter to the `.send` callback in `tpm_class_ops`.
>> This parameter will allow drivers to differentiate between the actual
>> command length to send and the total buffer size. Currently `buf_now` is
>> not used, but it will be used to implement devices with synchronous send()
>> to send the command and receive the response on the same buffer.
>>
>> Also rename the previous parameter `len` to `cmd_len` in the declaration
>> to make it clear that it contains the length in bytes of the command
>> stored in the buffer. The semantics don't change and it can be used as
>> before by drivers. This is an optimization since the drivers could get it
>> from the header, but let's avoid duplicating code.
>>
>> While we are here, resolve a checkpatch warning:
>>   WARNING: Unnecessary space before function pointer arguments
>>   #66: FILE: include/linux/tpm.h:90:
>>   +	int (*send) (struct tpm_chip *chip, u8 *buf, size_t cmd_len,
>>
>> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v4:
>> - rework the commit description [Jarkko]
>> ---
>>  include/linux/tpm.h                  | 3 ++-
>>  drivers/char/tpm/st33zp24/st33zp24.c | 2 +-
>>  drivers/char/tpm/tpm-interface.c     | 2 +-
>>  drivers/char/tpm/tpm_atmel.c         | 3 ++-
>>  drivers/char/tpm/tpm_crb.c           | 2 +-
>>  drivers/char/tpm/tpm_ftpm_tee.c      | 4 +++-
>>  drivers/char/tpm/tpm_i2c_atmel.c     | 3 ++-
>>  drivers/char/tpm/tpm_i2c_infineon.c  | 3 ++-
>>  drivers/char/tpm/tpm_i2c_nuvoton.c   | 3 ++-
>>  drivers/char/tpm/tpm_ibmvtpm.c       | 6 ++++--
>>  drivers/char/tpm/tpm_infineon.c      | 3 ++-
>>  drivers/char/tpm/tpm_nsc.c           | 3 ++-
>>  drivers/char/tpm/tpm_svsm.c          | 3 ++-
>>  drivers/char/tpm/tpm_tis_core.c      | 3 ++-
>>  drivers/char/tpm/tpm_tis_i2c_cr50.c  | 6 ++++--
>>  drivers/char/tpm/tpm_vtpm_proxy.c    | 4 +++-
>>  drivers/char/tpm/xen-tpmfront.c      | 3 ++-
>>  17 files changed, 37 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 9ac9768cc8f7..7ac390ec89ce 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -87,7 +87,8 @@ struct tpm_class_ops {
>>  	const u8 req_complete_val;
>>  	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
>>  	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
>> -	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
>> +	int (*send)(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
>> +		    size_t buf_size);
>
>I'm sorry but now that I look at this, just for the sake of consistency:
>
>	int (*send)(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>		    size_t cmd_len);
>
>I.e. match the order and parameter names from tpm_try_transmit().

Ah, I see, makes sense, I'll update and send v5.

Thanks,
Stefano


