Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7C12DDE94
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Dec 2020 07:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbgLRG0P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Dec 2020 01:26:15 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41910 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732647AbgLRG0P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Dec 2020 01:26:15 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C95CC20B717A;
        Thu, 17 Dec 2020 22:25:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C95CC20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608272734;
        bh=etZWIFSAunWvvTytCwaw4eRuJpjTSSwN3EVqRwxTxgo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dPeYTdzlbJyy71yFOMqIIPpxr4tH8rS154kSISMKYsrQ299j4AjVgYC8DJFV3V2zW
         EUckcDbECnnMo+b9KomsWtVYJj2oS79xkCOdcjWtxtVs5CULWLV9KZn5z3r6OqO19P
         90dxam6rHhIKp8WnQe2IMDyJw3W6j0heDI8ijGy8=
Subject: Re: [PATCH v12 2/4] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
To:     Rob Herring <robh@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        vincenzo.frascino@arm.com, Mark Rutland <mark.rutland@arm.com>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
References: <20201217173708.6940-1-nramas@linux.microsoft.com>
 <20201217173708.6940-3-nramas@linux.microsoft.com>
 <20201217200510.GA105447@robh.at.kernel.org>
 <0b17fbee-cfe9-8cb2-01d1-02b6a61a14f5@linux.microsoft.com>
 <CAL_Jsq+-HOkxtxOO=zyRbDuGVNZoMy589qoVANciNionsdsGCw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5dda6968-ca14-1695-3058-7c12653521ba@linux.microsoft.com>
Date:   Thu, 17 Dec 2020 22:25:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+-HOkxtxOO=zyRbDuGVNZoMy589qoVANciNionsdsGCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/17/20 2:01 PM, Rob Herring wrote:

> 
> [...]
> 
>>>> +#ifdef CONFIG_IMA_KEXEC
>>>> +/**
>>>> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
>>>> + *
>>>> + * @image: kimage struct to set IMA buffer data
>>>> + * @load_addr: Starting address where IMA buffer is loaded at
>>>> + * @size: Number of bytes in the IMA buffer
>>>> + *
>>>> + * Architectures should use this function to pass on the IMA buffer
>>>> + * information to the next kernel.
>>>> + *
>>>> + * Return: 0 on success, negative errno on error.
>>>> + */
>>>> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>>>> +                          size_t size)
>>>
>>> This should be a static inline in asm/kexec.h.
>>
>> arch_ima_add_kexec_buffer() is identical for powerpc and arm64.
>> Would it be better to "static inline" this function in "of.h" instead of
>> duplicating it in "asm/kexec.h" for powerpc and arm64?
> 
> No, think about what it is specific to and place it there. It has
> nothing to do with DT really. All it is is a wrapper to access the
> struct members in kimage_arch. So it belongs where they are declared.
> Now perhaps ima_buffer_addr and ima_buffer_size shouldn't be arch
> specific, but that's a separate issue.
> 

Since "struct kimage" definition is not available in "asm/kexec.h", 
defining arch_ima_add_kexec_buffer() in this header file results in the 
following build error:

./arch/powerpc/include/asm/kexec.h: In function 'arch_ima_add_kexec_buffer':
./arch/powerpc/include/asm/kexec.h:139:7: error: 'struct kimage' has no 
member named 'arch'
   139 |  image->arch.ima_buffer_addr = load_addr;

I think it would be appropriate to make arch_ima_add_kexec_buffer() a 
static inline function in "security/integrity/ima/ima_kexec.c" - the 
only file where this function is used.

This will also enable sharing this function for powerpc and arm64 
architectures.

thanks,
  -lakshmi
