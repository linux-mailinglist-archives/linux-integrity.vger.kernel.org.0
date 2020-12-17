Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3582DD7E6
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgLQSNd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 13:13:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56418 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbgLQSNa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 13:13:30 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6245E20B717A;
        Thu, 17 Dec 2020 10:12:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6245E20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608228768;
        bh=Op0ld8ZQz9MkUpOQGNST4tVuL0ZNrXjqa+FJW4eo3lg=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=fVgiVskChG1sCODqaC9ji/e08EOBl9FciBDOSkXrS6hHsVVqHAeEg7HpM89sbatB1
         yav/4BaBkrLCJmtFqJ1HhpnILWp1eByL6oa8t+H6E2+B6wWLFjN6MPU8O4t5fJJ9UD
         bCc3IYmmcivUyc+kbUolwk6EtPHVCMzxyzj7ErWA=
Subject: Re: [PATCH v12 0/4] Carry forward IMA measurement log on kexec on
 ARM64
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20201217173708.6940-1-nramas@linux.microsoft.com>
Message-ID: <2a0910db-5477-a852-3f35-4a3abb633b57@linux.microsoft.com>
Date:   Thu, 17 Dec 2020 10:12:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217173708.6940-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/17/20 9:37 AM, Lakshmi Ramasubramanian wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it. The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA. A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data. This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.

Typo in the email address of James Morse (ARM.com). Sorry about that.
Adding the correct email address.

  -lakshmi

