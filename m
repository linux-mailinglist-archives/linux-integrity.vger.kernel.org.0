Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40AA413F
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Aug 2019 02:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfHaALp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 20:11:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727708AbfHaALp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 20:11:45 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7V06vfY189487;
        Fri, 30 Aug 2019 20:11:41 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uq0kth90e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 20:11:40 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7V09toO017188;
        Sat, 31 Aug 2019 00:11:40 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 2un65kjujg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Aug 2019 00:11:40 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7V0BdZC43516174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 31 Aug 2019 00:11:39 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D084112064;
        Sat, 31 Aug 2019 00:11:39 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8FB0112063;
        Sat, 31 Aug 2019 00:11:37 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.207.220])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Sat, 31 Aug 2019 00:11:37 +0000 (GMT)
References: <20190829200532.13545-1-prsriva@linux.microsoft.com> <20190829200532.13545-2-prsriva@linux.microsoft.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        zohar@linux.ibm.com
Subject: Re: [RFC][PATCH 1/1] Carry ima measurement log for arm64 via kexec_file_load
In-reply-to: <20190829200532.13545-2-prsriva@linux.microsoft.com>
Date:   Fri, 30 Aug 2019 21:11:35 -0300
Message-ID: <87r252kxc8.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908310000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello Prakhar,

Answering this part from the cover letter:

> The code is in most part same as powerpc, i want to get feedback as to
> how/correct way to refactor the code so that cross architecture
> partial helpers can be put in a common place.

That's a great idea. If it could go to drivers/of/ as Stephen Boyd
mentioned in the other email that would be great.

More comments below.

Prakhar Srivastava <prsriva@linux.microsoft.com> writes:

> Carry ima measurement log for arm64 via kexec_file_load.
> add support to kexec_file_load to pass the ima measurement log
>
> This patch adds entry for the ima measurement log in the
> dtb which is then used in the kexec'ed session to fetch the
> segment and then load the ima measurement log.
>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> ---
>  arch/arm64/Kconfig                     |   7 +
>  arch/arm64/include/asm/ima.h           |  31 ++++
>  arch/arm64/include/asm/kexec.h         |   4 +
>  arch/arm64/kernel/Makefile             |   1 +
>  arch/arm64/kernel/ima_kexec.c          | 219 +++++++++++++++++++++++++
>  arch/arm64/kernel/machine_kexec_file.c |  39 +++++
>  6 files changed, 301 insertions(+)
>  create mode 100644 arch/arm64/include/asm/ima.h
>  create mode 100644 arch/arm64/kernel/ima_kexec.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3adcec05b1f6..9e1b831e7baa 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -964,6 +964,13 @@ config KEXEC_FILE
>  	  for kernel and initramfs as opposed to list of segments as
>  	  accepted by previous system call.
>
> +config HAVE_IMA_KEXEC
> +	bool "enable arch specific ima buffer pass"
> +	depends on KEXEC_FILE
> +	help
> +		This adds support to carry ima log to the next kernel in case
> +		of kexec_file_load
> +
>  config KEXEC_VERIFY_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on KEXEC_FILE

This Kconfig should be defined in arch/Kconfig so that both arm64 and
powerpc can select it.

> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 478491f07b4f..9620f90bd0e1 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
>  obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
>  obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
> +obj-$(CONFIG_HAVE_IMA_KEXEC)		+= ima_kexec.o
>
>  obj-y					+= vdso/ probes/
>  obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
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
> + */

The powerpc file was updated to use the SPDX tag and remove the
paragraph above. Please update your file to match.

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
> +static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
> +			       size_t *size)
> +{
> +

This spurious blank line only exists in the arm64 version. Should be
removed.

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
> +	prop = of_get_property(of_chosen, FDT_PROP_KEXEC_BUFFER, &len);
> +	if (!prop)
> +		return -ENOENT;
> +
> +	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
> +	if (ret)
> +		return ret;
> +
> +	*addr = __va(tmp_addr);
> +	*size = tmp_size;
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
> +	prop = of_find_property(of_chosen, FDT_PROP_KEXEC_BUFFER, NULL);
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

On the other hand you removed the spurious blank line that exists in
powerpc. Thanks. :-)

> +}
> +
> +#ifdef CONFIG_IMA

