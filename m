Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158922BC1D0
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Nov 2020 20:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKUTrH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 21 Nov 2020 14:47:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44774 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgKUTrH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 Nov 2020 14:47:07 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 582C320B717A;
        Sat, 21 Nov 2020 11:47:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 582C320B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605988025;
        bh=59IvGgvZFlnKU2vwMSgUoi2T91vH4paBI5R//tIote0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=qaIidqjqfgmp+YzmaXu/XHNpFvGL7i8TpuDJM/WSlOKIXC5Abql0R1lwqfpnhtPbA
         RiGT0pchPl2inXyodYv2KKWhHKXdwq4r7kOXAt8PC2PJCZTsmikiJmxbvG4bLRh5Pi
         QkrE7gJ9xRU1S12V2qpT8gLDLAV0PENA/uxP9cXE=
Subject: Re: [PATCH v9 0/8] Carry forward IMA measurement log on kexec on
 ARM64
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Rob Herring <robh@kernel.org>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
 <20201121135719.GA2134870@robh.at.kernel.org>
 <415b4d0b-3d93-40ce-b74e-48fdce7fbf7f@linux.microsoft.com>
Message-ID: <10fb7958-c6e1-e8c9-8802-f85f2a9311ed@linux.microsoft.com>
Date:   Sat, 21 Nov 2020 11:47:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <415b4d0b-3d93-40ce-b74e-48fdce7fbf7f@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/21/20 6:38 AM, Lakshmi Ramasubramanian wrote:
> On 11/21/20 5:57 AM, Rob Herring wrote:
>> On Fri, Nov 13, 2020 at 11:22:35AM -0800, Lakshmi Ramasubramanian wrote:
>>> On kexec file load Integrity Measurement Architecture (IMA) subsystem
>>> may verify the IMA signature of the kernel and initramfs, and measure
>>> it. The command line parameters passed to the kernel in the kexec call
>>> may also be measured by IMA. A remote attestation service can verify
>>> a TPM quote based on the TPM event log, the IMA measurement list, and
>>> the TPM PCR data. This can be achieved only if the IMA measurement log
>>> is carried over from the current kernel to the next kernel across
>>> the kexec call.
>>>
>>> powerpc already supports carrying forward the IMA measurement log on
>>> kexec. This patch set adds support for carrying forward the IMA
>>> measurement log on kexec on ARM64.
>>>
>>> This patch set moves the platform independent code defined for powerpc
>>> such that it can be reused for other platforms as well. A chosen node
>>> namely "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
>>> the address and the size of the memory reserved to carry
>>> the IMA measurement log.
>>>
>>> This patch set has been tested for ARM64 platform using QEMU.
>>> I would like help from the community for testing this change on powerpc.
>>> Thanks.
>>
>> As I mentioned previously, please move the kexec code to drivers/of/. Or
>> at least put the infrastructure in place so we're not defining public
>> IMA functions and then making them static later.
> 
> I am not sure I am following you. Could you please clarify -
> In this patch series, per your suggestion, I have moved the architecture 
> independent kexec code to "drivers/of".
> 
>      => drivers/of/ima_kexec.c
>      => drivers/of/kexec_fdt.c
> 
> Please let me know if I missed something.

The following two arch independent kexec functions are required only 
when CONFIG_IMA is enabled. So I moved them under security/integrity/ima

	=> ima_get_kexec_buffer()
	=> ima_free_kexec_buffer()

But the other arch independent kexec functions have been moved to 
drivers/of.

I am not sure if you wanted ima_get_kexec_buffer() and 
ima_free_kexec_buffer() to also be moved to "drivers/of". Please clarify.

thanks,
  -lakshmi

