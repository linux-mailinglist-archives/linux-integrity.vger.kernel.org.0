Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2351320C35
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Feb 2021 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBURuU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 12:50:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44982 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhBURuT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 12:50:19 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C3F5C20B6C40;
        Sun, 21 Feb 2021 09:49:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3F5C20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613929776;
        bh=l1x+qtiXlsGVGhQQJtC8xXukw9XCenTLK/rpc4QvrFU=;
        h=From:To:Cc:Subject:Date:From;
        b=e3Kuj6XWD28rC8Oy3c13SB9rQO7lYDMlNXgmqmwUOvHooZxeTsIzsCVDPZJTn89DX
         yPsTgyXunYY8yubWCMtj/A2f+Bkqu/PX5FUEUFUAcKldFhESwAM9EdSH1vFlIcMcgK
         mtGZ4yfWV2BXYcpC7Y0QKj3uBarpZ3+/+RUkxT3k=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, sfr@canb.auug.org.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v19 00/13] Carry forward IMA measurement log on kexec on ARM64
Date:   Sun, 21 Feb 2021 09:49:17 -0800
Message-Id: <20210221174930.27324-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On kexec file load Integrity Measurement Architecture (IMA) subsystem
may verify the IMA signature of the kernel and initramfs, and measure
it.  The command line parameters passed to the kernel in the kexec call
may also be measured by IMA.  A remote attestation service can verify
a TPM quote based on the TPM event log, the IMA measurement list, and
the TPM PCR data.  This can be achieved only if the IMA measurement log
is carried over from the current kernel to the next kernel across
the kexec call.

powerpc already supports carrying forward the IMA measurement log on
kexec.  This patch set adds support for carrying forward the IMA
measurement log on kexec on ARM64.

This patch set moves the platform independent code defined for powerpc
such that it can be reused for other platforms as well.  A chosen node
"linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
the address and the size of the memory reserved to carry
the IMA measurement log.

This patch set has been tested for ARM64 platform using QEMU.
I would like help from the community for testing this change on powerpc.
Thanks.

This patch set is based on
commit f31e3386a4e9 ("ima: Free IMA measurement buffer after kexec syscall")
in https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
"ima-kexec-fixes" branch.

Changelog:

v19
  - Moved ELF related fields from "struct kimage_arch" for x86, arm64,
    and powerpc architectures to "struct kimage".

v18
  - Added a parameter to of_kexec_alloc_and_setup_fdt() for the caller
    to specify additional space needed for the FDT buffer
  - Renamed arm64 and powerpc ELF buffer address field in
    "struct kimage_arch" to elf_load_addr to match x86_64 name.
  - Removed of_ima_add_kexec_buffer() and instead directly set
    ima_buffer_addr and ima_buffer_size in ima_add_kexec_buffer()
  - Moved FDT_EXTRA_SPACE definition from include/linux/of.h to
    drivers/of/kexec.c

v17
  - Renamed of_kexec_setup_new_fdt() to of_kexec_alloc_and_setup_fdt(),
    and moved memory allocation for the new FDT to this function.

v16
  - Defined functions to allocate and free buffer for FDT for powerpc
    and arm64.
  - Moved ima_buffer_addr and ima_buffer_size fields from
    "struct kimage_arch" in powerpc to "struct kimage"
v15
  - Included Rob's patches in the patch set, and rebased
    the changes to "next-integrity" branch.
  - Allocate memory for DTB, on arm64, using kmalloc() instead of
    vmalloc() to keep it consistent with powerpc implementation.
  - Call of_kexec_setup_new_fdt() from setup_new_fdt_ppc64() and
    remove setup_new_fdt() in the same patch to keep it bisect safe.

v14
  - Select CONFIG_HAVE_IMA_KEXEC for CONFIG_KEXEC_FILE, for powerpc
    and arm64, if CONFIG_IMA is enabled.
  - Use IS_ENABLED() macro instead of "#ifdef" in remove_ima_buffer(),
    ima_get_kexec_buffer(), and ima_free_kexec_buffer().
  - Call of_kexec_setup_new_fdt() from setup_new_fdt_ppc64() and
    remove setup_new_fdt() in "arch/powerpc/kexec/file_load.c".

v13
  - Moved the arch independent functions to drivers/of/kexec.c
    and then refactored the code.
  - Moved arch_ima_add_kexec_buffer() to
    security/integrity/ima/ima_kexec.c

v12
  - Use fdt_appendprop_addrrange() in setup_ima_buffer()
    to setup the IMA measurement list property in
    the device tree.
  - Moved architecture independent functions from
    "arch/powerpc/kexec/ima.c" to "drivers/of/kexec."
  - Deleted "arch/powerpc/kexec/ima.c" and
    "arch/powerpc/include/asm/ima.h".

v11
  - Rebased the changes on the kexec code refactoring done by
    Rob Herring in his "dt/kexec" branch
  - Removed "extern" keyword in function declarations
  - Removed unnecessary header files included in C files
  - Updated patch descriptions per Thiago's comments

v10
  - Moved delete_fdt_mem_rsv(), remove_ima_buffer(),
    get_ima_kexec_buffer, and get_root_addr_size_cells()
    to drivers/of/kexec.c
  - Moved arch_ima_add_kexec_buffer() to
    security/integrity/ima/ima_kexec.c
  - Conditionally define IMA buffer fields in struct kimage_arch

v9
  - Moved delete_fdt_mem_rsv() to drivers/of/kexec_fdt.c
  - Defined a new function get_ima_kexec_buffer() in
    drivers/of/ima_kexec.c to replace do_get_kexec_buffer()
  - Changed remove_ima_kexec_buffer() to the original function name
    remove_ima_buffer()
  - Moved remove_ima_buffer() to drivers/of/ima_kexec.c
  - Moved ima_get_kexec_buffer() and ima_free_kexec_buffer()
    to security/integrity/ima/ima_kexec.c

