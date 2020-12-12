Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05A2D83CB
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 02:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406309AbgLLBTh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 20:19:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36752 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405263AbgLLBTS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 20:19:18 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A65D020B717A;
        Fri, 11 Dec 2020 17:18:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A65D020B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607735917;
        bh=L+sSAkNyKVg99f8bs8P0XtidfzP9K6JUhgjxWMuy8zU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O0+EjY8JmRCvw0ikI+PgHAEt95LET9uFpYonHaDHkSrhS437xzwASjb3MY9SuuuaB
         eK06Z/+aI3x6vxTPaRXcqyyRUrPXz0QxSqQ4T7slQNZ94asLwC5/QL0//HwBx5B20d
         Z1mJPvqdQEhuOqhfLqECiw8+dv69Wl+bRQMqpxu8=
Subject: Re: [RFC PATCH 2/4] of: Add a common kexec FDT setup function
To:     Rob Herring <robh@kernel.org>, takahiro.akashi@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        zohar@linux.ibm.com, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-3-robh@kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6934c005-d848-314d-cfee-23f2273c119d@linux.microsoft.com>
Date:   Fri, 11 Dec 2020 17:18:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211221006.1052453-3-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/20 2:10 PM, Rob Herring wrote:

Hi Rob,

> Both arm64 and powerpc do essentially the same FDT /chosen setup for
> kexec. We can simply combine everything each arch does. The differences
> are either omissions that arm64 should have or additional properties
> that will be ignored.
> 
> The differences relative to the arm64 version:
> - If /chosen doesn't exist, it will be created (should never happen).
> - Any old dtb and initrd reserved memory will be released.
> - The new initrd and elfcorehdr are marked reserved.
> - "linux,booted-from-kexec" is set.
> 
> The differences relative to the powerpc version:
> - "kaslr-seed" and "rng-seed" may be set.
> - "linux,elfcorehdr" is set.
> - Any existing "linux,usable-memory-range" is removed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This could be taken a step further and do the allocation of the new
> FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
> arm64 version also retries with a bigger allocation. That seems
> unnecessary.
> ---
>   drivers/of/Makefile |   1 +
>   drivers/of/kexec.c  | 228 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/of.h  |   5 +
>   3 files changed, 234 insertions(+)
>   create mode 100644 drivers/of/kexec.c
> 
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 6e1e5212f058..8ce11955afde 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -13,5 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>   obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>   obj-$(CONFIG_OF_OVERLAY) += overlay.o
>   obj-$(CONFIG_OF_NUMA) += of_numa.o
> +obj-$(CONFIG_KEXEC_FILE) += kexec.o

For the functions moved from powerpc & arm64 to "drivers/of/kexec.c" in 
this patch, compiling kexec.c when CONFIG_KEXEC_FILE is enabled is fine. 
But when more functions (such as remove_ima_buffer()) are moved to this 
file, Makefile needs to be updated for other ima kexec related CONFIGs.

