Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242BD31834F
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 02:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBKB4I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 20:56:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34826 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhBKBvX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 20:51:23 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id AB9BA20B6C40;
        Wed, 10 Feb 2021 17:50:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB9BA20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613008232;
        bh=vcDxofWnoZw2pmIkFjZcnPLsVS9ccFRA9624EzZW0Z4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jfm5/BTa85WR6oMiaWJvCSPxwUcGCAbuGohT+l3IsPTLA0/XHJ9XTPrOZ9ouHIiEn
         fqMpr9/Du8pfJ11CBk69Rk/PIDFQQKzbLdevzANiI8pZIB2iCscYOSnEIt73KQIVbd
         0zuc7MvncowulwiTCJHU9W16aZDwG3j99W7njgeU=
Subject: Re: [PATCH v17 04/10] powerpc: Use common
 of_kexec_alloc_and_setup_fdt()
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org, joe@perches.com,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-5-nramas@linux.microsoft.com>
 <87sg63nzwc.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ec6a2a36-bb4d-45b1-9dfb-eba3e01e0d2d@linux.microsoft.com>
Date:   Wed, 10 Feb 2021 17:50:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87sg63nzwc.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/10/21 5:42 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> From: Rob Herring <robh@kernel.org>
>>
>> The code for setting up the /chosen node in the device tree
>> and updating the memory reservation for the next kernel has been
>> moved to of_kexec_alloc_and_setup_fdt() defined in "drivers/of/kexec.c".
>>
>> Use the common of_kexec_alloc_and_setup_fdt() to setup the device tree
>> and update the memory reservation for kexec for powerpc.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/powerpc/include/asm/kexec.h  |   1 +
>>   arch/powerpc/kexec/elf_64.c       |  29 ++++---
>>   arch/powerpc/kexec/file_load.c    | 132 +-----------------------------
>>   arch/powerpc/kexec/file_load_64.c |   3 +
>>   4 files changed, 25 insertions(+), 140 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
>> index dbf09d2f36d0..bdd0ddb9ac4d 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -111,6 +111,7 @@ struct kimage_arch {
>>   	unsigned long elf_headers_mem;
>>   	unsigned long elf_headers_sz;
>>   	void *elf_headers;
>> +	void *fdt;
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>>   	phys_addr_t ima_buffer_addr;
>> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>> index d0e459bb2f05..bfabd06f99b1 100644
>> --- a/arch/powerpc/kexec/elf_64.c
>> +++ b/arch/powerpc/kexec/elf_64.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/kexec.h>
>>   #include <linux/libfdt.h>
>>   #include <linux/module.h>
>> +#include <linux/of.h>
>>   #include <linux/of_fdt.h>
>>   #include <linux/slab.h>
>>   #include <linux/types.h>
>> @@ -29,7 +30,6 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>   			unsigned long cmdline_len)
>>   {
>>   	int ret;
>> -	unsigned int fdt_size;
>>   	unsigned long kernel_load_addr;
>>   	unsigned long initrd_load_addr = 0, fdt_load_addr;
>>   	void *fdt;
>> @@ -102,19 +102,13 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>   		pr_debug("Loaded initrd at 0x%lx\n", initrd_load_addr);
>>   	}
>>   
>> -	fdt_size = fdt_totalsize(initial_boot_params) * 2;
>> -	fdt = kmalloc(fdt_size, GFP_KERNEL);
>> +	fdt = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
>> +					   initrd_len, cmdline);
>>   	if (!fdt) {
>>   		pr_err("Not enough memory for the device tree.\n");
> 
> This error string can be a bit misleading now, since
> of_kexec_alloc_and_setup_fdt() can fail for reasons other than lack of
> memory. I suggest changing it to the error string from fdt_open_into()
> below:
> 
> 		pr_err("Error setting up the new device tree.\n");
> 
> With this change:
Agreed - I will make this change.

> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> And also:
> 
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 

Thanks a lot for your help Thiago.

  -lakshmi

