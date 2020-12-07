Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B782D0915
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 03:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgLGCFy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 21:05:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51378 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgLGCFy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 21:05:54 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id ACA5220B717A;
        Sun,  6 Dec 2020 18:05:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACA5220B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607306712;
        bh=/wrLiBA9WsJkzgbLLWy+FFywGFAHppwoQHpx39RlPbU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hx/3Fb0z7xtSOt/H40q4k6kFCruEzFQN6Lf3toiiC7pnKfQsG1fpaFsFM/VBSjC4+
         5UHzHq4nmg5pcNJMTZdRDp05Oxm+fYqKNxVwm+xMWaaANwMcz+KxGe4Wis0occJIpB
         qxjlvT1sai/3YN8+b++suj9Tc4UcqSte+WGjZhgw=
Subject: Re: [PATCH v10 8/8] arm64: Add IMA log information in kimage used for
 kexec
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-9-nramas@linux.microsoft.com>
 <87ft4klyg7.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <62543957-337a-aa23-4a09-b76ab82debd4@linux.microsoft.com>
Date:   Sun, 6 Dec 2020 18:05:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87ft4klyg7.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/5/20 1:44 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> Address and size of the buffer containing the IMA measurement log need
>> to be passed from the current kernel to the next kernel on kexec.
>>
>> Any existing "linux,ima-kexec-buffer" property in the device tree
>> needs to be removed and its corresponding memory reservation in
>> the currently running kernel needs to be freed. The address and
>> size of the current kernel's IMA measurement log need to be added
>> to the device tree's IMA kexec buffer node and memory for the buffer
>> needs to be reserved for the log to be carried over to the next kernel
>> on the kexec call.
>>
>> Add address and size fields to "struct kimage_arch" for ARM64 platform
>> to hold the address and size of the IMA measurement log buffer. Remove
>> any existing "linux,ima-kexec-buffer" property in the device tree and
>> free the corresponding memory reservation in the currently running
>> kernel. Add "linux,ima-kexec-buffer" property to the device tree and
>> reserve the memory for storing the IMA log that needs to be passed from
>> the current kernel to the next one.
>>
>> Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to indicate
>> that the IMA measurement log information is present in the device tree
>> for ARM64.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
>> ---
>>   arch/arm64/Kconfig                     |  1 +
>>   arch/arm64/include/asm/ima.h           | 22 ++++++++++++++
>>   arch/arm64/include/asm/kexec.h         |  5 ++++
>>   arch/arm64/kernel/Makefile             |  1 +
>>   arch/arm64/kernel/ima.c                | 41 ++++++++++++++++++++++++++
>>   arch/arm64/kernel/machine_kexec_file.c |  8 +++++
>>   6 files changed, 78 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/ima.h
>>   create mode 100644 arch/arm64/kernel/ima.c
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 1515f6f153a0..bcca4a467eda 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1094,6 +1094,7 @@ config KEXEC
>>   config KEXEC_FILE
>>   	bool "kexec file based system call"
>>   	select KEXEC_CORE
>> +	select HAVE_IMA_KEXEC
>>   	help
>>   	  This is new version of kexec system call. This system call is
>>   	  file based and takes file descriptors as system call argument
>> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
>> new file mode 100644
>> index 000000000000..354adc8b444c
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/ima.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2019 Microsoft Corporation
> 
> Shouldn't the year here be 2020?

Yes - will update.

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
>> +extern int setup_ima_buffer(struct kimage *image, void *dtb, int off);
>> +#else
>> +static inline int setup_ima_buffer(struct kimage *image, void *dtb, int off)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_IMA_KEXEC */
>> +
>> +#endif /* _ASM_ARCH_IMA_H */
> 
> <snip>
> 
>> diff --git a/arch/arm64/kernel/ima.c b/arch/arm64/kernel/ima.c
>> new file mode 100644
>> index 000000000000..d65bdbe1adf6
>> --- /dev/null
>> +++ b/arch/arm64/kernel/ima.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2016 IBM Corporation
> 
> Same question: shouldn't the year here be 2020?
Yes. Also, should be "Copyright (C) 2020 Microsoft Corporation"
Will make these changes.

thanks,
  -lakshmi

> 
>> + *
>> + * Authors:
>> + * Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> + */
>> +
>> +#include <linux/kexec.h>
>> +#include <linux/of.h>
>> +#include <linux/libfdt.h>
>> +#include <asm/ima.h>
>> +
>> +/**
>> + * setup_ima_buffer - add IMA buffer information to the fdt
>> + *
>> + * @image:	kexec image being loaded.
>> + * @dtb:	Flattened device tree for the next kernel.
>> + * @off:	Offset to the chosen node.
>> + *
>> + * Return: 0 on success, or negative errno on error.
>> + */
>> +int setup_ima_buffer(struct kimage *image, void *dtb, int off)
>> +{
>> +	int ret = 0;
>> +
>> +	/* add ima-kexec-buffer */
>> +	if (image->arch.ima_buffer_size > 0) {
>> +		ret = fdt_appendprop_addrrange(dtb, 0, off,
>> +				"linux,ima-kexec-buffer",
>> +				image->arch.ima_buffer_addr,
>> +				image->arch.ima_buffer_size);
>> +		if (ret)
>> +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
>> +
>> +		ret = fdt_add_mem_rsv(dtb, image->arch.ima_buffer_addr,
>> +				      image->arch.ima_buffer_size);
>> +	}
>> +
>> +	return ret;
>> +}
> 

