Return-Path: <linux-integrity+bounces-5317-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E7A67925
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F6E19C2A7C
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAEE211485;
	Tue, 18 Mar 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNsJTfpb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B920DD59
	for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314748; cv=none; b=AtHhk4z5ClSvoAxfxd6QLSqHDPj2fugQaunk7rjs92zWPHz87JXwDSz1/VmnRubPrqrZJaDat+PxSCPcnq53TqwweAAk2kFEdES21VjP2a30lBmeyD2YXsYTkUdJHad4HG4Y4+UC2OjTdY26mkUBmJyx4CxJdIOR8ck/+A/UgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314748; c=relaxed/simple;
	bh=xezgAHJjH1+Tu2ILpiloHYoZecr29l2Uf5h98HBsK5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc18kygkyHxcPdDMVOaAt5/rAGzZVSe48gOFdPG/48tghILPf6aTGBzJAkPOyoyZfjiGZILV2LPgp0qOCW6JwfXC+WUDcaK2cEdvcgp916TPHg/NWIkjlgbNRZrEBJgtaNRqRfkP+2sgyflifFQr0jsQmur0Bt67ApAJK1Xt8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNsJTfpb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742314742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojp+ehhGMDyrZfk37N2dqDkDnZrpGaHqadk7AS/VL4I=;
	b=BNsJTfpbeD1A5r3YKuYWwusfjjf8ycqjyfIE/Xlj729taB+RWtbXEVE8eLDWUTZ1QV2kyk
	G1TVL5zhjsZIQ8hDpxAmCAVcmmfqdNPkr3LgygCtkEAsQWjKIfRKU9cKAK5O38DJmmPbUE
	RrSD/RPPZmn9FUka+nkIpsTuHsMmH4U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-3bnaJhm_OtuwXguLnP5z6g-1; Tue, 18 Mar 2025 12:19:00 -0400
X-MC-Unique: 3bnaJhm_OtuwXguLnP5z6g-1
X-Mimecast-MFC-AGG-ID: 3bnaJhm_OtuwXguLnP5z6g_1742314739
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac21697a8ebso538365266b.1
        for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 09:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314739; x=1742919539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojp+ehhGMDyrZfk37N2dqDkDnZrpGaHqadk7AS/VL4I=;
        b=WxHkxp5X10aJgOz6ib4JGbY+T7QXTPxCCvgyDYeeLlI5ulJ724dUBAApHdtz9Mcyid
         yiHzEj1XsPzodMEuxKgyTxi0b5DP27N/N1CoPLkawLNSw5jHtGLnQRnEXeTbOCWLyM/Y
         amEUZQb9duHdcyJGfNXpdf7PgeOP+rvFAylDBLWl9V1uS9nUyVvebHa/tadyxCjJ+vfJ
         DFgSkDO8139xjLk0CQd5uTyjHYNwP8HXN7sYGxmSKhbBgyLV47tPGfAKF5ehDXqR3yKa
         sUZZwrqvlXPdgWYRyDoK8Y4b9dQb1a41FZfGeka19yjxoIyDtDo5cP45OnDKTejo5kzd
         S/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUqSPkyXmTDJ7fiZrnsIzYFS7/Y7dzSdagcZNeD5au7umuLTqEdlhlXStXX4ifbxybw5iffEcT2Buqt91KhWmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7Xw/6i+f5jz+NsThC14WbqvXBCvkRS2Fp2lk0TgO/T3x/9sm
	TyekB3Ffns011em2LF6rURAcaeyNr/xXB5xljh/pEsFd8CdnOi3uREASfh5ZCoBtaSAhc7L3AeZ
	0rspMmGq2ma1JN78P55ywgXFbh3SaTNAT4HY3VTQoLcPSQNJVGERMgtY5ocpNN3CYFw==
