Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC03A8EC8
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Jun 2021 04:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhFPC0B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 22:26:01 -0400
Received: from ozlabs.org ([203.11.71.1]:56549 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhFPC0B (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 22:26:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G4TWn4TqHz9sWX;
        Wed, 16 Jun 2021 12:23:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623810234;
        bh=P3MCetIfzZtPqhiTVaYvru4yq+FzxZnPf34lNt0JVNs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bFttHDSYDF8hs1GhcNrBuxC8r7YR1FbbNwSxkDAL7lQtIx4XxJMkGgJ7lrWjuZU9K
         hHlMI3fju9iswEdIjo7GjpwxP1Gj1Fm/KYx+39MCmWGuFbgefyJ9+AnXWm5Gf/e/WE
         A3rk+pmgQ4nYUF6AN4aESjVY9NcZzs/XD9grffQ9ZgTrSzGhxqLEc7HLOf2IyR5wUs
         BEgh91+kA9k66Ony2Qct/YJq45j32aDa0BAlicNYsFLF+qSWSLxNmpFtktw78LYU6u
         aLSqG0ucZiktlwstD97l1OxIipFzxib0Y/fOq3lYLMw7V3BV6g9i2RPMf7XTojDwDI
         6cNIWLPIEvGYQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>, nramas <nramas@linux.microsoft.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v19 05/13] of: Add a common kexec FDT setup function
In-Reply-To: <CAL_JsqJEucP043eViq0Y1kAeqWNTqP5fLjfjz7+ksYx7QP_V5w@mail.gmail.com>
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
 <20210221174930.27324-6-nramas@linux.microsoft.com>
 <CAMuHMdVSuNS4edh-zM0_sbC0i1AAjQ9Y0n_8Mjz=3CALkW4pgg@mail.gmail.com>
 <CAL_JsqJ2x7zbyP3fAacdfHOWjCVjg6XhraV2YkoBJdZ2jXAMEA@mail.gmail.com>
 <54efb4fce5aac7efbd0b1b3885e9098b1d4ea745.camel@linux.microsoft.com>
 <CAL_JsqJEucP043eViq0Y1kAeqWNTqP5fLjfjz7+ksYx7QP_V5w@mail.gmail.com>
Date:   Wed, 16 Jun 2021 12:23:44 +1000
Message-ID: <87y2basg27.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> On Tue, Jun 15, 2021 at 10:13 AM nramas <nramas@linux.microsoft.com> wrote:
>>
>> On Tue, 2021-06-15 at 08:01 -0600, Rob Herring wrote:
>> > On Tue, Jun 15, 2021 at 6:18 AM Geert Uytterhoeven <
>> > geert@linux-m68k.org> wrote:
>> > >
>> > > > +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>> > > > +                                  unsigned long
>> > > > initrd_load_addr,
>> > > > +                                  unsigned long initrd_len,
>> > > > +                                  const char *cmdline, size_t
>> > > > extra_fdt_size)
>> > > > +{
>> > > > +       /* Did we boot using an initrd? */
>> > > > +       prop = fdt_getprop(fdt, chosen_node, "linux,initrd-
>> > > > start", NULL);
>> > > > +       if (prop) {
>> > > > +               u64 tmp_start, tmp_end, tmp_size;
>> > > > +
>> > > > +               tmp_start = fdt64_to_cpu(*((const fdt64_t *)
>> > > > prop));
>> > > > +
>> > > > +               prop = fdt_getprop(fdt, chosen_node,
>> > > > "linux,initrd-end", NULL);
>> > > > +               if (!prop) {
>> > > > +                       ret = -EINVAL;
>> > > > +                       goto out;
>> > > > +               }
>> > > > +
>> > > > +               tmp_end = fdt64_to_cpu(*((const fdt64_t *)
>> > > > prop));
>> > >
>> > > Some kernel code assumes "linux,initrd-{start,end}" are 64-bit,
>> > > other code assumes 32-bit.
>> >
>> > It can be either. The above code was a merge of arm64 and powerpc >> > both
>> > of which use 64-bit and still only runs on those arches. It looks >> > like
>> > some powerpc platforms may use 32-bit, but this would have been >> > broken
>> > before.

>> of_kexec_alloc_and_setup_fdt() is called from elf_64.c (in
>> arch/powerpc/kexec) which is for 64-bit powerpc platform only.
>
> 64-bit PPC could be writing 32-bit property values. The architecture
> size doesn't necessarily matter. And if the values came from the
> bootloader, who knows what size it used.
>
> This code is 32-bit powerpc only?:
>
> arch/powerpc/boot/main.c-       /* Tell the kernel initrd address via device tree */
> arch/powerpc/boot/main.c:       setprop_val(chosen, "linux,initrd-start", (u32)(initrd_addr));
> arch/powerpc/boot/main.c-       setprop_val(chosen, "linux,initrd-end", (u32)(initrd_addr+initrd_size));

Historically that code was always built 32-bit, even when used with a
64-bit kernel.

These days it is also built 64-bit (for ppc64le).

It looks like the drivers/of/fdt.c code can handle either 64 or 32-bit,
so I guess that's why it seems to be working.

Although I'm not sure how much testing the 64-bit case gets, because the
distros tend to just use the vmlinux.

cheers
