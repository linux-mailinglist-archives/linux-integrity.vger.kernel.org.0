Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6980A1FEBEE
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgFRHLK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 03:11:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60552 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgFRHLK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 03:11:10 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8918F20B4781;
        Thu, 18 Jun 2020 00:11:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8918F20B4781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592464269;
        bh=lDSc0jJUTA/sW6q8KjNuhbmPa1VR7NZJ8pXu5G8PT78=;
        h=From:To:Cc:Subject:Date:From;
        b=aG83qxYXRNhqUmLDNYpbm33MDP2wZSL6QKrD2jzlLiNColOuwrb8FqAsVDhwxeIUj
         F6PyyYZeZsLvmO03Jk+E0IfjD1E+TJlD0wQIkfoT4XYzNzULxLkKcEFezwju6U+yNW
         CQB9TkUkQuhmLmJNPl9ot4OJOFtVYYPbjejsJWrw=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
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
        balajib@linux.microsoft.com
Subject: [V2 PATCH 0/3] Adding support for carrying IMA measurement logs
Date:   Thu, 18 Jun 2020 00:10:42 -0700
Message-Id: <20200618071045.471131-1-prsriva@linux.microsoft.com>
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

Prakhar Srivastava (3):
  Refactoring powerpc code for carrying over IMA measurement logs, to
    move non architecture specific code to security/ima.
  dt-bindings: chosen: Document ima-kexec-buffer carrying over IMA
    measuremnt logs over kexec.
  Add support for arm64 to carry over IMA measurement logs

 Documentation/devicetree/bindings/chosen.txt |  17 +++
 arch/arm64/Kconfig                           |   1 +
 arch/arm64/include/asm/ima.h                 |  17 +++
 arch/arm64/include/asm/kexec.h               |   3 +
 arch/arm64/kernel/machine_kexec_file.c       |  47 +++++--
 arch/powerpc/include/asm/ima.h               |  10 --
 arch/powerpc/kexec/ima.c                     | 126 ++-----------------
 security/integrity/ima/ima_kexec.c           | 116 +++++++++++++++++
 8 files changed, 201 insertions(+), 136 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h

-- 
2.25.1

