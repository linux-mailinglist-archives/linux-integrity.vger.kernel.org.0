Return-Path: <linux-integrity+bounces-5537-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFFA7770C
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Apr 2025 10:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D577E3A5FBB
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Apr 2025 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356351D7E52;
	Tue,  1 Apr 2025 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6Qe1SrS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA4189F56
	for <linux-integrity@vger.kernel.org>; Tue,  1 Apr 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497937; cv=none; b=d2+lW3zmW8874MH2saeI9dMNeWzS4weCnvrMbnEIqukdrTbVUsutSkdthQ31zxJjR/MGYd86b39AWC/RshsZX1R6wB5vLTK+tTMQwo2Dn76+0klT0VxLKOPjv1nn1dl0DUXUJJLGvPdfH5VWBFYssVhEqdus/6Ked+Qppikqok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497937; c=relaxed/simple;
	bh=Cbpy21Pj/PV3ox21YZxNBKmn0C1URS9/DxwZPfFmLPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUxsgCPzMmNWmPeSzFqwGxWTv2Sj9cUqRRnswnrp65TdVpDK+0v0iIjIsuWihBEWd0KfEgHbEHm1Ud/OXFUJnS3QSvjVHVvdGGztcZCbKsdaZhRbKe4QwpvSRC3Ts9gr/Ci0A1M8Vqb8Q3TXKORZvW/N5YRsAZGwt5UzWiWyfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6Qe1SrS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743497934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIf9d4LKwWJlU65MePabyEnw5zIkoOcPcSvDhqLnyRI=;
	b=M6Qe1SrSgW63tohdW6pHIyYOpOL13p34mBF0RXuWnYdbu9Y7Dkk3z0oilwVWDn/2Udyckv
	mV9VqUen/IldetO6155mN4IWbCzpJ3KZyqjGv3BgtgAlRc8QYhN+SZHPAIixJ2HOB2SpDF
	fnIgPkrKbI9CPTyudbZjsqG7NEddWok=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-X-I_uo3tO_OqAhlrAjAQ5g-1; Tue, 01 Apr 2025 04:58:52 -0400
X-MC-Unique: X-I_uo3tO_OqAhlrAjAQ5g-1
X-Mimecast-MFC-AGG-ID: X-I_uo3tO_OqAhlrAjAQ5g_1743497932
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so41848095e9.2
        for <linux-integrity@vger.kernel.org>; Tue, 01 Apr 2025 01:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497931; x=1744102731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIf9d4LKwWJlU65MePabyEnw5zIkoOcPcSvDhqLnyRI=;
        b=jgcW5gFz8tq6AMWOmZMuBm8679DBTBNfTS2dO4p7CtD12BmPUACehdypbIYXWB3H0l
         j7ekq89lpzMjwn6ht4QJVMpGOzgTcLoxJ2jHarOzyIyyFD/+ovrSa+E/GdmjZoL84Nfj
         hYVpI9ho/ksJIa6Pssqv0EyoFs7M3oHZnmhR//6rafwLJW1oQTuA0K9zhIb6fVKoOoXl
         c87dce/52hmrkA5Zz0+nHLodFXny53HhZ1KTMfGoegHf+FnCtldeAAoC5sb7qv3UNXgd
         JqefABoXjSyIwdvDtSu/k3p9TTJWUStmlPiK/5c6snK4Wb6xcSeSg29yN0N/XVNM3vD3
         q2Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXd+NsMQl9p7T0YI5EPEhtNUBgx2YJnk1SaEPpFaZkj2ZmyzHjzbaeyPiAjwUgsCV7FrfKP2G746hyJHEASOaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Y/uq5L3c0fmmtaWtAjHmXzWxO1zRIzO8oh+P/vmhhdfzYajN
	FcE4jPYUryaFNs13eksL/lOkUZWmOE2+5jklQLSe+SZEvwaMq+Niph9O4W6ZChTc1Ex3gEOKOPf
	8t471SyQ+7aUuuXc7caC0qe+xqnEz9+HKU/mJhF/hcsQs5utsguXDE518tw53vcndGQ==
