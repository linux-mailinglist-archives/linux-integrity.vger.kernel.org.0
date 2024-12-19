Return-Path: <linux-integrity+bounces-4423-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E59F7EEB
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 17:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C15163794
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F639226168;
	Thu, 19 Dec 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fr8U9syg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F12218AC8
	for <linux-integrity@vger.kernel.org>; Thu, 19 Dec 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624430; cv=none; b=n01Yj6gICCn1WIKtq8AYMA6QOm1XGkZWCG5Vu468asGJPB9R4FN5NMMZL3fZyHIzq8IQsKsCApTZdtunnjRU6GX+BkQxdEsp9Df7hvjHRoLVtBtaoyF45vFgvfFdFg8H30biTUZO6wjj8GttYDxOZEPmUATLvQ2O9l5NZGTQjUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624430; c=relaxed/simple;
	bh=A0aKZ83JDldiNCQojVArEWJB/LRrGLTjJkXrVOs2jAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIMB4PGW+aGQIvAX2bMwDYvGf2Vfnco0scpn0CH+axja/tu34h2Mx3oiHAPfwsUGR40tQLm0U1Ojhbz5RTN67k1MUrcDBHCgNQFTmHMIU6MdTNSXrcByH6eSloS0igY+KTKMD0OKYMAEbvjIwbrgvpHQjLbQr9T3vt5RsFLATJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fr8U9syg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734624427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSEIOt+Dl/39K7+8+fjxrm9chDB16camj9uOLkCkitw=;
	b=fr8U9sygbpMHCor2cDQh7yDUY3lHFM8rO6mvYSMv2VwpTp0QsOJ7MwurlpWsKLuaYw1T2C
	p46F6vsEemdgO3PL8Lnct8VBwwvvXDJsAvBVhf18YdBudjuYI+moMQI/VKjtCf2QyMqoVN
	6SsDzfvktXnGHhFtNQMg6V0WM8DVVc0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-9NGrGkt6MhGvwtXy5n7w9A-1; Thu, 19 Dec 2024 11:07:06 -0500
X-MC-Unique: 9NGrGkt6MhGvwtXy5n7w9A-1
X-Mimecast-MFC-AGG-ID: 9NGrGkt6MhGvwtXy5n7w9A
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa665246a3cso80652566b.0
        for <linux-integrity@vger.kernel.org>; Thu, 19 Dec 2024 08:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734624425; x=1735229225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSEIOt+Dl/39K7+8+fjxrm9chDB16camj9uOLkCkitw=;
        b=ZskWNa5cSJ8/P3zfKwycQddk+3jKOyS6C9AS0NxpkI8IsiLmGTua308a7QUo+2/8z/
         pbjl46D1UEHriSc/guORCk53TqIA+LsVu5VBXscLDqlGIeQxgHmXaXtre4U8wxI12029
         iMO68+oh678I67xqtj8UNDtO8qy01QoF3MIW5g5BD7O4RBcX9v6aJGtzO96QVaTuo3j0
         etxgbbbmJpo5VC6YrJ9a0ZtZybgObToy3XTJ8dwuOqqZDkGBOh1QSzK3YegwQccb0dU+
         BIrWeYmWtXmMlG9VJl9v5gB3gaHBnRzAoGAHaAPlRG2Rm6/HkmhcSAiDJSkmHforUNp4
         /Rlw==
X-Forwarded-Encrypted: i=1; AJvYcCU/nT8bLs1uU2+ULVXnetXWD+p1G0Gn0xDitMzuFnAZWWjFTTHYVfRYXdLb8uq72EqGTrvTZgZTYh6WZA6H8kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkbei6Wvzjkk9FpCKs4iMGaRub8VmMWYofEbnDLRInj3O6CVxa
	rUS6JUUVAi8q/iD5JAqmTXOdrRpwOnV87TZVQBItFhoVIgiy4H3kmyJ/EEx79NGIgL/cbCCnGh1
	nZ6Yv5t3hyseGxcR/GVnIj32aRyXBYGnGU1+IjzVeSUWhDP5AOFZ2/6GEZLV7tiRFZg==
X-Gm-Gg: ASbGncsPma6v4XtdvyXWQlb3eS72gNnzCgeUugmKupXQZgDcfJNR6G3GipQdLk+dtk3
	ePmAu/745B0wssq5wuyz10xeCXP5w/uy+mFrzvwu0NyExBiY5u2x28ce4aiTIK60jtLGKcPsZrg
	gXWtbzuDq428cDzIJkZZYMDJJtyiCZeVVqJJ/tJpPLvGt573Xrer3s+rYH7KHYw/YclCZ9DXKyr
	+Mt2cdVCa0LWD6F1rVkJ8197STscLZc/47TSQMpoULV7g+jaA1xfxf+2ujFi0zFeUsTb/dpkZxp
	ISXSmsnFdYapMClafr7qIlR9Xkvpiewt
X-Received: by 2002:a17:907:728a:b0:aa6:25c6:d94f with SMTP id a640c23a62f3a-aac07952880mr326060066b.31.1734624425156;
        Thu, 19 Dec 2024 08:07:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH93jwst7HGR8fbtTFBzBd4WHWnWQ7D9jH0jl2qZrx1lTc4+74MEteF4Sm/hWaXI73/yPDyWw==
X-Received: by 2002:a17:907:728a:b0:aa6:25c6:d94f with SMTP id a640c23a62f3a-aac07952880mr326051066b.31.1734624424311;
        Thu, 19 Dec 2024 08:07:04 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae5902sm78939866b.85.2024.12.19.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 08:07:03 -0800 (PST)
Date: Thu, 19 Dec 2024 17:06:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>

On Thu, Dec 19, 2024 at 05:40:58PM +0200, Jarkko Sakkinen wrote:
>On Thu Dec 19, 2024 at 5:35 PM EET, Stefano Garzarella wrote:
>> So to use them directly in sev, we would have to move these definitions
>> into include/linux/tpm.h or some other file in inlcude/. Is this
>> acceptable for TPM maintainers?
>
>There's only me.
>
>I don't know.
>
>What you want to put to include/linux/tpm.h anyway?

At least tpmm_chip_alloc(), tpm2_probe(), and tpm_chip_register()

>I have not followed this discussion.

Let me try to summarize what we are doing: We are writing a small TPM
driver to support AMD SEV-SNP SVSM. Basically SVSM defines some sort of
hypercalls, which the guest OS can call to talk to the emulated vTPM.

In the current version of this series, based on James' RFC, we have an
intermediate module (tpm_platform) and then another small driver
(platform_device) in arch/x86/coco/sev/core.c that registers the
callback to use.

To avoid the intermediate driver (Jason correct me if I misunderstood),
we want to register the `tpm_chip` with its `tpm_class_ops` directly in
arch/x86/coco/sev/core.c where it's easy to use "SVSM calls" (i.e.
svsm_perform_call_protocol()).

And here I have this problem, so I was proposing to expose these APIs.
BTW, we do have an alternative though that I proposed in the previous 
email that might avoid this.

Thanks,
Stefano


