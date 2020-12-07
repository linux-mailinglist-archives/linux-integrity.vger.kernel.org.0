Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8842D0909
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 02:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgLGB6I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 20:58:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50274 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgLGB6H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 20:58:07 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B79620B717A;
        Sun,  6 Dec 2020 17:57:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B79620B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607306246;
        bh=GlK/s+EgmPB0irtv3GsX2LP5l3rsRGSrZ5ZAEDyFZWo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K2s7YpIG3jT6Kbmk7H5cqTFtoC8kKL0UxcO2SbLxrElURapXNMC5TMrEQNEMfHS2J
         cmPtogosChV2GbmjuMWRlHvHrS+FySyeZm02j8sE59kG+IZ0nMPWLwl9Jkg8w6mC/N
         xPe+vrF3OmZyxLbSitDAtLCscev//C+4Xmof8A3A=
Subject: Re: [PATCH v10 5/8] powerpc: Move remove_ima_buffer() to
 drivers/of/kexec.c
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
 <20201204195149.611-6-nramas@linux.microsoft.com>
 <87sg8km2n5.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <19238597-5866-b5bb-2d84-e8f9a5c6089b@linux.microsoft.com>
Date:   Sun, 6 Dec 2020 17:57:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87sg8km2n5.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/5/20 12:14 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> remove_ima_buffer() removes the chosen node "linux,ima-kexec-buffer"
>> from the device tree and frees the memory reserved for carrying forward
>> the IMA measurement logs on kexec. This function does not have
>> architecture specific code, but is currently limited to powerpc.
>>
>> Move remove_ima_buffer() to "drivers/of/ima_kexec.c" so that it is
> 
> s/ima_kexec./kexec.c/
Will fix it.

> 
>> accessible for other architectures as well.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> Looks good. Just minor comments below. Nevertheless:
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
>> ---
>>   arch/powerpc/include/asm/ima.h |  8 ++------
>>   arch/powerpc/kexec/ima.c       | 26 --------------------------
>>   drivers/of/kexec.c             | 29 +++++++++++++++++++++++++++++
>>   include/linux/kexec.h          |  1 +
>>   4 files changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
>> index ead488cf3981..a2fc71bc3b23 100644
>> --- a/arch/powerpc/include/asm/ima.h
>> +++ b/arch/powerpc/include/asm/ima.h
>> @@ -2,17 +2,13 @@
>>   #ifndef _ASM_POWERPC_IMA_H
>>   #define _ASM_POWERPC_IMA_H
>>   
>> +#include <linux/kexec.h>
>> +
>>   struct kimage;
> 
> When you include <linux/kexec.h>, there's no need anymore for the
> `struct kimage` forward declaration so you can remove it.

Sure - i'll remove the forward declaration.

> 
>>   
>>   int ima_get_kexec_buffer(void **addr, size_t *size);
>>   int ima_free_kexec_buffer(void);
>>   
>> -#ifdef CONFIG_IMA
>> -void remove_ima_buffer(void *fdt, int chosen_node);
>> -#else
>> -static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
>> -#endif
>> -
> 
> This patch introduces a slight behaviour change on powerpc when
> CONFIG_IMA isn't set: since remove_ima_buffer() is now defined,
> kexec_file_load() will remove the IMA kexec buffer when creating the FDT
> for the next kernel. Before this patch, it will leave it there.
> 
> I think it's actually an improvement since a stale IMA kexec buffer
> isn't useful and just wastes memory. This should be mentioned on the
> commit message.

Thanks Thiago.

Appreciate if you could test this change for powerpc and let me know if 
you see any issues.

>>   #ifdef CONFIG_IMA_KEXEC
>>   int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>>   			      size_t size);
>> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
>> index 906e8212435d..68017123b07d 100644
>> --- a/arch/powerpc/kexec/ima.c
>> +++ b/arch/powerpc/kexec/ima.c
>> @@ -61,32 +61,6 @@ int ima_free_kexec_buffer(void)
>>   	return memblock_free(addr, size);
>>   }
>>   
>> -/**
>> - * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
>> - *
>> - * @fdt: Flattened Device Tree to update
>> - * @chosen_node: Offset to the chosen node in the device tree
>> - *
>> - * The IMA measurement buffer is of no use to a subsequent kernel, so we always
>> - * remove it from the device tree.
>> - */
>> -void remove_ima_buffer(void *fdt, int chosen_node)
>> -{
>> -	int ret;
>> -	unsigned long addr;
>> -	size_t size;
>> -
>> -	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
>> -	if (ret)
>> -		return;
>> -
>> -	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
>> -
>> -	ret = delete_fdt_mem_rsv(fdt, addr, size);
>> -	if (!ret)
>> -		pr_debug("Removed old IMA buffer reservation.\n");
>> -}
>> -
>>   #ifdef CONFIG_IMA_KEXEC
>>   /**
>>    * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index 516b86f7113a..42d16dfff78d 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -129,3 +129,32 @@ int get_ima_kexec_buffer(void *fdt, int chosen_node,
>>   
>>   	return 0;
>>   }
>> +
>> +/**
>> + * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
>> + *
>> + * @fdt: Flattened Device Tree to update
>> + * @chosen_node: Offset to the chosen node in the device tree
>> + *
>> + * The IMA measurement buffer is of no use to a subsequent kernel, so we always
>> + * remove it from the device tree.
>> + */
>> +void remove_ima_buffer(void *fdt, int chosen_node)
>> +{
>> +	int ret;
>> +	unsigned long addr;
>> +	size_t size;
>> +
>> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
>> +		return;
>> +
>> +	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
>> +	if (ret)
>> +		return;
>> +
>> +	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
>> +
>> +	ret = delete_fdt_mem_rsv(fdt, addr, size);
>> +	if (!ret)
>> +		pr_debug("Removed old IMA buffer reservation.\n");
>> +}
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 10ff704ab670..52a0efff184d 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -411,6 +411,7 @@ static inline int kexec_crash_loaded(void) { return 0; }
>>   extern int get_root_addr_size_cells(int *addr_cells, int *size_cells);
>>   extern int get_ima_kexec_buffer(void *fdt, int chosen_node,
>>   				unsigned long *addr, size_t *size);
>> +extern void remove_ima_buffer(void *fdt, int chosen_node);
>>   extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
>>   			      unsigned long size);
>>   #endif /* CONFIG_OF_FLATTREE */
> 
> Same comment as before: remove the `extern` keyword.
> 

Will remove "extern" keyword.

  -lakshmi

