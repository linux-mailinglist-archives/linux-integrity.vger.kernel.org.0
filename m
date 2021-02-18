Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A0931E3D8
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 02:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBRB0c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Feb 2021 20:26:32 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40507 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBRB00 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Feb 2021 20:26:26 -0500
Received: by mail-oi1-f177.google.com with SMTP id 18so244338oiz.7;
        Wed, 17 Feb 2021 17:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iNtR1+93qGiVvdTevWOQDis3P/Hn4HTusetEul7VNNU=;
        b=HLg8fpaOWeyE4tzHUdwruJsVBhH4+C05DvODVP6Hor29Fgy9LQZnuWIn640I6JxC1j
         DEkqNumiMUJnpcIAaKGlv5h172cb6mllGEuuZbSksbaSqcoIOSjWTBX4y0nkOxGNf1Q4
         7nJXHGPo8sOTpHvtV2jhuKgoa7U4AhAjzQRlG3gLKXKVbcuez9lxA2F2cMhCUH6U+tur
         JCqxvuIIbmT7YhEcWNcM0UJA1D2OVwhkwl26e3y5AJhThgHHudQEtpjqTcHlo/cIISmx
         LKLWnhWv32oja/qdvL392MVYT7Q7Ic5CLlv6htyc81OLMAQ7JyhOKUj7NMTaiUT8oAv2
         fCbA==
X-Gm-Message-State: AOAM532HRI37R4JaQG7V/GhKoWX9/R+28oiH/2yAOkx5CbGb8le0Ox++
        G5syoeD+pTFluKaNj0HLxw==
X-Google-Smtp-Source: ABdhPJxlWmWL7CcYv4EcrHGqHyxQN2Eh+W2H2Icgmn3Z5ZgxZqS/+8yWhHMVHsHbPdqCa5Nom/bD6g==
X-Received: by 2002:aca:48c:: with SMTP id 134mr1091401oie.16.1613611544793;
        Wed, 17 Feb 2021 17:25:44 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h21sm396907otm.45.2021.02.17.17.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 17:25:43 -0800 (PST)
Received: (nullmailer pid 3365284 invoked by uid 1000);
        Thu, 18 Feb 2021 01:25:41 -0000
Date:   Wed, 17 Feb 2021 19:25:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v18 00/10] Carry forward IMA measurement log on kexec on
 ARM64
