Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9325226364
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 17:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgGTPeS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 11:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTPeQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 11:34:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE98222C9D;
        Mon, 20 Jul 2020 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259255;
        bh=c/hjOojMTg3TNs8kx9IKYYH+HETNBY0OjLn1K7YlN4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jL3QpF7M/yHNP/7k2IedRR+xDd57JWgIlNQuItFwKeKF0i6B4XZhno5DnLE6v3yS8
         r8S1AYm/l1voF1muUjyl4sOydD9FZLyHmQ1ZrOTemwhdAv5cp2AbSKf0o6qpngdVb/
         ZGoa7A2NbW7NYzpRLuXG8hvtITFqu8jI+E2Uuw0A=
Date:   Mon, 20 Jul 2020 17:34:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, masahiroy@kernel.org, james.morse@arm.com,
        bhsharma@redhat.com, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com, bauerman@linux.ibm.com,
        robh@kernel.org
Subject: Re: [PATCH V3 6/6] Add the property used for carrying forward the
 IMA measurement logs and update the code to use the defined property string.
Message-ID: <20200720153400.GC1481119@kroah.com>
References: <20200720152342.337990-1-prsriva@linux.microsoft.com>
 <20200720152342.337990-7-prsriva@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720152342.337990-7-prsriva@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 20, 2020 at 08:23:42AM -0700, Prakhar Srivastava wrote:
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>

Again, subject line, no changelog :(

> ---
>  arch/arm64/kernel/machine_kexec_file.c | 19 ++++++++++---------
>  arch/powerpc/kexec/ima.c               |  8 +++++---
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 066670c43626..59058901e641 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -24,14 +24,15 @@
>  #include <asm/byteorder.h>
>  
>  /* relevant device tree properties */
> -#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
> -#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
> -#define FDT_PROP_INITRD_START	"linux,initrd-start"
> -#define FDT_PROP_INITRD_END	"linux,initrd-end"
> -#define FDT_PROP_BOOTARGS	"bootargs"
> -#define FDT_PROP_KASLR_SEED	"kaslr-seed"
> -#define FDT_PROP_RNG_SEED	"rng-seed"
> -#define RNG_SEED_SIZE		128
> +#define FDT_PROP_KEXEC_ELFHDR		"linux,elfcorehdr"
> +#define FDT_PROP_MEM_RANGE		"linux,usable-memory-range"
> +#define FDT_PROP_INITRD_START		"linux,initrd-start"
> +#define FDT_PROP_INITRD_END		"linux,initrd-end"
> +#define FDT_PROP_BOOTARGS		"bootargs"
> +#define FDT_PROP_KASLR_SEED		"kaslr-seed"
> +#define FDT_PROP_RNG_SEED		"rng-seed"
> +#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
> +#define RNG_SEED_SIZE			128

Why did you reformat all of these?

>  
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  	&kexec_image_ops,
> @@ -157,7 +158,7 @@ static int setup_dtb(struct kimage *image,
>  	if (image->arch.ima_buffer_size > 0) {
>  
>  		ret = fdt_appendprop_addrrange(dtb, 0, off,
> -				"linux,ima-kexec-buffer",
> +				FDT_PROP_IMA_KEXEC_BUFFER,
>  				image->arch.ima_buffer_addr,
>  				image->arch.ima_buffer_size);
>  		if (ret)
> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
> index a9e4e9f04273..7d6c43b2eacb 100644
> --- a/arch/powerpc/kexec/ima.c
> +++ b/arch/powerpc/kexec/ima.c
> @@ -12,6 +12,8 @@
>  #include <linux/memblock.h>
>  #include <linux/libfdt.h>
>  
> +#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
> +

Why are you mixing arm64 and powerpc patches together that do not do the
same thing???

Shouldn't there be a common place for these strings and not spread out
all over the kernel in random places?

thanks,

greg k-h
