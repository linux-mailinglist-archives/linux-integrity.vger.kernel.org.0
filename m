Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25EB1C5245
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2020 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgEEJ7W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 May 2020 05:59:22 -0400
Received: from foss.arm.com ([217.140.110.172]:35942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgEEJ7W (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 May 2020 05:59:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A77330E;
        Tue,  5 May 2020 02:59:21 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A74BF3F305;
        Tue,  5 May 2020 02:59:13 -0700 (PDT)
Date:   Tue, 5 May 2020 10:59:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        masahiroy@kernel.org, james.morse@arm.com, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, gregkh@linuxfoundation.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: Re: [RFC][PATCH 0/2] Add support for using reserved memory for ima
 buffer pass
Message-ID: <20200505095620.GA82424@C02TD0UTHF1T.local>
References: <20200504203829.6330-1-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504203829.6330-1-prsriva@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

On Mon, May 04, 2020 at 01:38:27PM -0700, Prakhar Srivastava wrote:
> IMA during kexec(kexec file load) verifies the kernel signature and measures
> the signature of the kernel. The signature in the logs can be used to verfiy the 
> authenticity of the kernel. The logs don not get carried over kexec and thus
> remote attesation cannot verify the signature of the running kernel.
> 
> Introduce an ABI to carry forward the ima logs over kexec.
> Memory reserved via device tree reservation can be used to store and read
> via the of_* functions.

This flow needs to work for:

1) Pure DT
2) DT + EFI memory map
3) ACPI + EFI memory map

... and if this is just for transiently passing the log, I don't think
that a reserved memory region is the right thing to use, since they're
supposed to be more permanent.

This sounds analogous to passing the initrd, and should probably use
properties under the chosen node (which can be used for all three boot
flows above).

For reference, how big is the IMA log likely to be? Does it need
physically contiguous space?

Thanks,
Mark.

> 
> Reserved memory stores the size(sizeof(size_t)) of the buffer in the starting
> address, followed by the IMA log contents.
> 
> Tested on:
>   arm64 with Uboot
> 
> Prakhar Srivastava (2):
>   Add a layer of abstraction to use the memory reserved by device tree
>     for ima buffer pass.
>   Add support for ima buffer pass using reserved memory for arm64 kexec.
>     Update the arch sepcific code path in kexec file load to store the
>     ima buffer in the reserved memory. The same reserved memory is read
>     on kexec or cold boot.
> 
>  arch/arm64/Kconfig                     |   1 +
>  arch/arm64/include/asm/ima.h           |  22 ++++
>  arch/arm64/include/asm/kexec.h         |   5 +
>  arch/arm64/kernel/Makefile             |   1 +
>  arch/arm64/kernel/ima_kexec.c          |  64 ++++++++++
>  arch/arm64/kernel/machine_kexec_file.c |   1 +
>  arch/powerpc/include/asm/ima.h         |   3 +-
>  arch/powerpc/kexec/ima.c               |  14 ++-
>  drivers/of/Kconfig                     |   6 +
>  drivers/of/Makefile                    |   1 +
>  drivers/of/of_ima.c                    | 165 +++++++++++++++++++++++++
>  include/linux/of.h                     |  34 +++++
>  security/integrity/ima/ima_kexec.c     |  15 ++-
>  13 files changed, 325 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ima.h
>  create mode 100644 arch/arm64/kernel/ima_kexec.c
>  create mode 100644 drivers/of/of_ima.c
> 
> -- 
> 2.25.1
> 
