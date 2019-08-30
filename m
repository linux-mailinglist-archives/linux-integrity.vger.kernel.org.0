Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6861CA2EDB
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 07:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfH3FXu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 01:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfH3FXt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 01:23:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8032F2073F;
        Fri, 30 Aug 2019 05:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567142627;
        bh=RBrbhKASCqObgzuGM1/8VbCqDXFL88kBbebOGmf2Vwg=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=h3hR1HH+1zoGIUMxpS5H705YLd8zt0t5Y+s6JWKb49VuZ6khR+kv8OvcZCmbsr9yd
         k9LIhb+hnZJE0L345yjASGGhqkrBg2fOTdVzH/NLpOxF2G8PWVE3FG6+mDnSQC4/7f
         rkAa3DA2/M3hjNZPEXdEZW453+TNH4haQnDLOeIo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829200532.13545-2-prsriva@linux.microsoft.com>
References: <20190829200532.13545-1-prsriva@linux.microsoft.com> <20190829200532.13545-2-prsriva@linux.microsoft.com>
Cc:     jmorris@namei.org, zohar@linux.ibm.com, bauerman@linux.ibm.com
Subject: Re: [RFC][PATCH 1/1] Carry ima measurement log for arm64 via kexec_file_load
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>,
        linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 22:23:46 -0700
Message-Id: <20190830052347.8032F2073F@mail.kernel.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Why is linux-arm-msm list CCed on this topic?

Quoting Prakhar Srivastava (2019-08-29 13:05:32)
> Carry ima measurement log for arm64 via kexec_file_load.
> add support to kexec_file_load to pass the ima measurement log

These first two sentences look sort of odd for a commit text.

>=20
> This patch adds entry for the ima measurement log in the

Don't use 'this patch' in commit text. It's in the wrong voice.

> dtb which is then used in the kexec'ed session to fetch the
> segment and then load the ima measurement log.
>=20
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3adcec05b1f6..9e1b831e7baa 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -964,6 +964,13 @@ config KEXEC_FILE
>           for kernel and initramfs as opposed to list of segments as
>           accepted by previous system call.
> =20
> +config HAVE_IMA_KEXEC
> +       bool "enable arch specific ima buffer pass"
> +       depends on KEXEC_FILE
> +       help
> +               This adds support to carry ima log to the next kernel in =
case

Should ima be all caps here?

> +               of kexec_file_load

Add a full-stop?

> +
>  config KEXEC_VERIFY_SIG
>         bool "Verify kernel signature during kexec_file_load() syscall"
>         depends on KEXEC_FILE
> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
> new file mode 100644
> index 000000000000..2c504281028d
> --- /dev/null
> +++ b/arch/arm64/include/asm/ima.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_IMA_H
> +#define _ASM_ARM64_IMA_H
> +
> +#define FDT_PROP_KEXEC_BUFFER  "linux,ima-kexec-buffer"

Is this documented somewhere in the DT bindings?

