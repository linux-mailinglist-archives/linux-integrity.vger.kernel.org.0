Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF41E9C53
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 06:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgFAEFp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jun 2020 00:05:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40382 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAEFp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jun 2020 00:05:45 -0400
Received: from [10.0.0.249] (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2990E20B717B;
        Sun, 31 May 2020 21:05:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2990E20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1590984344;
        bh=cRf16aYvsFXacsv2R2HsGnQ+AFezDz46tzhgNYqzsKQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RtclL/1mN0GD5uQjpU2HqQMKwfeCxJF7ii6ZMHj1q8msZDrQl3a61nZvqqop/mGeG
         +bxU39v107EGEpBikMuO+iu4qzmqb+8SjDrtEiRMmCNrLLpEmRo0efZ8pYE0dEAJfw
         Iq/vtpTkpHILxsgjyodTpvugBzpBvpLdSBmcmuWk=
Subject: Re: [RFC][PATCH 0/2] Add support for using reserved memory for ima
 buffer pass
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        masahiroy@kernel.org, james.morse@arm.com, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, gregkh@linuxfoundation.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com
References: <20200504203829.6330-1-prsriva@linux.microsoft.com>
 <20200505095620.GA82424@C02TD0UTHF1T.local>
 <e8c7d74e-74bf-caa3-452d-23faa649e825@linux.microsoft.com>
 <20200512230509.GA2654@bogus>
 <7701df90-a68b-b710-4279-9d64e45ee792@linux.microsoft.com>
 <87v9knpa36.fsf@morokweng.localdomain>
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
Message-ID: <9c016a54-1c05-2f5c-6755-3814309e17af@linux.microsoft.com>
Date:   Sun, 31 May 2020 21:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87v9knpa36.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/22/20 9:08 PM, Thiago Jung Bauermann wrote:
> 
> Hello Prakhar,
> 
> Prakhar Srivastava <prsriva@linux.microsoft.com> writes:
> 
>> On 5/12/20 4:05 PM, Rob Herring wrote:
>>> On Wed, May 06, 2020 at 10:50:04PM -0700, Prakhar Srivastava wrote:
>>>> Hi Mark,
>>>
>>> Please don't top post.
>>>
>>>> This patch set currently only address the Pure DT implementation.
>>>> EFI and ACPI implementations will be posted in subsequent patchsets.
>>>>
>>>> The logs are intended to be carried over the kexec and once read the
>>>> logs are no longer needed and in prior conversation with James(
>>>> https://lore.kernel.org/linux-arm-kernel/0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com/)
>>>> the apporach of using a chosen node doesn't
>>>> support the case.
>>>>
>>>> The DT entries make the reservation permanent and thus doesnt need kernel
>>>> segments to be used for this, however using a chosen-node with
>>>> reserved memory only changes the node information but memory still is
>>>> reserved via reserved-memory section.
>>>
>>> I think Mark's point was whether it needs to be permanent. We don't
>>> hardcode the initrd address for example.
>>>
>> Thankyou for clarifying my misunderstanding, i am modelling this keeping to the
>> TPM log implementation that uses a reserved memory. I will rev up the version
>> with chosen-node support.
>> That will make the memory reservation free after use.
> 
> Nice. Do you intend to use the same property that powerpc uses
> (linux,ima-kexec-buffer)?
> 
I was naming it ima-buffer, but naming is not a huge concern.
I will use linux,ima-kexec-buffer.
>>>> On 5/5/20 2:59 AM, Mark Rutland wrote:
>>>>> Hi Prakhar,
>>>>>
>>>>> On Mon, May 04, 2020 at 01:38:27PM -0700, Prakhar Srivastava wrote:
>>>>>> IMA during kexec(kexec file load) verifies the kernel signature and measures
>>>
>>> What's IMAIMA is a LSM attempting to detect if files have been accidentally or
>> maliciously altered, both remotely and locally, it can also be used
>> to appraise a file's measurement against a "good" value stored as an extended
>> attribute, and enforce local file integrity.
>>
>> IMA also validates and measures the signers of the kernel and initrd
>> during kexec. The measurements are extended to PCR 10(configurable) and the logs
>> stored in memory, however once kexec'd the logs are lost. Kexec is used as
>> secondary boot loader in may use cases and loosing the signer
>> creates a security hole.
>>
>> This patch is an implementation to carry over the logs and making it
>> possible to remotely validate the signers of the kernel and initrd. Such a
>> support exits only in powerpc.
>> This patch makes the carry over of logs architecture independent and puts the
>> complexity in a driver.
> 
> If I'm not mistaken, the code at arch/powerpc/kexec/ima.c isn't actually
> powerpc-specific. It could be moved to an arch-independent directory and
> used by any other architecture which supports device trees.
> 
> I think that's the simplest way forward. And to be honest I'm still
> trying to understand why you didn't take that approach. Did you try it
> and hit some obstacle or noticed a disadvantage for your use case?
> 
The approach i have in this patch set is to provide an abstraction layer 
that can be called from any architecture.
However taking a deeper look only the setup dtb is probably architecture
specific, only because the architecture specific kexec sets up the 
device tree. I can also move the code up in security/ima. However i do
have some concerns with layering. I am hoping you can provide me with 
some guidance in this aspect, i will send you the patch i am working on
to get some early feedback.

Thanks,
Prakhar Srivastava


> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
