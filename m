Return-Path: <linux-integrity+bounces-4346-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0139EC6EE
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 09:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508A8286834
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 08:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818031D61AF;
	Wed, 11 Dec 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8/nwdZj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE202451C5
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905160; cv=none; b=htwjHHEYY7JPXnr2qlEkUkS5nW/taW7uibQpUesOknFLSBG59U298NnMLSkjmbnbl52TfA69n4sTJK5m2pyag7vaYd+Iv0OzeHcI4md3MkmyFqBZdMr3cx6VJgNEER4I5GR6FDQVd5ML6LWi3WTd+T/KvYlgP1h7f99dyiQ+VnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905160; c=relaxed/simple;
	bh=kK/MJU/Q9OBs7J/to7TFQAxF5400ypJLjs8WUycDgxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYClSZHb3kNDHaDqDY1qqJRHWAYMotXvPATM+adrSSPltB80tcFz1gGurOThpJoKL0qL0MJF585d7duiCaGlXC1N37vv8iaDYW1x/DaYDpopOUTmdeJsGdX+zRvVCbuXxHBRxO0QomK+2ojpJFn5f5+NNslg8TIFqZnB2g5JiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8/nwdZj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733905157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df7gzbgWME26R9rpVKPWThUShTeBvSI36yYMQF09Oe4=;
	b=B8/nwdZj3wKjzVZ/alDn1yvyybfLH8U8s2R4YcEyAf6EkS9pO2EZIjpLcYu4CaH2OptiJe
	VkrrxDKJuHbAknPOxLRDxDwGUHEajeGzgfPfoZM3Sl3qevau3+pYDniuUcN9/1zjNiCGp6
	PMSWnnqtqabb29+vd4MrxzFtJ17/iXA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-JnOw9hyAMXS0Rc-f0-T-Qw-1; Wed, 11 Dec 2024 03:19:16 -0500
X-MC-Unique: JnOw9hyAMXS0Rc-f0-T-Qw-1
X-Mimecast-MFC-AGG-ID: JnOw9hyAMXS0Rc-f0-T-Qw
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e39a1a1f27dso10208533276.3
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 00:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905156; x=1734509956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Df7gzbgWME26R9rpVKPWThUShTeBvSI36yYMQF09Oe4=;
        b=sQNJbomZ/t6wOHBmGcAMn/sZIbzAf9V34VEjCadU/f9LI1ff3hnWyj5ZQ85dQtJW7H
         iop2EEUsPooXVP7Gy8hVAm500O104wUSY/MpvQjlIrKuF4ARB6QicDfV6KAyRH/f809A
         8QtXpRnHv5Sap98AB3zvGdhkwNYcXXpugzP6ZU6yMEvscOczKuZHLMmZMf1MoTY2x5lq
         E4AAIVRt9YP6bPJJAQeff8nAxdoi1c0F+2JuCpogwTXst9BZvbPmPw5DapYQo7Jw29jZ
         xlhH6InbQO0KXg6TQ7U77nVKxsO8jVLINoBvLwLdcqWdVu0U+yXy5I5rudYb/eoYlMRL
         8LfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK8UTP5K+hRftZjCTDLinkln0B6KXxrwws5FvHj3TysW8NIlJrsrkxwxnYUzt0B2kFl6xngQLKZlxTNiN4I2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJJSdXwlMaytWoKS6euxlIKqRHc2UF9o49IvGopjaUh7LgWQ1
	Ngn4XmUarSw+dlLSEXqhkPR+3ywBP8SygA3Vy1o9KJOZTayixEcOMORaw/dGXqU5d+AaT0oF4Zt
	e9NsVTQsgxt4d4Po/qYxlP7eHBkgRkI23LkzQr9NJcwICwKcQ+f0HEDhWzO6622jG6qbxCwMMzT
	YyLGDzb7Y/Y5lMPBaFri/vvCcjxp2TNBj62prham1o
X-Gm-Gg: ASbGnct5bq3/scZ4VUs2ZCVnQWpDf8KxIeKH3gdWlICyqTLvN9CkahCm7/ls8bUNveT
	5i5pjXWn4L9liBaRUOBZ4F1xG/f0gcopsQQ==
X-Received: by 2002:a05:6902:11c9:b0:e3c:8df7:4cdb with SMTP id 3f1490d57ef6-e3c8e67b517mr2108658276.32.1733905155735;
        Wed, 11 Dec 2024 00:19:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOSTE2WV/b1b9f1XmObRSLBn8v86IpzkAt8gBR0gdzUUukOkFtjbiPnJpDos/gaChbfGYffrt6LB23Z0mJj7U=
X-Received: by 2002:a05:6902:11c9:b0:e3c:8df7:4cdb with SMTP id
 3f1490d57ef6-e3c8e67b517mr2108649276.32.1733905155363; Wed, 11 Dec 2024
 00:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca> <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
In-Reply-To: <20241210150413.GI1888283@ziepe.ca>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 11 Dec 2024 09:19:04 +0100
Message-ID: <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, 
	x86@kernel.org, Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:04=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Dec 10, 2024 at 09:55:41AM -0500, James Bottomley wrote:
> > On Tue, 2024-12-10 at 10:40 -0400, Jason Gunthorpe wrote:
> > > On Tue, Dec 10, 2024 at 03:34:23PM +0100, Stefano Garzarella wrote:
> > >
> > > > +               if (platform_device_add_data(&tpm_device, &pops,
> > > > sizeof(pops)))
> > > > +                       return -ENODEV;
> > > > +               if (platform_device_register(&tpm_device))
> > > > +                       return -ENODEV;
> > >
> > > This seems like an old fashioned way to instantiate a device. Why do
> > > this? Just put the TPM driver here and forget about pops? Simple tpm
> > > drivers are not very complex.
> >
> > This driver may be for the AMD SEV SVSM vTPM module, but there are
> > other platforms where there's an internal vTPM which might be contacted
> > via a platform specific enlightenment (Intel SNP and Microsoft
> > OpenHCL).
>
> Sure, that's what TPM drivers are for, give those platforms TPM drivers
> too.
>
> Why put a mini driver hidden under an already mini driver?
>
> > This separation of the platform device from the contact
> > mechanism is designed to eliminate the duplication of having a platform
> > device within each implementation and to make any bugs in the mssim
> > protocol centrally fixable (every vTPM currently speaks this).
>
> That makes sense, but that isn't really what I see in this series?
>
> Patch one just has tpm_class_ops send() invoke pops sendrcv() after
> re-arranging the arguments?
>
> It looks to me like there would be mert in adding a new op to
> tpm_class_ops for the send/recv type operating mode and have the core
> code manage the buffer singleton (is a global static even *correct*??)
>
> After that, there is no meaningful shared code here, and maybe the
> TPM_CHIP_FLAG_IRQ hack can be avoided too.

IIUC you are proposing the following steps:
- extend tpm_class_ops to add a new send_recv() op and use it in
tpm_try_transmit()
- call the code in tpm_platform_probe() directly in sev

This would remove the intermediate driver, but at this point is it
worth keeping tpm_platform_send() and tpm_platform_recv() in a header
or module, since these are not related to sev, but to MSSIM?

As James mentioned, other platforms may want to reuse it.

Thanks,
Stefano

>
> Simply call tpm_chip_alloc/register from the sev code directly and
> provide an op that does the send/recv. Let the tpm core code deal with
> everything else. It is much cleaner than platform devices and driver
> data..


