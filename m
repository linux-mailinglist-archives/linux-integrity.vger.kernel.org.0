Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48B93100EE
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 00:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBDXod (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 18:44:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39262 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhBDXnv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 18:43:51 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 34AF920202A2;
        Thu,  4 Feb 2021 15:42:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34AF920202A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612482179;
        bh=grGpUZ9QXcwEfkJN6PbqbvuH3nL7OZPTJHOmfI5PI3U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fECv7/DnY4FO0bNMA6WWgLyz+/dHOfMcmq0QU0eiDfZaWbpacyaGvLg5lHbP2ETah
         s1vwvqeYx29aNMue0LQvultPdSr2bLpZDJ02zpuxHU/CZOkr/bJAqZzOOBkn9n5Q8c
         s0NHAumYFXMaMVxsQ0YdGOW8lHAYSIIWFqyqW0f8=
Subject: Re: [PATCH v16 11/12] powerpc: Use OF alloc and free for FDT
To:     Rob Herring <robh@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        vincenzo.frascino@arm.com, Mark Rutland <mark.rutland@arm.com>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20210204164135.29856-1-nramas@linux.microsoft.com>
 <20210204164135.29856-12-nramas@linux.microsoft.com>
 <CAL_JsqK1Pb9nAeL84EP2U3MQgpBsm+E_0QXmzbigWXnS245WPQ@mail.gmail.com>
 <503d42ba-89bf-4ad9-9d4c-acb625580f77@linux.microsoft.com>
 <CAL_JsqKY9fxOowW=sBVm9s8j=3RWA7Jn9Ft9Edyx5qy5Yvykmw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9d7c9f2a-fb85-ecd3-3e03-1d324f20d7de@linux.microsoft.com>
Date:   Thu, 4 Feb 2021 15:42:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKY9fxOowW=sBVm9s8j=3RWA7Jn9Ft9Edyx5qy5Yvykmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/4/21 3:36 PM, Rob Herring wrote:
> On Thu, Feb 4, 2021 at 5:23 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>>
>> On 2/4/21 11:26 AM, Rob Herring wrote:
>>> On Thu, Feb 4, 2021 at 10:42 AM Lakshmi Ramasubramanian
>>> <nramas@linux.microsoft.com> wrote:
>>>>
>>>> of_alloc_and_init_fdt() and of_free_fdt() have been defined in
>>>> drivers/of/kexec.c to allocate and free memory for FDT.
>>>>
>>>> Use of_alloc_and_init_fdt() and of_free_fdt() to allocate and
>>>> initialize the FDT, and to free the FDT respectively.
>>>>
>>>> powerpc sets the FDT address in image_loader_data field in
>>>> "struct kimage" and the memory is freed in
>>>> kimage_file_post_load_cleanup().  This cleanup function uses kfree()
>>>> to free the memory. But since of_alloc_and_init_fdt() uses kvmalloc()
>>>> for allocation, the buffer needs to be freed using kvfree().
>>>
>>> You could just change the kexec core to call kvfree() instead.
>>
>>>
>>>> Define "fdt" field in "struct kimage_arch" for powerpc to store
>>>> the address of FDT, and free the memory in powerpc specific
>>>> arch_kimage_file_post_load_cleanup().
>>>
>>> However, given all the other buffers have an explicit field in kimage
>>> or kimage_arch, changing powerpc is to match arm64 is better IMO.
>>
>> Just to be clear:
>> I'll leave this as is - free FDT buffer in powerpc's
>> arch_kimage_file_post_load_cleanup() to match arm64 behavior.
> 
> Yes.

ok

> 
>> Will not change "kexec core" to call kvfree() - doing that change would
>> require changing all architectures to use kvmalloc() for
>> image_loader_data allocation.
> 
> Actually, no. AIUI, kvfree() can be used whether you used kvmalloc,
> vmalloc, or kmalloc for the alloc.
That is good information. Thanks.

> 
>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>> Suggested-by: Rob Herring <robh@kernel.org>
>>>> Suggested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>>> ---
>>>>    arch/powerpc/include/asm/kexec.h  |  2 ++
>>>>    arch/powerpc/kexec/elf_64.c       | 26 ++++++++++++++++----------
>>>>    arch/powerpc/kexec/file_load_64.c |  3 +++
>>>>    3 files changed, 21 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
>>>> index 2c0be93d239a..d7d13cac4d31 100644
>>>> --- a/arch/powerpc/include/asm/kexec.h
>>>> +++ b/arch/powerpc/include/asm/kexec.h
>>>> @@ -111,6 +111,8 @@ struct kimage_arch {
>>>>           unsigned long elf_headers_mem;
>>>>           unsigned long elf_headers_sz;
>>>>           void *elf_headers;
>>>> +
>>>> +       void *fdt;
>>>>    };
>>>>
>>>>    char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>>>> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>>>> index d0e459bb2f05..51d2d8eb6c1b 100644
>>>> --- a/arch/powerpc/kexec/elf_64.c
>>>> +++ b/arch/powerpc/kexec/elf_64.c
>>>> @@ -19,6 +19,7 @@
>>>>    #include <linux/kexec.h>
>>>>    #include <linux/libfdt.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/of.h>
>>>>    #include <linux/of_fdt.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/types.h>
>>>> @@ -32,7 +33,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>>>           unsigned int fdt_size;
>>>>           unsigned long kernel_load_addr;
>>>>           unsigned long initrd_load_addr = 0, fdt_load_addr;
>>>> -       void *fdt;
>>>> +       void *fdt = NULL;
>>>>           const void *slave_code;
>>>>           struct elfhdr ehdr;
>>>>           char *modified_cmdline = NULL;
>>>> @@ -103,18 +104,12 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>>>           }
>>>>
>>>>           fdt_size = fdt_totalsize(initial_boot_params) * 2;
>>>> -       fdt = kmalloc(fdt_size, GFP_KERNEL);
>>>> +       fdt = of_alloc_and_init_fdt(fdt_size);
>>>>           if (!fdt) {
>>>>                   pr_err("Not enough memory for the device tree.\n");
>>>>                   ret = -ENOMEM;
>>>>                   goto out;
>>>>           }
>>>> -       ret = fdt_open_into(initial_boot_params, fdt, fdt_size);
>>>> -       if (ret < 0) {
>>>> -               pr_err("Error setting up the new device tree.\n");
>>>> -               ret = -EINVAL;
>>>> -               goto out;
>>>> -       }
>>>>
>>>>           ret = setup_new_fdt_ppc64(image, fdt, initrd_load_addr,
>>>
>>> The first thing this function does is call setup_new_fdt() which first
>>> calls of_kexec_setup_new_fdt(). (Note, I really don't understand the
>>> PPC code split. It looks like there's a 32-bit and 64-bit split, but
>>> 32-bit looks broken to me. Nothing ever calls setup_new_fdt() except
>>> setup_new_fdt_ppc64()). The arm64 version is calling
>>> of_alloc_and_init_fdt() and then of_kexec_setup_new_fdt() directly.
>>>
>>> So we can just make of_alloc_and_init_fdt() also call
>>> of_kexec_setup_new_fdt() (really, just tweak of_kexec_setup_new_fdt do
>>> the alloc and copy).
>> ok - will move fdt allocation into of_kexec_setup_new_fdt().
>>
>> I don't think the architecture needs to pick the
>>> size either. It's doubtful that either one is that sensitive to the
>>> amount of extra space.
>> I am not clear about the above comment -
>> are you saying the architectures don't need to pass FDT size to the
>> alloc function?
>>
>> arm64 is adding command line string length and some extra space to the
>> size computed from initial_boot_params for FDT Size:
>>
>>          buf_size = fdt_totalsize(initial_boot_params)
>>                          + cmdline_len + DTB_EXTRA_SPACE;
>>
>> powerpc is just using twice the size computed from initial_boot_params
>>
>>          fdt_size = fdt_totalsize(initial_boot_params) * 2;
>>
>> I think it would be safe to let arm64 and powerpc pass the required FDT
>> size, along with the other params to of_kexec_setup_new_fdt() - and in
>> this function we allocate FDT and set it up.
> 
> It's pretty clear that someone just picked something that 'should be
> enough'. The only thing I can guess for the difference is that arm
> DT's tend to be a bit larger. So doubling the size would be even more
> excessive. Either way, we're talking 10s kB to few 100kB. I'd go with
> DTB_EXTRA_SPACE and we can bump it up if someone has problems.
ok - I'll use DTB_EXTRA_SPACE for the fdt allocation.

> 
> Also, I would like for 'initial_boot_params' to be private ultimately,
> so removing any references is helpful.
ok

> 
>> And, for powerpc leave the remaining code in setup_new_fdt_ppc64().
> 
> Right.
ok

thanks,
  -lakshmi
