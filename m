Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4D2F40B9
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 01:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436936AbhAMAnF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 19:43:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47212 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392043AbhALXzf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 18:55:35 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 61D1F20B6C40;
        Tue, 12 Jan 2021 15:54:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61D1F20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610495694;
        bh=PPvEFYlKw1YG/P3Rr6NSYflDbfN80tOd8sdd+MreVdE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eamBIPdPY7NZ8L9C0P2dgoxOnkL/4nPiW47IusIGhqnc21MlvZ5cHj4A9tVcbC72I
         O9Mcs4SFllqRz8v8FAM/VrSjMxL7728nI3eLZnDJXubZ1h1c0jyrKA+l2+YdXsYuoG
         Foc5iFdU61xwKCJGamTAwRxxdHOARqnjByyGrQ3U=
Subject: Re: [PATCH v14 6/6] arm64: Add IMA log information in kimage used for
 kexec
To:     Mimi Zohar <zohar@linux.ibm.com>, bauerman@linux.ibm.com,
        robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@vger.kernel.org
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
 <20210104192602.10131-7-nramas@linux.microsoft.com>
 <4fef02cb3b330128e6d5d9bc9aab4d7e603d2945.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <45b60441-eb0d-4c02-6f6c-ea2f02bf1ee3@linux.microsoft.com>
Date:   Tue, 12 Jan 2021 15:54:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4fef02cb3b330128e6d5d9bc9aab4d7e603d2945.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/12/21 3:28 PM, Mimi Zohar wrote:
> Hi Lakshmi,
> 
> On Mon, 2021-01-04 at 11:26 -0800, Lakshmi Ramasubramanian wrote:
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
> 
> Perhaps for some previous version of this patch set, this patch
> description was appropriate, but for the code below it's kind of
> overkill.
> 

I agree Mimi. Will edit the patch description.

thanks,
  -lakshmi

>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/arm64/Kconfig             | 1 +
>>   arch/arm64/include/asm/kexec.h | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index a6b5b7ef40ae..312b4d5ad232 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1095,6 +1095,7 @@ config KEXEC
>>   config KEXEC_FILE
>>   	bool "kexec file based system call"
>>   	select KEXEC_CORE
>> +	select HAVE_IMA_KEXEC if IMA
>>   	help
>>   	  This is new version of kexec system call. This system call is
>>   	  file based and takes file descriptors as system call argument
>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>> index d24b527e8c00..2bd19ccb6c43 100644
>> --- a/arch/arm64/include/asm/kexec.h
>> +++ b/arch/arm64/include/asm/kexec.h
>> @@ -100,6 +100,11 @@ struct kimage_arch {
>>   	void *elf_headers;
>>   	unsigned long elf_headers_mem;
>>   	unsigned long elf_headers_sz;
>> +
>> +#ifdef CONFIG_IMA_KEXEC
>> +	phys_addr_t ima_buffer_addr;
>> +	size_t ima_buffer_size;
>> +#endif
>>   };
>>   
>>   extern const struct kexec_file_ops kexec_image_ops;
> 

