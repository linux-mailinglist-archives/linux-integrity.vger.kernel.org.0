Return-Path: <linux-integrity+bounces-4352-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880699ECFF0
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF49188B7B3
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C31D04A9;
	Wed, 11 Dec 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIJpOpkT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29F1A7AF7
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931525; cv=none; b=X2ZzBXgrv6/S9rDfpcMzpKnAY8qdykCGMVqxlmr3ExKIO/vI+NnCrU0krz9NvAg0ecbiwC84a8CZwiUYZ7c5GnJZ6JLiAK98l0cXeMkNXq/FPlwviupy9kp68DV2NcLQMkqylk48zlhcby+XPQ7x5wxFpbmBdouCiFLfFm/1P0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931525; c=relaxed/simple;
	bh=a0hv9mFPITU2NDP0pqXzJbW7Mb2xRwyfM5fwAm1ROFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChlZP+E2E2pT72RxwJbQ227ZSbkskCHpgeHwRalkph+vhA2hsZc1gansYpWYh0JMU8kQGiTpFZDtj5w+wPwxF6siq0kjfVEhaIh325JwQaNrJNAj6Mop1D+Vb/dX6dPTSRYPgn7Iexxv40Zdt9934e5nwtIrq4xCqwExsbaa+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIJpOpkT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733931523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0hv9mFPITU2NDP0pqXzJbW7Mb2xRwyfM5fwAm1ROFg=;
	b=gIJpOpkTFJk4+MzZhxBcxDXmAIao3j85XyaXtbz9Tcd6Am2MG8lnywRU2TNko3tymZ0ZtV
	VMgociQO8CQY+b6Y6l7+1JgeKBWSItL4kn4/sNe/CQSP3zYhqM75xiZV5SogEd7x3SYEFC
	n0xDv4MJsOAvEDjvqMdaHF8mohRblUA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-BON2XQ8VN5y_-W5iiNhMHQ-1; Wed, 11 Dec 2024 10:38:42 -0500
X-MC-Unique: BON2XQ8VN5y_-W5iiNhMHQ-1
X-Mimecast-MFC-AGG-ID: BON2XQ8VN5y_-W5iiNhMHQ
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6ef6e33c182so79989097b3.2
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 07:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931521; x=1734536321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0hv9mFPITU2NDP0pqXzJbW7Mb2xRwyfM5fwAm1ROFg=;
        b=eGIyAKT3UYJaHcpoeOCF8OOa9wVS4ph13r5aII7y+sTkgQmIOnjuSPmMKfFZrz2RrM
         fVuf+v6BgAu7VvFOvpGrnHHe3ZTgmezjj03vGHsayraDqxQIJ4iNNS79xBxYG5OyFgd0
         +XyKegctipoM3GARXaJYRPQPvbOJ5L2jxqiJHan2YWwnnUeZW2cNkOADDoJUSnY6RQC5
         0rWDp/muZrPOOmkvLALelLq747EuUBK72POi1Wfpia0oO0+oaBfnfPGr1DxTwit8434y
         Avp3W8XF1qHxqM1AGBp65p0WZyIIgpCD5D86xxvpnlvmXkWHHcCgX7yB+oDmjjb9YeTj
         sejQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7HXOTVHnCRJJzRiS83FtAeEZDhIHPTll1+2TqF/NfsRZFf/9EyPYQ+C+ZjH++CvkbeP4jRT22VowNQzFG4kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBgbhGqhi3+i+msUbmHFb2ptJllHA7Mwap4MarbjPcvcUbCSn
	w1tz7eZnCYWyYM9f7wxGLka3fBRmlcGgZ4dzV3m98ls6IRNuGrvTaQc2PKPlCiDi9fCgxfA4dN9
	wFV8wvco53RXasLw+abbJ1BOeIV/E7DUQ/fr04dk2Gjc9n6Re6e1BRpsxBdnkslpIegnjDHUSsI
	U4Ayz5phfiXL1ZuFyKlqb8PSgKnJv+dnSubQuKy0D3
X-Gm-Gg: ASbGncteNnOXh+rHHebF3jZgivN/oa993W8kbRm2nSRBH4Eii9NLoM3BgiAMsxGMJ8y
	yhCh+690uQKE5J/60TNNKT2ebZQQ3l4FrgA==
X-Received: by 2002:a05:6902:100b:b0:e39:95e8:31be with SMTP id 3f1490d57ef6-e3c8e4249f0mr2855083276.8.1733931521396;
        Wed, 11 Dec 2024 07:38:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE394UlHqCYe1P7sHFdWBBxDdJetIc75Ei4upOeKARHA2ACI/wc9W2mPBcu4AH1Pm2Pwz68qrAYfHGPQSHdD8g=
X-Received: by 2002:a05:6902:100b:b0:e39:95e8:31be with SMTP id
 3f1490d57ef6-e3c8e4249f0mr2855042276.8.1733931521054; Wed, 11 Dec 2024
 07:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210143423.101774-1-sgarzare@redhat.com> <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca> <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca> <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
 <20241211150048.GJ1888283@ziepe.ca>
In-Reply-To: <20241211150048.GJ1888283@ziepe.ca>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 11 Dec 2024 16:38:29 +0100
Message-ID: <CAGxU2F5NSqMbA1Lep3+16GoZXR23q0OP8dFVVRJ6DG5sF20R3Q@mail.gmail.com>
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

On Wed, Dec 11, 2024 at 4:00=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
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

Thanks for confirming!

>
> > This would remove the intermediate driver, but at this point is it
> > worth keeping tpm_platform_send() and tpm_platform_recv() in a header
> > or module, since these are not related to sev, but to MSSIM?
>
> Reuse *what* exactly? These are 10 both line funtions that just call
> another function pointer. Where exactly is this common MSSIM stuff?

Except for the call to pops->sendrcv(buffer) the rest depends on how
the TCG TPM reference implementation [1] expects the request/response
to be formatted (we refer to this protocol with MSSIM).

This format doesn't depend on sev, and as James said, OpenHCL for
example will have to use the same format (e.g. buffer defined by
struct tpm_send_cmd_req, filled with TPM_SEND_COMMAND, etc.), so
basically rewrite a similar function, because it also emulates the
vTPM using the TCG TPM reference implementation.

Now, I understand it's only 10 lines of code, but that code is
strictly TCG TPM dependent, so it might make sense to avoid having to
rewrite it for every implementation where the device is emulated by
TCG TPM.

>
> Stated another way, by adding send_Recv() op to tpm_class_ops you have
> already allowed reuse of all the code in tpm_platform_send/recv().

Partially, I mean the buffer format will always be the same for all
platforms (e.g. sev, OpenHCL, etc.), but how we read/write will be
different.
That is why I was saying to create a header with helpers that create
the request/parse the response as TCG TPM expects.

Thanks,
Stefano

[1] https://github.com/TrustedComputingGroup/TPM


