Return-Path: <linux-integrity+bounces-4618-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E901A1A192
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 11:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAEC1885FFE
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7F20DD40;
	Thu, 23 Jan 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVUHpjVh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51B20D4E6
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627005; cv=none; b=DWZrlmhvkjGT+aJNBkq/kR5CEefH+sba1Z/v39aixEX2gYON+YW0VUFQZABBIxigDXsfrmVyZNNN5X9iysTYFKEp3IwUECY4Fj3s1nbcu9J+ejahIpPrMld4yM68QnYfULYCoid/4Pc98LRksqOZqn0v8kOwlhPm2yRH9z7V5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627005; c=relaxed/simple;
	bh=AZocO9qizYTYyr8iDVCWWLjYcfYMA/r+d7A6sF8T8/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8KPqa00S5BMPS76R23syerGWn1cxEHCcuGhyknYi6/sDXNTzTCz/fRvS1SejKzCozFdjasuq7k3VgyatjK8Sbe/KiyUzxQKxvwcX9QiefPlJwm14h5a2WBHzeuCZo0Ng6ULEbK25oNKIWN+26+m41dBW/AwoMvxABDiSW9D/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVUHpjVh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737627002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZocO9qizYTYyr8iDVCWWLjYcfYMA/r+d7A6sF8T8/8=;
	b=IVUHpjVhozr8Q+pNygfM/J5aXKo2nA1hUc4591CUdd4UjQNcrRfNvjZPJ/POumGfcfyWbQ
	de4Wau8Zu9CG72JQXHpHIkFnAajzbTQqggd7HZf2VE7rw+hXNhXBQDIpzh4MbzRVZTWxDQ
	06W+aTybvHH5xHTuKby5QKUNshYYGVM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-m2Be24qgM8mSPmm0IqJVQw-1; Thu, 23 Jan 2025 05:10:00 -0500
X-MC-Unique: m2Be24qgM8mSPmm0IqJVQw-1
X-Mimecast-MFC-AGG-ID: m2Be24qgM8mSPmm0IqJVQw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso70694466b.3
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 02:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737627000; x=1738231800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZocO9qizYTYyr8iDVCWWLjYcfYMA/r+d7A6sF8T8/8=;
        b=DR04yutpPl6u8LBnA/gwNH6lWw14aLc1K4GZSIfuz6QosX3wwfHLBEOcgfSaZorqIP
         D+lJzpB+Q52V9RBNV5IKdY0/lVCr2e8HbU9DNE6n//jb/05E/z61nA8pbtnIWT7VMBnv
         l0QUMBexrD9Agr+DPCwFBTmLEnHqBKpR/SruvuNHpDfnWSxwaBcyp7+kOB60BfiQNxnS
         gYjOJGhoiyq45OaBoxxe0GLy3QyHZLn6JANELCyuwHPW1h+uZNpMEX441FCAlqd9TszO
         1KOx3Y6Zxi00Nxaof0DNq2D0CUENDDuv6nVVXmOSeaPZkZLtBWiOfe5eCmJhpwdHNCUA
         QJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCURmmkrI/L5RKGGx+c+LB9+PNmh/jyag8Tee2M73MxMv4A8g3xrrpbCvHgXUa0r0O1bxEvL93W6C32xUetUvcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCyalkKdM3/W9NIFb1N7Tr08GCSLjIQ6AEx7UDJRVCmHMlCbzp
	MTGJaAXJLOtRMYu7Yl0w70FsPlMdle2e/UR/VmsmGv/3cj2y8SQfFY6enpSul/CNwcmf1S2Uwk+
	GQqj+1RsX/Ge5GqwRIHiI/wcbRa9F6P6U41vv3MWlMzRabEHUtqBX/6UKID5CnTbouA==
X-Gm-Gg: ASbGncslWNscbVK8jWQ2HGPPYZ9JgGrfe+OStleoKz/J2E88I6S46D6qpbndHDr55Me
	R2YOCdLlwqDTZid+e3pE5Hjfqeny/52bifxQZZjXxWf65lHak2kUNqK34aqrd2I3Bw0Y4OZ4LhL
	6L1R+zWyP27+CM+BgrDa2CtvhGWqT5UgzPmZKUgLrPJFo0Lif6VxZogDWSH9xzyC5pgVXhaHu2I
	fWyLxfYc4L1ZzH/Mxomzyqa30C6+UPd9PcWCmbjn6v/HNd4I1YyKA6bqxsn7+40N0nH7ssVJvSt
	dAsuuNVTnUCQACLgKic7i0iXuzuLnjy7FWDi31JyTy1bPg==
X-Received: by 2002:a05:6402:5106:b0:5d0:ced8:d22d with SMTP id 4fb4d7f45d1cf-5db7db07334mr57465639a12.22.1737626999582;
        Thu, 23 Jan 2025 02:09:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsh4qs3h5y/WITOVt8IMEEcWxABv+Wl7UIuHOkXSUtwU8XIuPaZiXvWx9dgxB+3PPt41iI+w==
X-Received: by 2002:a05:6402:5106:b0:5d0:ced8:d22d with SMTP id 4fb4d7f45d1cf-5db7db07334mr57465532a12.22.1737626998747;
        Thu, 23 Jan 2025 02:09:58 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce0f58sm1027463466b.48.2025.01.23.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:09:58 -0800 (PST)
Date: Thu, 23 Jan 2025 11:09:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <sf5zezwsokmz7lkl7fdl5z5q6lipeqd5d4sws2hpi6pznyvdap@tjfv5p5uty7y>
References: <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
 <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
 <D725TPWOVBUL.1DJAOZ0QL0RNH@kernel.org>
 <D725V628UV87.31SUEYVF9IUUC@kernel.org>
 <D726DAWHLOGW.3TR2LCJ936OG7@kernel.org>
 <CAAH4kHYy7=OZsHnOBiQug0Y__bNHt6i+bop0xaxQjpWQ6aQr1Q@mail.gmail.com>
 <D79CYAVX0LAZ.1MIYNOM6J7MMM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <D79CYAVX0LAZ.1MIYNOM6J7MMM@kernel.org>

On Thu, Jan 23, 2025 at 11:50:40AM +0200, Jarkko Sakkinen wrote:
>On Wed Jan 22, 2025 at 11:29 PM EET, Dionna Amalie Glaze wrote:
>> I can appreciate this viewpoint. It even surfaced Microsoft's fTPM
>> paper to me, which solves some interesting problems we need to solve
>> in SVSM too. So thanks for that.
>>
>> Just to clarify, you're not asking for SVSM to implement the TIS-MMIO
>> interface instead, but rather to use the fTPM stack, which could make
>> SVSM calls a TEE device operation?
>
>I don't really know what I'm asking because this is barely even a
>PoC, and I state it like this knowingly.
>
>You should make the argument, and the case for the solution. Then
>it is my turn to comment on that scheme.

I'll check if I can use fTPM, in the meantime I had started to simplify
this series, avoiding the double stack and exposing some APIs from SEV
to probe the vTPM and to send the commands. The final driver in
drivers/char/tpm would be quite simple.

But I'll try to see if reusing fTPM is a feasible way, I like the idea.

>
>That said, I would not give high odds for acceptance of a duplicate
>TPM stack succeeding.

Got it ;-)

Thanks to everyone for the helpful feedbacks!

I've been a bit messy these days and I'm in FOSDEM next week, so I hope
not to take too long for the v2.

Stefano