> +
> +struct kimage;
> +
> +int ima_get_kexec_buffer(void **addr, size_t *size);
> +int ima_free_kexec_buffer(void);
> +
> +#ifdef CONFIG_IMA
> +void remove_ima_buffer(void *fdt, int chosen_node);
> +#else
> +static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
> +#endif
> +
> +#ifdef CONFIG_IMA_KEXEC
> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_a=
ddr,
> +                             size_t size);
> +
> +int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_n=
ode);
> +#else
> +static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
> +                                  int chosen_node)
> +{
> +       remove_ima_buffer(fdt, chosen_node);
> +       return 0;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
> +#endif /* _ASM_ARM64_IMA_H */
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexe=
c.h
> index 12a561a54128..ca1f9ad5c4d4 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -96,6 +96,8 @@ static inline void crash_post_resume(void) {}
>  struct kimage_arch {
>         void *dtb;
>         unsigned long dtb_mem;
> +       phys_addr_t ima_buffer_addr;
> +       size_t ima_buffer_size;

Should this be in an ifdef?

>  };
> =20
>  extern const struct kexec_file_ops kexec_image_ops;
> @@ -107,6 +109,8 @@ extern int load_other_segments(struct kimage *image,
>                 unsigned long kernel_load_addr, unsigned long kernel_size,
>                 char *initrd, unsigned long initrd_len,
>                 char *cmdline);
> +extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
> +               unsigned long size);
>  #endif
> =20
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/kernel/ima_kexec.c b/arch/arm64/kernel/ima_kexec.c
> new file mode 100644
> index 000000000000..5ae0d776ec42
> --- /dev/null
> +++ b/arch/arm64/kernel/ima_kexec.c
> @@ -0,0 +1,219 @@
> +/*
> + * Copyright (C) 2016 IBM Corporation
> + *
> + * Authors:
> + * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

Please use a SPDX tag instead of this boiler plate.

> + */
> +
> +#include <linux/slab.h>
> +#include <linux/kexec.h>
> +#include <linux/of.h>
> +#include <linux/memblock.h>
> +#include <linux/libfdt.h>
> +#include <asm/kexec.h>
> +#include <asm/ima.h>
> +
> +static int get_addr_size_cells(int *addr_cells, int *size_cells)
> +{
> +       struct device_node *root;
> +
> +       root =3D of_find_node_by_path("/");
> +       if (!root)
> +               return -EINVAL;
> +
> +       *addr_cells =3D of_n_addr_cells(root);
> +       *size_cells =3D of_n_size_cells(root);
> +
> +       of_node_put(root);
> +
> +       return 0;
> +}
> +
> +static int do_get_kexec_buffer(const void *prop, int len, unsigned long =
*addr,
> +                              size_t *size)
> +{
> +
> +       int ret, addr_cells, size_cells;
> +
> +       ret =3D get_addr_size_cells(&addr_cells, &size_cells);
> +       if (ret)
> +               return ret;
> +
> +       if (len < 4 * (addr_cells + size_cells))
> +               return -ENOENT;
> +
> +       *addr =3D of_read_number(prop, addr_cells);
> +       *size =3D of_read_number(prop + 4 * addr_cells, size_cells);
> +
> +       return 0;
> +}
> +
> +/**
> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> + * @addr:      On successful return, set to point to the buffer contents.
> + * @size:      On successful return, set to the buffer size.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +       int ret, len;
> +       unsigned long tmp_addr;
> +       size_t tmp_size;
> +       const void *prop;
> +
> +       prop =3D of_get_property(of_chosen, FDT_PROP_KEXEC_BUFFER, &len);
> +       if (!prop)
> +               return -ENOENT;
> +
> +       ret =3D do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
> +       if (ret)
> +               return ret;
> +
> +       *addr =3D __va(tmp_addr);
> +       *size =3D tmp_size;
> +       return 0;
> +}
> +
> +/**
> + * ima_free_kexec_buffer - free memory used by the IMA buffer
> + */
> +int ima_free_kexec_buffer(void)
> +{
> +       int ret;
> +       unsigned long addr;
> +       size_t size;
> +       struct property *prop;
> +
> +       prop =3D of_find_property(of_chosen, FDT_PROP_KEXEC_BUFFER, NULL);
> +       if (!prop)
> +               return -ENOENT;
> +
> +       ret =3D do_get_kexec_buffer(prop->value, prop->length, &addr, &si=
ze);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D of_remove_property(of_chosen, prop);
> +       if (ret)
> +               return ret;
> +
> +       return memblock_free(addr, size);
> +}
> +
> +#ifdef CONFIG_IMA
> +/**
> + * remove_ima_buffer - remove the IMA buffer property and reservation fr=
om @fdt
> + *
> + * The IMA measurement buffer is of no use to a subsequent kernel, so we=
 always
> + * remove it from the device tree.
> + */
> +void remove_ima_buffer(void *fdt, int chosen_node)
> +{
> +       int ret, len;
> +       unsigned long addr;
> +       size_t size;
> +       const void *prop;
> +
> +       prop =3D fdt_getprop(fdt, chosen_node, FDT_PROP_KEXEC_BUFFER, &le=
n);
> +       if (!prop)
> +               return;
> +
> +       ret =3D do_get_kexec_buffer(prop, len, &addr, &size);
> +       fdt_delprop(fdt, chosen_node, FDT_PROP_KEXEC_BUFFER);
> +       if (ret)
> +               return;
> +
> +       ret =3D delete_fdt_mem_rsv(fdt, addr, size);
> +       if (!ret)
> +               pr_debug("Removed old IMA buffer reservation.\n");
> +}
> +#endif /* CONFIG_IMA */
> +
> +#ifdef CONFIG_IMA_KEXEC
> +/**
> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buf=
fer
> + *
> + * Architectures should use this function to pass on the IMA buffer
> + * information to the next kernel.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_a=
ddr,
> +                             size_t size)
> +{
> +       image->arch.ima_buffer_addr =3D load_addr;
> +       image->arch.ima_buffer_size =3D size;
> +       return 0;
> +}
> +
> +static int write_number(void *p, u64 value, int cells)

Maybe this should be an of_write_number() API exposed by the DT parsing
code?

> +{
> +       if (cells =3D=3D 1) {
> +               u32 tmp;
> +
> +               if (value > U32_MAX)
> +                       return -EINVAL;
> +
> +               tmp =3D cpu_to_be32(value);
> +               memcpy(p, &tmp, sizeof(tmp));
> +       } else if (cells =3D=3D 2) {
> +               u64 tmp;
> +
> +               tmp =3D cpu_to_be64(value);
> +               memcpy(p, &tmp, sizeof(tmp));
> +       } else
> +               return -EINVAL;

Put braces around this else please.

> +       return 0;
> +}
> +
> +/**
> + * setup_ima_buffer - add IMA buffer information to the fdt
> + * @image:             kexec image being loaded.
> + * @dtb:               Flattened device tree for the next kernel.
> + * @chosen_node:       Offset to the chosen node.

Why capitalize Flattened and Offset?

> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int setup_ima_buffer(const struct kimage *image, void *dtb, int chosen_n=
ode)
> +{
> +       int ret, addr_cells, size_cells, entry_size;
> +       u8 value[16];
> +
> +       remove_ima_buffer(dtb, chosen_node);
> +
> +       ret =3D get_addr_size_cells(&addr_cells, &size_cells);
> +       if (ret)
> +               return ret;
> +
> +       entry_size =3D 4 * (addr_cells + size_cells);
> +
> +       if (entry_size > sizeof(value))
> +               return -EINVAL;
> +
> +       ret =3D write_number(value, image->arch.ima_buffer_addr, addr_cel=
ls);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D write_number(value + 4 * addr_cells, image->arch.ima_buff=
er_size,
> +                       size_cells);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D fdt_setprop(dtb, chosen_node, FDT_PROP_KEXEC_BUFFER, valu=
e,
> +                         entry_size);
> +       if (ret < 0)
> +               return -EINVAL;
> +
> +       ret =3D fdt_add_mem_rsv(dtb, image->segment[0].mem,
> +                             image->segment[0].memsz);
> +       if (ret)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/m=
achine_kexec_file.c
> index 58871333737a..c05ad6b74b62 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -21,6 +21,7 @@
>  #include <linux/types.h>
>  #include <linux/vmalloc.h>
>  #include <asm/byteorder.h>
> +#include <asm/ima.h>
> =20
>  /* relevant device tree properties */
>  #define FDT_PROP_INITRD_START  "linux,initrd-start"
> @@ -85,6 +86,11 @@ static int setup_dtb(struct kimage *image,
>                         goto out;
>         }
> =20
> +       /* add ima_buffer */
> +       ret =3D setup_ima_buffer(image, dtb, off);
> +       if (ret)
> +               goto out;
> +
>         /* add kaslr-seed */
>         ret =3D fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
>         if  (ret =3D=3D -FDT_ERR_NOTFOUND)
> @@ -114,6 +120,39 @@ static int setup_dtb(struct kimage *image,
>   */
>  #define DTB_EXTRA_SPACE 0x1000
> =20
> +
> +/**
> + * delete_fdt_mem_rsv - delete memory reservation with given address and=
 size
> + *

Can you document the arguments too?

> + * Return: 0 on success, or negative errno on error.
> + */
> +int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long siz=
e)
> +{
> +       int i, ret, num_rsvs =3D fdt_num_mem_rsv(fdt);
> +
> +       for (i =3D 0; i < num_rsvs; i++) {
> +               uint64_t rsv_start, rsv_size;
> +
> +               ret =3D fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
> +               if (ret) {
> +                       pr_err("Malformed device tree.\n");

Please drop the full-stop on this printk.

> +                       return -EINVAL;
> +               }
> +
> +               if (rsv_start =3D=3D start && rsv_size =3D=3D size) {
> +                       ret =3D fdt_del_mem_rsv(fdt, i);
> +                       if (ret) {
> +                               pr_err("Error deleting device tree reserv=
ation.\n");

Same comment.

> +                               return -EINVAL;
> +                       }
> +
> +                       return 0;
> +               }
> +       }
> +
> +       return -ENOENT;
> +}

A lot of this code looks DT generic. Can it be moved out of the arch
layer to drivers/of/?

