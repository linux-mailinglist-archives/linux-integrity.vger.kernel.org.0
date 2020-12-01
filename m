Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6562CAB71
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgLATIo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 14:08:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55502 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLATIo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 14:08:44 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6D79720B717B;
        Tue,  1 Dec 2020 11:08:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D79720B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1606849683;
        bh=uviDMqazHx7vVS+Y6RzmhMXm6z88v4czLJ1e//zSwLQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mtnMwkrzeEcktCb9don1xIAg0IpPLyJI+68xc2s4dJHn8820NnRagtL/EWVUgQv5V
         KGAKh6CtPb+s0qiL71zLlqg4ughIgGr27NQS+KaGBboa4WVeweEa/U3CA+xxQa5DSH
         UlxnFRiUi+lS9ECMCLwRC6ctRA1KbMiBebRS1M9E=
Subject: Re: [PATCH v9 7/8] arm64: Store IMA log information in kimage used
 for kexec
To:     Mimi Zohar <zohar@linux.ibm.com>, bauerman@linux.ibm.com,
        robh@kernel.org, gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
 <20201113192243.1993-8-nramas@linux.microsoft.com>
 <f0ac42878a713b270f7bad22d44f61739d582db8.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9e0430bc-e86b-c1c8-3b55-39292a05d6bb@linux.microsoft.com>
Date:   Tue, 1 Dec 2020 11:08:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f0ac42878a713b270f7bad22d44f61739d582db8.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/1/20 3:39 AM, Mimi Zohar wrote:
> On Fri, 2020-11-13 at 11:22 -0800, Lakshmi Ramasubramanian wrote:
>> Address and size of the buffer containing the IMA measurement log need
>> to be passed from the current kernel to the next kernel on kexec.
>>
>> Add address and size fields to "struct kimage_arch" for ARM64 platform
>> to hold the address and size of the IMA measurement log buffer.
>> Define an architecture specific function for ARM64 namely
>> arch_ima_add_kexec_buffer() that will set the address and size of
>> the current kernel's IMA buffer to be passed to the next kernel on kexec.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>   arch/arm64/include/asm/ima.h   | 18 ++++++++++++++++++
>>   arch/arm64/include/asm/kexec.h |  3 +++
>>   arch/arm64/kernel/Makefile     |  1 +
>>   arch/arm64/kernel/ima_kexec.c  | 34 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 56 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/ima.h
>>   create mode 100644 arch/arm64/kernel/ima_kexec.c
>>
>> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
>> new file mode 100644
>> index 000000000000..507fc94ddaba
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/ima.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2019 Microsoft Corporation
>> + *
>> + * Author: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> + *
>> + */
>> +#ifndef _ASM_ARCH_IMA_H
>> +#define _ASM_ARCH_IMA_H
>> +
>> +struct kimage;
>> +
>> +#ifdef CONFIG_IMA_KEXEC
>> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>> +			      size_t size);
>> +#endif /* CONFIG_IMA_KEXEC */
>> +
>> +#endif /* _ASM_ARCH_IMA_H */
>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>> index d24b527e8c00..7bd60c185ad3 100644
>> --- a/arch/arm64/include/asm/kexec.h
>> +++ b/arch/arm64/include/asm/kexec.h
>> @@ -100,6 +100,9 @@ struct kimage_arch {
>>   	void *elf_headers;
>>   	unsigned long elf_headers_mem;
>>   	unsigned long elf_headers_sz;
>> +
>> +	phys_addr_t ima_buffer_addr;
>> +	size_t ima_buffer_size;
>>   };
> 
> Any reason these definitions are not conditionally defined based on
> CONFIG_IMA_KEXEC, like on powerpc?

I'll define ima buffer related fields conditionally (CONFIG_IMA_KEXEC).

> 
>>
>> diff --git a/arch/arm64/kernel/ima_kexec.c b/arch/arm64/kernel/ima_kexec.c
>> new file mode 100644
>> index 000000000000..1847f1230710
>> --- /dev/null
>> +++ b/arch/arm64/kernel/ima_kexec.c
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2019 Microsoft Corporation
>> + *
>> + * Author: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> + *
>> + * File: ima_kexec.c
>> + *       Defines IMA kexec functions.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/kexec.h>
>> +#include <linux/types.h>
>> +#include <asm/ima.h>
>> +
>> +/**
>> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
>> + *
>> + * @image: kimage structure to set ima buffer information in for kexec
>> + * @load_addr: Start address of the IMA buffer
>> + * @size: size of the IMA buffer
>> + *
>> + * Architectures should use this function to pass on the IMA buffer
>> + * information to the next kernel.
>> + *
>> + * Return: 0 on success, negative errno on error.
>> + */
>> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>> +			      size_t size)
>> +{
>> +	image->arch.ima_buffer_addr = load_addr;
>> +	image->arch.ima_buffer_size = size;
>> +	return 0;
>> +}
> 
> This is exactly the same as the powerpc version.  Couldn't there be a
> common version of this as well?

I think it can be moved to a common version. I'll make that change.

thanks,
  -lakshmi


