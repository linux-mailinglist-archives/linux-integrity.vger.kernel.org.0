Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89032E1837
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 06:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgLWFCe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Dec 2020 00:02:34 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33708 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWFCe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Dec 2020 00:02:34 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 08A6C20B7192;
        Tue, 22 Dec 2020 21:01:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08A6C20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608699713;
        bh=jvhh/Z2/WSlyeBqb+UrNARECAlTWvMC3tRARFOQqgQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dD8+/9CsGqR4mNrHeZSfZKjwbN22nfNq9P1nYds8tsd2JGh5KTdKuI5R2Nlo/jIh/
         OfeRlveugjpKV1wIoEBxhhSSIDVC6iV18AABbDlj+rVC5enFFHGtRoUiH90ZzZyoiU
         5htWpiqbVtinOGKHLmej7EBQqqW1FD/LHkQ20NeE=
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-3-nramas@linux.microsoft.com>
 <87blell6g2.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6d7e0147-b5e4-d364-af7d-c089217e3fb0@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 21:01:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87blell6g2.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/22/20 4:19 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> The functions defined in "arch/powerpc/kexec/ima.c" handle setting up
>> and freeing the resources required to carry over the IMA measurement
>> list from the current kernel to the next kernel across kexec system call.
>> These functions do not have architecture specific code, but are
>> currently limited to powerpc.
>>
>> Move setup_ima_buffer() call into of_kexec_setup_new_fdt() defined in
>> "drivers/of/kexec.c".
>>
>> Move the remaining architecture independent functions from
>> "arch/powerpc/kexec/ima.c" to "drivers/of/kexec.c".
>> Delete "arch/powerpc/kexec/ima.c" and "arch/powerpc/include/asm/ima.h".
>> Remove references to the deleted files in powerpc and in ima.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/powerpc/include/asm/ima.h     |  27 ----
>>   arch/powerpc/kexec/Makefile        |   7 -
>>   arch/powerpc/kexec/file_load.c     |   7 -
>>   arch/powerpc/kexec/ima.c           | 202 -------------------------
>>   drivers/of/kexec.c                 | 235 +++++++++++++++++++++++++++++
>>   include/linux/of.h                 |   2 +
>>   security/integrity/ima/ima.h       |   4 -
>>   security/integrity/ima/ima_kexec.c |   1 +
>>   8 files changed, 238 insertions(+), 247 deletions(-)
>>   delete mode 100644 arch/powerpc/include/asm/ima.h
>>   delete mode 100644 arch/powerpc/kexec/ima.c
> 
> This looks good, provided the changes from the discussion with Mimi are
> made. Also, minor nits below.

I will address the changes Mimi had stated.

> 
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 6ebefec616e4..7c3947ad3773 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -24,10 +24,6 @@
>>   
>>   #include "../integrity.h"
>>   
>> -#ifdef CONFIG_HAVE_IMA_KEXEC
>> -#include <asm/ima.h>
>> -#endif
>> -
>>   enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
>>   		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
>>   enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
> 
> This belongs in patch 1.

No - the reference to "asm/ima.h" cannot be removed in Patch #1 since 
ima_get_kexec_buffer() and ima_free_kexec_buffer() are still declared in 
this header. They are moved in this patch only (Patch #2).

>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 38bcd7543e27..8a6712981dee 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/kexec.h>
>> +#include <linux/of.h>
>>   #include <linux/ima.h>
>>   #include "ima.h"
> 
> This include isn't necessary.

This change is necessary because ima_get_kexec_buffer() and 
ima_free_kexec_buffer() are now declared in "linux/of.h".

  -lakshmi



