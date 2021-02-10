Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7542431718C
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 21:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhBJUnu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 15:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhBJUns (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 15:43:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9559364EF1;
        Wed, 10 Feb 2021 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612989787;
        bh=uLOKAWM3j/FoxqUD8GT+3TtzddPUhVZXn4EjHpRaYRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K74lobox4y7gUuWJf5x9BZjKZ34y96W1chSRDGXNta6UmHLrqFFjA3wj1PI7xTRij
         syQ7wcueUW7+HioanlcWrFZ0mRRhCeQHaYHVrWB7vXOoZCT3QM0F6PzY0OBJCyfa2g
         19AbOG0dGhyn272NCJsuCuPusha+toPskSq3/V4Y0CoDPuZ1LCvDvTk2gmKq9m+Od0
         SgxkbRWyNazA1+tMMqRp6LJILmxOqLBK3AAkF2dIT5x05/aHtBSN3Lj73mFx6XTQOF
         EWUmv2cD4UPu3hAnoDhpMrgxWWRulqA5/PyRK28xe20b2Dpfjk2cIjNbkc51Dti93W
         SPnRe2Tt/v/+Q==
Received: by mail-ej1-f52.google.com with SMTP id w2so6484086ejk.13;
        Wed, 10 Feb 2021 12:43:07 -0800 (PST)
X-Gm-Message-State: AOAM532lwZ4odP6jGqshavMz1Gd8rWKnlnzkoWYuxPwFGG2CuocHh7qj
        JTZSMRJtFhZ6GTD2INpWq0vFwsjYiwMt3lvKQg==
X-Google-Smtp-Source: ABdhPJyZOou+FoAa1VvtSo/LHBp8mrbstlSxAr2IxMuuWsdlFjqx8EC6dZAWMoScFPYRRlNAEw7N0EavS9AV9/V0P7o=
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr4612652ejb.525.1612989785769;
 Wed, 10 Feb 2021 12:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210210171500.GA2328209@robh.at.kernel.org> <5c002c32-bc49-acda-c641-7b1494ea292d@linux.microsoft.com>
In-Reply-To: <5c002c32-bc49-acda-c641-7b1494ea292d@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Feb 2021 14:42:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLmdqfFF8u=dE+dQz+6ngv=moWkQF8tpZjUCX-vHuvU_w@mail.gmail.com>
Message-ID: <CAL_JsqLmdqfFF8u=dE+dQz+6ngv=moWkQF8tpZjUCX-vHuvU_w@mail.gmail.com>
Subject: Re: [PATCH v17 00/10] Carry forward IMA measurement log on kexec on ARM64
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        vincenzo.frascino@arm.com, Mark Rutland <mark.rutland@arm.com>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 10, 2021 at 11:33 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 2/10/21 9:15 AM, Rob Herring wrote:
> > On Tue, Feb 09, 2021 at 10:21:50AM -0800, Lakshmi Ramasubramanian wrote:
> >> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> >> may verify the IMA signature of the kernel and initramfs, and measure
> >> it.  The command line parameters passed to the kernel in the kexec call
> >> may also be measured by IMA.  A remote attestation service can verify
> >> a TPM quote based on the TPM event log, the IMA measurement list, and
> >> the TPM PCR data.  This can be achieved only if the IMA measurement log
> >> is carried over from the current kernel to the next kernel across
> >> the kexec call.
> >>
> >> powerpc already supports carrying forward the IMA measurement log on
> >> kexec.  This patch set adds support for carrying forward the IMA
> >> measurement log on kexec on ARM64.
> >>
> >> This patch set moves the platform independent code defined for powerpc
> >> such that it can be reused for other platforms as well.  A chosen node
> >> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
> >> the address and the size of the memory reserved to carry
> >> the IMA measurement log.
> >>
> >> This patch set has been tested for ARM64 platform using QEMU.
> >> I would like help from the community for testing this change on powerpc.
> >> Thanks.
> >>
> >> This patch set is based on
> >> commit 96acc833dec8 ("ima: Free IMA measurement buffer after kexec syscall")
> >> in https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> >> "next-integrity" branch.
> >
> > Is that a hard dependency still? Given this is now almost entirely
> > deleting arch code and adding drivers/of/ code, I was going to apply it.
> >
>
> I tried applying the patches in Linus' mainline branch -
> PATCH #5 0005-powerpc-Move-ima-buffer-fields-to-struct-kimage.patch
> doesn't apply.
>
> But if I apply the dependent patch set (link given below), all the
> patches in this patch set apply fine.
>
> https://patchwork.kernel.org/project/linux-integrity/patch/20210204174951.25771-2-nramas@linux.microsoft.com/

Ideally, we don't apply the same patch in 2 branches. It looks like
there's a conflict but no real dependence on the above patch (the
ima_buffer part). The conflict seems trivial enough that Linus can
resolve it in the merge window.

Or Mimi can take the whole thing if preferred?

Rob
