Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC3924A4CA
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHSRVm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 13:21:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44272 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgHSRVl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 13:21:41 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 078BA20B4908;
        Wed, 19 Aug 2020 10:21:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 078BA20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597857699;
        bh=UpCfcaHQrahaE2T3GHBLtMjY0drv+g0vhF7DKb3WEmo=;
        h=From:To:Cc:Subject:Date:From;
        b=YLP9CsoM9+5i4nPMXgM3TcscEWd4is442Fgao4Fs+4kG9BhBi5x8a4k4rDP/u0ObV
         4DVtI3R8Lo+DGxV9xvdnTYzDf18hiqq0tY5jFiu0HWKeYMzzSQUZ0LOnckdcSq2Uo6
         jmC2VNXMLvOTfqYu7iTck1JiGCglBJ1KAgoTOZm0=
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
Subject: [PATCH v4 0/5] Carry forward IMA measurement log on kexec on ARM64
Date:   Wed, 19 Aug 2020 10:21:29 -0700
Message-Id: <20200819172134.11243-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On kexec file load Integrgity Measurement Architecture(IMA) subsystem
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

This series refactors the platform independent code such that it can be
reused for ARM64 as well. A chosen node namely
"linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
the address and the size of the memory reserved to carry
the IMA measurement log.

This patch series has been tested for ARM64 platform using QEMU.
I would like help from the community for testing this change on powerpc.
Thanks.

This series is based on commit 18445bf405cb ("Merge tag 'spi-fix-v5.9-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi") in
https://github.com/torvalds/linux "master" branch.

Changelog:

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

Lakshmi Ramasubramanian (5):
  powerpc: Refactor kexec functions to move arch independent code to IMA
  powerpc: Use libfdt functions to fetch IMA buffer properties
  IMA: Refactor do_get_kexec_buffer() to call of_ functions directly
  arm64: Store IMA log information in kimage used for kexec
  arm64: Add IMA kexec buffer to DTB

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/ima.h           |  17 ++++
 arch/arm64/include/asm/kexec.h         |   3 +
 arch/arm64/kernel/machine_kexec_file.c |  28 ++++++
 arch/powerpc/include/asm/ima.h         |   3 -
 arch/powerpc/kexec/ima.c               | 123 ++++++-------------------
 include/linux/libfdt.h                 |   3 +
 security/integrity/ima/ima_kexec.c     |  81 ++++++++++++++++
 8 files changed, 161 insertions(+), 98 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h

-- 
2.28.0

