Return-Path: <linux-integrity+bounces-4558-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517CDA10CB5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FE8167704
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FBF159209;
	Tue, 14 Jan 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFY+GPE0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26403232459
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873503; cv=none; b=ma/osgsKTkeNuxFnySXr442HKylMbBrznQ3f2Eq9jX92BDdmlDB0uYpY2sl56dEFwp+kFOnVxgjMpkDZzsVVD4o5C0zh1B76n5oV2zjA002n17xlP08j5ZlpvolGDUEWI+3wOaT5Ca8QD3WbIEVw33ZC/aHOuePmuN36hUzoadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873503; c=relaxed/simple;
	bh=F/Rcvm8c7WOs06/htlH1im0ahc+bhTyHl9aYTYeW32M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf9Q1zGU/KoeEwxoWAbWwnluQssfWTQ3JVWf3XY+fBckxtDwrIMSsst22zufpacakBY0FtoGUT62fJlxepbKkiWBY6RohFmSPKM8Wedv/tt0HcqWX8Hn51UBsmt9WsxP1c3HD6saKCsG+4FZzmxEcBveYo4aWCxNBQDSp0UhBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFY+GPE0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736873500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVM4lB8fISehCZiKz+IKvae29WZL6ifuCMkp4bakUF8=;
	b=CFY+GPE0HHEoxUQBdrmNafVCv8Wzp9rcnkw2GNG6peLQ0rshWOH8e0+kIGzAP8MA7pR7qj
	G+hBirP5uumzM1IwRrtWqy3sydzjU5SCzr9g7cF5a80Q31a9q6TjX8Ooy3bmVH7hK7bLvW
	RRnI9M8/kDYL7CstmO4X+Myr9lti90E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Zj-pjI-NPXaKY2adzldlwg-1; Tue, 14 Jan 2025 11:51:38 -0500
X-MC-Unique: Zj-pjI-NPXaKY2adzldlwg-1
X-Mimecast-MFC-AGG-ID: Zj-pjI-NPXaKY2adzldlwg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so43785305e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 08:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873497; x=1737478297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVM4lB8fISehCZiKz+IKvae29WZL6ifuCMkp4bakUF8=;
        b=isqWu+uV5AIPagNae/sLJIkINhuUHF0RDL/QkUNNidq3X5x3bCt1MI8RBZLo6Ih4Vs
         Pu8BfMETfsbQbgNv7Ta/0BwVlNhB4VZlQBgdj33wUrM/AQ1lxOIqOoc8jT2L46T4NRMR
         hX/3HQi9bMoON/P7z9qpqziADrZMRiWZpKy+KghGU88wvF/eWVK4cL2CEzD4wd/8ayGl
         +ha3+JC4iTGnArXhFYhXLpS4JD3gn3PiK8e9lwTxGb9qnKhjVtdV7RaGHRviTTMqFogf
         C4aGSttSPk16KDNHaM3pk0fHnuzwjRsdGYOukITCY9c86RwPQ4ara8lAhD3VKWB3yCTH
         NZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVJ66DLHoxtozcxbv7gqKzOlBXDNEepdqkjTGbwvUE3olryGNGLy7Ie8MpxajX8BQ00FbF+M39cEhMoRvsBfwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDDk+orH2iGIufNYeyn15EmW8Sq/+UHyzaaFaAHSeHOfK3mIX
	mULnG2qAQZGHY4rUO5qQPFAAF1Z2agcTBhT0u2pFFTJ3s+AJwgMEEdPArHYuSTqVB7d9ce5TTWd
	QULNkxvANKIkjitviWqQt5EHTdmsWgBGcd3o6sqdzPnGdNnc9+oV5s8Yxf0LV0w+Wnw==
