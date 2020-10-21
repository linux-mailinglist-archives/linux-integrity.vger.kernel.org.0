Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063A2295137
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503258AbgJUQ6k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Oct 2020 12:58:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46182 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503261AbgJUQ6j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Oct 2020 12:58:39 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7B37A20B36E7;
        Wed, 21 Oct 2020 09:58:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B37A20B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603299518;
        bh=qoqMKd5rAYtWlHiexAS7FoltBw1ojl7Q05nqi0UaII0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KQYB+nroVu5+8g+mMq346b1h7y7Hxbx8qhI5tHgIoSJsNUmrGW4zrHe3DeP9vpcww
         Tz5R3inhBIPKsv/sQ9y3ny8H83LXZX7nciVyLITU4AwR4GuLR20MbfV6ULEaiobc5K
         XhzAyjHQAjh6ypqjTRe8UjFw4Cvy7DqFr38K30rY=
Subject: Re: [PATCH v7 1/4] powerpc: Refactor kexec functions to move arch
 independent code to kernel
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
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
 <20200930205941.1576-2-nramas@linux.microsoft.com>
 <bfaadaffafa3b8c12fce7e8491ea77e22a5821a8.camel@linux.ibm.com>
 <81c4a9ce-c363-a87a-06de-4a8729702b97@linux.microsoft.com>
 <a6c3e3ecb5c1c6f35b747f1ea4d8261667f9a376.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <af13db86-09c1-db12-330e-57e24bd07b9a@linux.microsoft.com>
Date:   Wed, 21 Oct 2020 09:58:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a6c3e3ecb5c1c6f35b747f1ea4d8261667f9a376.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/20/20 8:17 PM, Mimi Zohar wrote:
> On Tue, 2020-10-20 at 19:25 -0700, Lakshmi Ramasubramanian wrote:
>> On 10/20/20 1:00 PM, Mimi Zohar wrote:
>>> Hi Lakshmi,
>>>
>>> On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
>>>> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
>>>> carrying forward the IMA measurement logs on kexec for powerpc do not
>>>> have architecture specific code, but they are currently defined for
>>>> powerpc only.
>>>>
>>>> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
>>>> the IMA log entry from the device tree and free the memory reserved
>>>> for the log. These functions need to be defined even if the current
>>>> kernel does not support carrying forward IMA log across kexec since
>>>> the previous kernel could have supported that and therefore the current
>>>> kernel needs to free the allocation.
>>>>
>>>> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
>>>> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in kernel.
>>>> A later patch in this series will use these functions to free
>>>> the allocation, if any, made by the previous kernel for ARM64.
>>>>
>>>> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
>>>> "linux,ima-kexec-buffer", that is added to the DTB to hold
>>>> the address and the size of the memory reserved to carry
>>>> the IMA measurement log.
>>>
>>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>> Reported-by: kernel test robot <lkp@intel.com> error: implicit declaration of function 'delete_fdt_mem_rsv' [-Werror,-Wimplicit-function-declaration]
>>>
>>> Much better!  This version limits unnecessarily changing the existing
>>> code to adding a couple of debugging statements, but that looks to be
>>> about it.
>> Yes Mimi - that's correct.
>>
>>>
>>> Based on Chester Lin's "ima_arch" support for arm64 discussion, the IMA generic
>>> EFI support will be defined in ima/ima-efi.c.  Similarly, I think it would make sense to put the generic device tree support in ima/ima_kexec_fdt.c or ima/ima_fdt.c, as opposed to kernel/.  (Refer to my comments on 2/4 about the new file named ima_kexec_fdt.c.)
>>
>> The functions remove_ima_kexec_buffer() and delete_fdt_mem_rsv(), which
>> are defined in kernel/ima_kexec.c and kernel/kexec_file_fdt.c
>> respectively, are needed even when CONFIG_IMA is not defined. These
>> functions need to be called by the current kernel to free the ima kexec
>> buffer resources allocated by the previous kernel. This is the reason,
>> these functions are defined under "kernel" instead of
>> "security/integrity/ima".
>>
>> If there is a better location to move the above C files, please let me
>> know. I'll move them.
> 
> Freeing the previous kernel measurement list is currently called from
> ima_load_kexec_buffer(), only after the measurement list has been
> restored.  The only other time the memory is freed is when the
> allocated memory size isn't sufficient to hold the measurement list,
> which could happen if there is a delay between loading and executing
> the kexec.
> 

There are two "free" operations we need to perform with respect to ima 
buffer on kexec:

1, The ima_free_kexec_buffer() called from ima_load_kexec_buffer() - the 
one you have stated above.

Here we remove the "ima buffer" node from the "OF" tree and free the 
memory pages that were allocated for the measurement list.

This one is already present in ima and there's no change in that in my 
patches.

2, The other one is remove_ima_kexec_buffer() called from 
setup_ima_buffer() defined in "arch/powerpc/kexec/ima.c"

  This function removes the "ima buffer" node from the "FDT" and also 
frees the physical memory reserved for the "ima measurement list" by the 
previous kernel.

  This "free" operation needs to be performed even if the current kernel 
does not support IMA kexec since the previous kernel could have passed 
the IMA measurement list (in FDT and reserved physical memory).

For this reason, remove_ima_kexec_buffer() cannot be defined in "ima" 
but some other place which will be built even if ima is not enabled. I 
chose to define this function in "kernel" since that is guaranteed to be 
always built.

thanks,
  -lakshmi




