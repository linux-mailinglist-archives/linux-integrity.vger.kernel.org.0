Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C42DE3A6
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Dec 2020 15:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgLROET (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Dec 2020 09:04:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgLROES (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Dec 2020 09:04:18 -0500
X-Gm-Message-State: AOAM5301BaKFkObMcolD4EGpfJg5BLybewS46+ug52zePNY6F9LbJkDb
        56NSqMJpX1zmaqrdseW620blrJWymtlih6jtug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608300217;
        bh=O1DafvJd+vpBjnHu7VqZwdOPe6Eat+vdexFWMyOdf8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QspUt0WI8gJy+YRba8uV+QTdzJiqcbh5aDZK44bjpjDyMBVHEJ3aD77l2Xu8IgRMr
         Y8cb6yuJ7s9ipTs7NOOO4NHEgHm0EYg+cHkeuuLQYDDrvWuMI9pxXNZEB8eT89zU8N
         7dnpWtrc37PUEwcuqrbuCg2id5D36oHBE70bQ+dqN+tVG+FuIvlckkA9ykJR2CtopF
         +XxpliEyYSQ3fRMpQvQJnC9OW3P/MASH+sRA8FrQjMdujZyqyao+tE3M4w51DVE7I6
         hBYW3RclpZ4+EIAqsqy+SEPjJv7KL5GxeGX9UxEHElN5nieCpArcM7l9fOOwYoPrrZ
         cnzhCTlNpYxiQ==
X-Google-Smtp-Source: ABdhPJzZOEqrsFJFwxnsklPBIeh2RjmWMC1VVgKTVP6zBJTiorisDYuH7i1GjzMkJ5LwNYj39gjyRlpzR/FYCIHYTBA=
X-Received: by 2002:a05:6402:352:: with SMTP id r18mr4421311edw.373.1608300216031;
 Fri, 18 Dec 2020 06:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20201217173708.6940-1-nramas@linux.microsoft.com>
 <20201217173708.6940-3-nramas@linux.microsoft.com> <20201217200510.GA105447@robh.at.kernel.org>
 <0b17fbee-cfe9-8cb2-01d1-02b6a61a14f5@linux.microsoft.com>
 <CAL_Jsq+-HOkxtxOO=zyRbDuGVNZoMy589qoVANciNionsdsGCw@mail.gmail.com> <5dda6968-ca14-1695-3058-7c12653521ba@linux.microsoft.com>
In-Reply-To: <5dda6968-ca14-1695-3058-7c12653521ba@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Dec 2020 08:03:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJoyhOrWQiKq_q+7dpCj3MEsRtbGZ=SDxmeVswjQr-9sw@mail.gmail.com>
Message-ID: <CAL_JsqJoyhOrWQiKq_q+7dpCj3MEsRtbGZ=SDxmeVswjQr-9sw@mail.gmail.com>
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

On Fri, Dec 18, 2020 at 12:25 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 12/17/20 2:01 PM, Rob Herring wrote:
>
> >
> > [...]
> >
> >>>> +#ifdef CONFIG_IMA_KEXEC
> >>>> +/**
> >>>> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> >>>> + *
> >>>> + * @image: kimage struct to set IMA buffer data
> >>>> + * @load_addr: Starting address where IMA buffer is loaded at
> >>>> + * @size: Number of bytes in the IMA buffer
> >>>> + *
> >>>> + * Architectures should use this function to pass on the IMA buffer
> >>>> + * information to the next kernel.
> >>>> + *
> >>>> + * Return: 0 on success, negative errno on error.
> >>>> + */
> >>>> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> >>>> +                          size_t size)
> >>>
> >>> This should be a static inline in asm/kexec.h.
> >>
> >> arch_ima_add_kexec_buffer() is identical for powerpc and arm64.
> >> Would it be better to "static inline" this function in "of.h" instead of
> >> duplicating it in "asm/kexec.h" for powerpc and arm64?
> >
> > No, think about what it is specific to and place it there. It has
> > nothing to do with DT really. All it is is a wrapper to access the
> > struct members in kimage_arch. So it belongs where they are declared.
> > Now perhaps ima_buffer_addr and ima_buffer_size shouldn't be arch
> > specific, but that's a separate issue.
> >
>
> Since "struct kimage" definition is not available in "asm/kexec.h",
> defining arch_ima_add_kexec_buffer() in this header file results in the
> following build error:
>
> ./arch/powerpc/include/asm/kexec.h: In function 'arch_ima_add_kexec_buffer':
> ./arch/powerpc/include/asm/kexec.h:139:7: error: 'struct kimage' has no
> member named 'arch'
>    139 |  image->arch.ima_buffer_addr = load_addr;
>
> I think it would be appropriate to make arch_ima_add_kexec_buffer() a
> static inline function in "security/integrity/ima/ima_kexec.c" - the
> only file where this function is used.

Even better. It doesn't need to be 'inline' then. The compiler will
inline it without.

Rob