>>> This patch set is based on
>>> commit af5043c89a8e ("Merge tag 'acpi-5.10-rc4' of 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm")
>>> in https://github.com/torvalds/linux "master" branch.
>>>
>>> Changelog:
>>>
>>> v9
>>>    - Moved delete_fdt_mem_rsv() to drivers/of/kexec_fdt.c
>>>    - Defined a new function get_ima_kexec_buffer() in
>>>      drivers/of/ima_kexec.c to replace do_get_kexec_buffer()
>>>    - Changed remove_ima_kexec_buffer() to the original function name
>>>      remove_ima_buffer()
>>>    - Moved remove_ima_buffer() to drivers/of/ima_kexec.c
>>>    - Moved ima_get_kexec_buffer() and ima_free_kexec_buffer()
>>>      to security/integrity/ima/ima_kexec.c
>>>
>>> v8:
>>>    - Moved remove_ima_kexec_buffer(), do_get_kexec_buffer(), and
>>>      delete_fdt_mem_rsv() to drivers/of/fdt.c
>>>    - Moved ima_dump_measurement_list() and ima_add_kexec_buffer()
>>>      back to security/integrity/ima/ima_kexec.c
>>>
>>> v7:
>>>    - Renamed remove_ima_buffer() to remove_ima_kexec_buffer() and moved
>>>      this function definition to kernel.
>>>    - Moved delete_fdt_mem_rsv() definition to kernel
>>>    - Moved ima_dump_measurement_list() and ima_add_kexec_buffer() to
>>>      a new file namely ima_kexec_fdt.c in IMA
>>>
>>> v6:
>>>    - Remove any existing FDT_PROP_IMA_KEXEC_BUFFER property in the 
>>> device
>>>      tree and also its corresponding memory reservation in the currently
>>>      running kernel.
>>>    - Moved the function remove_ima_buffer() defined for powerpc to IMA
>>>      and renamed the function to ima_remove_kexec_buffer(). Also, moved
>>>      delete_fdt_mem_rsv() from powerpc to IMA.
>>>
>>> v5:
>>>    - Merged get_addr_size_cells() and do_get_kexec_buffer() into a 
>>> single
>>>      function when moving the arch independent code from powerpc to IMA
>>>    - Reverted the change to use FDT functions in powerpc code and added
>>>      back the original code in get_addr_size_cells() and
>>>      do_get_kexec_buffer() for powerpc.
>>>    - Added fdt_add_mem_rsv() for ARM64 to reserve the memory for
>>>      the IMA log buffer during kexec.
>>>    - Fixed the warning reported by kernel test bot for ARM64
>>>      arch_ima_add_kexec_buffer() - moved this function to a new file
>>>      namely arch/arm64/kernel/ima_kexec.c
>>>
>>> v4:
>>>    - Submitting the patch series on behalf of the original author
>>>      Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>    - Moved FDT_PROP_IMA_KEXEC_BUFFER ("linux,ima-kexec-buffer") to
>>>      libfdt.h so that it can be shared by multiple platforms.
>>>
>>> v3:
>>> Breakup patches further into separate patches.
>>>    - Refactoring non architecture specific code out of powerpc
>>>    - Update powerpc related code to use fdt functions
>>>    - Update IMA buffer read related code to use of functions
>>>    - Add support to store the memory information of the IMA
>>>      measurement logs to be carried forward.
>>>    - Update the property strings to align with documented nodes
>>>      https://github.com/devicetree-org/dt-schema/pull/46
>>>
>>> v2:
>>>    Break patches into separate patches.
>>>    - Powerpc related Refactoring
>>>    - Updating the docuemntation for chosen node
>>>    - Updating arm64 to support IMA buffer pass
>>>
>>> v1:
>>>    Refactoring carrying over IMA measuremnet logs over Kexec. This patch
>>>      moves the non-architecture specific code out of powerpc and adds to
>>>      security/ima.(Suggested by Thiago)
>>>    Add Documentation regarding the ima-kexec-buffer node in the chosen
>>>      node documentation
>>>
>>> v0:
>>>    Add a layer of abstraction to use the memory reserved by device tree
>>>      for ima buffer pass.
>>>    Add support for ima buffer pass using reserved memory for arm64 
>>> kexec.
>>>      Update the arch sepcific code path in kexec file load to store the
>>>      ima buffer in the reserved memory. The same reserved memory is read
>>>      on kexec or cold boot.
>>>
>>> Lakshmi Ramasubramanian (8):
>>>    powerpc: fix compiler warnings and errors
>>>    powerpc: Move delete_fdt_mem_rsv() to drivers/of
>>>    ima: Define get_ima_kexec_buffer() in drivers/of
>>>    powerpc: Use get_ima_kexec_buffer to get ima kexec buffer
>>>    powerpc: Move remove_ima_buffer() to drivers/of
>>>    powerpc: Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to
>>>      ima
>>>    arm64: Store IMA log information in kimage used for kexec
>>>    arm64: Add IMA kexec buffer to DTB
>>>
>>>   arch/arm64/Kconfig                     |   1 +
>>>   arch/arm64/include/asm/ima.h           |  18 +++++
>>>   arch/arm64/include/asm/kexec.h         |   3 +
>>>   arch/arm64/kernel/Makefile             |   1 +
>>>   arch/arm64/kernel/ima_kexec.c          |  34 ++++++++
>>>   arch/arm64/kernel/machine_kexec_file.c |  18 +++++
>>>   arch/powerpc/include/asm/ima.h         |  11 +--
>>>   arch/powerpc/include/asm/kexec.h       |   1 -
>>>   arch/powerpc/kexec/Makefile            |   7 +-
>>>   arch/powerpc/kexec/file_load.c         |  32 --------
>>>   arch/powerpc/kexec/ima.c               | 106 ++-----------------------
>>>   drivers/of/Makefile                    |   9 +++
>>
>>>   drivers/of/ima_kexec.c                 |  91 +++++++++++++++++++++
>>>   drivers/of/kexec_fdt.c                 |  55 +++++++++++++
>>
>> Does this need to be 2 files? Just kexec.c?
> 
> Since the functions defined in "ima_kexec.c" and "kexec_fdt.c" are 
> enabled on 2 different kernel CONFIGs, keeping them in 2 files enables 
> us to avoid using "#ifdef" in C files.
> 
> thanks,
>   -lakshmi
> 
>>
>>>   include/linux/kexec.h                  |  24 ++++++
>>>   security/integrity/ima/ima_kexec.c     |  51 ++++++++++++
>>>   16 files changed, 313 insertions(+), 149 deletions(-)
>>>   create mode 100644 arch/arm64/include/asm/ima.h
>>>   create mode 100644 arch/arm64/kernel/ima_kexec.c
>>>   create mode 100644 drivers/of/ima_kexec.c
>>>   create mode 100644 drivers/of/kexec_fdt.c
>>>
>>> -- 
>>> 2.29.2
>>>