Why not compile kexec.c when CONFIG_OF_FLATTREE is enabled, and handle 
other CONFIGs using IS_ENABLED (like you'd suggested earlier)?

>   
>   obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> new file mode 100644
> index 000000000000..66787be081fe
> --- /dev/null
> +++ b/drivers/of/kexec.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Arm Limited
> + *
> + * Based on arch/arm64/kernel/machine_kexec_file.c:
> + *  Copyright (C) 2018 Linaro Limited
> + *
> + * And arch/powerpc/kexec/file_load.c:
> + *  Copyright (C) 2016  IBM Corporation
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/libfdt.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/random.h>
> +#include <linux/types.h>
> +
> +/* relevant device tree properties */
> +#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
> +#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
> +#define FDT_PROP_INITRD_START	"linux,initrd-start"
> +#define FDT_PROP_INITRD_END	"linux,initrd-end"
> +#define FDT_PROP_BOOTARGS	"bootargs"
> +#define FDT_PROP_KASLR_SEED	"kaslr-seed"
> +#define FDT_PROP_RNG_SEED	"rng-seed"
> +#define RNG_SEED_SIZE		128

> +
> +/**
> + * fdt_find_and_del_mem_rsv - delete memory reservation with given address and size
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned long size)
> +{
> +	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
> +
> +	for (i = 0; i < num_rsvs; i++) {
> +		u64 rsv_start, rsv_size;
> +
> +		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
> +		if (ret) {
> +			pr_err("Malformed device tree.\n");
> +			return -EINVAL;
> +		}
> +
> +		if (rsv_start == start && rsv_size == size) {
> +			ret = fdt_del_mem_rsv(fdt, i);
> +			if (ret) {
> +				pr_err("Error deleting device tree reservation.\n");
> +				return -EINVAL;
> +			}
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +/*
> + * of_kexec_setup_new_fdt - modify /chosen and memory reservation for the next kernel
> + *
> + * @image:		kexec image being loaded.
> + * @fdt:		Flattened device tree for the next kernel.
> + * @initrd_load_addr:	Address where the next initrd will be loaded.
> + * @initrd_len:		Size of the next initrd, or 0 if there will be none.
> + * @cmdline:		Command line for the next kernel, or NULL if there will
> + *			be none.
nit: alignment of the parameter description seems to be off. But it 
could be due to my mail client.

> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
> +			   unsigned long initrd_load_addr, unsigned long initrd_len,
> +			   const char *cmdline)
> +{
> +	int ret, chosen_node;
> +	const void *prop;
> +
> +	/* Remove memory reservation for the current device tree. */
> +	ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
> +				       fdt_totalsize(initial_boot_params));
> +	if (ret == -EINVAL)
> +		return ret;
> +
> +	chosen_node = fdt_path_offset(fdt, "/chosen");
> +	if (chosen_node == -FDT_ERR_NOTFOUND)
> +		chosen_node = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
> +					      "chosen");
> +	if (chosen_node < 0) {
> +		ret = chosen_node;
> +		goto out;
> +	}
> +
> +	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_KEXEC_ELFHDR);
> +	if (ret && ret != -FDT_ERR_NOTFOUND)
> +		goto out;
> +	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_MEM_RANGE);
> +	if (ret && ret != -FDT_ERR_NOTFOUND)
> +		goto out;
> +
> +	/* Did we boot using an initrd? */
> +	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
> +	if (prop) {
> +		u64 tmp_start, tmp_end, tmp_size;
> +
> +		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
> +
> +		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
> +		if (!prop)
> +			return -EINVAL;
> +
> +		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
> +
> +		/*
> +		 * kexec reserves exact initrd size, while firmware may
> +		 * reserve a multiple of PAGE_SIZE, so check for both.
> +		 */
> +		tmp_size = tmp_end - tmp_start;
> +		ret = fdt_find_and_del_mem_rsv(fdt, tmp_start, tmp_size);
> +		if (ret == -ENOENT)
> +			ret = fdt_find_and_del_mem_rsv(fdt, tmp_start,
> +						       round_up(tmp_size, PAGE_SIZE));
> +		if (ret == -EINVAL)
> +			return ret;
> +	}
> +
> +	/* add initrd-* */
> +	if (initrd_load_addr) {
> +		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_INITRD_START,
> +				      initrd_load_addr);
> +		if (ret)
> +			goto out;
> +
> +		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_INITRD_END,
> +				      initrd_load_addr + initrd_len);
> +		if (ret)
> +			goto out;
> +
> +		ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
> +		if (ret)
> +			goto out;
> +
> +	} else {
> +		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_INITRD_START);
> +		if (ret && (ret != -FDT_ERR_NOTFOUND))
> +			goto out;
> +
> +		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_INITRD_END);
> +		if (ret && (ret != -FDT_ERR_NOTFOUND))
> +			goto out;
> +	}
> +
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		/* add linux,elfcorehdr */
> +		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> +				FDT_PROP_KEXEC_ELFHDR,
> +				image->arch.elf_headers_mem,
> +				image->arch.elf_headers_sz);
> +		if (ret)
> +			goto out;
> +
> +		/*
> +		 * Avoid elfcorehdr from being stomped on in kdump kernel by
> +		 * setting up memory reserve map.
> +		 */
> +		ret = fdt_add_mem_rsv(fdt, image->arch.elf_headers_mem,
> +				      image->arch.elf_headers_sz);
Return value from fdt_add_mem_rsv() should be checked.

> +
> +		/* add linux,usable-memory-range */
> +		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> +				FDT_PROP_MEM_RANGE,
> +				crashk_res.start,
> +				crashk_res.end - crashk_res.start + 1);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* add bootargs */
> +	if (cmdline) {
> +		ret = fdt_setprop_string(fdt, chosen_node, FDT_PROP_BOOTARGS, cmdline);
> +		if (ret)
> +			goto out;
> +	} else {
> +		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_BOOTARGS);
> +		if (ret && (ret != -FDT_ERR_NOTFOUND))
> +			goto out;
> +	}
> +
> +	/* add kaslr-seed */
> +	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_KASLR_SEED);
> +	if (ret == -FDT_ERR_NOTFOUND)
> +		ret = 0;
> +	else if (ret)
> +		goto out;
> +
> +	if (rng_is_initialized()) {
> +		u64 seed = get_random_u64();
> +		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_KASLR_SEED, seed);
> +		if (ret)
> +			goto out;
> +	} else {
> +		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
> +				FDT_PROP_KASLR_SEED);
> +	}
> +
> +	/* add rng-seed */
> +	if (rng_is_initialized()) {
> +		void *rng_seed;
> +		ret = fdt_setprop_placeholder(fdt, chosen_node, FDT_PROP_RNG_SEED,
> +				RNG_SEED_SIZE, &rng_seed);
> +		if (ret)
> +			goto out;
> +		get_random_bytes(rng_seed, RNG_SEED_SIZE);
> +	} else {
> +		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
> +				FDT_PROP_RNG_SEED);
> +	}
> +
> +	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
> +
> +out:
> +	if (ret)
> +		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
> +
> +	return 0;
> +}
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 5d51891cbf1a..3375f5295875 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -558,6 +558,11 @@ int of_map_id(struct device_node *np, u32 id,
>   	       const char *map_name, const char *map_mask_name,
>   	       struct device_node **target, u32 *id_out);
>   
> +struct kimage;
> +int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
> +			   unsigned long initrd_load_addr, unsigned long initrd_len,
> +			   const char *cmdline);

of_kexec_setup_new_fdt() should only be declared if CONFIG_KEXEC_FILE is 
enabled. Right?

  -lakshmi

> +
>   #else /* CONFIG_OF */
>   
>   static inline void of_core_init(void)
> 

