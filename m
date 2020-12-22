Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159EC2E1098
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 00:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgLVXdy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 18:33:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44776 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgLVXdy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 18:33:54 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A632520B83DE;
        Tue, 22 Dec 2020 15:33:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A632520B83DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608679993;
        bh=fTplnXce8AUizepgT9tlgsV7Lx9McrTCz0G/NnMQFbk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gGnJRy48t4QVjJIZCI+rIS9RJemKGB3g4bEhcrKN+UwtQj3F1R0qPwjiaXJJOpTsB
         4spvBH2HXEKkuq0V7UH/6OETY4rdN5pjeYeCiw/YusykEMH786W9HvX9+rGszMgMM1
         GTWxH/FXOU3n6uYGUTH9DxNk/0iIRL9RL4Ello/s=
Subject: Re: [RFC PATCH 4/4] powerpc: Use common of_kexec_setup_new_fdt()
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Rob Herring <robh@kernel.org>
Cc:     takahiro.akashi@linaro.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, zohar@linux.ibm.com,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-5-robh@kernel.org>
 <87h7odld3x.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <fbe0f26e-decd-a158-8787-9853a4ca7a6b@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 15:33:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7odld3x.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/22/20 1:55 PM, Thiago Jung Bauermann wrote:
> 
> Rob Herring <robh@kernel.org> writes:
> 
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> After the IMA changes, delete_fdt_mem_rsv() can also be removed.
>>
>>   arch/powerpc/kexec/file_load.c | 125 ++-------------------------------
>>   1 file changed, 6 insertions(+), 119 deletions(-)
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Shouldn't this series also be Cc'd to the linuxppc-dev mailing list?
> 
> I just noticed that the ARM64 IMA kexec series hasn't been copying the
> linuxppc-dev mailing list, so perhaps this is why this series isn't
> doing that, either.

Thanks for pointing that out Thiago.
I will copy linuxppc-dev mailing list (linuxppc-dev@vger.kernel.org) 
when I post v14 of my patch set.

  -lakshmi

> 
>> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
>> index e452b11df631..956bcb2d1ec2 100644
>> --- a/arch/powerpc/kexec/file_load.c
>> +++ b/arch/powerpc/kexec/file_load.c
>> @@ -16,6 +16,7 @@
>>
>>   #include <linux/slab.h>
>>   #include <linux/kexec.h>
>> +#include <linux/of.h>
>>   #include <linux/of_fdt.h>
>>   #include <linux/libfdt.h>
>>   #include <asm/setup.h>
> 
> It's possible to remove the <linux/of_fdt.h> include now.
> 

