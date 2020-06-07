Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10D81F106C
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2020 01:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFGXde (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jun 2020 19:33:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34008 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgFGXdd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jun 2020 19:33:33 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id C1D9520B717B;
        Sun,  7 Jun 2020 16:33:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1D9520B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591572812;
        bh=DB6Cl6RHr8cekVcsDZkbuYBtSszswuXLUSqvQUhO2ps=;
        h=From:To:Cc:Subject:Date:From;
        b=jf58nVlwSpSms4FyBpvdpS5L/b68k74OADgHL6/JRsKRN65DEQGu08m5Y9vgZjXz7
         UMgDudDCE1Jx4rfifAEkUog31G9m/W1iUpE4SjPKR7or5h81nOg9rOO66POwl4ho6b
         Q+6FdMlHCNX3RzSGQ7tuKYlzVzkT1RmxfjrADR0Y=
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
Subject: [v1 PATCH 0/2] Adding support to carry IMA measurement logs
Date:   Sun,  7 Jun 2020 16:33:21 -0700
Message-Id: <20200607233323.22375-1-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA during kexec(kexec file load) verifies the kernel signature and measures
the signature of the kernel. The signature in the logs can be used to verfiy the 
authenticity of the kernel. The logs don not get carried over kexec and thus
remote attesation cannot verify the signature of the running kernel.

Add a new chosen node entry linux,ima-kexec-buffer to hold the address and
the size of the memory reserved to carry the IMA measurement log.

Tested on:
  arm64 with Uboot

Changelog:

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

 Documentation/devicetree/bindings/chosen.txt |  17 +++
 arch/arm64/Kconfig                           |   1 +
 arch/arm64/include/asm/ima.h                 |  24 +++
 arch/arm64/include/asm/kexec.h               |   3 +
 arch/arm64/kernel/machine_kexec_file.c       |  47 +++++-
 arch/powerpc/include/asm/ima.h               |   9 --
 arch/powerpc/kexec/ima.c                     | 117 +-------------
 security/integrity/ima/ima_kexec.c           | 151 +++++++++++++++++++
 8 files changed, 236 insertions(+), 133 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h

-- 
2.25.1

