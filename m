Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E612DDB25
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 23:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgLQWCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 17:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLQWCX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 17:02:23 -0500
X-Gm-Message-State: AOAM530ZkZhiarVGzJ6OZojQMghmwUQB4SBiFJlBpTM+RSDPZT8GWP08
        QW/jnC4uUPSQUZdOW2dtHi9Mc8Vr6AK/TiQsKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608242502;
        bh=Tvn9jrecEQspYro+q9S2fWwt824cwVXTxc9Kum0JJ/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qXFm60GqKVBH/gTpEe/wzO4dP4IVQ5Uqg70JiTCF8T5e3iAoPJIUA+qaP2IwbKWTW
         50u2qUkasgq8ibYgrKzahMbQ8juu+gAK9jKY/upWV9tlszh4k+b5BCX95R2uG71jB4
         XWY/yJD37tIaSk8hLpaQt7Ixc0xnSftp1KRELT2loYIBlBM/GRAlX1jdB/QUbc4VKi
         O4VAjom/G1gTazl7XbTSeZi9PX5T5zsnmS89Pk6e6FLWe8G9WWeIyP7a1mj3wiejEy
         3aciomts1pBHNfjyK5fvGGtfCEIlnWai2+H1xRIz2f6aihHH1DrtdHHo4Q1RbOG2Q+
         YAYZrur7+qmIA==
X-Google-Smtp-Source: ABdhPJwVvM6GScbCAPsAZsTId9M4kSeq2qbkfeKeKIXw4C5P5GAPV1Qz9568jeeXjj7XqFj+HArKxkkKtJrc72tSvc8=
X-Received: by 2002:a17:906:d784:: with SMTP id pj4mr1079986ejb.360.1608242500803;
 Thu, 17 Dec 2020 14:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20201217173708.6940-1-nramas@linux.microsoft.com>
 <20201217173708.6940-3-nramas@linux.microsoft.com> <20201217200510.GA105447@robh.at.kernel.org>
 <0b17fbee-cfe9-8cb2-01d1-02b6a61a14f5@linux.microsoft.com>
In-Reply-To: <0b17fbee-cfe9-8cb2-01d1-02b6a61a14f5@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Dec 2020 16:01:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-HOkxtxOO=zyRbDuGVNZoMy589qoVANciNionsdsGCw@mail.gmail.com>
Message-ID: <CAL_Jsq+-HOkxtxOO=zyRbDuGVNZoMy589qoVANciNionsdsGCw@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
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
        Bhupesh Sharma <bhsharma@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 17, 2020 at 2:52 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 12/17/20 12:05 PM, Rob Herring wrote:
> > On Thu, Dec 17, 2020 at 09:37:06AM -0800, Lakshmi Ramasubramanian wrote:
> >> The functions defined in "arch/powerpc/kexec/ima.c" handle setting up
> >> and freeing the resources required to carry over the IMA measurement
> >> list from the current kernel to the next kernel across kexec system call.
> >> These functions do not have architecture specific code, but are
> >> currently limited to powerpc.

[...]

> >> +#ifdef CONFIG_IMA_KEXEC
> >> +/**
> >> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> >> + *
> >> + * @image: kimage struct to set IMA buffer data
> >> + * @load_addr: Starting address where IMA buffer is loaded at
> >> + * @size: Number of bytes in the IMA buffer
> >> + *
> >> + * Architectures should use this function to pass on the IMA buffer
> >> + * information to the next kernel.
> >> + *
> >> + * Return: 0 on success, negative errno on error.
> >> + */
> >> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> >> +                          size_t size)
> >
> > This should be a static inline in asm/kexec.h.
>
> arch_ima_add_kexec_buffer() is identical for powerpc and arm64.
> Would it be better to "static inline" this function in "of.h" instead of
> duplicating it in "asm/kexec.h" for powerpc and arm64?

No, think about what it is specific to and place it there. It has
nothing to do with DT really. All it is is a wrapper to access the
struct members in kimage_arch. So it belongs where they are declared.
Now perhaps ima_buffer_addr and ima_buffer_size shouldn't be arch
specific, but that's a separate issue.

Rob
