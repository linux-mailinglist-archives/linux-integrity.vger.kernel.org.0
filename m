Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E921C4866
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2020 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEDUij (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 May 2020 16:38:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34860 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDUij (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 May 2020 16:38:39 -0400
Received: from prsriva-linux.hsd1.wa.comcast.net (c-24-19-135-168.hsd1.wa.comcast.net [24.19.135.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6895820B717B;
        Mon,  4 May 2020 13:38:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6895820B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588624718;
        bh=6P2paN9NO0FWx6B7UbSmB/LcZk3eOjU9tLNhjVjgu2E=;
        h=From:To:Cc:Subject:Date:From;
        b=K3BUKLXFPzHk5/vc18E2X2yGYsVoVrEVR3Bjxnk0kkNoK1RyGJF07VpR4jNjPdswq
         PTdElXCTeIvlEoVsKZH0Tk/UjQ3124JQLUs2fMp9IFj0dQ3idwPz+efdmEETdAO+dm
         kf7mZQNd1GyWhA36D3uKZsPysbTHSk1ty11ir9Jk=
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
Subject: [RFC][PATCH 0/2] Add support for using reserved memory for ima buffer pass
Date:   Mon,  4 May 2020 13:38:27 -0700
Message-Id: <20200504203829.6330-1-prsriva@linux.microsoft.com>
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

Introduce an ABI to carry forward the ima logs over kexec.
Memory reserved via device tree reservation can be used to store and read
via the of_* functions.

Reserved memory stores the size(sizeof(size_t)) of the buffer in the starting
address, followed by the IMA log contents.

Tested on:
  arm64 with Uboot

Prakhar Srivastava (2):
  Add a layer of abstraction to use the memory reserved by device tree
    for ima buffer pass.
  Add support for ima buffer pass using reserved memory for arm64 kexec.
    Update the arch sepcific code path in kexec file load to store the
    ima buffer in the reserved memory. The same reserved memory is read
    on kexec or cold boot.

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/ima.h           |  22 ++++
 arch/arm64/include/asm/kexec.h         |   5 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/ima_kexec.c          |  64 ++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   1 +
 arch/powerpc/include/asm/ima.h         |   3 +-
 arch/powerpc/kexec/ima.c               |  14 ++-
 drivers/of/Kconfig                     |   6 +
 drivers/of/Makefile                    |   1 +
 drivers/of/of_ima.c                    | 165 +++++++++++++++++++++++++
 include/linux/of.h                     |  34 +++++
 security/integrity/ima/ima_kexec.c     |  15 ++-
 13 files changed, 325 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c
 create mode 100644 drivers/of/of_ima.c

-- 
2.25.1

