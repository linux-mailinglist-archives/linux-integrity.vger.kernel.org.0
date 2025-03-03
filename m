Return-Path: <linux-integrity+bounces-5049-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB3A4CA31
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A081669D7
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7181F22E40F;
	Mon,  3 Mar 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrChOGD2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7622F39C
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022970; cv=none; b=FVUGYkjucjbldcxdoJf/uu6Z87zfxci6tyyg0iqJm6u+JrG4LVglNnSGHVa610uATKQYX8OgDSr6f8gKvsbrSi9BvYuuB/Li37da2IN6Xzy3CMFtFCLXGoj0d4JjvVOFl+OyVfseL58UwhBZ5oDfU3XOgnsiCscw7mIUzXvdBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022970; c=relaxed/simple;
	bh=CVM2bEp4Yw0krI1DvlnCOP3KfIRlfjlQ2aneugrysqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zuvb1heDChhyrrX9/3tkG+cz5Wz1MM0icVyq+9mrR83cso3nME/a0y043FvGZ/0a88Zd/8hEsKVGLqLwdZPPxCTKAUgEFiMiruQ1Gq8fYgAUa/aN+LGnTZQGJefqzpf8qxM+JPzojYErafIF9NYr25lPlea3rYIQBecTHEqMFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrChOGD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741022967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B7dOzss5xAIS9ugz03HBjmDIWffEe1Y3q/s1aHQafjQ=;
	b=OrChOGD2qmoIwapsmD97P/Y39aPVS/YR+cqQ2PFTkchUs6nIeKs5its55kKBc3rl0zGczi
	5XRkX0CT+WcxnPtWfhsw8NGgWn8Crd3V5cBK4pNy8BL7EEwRHYwME5E3T6ae591Q/dwHaq
	PtQyh+hpb273ltJGwkcaExl74dT36BE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-292xDe2zMnSohjnqJxSIew-1; Mon, 03 Mar 2025 12:29:21 -0500
X-MC-Unique: 292xDe2zMnSohjnqJxSIew-1
X-Mimecast-MFC-AGG-ID: 292xDe2zMnSohjnqJxSIew_1741022960
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391079c9798so620300f8f.3
        for <linux-integrity@vger.kernel.org>; Mon, 03 Mar 2025 09:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741022960; x=1741627760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7dOzss5xAIS9ugz03HBjmDIWffEe1Y3q/s1aHQafjQ=;
        b=A1dFH3kMqGenE+on9E4e2Zv4Fzlw035bVdOGfNmgTRU1fs3PwDrMma67ZDopxmQYkJ
         rWetTCZtNDbTTY6fY69WGUoVTj/EvJgCIzpdHRPyKQYE5w3Czo42aMr/Tg0+7umYzuw1
         7QHGgdj3W1EsA2PbGZK0YeKRPH5KdbwqVtaQ4WPyXqlSpBq/Ps3uMLnBUrc9FmkZyEZM
         BtWEcX7wsAjaed4H9OdhEjUx3IGVJiaN+7l2zZJEy69c2efJxz39vrFS0B6OVnwB5NsJ
         TrY0GrpIkPezhcS/HmRS/RvsOYqOTb90T3XKqOJ0tfpL0FDBuAQ/Dpq4La5g9mSntmJT
         pIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWCVO+z/xgH7tCKwjSNJiGhbfSUwLfwC+2l3p4uMPgmkujKycRmUmuqq93TG7VOz8hTql2Ixos38+Yyr54ekE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0anFXgol9ITlBHUbo1RGAyBMwBksWlLknuw4I9lZUKaM2eY2a
	LCNYx7A8OauymQF5wzDU3nlW8T0VJbXmGyV4RRxhGqp9mepK7+qjSd6bO/sfJzSTD3PpCzdZOxp
	wCkNWlxbRvKNoDROYRmXOXdlbKKmLJyuEqTB3CFE7RyovWnFqvJSt/OJCxJWOMh1q3w==
