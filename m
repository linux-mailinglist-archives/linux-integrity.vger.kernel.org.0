Return-Path: <linux-integrity+bounces-5309-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BDA671AB
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 11:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C724516C4AC
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE030EAC6;
	Tue, 18 Mar 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjN8a3/H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA12080DB
	for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294656; cv=none; b=avt2w/rq5XwvCtYqCqSy0EgWt4n7TYr9AH/w87kk48B9qYobO6mzps1tFWLBj0z+i1E7++pzb7+qnhZZWnCp/IK4wIka+7a5eNoRg0LsS1A+P1j8Af5vxO1xyIUCKl6ZjmUyz4zAsB+1ESAWkQhFTgCpCpKfVGHuvnryDKEZIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294656; c=relaxed/simple;
	bh=JjVwiG6JTed8Funsj+Yghz5UOx9ruQQVenphykw5+t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVjFNy5VVH9jf2+IOWNdWh/kB9it+RR3zl1dAocvZGdn0BoXG+fqSgKr3u0VprcrwwCeHwt71asY4plSd9oMy81zDdGQyn1hohojHFjEPliT0gabhpf5jWttZiw93LMn+PVjfRia05Wfu06W+kwlsq7PObd6i/ZNmdepiuM2JZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjN8a3/H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742294653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vODclRtlESq833QiRMA2SC9kn8teAEC7lQk1RJgpb+0=;
	b=OjN8a3/HANNEiM/9OAI//AWsEA9Nxfjw1NofTPnlKeD9LMu/9NvLQDODSiTAaFTyZyZkT2
	HGa6Kt56lVScAGA3LNE4DI12eTG6arg0WJGElszC2q6zpalnvLyDordUa+y4rWYPzjc0SM
	i2c/wExXwtqY0gRnPc8G2ZDwgEcegWs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-w4HsB1ALO0SZrAEajHgjkA-1; Tue, 18 Mar 2025 06:44:12 -0400
X-MC-Unique: w4HsB1ALO0SZrAEajHgjkA-1
X-Mimecast-MFC-AGG-ID: w4HsB1ALO0SZrAEajHgjkA_1742294652
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so27137395e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 03:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294651; x=1742899451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vODclRtlESq833QiRMA2SC9kn8teAEC7lQk1RJgpb+0=;
        b=qxIGjwl6PyjHJ/51hqsolOP2ryJ5/ahop09G5wP9oBVWkJAMl84gas+w2vhaVJ9Iwg
         IM67XUuz/5p6/YjhkjRmjqQarVTwQYn9k5u3ugSspwIfKdmGLHQL68zg/HV0YvC2dsVL
         yfDZO/9r29oy2+xS0XQXP++r61JkrCQqaJvDepCooEguQOfg2NPx2BV+kOrV2yLf1KMx
         HlMDOKGyyRvxYzMFREpEUFfWXsQZsNZDasFsGWRbhRzlAfK5NHpOJ0kmW/W0xkcb3c61
         kOLz+/6BQ8ArlcnI9uQDA1MbSSuw1EmYR+/k/STdOZISpAGM0KaRIGD0sPoOcPfMN9wR
         1rNw==
X-Forwarded-Encrypted: i=1; AJvYcCV1xYaSYo1bugKkFoSF4QvaCDl7cDFbQsJl1ImFekDnequPAaVdT/cxYJYH8ujwQK5PUpRhlQS+OVPVVdYZGZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR69b8Y/aNsfkopRMZweynafv9RrgFVR7RyGytGfxGe7QE1X0h
	6kLDkXXjLS2RcKt47blV7C6ZJdqHOyq3t3vqxQnLYTjmHW+kWaVaG3r8jpY/Zu+WhdVJ4yMSShO
	bepPl6Ektpq1kHkuriAk9GAreL9+j+g+n/Tu7gCNt01f0K4ePxt8E2+Bgeny5ecjZrA==
