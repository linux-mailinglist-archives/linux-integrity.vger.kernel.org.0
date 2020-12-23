Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4542E183A
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 06:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLWFDr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Dec 2020 00:03:47 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33898 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWFDr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Dec 2020 00:03:47 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 770C720B7192;
        Tue, 22 Dec 2020 21:03:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 770C720B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608699786;
        bh=+qWMHabIV1b5Ec2AcABEWGXQMINxp/AybIKM5slhmIo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RvRaYi+lR7Ume2OZNoW3hfzn2O5eGgvqlWIoJv30sqrbOS/BvtZRtYsGRv7OfAIym
         +aN98PTpZnMYs7NrZm8wwLKx4C25mcMEpU+WxT3fz2ehDNFaGRv2SsRbZ7ZAg71paq
         EhS2Bc+r8Jv51WMQu9GTy72e/ZNj44EpZDWT5Oes=
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
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
 <e0d9398b-1b46-8115-7bf0-28e9826fcd6b@linux.microsoft.com>
 <7a347c8f2a76fc80551a3dfcb66b0eec9b024a90.camel@linux.ibm.com>
 <71764175-4007-2828-f882-9215c062330a@linux.microsoft.com>
 <878s9pl5hb.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <159c7e4d-0cad-158f-6f5b-9f3b60159b38@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 21:03:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878s9pl5hb.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/22/20 4:40 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> On 12/22/20 11:45 AM, Mimi Zohar wrote:
>>> On Tue, 2020-12-22 at 10:53 -0800, Lakshmi Ramasubramanian wrote:
>>>> On 12/22/20 6:26 AM, Mimi Zohar wrote:
>>>>
>>>> Hi Mimi,
>>>>
>>>>>
>>>>> On Sat, 2020-12-19 at 09:57 -0800, Lakshmi Ramasubramanian wrote:
>>>>>>
>>>>>> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
>>>>>> index 4aff6846c772..b6c52608cb49 100644
>>>>>> --- a/arch/powerpc/kexec/Makefile
>>>>>> +++ b/arch/powerpc/kexec/Makefile
>>>>>> @@ -9,13 +9,6 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
>>>>>>        obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o
>>>>>> file_load_$(BITS).o elf_$(BITS).o
>>>>>>     -ifdef CONFIG_HAVE_IMA_KEXEC
>>>>>> -ifdef CONFIG_IMA
>>>>>> -obj-y				+= ima.o
>>>>>> -endif
>>>>>> -endif
>>>>>
>>>>> Notice how "kexec/ima.o" is only included if the architecture supports
>>>>> it and IMA is configured.  In addition only if CONFIG_IMA_KEXEC is
>>>>> configured, is the IMA measurement list carried across kexec.  After
>>>>> moving the rest of ima.c to drivers/of/kexec.c, this changes.   Notice
>>>>> how drivers/of/Kconfig includes kexec.o:
>>>>>
>>>>> obj-$(CONFIG_KEXEC_FILE) += kexec.o
>>>>>
>>>>> It is not dependent on CONFIG_HAVE_IMA_KEXEC.  Shouldn't all of the
>>>>> functions defined in ima.c being moved to kexec.o be defined within a
>>>>> CONFIG_HAVE_IMA_KEXEC ifdef?
>>>>>
>>>>
>>>> Thanks for reviewing the changes.
>>>>
>>>> In "drivers/of/kexec.c" the function remove_ima_buffer() is defined
>>>> under "#ifdef CONFIG_HAVE_IMA_KEXEC"
>>>>
>>>> setup_ima_buffer() is defined under "#ifdef CONFIG_IMA_KEXEC" - the same
>>>> way it was defined in "arch/powerpc/kexec/ima.c".
>>>>
>>>> As you know, CONFIG_IMA_KEXEC depends on CONFIG_HAVE_IMA_KEXEC (as
>>>> defined in "security/integrity/ima/Kconfig").
>>>>
>>>> ima_get_kexec_buffer() and ima_free_kexec_buffer() are unconditionally
>>>> defined in "drivers/of/kexec.c" even though they are called only when
>>>> CONFIG_HAVE_IMA_KEXEC is enabled. I will update these two functions to
>>>> be moved under "#ifdef CONFIG_HAVE_IMA_KEXEC"
>>> The issue is the reverse.  CONFIG_HAVE_IMA_KEXEC may be enabled without
>>> CONFIG_IMA_KEXEC being enabled.  This allows the architecture to
>>> support carrying the measurement list across kexec, but requires
>>> enabling it at build time.
>>> Only if CONFIG_HAVE_IMA_KEXEC is enabled should any of these functions
>>> be compiled at build.  This allows restoring the previous IMA
>>> measurement list, even if CONFIG_IMA_KEXEC is not enabled.
>>> Only if CONFIG_IMA_KEXEC is enabled, should carrying the measurement
>>> list across kexec be enabled.  See how arch_ima_add_kexec_buffer,
>>> write_number, setup_ima_buffer are ifdef'ed in
>>> arch/powerpc/kexec/ima.c.
>>>
>>
>> Yes - I agree. I will make the following changes:
>>
>> => Enable the functions moved from "arch/powerpc/kexec/ima.c" to
>> "drivers/of/kexec.c" only when CONFIG_HAVE_IMA_KEXEC is enabled.
>>
>> => Also, compile write_number() and setup_ima_buffer() only when
>> CONFIG_IMA_KEXEC is enabled.
> 
> Sounds good, with one additional change:
> 
> So far, CONFIG_HAVE_IMA_KEXEC was tested only in files that were built
> when CONFIG_IMA was set. With this series this is not the case anymore
> (in drivers/of/kexec.c). The simplest way to keep this consistent is to
> only enable CONFIG_HAVE_IMA_KEXEC if CONFIG_IMA is also set.
> 
> For example, with this:
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e9f13fe08492..4ddd17215ecf 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -548,7 +548,7 @@ config KEXEC
>   config KEXEC_FILE
>   	bool "kexec file based system call"
>   	select KEXEC_CORE
> -	select HAVE_IMA_KEXEC
> +	select HAVE_IMA_KEXEC if IMA
>   	select BUILD_BIN2C
>   	select KEXEC_ELF
>   	depends on PPC64
> 
> And then the same thing on the arm64 patch.

This is a good idea Thiago - I will make this change in the Kconfig for 
both powerpc and arm64.

thanks,
  -lakshmi


