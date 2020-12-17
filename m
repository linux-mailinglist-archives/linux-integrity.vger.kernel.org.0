Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ACC2DDB31
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 23:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgLQWL4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 17:11:56 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34500 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgLQWLz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 17:11:55 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id E503220B717A;
        Thu, 17 Dec 2020 14:11:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E503220B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608243074;
        bh=QSosWZwtVMTcMn62nBnRz7ClBx5R8L8Yz9ALkNCQps8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iB98ytkLLq7AgvZAquE6qTkzmUDb+o+31aedBLPvq1Lmn/k0Com6XleZhRApsg7C1
         ayIyKcrnJ/wTtkBYe/dMGz5HE7ODovuUGlX9iIqySfXrwGcwnXn//yeZFpd4DEijMZ
         Z1l2dVHjQXDjA0x9nUmy4J90J0ElUAKTEwzXT8Vk=
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
Message-ID: <de64bbaf-1568-b4a4-d76d-fc07a91d7c27@linux.microsoft.com>
Date:   Thu, 17 Dec 2020 14:11:13 -0800
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
> On Thu, Dec 17, 2020 at 2:52 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>>
>> On 12/17/20 12:05 PM, Rob Herring wrote:
>>> On Thu, Dec 17, 2020 at 09:37:06AM -0800, Lakshmi Ramasubramanian wrote:
>>>> The functions defined in "arch/powerpc/kexec/ima.c" handle setting up
>>>> and freeing the resources required to carry over the IMA measurement
>>>> list from the current kernel to the next kernel across kexec system call.
>>>> These functions do not have architecture specific code, but are
>>>> currently limited to powerpc.
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

okay - I'll move arch_ima_add_kexec_buffer() to asm/kexec.h

Please let me know if you have any other comments on the patches.
If you are done reviewing, I'll post the updated patches shortly.

Thanks for reviewing the changes.

  -lakshmi


