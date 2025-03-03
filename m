Return-Path: <linux-integrity+bounces-5051-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B1A4CAF1
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 19:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ACCC7A65F4
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9422D79E;
	Mon,  3 Mar 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cVttLxSe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8B22D4ED
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026264; cv=none; b=ntzB+i3AjFiPGXbbiDzQqB1ah7vZAd+Jg+BiPdlIXaw8hTF3+dXR76dVCWjkmxh3zWbhyql2A+hqyVdPxxypyMjB9pJqTB6pITwJeU0V0afnaREtJ+Un+xXGcm55jDPXY2erc8d66KxdA24KeblysVcUkOCKzZX69M/SC/R1+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026264; c=relaxed/simple;
	bh=w2v2TO7Z7r5xka8aiKLuLQ59vaFsTPp6HtiifikSyfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA2IP9Rq2W7e7ClyJO2on4qKNSwlBTjyb5qtf65tAgNGE4+jtJ2NNpPJz3KHEavZYxFPprSxB8RLKJqBYT4+VQlehyhDli4yP9lrVud0fhQ3PqBzAu9MUsL2IcEUop1HKq1wM3zETJonmbUiI7kB+CEmmwng1nOZwPBn2VsVxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cVttLxSe; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-472242b0da5so44447801cf.1
        for <linux-integrity@vger.kernel.org>; Mon, 03 Mar 2025 10:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741026262; x=1741631062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFd2UZ8ldmIHGAH7CB3R5Sq6scV42nHS8znHwSV7/PU=;
        b=cVttLxSejPUSS5FDFsr8G7ieGQC/+a7Uf1DBeewybnI5xbjfd4ECy+WMHJQ43eLroY
         EFbopQO8OMB8F9M3z7NBQ4AFUrsSDs0yKP66eXhV7gIRu4YxofMd+v2Dcqq/nwiMtfJt
         OiqUESuddo8HM6nZsF9/Y9MXgLGFkPiNHKzZbDT4b8+xwR3rDQBC61gVek9S0y4hiKSZ
         bul4fMdluv4YueztXXGuIAVPeSg/nttzsbvd7Ll9HzDzuKE6xEeDErLB52XsYtF8lBgB
         2oTAQsgqIi2LqVVG8XR08QmNZ34SQxcehGFDIcIFIbbhJaCfjaN7l1Y37IUqmOSq610b
         KFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026262; x=1741631062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFd2UZ8ldmIHGAH7CB3R5Sq6scV42nHS8znHwSV7/PU=;
        b=tto1TW2abd4kIERzm24Xw+NoHgeP9PjXdb/DID1cbFvS14GsNfxelnHjkcyA5dXAX1
         tnee7SNpiEmQ4zWpIlvgV50yKzvc+7oegY69mnFEg3CSpWDnTiNXFU/5y3L8dEP7MsX4
         Lq/Bp3a1ruRMJkUhl42EfIiRub7YGMlav4hwixbtPypH9fz3sUgmFwjNg2Md6GqsXXor
         5xghtFzGwtDXjaznC41gTIO5S76+dJe0BN7ubfbfAjarYGY27UWfAcWkNhY4j7DV8Q4f
         U/6Zo9Y3OaDW+e1OSW2O+qGRpfPOhfWCn1HH8WkTQ+4eFu7YH0JSsfVhmfXvlytQ4mL8
         6ERQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlgXVstOjE+CjfbO+pG1Yj2NhLkMUnJYNYdxcaE/fp7stgsdy3nHDBgUD9uU0OUOXei5G249ooW6ZdF/dLnt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQ7X9SrL5dn73acBdR75iQP8FSBsixeT/M0ud5p5A/pDdtEKM
	S64itnzdIb4DfRCjCnETIhQB9WYARhqSA15PKzzD3MYNEUH5SXjAn9hGpHgD3Zo=
X-Gm-Gg: ASbGncuSomeiqIB1pfuvFXncS49dK3ndyEp3tVyWygI1tipDtCcptTsCCTLxRRK5a4P
	GN5vEZOaNudHNmQnMS6NoRm02wya8rmw1Fweqx1N6bAaTc4pCbB1oi0LQPyapqQN6GhbmnlfPVF
	IT7DqjDFy+XD1xem7LRxdftz3S2tq1uFEFWKq1SUrPR36pfdDCA3+aRSdIqUIeLZsu4eSPSVb0S
	71gGUxuS4CMbFUBwKJicIlJjg4U85XKPRhSxq0uIAChtVeqT0LmKEUJaP9IBRkYqnW0NhXvNCQR
	MNY3RvmGXdZR4C5ZcKMJOCLKcVOxWDiYCMMrLVrLMwf27crzJcMyGvAcoazayfDCg5vQ5oGbH56
	LhKyiLfLB7KdQZJ/jZA==
X-Google-Smtp-Source: AGHT+IHWCURrix0Rft30xojtcusv99HH/0K8wXIOezwHjJdDQzWoXGybANt1L1TDGdUNQiwXCdU87A==
X-Received: by 2002:a05:622a:81:b0:472:5ac:48bb with SMTP id d75a77b69052e-474bc095d6fmr182789981cf.29.1741026262120;
        Mon, 03 Mar 2025 10:24:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f1b76856sm9787641cf.16.2025.03.03.10.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:24:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpASi-00000000qFl-48AL;
	Mon, 03 Mar 2025 14:24:21 -0400
Date: Mon, 3 Mar 2025 14:24:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <20250303182420.GU5011@ziepe.ca>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
 <20250301002819.GO5011@ziepe.ca>
 <45ze5sxvcvg2ituxrefw6konxtwjgs4zs5bscrp2khfqkf3jb4@zozeerbmtik5>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ze5sxvcvg2ituxrefw6konxtwjgs4zs5bscrp2khfqkf3jb4@zozeerbmtik5>

On Mon, Mar 03, 2025 at 05:19:05PM +0100, Stefano Garzarella wrote:
> On Fri, Feb 28, 2025 at 08:28:19PM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
> > > +/*
> > > + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> > > + * module_platform_driver_probe() this is ok because they cannot get unbound
> > > + * at runtime. So mark the driver struct with __refdata to prevent modpost
> > > + * triggering a section mismatch warning.
> > > + */
> > 
> > ??? Is that really true? I didn't know that
> 
> I initially followed drivers/virt/coco/sev-guest/sev-guest.c to figure out
> how to clean a driver registered with module_platform_driver_probe(), then I
> saw that pattern with the same comment is used in several other drivers.
> 
> > 
> > I thought you could unbind anything using /sys/../unbind?
> 
> I can't see `unbind` for this driver:
> 
>   $ ls /sys/bus/platform/drivers/tpm-svsm/
>   module	tpm-svsm  uevent
> 
> While I can see it for example for others like fw_cfg:

Wow, I didn't know that could be done

> BTW I can unload the `tpm-svsm` module.

Unload the module and implicitly unbound the driver

But not manually unbind the driver?? Huh? That seems pretty wrong..

> Loading it again will cause issues if I don't have a remove function
> that calls tpm_chip_unregister().

You definately need the remove function call doing what you have, it
is just surprising to me that there is a case where you can statically
know it is not callable..

Jason

