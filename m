Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB822633D
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGTPXy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:23:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47582 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTPXy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:23:54 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id E4CDC20B4909;
        Mon, 20 Jul 2020 08:23:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4CDC20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595258633;
        bh=px+LpIYdzoDCqRn/AtnTcyp6tay3vEYvhWXD+wh+zDI=;
        h=From:To:Cc:Subject:Date:From;
        b=dhNCD1DMzrmLzQURopWP8dGFqQ74moJD0UypJyZSvQJB13lKSdn8RoZphRa7/2bch
         6tRfEml1w8K7lxp4M+B5ofn8EhJYgMVBOB30TuK5XLg44747pVSBxtn4IGxH5foACW
         +UwWQC7BBVE6zlqsk8SeNpYh0EIfK/4dB+WNjY3A=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, robh+dt@kernel.org,
        frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        gregkh@linuxfoundation.org, nramas@linux.microsoft.com,
        prsriva@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com, bauerman@linux.ibm.com,
        robh@kernel.org
Subject: [PATCH V3 0/6] Add support to carry forward the IMA measurement logs
Date:   Mon, 20 Jul 2020 08:23:36 -0700
Message-Id: <20200720152342.337990-1-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Integrgity Measurement Architecture(IMA) during kexec(kexec file load)
verifies the kernel signature and measures the signature of the kernel.

The signature in the measuremnt logs is used to verfiy the 
authenticity of the kernel in the subsequent kexec'd session, however in
the current implementation IMA measurement logs are not carried over thus
remote attesation cannot verify the signature of the running kernel.

Adding support to arm64 to carry over the IMA measurement logs over kexec.

Add a new chosen node entry linux,ima-kexec-buffer to hold the address and
the size of the memory reserved to carry the IMA measurement log.
Refactor existing powerpc code to be used by amr64 as well.  

Changelog:

v3:
Breakup patches further into separate patches.
  - Refactoring non architecture specific code out of powerpc
  - Update powerpc related code to use fdt functions
  - Update IMA buffer read related code to use of functions
  - Add support to store the memory information of the IMA measurement logs 
    to be carried forward.
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

Prakhar Srivastava (6):
  Refactoring powerpc code to be made available to other architectures
  Update remove_ima_buffer code to use functions from libfdt reducing
    wrappers functions.
  Update function do_get_kexec_buffer to use of_* functions, and
    reducing wrapper functions.
  Add support in arm64 to store the memory information of the IMA
    measurement log in the kimage used for kexec.
  Update the Kconfig to support carrying forward the IMA Measurement log
    and and update the setup_dtb call to add the linux,ima-kexec-buffer
    property to the DTB.
  Add the property used for carrying forward the IMA measurement logs
    and update the code to use the defined property string.

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/ima.h           |  17 ++++
 arch/arm64/include/asm/kexec.h         |   3 +
 arch/arm64/kernel/machine_kexec_file.c |  45 +++++++--
 arch/powerpc/include/asm/ima.h         |   3 -
 arch/powerpc/kexec/ima.c               | 123 ++++++-------------------
 security/integrity/ima/ima_kexec.c     |  81 ++++++++++++++++
 7 files changed, 168 insertions(+), 105 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h

-- 
2.25.1

