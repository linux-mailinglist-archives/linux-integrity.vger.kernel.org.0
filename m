Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF24D25D0AA
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 06:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgIDEpK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 00:45:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37812 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgIDEpK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 00:45:10 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5F05720B7178;
        Thu,  3 Sep 2020 21:45:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F05720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599194709;
        bh=RpWQ073VIH14t43XVqWmodh+nr8CLXf0OhaMaz/PNpc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cnfSSiYIMeDx3WseF4w/2m+nlcpw4+brLUAvvqJlkCYcflBi5aoUZkVgJfMfEie/r
         qJwuc8VtLvNBaY3w3rLneU8aYeouhqFMS0+sfDCvts1Vg2chTDxPkh2Fgn7B6m9hJP
         tQ3xjemvbysiY6NFgWs38yVgrku/wbWvPZ/omWbw=
Subject: Re: [PATCH v5 3/3] arm64: Add IMA kexec buffer to DTB
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
References: <20200901195029.30039-1-nramas@linux.microsoft.com>
 <20200901195029.30039-4-nramas@linux.microsoft.com>
 <87sgbyy0gr.fsf@morokweng.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <35e3e3b0-541c-8a93-8c2f-b7659090d41f@linux.microsoft.com>
Date:   Thu, 3 Sep 2020 21:45:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87sgbyy0gr.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/3/20 3:11 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> The address and size of the current kernel's IMA measurement log
>> need to be added to the device tree's IMA kexec buffer node for
>> the log to be carried over to the next kernel on the kexec call.
>>
>> Add the IMA measurement log buffer properties to the device tree for
>> ARM64 and reserve the memory for storing the IMA log.
>> Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to
>> indicate that the IMA measurement log information is present in
>> the device tree.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/arm64/Kconfig                     |  1 +
>>   arch/arm64/kernel/machine_kexec_file.c | 15 +++++++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6d232837cbee..9f03c8245e5b 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1077,6 +1077,7 @@ config KEXEC
>>   config KEXEC_FILE
>>   	bool "kexec file based system call"
>>   	select KEXEC_CORE
>> +	select HAVE_IMA_KEXEC
>>   	help
>>   	  This is new version of kexec system call. This system call is
>>   	  file based and takes file descriptors as system call argument
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 361a1143e09e..0fe3d629eefe 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -136,6 +136,21 @@ static int setup_dtb(struct kimage *image,
>>   				FDT_PROP_KASLR_SEED);
>>   	}
>>   
>> +	/* add ima-kexec-buffer */
>> +	if (image->arch.ima_buffer_size > 0) {
>> +		ret = fdt_appendprop_addrrange(dtb, 0, off,
>> +				FDT_PROP_IMA_KEXEC_BUFFER,
>> +				image->arch.ima_buffer_addr,
>> +				image->arch.ima_buffer_size);
>> +		if (ret)
>> +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
>> +
>> +		ret = fdt_add_mem_rsv(dtb, image->arch.ima_buffer_addr,
>> +				      image->arch.ima_buffer_size);
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
>>   	/* add rng-seed */
>>   	if (rng_is_initialized()) {
>>   		void *rng_seed;
> 
> I just noticed one more thing this code isn't doing compared to the
> powerpc version (sorry to bring these issues piecemeal, I didn't realize
> this before):
> 
> You're not checking whether there already is a device tree property and
> corresponding memory reservation for an IMA kexec buffer that the
> currently running kernel might have received from a previous kernel. In
> that case, this code will do the wrong thing because
> fdt_appendprop_addrrange() will append the range to the existing
> property, which is not what you want. You'll also have a memory
> reservation entry for a stale IMA kexec buffer, which just wastes
> memory.
> 
> So one thing you need to do, whether or not there's an IMA kexec buffer
> to be passed to the next kernel, is to remove any existing
> FDT_PROP_IMA_KEXEC_BUFFER property and also its corresponding memory
> reservation, so that you avoid accumulating stale memory reservations
> for non-existing IMA kexec buffers from previous kexecs.
> 

That's good catch Thiago. Thanks for the feedback. I'll make this change 
and update.

thanks,
  -lakshmi

