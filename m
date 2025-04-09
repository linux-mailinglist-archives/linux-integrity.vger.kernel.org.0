Return-Path: <linux-integrity+bounces-5692-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBEA82CDA
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B80D440DEC
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD226FDB0;
	Wed,  9 Apr 2025 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9Er/itY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973026FA5D
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217533; cv=none; b=Cbn3+gCIjpGR+ip8SY+UhQIfo7vALc4x8ONjClop9n0FHSKeNj/WJt8pzmKP47pOV0F1L9VI2jglgKxK5eKRJWA2jv1zXm7+yzOrFvz/+IlLEmT66trc8ZwK1RjmsZZZ1L7CF+DzBZx0kDx0be2MQOQ2YigDCgKIDg/PMwZtMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217533; c=relaxed/simple;
	bh=WmdXdssA04lzq+kg5zcA/34rnB+wjGgMZjhqBx5G1j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iktmovYTjLN1AwsyWQt1Q1APeAleIznhIRL6Ys7zZOwubzjzed/BTZIK2hhdeMtIVyC2DYQ7Cmm0XyxGsXcj7a5IgRDASfEG7I7LDHUWqyiUEf8+AwnvmytDt7Qd22EIMuw3AoDcShdFIg4S0eWJI7sHFucSzQyRso47uQM46R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9Er/itY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744217529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GcJmV42DoLO51Xqo6xJgLe2Sf0B0NEZebsChSe2rsW4=;
	b=V9Er/itYJ55wAPkhhyGIHHii05CK2uq62IVbv9jc080VgKcOlIDKj/j0qOIFXCh/Thlay/
	b1BB6b7tZ3kVdF4Ldhz4ptFVBOpZfp7Tmw689DQd+IOOwLdmXBa1UaJa4DU9A+L+X9tuEe
	7q5iSiHkxi4U4elll1q+7lk2ReZJCRc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-fkDePuUEMFiBGFIkXse09g-1; Wed, 09 Apr 2025 12:52:08 -0400
X-MC-Unique: fkDePuUEMFiBGFIkXse09g-1
X-Mimecast-MFC-AGG-ID: fkDePuUEMFiBGFIkXse09g_1744217527
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6ff4d1b7490so89423497b3.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 09:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744217527; x=1744822327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcJmV42DoLO51Xqo6xJgLe2Sf0B0NEZebsChSe2rsW4=;
        b=Yh5hb/Llk10hm88sP2I+zJVWpGdCOuwis9Bw7tePCgJBMb6aX0sPwbgLyT73AyKibY
         hXAMAdZbKs72ogDuDRw51QzMp2iTp8ye0akd0aQpC2o+i77mvhQzLYx9LAWLOM1bOOmy
         Jx0YJ17uzhYCp26qwluFjBKDGgGyaf4iG89DMYBpEax3AijoUedLF1nsga4zbbPhKOQf
         K4NvT5PgYM6x8V7Ff6n9Tia9+EnpC10xHSjrCaa2JWf85WJ8wMzFbnNXIJYYhuihncG/
         Vs1e8+y5LtTgXapDF9gW1QWPu1IXwlS3vt4q10dtO5Qu/Cg0j9LIgU6b3fqgA3BJoTtX
         Aa3w==
X-Forwarded-Encrypted: i=1; AJvYcCXQUhpRcpnwx8rYb1jEdRgF1AipU9sdXc4zbgkvT30GzOiVhYi+X2qIiyk5lqdciPONK9dPvOYxIFRuLddo2TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydUnCblyKHsKSvDtJPGKuThHRXCA4ahDcEBNpLJHpaAdsgUk07
	vrJtIPIIPt/ZfZ47mESvVnDpdT8MUmi+k3KWpTUw3Wj3/7XCuy4Sl6g2gDlGHQPkOvNtrLpbVcF
	LzrJwHg/HIE7rnOFJCz+21TPK8l7Mdy1HGvgR+vc/qdO6l7urYB4szjsQXqLpa8EKdR9rAIhp7/
	WJlqxVskxmzdQyAv5Pk1DlxwGblkZMRcQhmpZg3Fd/
X-Gm-Gg: ASbGnctGtslndOzAA2Y1+9HM0fwICFTmCKgTafzTVDI8MXj8nGs7AwpfiNhfYfxfYgv
	TNmnv+h/SaE0SCL2/PGCfl8vhDdypSkq0w+dohZozVICv5ZU2iw8riCnEkHG7exgVVhM=
X-Received: by 2002:a05:690c:60c7:b0:6f8:c7e5:9dc8 with SMTP id 00721157ae682-70538813622mr55110057b3.21.1744217527683;
        Wed, 09 Apr 2025 09:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoPo+db453A3VRpl2iuqkn3Bsgq1KRMvfk6tMOx+Z2OH7fXGulE/SBM8lBhRiSM2h3KS/aGeaNttVPvceLLUM=
X-Received: by 2002:a05:690c:60c7:b0:6f8:c7e5:9dc8 with SMTP id
 00721157ae682-70538813622mr55109687b3.21.1744217527344; Wed, 09 Apr 2025
 09:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403100943.120738-1-sgarzare@redhat.com> <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local> <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
 <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local> <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>
 <20250409102120.GCZ_ZKIJw9WkXpTz4u@fat_crate.local> <CAGxU2F7r_fWgr2YRmCvh2iQ1vPg30f-+W6FXyuidbakZkwhw2w@mail.gmail.com>
 <20250409113154.GGZ_ZaqgfRrrMij_Zm@fat_crate.local> <6e5bf479-ee95-a996-5845-1f76730e2488@amd.com>
In-Reply-To: <6e5bf479-ee95-a996-5845-1f76730e2488@amd.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Apr 2025 18:51:56 +0200
X-Gm-Features: ATxdqUGEYS-HBaML_tAhrP8B1crvRL_OaCpNp5JHB_LYoxbYRpqgOrV3UZSt1ms
Message-ID: <CAGxU2F55VWoBJ92gM+Rora=+_B94PzW+DwRYjsa6=sdS+ZWLVQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-integrity@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Dionna Glaze <dionnaglaze@google.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/9/25 06:31, Borislav Petkov wrote:
> > On Wed, Apr 09, 2025 at 12:43:01PM +0200, Stefano Garzarella wrote:
> >> Sorry, maybe I missed something.
> >>
> >> tpm_svsm.c registers the driver with module_platform_driver_probe().
> >>
> >> Someone (the platform I guess) has to register the device by calling
> >> platform_device_register(), as we already do for example for
> >> sev_guest.
> >
> > Maybe that platform device thing is the wrong approach. Why does the core code
> > need to register some dummy platform device in the first place? Why can't
> > drivers/char/tpm/tpm_svsm.c probe and init without it?
>
> I think the platform device is the right approach (just like we do for the
> sev-guest driver), but I think we should only register the device if an
> SVSM is present. Then let the vTPM driver probe routine check if the SVSM
> vTPM support is present.

I see, agree.

>
> So the vTPM driver wouldn't change, just snp_init_platform_device():
>
>         if (snp_vmpl && platform_device_register(&tpm_svsm_device))

I can do if we agree on that.

>
> Looking at the message that is issued after, maybe it should read
> "devices" now.

Good catch, I'll update the pr_info() message!

Thanks,
Stefano


