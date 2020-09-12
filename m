Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696C1267768
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 05:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgILDTf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 23:19:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgILDTb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 23:19:31 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08C3439g047220;
        Fri, 11 Sep 2020 23:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=pg6tpZFZ2cLC1huT3C0Ian5fNemnubCmdo+K84tJw8c=;
 b=aMZU1838fEVBDmYwm/29Me9Fj2y36P5FcHTIcWkT/3ZZ0CvlLFk9iZfcGfqXbVzk+msg
 aBTCZuOmmOfQnW7K0sYliqoOZFb5ORJ1pmAt6Zu3EJvoz3kFtvlI93R29Bsjur4JNYWw
 jx3IYjcpY+GbMe1E0JhGkdsVbnztA+ZshUXC/GAkEdmSJamtBeqjlntn2gqrL6wqYbFN
 3v7UrV0aD53uFk/JuFTIlWwvJBeydnGvdc9pQXp9+IaWLIkvCyhez49LPRtOnzU0a1nA
 c0Vrv69RS97K2F7p1i8rgDNqjskTBZEMzTDMFCpLJ4pOu/bs03ZC3raEbxd8rlUxVEQ+ QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gm74tdw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 23:18:39 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08C35T2V050755;
        Fri, 11 Sep 2020 23:18:38 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gm74tdvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 23:18:38 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08C3I0T7009852;
        Sat, 12 Sep 2020 03:18:37 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 33gny884y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Sep 2020 03:18:37 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08C3IaaE38928668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Sep 2020 03:18:36 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69344AC059;
        Sat, 12 Sep 2020 03:18:36 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7666BAC05E;
        Sat, 12 Sep 2020 03:18:26 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.151.100])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Sat, 12 Sep 2020 03:18:26 +0000 (GMT)
References: <20200908230856.9799-1-nramas@linux.microsoft.com>
 <20200908230856.9799-2-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [PATCH v6 1/3] powerpc: Refactor kexec functions to move arch
 independent code to IMA
In-reply-to: <20200908230856.9799-2-nramas@linux.microsoft.com>
Date:   Sat, 12 Sep 2020 00:18:23 -0300
Message-ID: <875z8ju1hc.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-12_01:2020-09-10,2020-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=2
 mlxlogscore=999 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120027
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello Lakshmi,

The code itself is good, I have just some minor comments about it.

But movement of powerpc code is unfortunately creating some issues. More
details below.

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
> index 720e50e490b6..467647886064 100644
> --- a/arch/powerpc/kexec/ima.c
> +++ b/arch/powerpc/kexec/ima.c
> @@ -9,6 +9,7 @@
>  #include <linux/slab.h>
>  #include <linux/kexec.h>
>  #include <linux/of.h>
> +#include <linux/ima.h>
>  #include <linux/memblock.h>
>  #include <linux/libfdt.h>
>  
> @@ -28,105 +29,6 @@ static int get_addr_size_cells(int *addr_cells, int *size_cells)
>  	return 0;
>  }
>  
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

With this change if CONFIG_IMA=y but CONFIG_IMA_KEXEC=n, this file will
only have static int get_addr_size_cells() as its contents, which isn't
useful (and will print a warning about the function not being used). You
should change the Makefile to only build this file if CONFIG_IMA_KEXEC=y.
Then you can also remove the #ifdef CONFIG_IMA_KEXEC/#endif within it as
well.

>  #ifdef CONFIG_IMA_KEXEC
>  /**
>   * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> @@ -179,7 +81,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>  	int ret, addr_cells, size_cells, entry_size;
>  	u8 value[16];
>  
> -	remove_ima_buffer(fdt, chosen_node);
> +	ima_remove_kexec_buffer(fdt, chosen_node);
>  	if (!image->arch.ima_buffer_size)
>  		return 0;
>  
> @@ -201,7 +103,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>  	if (ret)
>  		return ret;
>  
> -	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
> +	ret = fdt_setprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, value,
>  			  entry_size);
>  	if (ret < 0)
>  		return -EINVAL;

<snip>

> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 9e93bef52968..00a60dcc7075 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -223,8 +223,19 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mend);
>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>  				       void **addr, unsigned long *sz);
> +
> +extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
> +			      unsigned long size);
>  #endif /* CONFIG_KEXEC_FILE */
>  
> +#ifndef CONFIG_KEXEC_FILE

I would use an `#else /* CONFIG_KEXEC_FILE */` here instead of #endif / #ifndef

