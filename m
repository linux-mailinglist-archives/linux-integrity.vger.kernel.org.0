Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D131F414
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 03:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhBSCyJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 21:54:09 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46946 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhBSCyI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 21:54:08 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id EC32F20B6C40;
        Thu, 18 Feb 2021 18:53:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC32F20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613703207;
        bh=rCbOOt9TGbdpIdg/NY4OSQmhLeB26YL8cZjJbICdaAc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i2QNptUyIxtzMh1vzNftJJSIDqPg/Rh8WEDNFdN06ErcAtos6xWdOmUlFKoURpATp
         KA8dtdlqYXaLfnfAHE3i8qpeURTGNoV9Hh98K2MwZhCzywlFMNZPZWRi702dTjwl6S
         L3LHxZqzFfjG37gk2b8QJikgab6sr51LHF4dw+Lk=
Subject: Re: [PATCH] of: error: 'const struct kimage' has no member named
 'arch'
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, sfr@canb.auug.org.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210218223305.2044-1-nramas@linux.microsoft.com>
 <c6490f6a126a2f10e3e3445b51ea552a26f896a9.camel@linux.ibm.com>
 <8b8c0b70-c7ab-33f3-b66c-9ea03388497b@linux.microsoft.com>
 <87k0r4yi4s.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <3ca0aa87-ca83-8024-4067-c2382a360db9@linux.microsoft.com>
Date:   Thu, 18 Feb 2021 18:53:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0r4yi4s.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/18/21 5:13 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> On 2/18/21 4:07 PM, Mimi Zohar wrote:
>>
>> Hi Mimi,
>>
>>> On Thu, 2021-02-18 at 14:33 -0800, Lakshmi Ramasubramanian wrote:
>>>> of_kexec_alloc_and_setup_fdt() defined in drivers/of/kexec.c builds
>>>> a new device tree object that includes architecture specific data
>>>> for kexec system call.  This should be defined only if the architecture
>>>> being built defines kexec architecture structure "struct kimage_arch".
>>>>
>>>> Define a new boolean config OF_KEXEC that is enabled if
>>>> CONFIG_KEXEC_FILE and CONFIG_OF_FLATTREE are enabled, and
>>>> the architecture is arm64 or powerpc64.  Build drivers/of/kexec.c
>>>> if CONFIG_OF_KEXEC is enabled.
>>>>
>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>> Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> ---
>>>>    drivers/of/Kconfig  | 6 ++++++
>>>>    drivers/of/Makefile | 7 +------
>>>>    2 files changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>>>> index 18450437d5d5..f2e8fa54862a 100644
>>>> --- a/drivers/of/Kconfig
>>>> +++ b/drivers/of/Kconfig
>>>> @@ -100,4 +100,10 @@ config OF_DMA_DEFAULT_COHERENT
>>>>    	# arches should select this if DMA is coherent by default for OF devices
>>>>    	bool
>>>>    +config OF_KEXEC
>>>> +	bool
>>>> +	depends on KEXEC_FILE
>>>> +	depends on OF_FLATTREE
>>>> +	default y if ARM64 || PPC64
>>>> +
>>>>    endif # OF
>>>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>>>> index c13b982084a3..287579dd1695 100644
>>>> --- a/drivers/of/Makefile
>>>> +++ b/drivers/of/Makefile
>>>> @@ -13,11 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>>>>    obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>>>>    obj-$(CONFIG_OF_OVERLAY) += overlay.o
>>>>    obj-$(CONFIG_OF_NUMA) += of_numa.o
>>>> -
>>>> -ifdef CONFIG_KEXEC_FILE
>>>> -ifdef CONFIG_OF_FLATTREE
>>>> -obj-y	+= kexec.o
>>>> -endif
>>>> -endif
>>>> +obj-$(CONFIG_OF_KEXEC) += kexec.o
>>>>      obj-$(CONFIG_OF_UNITTEST) += unittest-data/
>>> Is it possible to reuse CONFIG_HAVE_IMA_KEXEC here?
>>>
>>
>> For ppc64 CONFIG_HAVE_IMA_KEXEC is selected when CONFIG_KEXEC_FILE is enabled.
>> So I don't see a problem in reusing CONFIG_HAVE_IMA_KEXEC for ppc.
>>
>> But for arm64, CONFIG_HAVE_IMA_KEXEC is enabled in the final patch in the patch
>> set (the one for carrying forward IMA log across kexec for arm64). arm64 calls
>> of_kexec_alloc_and_setup_fdt() prior to enabling CONFIG_HAVE_IMA_KEXEC and hence
>> breaks the build for arm64.
> 
> One problem is that I believe that this patch won't placate the robot,
> because IIUC it generates config files at random and this change still
> allows hppa and s390 to enable CONFIG_OF_KEXEC.

I enabled CONFIG_OF_KEXEC for s390. With my patch applied, 
CONFIG_OF_KEXEC is removed. So I think the robot enabling this config 
would not be a problem.

> 
> Perhaps a new CONFIG_HAVE_KIMAGE_ARCH option? Not having that option
> would still allow building kexec.o, but would be used inside kexec.c to
> avoid accessing kimage.arch members.
> 

I think this is a good idea - a new CONFIG_HAVE_KIMAGE_ARCH, which will 
be selected by arm64 and ppc for now. I tried this, and it fixes the 
build issue.

Although, the name for the new config can be misleading since PARISC, 
for instance, also defines "struct kimage_arch". Perhaps, 
CONFIG_HAVE_ELF_KIMAGE_ARCH since of_kexec_alloc_and_setup_fdt() is 
accessing ELF specific fields in "struct kimage_arch"?

Rob/Mimi - please let us know which approach you think is better.

thanks,
  -lakshmi