Message-ID: <20210218012541.GA3001280@robh.at.kernel.org>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213161049.6190-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 13, 2021 at 08:10:38AM -0800, Lakshmi Ramasubramanian wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it.  The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA.  A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data.  This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.
> 
> powerpc already supports carrying forward the IMA measurement log on
> kexec.  This patch set adds support for carrying forward the IMA
> measurement log on kexec on ARM64.
> 
> This patch set moves the platform independent code defined for powerpc
> such that it can be reused for other platforms as well.  A chosen node
> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.
> 
> This patch set has been tested for ARM64 platform using QEMU.
> I would like help from the community for testing this change on powerpc.
> Thanks.
> 
> This patch set is based on
> commit f31e3386a4e9 ("ima: Free IMA measurement buffer after kexec syscall")
> in https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> "ima-kexec-fixes" branch.
> 
> Changelog:
> 
> v18
>   - Added a parameter to of_kexec_alloc_and_setup_fdt() for the caller
>     to specify additional space needed for the FDT buffer
>   - Renamed arm64 and powerpc ELF buffer address field in
>     "struct kimage_arch" to elf_load_addr to match x86_64 name.
>   - Removed of_ima_add_kexec_buffer() and instead directly set
>     ima_buffer_addr and ima_buffer_size in ima_add_kexec_buffer()
>   - Moved FDT_EXTRA_SPACE definition from include/linux/of.h to
>     drivers/of/kexec.c
> 
> v17
>   - Renamed of_kexec_setup_new_fdt() to of_kexec_alloc_and_setup_fdt(),
>     and moved memory allocation for the new FDT to this function.
> 
> v16
>   - Defined functions to allocate and free buffer for FDT for powerpc
>     and arm64.
>   - Moved ima_buffer_addr and ima_buffer_size fields from
>     "struct kimage_arch" in powerpc to "struct kimage"
> v15
>   - Included Rob's patches in the patch set, and rebased
>     the changes to "next-integrity" branch.
>   - Allocate memory for DTB, on arm64, using kmalloc() instead of
>     vmalloc() to keep it consistent with powerpc implementation.
>   - Call of_kexec_setup_new_fdt() from setup_new_fdt_ppc64() and
>     remove setup_new_fdt() in the same patch to keep it bisect safe.
> 
> v14
>   - Select CONFIG_HAVE_IMA_KEXEC for CONFIG_KEXEC_FILE, for powerpc
>     and arm64, if CONFIG_IMA is enabled.
>   - Use IS_ENABLED() macro instead of "#ifdef" in remove_ima_buffer(),
>     ima_get_kexec_buffer(), and ima_free_kexec_buffer().
>   - Call of_kexec_setup_new_fdt() from setup_new_fdt_ppc64() and
>     remove setup_new_fdt() in "arch/powerpc/kexec/file_load.c".
> 
> v13
>   - Moved the arch independent functions to drivers/of/kexec.c
>     and then refactored the code.
>   - Moved arch_ima_add_kexec_buffer() to
>     security/integrity/ima/ima_kexec.c
> 
> v12
>   - Use fdt_appendprop_addrrange() in setup_ima_buffer()
>     to setup the IMA measurement list property in
>     the device tree.
>   - Moved architecture independent functions from
>     "arch/powerpc/kexec/ima.c" to "drivers/of/kexec."
>   - Deleted "arch/powerpc/kexec/ima.c" and
>     "arch/powerpc/include/asm/ima.h".
> 
> v11
>   - Rebased the changes on the kexec code refactoring done by
>     Rob Herring in his "dt/kexec" branch
>   - Removed "extern" keyword in function declarations
>   - Removed unnecessary header files included in C files
>   - Updated patch descriptions per Thiago's comments
> 
> v10
>   - Moved delete_fdt_mem_rsv(), remove_ima_buffer(),
>     get_ima_kexec_buffer, and get_root_addr_size_cells()
>     to drivers/of/kexec.c
>   - Moved arch_ima_add_kexec_buffer() to
>     security/integrity/ima/ima_kexec.c
>   - Conditionally define IMA buffer fields in struct kimage_arch
> 
> v9
>   - Moved delete_fdt_mem_rsv() to drivers/of/kexec_fdt.c
>   - Defined a new function get_ima_kexec_buffer() in
>     drivers/of/ima_kexec.c to replace do_get_kexec_buffer()
>   - Changed remove_ima_kexec_buffer() to the original function name
>     remove_ima_buffer()
>   - Moved remove_ima_buffer() to drivers/of/ima_kexec.c
>   - Moved ima_get_kexec_buffer() and ima_free_kexec_buffer()
>     to security/integrity/ima/ima_kexec.c
> 
> v8:
>   - Moved remove_ima_kexec_buffer(), do_get_kexec_buffer(), and
>     delete_fdt_mem_rsv() to drivers/of/fdt.c
>   - Moved ima_dump_measurement_list() and ima_add_kexec_buffer()
>     back to security/integrity/ima/ima_kexec.c
> 
> v7:
>   - Renamed remove_ima_buffer() to remove_ima_kexec_buffer() and moved
>     this function definition to kernel.
>   - Moved delete_fdt_mem_rsv() definition to kernel
>   - Moved ima_dump_measurement_list() and ima_add_kexec_buffer() to
>     a new file namely ima_kexec_fdt.c in IMA
> 
> v6:
>   - Remove any existing FDT_PROP_IMA_KEXEC_BUFFER property in the device
>     tree and also its corresponding memory reservation in the currently
>     running kernel.
>   - Moved the function remove_ima_buffer() defined for powerpc to IMA
>     and renamed the function to ima_remove_kexec_buffer(). Also, moved
>     delete_fdt_mem_rsv() from powerpc to IMA.
> 
> v5:
>   - Merged get_addr_size_cells() and do_get_kexec_buffer() into a single
>     function when moving the arch independent code from powerpc to IMA
>   - Reverted the change to use FDT functions in powerpc code and added
>     back the original code in get_addr_size_cells() and
>     do_get_kexec_buffer() for powerpc.
>   - Added fdt_add_mem_rsv() for ARM64 to reserve the memory for
>     the IMA log buffer during kexec.
>   - Fixed the warning reported by kernel test bot for ARM64
>     arch_ima_add_kexec_buffer() - moved this function to a new file
>     namely arch/arm64/kernel/ima_kexec.c
> 
> v4:
>   - Submitting the patch series on behalf of the original author
>     Prakhar Srivastava <prsriva@linux.microsoft.com>
>   - Moved FDT_PROP_IMA_KEXEC_BUFFER ("linux,ima-kexec-buffer") to
>     libfdt.h so that it can be shared by multiple platforms.
> 
> v3:
> Breakup patches further into separate patches.
>   - Refactoring non architecture specific code out of powerpc
>   - Update powerpc related code to use fdt functions
>   - Update IMA buffer read related code to use of functions
>   - Add support to store the memory information of the IMA
>     measurement logs to be carried forward.
>   - Update the property strings to align with documented nodes
>     https://github.com/devicetree-org/dt-schema/pull/46
> 
> v2:
>   Break patches into separate patches.
>   - Powerpc related Refactoring
>   - Updating the docuemntation for chosen node
>   - Updating arm64 to support IMA buffer pass
> 
> v1:
>   Refactoring carrying over IMA measuremnet logs over Kexec. This patch
>     moves the non-architecture specific code out of powerpc and adds to
>     security/ima.(Suggested by Thiago)
>   Add Documentation regarding the ima-kexec-buffer node in the chosen
>     node documentation
> 
> v0:
>   Add a layer of abstraction to use the memory reserved by device tree
>     for ima buffer pass.
>   Add support for ima buffer pass using reserved memory for arm64 kexec.
>     Update the arch sepcific code path in kexec file load to store the
>     ima buffer in the reserved memory. The same reserved memory is read
>     on kexec or cold boot.
> 
> Lakshmi Ramasubramanian (7):
>   arm64: Rename kexec elf_headers_mem to elf_load_addr
>   powerpc: Move ima buffer fields to struct kimage
>   powerpc: Enable passing IMA log to next kernel on kexec
>   powerpc: Move arch independent ima kexec functions to
>     drivers/of/kexec.c
>   kexec: Use fdt_appendprop_addrrange() to add ima buffer to FDT
>   powerpc: Delete unused function delete_fdt_mem_rsv()
>   arm64: Enable passing IMA log to next kernel on kexec
> 
> Rob Herring (4):
>   powerpc: Rename kexec elfcorehdr_addr to elf_load_addr
>   of: Add a common kexec FDT setup function
>   arm64: Use common of_kexec_alloc_and_setup_fdt()
>   powerpc: Use common of_kexec_alloc_and_setup_fdt()

I've applied the series. The merge conflict is not too bad, but will 
need a follow on patch to change the powerpc FDT size calculation 
(dropping the current FDT's size out).

Thanks for persisting!

Rob
