Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED6F32B010
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Mar 2021 04:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhCCBac (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Mar 2021 20:30:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56192 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578708AbhCBP0p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Mar 2021 10:26:45 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9687820B83EA;
        Tue,  2 Mar 2021 07:26:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9687820B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614698761;
        bh=lwnEHkkImr8dT+pu5zA94ImzVDh1eaKp+2wplr8dTxw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pLLCBLu/Gt65UbzyLnL9BV31JdFvnxcEvpWZedW6aek9Fr7BAvJMq8pE7+I3D21HR
         IhAQWA5ZLk63w0dE3FSSr4HbxcROs4K0Ok7obQWUOQTWh9PrLQWbwmnRiQ5oDBMNjX
         vvxYK8ZzE4nI3spfi8YNiR8jeYbt6avdkMKdo2vQ=
Subject: Re: [PATCH v19 00/13] Carry forward IMA measurement log on kexec on
 ARM64
To:     Rob Herring <robh@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
 <CAL_JsqKiOVo2rDhstAA-jUkMJiajHM=uwfj3JQd64h_eEfSjTw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7828ec90-a768-f96f-192f-d00dec2344af@linux.microsoft.com>
Date:   Tue, 2 Mar 2021 07:25:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKiOVo2rDhstAA-jUkMJiajHM=uwfj3JQd64h_eEfSjTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/2/21 7:06 AM, Rob Herring wrote:
> On Sun, Feb 21, 2021 at 11:49 AM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>>
>> On kexec file load Integrity Measurement Architecture (IMA) subsystem
>> may verify the IMA signature of the kernel and initramfs, and measure
>> it.  The command line parameters passed to the kernel in the kexec call
>> may also be measured by IMA.  A remote attestation service can verify
>> a TPM quote based on the TPM event log, the IMA measurement list, and
>> the TPM PCR data.  This can be achieved only if the IMA measurement log
>> is carried over from the current kernel to the next kernel across
>> the kexec call.
>>
>> powerpc already supports carrying forward the IMA measurement log on
>> kexec.  This patch set adds support for carrying forward the IMA
>> measurement log on kexec on ARM64.
>>
>> This patch set moves the platform independent code defined for powerpc
>> such that it can be reused for other platforms as well.  A chosen node
>> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
>> the address and the size of the memory reserved to carry
>> the IMA measurement log.
>>
>> This patch set has been tested for ARM64 platform using QEMU.
>> I would like help from the community for testing this change on powerpc.
>> Thanks.
>>
>> This patch set is based on
>> commit f31e3386a4e9 ("ima: Free IMA measurement buffer after kexec syscall")
>> in https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>> "ima-kexec-fixes" branch.

[...]

>>
>> Lakshmi Ramasubramanian (10):
>>    kexec: Move ELF fields to struct kimage
>>    arm64: Use ELF fields defined in 'struct kimage'
>>    powerpc: Use ELF fields defined in 'struct kimage'
>>    x86: Use ELF fields defined in 'struct kimage'
>>    powerpc: Move ima buffer fields to struct kimage
>>    powerpc: Enable passing IMA log to next kernel on kexec
>>    powerpc: Move arch independent ima kexec functions to
>>      drivers/of/kexec.c
>>    kexec: Use fdt_appendprop_addrrange() to add ima buffer to FDT
>>    powerpc: Delete unused function delete_fdt_mem_rsv()
>>    arm64: Enable passing IMA log to next kernel on kexec
>>
>> Rob Herring (3):
>>    of: Add a common kexec FDT setup function
>>    arm64: Use common of_kexec_alloc_and_setup_fdt()
>>    powerpc: Use common of_kexec_alloc_and_setup_fdt()
>>
>>   arch/arm64/Kconfig                     |   1 +
>>   arch/arm64/include/asm/kexec.h         |   4 -
>>   arch/arm64/kernel/machine_kexec_file.c | 194 +----------
>>   arch/powerpc/Kconfig                   |   2 +-
>>   arch/powerpc/include/asm/ima.h         |  30 --
>>   arch/powerpc/include/asm/kexec.h       |  14 +-
>>   arch/powerpc/kexec/Makefile            |   7 -
>>   arch/powerpc/kexec/elf_64.c            |  30 +-
>>   arch/powerpc/kexec/file_load.c         | 183 +---------
>>   arch/powerpc/kexec/file_load_64.c      |  21 +-
>>   arch/powerpc/kexec/ima.c               | 219 ------------
>>   arch/x86/include/asm/kexec.h           |   5 -
>>   arch/x86/kernel/crash.c                |  14 +-
>>   arch/x86/kernel/kexec-bzimage64.c      |   2 +-
>>   arch/x86/kernel/machine_kexec_64.c     |   4 +-
>>   drivers/of/Makefile                    |   6 +
>>   drivers/of/kexec.c                     | 458 +++++++++++++++++++++++++
>>   include/linux/kexec.h                  |   8 +
>>   include/linux/of.h                     |   7 +
>>   security/integrity/ima/ima.h           |   4 -
>>   security/integrity/ima/ima_kexec.c     |   9 +-
>>   21 files changed, 539 insertions(+), 683 deletions(-)
>>   delete mode 100644 arch/powerpc/include/asm/ima.h
>>   delete mode 100644 arch/powerpc/kexec/ima.c
>>   create mode 100644 drivers/of/kexec.c
> 
> I fixed up the Fixes tags and applied for 5.13.
> 

Thanks a lot Rob.

  -lakshmi