> 
> powerpc already supports carrying forward the IMA measurement log on
> kexec. This patch set adds support for carrying forward the IMA
> measurement log on kexec on ARM64.
> 
> This patch set moves the platform independent code defined for powerpc
> such that it can be reused for other platforms as well. A chosen node
> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.
> 
> This patch set has been tested for ARM64 platform using QEMU.
> I would like help from the community for testing this change on powerpc.
> Thanks.
> 
> This patch set is based on
> commit a29a64445089 ("powerpc: Use common of_kexec_setup_new_fdt()")
> in https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> "dt/kexec" branch.
>  > Changelog:
> 
> v12
>    - Use fdt_appendprop_addrrange() in setup_ima_buffer()
>      to setup the IMA measurement list property in
>      the device tree.
>    - Moved architecture independent functions from
>      "arch/powerpc/kexec/ima.c" to "drivers/of/kexec."
>    - Deleted "arch/powerpc/kexec/ima.c" and
>      "arch/powerpc/include/asm/ima.h".
> 
> v11
>    - Rebased the changes on the kexec code refactoring done by
>      Rob Herring in his "dt/kexec" branch
>    - Removed "extern" keyword in function declarations
>    - Removed unnecessary header files included in C files
>    - Updated patch descriptions per Thiago's comments
> 
> v10
>    - Moved delete_fdt_mem_rsv(), remove_ima_buffer(),
>      get_ima_kexec_buffer, and get_root_addr_size_cells()
>      to drivers/of/kexec.c
>    - Moved arch_ima_add_kexec_buffer() to
>      security/integrity/ima/ima_kexec.c
>    - Conditionally define IMA buffer fields in struct kimage_arch
> 
> v9
>    - Moved delete_fdt_mem_rsv() to drivers/of/kexec_fdt.c
>    - Defined a new function get_ima_kexec_buffer() in
>      drivers/of/ima_kexec.c to replace do_get_kexec_buffer()
>    - Changed remove_ima_kexec_buffer() to the original function name
>      remove_ima_buffer()
>    - Moved remove_ima_buffer() to drivers/of/ima_kexec.c
>    - Moved ima_get_kexec_buffer() and ima_free_kexec_buffer()
>      to security/integrity/ima/ima_kexec.c
> 
> v8:
>    - Moved remove_ima_kexec_buffer(), do_get_kexec_buffer(), and
>      delete_fdt_mem_rsv() to drivers/of/fdt.c
>    - Moved ima_dump_measurement_list() and ima_add_kexec_buffer()
>      back to security/integrity/ima/ima_kexec.c
> 
> v7:
>    - Renamed remove_ima_buffer() to remove_ima_kexec_buffer() and moved
>      this function definition to kernel.
>    - Moved delete_fdt_mem_rsv() definition to kernel
>    - Moved ima_dump_measurement_list() and ima_add_kexec_buffer() to
>      a new file namely ima_kexec_fdt.c in IMA
> 
> v6:
>    - Remove any existing FDT_PROP_IMA_KEXEC_BUFFER property in the device
>      tree and also its corresponding memory reservation in the currently
>      running kernel.
>    - Moved the function remove_ima_buffer() defined for powerpc to IMA
>      and renamed the function to ima_remove_kexec_buffer(). Also, moved
>      delete_fdt_mem_rsv() from powerpc to IMA.
> 
> v5:
>    - Merged get_addr_size_cells() and do_get_kexec_buffer() into a single
>      function when moving the arch independent code from powerpc to IMA
>    - Reverted the change to use FDT functions in powerpc code and added
>      back the original code in get_addr_size_cells() and
>      do_get_kexec_buffer() for powerpc.
>    - Added fdt_add_mem_rsv() for ARM64 to reserve the memory for
>      the IMA log buffer during kexec.
>    - Fixed the warning reported by kernel test bot for ARM64
>      arch_ima_add_kexec_buffer() - moved this function to a new file
>      namely arch/arm64/kernel/ima_kexec.c
> 
> v4:
>    - Submitting the patch series on behalf of the original author
>      Prakhar Srivastava <prsriva@linux.microsoft.com>
>    - Moved FDT_PROP_IMA_KEXEC_BUFFER ("linux,ima-kexec-buffer") to
>      libfdt.h so that it can be shared by multiple platforms.
> 
> v3:
> Breakup patches further into separate patches.
>    - Refactoring non architecture specific code out of powerpc
>    - Update powerpc related code to use fdt functions
>    - Update IMA buffer read related code to use of functions
>    - Add support to store the memory information of the IMA
>      measurement logs to be carried forward.
>    - Update the property strings to align with documented nodes
>      https://github.com/devicetree-org/dt-schema/pull/46
> 
> v2:
>    Break patches into separate patches.
>    - Powerpc related Refactoring
>    - Updating the docuemntation for chosen node
>    - Updating arm64 to support IMA buffer pass
> 
> v1:
>    Refactoring carrying over IMA measuremnet logs over Kexec. This patch
>      moves the non-architecture specific code out of powerpc and adds to
>      security/ima.(Suggested by Thiago)
>    Add Documentation regarding the ima-kexec-buffer node in the chosen
>      node documentation
> 
> v0:
>    Add a layer of abstraction to use the memory reserved by device tree
>      for ima buffer pass.
>    Add support for ima buffer pass using reserved memory for arm64 kexec.
>      Update the arch sepcific code path in kexec file load to store the
>      ima buffer in the reserved memory. The same reserved memory is read
>      on kexec or cold boot.
> 
> Lakshmi Ramasubramanian (4):
>    powerpc: Use fdt_appendprop_addrrange() to add ima buffer to FDT
>    powerpc: Move arch independent ima kexec functions to
>      drivers/of/kexec.c
>    arm64: Free DTB buffer if fdt_open_into() fails
>    arm64: Add IMA log information in kimage used for kexec
> 
>   arch/arm64/Kconfig                     |   1 +
>   arch/arm64/include/asm/kexec.h         |   5 +
>   arch/arm64/kernel/machine_kexec_file.c |   4 +-
>   arch/powerpc/include/asm/ima.h         |  30 ----
>   arch/powerpc/include/asm/kexec.h       |   1 -
>   arch/powerpc/kexec/Makefile            |   7 -
>   arch/powerpc/kexec/file_load.c         |  39 -----
>   arch/powerpc/kexec/ima.c               | 219 -------------------------
>   drivers/of/kexec.c                     | 198 ++++++++++++++++++++++
>   include/linux/of.h                     |  17 ++
>   security/integrity/ima/ima.h           |   4 -
>   security/integrity/ima/ima_kexec.c     |   2 +
>   12 files changed, 226 insertions(+), 301 deletions(-)
>   delete mode 100644 arch/powerpc/include/asm/ima.h
>   delete mode 100644 arch/powerpc/kexec/ima.c
> 

