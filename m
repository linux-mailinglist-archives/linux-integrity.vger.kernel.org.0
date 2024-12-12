Return-Path: <linux-integrity+bounces-4367-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B6F9EEC35
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E203168971
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA92210DE;
	Thu, 12 Dec 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4NSWmMV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61421B8E1
	for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017418; cv=none; b=WDzSHnJCrRofOdIDu/bzl619ZyxhZYDbjkXqY41NMnjGHzG2bEJu3TvDgszb6zKS9jASz+0eSGtqu0jZyidWMlqT+VXVGyYI+npblmYys11WKjqK6ZXwSfEdBJEnsNp4TVgGBP70OtV7kU4e+JUgcRIozVMDoA9kR03ayhQ+4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017418; c=relaxed/simple;
	bh=O5ahhxuiUloPACS05gzUNOEWN3T1mok3ANYk7EW/OLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os/DVBXuu9QPuh3udZMKDGwWzLgqOMq4m+Rqz+uBOJpBPxXgJ0qUT205O9aVCZOH3djXOpMpQu/7eH+VJskkMyG9d+dh0tADAq4Oq7QGUuyRCoAlnfKmLd3PEVTRrzJpLNynLVtSHmMOk36GPFE8mp7h8OKtOInPBiW0WPa1QDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4NSWmMV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734017416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNvPlu3/tbTEKcryDTMAGFOHz4wBWW7XP10awKbwl0c=;
	b=M4NSWmMVcP+Qy6LmeNdC5u01qwFD13jFUNXX+CFYfxn2fjw+uG1H2Ozrge/eBr8PRJMuWH
	k/V9kcup/wt11QFZ/wV/DGIBiBAl1R+PV7n1RhMm9ld55DqeRdYwUa8riKhS4GCsoOZ5wW
	WcBcjpUSrm4kUGgCwHU0AEs5RDG0aK8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-JmZWvK2EPaq9p6ySfBm95Q-1; Thu, 12 Dec 2024 10:30:14 -0500
X-MC-Unique: JmZWvK2EPaq9p6ySfBm95Q-1
X-Mimecast-MFC-AGG-ID: JmZWvK2EPaq9p6ySfBm95Q
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46799aa9755so19836611cf.0
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 07:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734017414; x=1734622214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNvPlu3/tbTEKcryDTMAGFOHz4wBWW7XP10awKbwl0c=;
        b=MjmFkxVNv2OSxpauCNRiYYsTT+p+FoGk3knY10Q2kz4AOP3eLVNsO0QHeDuD8cGvS+
         WbjDrk0J9PqFhRbBplqbtl7NL/0tSwSh45Hs9uCf3DGEfmmRLJ4IgiBjMQy2KERNRb4b
         GN9BYKBx6K+KYlLITK8OrGIdrLXAuSQ2Fmc3FAOa04dh8a2yxjT5zmgZQ172YrqDTPrn
         uejK01ay3OSJbpeXtWmrAhy8onXf1dcvyKFgPqbqJDTLoZmRE/N7nmXrAQf6GPu8hEpL
         7zVzv9dNmgXNZVJ8Sq4UdLV0GG55O1qpQ4Ye5IcOlhfiVUc7EskPxyiPmtT8MfGjcwoE
         dSsA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Qzrqv5Qmp7+v6WgEGYCdYND1ctjIntWVEYZmP3kY6c9UHPLUU5AXBkV0BF0aBzDFbBxWw6zo2PabfMxjijQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrjf/JHKTNMpaEl5jExF00jo8upOUHkZMqs79Pgo7YzYcK6q1
	I8Bq71pc5g37iEDkSY4us4EniHXZNl9UeQDyB3Ce2b7/irMOh7FYbJ4TljQfTm71zDv2UuQuBGb
	kFX/QVD5NccRN7iYsGD6dhdcykLRpWWaJKdXanCO6C0iQGMSARZsSVaWBRUbq3Cur3w==
