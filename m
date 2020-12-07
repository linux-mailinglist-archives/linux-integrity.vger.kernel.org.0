Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42622D0912
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 03:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgLGCDx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 21:03:53 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgLGCDx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 21:03:53 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3DBE120B717A;
        Sun,  6 Dec 2020 18:03:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DBE120B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607306591;
        bh=wNXjR79DfZouD5kjHAVglpUTtFseXZpcPOkj3ZGki20=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IXegge9eZpr5RicWYXAS/1EreO/D8z5mCjdxt/WxC/uTu+9xAW7ci+SSE4WycAPYH
         u2E41ku7hlxBF1k0gheSZte/9YCEoQwOkIUzHFBIRY7AkiaTRi5+ZLGB4RG2FP2/FJ
         DqnVJGneW/IcVWtq5b/QIE5lrrK7Br0uHeKksh4w=
Subject: Re: [PATCH v10 7/8] powerpc: Move arch_ima_add_kexec_buffer to ima
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
 <20201204195149.611-8-nramas@linux.microsoft.com>
 <87k0twlytt.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <0f60b35e-eff6-20c6-363d-82f0b10a1c1f@linux.microsoft.com>
Date:   Sun, 6 Dec 2020 18:03:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0twlytt.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/5/20 1:36 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> arch_ima_add_kexec_buffer() sets the address and size of the IMA
>> measurement log in the architecture specific field in struct kimage.
>> This function does not have architecture specific code, but is
>> currently limited to powerpc.
>>
>> Move arch_ima_add_kexec_buffer() to
>> security/integrity/ima/ima_kexec.c so that it is accessible for
>> other architectures as well.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> Not sure if the maintainers will agree with me (see below), but FWIW:
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
>> ---
>>   arch/powerpc/include/asm/ima.h     |  3 ---
>>   arch/powerpc/kexec/ima.c           | 21 ---------------------
>>   security/integrity/ima/ima_kexec.c | 22 ++++++++++++++++++++++
>>   3 files changed, 22 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
>> index d8444d27f0d8..d6ab5d944dcd 100644
>> --- a/arch/powerpc/include/asm/ima.h
>> +++ b/arch/powerpc/include/asm/ima.h
>> @@ -7,9 +7,6 @@
>>   struct kimage;
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> -int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>> -			      size_t size);
>> -
>>   int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
>>   #else
>>   static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
>> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
>> index bf7084c0c4da..b2793be353a9 100644
>> --- a/arch/powerpc/kexec/ima.c
>> +++ b/arch/powerpc/kexec/ima.c
>> @@ -13,27 +13,6 @@
>>   #include <linux/libfdt.h>
>>   #include <asm/ima.h>
>>   
>> -/**
>> - * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
>> - *
>> - * @image: kimage struct to set IMA buffer data
>> - * @load_addr: Starting address where IMA buffer is loaded at
>> - * @size: Number of bytes in the IMA buffer
>> - *
>> - * Architectures should use this function to pass on the IMA buffer
>> - * information to the next kernel.
>> - *
>> - * Return: 0 on success, negative errno on error.
>> - */
>> -int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>> -			      size_t size)
>> -{
>> -	image->arch.ima_buffer_addr = load_addr;
>> -	image->arch.ima_buffer_size = size;
>> -
>> -	return 0;
>> -}
>> -
>>   static int write_number(void *p, u64 value, int cells)
>>   {
>>   	if (cells == 1) {
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 4d354593aecf..5263dafe8f4d 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -74,6 +74,28 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   	return ret;
>>   }
>>   
>> +/**
>> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
>> + *
>> + * @image: kimage struct to set IMA buffer data
>> + * @load_addr: Starting address where IMA buffer is loaded at
>> + * @size: Number of bytes in the IMA buffer
>> + *
>> + * Architectures should use this function to pass on the IMA buffer
>> + * information to the next kernel.
>> + *
>> + * Return: 0 on success, negative errno on error.
>> + */
>> +static int arch_ima_add_kexec_buffer(struct kimage *image,
>> +				     unsigned long load_addr,
>> +				     size_t size)
>> +{
>> +	image->arch.ima_buffer_addr = load_addr;
>> +	image->arch.ima_buffer_size = size;
>> +
>> +	return 0;
>> +}
>> +
> 
> Both powerpc and arm64 use the definition above for
> arch_ima_add_kexec_buffer(), so it makes sense to share them as you do
> in this patch. This file isn't the best one to put arch-specific code
> which happens to be identical among architectures, but I can't think of
> somewhere else to put it.
> 
> For now this isn't an issue since powerpc and arm64 are the only arches
> implementing tihs feature. If a third arch implemented it and also used
> the same function definition as above, it wouldn't be an issue either so
> perhaps this is good enough for the time being? :-)

If Mimi doesn't have any objection, I'll leave this function in this 
file. The other option is to move this function also to 
"drivers/of/kexec.c".

Please let me know.

> 
> With this patch, the `#include <asm/ima.h>` in
> security/integrity/ima/ima.h can be removed. It was there just to
> provide a declaration of arch_ima_add_kexec_buffer().
> 

Sure - will remove this #include.

thanks,
  -lakshmi