X-Gm-Gg: ASbGncuDVqG1cw2B3EA1q00qqfvb6/gFM7N+TnFNQFPUyq9Cavty396laawZDHEdCCl
	e1MoHzMW/2EVMzfghtCcy1nlBb7caQa6V5hQWWPMNCZhFCJ0+3IZLlZIWkevpJqT3uFETwWNunX
	ameAi7OJflv9Ggp66gr3KoLZ+6ILxrU5rzDySMjOdWy67vcTgmBhhD2XAAJ3Bx4mfx1fVLagmk3
	iqa93IdslnUPTFEC5f2/pi+vA7CtT740FwCjFmMJQ1a38+OIMxclnhWbVzDdYsqovo2E6VNtAH6
	AK1L9R5OEvGiN/Ap6e9cLONAWpIgsd8O
X-Received: by 2002:a05:600c:1d9e:b0:436:8a6f:b6db with SMTP id 5b1f17b1804b1-436e2707c41mr203961405e9.22.1736873497362;
        Tue, 14 Jan 2025 08:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHChBCm1fcENOEHRTFDJk6utAemDGsmFgi4siBbiD1KOBkMWUnBLk6m+9wbauenfuVr5rYzaQ==
X-Received: by 2002:a05:600c:1d9e:b0:436:8a6f:b6db with SMTP id 5b1f17b1804b1-436e2707c41mr203960865e9.22.1736873496611;
        Tue, 14 Jan 2025 08:51:36 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d050sm15652966f8f.15.2025.01.14.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:51:36 -0800 (PST)
Date: Tue, 14 Jan 2025 17:51:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <2yyqhjkxl56uqv35smrq6mdddufcpoj7fgon4n6h6zwei4kryu@pkwhln6b57ga>
References: <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
 <CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com>
 <D6FSHG5Z9UJQ.CWQTAANBVIQQ@iki.fi>
 <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
 <20250114130720.GJ26854@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250114130720.GJ26854@ziepe.ca>

On Tue, Jan 14, 2025 at 09:07:20AM -0400, Jason Gunthorpe wrote:
>On Tue, Jan 14, 2025 at 11:42:34AM +0100, Stefano Garzarella wrote:
>> Hi Jarkko,
>>
>> On Thu, 19 Dec 2024 at 17:07, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > On Thu, Dec 19, 2024 at 05:40:58PM +0200, Jarkko Sakkinen wrote:
>> > >On Thu Dec 19, 2024 at 5:35 PM EET, Stefano Garzarella wrote:
>> > >> So to use them directly in sev, we would have to move these definitions
>> > >> into include/linux/tpm.h or some other file in inlcude/. Is this
>> > >> acceptable for TPM maintainers?
>> > >
>> > >There's only me.
>> > >
>> > >I don't know.
>> > >
>> > >What you want to put to include/linux/tpm.h anyway?
>> >
>> > At least tpmm_chip_alloc(), tpm2_probe(), and tpm_chip_register()
>
>The intention was that tpm drivers would be under drivers/char/tpm/
>
>Do you really need to put your tpm driver in arch code? Historically
>drivers in arch code have not worked out so well.

I think I misinterpreted your answer here: https://lore.kernel.org/linux-coco/20241211150048.GJ1888283@ziepe.ca/ when I asked about calling "the code in
tpm_platform_probe() directly in sev".

I totally agree that it's not a good idea, which is why I had proposed
this: https://lore.kernel.org/linux-coco/CAGxU2F7QjQTnXsqYeKc0q03SQCoW+BHbej9Q2Z8gxbgu-3O2fA@mail.gmail.com/

   Otherwise we need an intermediate module in drivers/char/tpm. Here we
   have 2 options:
   1. continue as James did by creating a platform_device.
   2. or we could avoid this by just exposing a registration API invoked by
   sev to specify the send_recv() callback to use. I mean something like
   renaming tpm_platform_probe() in tpm_platform_register(), and call it in
   snp_init_platform_device().

I'm thinking of sending an RFC implementing 2 so we can discuss there,
it should be a good compromise between your suggestions and James'
version.

>
>Meaning that you'd export some of your arch stuff for the tpm driver
>to live in its natural home

@Tom do you think we can eventually expose sev API like
svsm_perform_call_protocol(), svsm_get_caa(), etc.?

Maybe option 2 that I proposed could avoid this and have sev register a
simple callback so that we avoid exposing these internal APIs.

Thanks,
Stefano