X-Gm-Gg: ASbGncsjEkTYDNx+8w8/bBpvp9ij5NK6oeWByNmkW3LpPqfmvbWMBchwom2qqve36BP
	4MMLvJQCD30TAeJJQ6EUVxm0QfzsTZWZWcu8pwjvv2jj/ajnWsNkb3tPcqoLdz7vf94KCBVLkB+
	+dcT+qy19PTpxdl/D30l6SLathKO14kN4G/0aQjW+oC64swvbV9jge4EWbw/WrF/F7+cTwHOWRo
	euNnsjdXu6sy4N1tln2Kq8e0fmYxh8xpoEhV94kFc6ArL3bX45T6SwRM+UvTXRP4yPvCf4pnk/z
	4y4aJVHHSrMg8E0ySoBSIECoMEtbBXgvQ3sUgjMvnrCqpyn4JM+No1pynK6lWXXU
X-Received: by 2002:a17:907:7d93:b0:ac2:84db:5916 with SMTP id a640c23a62f3a-ac3303013demr1950495566b.31.1742314739041;
        Tue, 18 Mar 2025 09:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEBXn2Dp5CzogYyVhOceebzb+lde3KvdaGTDH+J6/yUCXbynPYtozYnV11UWLKbFnsupkUkQ==
X-Received: by 2002:a17:907:7d93:b0:ac2:84db:5916 with SMTP id a640c23a62f3a-ac3303013demr1950491266b.31.1742314738419;
        Tue, 18 Mar 2025 09:18:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968cd8sm7829348a12.18.2025.03.18.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:18:57 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:18:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>, 
	linux-coco@lists.linux.dev, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <qne5fm44dhkbnwc6ldgff76ljt7ecd3cvtf3b3lhos56yyx2ez@qbcv45zbxlhp>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>
 <Z9gm9iWhk5Zs2NvI@kernel.org>
 <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
 <1262fa5b-0822-b8d4-26c5-426ffa4e0265@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1262fa5b-0822-b8d4-26c5-426ffa4e0265@amd.com>

