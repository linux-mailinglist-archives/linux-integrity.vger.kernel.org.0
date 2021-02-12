Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB79231A36F
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhBLRTp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 12:19:45 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38426 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhBLRTm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 12:19:42 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C5C7020B6C40;
        Fri, 12 Feb 2021 09:19:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5C7020B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613150341;
        bh=ymZC2uSu1WhDmmhzMMk+j693znWvxWsQ0oRGutDXsUU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UFctr/CjGfWUVNUkmlcZdiSnRimSYXYpf7boiSafTdIohyW4op8aqXiOPIXG7tD9w
         2+CCCjIQwjmCzRCgCyJOtrEfXaan1toeQ6tewZfvQeoz8k1bHJnQ/MjJqkkzxmgjf+
         fBeDNBT4ANHJIZyDIIuAoR7Wx92T/5Rbhxu+1Yog=
Subject: Re: [PATCH v17 02/10] of: Add a common kexec FDT setup function
To:     Rob Herring <robh@kernel.org>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-3-nramas@linux.microsoft.com>
 <87k0reozwh.fsf@manicouagan.localdomain>
 <8a3aa3d2-2eba-549a-9970-a2b0fe3586c9@linux.microsoft.com>
 <CAL_JsqJ3sDzjsJXtb6EzE77BL+PhUxDJYUngLTqcm0popd7Ajw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <55685b61-dac0-2f24-f74a-939acf74a4f2@linux.microsoft.com>
Date:   Fri, 12 Feb 2021 09:19:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ3sDzjsJXtb6EzE77BL+PhUxDJYUngLTqcm0popd7Ajw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/12/21 6:38 AM, Rob Herring wrote:
> On Thu, Feb 11, 2021 at 7:17 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>>
>> On 2/11/21 5:09 PM, Thiago Jung Bauermann wrote:
>>>
>>> There's actually a complication that I just noticed and needs to be
>>> addressed. More below.
>>>
>>
>> <...>
>>
>>>> +
>>>> +/*
>>>> + * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
>>>> + *
>>>> + * @image:          kexec image being loaded.
>>>> + * @initrd_load_addr:       Address where the next initrd will be loaded.
>>>> + * @initrd_len:             Size of the next initrd, or 0 if there will be none.
>>>> + * @cmdline:                Command line for the next kernel, or NULL if there will
>>>> + *                  be none.
>>>> + *
>>>> + * Return: fdt on success, or NULL errno on error.
>>>> + */
>>>> +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>>>> +                               unsigned long initrd_load_addr,
>>>> +                               unsigned long initrd_len,
>>>> +                               const char *cmdline)
>>>> +{
>>>> +    void *fdt;
>>>> +    int ret, chosen_node;
>>>> +    const void *prop;
>>>> +    unsigned long fdt_size;
>>>> +
>>>> +    fdt_size = fdt_totalsize(initial_boot_params) +
>>>> +               (cmdline ? strlen(cmdline) : 0) +
>>>> +               FDT_EXTRA_SPACE;
>>>
>>> Just adding 4 KB to initial_boot_params won't be enough for crash
>>> kernels on ppc64. The current powerpc code doubles the size of
>>> initial_boot_params (which is normally larger than 4 KB) and even that
>>> isn't enough. A patch was added to powerpc/next today which uses a more
>>> precise (but arch-specific) formula:
>>>
>>> https://lore.kernel.org/linuxppc-dev/161243826811.119001.14083048209224609814.stgit@hbathini/
>>>
>>> So I believe we need a hook here where architectures can provide their
>>> own specific calculation for the size of the fdt. Perhaps a weakly
>>> defined function providing a default implementation which an
>>> arch-specific file can override (a la arch_kexec_kernel_image_load())?
>>>
>>> Then the powerpc specific hook would be the kexec_fdt_totalsize_ppc64()
>>> function from the patch I linked above.
>>>
>>
>> Do you think it'd better to add "fdt_size" parameter to
>> of_kexec_alloc_and_setup_fdt() so that the caller can provide the
>> desired FDT buffer size?
> 
> Yes, I guess so. But please define the param as extra size, not total
> size. The kernel command line size addition can be in the common code.

Will do. Just to clarify -

The common code will do:

fdt_totalsize(initial_boot_params) + strlen(cmdline) + extra_fdt_size

The caller will pass "extra_fdt_size"
ARM64 => 4KB
PPC64 => fdt_totalsize(initial_boot_params) - which will be updated when 
the patch Thiago had referred to is merged.

> 
> The above change is also going to conflict, so I think this may have
> to wait. Or I'll take the common and arm bits and powerpc can be
> converted next cycle (or after the merge window).
> 

thanks.

  -lakshmi