X-Gm-Gg: ASbGncshr+4xVuGcCCWaDTDk3XlFlWdoteY8rJk7NZm/AAOcsCprxJ/wriJCHpVDcWY
	odKV1+9A6SKP5D94IcNTCpmn7apF3tFrX7piMGn/pq29LHmObtOEFOix6+mViiswIDvj++czUji
	5JI7Ab8I9X6AHuYIB25+baeeVO12EuUm6Y7BgqzpAj7nM4XHFA4b2umTMKtmIpNT5c5YitBjP6G
	7XPgrmI45pv9kso5UlaCoLbNV3EGHJ/7TVEu8cHmnqC3V+kt34F4AIhA8FtcFouyGJYDJUCHi/L
	icvJcAtppg6GtMtoGb6LiyqXMQDAZmKj
X-Received: by 2002:a05:622a:109:b0:466:954e:a89f with SMTP id d75a77b69052e-467a15c5d85mr9981471cf.14.1734017413999;
        Thu, 12 Dec 2024 07:30:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUqrMzHnYDqYzGLOnDSNbK6UCDbQs0xhbgvHxu32yCmWJ3ltiMe4gnLZlEysVazYeVy4rzFA==
X-Received: by 2002:a05:622a:109:b0:466:954e:a89f with SMTP id d75a77b69052e-467a15c5d85mr9980721cf.14.1734017413364;
        Thu, 12 Dec 2024 07:30:13 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4679748dac4sm10045351cf.22.2024.12.12.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:30:12 -0800 (PST)
Date: Thu, 12 Dec 2024 16:30:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dov Murik <dovmurik@linux.ibm.com>, 
	Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 1/3] tpm: add generic platform device
Message-ID: <cnq6nzhvrsas6ud7t4woybktpesepm7a3sq5sd5yldq4hr5kyl@ezm4xi3o7eax>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-2-sgarzare@redhat.com>
 <zzi3fvbo2rnb2d76soseuekwaqe22ifnrhhjplqhvw6x26lbb4@nmcqylrenzyj>
 <b92113a11f121dc4d485b5ba522c8c8c0781d1be.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b92113a11f121dc4d485b5ba522c8c8c0781d1be.camel@HansenPartnership.com>

On Thu, Dec 12, 2024 at 09:35:46AM -0500, James Bottomley wrote:
>On Thu, 2024-12-12 at 10:51 +0100, Stefano Garzarella wrote:
>> On Tue, Dec 10, 2024 at 03:34:21PM +0100, Stefano Garzarella wrote:
>[...]
>> > +static int tpm_platform_recv(struct tpm_chip *chip, u8 *buf,
>> > size_t len)
>> > +{
>> > +       struct tpm_resp *resp = (struct tpm_resp *)buffer;
>> > +
>> > +       if (resp->size < 0)
>> > +               return resp->size;
>>
>> While reviewing Oliver's work for the driver in edk2[1], I noticed
>> that
>> there wasn't this check and asked to add it, but talking to him and
>> looking in the code/spec, we realized that it's strange that
>> tpm_resp.size field is signed.
>>
>>  From SVSM spec it looks like it can't be negative:
>>
>>      Table 17: TPM_SEND_COMMAND Response Structure
>>
>>      Byte     Size        Meaning
>>      Offset   (Bytes)
>>      0x000    4           Response size (in bytes)
>>      0x004    Variable    Variable Response
>>
>> And also Coconut SVSM remap it to the `responseSize` of the TCG TPM
>> implementation which is unsigned:
>>
>>      LIB_EXPORT void _plat__RunCommand(
>>          uint32_t        requestSize,   // IN: command buffer size
>>          unsigned char*  request,       // IN: command buffer
>>          uint32_t*       responseSize,  // IN/OUT: response buffer
>> size
>>          unsigned char** response       // IN/OUT: response buffer
>>      )
>>
>> @James, @Claudio, @Tom, should we use u32 for tpm_resp.size?
>
>The original idea was to allow the protocol to return an error (like
>out of memory or something) before the command ever got to the TPM
>rather than having to wrap it up in a TPM error.  However, that's done
>in the actual return from the SVSM call, which the sendrecv routine
>checks, so I agree this can be removed and a u32 done for the length.

Thanks for the details!
I'll fix it in v2 and put a comment also in the edk2 PR.

>Dov did recommend we should check the returned length against the
>maximum allowable:
>
>https://lore.kernel.org/linux-coco/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/

I added in this version the check he suggested:

	if (resp->size > TPM_PLATFORM_MAX_BUFFER - sizeof(*resp))
		return -EINVAL;  // Invalid response from the platform TPM

Were you referring to that?

Thanks,
Stefano