X-Gm-Gg: ASbGncujUreqfohY6zeS/DJbw0Swx31PVvJhq/fucjiowG7npSPlSLf8NamKrelOZVU
	eF2ia4jZqkkzsE2VgG4g5YsxbqrtCPRdwmCcACyQKMQohvmK2FVPlUAzOqYnuCMbgBpY0iWhFdN
	w/M7x451s3lWEhIscPd7T6VDXlGF2fDTyz2mpPc0TkWJAmoGaM6Y+QYQ/ram/999WwAZu55pRcd
	Qk375/ZiZivLX/ia1xbfGQQnZJqt22pAH+F/Pf46WJG84UwrJNkjYhkE6Fq1DgnQ/Xg0bE79rap
	+a5gPyFiV1E070JpvgAv197RG5ENrksCnILdBTQjVN1bT6EA23DlCcXmkTbbD9y4
X-Received: by 2002:a05:600c:3d14:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43d3b9b5537mr20194575e9.15.1742294651436;
        Tue, 18 Mar 2025 03:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc40ALDk8HYZeNcIG4ZWmui1bzdkvrY09zY+lTByGVYf7UuCwtqoNcke3O+q2K99biFiE4lQ==
X-Received: by 2002:a05:600c:3d14:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43d3b9b5537mr20194255e9.15.1742294650956;
        Tue, 18 Mar 2025 03:44:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm130776845e9.26.2025.03.18.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:44:10 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:44:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	x86@kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <nrn4ur66lz2ocbkkjl2bgiex3xbp552szerfhalsaefunqxf7p@ki7xf66zrf6u>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-5-sgarzare@redhat.com>
 <7c35f370-f1f2-7100-3b78-b595e977e964@amd.com>
 <Z9gk0jg1JLZY4Fk9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9gk0jg1JLZY4Fk9@kernel.org>

On Mon, Mar 17, 2025 at 03:34:10PM +0200, Jarkko Sakkinen wrote:
>On Fri, Mar 14, 2025 at 11:56:31AM -0500, Tom Lendacky wrote:
>> On 3/11/25 04:42, Stefano Garzarella wrote:
>> > SNP platform can provide a vTPM device emulated by SVSM.
>> >
>> > The "tpm-svsm" device can be handled by the platform driver added
>> > by the previous commit in drivers/char/tpm/tpm_svsm.c
>> >
>> > The driver will call snp_svsm_vtpm_probe() to check if SVSM is
>> > present and if it's support the vTPM protocol.
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> >  arch/x86/coco/sev/core.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> > index 2166bdff88b7..a2383457889e 100644
>> > --- a/arch/x86/coco/sev/core.c
>> > +++ b/arch/x86/coco/sev/core.c
>> > @@ -2664,6 +2664,11 @@ static struct platform_device sev_guest_device = {
>> >  	.id		= -1,
>> >  };
>> >
>> > +static struct platform_device tpm_svsm_device = {
>> > +	.name		= "tpm-svsm",
>> > +	.id		= -1,
>> > +};
>> > +
>> >  static int __init snp_init_platform_device(void)
>> >  {
>> >  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> > @@ -2672,6 +2677,9 @@ static int __init snp_init_platform_device(void)
>> >  	if (platform_device_register(&sev_guest_device))
>> >  		return -ENODEV;
>> >
>> > +	if (platform_device_register(&tpm_svsm_device))
>> > +		return -ENODEV;
>> > +
>>
>> You could avoid registering the device if an SVSM isn't present. Not sure
>> if that is desirable or not.
>
>Is there any use for the device if an SVSM isn't present? :-)
>
>I'd judge it based on that...

I tried to keep the logic of whether or not the driver is needed all in 
the tpm_svsm_probe()/snp_svsm_vtpm_probe() (where I check for SVSM).
If you prefer to move some pieces here, though, I'm open.

Thanks,
Stefano


