Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E8029509B
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444504AbgJUQUh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Oct 2020 12:20:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41046 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444499AbgJUQUg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Oct 2020 12:20:36 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D988420B4905;
        Wed, 21 Oct 2020 09:20:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D988420B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603297235;
        bh=UNeDR+n68uDFmqC9SMWAFNgDgsQzAZUUOaqRegCPxtE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FRPhseunculQdArN+Aug2a3krX0YrS2zQzHf7wbx9uJ1Yv7jgIr8SRlp3gKX9Lqp6
         Oc/p2ouvXetiqzIthBlua5PvwcunCtF+HIEZTJwqD3aTZ/FjTbc8puh1FmwDrH6MQZ
         wZhk9vbgriemOz4zHE8Gu+PH/bu8HHdxIuVhB06I=
Subject: Re: [PATCH v7 2/4] powerpc: Refactor kexec functions to move arch
 independent code to ima
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
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
 <20200930205941.1576-3-nramas@linux.microsoft.com>
 <ecc13356983d5cff536c53c4da98a839ea9a0f19.camel@linux.ibm.com>
 <9a44d8aa-515d-fc97-74bd-7ae976dea35b@linux.microsoft.com>
 <b8e04f61016b558ad62c4ac0aba183bab521664c.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9712c6bd-b0f8-773f-0b54-828410c61f50@linux.microsoft.com>
Date:   Wed, 21 Oct 2020 09:20:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b8e04f61016b558ad62c4ac0aba183bab521664c.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/20/20 8:50 PM, Mimi Zohar wrote:
> Hi Lakshmi,
> 
> On Tue, 2020-10-20 at 19:38 -0700, Lakshmi Ramasubramanian wrote:
>> On 10/20/20 1:01 PM, Mimi Zohar wrote:
>>> On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
>>>> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
>>>> that handle carrying forward the IMA measurement logs on kexec for
>>>> powerpc do not have architecture specific code, but they are currently
>>>> defined for powerpc only.
>>>>
>>>> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
>>>> subsystem. A later patch in this series will use these functions for
>>>> carrying forward the IMA measurement log for ARM64.
>>>>
>>>> With the above refactoring arch/powerpc/kexec/ima.c contains only
>>>> functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
>>>> in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
>>>> when CONFIG_IMA_KEXEC is enabled.
>>>>
>>>> Move ima_dump_measurement_list() and ima_add_kexec_buffer() to
>>>> a new file namely ima_kexec_fdt.c in IMA. Update
>>>> security/integrity/ima/Makefile to include ima_kexec_fdt.c only
>>>> when CONFIG_IMA_KEXEC is enabled.
>>>>
>>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>
>>> The existing support for carrying the IMA measurement list across kexec
>>> is limited to powerpc.  This patch set is adding similar support for
>>> arm64, making as much of the existing code as generic as possible.
>>> However ima_dump_measurement_list() is already generic, but for some
>>> reason this patch moves it to ima_kexec_fdt.c.  ima_kexec_fdt.c should
>>> be limited to device tree specific code.
>>
>> I wanted to split the functions defined under CONFIG_HAVE_IMA_KEXEC and
>> CONFIG_IMA_KEXEC to separate files so that we can get rid of #ifdef in C
>> file and instead conditionally compile the C files (using Makefile).
>>
>> ima_dump_measurement_list() need to be defined only when
>> CONFIG_IMA_KEXEC is defined. I moved it to ima_kexec_fdt.c
> 
> In this case, everything in ima_kexec.c relates to carrying or
> restoring the measurement list.  It's a logical unit.  Separating them
> doesn't make sense.
> 

Sounds good - I'll keep ima_dump_measurement_list() and 
ima_add_kexec_buffer() in ima_kexec.c as it was earlier.

>>
>> Instead of ima_kexec_fdt.c, where ima_dump_measurement_list() and
>> ima_add_kexec_buffer() are defined, perhaps I can change the file name
>> to "ima_kexec_buffer.c". Would that be better?
> 
> I don't understand why adding support for carrying the IMA measurement
> across kexec on ARM64, should require any changes in the IMA loading
> and restoring the measurement list code itself.  Please minimize the
> changes.

Agreed - will do.

thanks,
  -lakshmi


