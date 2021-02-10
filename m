Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B14316DC7
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhBJSD7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 13:03:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33878 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhBJSBd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 13:01:33 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A95AE2078945;
        Wed, 10 Feb 2021 10:00:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A95AE2078945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612980050;
        bh=R9xpAEULLlRloLEZ3aDp0NwjBNcG/EJw+NYFrjbxovk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iLPpwBjLdWwIRAhzbc9LVKfkXHca9jl+5BYxYtIL/Nw2utUjaWoz3J/q4Khaingxp
         9g+ioSTJJfSpxELua3hENK89gsOkGTSQniJuV52oPiEB0xSN23m+EYsm2a7+KTq4dr
         1Fl6I+Swrn54OePYZFnQpIO72FEz7BkMY+hiVBu0=
Subject: Re: [PATCH v17 05/10] powerpc: Move ima buffer fields to struct
 kimage
To:     Rob Herring <robh@kernel.org>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-6-nramas@linux.microsoft.com>
 <20210210172018.GA2361245@robh.at.kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a508a7b9-ce90-a68a-8b07-7fc65052d98a@linux.microsoft.com>
Date:   Wed, 10 Feb 2021 10:00:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210172018.GA2361245@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/10/21 9:20 AM, Rob Herring wrote:
> On Tue, Feb 09, 2021 at 10:21:55AM -0800, Lakshmi Ramasubramanian wrote:
>> The fields ima_buffer_addr and ima_buffer_size in "struct kimage_arch"
>> for powerpc are used to carry forward the IMA measurement list across
>> kexec system call.  These fields are not architecture specific, but are
>> currently limited to powerpc.
>>
>> arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
>> sets ima_buffer_addr and ima_buffer_size for the kexec system call.
>> This function does not have architecture specific code, but is
>> currently limited to powerpc.
>>
>> Move ima_buffer_addr and ima_buffer_size to "struct kimage".
>> Rename arch_ima_add_kexec_buffer() to of_ima_add_kexec_buffer()
>> and move it in drivers/of/kexec.c.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Will Deacon <will@kernel.org>
>> ---
>>   arch/powerpc/include/asm/ima.h     |  3 ---
>>   arch/powerpc/include/asm/kexec.h   |  5 -----
>>   arch/powerpc/kexec/ima.c           | 29 ++++++-----------------------
>>   drivers/of/kexec.c                 | 23 +++++++++++++++++++++++
>>   include/linux/kexec.h              |  3 +++
>>   include/linux/of.h                 |  5 +++++
>>   security/integrity/ima/ima_kexec.c |  3 ++-
>>   7 files changed, 39 insertions(+), 32 deletions(-)

>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index 469e09613cdd..9f33d215b9f2 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -63,6 +63,29 @@ static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned lon
>>   	return -ENOENT;
>>   }
>>   
>> +#ifdef CONFIG_IMA_KEXEC
>> +/**
>> + * of_ima_add_kexec_buffer - Add IMA buffer for next kernel
>> + *
>> + * @image: kimage struct to set IMA buffer data
>> + * @load_addr: Starting address where IMA buffer is loaded at
>> + * @size: Number of bytes in the IMA buffer
>> + *
>> + * Use this function to pass on the IMA buffer information to
>> + * the next kernel across kexec system call.
>> + *
>> + * Return: 0 on success, negative errno on error.
>> + */
>> +int of_ima_add_kexec_buffer(struct kimage *image,
>> +			    unsigned long load_addr, size_t size)
>> +{
>> +	image->ima_buffer_addr = load_addr;
>> +	image->ima_buffer_size = size;
>> +
> 
> There's nothing DT specific about this function, so this is the wrong
> place for it. I would just remove it and directly set the members.

Will do.

  -lakshmi


