Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A640F2E0E72
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 19:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgLVSyT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 13:54:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38580 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLVSyT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 13:54:19 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C490C20B83DE;
        Tue, 22 Dec 2020 10:53:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C490C20B83DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608663218;
        bh=//PxRnptZMzVjXYlyIzWx/0zydVkwQDoYcP2NBeyDZ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hb9HWHUZ+LQw+0OkX+tP5HdR/Q7wQOGoBlOskRnaFQ9kuqceUyz0iOqmuPLV+VsI6
         V1Jtbm11qxpVrmrWUGgcl9d8+EW5IESynwTuFoKFmuHwK2PM/gmJU17L5+D/ZXVouc
         gy+KEEVaVTjiZoJHevX/cRW3Nc/dI01qh7Y6625M=
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-3-nramas@linux.microsoft.com>
 <a1a4526c0759eb3b5d70fb8edc89360718376def.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <e0d9398b-1b46-8115-7bf0-28e9826fcd6b@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 10:53:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a1a4526c0759eb3b5d70fb8edc89360718376def.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/22/20 6:26 AM, Mimi Zohar wrote:

Hi Mimi,

> 
> On Sat, 2020-12-19 at 09:57 -0800, Lakshmi Ramasubramanian wrote:
>>
>> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
>> index 4aff6846c772..b6c52608cb49 100644
>> --- a/arch/powerpc/kexec/Makefile
>> +++ b/arch/powerpc/kexec/Makefile
>> @@ -9,13 +9,6 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
>>   
>>   obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
>>   
>> -ifdef CONFIG_HAVE_IMA_KEXEC
>> -ifdef CONFIG_IMA
>> -obj-y				+= ima.o
>> -endif
>> -endif
> 
> Notice how "kexec/ima.o" is only included if the architecture supports
> it and IMA is configured.  In addition only if CONFIG_IMA_KEXEC is
> configured, is the IMA measurement list carried across kexec.  After
> moving the rest of ima.c to drivers/of/kexec.c, this changes.   Notice
> how drivers/of/Kconfig includes kexec.o:
> 
> obj-$(CONFIG_KEXEC_FILE) += kexec.o
> 
> It is not dependent on CONFIG_HAVE_IMA_KEXEC.  Shouldn't all of the
> functions defined in ima.c being moved to kexec.o be defined within a
> CONFIG_HAVE_IMA_KEXEC ifdef?
> 

Thanks for reviewing the changes.

In "drivers/of/kexec.c" the function remove_ima_buffer() is defined 
under "#ifdef CONFIG_HAVE_IMA_KEXEC"

setup_ima_buffer() is defined under "#ifdef CONFIG_IMA_KEXEC" - the same 
way it was defined in "arch/powerpc/kexec/ima.c".

As you know, CONFIG_IMA_KEXEC depends on CONFIG_HAVE_IMA_KEXEC (as 
defined in "security/integrity/ima/Kconfig").

ima_get_kexec_buffer() and ima_free_kexec_buffer() are unconditionally 
defined in "drivers/of/kexec.c" even though they are called only when 
CONFIG_HAVE_IMA_KEXEC is enabled. I will update these two functions to 
be moved under "#ifdef CONFIG_HAVE_IMA_KEXEC"

Rob/Mimi/Thiago - Please let me know if you have other comments in the 
v13 patches. Will address those as well and post v14.

thanks,
  -lakshmi
