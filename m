Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B92DD85F
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 19:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgLQSau (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 13:30:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58550 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgLQSat (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 13:30:49 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2907320B717B;
        Thu, 17 Dec 2020 10:30:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2907320B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608229806;
        bh=zIJfcV/rXurSqiM8Nh8uj0F5T65ry0AOd6GQUUuZL24=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=PCBQ4lYah5QxzQ7jFYyuA3qXneg04UZPLN/qVtnl7QA/47LTAbyntdx2NuOBmXhFt
         wcqk5uo1a9BuWlwbqWCJnsR07ixgRgj62XEHcBUaIy6EcewA/SJkwyGg0U3i6klwf8
         E5lVMateK0De2QnYvaJHQU5sRHjhkmC0si4bqHms=
Subject: Re: [PATCH v12 2/4] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20201217173708.6940-1-nramas@linux.microsoft.com>
 <20201217173708.6940-3-nramas@linux.microsoft.com>
Message-ID: <f1521c27-047b-af84-acfe-314761e59a50@linux.microsoft.com>
Date:   Thu, 17 Dec 2020 10:30:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217173708.6940-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/17/20 9:37 AM, Lakshmi Ramasubramanian wrote:
> The functions defined in "arch/powerpc/kexec/ima.c" handle setting up
> and freeing the resources required to carry over the IMA measurement
> list from the current kernel to the next kernel across kexec system call.
> These functions do not have architecture specific code, but are
> currently limited to powerpc.

Typo in the email address of James Morse (ARM.com). Sorry about that.
Adding the correct email address.

  -lakshmi

> 
> Move setup_ima_buffer() call into of_kexec_setup_new_fdt().
> 
> Move architecture independent functions from "arch/powerpc/kexec/ima.c"
> to "drivers/of/kexec.c". Delete "arch/powerpc/kexec/ima.c" and
> "arch/powerpc/include/asm/ima.h". Remove references to the deleted files
> in powerpc and in ima.
> 
> delete_fdt_mem_rsv() defined in "arch/powerpc/kexec/file_load.c"
> is not used anymore. Remove this function.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>   arch/powerpc/include/asm/ima.h     |  30 -----
>   arch/powerpc/include/asm/kexec.h   |   1 -
>   arch/powerpc/kexec/Makefile        |   7 -
>   arch/powerpc/kexec/file_load.c     |  39 ------
>   arch/powerpc/kexec/ima.c           | 182 --------------------------
>   drivers/of/kexec.c                 | 198 +++++++++++++++++++++++++++++
>   include/linux/of.h                 |  17 +++
>   security/integrity/ima/ima.h       |   4 -
>   security/integrity/ima/ima_kexec.c |   2 +
>   9 files changed, 217 insertions(+), 263 deletions(-)
>   delete mode 100644 arch/powerpc/include/asm/ima.h
>   delete mode 100644 arch/powerpc/kexec/ima.c
> 
> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
> deleted file mode 100644
> index ead488cf3981..000000000000
> --- a/arch/powerpc/include/asm/ima.h
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_POWERPC_IMA_H
> -#define _ASM_POWERPC_IMA_H
> -
> -struct kimage;
> -
> -int ima_get_kexec_buffer(void **addr, size_t *size);
> -int ima_free_kexec_buffer(void);
> -
> -#ifdef CONFIG_IMA
> -void remove_ima_buffer(void *fdt, int chosen_node);
> -#else
> -static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
> -#endif
> -
> -#ifdef CONFIG_IMA_KEXEC
> -int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> -			      size_t size);
> -
> -int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
> -#else
> -static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
> -				   int chosen_node)
> -{
> -	remove_ima_buffer(fdt, chosen_node);
> -	return 0;
> -}
> -#endif /* CONFIG_IMA_KEXEC */
> -
> -#endif /* _ASM_POWERPC_IMA_H */
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index dbf09d2f36d0..d4b7d2d6191d 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -126,7 +126,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>   int setup_new_fdt(const struct kimage *image, void *fdt,
>   		  unsigned long initrd_load_addr, unsigned long initrd_len,
>   		  const char *cmdline);
> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
>   
>   #ifdef CONFIG_PPC64
>   struct kexec_buf;
> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> index 4aff6846c772..b6c52608cb49 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -9,13 +9,6 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
>   
>   obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
>   
> -ifdef CONFIG_HAVE_IMA_KEXEC
> -ifdef CONFIG_IMA
> -obj-y				+= ima.o
> -endif
> -endif
> -
> -
>   # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>   GCOV_PROFILE_core_$(BITS).o := n
>   KCOV_INSTRUMENT_core_$(BITS).o := n
> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
> index 956bcb2d1ec2..f37652ccb8a1 100644
> --- a/arch/powerpc/kexec/file_load.c
> +++ b/arch/powerpc/kexec/file_load.c
> @@ -20,7 +20,6 @@
>   #include <linux/of_fdt.h>
>   #include <linux/libfdt.h>
>   #include <asm/setup.h>
> -#include <asm/ima.h>
>   
>   #define SLAVE_CODE_SIZE		256	/* First 0x100 bytes */
>   
> @@ -110,38 +109,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>   	return 0;
>   }
>   
> -/**
> - * delete_fdt_mem_rsv - delete memory reservation with given address and size
> - *
> - * Return: 0 on success, or negative errno on error.
> - */
> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
> -{
> -	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
> -
> -	for (i = 0; i < num_rsvs; i++) {
> -		uint64_t rsv_start, rsv_size;
> -
> -		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
> -		if (ret) {
> -			pr_err("Malformed device tree.\n");
> -			return -EINVAL;
> -		}
> -
> -		if (rsv_start == start && rsv_size == size) {
> -			ret = fdt_del_mem_rsv(fdt, i);
> -			if (ret) {
> -				pr_err("Error deleting device tree reservation.\n");
> -				return -EINVAL;
> -			}
> -
> -			return 0;
> -		}
> -	}
> -
> -	return -ENOENT;
> -}
> -
>   /*
>    * setup_new_fdt - modify /chosen and memory reservation for the next kernel
>    * @image:		kexec image being loaded.
> @@ -163,12 +130,6 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
>   	if (ret)
>   		goto err;
>   
> -	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
> -	if (ret) {
> -		pr_err("Error setting up the new device tree.\n");
> -		return ret;
> -	}
> -
>   	return 0;
>   
>   err:
> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
> deleted file mode 100644
> index d579d3da4715..000000000000
> --- a/arch/powerpc/kexec/ima.c
> +++ /dev/null
> @@ -1,182 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (C) 2016 IBM Corporation
> - *
> - * Authors:
> - * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> - */
> -
> -#include <linux/slab.h>
> -#include <linux/kexec.h>
> -#include <linux/of.h>
> -#include <linux/memblock.h>
> -#include <linux/libfdt.h>
> -#include <asm/ima.h>
> -
> -static int get_addr_size_cells(int *addr_cells, int *size_cells)
> -{
> -	struct device_node *root;
> -
> -	root = of_find_node_by_path("/");
> -	if (!root)
> -		return -EINVAL;
> -
> -	*addr_cells = of_n_addr_cells(root);
> -	*size_cells = of_n_size_cells(root);
> -
> -	of_node_put(root);
> -
> -	return 0;
> -}
> -
> -static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
> -			       size_t *size)
> -{
> -	int ret, addr_cells, size_cells;
> -
> -	ret = get_addr_size_cells(&addr_cells, &size_cells);
> -	if (ret)
> -		return ret;
> -
> -	if (len < 4 * (addr_cells + size_cells))
> -		return -ENOENT;
> -
> -	*addr = of_read_number(prop, addr_cells);
> -	*size = of_read_number(prop + 4 * addr_cells, size_cells);
> -
> -	return 0;
> -}
> -
> -/**
> - * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> - * @addr:	On successful return, set to point to the buffer contents.
> - * @size:	On successful return, set to the buffer size.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int ima_get_kexec_buffer(void **addr, size_t *size)
> -{
> -	int ret, len;
> -	unsigned long tmp_addr;
> -	size_t tmp_size;
> -	const void *prop;
> -
> -	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
> -	if (!prop)
> -		return -ENOENT;
> -
> -	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
> -	if (ret)
> -		return ret;
> -
> -	*addr = __va(tmp_addr);
> -	*size = tmp_size;
> -
> -	return 0;
> -}
> -
> -/**
> - * ima_free_kexec_buffer - free memory used by the IMA buffer
> - */
> -int ima_free_kexec_buffer(void)
> -{
> -	int ret;
> -	unsigned long addr;
> -	size_t size;
> -	struct property *prop;
> -
> -	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
> -	if (!prop)
> -		return -ENOENT;
> -
> -	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
> -	if (ret)
> -		return ret;
> -
> -	ret = of_remove_property(of_chosen, prop);
> -	if (ret)
> -		return ret;
> -
> -	return memblock_free(addr, size);
> -
> -}
> -
> -/**
> - * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> - *
> - * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> - * remove it from the device tree.
> - */
> -void remove_ima_buffer(void *fdt, int chosen_node)
> -{
> -	int ret, len;
> -	unsigned long addr;
> -	size_t size;
> -	const void *prop;
> -
> -	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
> -	if (!prop)
> -		return;
> -
> -	ret = do_get_kexec_buffer(prop, len, &addr, &size);
> -	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
> -	if (ret)
> -		return;
> -
> -	ret = delete_fdt_mem_rsv(fdt, addr, size);
> -	if (!ret)
> -		pr_debug("Removed old IMA buffer reservation.\n");
> -}
> -
> -#ifdef CONFIG_IMA_KEXEC
> -/**
> - * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> - *
> - * Architectures should use this function to pass on the IMA buffer
> - * information to the next kernel.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> -			      size_t size)
> -{
> -	image->arch.ima_buffer_addr = load_addr;
> -	image->arch.ima_buffer_size = size;
> -
> -	return 0;
> -}
> -
> -/**
> - * setup_ima_buffer - add IMA buffer information to the fdt
> - * @image:		kexec image being loaded.
> - * @fdt:		Flattened device tree for the next kernel.
> - * @chosen_node:	Offset to the chosen node.
> - *
> - * Return: 0 on success, or negative errno on error.
> - */
> -int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
> -{
> -	int ret;
> -
> -	remove_ima_buffer(fdt, chosen_node);
> -	if (!image->arch.ima_buffer_size)
> -		return 0;
> -
> -	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> -				       "linux,ima-kexec-buffer",
> -				       image->arch.ima_buffer_addr,
> -				       image->arch.ima_buffer_size);
> -	if (ret)
> -		return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> -
> -	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
> -			      image->arch.ima_buffer_size);
> -	if (ret)
> -		return -EINVAL;
> -
> -	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
> -		 image->arch.ima_buffer_addr, image->arch.ima_buffer_size);
> -
> -	return 0;
> -}
> -#endif /* CONFIG_IMA_KEXEC */
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 66787be081fe..a6ab35f16dd2 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -10,10 +10,12 @@
>    */
>   
>   #include <linux/kernel.h>
> +#include <linux/slab.h>
>   #include <linux/kexec.h>
>   #include <linux/libfdt.h>
>   #include <linux/of.h>
>   #include <linux/of_fdt.h>
> +#include <linux/memblock.h>
>   #include <linux/random.h>
>   #include <linux/types.h>
>   
> @@ -59,6 +61,141 @@ static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned lon
>   	return -ENOENT;
>   }
>   
> +/**
> + * get_addr_size_cells - Get address and size of root node
> + *
> + * @addr_cells: Return address of the root node
> + * @size_cells: Return size of the root node
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +static int get_addr_size_cells(int *addr_cells, int *size_cells)
> +{
> +	struct device_node *root;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return -EINVAL;
> +
> +	*addr_cells = of_n_addr_cells(root);
> +	*size_cells = of_n_size_cells(root);
> +
> +	of_node_put(root);
> +
> +	return 0;
> +}
> +
> +/**
> + * do_get_kexec_buffer - Get address and size of device tree property
> + *
> + * @prop: Device tree property
> + * @len: Size of @prop
> + * @addr: Return address of the node
> + * @size: Return size of the node
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
> +			       size_t *size)
> +{
> +	int ret, addr_cells, size_cells;
> +
> +	ret = get_addr_size_cells(&addr_cells, &size_cells);
> +	if (ret)
> +		return ret;
> +
> +	if (len < 4 * (addr_cells + size_cells))
> +		return -ENOENT;
> +
> +	*addr = of_read_number(prop, addr_cells);
> +	*size = of_read_number(prop + 4 * addr_cells, size_cells);
> +
> +	return 0;
> +}
> +
> +/**
> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> + * @addr:	On successful return, set to point to the buffer contents.
> + * @size:	On successful return, set to the buffer size.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	int ret, len;
> +	unsigned long tmp_addr;
> +	size_t tmp_size;
> +	const void *prop;
> +
> +	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
> +	if (!prop)
> +		return -ENOENT;
> +
> +	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
> +	if (ret)
> +		return ret;
> +
> +	*addr = __va(tmp_addr);
> +	*size = tmp_size;
> +
> +	return 0;
> +}
> +
> +/**
> + * ima_free_kexec_buffer - free memory used by the IMA buffer
> + */
> +int ima_free_kexec_buffer(void)
> +{
> +	int ret;
> +	unsigned long addr;
> +	size_t size;
> +	struct property *prop;
> +
> +	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
> +	if (!prop)
> +		return -ENOENT;
> +
> +	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_remove_property(of_chosen, prop);
> +	if (ret)
> +		return ret;
> +
> +	return memblock_free(addr, size);
> +}
> +
> +/**
> + * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> + *
> + * @fdt: Flattened Device Tree to update
> + * @chosen_node: Offset to the chosen node in the device tree
> + *
> + * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> + * remove it from the device tree.
> + */
> +void remove_ima_buffer(void *fdt, int chosen_node)
> +{
> +	int ret, len;
> +	unsigned long addr;
> +	size_t size;
> +	const void *prop;
> +
> +	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
> +	if (!prop)
> +		return;
> +
> +	ret = do_get_kexec_buffer(prop, len, &addr, &size);
> +	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
> +	if (ret)
> +		return;
> +
> +	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
> +	if (!ret)
> +		pr_debug("Removed old IMA buffer reservation.\n");
> +}
> +
>   /*
>    * of_kexec_setup_new_fdt - modify /chosen and memory reservation for the next kernel
>    *
> @@ -219,6 +356,10 @@ int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
>   	}
>   
>   	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
> +	if (ret)
> +		goto out;
> +
> +	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
>   
>   out:
>   	if (ret)
> @@ -226,3 +367,60 @@ int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
>   
>   	return 0;
>   }
> +
> +#ifdef CONFIG_IMA_KEXEC
> +/**
> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> + *
> + * @image: kimage struct to set IMA buffer data
> + * @load_addr: Starting address where IMA buffer is loaded at
> + * @size: Number of bytes in the IMA buffer
> + *
> + * Architectures should use this function to pass on the IMA buffer
> + * information to the next kernel.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> +			      size_t size)
> +{
> +	image->arch.ima_buffer_addr = load_addr;
> +	image->arch.ima_buffer_size = size;
> +
> +	return 0;
> +}
> +
> +/**
> + * setup_ima_buffer - add IMA buffer information to the fdt
> + * @image:		kexec image being loaded.
> + * @fdt:		Flattened device tree for the next kernel.
> + * @chosen_node:	Offset to the chosen node.
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
> +{
> +	int ret;
> +
> +	remove_ima_buffer(fdt, chosen_node);
> +	if (!image->arch.ima_buffer_size)
> +		return 0;
> +
> +	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> +				       "linux,ima-kexec-buffer",
> +				       image->arch.ima_buffer_addr,
> +				       image->arch.ima_buffer_size);
> +	if (ret)
> +		return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> +
> +	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
> +			      image->arch.ima_buffer_size);
> +	if (ret)
> +		return -EINVAL;
> +
> +	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
> +		 image->arch.ima_buffer_addr, image->arch.ima_buffer_size);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 3375f5295875..7477f2266d8f 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -562,6 +562,23 @@ struct kimage;
>   int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
>   			   unsigned long initrd_load_addr, unsigned long initrd_len,
>   			   const char *cmdline);
> +int ima_get_kexec_buffer(void **addr, size_t *size);
> +int ima_free_kexec_buffer(void);
> +void remove_ima_buffer(void *fdt, int chosen_node);
> +
> +#ifdef CONFIG_IMA_KEXEC
> +int arch_ima_add_kexec_buffer(struct kimage *image,
> +			      unsigned long load_addr,
> +			      size_t size);
> +int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
> +#else
> +static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
> +				   int chosen_node)
> +{
> +	remove_ima_buffer(fdt, chosen_node);
> +	return 0;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
>   
>   #else /* CONFIG_OF */
>   
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 6ebefec616e4..7c3947ad3773 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -24,10 +24,6 @@
>   
>   #include "../integrity.h"
>   
> -#ifdef CONFIG_HAVE_IMA_KEXEC
> -#include <asm/ima.h>
> -#endif
> -
>   enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
>   		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
>   enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 121de3e04af2..3d6a8820e2a5 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -9,7 +9,9 @@
>   
>   #include <linux/seq_file.h>
>   #include <linux/vmalloc.h>
> +#include <linux/of.h>
>   #include <linux/kexec.h>
> +#include <linux/ima.h>
>   #include "ima.h"
>   
>   #ifdef CONFIG_IMA_KEXEC
> 

