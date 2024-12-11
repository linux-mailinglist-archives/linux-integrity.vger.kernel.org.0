Return-Path: <linux-integrity+bounces-4351-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586249ECF38
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 16:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF32B280C26
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1168A24634E;
	Wed, 11 Dec 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Toi6SJl1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738324634C
	for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929253; cv=none; b=O7eRAjUblRcaISb1UDTDzZZGRkrYGdTxBWFQzzesji3ufJxzMIN6e6gpQXC7qSUeHfBh6bJhCadb769yLiW6Ajezqtw0mGH450wmqcvybhKWTOiu7zC/ZYO1OlMAeOvW0Zj6YjYY6mRQFLysFBbIz2maNmuW9srrbM28OYX6A+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929253; c=relaxed/simple;
	bh=tLszuGjmr5DmRzuJ37tFeyxJiAHTkhXYikVmA7/gTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POIGYCv9vMcqrUlm+R1QcEJoMeI0zUOXUY8P0RIHpMDpiOvHiTv3Fd7TRuGI5rqs9tBPwbQVtCYt7T1LEtOxOE+5Yrs8XlJGXWkxwv8hIGiDeSHXtu3lA2As3bqDHsmiGvwcPbTMypEH4wv5TP80i+Zreel27JD+XG0FbgM8MEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Toi6SJl1; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b676152a86so71967085a.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2024 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733929250; x=1734534050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrtmwbffSfZyT6YxRWc9FPtrtY5w8qbaif6a3GhziHU=;
        b=Toi6SJl1+npOzcW9+TeiwHI0XkmlgzC7E9QHi4dIhLCs3M2nlMP06dauO2Jq0phb5Q
         k/3Y/bxm4sspN/ruZxUdywsywb7kYJ8xdPRy7uS99AwnCvUAcHkR7skAU9wg2So4a5Ro
         BJUtlrPtZGrqdddLLcwv1agZ4vW9cVlBmqfF63sJMHRxwt+Xb3C3F7SCyhVrHOlSECUd
         i9h6hOuDyWCBPq2QaVxN78WUXl79Z0rIJPmrkuzAH992pynXaE9PlUUv5HWKTFVz17Ov
         Jg4k2SGAiqylDcVRUxVed5Vsezx6v1ElbVKErzdnW2JkWYUITDDPSmrKqimS0h78bssn
         0swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929250; x=1734534050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrtmwbffSfZyT6YxRWc9FPtrtY5w8qbaif6a3GhziHU=;
        b=F6f5w715cIQnvczpytzyGC0p8WXSmwzBZVPRm2cSG2Fvozq0vumL1asNvzspUyNTdC
         ECv+nfWCUu7S3k6M5Y4oaGM6ETW2dB9e2lnt04bvFXJAtOOSAgqeCxRTodvpFcgY9FjP
         alyeSPG+kLX63dEbU629j8ps4llaR34kQBGs/Gyg834YqZx9nnyoMYCbKQRHxEAQrOhg
         FIiafV4JZ9jPbLEqv71dKd+wvrp9l4FiwsyeTmIY6iKdvLQDX59we1zbWVpNx8Zg/C5+
         /6cYV9dxKRx4WWatcbqcGsM79W88TRl5PH0ckjzdt7398EVo8D3xSHOygtFf7gzONwBI
         GKzg==
X-Forwarded-Encrypted: i=1; AJvYcCXBMS3Yuprqz77w4iqyKQlZmDA+YfMlblm/bm4AE+eIcb7tir45RECc8Um3SxDCU8HCtqpBGkYBrhlPHj9SUN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0takN3+JoCbMFqOpULockeJSqOwqyeffkntBzmTpM0Q4sUZ0Z
	jL5hsBnUS+Pz5t9wcvjl0hrhG85STV6WwVkYkaijMi3KeivgJMPKi/fq6o4rSB0=
X-Gm-Gg: ASbGncsUuRIN7jvUYkmKfvLLOJVAbDFSfRQCyfRc/QIzVBjfjNoRF6U9JxAOMGq+w4o
	Hm5saKeVZdxwMtQ2mwjh+8g8K3GJ/nv/00prK3T+X9tBfb0kMhkjsLScVXulZe86sKm17XUY9h5
	Mn9vaQOeinXlJy02Z2bYeEtNVFPahuH2hslNVAvVSsRNvNv+CYOJKbm1XQlpngr5Jl7DTKGiPNI
	In7Z1KG8xxEyUWb1HVfoFnoVAfNnZJZnEskefzdeOyPOK688LIzQvHLCGxkLpxW/T3WJDM5PaBZ
	GnsRYwI6vqHiL7IlOEEgmALaOXI=
X-Google-Smtp-Source: AGHT+IFQcbIbj/UVOC6lgBpyonYbHxz3lu1y3vK9mVU+Waihpf9zpnAftHXTy27rea7DKFP+zHsrCQ==
X-Received: by 2002:a05:620a:4488:b0:7b1:4a2a:9ae0 with SMTP id af79cd13be357-7b6ebc2ded9mr501476085a.9.1733929250259;
        Wed, 11 Dec 2024 07:00:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6ef71409dsm29466085a.121.2024.12.11.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:00:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tLOCm-0000000ADPI-0U4U;
	Wed, 11 Dec 2024 11:00:48 -0400
Date: Wed, 11 Dec 2024 11:00:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org, x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <20241211150048.GJ1888283@ziepe.ca>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
 <20241210150413.GI1888283@ziepe.ca>
 <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F6yzqb0o_pQDakBbCj3RdKy_XfZfzGsiywnYL65g6WeGg@mail.gmail.com>

On Wed, Dec 11, 2024 at 09:19:04AM +0100, Stefano Garzarella wrote:

> > After that, there is no meaningful shared code here, and maybe the
> > TPM_CHIP_FLAG_IRQ hack can be avoided too.
> 
> IIUC you are proposing the following steps:
> - extend tpm_class_ops to add a new send_recv() op and use it in
> tpm_try_transmit()

Yes, that seems to be the majority of your shared code.

> - call the code in tpm_platform_probe() directly in sev

Yes

> This would remove the intermediate driver, but at this point is it
> worth keeping tpm_platform_send() and tpm_platform_recv() in a header
> or module, since these are not related to sev, but to MSSIM?

Reuse *what* exactly? These are 10 both line funtions that just call
another function pointer. Where exactly is this common MSSIM stuff?

Stated another way, by adding send_Recv() op to tpm_class_ops you have
already allowed reuse of all the code in tpm_platform_send/recv().

Jason

