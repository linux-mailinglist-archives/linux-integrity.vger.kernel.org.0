Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52491C81D8
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 07:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgEGFuG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 01:50:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53950 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgEGFuG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 01:50:06 -0400
Received: from [10.0.0.249] (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0032A20B717B;
        Wed,  6 May 2020 22:50:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0032A20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588830605;
        bh=RUpzSogQyBsfsF8uRrUaHvzQm2ALKf57K82ip6cdAaY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a30X84p93MtdqmMPZmiBYv7G8klLTj0qcyl93LuHoTLgpulFY9yv1ku/aZlKbtyK6
         CyDCJ1vIA7SQnmsoE4ks21SB+9satufY8x+LCve2QjF0IItO/Y9+ScdQw1zSVR6nje
         f1Y8MnJYA2so0zJpDYs86HATPbT/imk90TUbGuLk=
Subject: Re: [RFC][PATCH 0/2] Add support for using reserved memory for ima
 buffer pass
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        masahiroy@kernel.org, james.morse@arm.com, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, gregkh@linuxfoundation.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com
References: <20200504203829.6330-1-prsriva@linux.microsoft.com>
 <20200505095620.GA82424@C02TD0UTHF1T.local>
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
Message-ID: <e8c7d74e-74bf-caa3-452d-23faa649e825@linux.microsoft.com>
Date:   Wed, 6 May 2020 22:50:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505095620.GA82424@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mark,

This patch set currently only address the Pure DT implementation.
EFI and ACPI implementations will be posted in subsequent patchsets.

The logs are intended to be carried over the kexec and once read the
logs are no longer needed and in prior conversation with James(
https://lore.kernel.org/linux-arm-kernel/0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com/) 
the apporach of using a chosen node doesn't
support the case.

The DT entries make the reservation permanent and thus doesnt need 
kernel segments to be used for this, however using a chosen-node with
reserved memory only changes the node information but memory still is
reserved via reserved-memory section.

On 5/5/20 2:59 AM, Mark Rutland wrote:
> Hi Prakhar,
> 
> On Mon, May 04, 2020 at 01:38:27PM -0700, Prakhar Srivastava wrote:
>> IMA during kexec(kexec file load) verifies the kernel signature and measures
>> the signature of the kernel. The signature in the logs can be used to verfiy the
>> authenticity of the kernel. The logs don not get carried over kexec and thus
>> remote attesation cannot verify the signature of the running kernel.
>>
>> Introduce an ABI to carry forward the ima logs over kexec.
>> Memory reserved via device tree reservation can be used to store and read
>> via the of_* functions.
> 
> This flow needs to work for:
> 
> 1) Pure DT
> 2) DT + EFI memory map
> 3) ACPI + EFI memory map
> 
> ... and if this is just for transiently passing the log, I don't think
> that a reserved memory region is the right thing to use, since they're
> supposed to be more permanent.
> 
> This sounds analogous to passing the initrd, and should probably use
> properties under the chosen node (which can be used for all three boot
> flows above).
> 
> For reference, how big is the IMA log likely to be? Does it need
> physically contiguous space?

It purely depends on the policy used and the modules/files that are 
accessed for my local testing over a kexec session the log in
about 30KB.

Current implementation expects enough contiguous memory to allocated to 
carry forward the logs. If the log size exceeds the reserved memory the
call will fail.

Thanks,
Prakhar Srivastava
> 
> Thanks,
> Mark.
> 
>>
>> Reserved memory stores the size(sizeof(size_t)) of the buffer in the starting
>> address, followed by the IMA log contents.
>>
>> Tested on:
>>    arm64 with Uboot
>>
>> Prakhar Srivastava (2):
>>    Add a layer of abstraction to use the memory reserved by device tree
>>      for ima buffer pass.
>>    Add support for ima buffer pass using reserved memory for arm64 kexec.
>>      Update the arch sepcific code path in kexec file load to store the
>>      ima buffer in the reserved memory. The same reserved memory is read
>>      on kexec or cold boot.
>>
>>   arch/arm64/Kconfig                     |   1 +
>>   arch/arm64/include/asm/ima.h           |  22 ++++
>>   arch/arm64/include/asm/kexec.h         |   5 +
>>   arch/arm64/kernel/Makefile             |   1 +
>>   arch/arm64/kernel/ima_kexec.c          |  64 ++++++++++
>>   arch/arm64/kernel/machine_kexec_file.c |   1 +
>>   arch/powerpc/include/asm/ima.h         |   3 +-
>>   arch/powerpc/kexec/ima.c               |  14 ++-
>>   drivers/of/Kconfig                     |   6 +
>>   drivers/of/Makefile                    |   1 +
>>   drivers/of/of_ima.c                    | 165 +++++++++++++++++++++++++
>>   include/linux/of.h                     |  34 +++++
>>   security/integrity/ima/ima_kexec.c     |  15 ++-
>>   13 files changed, 325 insertions(+), 7 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/ima.h
>>   create mode 100644 arch/arm64/kernel/ima_kexec.c
>>   create mode 100644 drivers/of/of_ima.c
>>
>> -- 
>> 2.25.1
>>
