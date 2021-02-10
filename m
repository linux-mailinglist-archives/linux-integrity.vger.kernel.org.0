Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52B6316DA9
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhBJSCb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 13:02:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33662 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhBJSA2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 13:00:28 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id E1A6C20B6C40;
        Wed, 10 Feb 2021 09:59:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1A6C20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612979986;
        bh=RxMU+6LvrmWqnc2DIvDKSobw3xIYfkJxDlkl4WJG9pA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rXKegh2/YA91tBR+aWotNVHPxyoiZ82CI7iw5lH0BizvhUionT/gtjxrVFB+WbgfU
         /46GfI1+XXkGMKqtIoTDNJAqgO/+8RJErnwcCffAfUIdMKltR0eb8elSvTpKPn89Qn
         7IjMliBK0tfTmURhDQ4q8qNf9EkEv1qqQVKvwopw=
Subject: Re: [PATCH v17 02/10] of: Add a common kexec FDT setup function
To:     Rob Herring <robh@kernel.org>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-3-nramas@linux.microsoft.com>
 <20210210172307.GB2361245@robh.at.kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f464508d-fcbe-f3a2-07d5-88fd0f6e4c04@linux.microsoft.com>
Date:   Wed, 10 Feb 2021 09:59:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210172307.GB2361245@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/10/21 9:23 AM, Rob Herring wrote:
> On Tue, Feb 09, 2021 at 10:21:52AM -0800, Lakshmi Ramasubramanian wrote:
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
>> ---
>>   drivers/of/Makefile |   6 ++
>>   drivers/of/kexec.c  | 258 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of.h  |  13 +++
>>   3 files changed, 277 insertions(+)
>>   create mode 100644 drivers/of/kexec.c


>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 4b27c9a27df3..f0eff5e84353 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -560,6 +560,19 @@ int of_map_id(struct device_node *np, u32 id,
>>   
>>   phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
>>   
>> +/*
>> + * Additional space needed for the buffer to build the new FDT
>> + * so that we can add initrd, bootargs, kaslr-seed, rng-seed,
>> + * userable-memory-range and elfcorehdr.
>> + */
>> +#define FDT_EXTRA_SPACE 0x1000
> 
> No need for this to be public now. Move it to of/kexec.c.
> 

Will do.

  -lakshmi


