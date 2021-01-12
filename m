Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36F2F331E
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 15:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbhALOnd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 09:43:33 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34043 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbhALOnc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 09:43:32 -0500
Received: by mail-ot1-f41.google.com with SMTP id a109so2482344otc.1;
        Tue, 12 Jan 2021 06:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jLuXNEmtLsh4q/WoTJHKIzGwbfv3S50Xpe/RyA9VIyM=;
        b=A2iCrX+rVzFMlQuiC8ZLlPg4IOjM9d2FfMyWcp/Dt4cslwICMjoNaSmN0HMe1bm1iy
         QQJVYmPjlqBIYQYBBO4C0JrDEENz/AxTraizpCa3ogWJjwTJa66rZ63xqcl0V8/dE7rf
         q/q7ZNTS1BkuqajcaICD7qPrErmBxQG3oDGwA6+V3NxJMiU6csWOKEdmc3hH3UVd6e6V
         7nCt5Js2XnSQKPkQQvfbYxwzG9I9u8girfeaOeDBgc4BaYsdSnpI+MKrWb9+vGXJFhWh
         aNLEAA8r+2pT5M4rZHsALWrqr8sLKZAPc9UPZZTOq1Rm191Ph09wNFdkMglmLnUCPCDb
         Rx6w==
X-Gm-Message-State: AOAM531ntcqTSrfOj/3DQdxQTPMbFxS9JXbr53a+jnRfErzkTif1Ocab
        I7ZBizIqvtCJzG7LgePAwDFH5HbEwQ==
X-Google-Smtp-Source: ABdhPJzjdAg7vY7kX3mqmavPKtL3svboVN48BuxP85NLoc3mx90pHjm3o+5h8okafMrBIipAWaNpRQ==
X-Received: by 2002:a9d:ec5:: with SMTP id 63mr2969536otj.181.1610462571490;
        Tue, 12 Jan 2021 06:42:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c18sm675458oib.31.2021.01.12.06.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:42:50 -0800 (PST)
Received: (nullmailer pid 321418 invoked by uid 1000);
        Tue, 12 Jan 2021 14:42:48 -0000
Date:   Tue, 12 Jan 2021 08:42:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@vger.kernel.org
Subject: Re: [PATCH v14 0/6] Carry forward IMA measurement log on kexec on
 ARM64
Message-ID: <20210112144248.GA256955@robh.at.kernel.org>
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104192602.10131-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 04, 2021 at 11:25:56AM -0800, Lakshmi Ramasubramanian wrote:
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
> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.
> 
> This patch set has been tested for ARM64 platform using QEMU.
> I would like help from the community for testing this change on powerpc.
> Thanks.
> 
> This patch set is based on
> commit a29a64445089 ("powerpc: Use common of_kexec_setup_new_fdt()")
> in https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> "dt/kexec" branch.

This all looks good to me. I'd suggest you send the above patches out as 
part of this series because I don't plan to do so.

I would like to also resolve the vmalloc vs. kmalloc difference for 
allocating the FDT. Then we can further consolidate the DT kexec code. 

It all needs some acks from arm64 and powerpc maintainers. As far as 
merging, I think via the integrity tree makes the most sense.

Rob