> +static inline int delete_fdt_mem_rsv(void *fdt, unsigned long start,
> +				     unsigned long size)
> +{
> +	return 0;
> +}
> +#endif /* ifndef CONFIG_KEXEC_FILE */
> +
>  #ifdef CONFIG_KEXEC_ELF
>  struct kexec_elf_info {
>  	/*
> diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
> index 90ed4ebfa692..75fb40aa013b 100644
> --- a/include/linux/libfdt.h
> +++ b/include/linux/libfdt.h
> @@ -5,4 +5,7 @@
>  #include <linux/libfdt_env.h>
>  #include "../../scripts/dtc/libfdt/libfdt.h"
>  
> +/* Common device tree properties */
> +#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
> +
>  #endif /* _INCLUDE_LIBFDT_H_ */
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index 67dabca670e2..05719fd28aec 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -7,10 +7,11 @@
>  obj-$(CONFIG_IMA) += ima.o
>  
>  ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> -	 ima_policy.o ima_template.o ima_template_lib.o
> +	 ima_policy.o ima_template.o ima_template_lib.o ima_fdt.o
>  ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
>  ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
>  ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>  ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>  ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
> +ima-$(CONFIG_KEXEC_FILE) += ima_kexec_file.o

Even though you are using CONFIG_KEXEC_FILE here, AFAIK this will break
the powerpc build in the case of CONFIG_IMA=n and CONFIG_KEXEC_FILE=y
because the build system won't visit security/integrity/ima in that
case.

<snip>

> +/**
> + * ima_remove_kexec_buffer - remove the IMA buffer property and
> + *			     reservation from @fdt
> + *
> + * @fdt: Flattened Device Tree to update
> + * @chosen_node: Offset to the chosen node in the device tree
> + *
> + * The IMA measurement buffer is of no use to a subsequent kernel,
> + * so we always remove it from the device tree.
> + */
> +void ima_remove_kexec_buffer(void *fdt, int chosen_node)
> +{
> +	int ret, len;
> +	unsigned long addr;
> +	size_t size;
> +	const void *prop;
> +
> +	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, &len);
> +	if (!prop) {
> +		pr_err("Unable to find the ima kexec buffer node\n");

It's not an error if there's no IMA kexec buffer node. In case the
previous kernel didn't pass a buffer to this kernel there won't be one,
and it's fine. You should remove this pr_err().

> +		return;
> +	}
> +
> +	ret = do_get_kexec_buffer(prop, len, &addr, &size);
> +	fdt_delprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER);
> +	if (ret) {
> +		pr_err("Unable to delete the ima kexec buffer node\n");
> +		return;
> +	}
> +
> +	ret = delete_fdt_mem_rsv(fdt, addr, size);
> +	if (!ret)
> +		pr_err("Removed old IMA buffer reservation.\n");

Here you're printing an error when the function actually succeeded. You
should either change this back to a pr_debug(), or remove it.

> +}
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 121de3e04af2..ed70f99aeedc 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -10,8 +10,66 @@
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
> +#include <linux/of.h>
> +#include <linux/memblock.h>
> +#include <linux/libfdt.h>
> +#include <linux/ima.h>
>  #include "ima.h"
>  
> +/**
> + * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> + * @addr:	On successful return, set to point to the buffer contents.
> + * @size:	On successful return, set to the buffer size.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +static int ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	int ret, len;
> +	unsigned long tmp_addr;
> +	size_t tmp_size;
> +	const void *prop;
> +
> +	prop = of_get_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, &len);
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
> +static int ima_free_kexec_buffer(void)
> +{
> +	int ret;
> +	unsigned long addr;
> +	size_t size;
> +	struct property *prop;
> +
> +	prop = of_find_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, NULL);
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
> +
> +}
> +

Since you created ima_fdt.c, shouldn't the two functions above go in
that file instead of here, since they work with the device tree?

>  #ifdef CONFIG_IMA_KEXEC
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
> diff --git a/security/integrity/ima/ima_kexec_file.c b/security/integrity/ima/ima_kexec_file.c
> new file mode 100644
> index 000000000000..225e913e6ef2
> --- /dev/null
> +++ b/security/integrity/ima/ima_kexec_file.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2020 Microsoft Corporation
> + *
> + * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
> + *
> + * ima_kexec_file.c
> + *	Implements functions to handle device tree operations
> + */
> +
> +#include <linux/libfdt.h>
> +#include <linux/kexec.h>
> +#include <linux/types.h>
> +
> +/**
> + * delete_fdt_mem_rsv - delete memory reservation with given address and size
> + *
> + * @fdt: Flattened Device Tree to update
> + * @start: Starting address of the property to update

s/property to update/reservation to delete/

> + * @size: Size of the buffer corresponding to the given property

s/buffer corresponding to the given property/reservation to delete/

> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)

This function can't go in an IMA-specific directory, because it's used
in arch/powerpc/kexec/file_load.c even if IMA isn't enabled.

I'm not sure where would be a good place for it. Perhaps a new file
called kernel/kexec_file_fdt.c?

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
> +			pr_err("Freed the reserved memory at %lu of size %lu\n",
> +				start, size);

This isn't an error. You should change it to a pr_debug() or remove it.

> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}


-- 
Thiago Jung Bauermann
IBM Linux Technology Center
