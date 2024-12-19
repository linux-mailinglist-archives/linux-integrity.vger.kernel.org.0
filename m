Return-Path: <linux-integrity+bounces-4419-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4D9F7E2B
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 16:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809251641F2
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D81522616F;
	Thu, 19 Dec 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oxj8yT2+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E214AD17
	for <linux-integrity@vger.kernel.org>; Thu, 19 Dec 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622556; cv=none; b=r/zahPGi4c3T9Sf1xFiLNP2W+ciFX0wWUgVns5pmazMiWcleQYuYfR9plMD2Ez+b1Y4JnKV41+gfilHTWq4jF0VsCNlZ4sWsehGdSoQWK4Vk7c6xnvNCmpVzY4nGQRXFFfogmHh/WZ9mTEeTzu2W2lhPsSgwgGovZFzRGVb2+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622556; c=relaxed/simple;
	bh=UHleueck9CKLJf8SAKd40mLejhBOJXBHztTRdmvdD7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuurWkvIsfRNTWb9peTYVV9zuW/r+ERsV/vrMU1w6XaiGcJbZYouU+b0aJ07rVTcOkkPCe4ZX3ifqIw07ja9nOPveHz1Z6P90rtGthy0tn1XoiwExFeEQvjoY1WK+cYX3w0C7n3U+DbwUrn6Bu5SUlN4Cb7oay59sFJQ9bu/Am8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oxj8yT2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734622553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=okQ1fdfaEip08JNQz75y5j89eYX/clZZBcTctSXfink=;
	b=Oxj8yT2+vkQ6nSZMyBc6D2QKqr3YS8R4099pMoqNBVQSu29ngrKIRXfFTiR1eeAoJjDFpk
	tXc+ffCjxFLwPiREp3fANegzdRFFJTsoqDRoouwUhY+pBGtvjCyYG86tZqByuR1MMj6oaf
	y3StTRddkmuzCWQACmC9KUJ6Oc7f3rc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-m2jCYpFdPyGYiW_7z0Rq8w-1; Thu, 19 Dec 2024 10:35:52 -0500
X-MC-Unique: m2jCYpFdPyGYiW_7z0Rq8w-1
X-Mimecast-MFC-AGG-ID: m2jCYpFdPyGYiW_7z0Rq8w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43646b453bcso5735925e9.3
        for <linux-integrity@vger.kernel.org>; Thu, 19 Dec 2024 07:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622551; x=1735227351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okQ1fdfaEip08JNQz75y5j89eYX/clZZBcTctSXfink=;
        b=Wsq/qYxHoEqD+lfZZKMMfelDUOzI4/lg3ogQtEOEU2PCtmNZwyPvSjD31IWjGt+paS
         53p8liHcWj1oxDrv0anfmNuW2uxdigsoOuNKk2TLbYWBtKvvh3H/FNef46Zc4jfOukT3
         oQETyXUKkLhHqbzXJQAsHz2n80NZmcIiFV3vMyTAceJ2M1YVb7gFTA8BNCLcNpgxqF7I
         lJ/Ia9aAGKOoYZ5KeqVpRMuBG8tBrHQD62vMzDWmZjL4xUc698jnL89y8Uwsl4QtwnqF
         7e8JlSAaxqQFc4pgeOdN5fQkB0YHzplzvm44EeAQE0QSNuXfBvOwJ+m+i1Xb6V5Ig+Gb
         IaDA==
X-Forwarded-Encrypted: i=1; AJvYcCXJIVOERiHtDkJoOuwf/+uSZYkn7Ox09I7s1pZIH2QSgpGptUqhWqsAPO616I/I17KKfxff+VxERtI/ZQVz1c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVOknzXSgKm3L4/HogdK1wdLhaHuDS18XA1p923dEyno6oOCP
	LAvMZsLxZhuG+sUGXKB24POieVDWhRfCGP6tyL+CJnkv27CILkJrabx7MiW+bhp1T+8wFel9kq2
	ltaMLRRpg16jvFJ4Mo/VcaejjP49uvHTo9SPn7clLHpyelaN7ZCOJnK81bs03j+rHHg==
X-Gm-Gg: ASbGncs0P7k2DaIUd4APvKC/jnXgL2JXYRPeOL97BIT/JaiBVr1w4XRTzILjF3V2eSa
	wtPOwl42sRvQ2ZFc49jOh/TFEA6oilK6XiXUEVHG825Y25Z4m6sClssf/3KrnDMnSP9Lfa7qeRi
	1tGdc/FWxOi9htAX3kZsJMdRhPRJpvk/ATOBf0U0SSZjqMEalCNx9OThr1rEwv0A29wuecnDIfe
	oBnOyWaG4Y510PiYIfkPFiEWdgXxU501vAGkrrzXvrTkbqAXCZRGTDnlM6PPay1mVv4O+uF/2Ju
	DDJhbQVxRcYVi0+05aCDumRwjBkIHuza
X-Received: by 2002:a5d:64a3:0:b0:388:da2a:e48 with SMTP id ffacd0b85a97d-38a19ae7e68mr3863683f8f.23.1734622551228;
        Thu, 19 Dec 2024 07:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFamfbO9O2OJ9k/OnSfDep3NgEc1R0xrHmelVQ4sUSvht3jKmfVB25GlkMf9i6C8wcOxd+tQ==
X-Received: by 2002:a5d:64a3:0:b0:388:da2a:e48 with SMTP id ffacd0b85a97d-38a19ae7e68mr3863644f8f.23.1734622550548;
        Thu, 19 Dec 2024 07:35:50 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828f5fsm1835619f8f.8.2024.12.19.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:35:47 -0800 (PST)
Date: Thu, 19 Dec 2024 16:35:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
	James Bottomley <james.bottomley@hansenpartnership.com>
Cc: linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211150048.GJ1888283@ziepe.ca>

On Wed, 11 Dec 2024 at 16:00, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Dec 11, 2024 at 09:19:04AM +0100, Stefano Garzarella wrote:
>
> > > After that, there is no meaningful shared code here, and maybe the
> > > TPM_CHIP_FLAG_IRQ hack can be avoided too.
> >
> > IIUC you are proposing the following steps:
> > - extend tpm_class_ops to add a new send_recv() op and use it in
> > tpm_try_transmit()
>
> Yes, that seems to be the majority of your shared code.
>
> > - call the code in tpm_platform_probe() directly in sev
>
> Yes

I tried this, it's not bad, but I have a problem that I'm not sure how 
to solve. Basically, the functions used in tpm_platform_probe() (e.g. 
tpmm_chip_alloc, tpm2_probe, tpm_chip_register) are all defined in 
drivers/char/tpm/tpm.h
And in fact all users are in drivers/char/tpm.

So to use them directly in sev, we would have to move these definitions 
into include/linux/tpm.h or some other file in inlcude/. Is this 
acceptable for TPM maintainers?

Otherwise we need an intermediate module in drivers/char/tpm. Here we 
have 2 options:
1. continue as James did by creating a platform_device.
2. or we could avoid this by just exposing a registration API invoked by 
sev to specify the send_recv() callback to use. I mean something like 
renaming tpm_platform_probe() in tpm_platform_register(), and call it in 
snp_init_platform_device().

WDYT?

Thanks,
Stefano


