Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D52BBF52
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Nov 2020 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgKUN5c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 21 Nov 2020 08:57:32 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46878 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbgKUN5b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 Nov 2020 08:57:31 -0500
Received: by mail-qt1-f193.google.com with SMTP id f15so5868110qto.13;
        Sat, 21 Nov 2020 05:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0h4CYWpuve25An2pTG78idqFh/rYgn8LY4jQOAijea8=;
        b=Dsi+ktVs758/mOC/ywsshZVtagbrOeS7RuvIbR6Nh4pMWEfD4diP7eNw7KM5t+TvXc
         GpP55r9rAbUI9w04ePpL81JNhiktYbzvnTQST6mg/EsKBhh1F1d21OVh43yD8PZxqaoT
         HXQHSYCV4lwfEeu/CyPDM0b4aX0THbQpSZjoXs3uiVi85c/rIDkCtinZ6kVsn2nrEcDh
         3p8q3KYwv14E5RWPHp+/nQOiq0Xved5HNADGxKuQvgKU+Q85KurgXBUTJzcilTfIZumg
         K42vttdq5bGn0e7RuIjnd3nFcaOcZ7YorpPb6gg+NKE2C1vk+umFdv3xrTuXXKSSQQmV
         Te5Q==
X-Gm-Message-State: AOAM532OQWR/YshkevHJtSe1ys/cSPkf4J6G6opYFbHO647NdWnX/nbY
        xIvMpSl01HTGOXOM1cm3NQ==
X-Google-Smtp-Source: ABdhPJz54VLrIah9C/xyAXbbg01e60vDAe59jeL4VZUgeJRlxxd41q4MXkvQShMF7XrDnNZkTpLHpA==
X-Received: by 2002:ac8:5750:: with SMTP id 16mr112028qtx.305.1605967049115;
        Sat, 21 Nov 2020 05:57:29 -0800 (PST)
Received: from xps15 ([172.58.99.230])
        by smtp.gmail.com with ESMTPSA id q15sm3978379qki.13.2020.11.21.05.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 05:57:28 -0800 (PST)
Received: (nullmailer pid 2163712 invoked by uid 1000);
        Sat, 21 Nov 2020 13:57:19 -0000
Date:   Sat, 21 Nov 2020 07:57:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [PATCH v9 0/8] Carry forward IMA measurement log on kexec on
 ARM64
Message-ID: <20201121135719.GA2134870@robh.at.kernel.org>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113192243.1993-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 13, 2020 at 11:22:35AM -0800, Lakshmi Ramasubramanian wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it. The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA. A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data. This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.
> 
> powerpc already supports carrying forward the IMA measurement log on
> kexec. This patch set adds support for carrying forward the IMA
> measurement log on kexec on ARM64. 
> 
> This patch set moves the platform independent code defined for powerpc
> such that it can be reused for other platforms as well. A chosen node
> namely "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.
> 
> This patch set has been tested for ARM64 platform using QEMU.
> I would like help from the community for testing this change on powerpc.
> Thanks.

As I mentioned previously, please move the kexec code to drivers/of/. Or 
at least put the infrastructure in place so we're not defining public 
IMA functions and then making them static later.
 
> This patch set is based on
> commit af5043c89a8e ("Merge tag 'acpi-5.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm")
> in https://github.com/torvalds/linux "master" branch.
> 
> Changelog:
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
> Lakshmi Ramasubramanian (8):
>   powerpc: fix compiler warnings and errors
>   powerpc: Move delete_fdt_mem_rsv() to drivers/of
>   ima: Define get_ima_kexec_buffer() in drivers/of
>   powerpc: Use get_ima_kexec_buffer to get ima kexec buffer
>   powerpc: Move remove_ima_buffer() to drivers/of
>   powerpc: Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to
>     ima
>   arm64: Store IMA log information in kimage used for kexec
>   arm64: Add IMA kexec buffer to DTB
> 
>  arch/arm64/Kconfig                     |   1 +
>  arch/arm64/include/asm/ima.h           |  18 +++++
>  arch/arm64/include/asm/kexec.h         |   3 +
>  arch/arm64/kernel/Makefile             |   1 +
>  arch/arm64/kernel/ima_kexec.c          |  34 ++++++++
>  arch/arm64/kernel/machine_kexec_file.c |  18 +++++
>  arch/powerpc/include/asm/ima.h         |  11 +--
>  arch/powerpc/include/asm/kexec.h       |   1 -
>  arch/powerpc/kexec/Makefile            |   7 +-
>  arch/powerpc/kexec/file_load.c         |  32 --------
>  arch/powerpc/kexec/ima.c               | 106 ++-----------------------
>  drivers/of/Makefile                    |   9 +++

>  drivers/of/ima_kexec.c                 |  91 +++++++++++++++++++++
>  drivers/of/kexec_fdt.c                 |  55 +++++++++++++

Does this need to be 2 files? Just kexec.c?

>  include/linux/kexec.h                  |  24 ++++++
>  security/integrity/ima/ima_kexec.c     |  51 ++++++++++++
>  16 files changed, 313 insertions(+), 149 deletions(-)
>  create mode 100644 arch/arm64/include/asm/ima.h
>  create mode 100644 arch/arm64/kernel/ima_kexec.c
>  create mode 100644 drivers/of/ima_kexec.c
>  create mode 100644 drivers/of/kexec_fdt.c
> 
> -- 
> 2.29.2
> 
