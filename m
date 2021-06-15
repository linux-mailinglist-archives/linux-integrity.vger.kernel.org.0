Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAA3A8623
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFOQPY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 12:15:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59738 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhFOQPU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 12:15:20 -0400
Received: from nramas-ThinkStation-P520 (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 289BF20B83DE;
        Tue, 15 Jun 2021 09:13:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 289BF20B83DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623773595;
        bh=6UtEbcJN/IpvUsLN1GwdJnJrbEZUHAkAxbKrwbhgW78=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S3nWv4Yf1N41H0w1XOSwFPGkr7/xfVoa9sUqWF341iik0xwYxblV16N/Bn7QfL+Gu
         4rULT6aNTDRocdECtjebsPLhXgpR5L67WcrQMTYKf/J9N2zaDDOmFqJGxI8/rygbOq
         LZOJ+ayZrbnAqpTcPicLrwL8cTXwbtOcLdLzJGEk=
Message-ID: <54efb4fce5aac7efbd0b1b3885e9098b1d4ea745.camel@linux.microsoft.com>
Subject: Re: [PATCH v19 05/13] of: Add a common kexec FDT setup function
From:   nramas <nramas@linux.microsoft.com>
To:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, dmitry.kasatkin@gmail.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Tue, 15 Jun 2021 09:13:14 -0700
In-Reply-To: <CAL_JsqJ2x7zbyP3fAacdfHOWjCVjg6XhraV2YkoBJdZ2jXAMEA@mail.gmail.com>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
         <20210221174930.27324-6-nramas@linux.microsoft.com>
         <CAMuHMdVSuNS4edh-zM0_sbC0i1AAjQ9Y0n_8Mjz=3CALkW4pgg@mail.gmail.com>
         <CAL_JsqJ2x7zbyP3fAacdfHOWjCVjg6XhraV2YkoBJdZ2jXAMEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-06-15 at 08:01 -0600, Rob Herring wrote:
> On Tue, Jun 15, 2021 at 6:18 AM Geert Uytterhoeven <
> geert@linux-m68k.org> wrote:
> > 
> > > +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> > > +                                  unsigned long
> > > initrd_load_addr,
> > > +                                  unsigned long initrd_len,
> > > +                                  const char *cmdline, size_t
> > > extra_fdt_size)
> > > +{
> > > +       /* Did we boot using an initrd? */
> > > +       prop = fdt_getprop(fdt, chosen_node, "linux,initrd-
> > > start", NULL);
> > > +       if (prop) {
> > > +               u64 tmp_start, tmp_end, tmp_size;
> > > +
> > > +               tmp_start = fdt64_to_cpu(*((const fdt64_t *)
> > > prop));
> > > +
> > > +               prop = fdt_getprop(fdt, chosen_node,
> > > "linux,initrd-end", NULL);
> > > +               if (!prop) {
> > > +                       ret = -EINVAL;
> > > +                       goto out;
> > > +               }
> > > +
> > > +               tmp_end = fdt64_to_cpu(*((const fdt64_t *)
> > > prop));
> > 
> > Some kernel code assumes "linux,initrd-{start,end}" are 64-bit,
> > other code assumes 32-bit.
> 
> It can be either. The above code was a merge of arm64 and powerpc
> both
> of which use 64-bit and still only runs on those arches. It looks
> like
> some powerpc platforms may use 32-bit, but this would have been
> broken
> before.
of_kexec_alloc_and_setup_fdt() is called from elf_64.c (in
arch/powerpc/kexec) which is for 64-bit powerpc platform only.

thanks,
 -lakshmi

> 
> The code in drivers/of/fdt.c handles either case. We should probably
> refactor early_init_dt_check_for_initrd() and this function to use a
> common routine.
> 
> > linux/Documentation/arm/uefi.rst says 64-bit,
> > dt-schema/schemas/chosen.yaml says 32-bit.
> 
> We should fix that.
> 
> Rob

