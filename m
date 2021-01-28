Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457E4306BC7
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 05:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhA1EBv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 23:01:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40218 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhA1EBc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 23:01:32 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 68AA620B7192;
        Wed, 27 Jan 2021 20:00:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68AA620B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611806436;
        bh=j2ytaqRDLSxdVnbORmC1VmYaP/7+dbpAQywJI7b00gU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XjFkrXhHnyR53rne7WHNJDhhws91IZ+fiKsrlIcQYw4OfuqWziuNTJejFWJTYWfsT
         ReANiquNaEdr2UmAt9OkF/LasShgVDZT0lsMWLATFdmIKswUBTiXWvyfHyzINMiQoG
         QWAg7xvg2QTc/vkCRwtttTKCyBKFBTiHrO28Yypo=
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Will Deacon <will@kernel.org>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
 <20210127165208.GA358@willie-the-truck>
 <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
 <20210127184319.GA676@willie-the-truck>
 <871re5soof.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <58d3ffbf-4d80-c893-34d6-366ebfac55bd@linux.microsoft.com>
Date:   Wed, 27 Jan 2021 20:00:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871re5soof.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/27/21 7:52 PM, Thiago Jung Bauermann wrote:
> 
> Will Deacon <will@kernel.org> writes:
> 
>> On Wed, Jan 27, 2021 at 09:59:38AM -0800, Lakshmi Ramasubramanian wrote:
>>> On 1/27/21 8:52 AM, Will Deacon wrote:
>>>
>>> Hi Will,
>>>
>>>> On Fri, Jan 15, 2021 at 09:30:16AM -0800, Lakshmi Ramasubramanian wrote:
>>>>> create_dtb() function allocates kernel virtual memory for
>>>>> the device tree blob (DTB).  This is not consistent with other
>>>>> architectures, such as powerpc, which calls kmalloc() for allocating
>>>>> memory for the DTB.
>>>>>
>>>>> Call kmalloc() to allocate memory for the DTB, and kfree() to free
>>>>> the allocated memory.
>>>>>
>>>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>>> ---
>>>>>    arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
>>>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>>>>> index 7de9c47dee7c..51c40143d6fa 100644
>>>>> --- a/arch/arm64/kernel/machine_kexec_file.c
>>>>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>>>>> @@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>>>>>    int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>>>>    {
>>>>> -	vfree(image->arch.dtb);
>>>>> +	kfree(image->arch.dtb);
>>>>>    	image->arch.dtb = NULL;
>>>>>    	vfree(image->arch.elf_headers);
>>>>> @@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
>>>>>    			+ cmdline_len + DTB_EXTRA_SPACE;
>>>>>    	for (;;) {
>>>>> -		buf = vmalloc(buf_size);
>>>>> +		buf = kmalloc(buf_size, GFP_KERNEL);
>>>>
>>>> Is there a functional need for this patch? I build the 'dtbs' target just
>>>> now and sdm845-db845c.dtb is approaching 100K, which feels quite large
>>>> for kmalloc().
>>>
>>> Changing the allocation from vmalloc() to kmalloc() would help us further
>>> consolidate the DTB setup code for powerpc and arm64.
>>
>> Ok, but at the risk of allocation failure. Can powerpc use vmalloc()
>> instead?
> 
> I believe this patch stems from this suggestion by Rob Herring:
> 
>> This could be taken a step further and do the allocation of the new
>> FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
>> arm64 version also retries with a bigger allocation. That seems
>> unnecessary.
> 
> in https://lore.kernel.org/linux-integrity/20201211221006.1052453-3-robh@kernel.org/
> 
> The problem is that this patch implements only part of the suggestion,
> which isn't useful in itself. So the patch series should either drop
> this patch or consolidate the FDT allocation between the arches.
> 
> I just tested on powernv and pseries platforms and powerpc can use
> vmalloc for the FDT buffer.
> 

Thanks for verifying on powerpc platform Thiago.

I'll update the patch to do the following:

=> Use vmalloc for FDT buffer allocation on powerpc
=> Keep vmalloc for arm64, but remove the retry on allocation.
=> Also, there was a memory leak of FDT buffer in the error code path on 
arm64, which I'll fix as well.

Did I miss anything?

thanks,
  -lakshmi
