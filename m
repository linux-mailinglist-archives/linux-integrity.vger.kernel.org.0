Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7203129A5
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 05:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBHENw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Feb 2021 23:13:52 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41769 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBHENv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Feb 2021 23:13:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DYt0t66nsz9sVF;
        Mon,  8 Feb 2021 15:13:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1612757588;
        bh=OO7xGWmsUnuYQgc3bx44I7oadxiJ3c+qloWk8zo8s/E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SQsvL45jlKpqUCEP8e1n03m12ASsrcsFM4rulmGn0o0JHZVPyDkisCyaZygcFW+w/
         o+aNZskRfsTmGwMpW337LVHKl/7fzsO7W/0NkNFfBpab7Nq/iTWuLQYB5o7WrlGlgR
         vrm9InatVSOATOiUKFPVdFYZ1JXjJqQkTzJjF+50Dkp6/IBYDj8ZWuJoomQ79smix5
         Jb09M2DIY7piouMND8uNftwaBdOiAx0C8HFgF5ekV/3yH2poxd2WulSITdHQwwW01E
         tXf52460TJkHIrDDaHHGbop5tjAoaZRaWZb+tWdI8YhTvmkDE9J66esGpcdkyVyXAX
         oUG7BiZkbIKyw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v16 11/12] powerpc: Use OF alloc and free for FDT
In-Reply-To: <CAL_JsqK1Pb9nAeL84EP2U3MQgpBsm+E_0QXmzbigWXnS245WPQ@mail.gmail.com>
References: <20210204164135.29856-1-nramas@linux.microsoft.com>
 <20210204164135.29856-12-nramas@linux.microsoft.com>
 <CAL_JsqK1Pb9nAeL84EP2U3MQgpBsm+E_0QXmzbigWXnS245WPQ@mail.gmail.com>
Date:   Mon, 08 Feb 2021 15:12:59 +1100
Message-ID: <87zh0fnqno.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> On Thu, Feb 4, 2021 at 10:42 AM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
...
>> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>> index d0e459bb2f05..51d2d8eb6c1b 100644
>> --- a/arch/powerpc/kexec/elf_64.c
>> +++ b/arch/powerpc/kexec/elf_64.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/kexec.h>
>>  #include <linux/libfdt.h>
>>  #include <linux/module.h>
>> +#include <linux/of.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>> @@ -32,7 +33,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>         unsigned int fdt_size;
>>         unsigned long kernel_load_addr;
>>         unsigned long initrd_load_addr = 0, fdt_load_addr;
>> -       void *fdt;
>> +       void *fdt = NULL;
>>         const void *slave_code;
>>         struct elfhdr ehdr;
>>         char *modified_cmdline = NULL;
>> @@ -103,18 +104,12 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>         }
>>
>>         fdt_size = fdt_totalsize(initial_boot_params) * 2;
>> -       fdt = kmalloc(fdt_size, GFP_KERNEL);
>> +       fdt = of_alloc_and_init_fdt(fdt_size);
>>         if (!fdt) {
>>                 pr_err("Not enough memory for the device tree.\n");
>>                 ret = -ENOMEM;
>>                 goto out;
>>         }
>> -       ret = fdt_open_into(initial_boot_params, fdt, fdt_size);
>> -       if (ret < 0) {
>> -               pr_err("Error setting up the new device tree.\n");
>> -               ret = -EINVAL;
>> -               goto out;
>> -       }
>>
>>         ret = setup_new_fdt_ppc64(image, fdt, initrd_load_addr,
>
> The first thing this function does is call setup_new_fdt() which first
> calls of_kexec_setup_new_fdt(). (Note, I really don't understand the
> PPC code split. It looks like there's a 32-bit and 64-bit split, but
> 32-bit looks broken to me. Nothing ever calls setup_new_fdt() except
> setup_new_fdt_ppc64()).

I think that's because 32-bit doesn't support kexec_file_load().

cheers
