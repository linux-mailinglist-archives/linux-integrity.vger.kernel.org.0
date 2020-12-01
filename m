Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963BA2CAB64
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389068AbgLATG3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 14:06:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55168 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgLATG3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 14:06:29 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 585DE20B717A;
        Tue,  1 Dec 2020 11:05:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 585DE20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1606849547;
        bh=1bXx8POpNuesUco9nR+1jimVOmyvNWOw/SyzMIguCxg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YDf3JFolHlEBiE//7wtGnx6S6VMjjvZWd5bAYkhNqd6tKNAosz0AzEi6izfC0LqlQ
         1Vd+eUrcbf703H+SNMgUI5Ynhj+m3TuFnZq9xj3sIMi3qGqczDZZWC4J5yE0oKriU1
         QtXyCskkkgmIu5R7qwx1Kca7XaQ1YNa4ND8Av8/A=
Subject: Re: [PATCH v9 6/8] powerpc: Move ima_get_kexec_buffer() and
 ima_free_kexec_buffer() to ima
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
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
 <20201113192243.1993-7-nramas@linux.microsoft.com>
 <493cf3c91579877d7e9cb79ad87ac086671d6ffc.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <19d10383-7059-ff90-37d1-7806585b331d@linux.microsoft.com>
Date:   Tue, 1 Dec 2020 11:05:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <493cf3c91579877d7e9cb79ad87ac086671d6ffc.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/1/20 3:38 AM, Mimi Zohar wrote:
> Hi Lakshmi,
> 
> On Fri, 2020-11-13 at 11:22 -0800, Lakshmi Ramasubramanian wrote:
>> ima_get_kexec_buffer() retrieves the address and size of the buffer
>> used for carrying forward the IMA measurement logs on kexec from
>> the device tree.
>>
>> ima_free_kexec_buffer() removes the chosen node namely
>> "linux,ima-kexec-buffer" from the device tree, and frees the buffer
>> used for carrying forward the IMA measurement logs on kexec.
>>
>> These functions do not have architecture specific code, but are
>> currently limited to powerpc.
>>
>> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to ima_kexec.c
>> in IMA so that they are accessible for other architectures as well.
> 
> This sentence flows from the previous line.  No need for separate
> paragraphs here.

Sure - will update Mimi.

>>
>> With the above change the functions in arch/powerpc/kexec/ima.c are
>> defined only when the kernel config CONFIG_IMA_KEXEC is enabled.
>> Update the Makefile to build arch/powerpc/kexec/ima.c only when
>> CONFIG_IMA_KEXEC is enabled and remove "#ifdef CONFIG_IMA_KEXEC"
>> in arch/powerpc/kexec/ima.c.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> After making the two changes,
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> 
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 121de3e04af2..3f0fa2673dd3 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -9,9 +9,60 @@
>>   
>>   #include <linux/seq_file.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/memblock.h>
>> +#include <linux/of.h>
>>   #include <linux/kexec.h>
>> +#include <linux/ima.h>
>>   #include "ima.h"
>>   
>> +/**
>> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>> + * @addr:	On successful return, set to point to the buffer contents.
>> + * @size:	On successful return, set to the buffer size.
>> + *
>> + * Return: 0 on success, negative errno on error.
>> + */
>> +static int ima_get_kexec_buffer(void **addr, size_t *size)
>> +{
>> +	int ret;
>> +	unsigned long tmp_addr;
>> +	size_t tmp_size;
>> +
>> +	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*addr = __va(tmp_addr);
>> +	*size = tmp_size;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ima_free_kexec_buffer - free memory used by the IMA buffer
>> + */
>> +static int ima_free_kexec_buffer(void)
>> +{
>> +	int ret;
>> +	unsigned long addr;
>> +	size_t size;
>> +	struct property *prop;
>> +
>> +	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
>> +	if (!prop)
>> +		return -ENOENT;
>> +
>> +	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_remove_property(of_chosen, prop);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return memblock_free(addr, size);
>> +}
>> +
> 
> Please move these functions, after the ifdef below, before the function
> where they're used.

Will make the above change.

thanks,
  -lakshmi

> 
>>   #ifdef CONFIG_IMA_KEXEC
>>   static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   				     unsigned long segment_size)
> 