v8:
  - Moved remove_ima_kexec_buffer(), do_get_kexec_buffer(), and
    delete_fdt_mem_rsv() to drivers/of/fdt.c
  - Moved ima_dump_measurement_list() and ima_add_kexec_buffer()
    back to security/integrity/ima/ima_kexec.c

v7:
  - Renamed remove_ima_buffer() to remove_ima_kexec_buffer() and moved
    this function definition to kernel.
  - Moved delete_fdt_mem_rsv() definition to kernel
  - Moved ima_dump_measurement_list() and ima_add_kexec_buffer() to
    a new file namely ima_kexec_fdt.c in IMA

v6:
  - Remove any existing FDT_PROP_IMA_KEXEC_BUFFER property in the device
    tree and also its corresponding memory reservation in the currently
    running kernel.
  - Moved the function remove_ima_buffer() defined for powerpc to IMA
    and renamed the function to ima_remove_kexec_buffer(). Also, moved
    delete_fdt_mem_rsv() from powerpc to IMA.

v5:
  - Merged get_addr_size_cells() and do_get_kexec_buffer() into a single
    function when moving the arch independent code from powerpc to IMA
  - Reverted the change to use FDT functions in powerpc code and added
    back the original code in get_addr_size_cells() and
    do_get_kexec_buffer() for powerpc.
  - Added fdt_add_mem_rsv() for ARM64 to reserve the memory for
    the IMA log buffer during kexec.
  - Fixed the warning reported by kernel test bot for ARM64
    arch_ima_add_kexec_buffer() - moved this function to a new file
    namely arch/arm64/kernel/ima_kexec.c

v4:
  - Submitting the patch series on behalf of the original author
    Prakhar Srivastava <prsriva@linux.microsoft.com>
  - Moved FDT_PROP_IMA_KEXEC_BUFFER ("linux,ima-kexec-buffer") to
    libfdt.h so that it can be shared by multiple platforms.

v3:
Breakup patches further into separate patches.
  - Refactoring non architecture specific code out of powerpc
  - Update powerpc related code to use fdt functions
  - Update IMA buffer read related code to use of functions
  - Add support to store the memory information of the IMA
    measurement logs to be carried forward.
  - Update the property strings to align with documented nodes
    https://github.com/devicetree-org/dt-schema/pull/46

v2:
  Break patches into separate patches.
  - Powerpc related Refactoring
  - Updating the docuemntation for chosen node
  - Updating arm64 to support IMA buffer pass

v1:
  Refactoring carrying over IMA measuremnet logs over Kexec. This patch
    moves the non-architecture specific code out of powerpc and adds to
    security/ima.(Suggested by Thiago)
  Add Documentation regarding the ima-kexec-buffer node in the chosen
    node documentation

v0:
  Add a layer of abstraction to use the memory reserved by device tree
    for ima buffer pass.
  Add support for ima buffer pass using reserved memory for arm64 kexec.
    Update the arch sepcific code path in kexec file load to store the
    ima buffer in the reserved memory. The same reserved memory is read
    on kexec or cold boot.

Lakshmi Ramasubramanian (10):
  kexec: Move ELF fields to struct kimage
  arm64: Use ELF fields defined in 'struct kimage'
  powerpc: Use ELF fields defined in 'struct kimage'
  x86: Use ELF fields defined in 'struct kimage'
  powerpc: Move ima buffer fields to struct kimage
  powerpc: Enable passing IMA log to next kernel on kexec
  powerpc: Move arch independent ima kexec functions to
    drivers/of/kexec.c
  kexec: Use fdt_appendprop_addrrange() to add ima buffer to FDT
  powerpc: Delete unused function delete_fdt_mem_rsv()
  arm64: Enable passing IMA log to next kernel on kexec

Rob Herring (3):
  of: Add a common kexec FDT setup function
  arm64: Use common of_kexec_alloc_and_setup_fdt()
  powerpc: Use common of_kexec_alloc_and_setup_fdt()

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/kexec.h         |   4 -
 arch/arm64/kernel/machine_kexec_file.c | 194 +----------
 arch/powerpc/Kconfig                   |   2 +-
 arch/powerpc/include/asm/ima.h         |  30 --
 arch/powerpc/include/asm/kexec.h       |  14 +-
 arch/powerpc/kexec/Makefile            |   7 -
 arch/powerpc/kexec/elf_64.c            |  30 +-
 arch/powerpc/kexec/file_load.c         | 183 +---------
 arch/powerpc/kexec/file_load_64.c      |  21 +-
 arch/powerpc/kexec/ima.c               | 219 ------------
 arch/x86/include/asm/kexec.h           |   5 -
 arch/x86/kernel/crash.c                |  14 +-
 arch/x86/kernel/kexec-bzimage64.c      |   2 +-
 arch/x86/kernel/machine_kexec_64.c     |   4 +-
 drivers/of/Makefile                    |   6 +
 drivers/of/kexec.c                     | 458 +++++++++++++++++++++++++
 include/linux/kexec.h                  |   8 +
 include/linux/of.h                     |   7 +
 security/integrity/ima/ima.h           |   4 -
 security/integrity/ima/ima_kexec.c     |   9 +-
 21 files changed, 539 insertions(+), 683 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/ima.h
 delete mode 100644 arch/powerpc/kexec/ima.c
 create mode 100644 drivers/of/kexec.c

-- 
2.30.0

