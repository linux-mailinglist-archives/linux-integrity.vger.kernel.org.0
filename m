Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8BE2A0CAD
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 18:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgJ3Ros (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 13:44:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50146 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgJ3Ror (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 13:44:47 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 555AE20B4905;
        Fri, 30 Oct 2020 10:44:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 555AE20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604079885;
        bh=7TnyUaUUazyljvJPPu7HdnhPyePCDIjVBvgDsHhSRLc=;
        h=From:To:Cc:Subject:Date:From;
        b=ng9FydkfzsZt/fGyVRKu8dfu897Ws3lduxS5VWUfvYwvb/EZ79lA/8LxQPiQCl9jq
         fGCgMmlJVnYiu+HLgn22ljYKKYsuPhPifGERWIROXejoP1T29AdrJOhOhq5qDwpbig
         7PRORV+hbhyFdFUPectQ/GJrCJrdw51LCwngHfAc=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [PATCH v8 0/4] Carry forward IMA measurement log on kexec on ARM64
Date:   Fri, 30 Oct 2020 10:44:25 -0700
Message-Id: <20201030174429.29893-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On kexec file load Integrity Measurement Architecture (IMA) subsystem
may verify the IMA signature of the kernel and initramfs, and measure
it. The command line parameters passed to the kernel in the kexec call
may also be measured by IMA. A remote attestation service can verify
the measurement through the IMA log and the TPM PCR data. This can be
achieved only if the IMA measurement log is carried over from
the current kernel to the next kernel across the kexec call.
However in the current implementation the IMA measurement logs are not
carried over on ARM64 platforms. Therefore a remote attestation service
cannot verify the authenticity of the running kernel on ARM64 platforms
when the kernel is updated through the kexec system call.

This patch series adds support for carrying forward the IMA measurement
log on kexec on ARM64. powerpc already supports carrying forward
the IMA measurement log on kexec.

This series refactors the platform independent code defined for powerpc
such that it can be reused for ARM64 as well. A chosen node namely
"linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
the address and the size of the memory reserved to carry
the IMA measurement log.

This patch series has been tested for ARM64 platform using QEMU.
I would like help from the community for testing this change on powerpc.
Thanks.

This patch series is based on
commit 598a597636f8 ("Merge tag 'afs-fixes-20201029' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs")
in https://github.com/torvalds/linux "master" branch.

Changelog:

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

Lakshmi Ramasubramanian (4):
  powerpc: Refactor kexec functions to move arch independent code to
    drivers/of
  powerpc: Refactor kexec functions to move arch independent code to ima
  arm64: Store IMA log information in kimage used for kexec
  arm64: Add IMA kexec buffer to DTB

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/ima.h           |  18 ++++
 arch/arm64/include/asm/kexec.h         |   3 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/ima_kexec.c          |  34 ++++++++
 arch/arm64/kernel/machine_kexec_file.c |  18 ++++
 arch/powerpc/include/asm/ima.h         |  13 +--
 arch/powerpc/include/asm/kexec.h       |   1 -
 arch/powerpc/kexec/Makefile            |   7 +-
 arch/powerpc/kexec/file_load.c         |  33 +-------
 arch/powerpc/kexec/ima.c               | 111 ++-----------------------
 drivers/of/fdt.c                       | 110 ++++++++++++++++++++++++
 include/linux/kexec.h                  |  24 ++++++
 include/linux/libfdt.h                 |   3 +
 security/integrity/ima/ima_kexec.c     |  57 +++++++++++++
 15 files changed, 282 insertions(+), 152 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c

-- 
2.29.0

