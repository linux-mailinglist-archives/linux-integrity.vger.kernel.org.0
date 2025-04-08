Return-Path: <linux-integrity+bounces-5664-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5B4A7FF11
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 13:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C815C3AE845
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF2264FB6;
	Tue,  8 Apr 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS0DV42e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7366267F5F
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110527; cv=none; b=XRyRZIT98yA8UKrKSrxeUzBNUzm/bK3Ohw9Fgxn92247fmKYqZ222zbnNfPpsX4T35Wl14yVJSUt86xuZW8/AE2vBWxbWcM1TLY+6fVtk1a1wJ9P4lgcIw7fp2TgVo65hRHreFmILFG70UfnLak5DkylBbyjpHPWzX8s+fxMEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110527; c=relaxed/simple;
	bh=pNXa2XEAZKwmP0PbFXg1zjrzFXFnWgnsxFsJ8P7Mpk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAM7G6HOFskMPpG2Tt0+WO3v+cvVUjPhf0bjT6e0zcPiaggStRze2po6jUddOwjrSmR4zQrdcJR6LKdZljrPncUv1m2hPcBixNMiDKLLePkuiFcdDGte1hHqgPjCPM4G59/HPf1cvk8ZfkYEsUGejjQw0uCYJ4MHmjz1bVOXPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VS0DV42e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744110524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiWKsYWjlXVdW0Vl66KeGe+yfVSaUjilRJLGAs2qAqY=;
	b=VS0DV42eGfm7pCS+Gqk7f4J0wMO9jYZxVlUCF3jl8Kpamsj8eBNoAXsLC5r0+tN3gLpKp1
	vbDPlzLebci3u5UETGJdzHs4vdSGKNvzFgmLXED+iSFFMU38VBRwZ6PAR8l2saW3Fh/1j9
	GmBB+9pco4u45Hkyx4soCOLv9JxglEU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-VKqfR9kiPLqRs7bAwcoc-Q-1; Tue, 08 Apr 2025 07:08:43 -0400
X-MC-Unique: VKqfR9kiPLqRs7bAwcoc-Q-1
X-Mimecast-MFC-AGG-ID: VKqfR9kiPLqRs7bAwcoc-Q_1744110522
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so45936245e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 08 Apr 2025 04:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744110522; x=1744715322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiWKsYWjlXVdW0Vl66KeGe+yfVSaUjilRJLGAs2qAqY=;
        b=UX80gDmjCaoZCwjLFcNPS+YSGP3HXDT9G+pofd/6cGaVnOs2m4hjv/tqY3msfphhuv
         IUyQu/vPFQtqYzFdRzPxbsAA3USzOLH1OeiyMgXxKACFrORROduo+YgbQ5LtiurlhN4R
         +O+xykEq+hYdV4u60uzcEEpkxgvX+B8D96CqIQK8iZ4Oyw4ZITnhbWmWXLJdP6GbIJ1d
         vrBNnpOGMpZUYK1v5oWlB/i52fzqGoUIIbpfnDSvR9+SeJhrCyKZ5hriOzbHF11TFNJ6
         +L5JP/+piR7z133AAZ98SnGqNDzgUFNSjPzwZbJqX7lKSci4j2z+HQoLMFsFcdSGrO1q
         mOLg==
X-Forwarded-Encrypted: i=1; AJvYcCWA7RuImNNja585kDvJsZpx5lMiASjm4XHQoZ1StEjL4QzhvfxAsOMkhBDDBc9opbQRN64amCCN9l5EOdcRSnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeA2mwxU1W9XmiDwJISM+xLeHUqo9nqu3Dix7W8z/GHomjVqr
	ojHkc0dfOLyMzbQhJRIFd/PneHTDqSS8WVUSm1t1eOKSnjeidV4K0+OOeNYV2owOd3a5yXhc6Tx
	mPIZv+TOJqIoA7zu1PVAPzrfuT6pp3/KUyKIzUxF9ijTk0ywz45C8/eJtECv1XaEGnA==
X-Gm-Gg: ASbGncuJtw0XOAOcwOU5pGUKKfWBNE38kB4KkrDqpbI1MYxVkzEjGBPCBXxvtwAmQAf
	Mr0c+Y2hWJnw+S6vyFaa6/XrX8k73eFXPqGnqZRKdAoF6dW+AID2rA94CtU6UwiTFpOiqESiA0q
	HpIIkZJlHTanvuTUvVsN5lEu/oanCN1H4amlD4bKOt5NW9fk1TT7v2CLynhlz8PeckpSATlQ4oW
	4uLvTSYY6OH/72yfkFevvbM4VnyxdKM7xzcsJxccPHbECeLuyWRdyzORVWia7KZ9vKxiE9+DDDP
	0b65ByPSlP+iIC8XGkHQ2jCEKCMLuob/qA3bNt09SqfSMoOsAmVs56Gr2QZ7a8Al
X-Received: by 2002:a05:600c:1c17:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43ee063fbc7mr118525105e9.8.1744110522184;
        Tue, 08 Apr 2025 04:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWienIwYQBLsRDfxpLTrW6mxw6sjcpGYF27rjIKiWUTsuRHwg0Muagv8RixgT6kwQsR+HJNg==
X-Received: by 2002:a05:600c:1c17:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43ee063fbc7mr118524765e9.8.1744110521621;
        Tue, 08 Apr 2025 04:08:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1f27a55sm160617895e9.2.2025.04.08.04.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:08:40 -0700 (PDT)
Date: Tue, 8 Apr 2025 13:08:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, Dionna Glaze <dionnaglaze@google.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>

On Tue, Apr 08, 2025 at 01:00:12PM +0200, Borislav Petkov wrote:
>On Thu, Apr 03, 2025 at 12:09:42PM +0200, Stefano Garzarella wrote:
>> @@ -2697,6 +2702,9 @@ static int __init snp_init_platform_device(void)
>>  	if (platform_device_register(&sev_guest_device))
>>  		return -ENODEV;
>>
>> +	if (platform_device_register(&tpm_svsm_device))
>> +		return -ENODEV;
>
>So I don't understand the design here:
>
>You've exported the probe function - snp_svsm_vtpm_probe() - and you're
>calling it in tpm_svsm_probe().
>
>So why aren't you registering the platform device there too but are doing this
>unconditional strange thing here?

We discussed a bit on v3, but I'm open to change it:
https://lore.kernel.org/linux-integrity/nrn4ur66lz2ocbkkjl2bgiex3xbp552szerfhalsaefunqxf7p@ki7xf66zrf6u/

  I tried to keep the logic of whether or not the driver is needed all in 
  the tpm_svsm_probe()/snp_svsm_vtpm_probe() (where I check for SVSM).
  If you prefer to move some pieces here, though, I'm open.

Thanks,
Stefano


