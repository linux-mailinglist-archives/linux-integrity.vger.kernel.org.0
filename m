Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2AA316C55
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 18:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBJRQF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 12:16:05 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:44832 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhBJRPm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 12:15:42 -0500
Received: by mail-oi1-f177.google.com with SMTP id r75so2801916oie.11;
        Wed, 10 Feb 2021 09:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJ1RPXH4Ky3rknP1i83/kgXLfXXCz/TwgTUNKoCqZ64=;
        b=jCaPwHLnu4SSILpHP6GBhijrurgzTd4EbjrfWGRRnTjoN9QqldSK8wlbamU7by3rNk
         6ofNwZfHYZ2PLwo1xlIl1a82toGuiLntMCPj0NJDJVmQ3b3/H2ICtJaiO/b3TZHbbvuZ
         0xg0aUBSKyb/aNXUr6xypO7EvnkGwz+L4A/tQGdBs2jWTy8LtdvPN5FE9FHWnumRvR3r
         PahcY9sIL3/hIGDuJnU74GG8k+3/wr0h3J1ynehDliXPTa5nRZXP5QdTRnrWqdP3OPvy
         VT3RnD+xlVz+KNGRPKEQ23xgBTSHC2qSYq1VoXkKlAauLtF1iyxLw4oXFk1Oq7v5qKwv
         wf7Q==
X-Gm-Message-State: AOAM532yXct8P5Ll3nLNAKJZ+TdSovcfv2rf2o2tXHljS3Dqf3j5AC3S
        uCCylX6vD8eVOPETQuz83A==
X-Google-Smtp-Source: ABdhPJzsuQvHnbVMCnXzigZFYvy1mjydqefuslXLM2227BCJ57eYbmrcMRouWbgxLWOcD8sgwjoLFw==
X-Received: by 2002:a54:4803:: with SMTP id j3mr2257771oij.124.1612977302768;
        Wed, 10 Feb 2021 09:15:02 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u126sm567339oig.55.2021.02.10.09.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:15:02 -0800 (PST)
Received: (nullmailer pid 2360939 invoked by uid 1000);
        Wed, 10 Feb 2021 17:15:00 -0000
Date:   Wed, 10 Feb 2021 11:15:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v17 00/10] Carry forward IMA measurement log on kexec on
 ARM64
Message-ID: <20210210171500.GA2328209@robh.at.kernel.org>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209182200.30606-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 09, 2021 at 10:21:50AM -0800, Lakshmi Ramasubramanian wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it.  The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA.  A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data.  This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.
> 
> powerpc already supports carrying forward the IMA measurement log on
> kexec.  This patch set adds support for carrying forward the IMA
> measurement log on kexec on ARM64.
> 
> This patch set moves the platform independent code defined for powerpc
> such that it can be reused for other platforms as well.  A chosen node
> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> the address and the size of the memory reserved to carry
> the IMA measurement log.
> 
> This patch set has been tested for ARM64 platform using QEMU.
> I would like help from the community for testing this change on powerpc.
> Thanks.
> 
> This patch set is based on
> commit 96acc833dec8 ("ima: Free IMA measurement buffer after kexec syscall")
> in https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> "next-integrity" branch.

Is that a hard dependency still? Given this is now almost entirely 
deleting arch code and adding drivers/of/ code, I was going to apply it.

Rob