remove_ima_buffer() should exist even if CONFIG_IMA isn't set. If I
recall correctly, Mimi requested that kernels that are booted via kexec
should remove the IMA buffer even if they won't use it.

> +/**
> + * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
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
> +	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_KEXEC_BUFFER, &len);
> +	if (!prop)
> +		return;
> +
> +	ret = do_get_kexec_buffer(prop, len, &addr, &size);
> +	fdt_delprop(fdt, chosen_node, FDT_PROP_KEXEC_BUFFER);
> +	if (ret)
> +		return;
> +
> +	ret = delete_fdt_mem_rsv(fdt, addr, size);
> +	if (!ret)
> +		pr_debug("Removed old IMA buffer reservation.\n");
> +}
> +#endif /* CONFIG_IMA */
> +
> +#ifdef CONFIG_IMA_KEXEC
> +/**
> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
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
> +	return 0;
> +}
> +
> +static int write_number(void *p, u64 value, int cells)
> +{
> +	if (cells == 1) {
> +		u32 tmp;
> +
> +		if (value > U32_MAX)
> +			return -EINVAL;
> +
> +		tmp = cpu_to_be32(value);
> +		memcpy(p, &tmp, sizeof(tmp));
> +	} else if (cells == 2) {
> +		u64 tmp;
> +
> +		tmp = cpu_to_be64(value);
> +		memcpy(p, &tmp, sizeof(tmp));
> +	} else
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +/**
> + * setup_ima_buffer - add IMA buffer information to the fdt
> + * @image:		kexec image being loaded.
> + * @dtb:		Flattened device tree for the next kernel.
> + * @chosen_node:	Offset to the chosen node.
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int setup_ima_buffer(const struct kimage *image, void *dtb, int chosen_node)
> +{

Is there any particular reason to rename the fdt parameter to dtb?

> +	int ret, addr_cells, size_cells, entry_size;
> +	u8 value[16];
> +
> +	remove_ima_buffer(dtb, chosen_node);

In the powerpc version, there's an if here to return early if
image->arch.ima_buffer_size == 0. Is there a reason why you removed it?

> +
> +	ret = get_addr_size_cells(&addr_cells, &size_cells);
> +	if (ret)
> +		return ret;
> +
> +	entry_size = 4 * (addr_cells + size_cells);
> +
> +	if (entry_size > sizeof(value))
> +		return -EINVAL;
> +
> +	ret = write_number(value, image->arch.ima_buffer_addr, addr_cells);
> +	if (ret)
> +		return ret;
> +
> +	ret = write_number(value + 4 * addr_cells, image->arch.ima_buffer_size,
> +			size_cells);
> +	if (ret)
> +		return ret;
> +
> +	ret = fdt_setprop(dtb, chosen_node, FDT_PROP_KEXEC_BUFFER, value,
> +			  entry_size);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	ret = fdt_add_mem_rsv(dtb, image->segment[0].mem,
> +			      image->segment[0].memsz);

powerpc uses image->arch.ima_buffer_addr and image->arch.ima_buffer_size
here. Why do you use segment[0] above?

> +	if (ret)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 58871333737a..c05ad6b74b62 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -21,6 +21,7 @@
>  #include <linux/types.h>
>  #include <linux/vmalloc.h>
>  #include <asm/byteorder.h>
> +#include <asm/ima.h>
>
>  /* relevant device tree properties */
>  #define FDT_PROP_INITRD_START	"linux,initrd-start"
> @@ -85,6 +86,11 @@ static int setup_dtb(struct kimage *image,
>  			goto out;
>  	}
>
> +	/* add ima_buffer */
> +	ret = setup_ima_buffer(image, dtb, off);
> +	if (ret)
> +		goto out;
> +
>  	/* add kaslr-seed */
>  	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
>  	if  (ret == -FDT_ERR_NOTFOUND)
> @@ -114,6 +120,39 @@ static int setup_dtb(struct kimage *image,
>   */
>  #define DTB_EXTRA_SPACE 0x1000
>
> +
> +/**
> + * delete_fdt_mem_rsv - delete memory reservation with given address and size
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
> +{
> +	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
> +
> +	for (i = 0; i < num_rsvs; i++) {
> +		uint64_t rsv_start, rsv_size;
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

This functions is the same as the one in powerpc, and should be shared too.

--
Thiago Jung Bauermann
IBM Linux Technology Center
