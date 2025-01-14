Return-Path: <linux-integrity+bounces-4540-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A808A1047F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984061695A8
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A801EE7C5;
	Tue, 14 Jan 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpvSzIX1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BF1C4617
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851371; cv=none; b=OtO9YHBvN6s9bSB6Yoo5QERv/V9QLnTacmxCF2rbxS4lY/UzGct6Z1MaNR9Yy+sB4IznUKZq9r08TPPySIq3LsqVh164yMdmFnrsZC1HWPzST5COtM1TJeFlMtaPsBElMv5ZKM9gSWoRoGuCTEyKjMwkBxQFUGgIBHougSI71j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851371; c=relaxed/simple;
	bh=XUmwUb2mpX4ZIjItpQkbXH2upcyx/o8+os3uVGGcCto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbM2VkRtuC2U+gA3klr5uxcF+mZeHNblRVMpk0TB9vkp0bfBm8s1K15s2A/qdmq80SmuzDh83X2zO9FAA9hHn1ldhk23HYnmKMO1U1vXksaw4/NsQ0eYRrrvhihQZbR/yMnUEuCsg6RFDlAcRlVdh6fPhBQs+RoSmyflnqBxfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpvSzIX1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736851368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XUmwUb2mpX4ZIjItpQkbXH2upcyx/o8+os3uVGGcCto=;
	b=DpvSzIX1TLEk4CMFxcYD6aNyc/kYW72xWu9nINa0lUBAV8fAJNuLb1CAULv+4sAB/lpo6/
	ZsQV4BklDXIPPkLqYK0DTfkLqpp6Ps673M0qO1431pu1RJ0kzncsSBwp8wNHcakTcY1Qoa
	AYDW8/YSy/Za20d+VXB1aGgGbehZPkw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-1iuHZFxFOMKoEQYtzBfuhg-1; Tue, 14 Jan 2025 05:42:47 -0500
X-MC-Unique: 1iuHZFxFOMKoEQYtzBfuhg-1
X-Mimecast-MFC-AGG-ID: 1iuHZFxFOMKoEQYtzBfuhg
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e3a1bc0c876so11608728276.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 02:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736851367; x=1737456167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUmwUb2mpX4ZIjItpQkbXH2upcyx/o8+os3uVGGcCto=;
        b=S4UhTeBrEgCYlPn/uGyk8ebgfBpjicqqhd0mDuNFC8/W1LcacevNBEQGo12UpxrVwq
         Hm+ht+AjEUoiSai2/brfgFvW3svm2jh+9OnKGuOj0IJMmUFc0Gm0g07KEp9vglMz8bqr
         wPv665bd/lupqtnIpVTqijmVhHqqfVjaoSaIJGjCc4EnlvOeH4VFWKQ0JsJ+xKl216QH
         3LLOpOi7TGL06x0tznDeV00620Bf4/wERQ+UBDiSPxTkQMO3u90G0vapEFbe0oiaQetA
         oLg0VV6Lqy0pO4uIvwu85PWnX833DJS596z/ebt+DjO2osyT2O0OJro+gND14duDyMpt
         iFIg==
X-Forwarded-Encrypted: i=1; AJvYcCXGIC3HEaCRPSZLB7T/Q09vsO0+/5ZaduM+ciOe7Dv/GTn810PShp5VHOGg00e1yvhwFVA5nvy31mxcKsL2+q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28rcwfs3l0RCsF/scA//6/nb8E/LYdwJL8ZwZ3Fug+n5OZJvY
	mFV1Q9PxOAyVTQNjL0gin8hIaFAb9iLjvx5r6mbv0Xk2f/FY2JCF6SwmZ4xCcpv706wliZsjPbf
	mHZh6b9x4WUaEma6W+GAnVyg2X5HaDrsb7xjGI400u0EgB9FYFehaf99m3gpkr2eQM8cGv/DBld
	0hfUk9LSkrjbjNeIAz5a7pvl8ocjIRhHnF0Oc0EG/1
X-Gm-Gg: ASbGnct9zaz4jpMt6T2EnBKpKQJr/ey86pboXUPQrSA0TgxE4HdSmz8S6LBnYrmIg9i
	CumGSFNE6MkNCjUnNaag/W9eEHtAlY29flBiVxg==
X-Received: by 2002:a05:6902:2b8f:b0:e57:3635:8659 with SMTP id 3f1490d57ef6-e573635870fmr9141699276.25.1736851366891;
        Tue, 14 Jan 2025 02:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOZIJlicLLrBAyQmDoeqAtFnyT1ImV+T1Uhx17NQT/QOC5LkDQJVhFAyMaYO7X972M5OFPus6XF/HZMq7kyU8=
X-Received: by 2002:a05:6902:2b8f:b0:e57:3635:8659 with SMTP id
 3f1490d57ef6-e573635870fmr9141695276.25.1736851366585; Tue, 14 Jan 2025
 02:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca> <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca> <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca> <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi> <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
In-Reply-To: <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 14 Jan 2025 11:42:34 +0100
X-Gm-Features: AbW1kvaMP9hqrX7EbZd8ixyMHLxXzfJgXSkmu3Hcf4GyoCzHKWggJwOwPVU6IFE
Message-ID: <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, James Bottomley <james.bottomley@hansenpartnership.com>, 
	linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Dov Murik <dovmurik@linux.ibm.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jarkko,

On Thu, 19 Dec 2024 at 17:07, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Dec 19, 2024 at 05:40:58PM +0200, Jarkko Sakkinen wrote:
> >On Thu Dec 19, 2024 at 5:35 PM EET, Stefano Garzarella wrote:
> >> So to use them directly in sev, we would have to move these definitions
> >> into include/linux/tpm.h or some other file in inlcude/. Is this
> >> acceptable for TPM maintainers?
> >
> >There's only me.
> >
> >I don't know.
> >
> >What you want to put to include/linux/tpm.h anyway?
>
> At least tpmm_chip_alloc(), tpm2_probe(), and tpm_chip_register()
>
> >I have not followed this discussion.
>
> Let me try to summarize what we are doing: We are writing a small TPM
> driver to support AMD SEV-SNP SVSM. Basically SVSM defines some sort of
> hypercalls, which the guest OS can call to talk to the emulated vTPM.
>
> In the current version of this series, based on James' RFC, we have an
> intermediate module (tpm_platform) and then another small driver
> (platform_device) in arch/x86/coco/sev/core.c that registers the
> callback to use.
>
> To avoid the intermediate driver (Jason correct me if I misunderstood),
> we want to register the `tpm_chip` with its `tpm_class_ops` directly in
> arch/x86/coco/sev/core.c where it's easy to use "SVSM calls" (i.e.
> svsm_perform_call_protocol()).
>
> And here I have this problem, so I was proposing to expose these APIs.
> BTW, we do have an alternative though that I proposed in the previous
> email that might avoid this.

Any thought on this?

Thanks,
Stefano