On Tue, Mar 18, 2025 at 09:54:31AM -0500, Tom Lendacky wrote:
>On 3/18/25 05:38, Stefano Garzarella wrote:
>> On Mon, Mar 17, 2025 at 03:43:18PM +0200, Jarkko Sakkinen wrote:
>>> On Fri, Mar 14, 2025 at 11:48:11AM -0500, Tom Lendacky wrote:
>>>> On 3/11/25 04:42, Stefano Garzarella wrote:
>>>>> Add driver for the vTPM defined by the AMD SVSM spec [1].
>>>>>
>>>>> The specification defines a protocol that a SEV-SNP guest OS can use to
>>>>> discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>>>>> in the guest context, but at a more privileged level (VMPL0).
>>>>>
>>>>> The new tpm-svsm platform driver uses two functions exposed by x86/sev
>>>>> to verify that the device is actually emulated by the platform and to
>>>>> send commands and receive responses.
>>>>>
>>>>> The device cannot be hot-plugged/unplugged as it is emulated by the
>>>>> platform, so we can use module_platform_driver_probe(). The probe
>>>>> function will only check whether in the current runtime configuration,
>>>>> SVSM is present and provides a vTPM.
>>>>>
>>>>> This device does not support interrupts and sends responses to commands
>>>>> synchronously. In order to have .recv() called just after .send() in
>>>>> tpm_try_transmit(), the .status() callback returns 0, and both
>>>>> .req_complete_mask and .req_complete_val are set to 0.
>>>>>
>>>>> [1] "Secure VM Service Module for SEV-SNP Guests"
>>>>>     Publication # 58019 Revision: 1.00
>>>>>
>>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> ---
>>>>> v3:
>>>>> - removed send_recv() ops and followed the ftpm driver implementing .status,
>>>>>   .req_complete_mask, .req_complete_val, etc. [Jarkko]
>>>>> - removed link to the spec because those URLs are unstable [Borislav]
>>>>> ---
>>>>>  drivers/char/tpm/tpm_svsm.c | 148 ++++++++++++++++++++++++++++++++++++
>>>>>  drivers/char/tpm/Kconfig    |  10 +++
>>>>>  drivers/char/tpm/Makefile   |   1 +
>>>>>  3 files changed, 159 insertions(+)
>>>>>  create mode 100644 drivers/char/tpm/tpm_svsm.c
>>>>>
>>>>> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
>>>>> new file mode 100644
>>>>> index 000000000000..5540d0227eed
>>>>> --- /dev/null
>>>>> +++ b/drivers/char/tpm/tpm_svsm.c
>>>>> @@ -0,0 +1,148 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
>>>>> + *
>>>>> + * Driver for the vTPM defined by the AMD SVSM spec [1].
>>>>> + *
>>>>> + * The specification defines a protocol that a SEV-SNP guest OS can use to
>>>>> + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>>>>> + * in the guest context, but at a more privileged level (usually VMPL0).
>>>>> + *
>>>>> + * [1] "Secure VM Service Module for SEV-SNP Guests"
>>>>> + *     Publication # 58019 Revision: 1.00
>>>>> + */
>>>>> +
>>>>> +#include <asm/sev.h>
>>>>
>>>> Typically the "asm" includes are after the "linux" includes and separated
>>>> from each other by a blank line.
>>
>> Yep, I already fixed it in v4, since I found that issue while
>> backporting this patch to CentOS 9.
>>
>>>>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/svsm_vtpm.h>
>>>>> +
>>>>> +#include "tpm.h"
>>>>> +
>>>>> +struct tpm_svsm_priv {
>>>>> +  u8 buffer[SVSM_VTPM_MAX_BUFFER];
>>>>> +  u8 locality;
>>>>> +};
>>>>
>>>> I'm wondering if the buffer shouldn't be a pointer to a page of memory
>>>> that is a page allocation. This ensures it is always page-aligned in case
>>>> the tpm_svsm_priv structure is ever modified.
>>
>> @Tom Should that buffer really page aligned?
>>
>> I couldn't find anything in the specification. IIRC edk2 also doesn't
>> allocate it aligned, and the code in SVSM already handles the case when
>> this is not aligned.
>>
>> So if it is to be aligned to the pages, we should reinforce it in SVSM
>> (spec/code) and also fix edk2.
>>
>> Or was yours a suggestion for performance/optimization?
>
>No reason other than the size of the buffer is the size of a page.
>Allocating a page provides a page that is dedicated to the buffer for
>the SVSM. To me it just makes sense to keep it separate from any driver
>related data. Just a suggestion, not a requirement, and no need to
>update the spec.

I see, thanks for the clarification!
I saw that with devm_get_free_pages() I can easily allocate a 
resource-managed page, so I'll do that in v4.

Thanks,
Stefano

>
>Thanks,
>Tom
>
>>
>>>>
>>>> As it is, the kmalloc() allocation will be page-aligned because of the
>>>> size, but it might be safer, dunno, your call.
>>>
>>> This was good catch. There's actually two issues here:
>>>
>>> 1. SVSM_VTPM_MAX_BUFFER is same as page size.
>>> 2. SVSM_VTPM_MAX_BUFFER is IMHO defined in wrong patch 2/4.
>>
>> I put it in patch 2 because IIUC it should be part of the SVSM
>> specification (the size, not the alignment).
>>
>>>
>>> So this constant would be needed, it should be appeneded in this patch,
>>> not in 2/4 because it has direct effect on implementation of the driver.
>>>
>>> I'd personally support the idea of removing this constant altogether
>>> and use alloc_page() (i.e., same as you suggested).
>>
>> Do you think it's necessary, even though alignment is not required?
>> (I'm still not clear if it's a requirement, see above)
>>
>>>
>>> kmalloc() does do the "right thing here but it is still extra
>>> unnecessary layer of random stuff on top...
>>
>> Yes, if it has to be aligned I completely agree. I would like to use
>> devm_ functions to keep the driver simple. Do you think
>> devm_get_free_pages() might be a good alternative to alloc_page()?
>>
>> Thanks,
>> Stefano
>>
>


