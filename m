Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295DC2D090D
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 03:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgLGB7c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 20:59:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50466 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgLGB7c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 20:59:32 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5145D20B717A;
        Sun,  6 Dec 2020 17:58:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5145D20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607306330;
        bh=/Cf/yRbzOnG3giC2ND9eUvtQX6RISOvFZQvATkLTaFU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nOYMQ/dt9AclhKQs005/+KumMAR8tyldVDRNe8AazFu3FFcBOX/fGdtlGtv4ID4Ez
         8Cp0NiOUwNfXAsHEfP3Vo7IVaNAIyCWg5o2E+86P5MvmmS5/iAwWsVwgt7RWH5EwAn
         MTm6yhn2WAcvO4j8c68LDIV0Mqg0Ow0WBI5oNFFE=
Subject: Re: [PATCH v10 6/8] powerpc: Move ima_get_kexec_buffer() and
 ima_free_kexec_buffer() to ima
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
 <20201204195149.611-7-nramas@linux.microsoft.com>
 <87mtysm0fk.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <4ca5be10-7fd0-baa9-61b6-bfce101e218b@linux.microsoft.com>
Date:   Sun, 6 Dec 2020 17:58:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87mtysm0fk.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/5/20 1:02 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> ima_get_kexec_buffer() retrieves the address and size of the buffer
>> used for carrying forward the IMA measurement logs on kexec from
>> the device tree.
>>
>> ima_free_kexec_buffer() removes the chosen node
>> "linux,ima-kexec-buffer" from the device tree, and frees the buffer
>> used for carrying forward the IMA measurement logs on kexec.
>>
>> These functions do not have architecture specific code, but are
>> currently limited to powerpc. Move ima_get_kexec_buffer() and
>> ima_free_kexec_buffer() to ima_kexec.c in IMA so that they are
>> accessible for other architectures as well.
>>
>> With the above change the functions in arch/powerpc/kexec/ima.c are
>> defined only when the kernel config CONFIG_IMA_KEXEC is enabled.
>> Update the Makefile to build arch/powerpc/kexec/ima.c only when
>> CONFIG_IMA_KEXEC is enabled and remove "#ifdef CONFIG_IMA_KEXEC"
>> in arch/powerpc/kexec/ima.c.
> 
> Nice.
> 
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Just a small nit below:
> 
>> ---
>>   arch/powerpc/include/asm/ima.h     |  3 --
>>   arch/powerpc/kexec/Makefile        |  7 +---
>>   arch/powerpc/kexec/ima.c           | 50 -----------------------------
>>   security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++++++++++++++
>>   4 files changed, 52 insertions(+), 59 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
>> index a2fc71bc3b23..d8444d27f0d8 100644
>> --- a/arch/powerpc/include/asm/ima.h
>> +++ b/arch/powerpc/include/asm/ima.h
>> @@ -6,9 +6,6 @@
>>   
>>   struct kimage;
>>   
>> -int ima_get_kexec_buffer(void **addr, size_t *size);
>> -int ima_free_kexec_buffer(void);
>> -
>>   #ifdef CONFIG_IMA_KEXEC
>>   int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>>   			      size_t size);
>> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
>> index 4aff6846c772..f54a9dbff4c8 100644
>> --- a/arch/powerpc/kexec/Makefile
>> +++ b/arch/powerpc/kexec/Makefile
>> @@ -9,12 +9,7 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
>>   
>>   obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
>>   
>> -ifdef CONFIG_HAVE_IMA_KEXEC
>> -ifdef CONFIG_IMA
>> -obj-y				+= ima.o
>> -endif
>> -endif
>> -
>> +obj-$(CONFIG_IMA_KEXEC)		+= ima.o
>>   
>>   # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>>   GCOV_PROFILE_core_$(BITS).o := n
>> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
>> index 68017123b07d..bf7084c0c4da 100644
>> --- a/arch/powerpc/kexec/ima.c
>> +++ b/arch/powerpc/kexec/ima.c
>> @@ -13,55 +13,6 @@
>>   #include <linux/libfdt.h>
>>   #include <asm/ima.h>
> 
> With this patch, the following includes become unnecessary and can be
> removed from this file:
> 
> #include <linux/of.h>
> #include <linux/memblock.h>
> 

Sure - will make this change.

thanks,
  -lakshmi

>> -/**
>> - * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>> - * @addr:	On successful return, set to point to the buffer contents.
>> - * @size:	On successful return, set to the buffer size.
>> - *
>> - * Return: 0 on success, negative errno on error.
>> - */
>> -int ima_get_kexec_buffer(void **addr, size_t *size)
>> -{
>> -	int ret;
>> -	unsigned long tmp_addr;
>> -	size_t tmp_size;
>> -
>> -	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
>> -	if (ret)
>> -		return ret;
>> -
>> -	*addr = __va(tmp_addr);
>> -	*size = tmp_size;
>> -
>> -	return 0;
>> -}
>> -
>> -/**
>> - * ima_free_kexec_buffer - free memory used by the IMA buffer
>> - */
>> -int ima_free_kexec_buffer(void)
>> -{
>> -	int ret;
>> -	unsigned long addr;
>> -	size_t size;
>> -	struct property *prop;
>> -
>> -	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
>> -	if (!prop)
>> -		return -ENOENT;
>> -
>> -	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
>> -	if (ret)
>> -		return ret;
>> -
>> -	ret = of_remove_property(of_chosen, prop);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return memblock_free(addr, size);
>> -}
>> -
>> -#ifdef CONFIG_IMA_KEXEC
>>   /**
>>    * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
>>    *
>> @@ -154,4 +105,3 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>>   
>>   	return 0;
>>   }
>> -#endif /* CONFIG_IMA_KEXEC */
> 

