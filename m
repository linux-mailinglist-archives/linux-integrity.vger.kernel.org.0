Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD652E1832
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 05:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgLWE51 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 23:57:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33010 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgLWE51 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 23:57:27 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id BD2E520B7192;
        Tue, 22 Dec 2020 20:56:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD2E520B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608699406;
        bh=XGD1UGZ6RZjC4xpp5KtSuriQKt2Ml3utmTd4kuwn/SE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WrWIEPk23qk6GDC6v9DLLAM7WGqBG2c+BJWDZg0LRo3Azp7AVj9K3Bx7F/t5Wb8Xx
         UoGdCX5PxPaBaBWFUz/bTcPDju+dcNjrYC+dZ2cR5h/2S2qK/qiF1LuOwq0eMY6tqJ
         9ck7wm9S4v8Tbqh22HOo2ttRSwuC/4+ye9E6MwG4=
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
 <875z4tl54t.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <caf829a6-4d88-d932-f1cb-7dc16817719d@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 20:56:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z4tl54t.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/22/20 4:48 PM, Thiago Jung Bauermann wrote:
> 
> Actually, I have one more comment on this patch:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
>> index 956bcb2d1ec2..9f3ec0b239ef 100644
>> --- a/arch/powerpc/kexec/file_load.c
>> +++ b/arch/powerpc/kexec/file_load.c
>> @@ -20,7 +20,6 @@
>>   #include <linux/of_fdt.h>
>>   #include <linux/libfdt.h>
>>   #include <asm/setup.h>
>> -#include <asm/ima.h>
>>   
>>   #define SLAVE_CODE_SIZE		256	/* First 0x100 bytes */
>>   
>> @@ -163,12 +162,6 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
>>   	if (ret)
>>   		goto err;
>>   
>> -	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
>> -	if (ret) {
>> -		pr_err("Error setting up the new device tree.\n");
>> -		return ret;
>> -	}
>> -
>>   	return 0;
>>   
>>   err:
> 
> With this change, setup_new_fdt() is nothing more than a call to
> of_kexec_setup_new_fdt(). It should be removed, and its caller should
> call of_kexec_setup_new_fdt() directly.
> 
> This change could be done in patch 4 of this series, to keep this patch
> simpler.
> 

Sure Thiago - I will make that change.

thanks,
  -lakshmi
