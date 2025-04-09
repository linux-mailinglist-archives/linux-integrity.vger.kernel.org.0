Return-Path: <linux-integrity+bounces-5685-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4557CA82280
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 12:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B7A4A7465
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EF625D906;
	Wed,  9 Apr 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faOg85dN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E545252905
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195398; cv=none; b=b3a5u+ud1mWuKNIj0ACE6SME63ghGfglwny69Vg/mmPgBUzH4kFdgsxx7OIb3amI3o9GykOYQl7xzwCfB1F+k3oX/BL1Li1a+Uz3MvLbngiRZV84VAXM9FS+7RuTqbyChKoB0GPqKMYgMw1hUliRhL5S/uEPKg0EnFoZQu4tqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195398; c=relaxed/simple;
	bh=A/FlqmaIzcO4c8nAuBHIloGWE3rDWwPZOR27kQ1vVdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5cJayqbBGMun7uEbl+w9fi9OrJzQOoCKx0q0/w8wuy/QTKcFvOBXTnTHnVlJFVXYlq8FXNm098NtIA1dPCHaxZHdxium9WOtoRvEsII3VXJE+DWQCIA709Tlz7os9RQN+99WsTVhT1k9Sn7I9WYJMrEbPU+re+ITCMreyEXyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faOg85dN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744195395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnfObN/lFf683o8WuLfplJQb1/cYuQGkU+V1Bcc+zTA=;
	b=faOg85dNB73UyyYuViZ5JaBU2Z5/JC4V1aLvF2hI6jgsxqbeAjWF/q6bDFwSJkETQoJ9eJ
	44pRSgJPynh7bAAHYYr0RhX7muoQwgWQfEfWAEd+Db83RD6WyBuKFLjR4IoZg/Z+zlKsnN
	C1gT7BPCJlQHkpdeRroEXwAkqUgEuwA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-EwiBTdqjMO-l1YzT86PxqQ-1; Wed, 09 Apr 2025 06:43:14 -0400
X-MC-Unique: EwiBTdqjMO-l1YzT86PxqQ-1
X-Mimecast-MFC-AGG-ID: EwiBTdqjMO-l1YzT86PxqQ_1744195393
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e643fea7fd8so863375276.1
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 03:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195393; x=1744800193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnfObN/lFf683o8WuLfplJQb1/cYuQGkU+V1Bcc+zTA=;
        b=wCIe1p6fTt9C5SRJp+4CZAWsv+CaFXDH1YN155AJ+gJafOlu9OGAWgIF154tebn1hI
         VBykfkpkXfi8MoY9+/APlQrsZbyAqwnkwrZffuvHJ0e3CJPaN8GPNgyuHDsvG6+3OEJ5
         +CfaZfw9Rrp2tWZkZpycZp0VTghbEmD/tlnV8UQ4EG834JBHWL5bZD95NG2JCfw6q+ME
         hBeQjPIQXPF3GIkpw++4hvMxBvbXLZuEFuw6qpqgPfmoVeWLTToWq1Oaiw2DGDqL+qBF
         XK7IaFqDpvpuY/nMIJHtm97539U19DZN96Qlguh/FvdZO2fEzuZiuSkwGDBgaaA3iPfj
         8XQg==
X-Forwarded-Encrypted: i=1; AJvYcCXhqACdxvYVl6mwD/eB+qkX2SLqSQ1Wc5fY1yvHVdiJPx4eZndFu5cs4FZNX31e4nnTDs33Knyv116SkAGw+kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHFpN+Y8AuZR5+hAwjDFGDdCf/fVGwsEmdCodchwHH3c9Wo64
	D7oxRgzqldR6UkqjFMJg68V/MoHOqJi7+OCB+SnXaDgE1zff7gnjXmVOWtSRaQSzVo0E/EiHg1W
	LxPUfu2iVWWxVQCxP/t4q9PEd3ut8iaRL4/l5ADD8p8am5C4H9vjuUVajTVx9jKy+R8lTjz5vG3
	v1ay9tLjSFlnjBxNWW0Xuf6QvvbKe9C4Tdv/O7g2rS
X-Gm-Gg: ASbGncsMEYIaHO9Py4ok1oS8ubKD4fpwjmN2yYvZEgiuGCdMWIMAbf4AoyWNW/0u0pL
	MDOlviQPcJ2CxzrqQA4ZzyA4SWLB9pCYYmEMoe2IMiW/rxN2vHU3OOSwkbCZLFGaok+8=
X-Received: by 2002:a05:6902:2487:b0:e61:142a:82b1 with SMTP id 3f1490d57ef6-e6e5da76d6dmr11417304276.16.1744195393474;
        Wed, 09 Apr 2025 03:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9XLCSiAWV0l0Xyy3erc/2RwiuGpJfzHLbxLJRgI2MfphnLTk5GZMmDYdIvEsBTniIkRBZyC9Yc3m0F9mrx/U=
X-Received: by 2002:a05:6902:2487:b0:e61:142a:82b1 with SMTP id
 3f1490d57ef6-e6e5da76d6dmr11417256276.16.1744195393057; Wed, 09 Apr 2025
 03:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403100943.120738-1-sgarzare@redhat.com> <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local> <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
 <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local> <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>
 <20250409102120.GCZ_ZKIJw9WkXpTz4u@fat_crate.local>
In-Reply-To: <20250409102120.GCZ_ZKIJw9WkXpTz4u@fat_crate.local>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Apr 2025 12:43:01 +0200
X-Gm-Features: ATxdqUEEmadHBgiIuGJgxnDt-QGQF_QGugtY5XSP7f88rY67_2s-xBx1Kyl3594
Message-ID: <CAGxU2F7r_fWgr2YRmCvh2iQ1vPg30f-+W6FXyuidbakZkwhw2w@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
To: Borislav Petkov <bp@alien8.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, Dionna Glaze <dionnaglaze@google.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 12:21, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 08, 2025 at 01:54:07PM +0200, Stefano Garzarella wrote:
> > I see, so IIUC I can just apply the following change to this patch and avoid
> > to export snp_svsm_vtpm_probe() at all, right?
> >
> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > index acbd9bc526b1..fa83e6c7f990 100644
> > --- a/arch/x86/coco/sev/core.c
> > +++ b/arch/x86/coco/sev/core.c
> > @@ -2702,8 +2702,10 @@ static int __init snp_init_platform_device(void)
> >         if (platform_device_register(&sev_guest_device))
> >                 return -ENODEV;
> > -       if (platform_device_register(&tpm_svsm_device))
> > -               return -ENODEV;
> > +       if (snp_svsm_vtpm_probe()) {
> > +               if (platform_device_register(&tpm_svsm_device))
> > +                       return -ENODEV;
> > +       }
> >         pr_info("SNP guest platform device initialized.\n");
> >         return 0;
>
> No, this should go in tpm_svsm_probe().

Sorry, maybe I missed something.

tpm_svsm.c registers the driver with module_platform_driver_probe().

Someone (the platform I guess) has to register the device by calling
platform_device_register(), as we already do for example for
sev_guest.

If we move platform_device_register() to tpm_svsm_probe() how will the
probe be invoked?

Thanks,
Stefano


