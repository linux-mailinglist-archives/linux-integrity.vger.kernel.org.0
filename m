Return-Path: <linux-integrity+bounces-4332-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F669EB447
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 16:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46217162095
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A541A9B4C;
	Tue, 10 Dec 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gbwATCDZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A319E992
	for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843058; cv=none; b=WP8VYF4R652vgD3JWKNTeHqlhWhf+RG6qxQNu/1oOEfdEzK4VGZ+0cWVhQGXx6pxnqdSLXeo/tAajq9VSNRtcKikEnn3MjOOdI0FIdeHGdItUyRQR/WRTZN3NCzkDM0aDLXoNi5zY03Dcp+zmorqUpCjTRjxKsgWkyQP4fq+yWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843058; c=relaxed/simple;
	bh=ukjdHQgppfhZ4ld3b0epSQ6+Sp58DgXjMSZP+XOlx+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQbDPHDazEJcPSJv2+uDiZ2CPVT5FtD4dHYb/2TI7ox9S4DaOm333RkFD+xlGb9KOmPLbhLPZct/t2RqvuJ8DcVoyG/gBX8E+8NmTYjDLsy+lIaEB/hv6CG6w5VahASzEAOnVlOWgGn3eETc7D1tmTuy7CpClat7Acdo05oMlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gbwATCDZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d888c38841so44338086d6.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 07:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733843055; x=1734447855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Aul+w/AZ/V/tfWxFGZGkmQ2XjrfsU0kM7YK/J2vpZW0=;
        b=gbwATCDZTAjB3pvsGw8o2/QjLjfSH4lvWu9pRYm4wNa+3CPsglhOJ+TU2Z7KwbiODp
         EFX2UyF5K/fWTOSzc/9bMLLJoHG2Ec8+9Ro6fsXONDeyUFWHyrW503mECxGID6JL6gu3
         FWV52X0fFbGeR3v4vIj/cgT321Q0QoLJE7rs+pBvjL9EtTeRBxciRq6MId6UoflMQc4z
         vBrbCWk6Wx5GgVb44CRiSZjhAGEvWB6+McTJRGHSzblDN5azifxd4M6nFGX7GrgYwW4A
         +/lSdohlrcy4ExNUDPX6Qmc2ZRNgpCMBYQ+lmexiFlZbMvYISKWktwj64SEl2V3zCuTW
         KLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843055; x=1734447855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aul+w/AZ/V/tfWxFGZGkmQ2XjrfsU0kM7YK/J2vpZW0=;
        b=bACcuukFScxNoGKHT47p54lACU3BCnH1G94HzbiBfdMCmVjvO/rMrZtHnCpKKbdMjH
         tQlTHB9lNk5E3kSGiVyY6MKmFpSwgvpFMIYOyVVLbTkt760n3OBYsQt9JI3NEKDABwmd
         AEGkBL4LbVIwrYK5bOevKTfJEpd5IQDWne6xvbn6vWiB7DclVdjyK4GTdf+/cgdUOEWe
         HaeRUTKWETRTdKChiIp7ZwqZ4Q6eDJDp54wz5ZX5sjWwJEkQFK9Kj6k7acktdUiTCogB
         //8dnzvSvs/o/ZxqCAFrKiSPIOjy+afyMRzxYEdr1r0kRPnnhR7C4p2qtKmjzchFiDid
         53yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIoWwnX35/Eg0KzSbGk6oIyx+NuPIuF6gZ24gMph1fcK/szvDxJsZzLc4S2JOE1Hi+t/hpJFewHDVD1AdYiSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUejJNsF2OjMAh9+BjI34xlcSgntGzHvHjDJzjbKL6JWk7y4W
	Qqe+762KeurPY56EHcRzG6zoCyf0mxOSUkRqwpfiX8ik7r3AOJ5wBf/TdCBtjOc=
X-Gm-Gg: ASbGnctUdKnYhq0W1Iy0jqBwPQpAVur33UCckyvhNm7CkJFI+ONClr0YIJIn/phBDev
	4TAZooVIMF/w5tzs3eOxxsTi21/lDXilGsVaXBJFKvwHwdSJuf3d1LrJsBm7rp5Co3WcjkY86hM
	m0TkpKdHkqoXGpgpSlSVG6P0Zb6nLoIX5tC+J7d49EUleHyP1NRoypdAKmoD8dWBM4qwQhDsxDE
	ITVvjTZtQ/i/SVV8VFwitsrbpm2UfWovFbH5FwmiuVCQ9lBP6pl4zFotDQbDqyH5G+4CJPcRJHD
	TMd24cUJRGPjRiXZj6O/XR7YNfA=
X-Google-Smtp-Source: AGHT+IHyRvfTyyUB15vN1Ysf2M16N9KtPiDgvd0O/VN/SYXUfdWudj3J8B/1cFjnew5pjbR5udBkrw==
X-Received: by 2002:a05:6214:400b:b0:6d8:95c9:af2b with SMTP id 6a1803df08f44-6d8e71e8818mr304958446d6.35.1733843055170;
        Tue, 10 Dec 2024 07:04:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66efd7sm60633426d6.17.2024.12.10.07.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:04:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tL1mX-0000000A2oq-1oZj;
	Tue, 10 Dec 2024 11:04:13 -0400
Date: Tue, 10 Dec 2024 11:04:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, linux-coco@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20241210150413.GI1888283@ziepe.ca>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
 <20241210144025.GG1888283@ziepe.ca>
 <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50a2e1d29b065498146f459035e447851a518d1a.camel@HansenPartnership.com>

On Tue, Dec 10, 2024 at 09:55:41AM -0500, James Bottomley wrote:
> On Tue, 2024-12-10 at 10:40 -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 10, 2024 at 03:34:23PM +0100, Stefano Garzarella wrote:
> > 
> > > +               if (platform_device_add_data(&tpm_device, &pops,
> > > sizeof(pops)))
> > > +                       return -ENODEV;
> > > +               if (platform_device_register(&tpm_device))
> > > +                       return -ENODEV;
> > 
> > This seems like an old fashioned way to instantiate a device. Why do
> > this? Just put the TPM driver here and forget about pops? Simple tpm
> > drivers are not very complex.
> 
> This driver may be for the AMD SEV SVSM vTPM module, but there are
> other platforms where there's an internal vTPM which might be contacted
> via a platform specific enlightenment (Intel SNP and Microsoft
> OpenHCL). 

Sure, that's what TPM drivers are for, give those platforms TPM drivers
too.

Why put a mini driver hidden under an already mini driver?

> This separation of the platform device from the contact
> mechanism is designed to eliminate the duplication of having a platform
> device within each implementation and to make any bugs in the mssim
> protocol centrally fixable (every vTPM currently speaks this).

That makes sense, but that isn't really what I see in this series?

Patch one just has tpm_class_ops send() invoke pops sendrcv() after
re-arranging the arguments?

It looks to me like there would be mert in adding a new op to
tpm_class_ops for the send/recv type operating mode and have the core
code manage the buffer singleton (is a global static even *correct*??)

After that, there is no meaningful shared code here, and maybe the
TPM_CHIP_FLAG_IRQ hack can be avoided too.

Simply call tpm_chip_alloc/register from the sev code directly and
provide an op that does the send/recv. Let the tpm core code deal with
everything else. It is much cleaner than platform devices and driver
data..

Jason

