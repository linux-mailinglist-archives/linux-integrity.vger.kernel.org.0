Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0E2CB2CA
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Dec 2020 03:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgLBC0E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 21:26:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55964 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgLBC0E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 21:26:04 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D4B6B20B717A;
        Tue,  1 Dec 2020 18:25:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4B6B20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1606875923;
        bh=8zAZBN7xMgg91o7+5aZk7oyTbbSqBxC+Lh9bjFbKL7A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Za7YFMlkQR7YFVFZjNbKLQhXOxaM/Ozhxo8jt2SfQQxYcTOA+iHOJ+LblUiT+K5nG
         QXKsTQ+mVKJrF2XNnphlFbe6nfQSW0u9kH1FXdbMq0g0mpUAImNAymJzyHFrEWKmXq
         RQXAnGmoCFzlZNI6drbrZ3X0BF2QGF50y72O/i18=
Subject: Re: [PATCH v9 0/8] Carry forward IMA measurement log on kexec on
 ARM64
To:     Mimi Zohar <zohar@linux.ibm.com>, Rob Herring <robh@kernel.org>
Cc:     bauerman@linux.ibm.com, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
 <20201121135719.GA2134870@robh.at.kernel.org>
 <415b4d0b-3d93-40ce-b74e-48fdce7fbf7f@linux.microsoft.com>
 <a73a47da53b795617758cc23991624dfca173eba.camel@linux.ibm.com>
 <76a749ac-8465-1d82-0ff5-0a46e0a29f18@linux.microsoft.com>
 <f25df5ba1cda54f3b7c555367f58f43caf3a3c7d.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <4d776cba-1380-0151-b9b4-4bbbe320742e@linux.microsoft.com>
Date:   Tue, 1 Dec 2020 18:25:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f25df5ba1cda54f3b7c555367f58f43caf3a3c7d.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/1/20 11:15 AM, Mimi Zohar wrote:
> On Tue, 2020-12-01 at 11:10 -0800, Lakshmi Ramasubramanian wrote:
>> On 12/1/20 3:34 AM, Mimi Zohar wrote:
>>> On Sat, 2020-11-21 at 06:38 -0800, Lakshmi Ramasubramanian wrote:
>>>> On 11/21/20 5:57 AM, Rob Herring wrote:
>>>>> On Fri, Nov 13, 2020 at 11:22:35AM -0800, Lakshmi Ramasubramanian wrote:
>>>
>>>>>>     arch/powerpc/include/asm/kexec.h       |   1 -
>>>>>>     arch/powerpc/kexec/Makefile            |   7 +-
>>>>>>     arch/powerpc/kexec/file_load.c         |  32 --------
>>>>>>     arch/powerpc/kexec/ima.c               | 106 ++-----------------------
>>>>>>     drivers/of/Makefile                    |   9 +++
>>>>>
>>>>>>     drivers/of/ima_kexec.c                 |  91 +++++++++++++++++++++
>>>>>>     drivers/of/kexec_fdt.c                 |  55 +++++++++++++
>>>>>
>>>>> Does this need to be 2 files? Just kexec.c?
>>>>
>>>> Since the functions defined in "ima_kexec.c" and "kexec_fdt.c" are
>>>> enabled on 2 different kernel CONFIGs, keeping them in 2 files enables
>>>> us to avoid using "#ifdef" in C files.
>>>
>>> Normally that is true, but just as all of the kexec related functions
>>> are co-located in ima/ima_kexec.c, co-locating all of the kexec related
>>> functions in drivers/of makes sense.
>>>
>>
>> Sounds good - i'll make the change.
>> Instead of "#ifdef" will use "IS_ENABLED" macro, and define the kexec
>> related functions in drivers/of/ima_kexec.c
> 
> Perhaps name the file kexec.c, as Rob suggested.
> 

Will do.

thanks,
  -lakshmi


