Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF322320F32
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 02:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBVBgo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 20:36:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44656 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhBVBgl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 20:36:41 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D759320B57A0;
        Sun, 21 Feb 2021 17:35:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D759320B57A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613957760;
        bh=ExCdsyPkQI85bgvWno/UIC3VrrC79Ve3YTXOyYnfvYU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qq4J4yH6UugpeNQ3CD/H/jYSDYubKgYDrULJm5MSRGGMy4pVUF3ZhkkpFDiz4UKpC
         Fbe9plxzMLfQUkOqW20+R5R0Fp3HF31QA9jJO+T4Drq2NGRAd0AXMWGRuiHddmF4lc
         s/bgSL36U18cNAWtIPD4IoDQS7mWtllOclFbv2tE=
Subject: Re: [PATCH v18 03/11] of: Add a common kexec FDT setup function
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, mark.rutland@arm.com, benh@kernel.crashing.org,
        tao.li@vivo.com, paulus@samba.org, vincenzo.frascino@arm.com,
        frowand.list@gmail.com, sashal@kernel.org, masahiroy@kernel.org,
        jmorris@namei.org, allison@lohutok.net, serge@hallyn.com,
        devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
        prsriva@linux.microsoft.com, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
        mbrugger@suse.com, balajib@linux.microsoft.com,
        dmitry.kasatkin@gmail.com, linux-kernel@vger.kernel.org,
        james.morse@arm.com, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
 <20210213161049.6190-4-nramas@linux.microsoft.com>
 <20210222013207.GA142216@roeck-us.net>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b4237414-24ec-f905-2561-6237081ea7ff@linux.microsoft.com>
Date:   Sun, 21 Feb 2021 17:35:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222013207.GA142216@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/21/21 5:32 PM, Guenter Roeck wrote:

Hi Guenter,

> On Sat, Feb 13, 2021 at 08:10:41AM -0800, Lakshmi Ramasubramanian wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> Both arm64 and powerpc do essentially the same FDT /chosen setup for
>> kexec.  The differences are either omissions that arm64 should have
>> or additional properties that will be ignored.  The setup code can be
>> combined and shared by both powerpc and arm64.
>>
>> The differences relative to the arm64 version:
>>   - If /chosen doesn't exist, it will be created (should never happen).
>>   - Any old dtb and initrd reserved memory will be released.
>>   - The new initrd and elfcorehdr are marked reserved.
>>   - "linux,booted-from-kexec" is set.
>>
>> The differences relative to the powerpc version:
>>   - "kaslr-seed" and "rng-seed" may be set.
>>   - "linux,elfcorehdr" is set.
>>   - Any existing "linux,usable-memory-range" is removed.
>>
>> Combine the code for setting up the /chosen node in the FDT and updating
>> the memory reservation for kexec, for powerpc and arm64, in
>> of_kexec_alloc_and_setup_fdt() and move it to "drivers/of/kexec.c".
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> s390:allmodconfig:
> 
> drivers/of/kexec.c: In function 'of_kexec_alloc_and_setup_fdt':
> drivers/of/kexec.c:378:10: error: 'const struct kimage' has no member named 'arch'
>    378 |     image->arch.elf_load_addr,
>        |          ^~
> drivers/of/kexec.c:379:10: error: 'const struct kimage' has no member named 'arch'
>    379 |     image->arch.elf_headers_sz);
>        |          ^~
> drivers/of/kexec.c:387:35: error: 'const struct kimage' has no member named 'arch'
>    387 |   ret = fdt_add_mem_rsv(fdt, image->arch.elf_load_addr,
>        |                                   ^~
> drivers/of/kexec.c:388:16: error: 'const struct kimage' has no member named 'arch'
>    388 |           image->arch.elf_headers_sz);
>        |                ^~
> 

I have posted a new patch set (link given below) that fixes the above 
build break. Could you please try that?

https://patchwork.kernel.org/project/linux-integrity/patch/20210221174930.27324-14-nramas@linux.microsoft.com/

thanks,
  -lakshmi

