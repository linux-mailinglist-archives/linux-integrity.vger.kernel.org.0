Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA75E2D84EE
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 06:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbgLLFr3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Dec 2020 00:47:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41340 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbgLLFrK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Dec 2020 00:47:10 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 195E420B717A;
        Fri, 11 Dec 2020 21:46:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 195E420B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607751988;
        bh=V31bOChnr8lat3WNyoEvadwinYKZ3Pm3p29JNFXDyvc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m5okTUXaQpr9BxPcQD+AKL1HBqahIUQGwQy5M0QXxtaObm3u3cP5aGmBF8SCtyZD8
         bhl8wETUf6c/N0ncRmptKshSMM9lvyRPf4QzEyml8m4gB/CXc0Op/ss2tR6CZyTbJs
         X2wjf4djHP4LKy9fbUokPuvcVqOMy4Nho/T8tqMk=
Subject: Re: [RFC PATCH 2/4] of: Add a common kexec FDT setup function
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Rob Herring <robh@kernel.org>, takahiro.akashi@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        zohar@linux.ibm.com, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-3-robh@kernel.org>
 <6934c005-d848-314d-cfee-23f2273c119d@linux.microsoft.com>
 <87360bahup.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <49579baf-6159-0eac-fa36-6fdb618c2320@linux.microsoft.com>
Date:   Fri, 11 Dec 2020 21:46:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87360bahup.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/20 6:17 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> On 12/11/20 2:10 PM, Rob Herring wrote:
>>
>> Hi Rob,
>>
>>> Both arm64 and powerpc do essentially the same FDT /chosen setup for
>>> kexec. We can simply combine everything each arch does. The differences
>>> are either omissions that arm64 should have or additional properties
>>> that will be ignored.
>>> The differences relative to the arm64 version:
>>> - If /chosen doesn't exist, it will be created (should never happen).
>>> - Any old dtb and initrd reserved memory will be released.
>>> - The new initrd and elfcorehdr are marked reserved.
>>> - "linux,booted-from-kexec" is set.
>>> The differences relative to the powerpc version:
>>> - "kaslr-seed" and "rng-seed" may be set.
>>> - "linux,elfcorehdr" is set.
>>> - Any existing "linux,usable-memory-range" is removed.
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>> This could be taken a step further and do the allocation of the new
>>> FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
>>> arm64 version also retries with a bigger allocation. That seems
>>> unnecessary.
>>> ---
>>>    drivers/of/Makefile |   1 +
>>>    drivers/of/kexec.c  | 228 ++++++++++++++++++++++++++++++++++++++++++++
>>>    include/linux/of.h  |   5 +
>>>    3 files changed, 234 insertions(+)
>>>    create mode 100644 drivers/of/kexec.c
>>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>>> index 6e1e5212f058..8ce11955afde 100644
>>> --- a/drivers/of/Makefile
>>> +++ b/drivers/of/Makefile
>>> @@ -13,5 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>>>    obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>>>    obj-$(CONFIG_OF_OVERLAY) += overlay.o
>>>    obj-$(CONFIG_OF_NUMA) += of_numa.o
>>> +obj-$(CONFIG_KEXEC_FILE) += kexec.o
>>
>> For the functions moved from powerpc & arm64 to "drivers/of/kexec.c" in this
>> patch, compiling kexec.c when CONFIG_KEXEC_FILE is enabled is fine. But when
>> more functions (such as remove_ima_buffer()) are moved to this file, Makefile
>> needs to be updated for other ima kexec related CONFIGs.
> 
> IMA kexec is only available if CONFIG_KEXEC_FILE is enabled, so I don't
> understand what problem you are seeing.
> 

delete_fdt_mem_rsv() and setup_fdt() functions are defined when 
CONFIG_KEXEC_FILE is enabled. So there is no problem with this patch as 
such.

I was thinking when other arch independent functions such as 
do_get_kexec_buffer() and remove_ima_buffer() are moved to 
"drivers/of/kexec.c", they need to be defined only when 
CONFIG_HAVE_IMA_KEXEC is enabled.

If CONFIG_HAVE_IMA_KEXEC is enabled, CONFIG_KEXEC_FILE is also enabled. 
So there shouldn't be a problem moving those functions to 
"drivers/of/kexec.c". You are right Thiago. Thanks.

  -lakshmi