X-Gm-Gg: ASbGncum6VByz7dmbqKAEudcRSt+wEoYQrQWdkOAHXjg7IO0FRgYZaWycdNHBtGjc7j
	N3TQb45Aac4inoL4tbHxEobMr4ksNGU4kASGZuHgMIICb3M253ZSN2+1c761/FGyTaKBTVYamSu
	efKvk0awuxAP/r93e22v8l84u/12rVGPtlVQQVllUd3VQa45FqKRkZcd2/XBkHO0LpVm3F7n4+v
	lWM/fclEw3cY1zz3wn3v1L0jsPcH31TxbeLeH/jIaAMlzKsBYRCVS/o9ZW21IjX4zFDv/O3/Pyr
	3VgklLL9/Wj+90AFl2LublPfP8DaEOT83/aSRp3QqO+9Z3nN+s++HfPcLm8=
X-Received: by 2002:a05:6000:2b03:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-39c12118f9fmr6752853f8f.37.1743497931568;
        Tue, 01 Apr 2025 01:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWnEs6xzLDc1YxYeDtY269xDpZqA1RPcUk8inouSBTPsWMS3grkQL5iiqBKXY3nyZb9YG6vg==
X-Received: by 2002:a05:6000:2b03:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-39c12118f9fmr6752823f8f.37.1743497931082;
        Tue, 01 Apr 2025 01:58:51 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e097sm13323779f8f.80.2025.04.01.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:58:50 -0700 (PDT)
Date: Tue, 1 Apr 2025 10:58:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, linux-coco@lists.linux.dev, Dov Murik <dovmurik@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <jroedel@suse.de>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <CAGxU2F5WtVZWEgJNwzoWUX0gcq8fe6evnU026R1hHXqCfG2v9w@mail.gmail.com>
References: <20250331103900.92701-1-sgarzare@redhat.com>
 <20250331103900.92701-4-sgarzare@redhat.com>
 <Z-rSMi2uCvShLbLS@kernel.org>
 <CAAH4kHY-Orjr_+rcYNemuWrAOOtyrCMD5s6KsOrkX740AARXiA@mail.gmail.com>
 <02190762dd82104070ff1a2942a7be703f4ff53d.camel@HansenPartnership.com>
 <CAAH4kHYwDgnYsMhJ8zZWn1uU4tqqnSXOLKEJNMb-3OCNrM7Z9A@mail.gmail.com>
 <e2db0cef00e9ad6061af8256c71d0198b15a5ddc.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2db0cef00e9ad6061af8256c71d0198b15a5ddc.camel@HansenPartnership.com>

On Tue, 1 Apr 2025 at 00:59, James Bottomley <James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2025-03-31 at 15:23 -0700, Dionna Amalie Glaze wrote:
> > On Mon, Mar 31, 2025 at 2:26 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Mon, 2025-03-31 at 13:56 -0700, Dionna Amalie Glaze wrote:
> > > [...]
> > > > I might be unclear on how I should be testing this, but I do see
> > > > /dev/tpm0 and /dev/tpmrm0 when I build with CONFIG_TCG_SVSM=y,
> > > > but I don't see the event log in securityfs. What am I missing?
> > >
> > > The vtpm driver for EDK2/OVMF I suspect ... without that the UEFI
> > > won't lay down and event log for the kernel to pick up.
> >
> > This test is with Oliver's PR
> > https://github.com/tianocore/edk2/pull/6527
>
> Well, since the event log is searched for in tpm_chip_register(), I
> really don't think it can be the kernel driver.  Best guess is there's
> something wrong with that patch set (or the vTPM didn't activate in
> OVMF for some reason).

Yep, I also think it should be something in edk2.

I'm using edk2 from https://github.com/coconut-svsm/edk2/pull/62 which 
should contain the commits from that PR + a fix not yet merged upstream.

I'm building it with:
build -a X64 -b DEBUG -t GCC5 -DTPM2_ENABLE \
  --pcd PcdUninstallMemAttrProtocol=TRUE -p OvmfPkg/OvmfPkgX64.dsc

And in Linux I see the devices and the event log:

# ls /dev/tpm*
/dev/tpm0  /dev/tpmrm0

# ls /sys/kernel/security/tpm0/
binary_bios_measurements

# tpm2_eventlog /sys/kernel/security/tpm0/binary_bios_measurements
---
version: 1
events:
- EventNum: 0
  PCRIndex: 0
  EventType: EV_NO_ACTION
  Digest: "0000000000000000000000000000000000000000"
  EventSize: 37
...

If I remove `-DTPM2_ENABLE` when building edk2, I can still see the 
/dev/tpm* devices (of course), but I can't see the event log anymore.
And also most PCRs are 0 (unlike when I have tpm driver enabled in 
edk2).

Thanks,
Stefano