X-Gm-Gg: ASbGncu45tC+/M8DnmQq2uwnesreWnjYOxthejU06dCXs101vM7SyFBkLmdn5ZLAiOT
	VlOMJlVfbR1NyxnQpVt7obEssMsjeecI4n8WOGgH0MQbnO0baPXKj6cvIErbGFep/oCA07ThUrJ
	plyYzHWn2Dphi4ry9tgL2QQaK9OCxi+3GKVMdFAVnblNo05whQ+et5Oew+dOr15F8x0woU8sqJB
	MyKqOWIBVLQ3dXKqPHLiatZ1IgI7wOLvvr4vJcR1IDRxzFt7khV7MjdmeqX5CKHnJ1nrKO8ZrjR
	In6q6+L2ndgte4UgJ4xLGPoWAcmvxJczpetfdVXyzEZt4UW9O0FquHEcOYWXQGRz
X-Received: by 2002:a05:6000:178b:b0:390:e7c1:59d3 with SMTP id ffacd0b85a97d-390ec7c6abamr11328169f8f.2.1741022960343;
        Mon, 03 Mar 2025 09:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpchx3nv4q0TXNFvNSfubbI7dVtBf4O0TPmwO/185eVNFUyGlQ3OOmYi8/44rH+u3S41KQ3A==
X-Received: by 2002:a05:6000:178b:b0:390:e7c1:59d3 with SMTP id ffacd0b85a97d-390ec7c6abamr11328135f8f.2.1741022959828;
        Mon, 03 Mar 2025 09:29:19 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm194884025e9.30.2025.03.03.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:29:18 -0800 (PST)
Date: Mon, 3 Mar 2025 18:29:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <r6hegxjq2aoukue4hmnuollf7lukmpnv7vxca3buqo3hulcslu@kbua5cazkv4m>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <c8e067f3-117a-7737-64ea-ac016b697d0e@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c8e067f3-117a-7737-64ea-ac016b697d0e@amd.com>

On Mon, Mar 03, 2025 at 08:06:43AM -0600, Tom Lendacky wrote:
>On 2/28/25 11:07, Stefano Garzarella wrote:
>> Some devices do not support interrupts and provide a single operation
>> to send the command and receive the response on the same buffer.
>>
>> To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
>> chip's flags to get recv() to be called immediately after send() in
>> tpm_try_transmit().
>>
>> Instead of abusing TPM_CHIP_FLAG_IRQ, introduce a new callback
>> send_recv(). If that callback is defined, it is called in
>> tpm_try_transmit() to send the command and receive the response on
>> the same buffer in a single call.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/linux/tpm.h              | 2 ++
>>  drivers/char/tpm/tpm-interface.c | 8 +++++++-
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 20a40ade8030..2ede8e0592d3 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -88,6 +88,8 @@ struct tpm_class_ops {
>>  	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
>>  	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
>>  	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
>> +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
>> +			 size_t to_send);
>>  	void (*cancel) (struct tpm_chip *chip);
>>  	u8 (*status) (struct tpm_chip *chip);
>>  	void (*update_timeouts)(struct tpm_chip *chip,
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index b1daa0d7b341..4f92b0477696 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -82,6 +82,9 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>  		return -E2BIG;
>>  	}
>>
>> +	if (chip->ops->send_recv)
>> +		goto out_recv;
>
>It might look a bit cleaner if you issue the send_recv() call here and
>then jump to a new label after the recv() call just before 'len' is checked.

Yep, I see, I was undecided to avoid adding a new label and just have 
out_recv which in future cases always handles the send_recv() case.
But maybe I overthought, I will do as you suggest.

Thanks,
Stefano

>
>Thanks,
>Tom
>
>> +
>>  	rc = chip->ops->send(chip, buf, count);
>>  	if (rc < 0) {
>>  		if (rc != -EPIPE)
>> @@ -123,7 +126,10 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>>  	return -ETIME;
>>
>>  out_recv:
>> -	len = chip->ops->recv(chip, buf, bufsiz);
>> +	if (chip->ops->send_recv)
>> +		len = chip->ops->send_recv(chip, buf, bufsiz, count);
>> +	else
>> +		len = chip->ops->recv(chip, buf, bufsiz);
>>  	if (len < 0) {
>>  		rc = len;
>>  		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
>


