Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227FE2CF8EE
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 03:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLECYV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 21:24:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLECYU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 21:24:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B525ZW9009844;
        Fri, 4 Dec 2020 21:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=6s1kaGg76WjieDJ4gzTD/EKW13njqYaGv2tYSRMM5Fs=;
 b=kt8Cd/xqBSyFt4ONq3FAKgspHqQI5bIQF/ktbO4CuTveYgMj5JDtzqsD9/AK0KmeN7qu
 zfTKwFXdZiNolOFMvqTrYBEUyaf4+ZjrS//RvHmclWbRCKSUAiSfaMBz6FlnHTR83jq4
 dWeHSjBBLTEMPxR10zDQezTh0e+GvjADrzAFvVLJfNK0PUSXUVNpwllA1aPgqzVLlLjP
 qDCXgQyOSEOV4G7wLKyakY+UYaeltJNtFY5u7W6oAH/RgXlN/OFR5PYubwvaiC+CgRMn
 04VESBz0xsJxCH00VC2WVLl/gBr1dh89FjxZoagzx+6J0mGFn27NKKx/Lbva54EyDrKp Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357hfajc0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 21:23:01 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B52FIRA049268;
        Fri, 4 Dec 2020 21:23:00 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357hfajbyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 21:23:00 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B52LeeA006025;
        Sat, 5 Dec 2020 02:22:59 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 355rf8b95d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 02:22:59 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B52Mwnb13697632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Dec 2020 02:22:58 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74ADFAE062;
        Sat,  5 Dec 2020 02:22:58 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37F8BAE05F;
        Sat,  5 Dec 2020 02:22:46 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.203.141])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 02:22:45 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-3-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v10 2/8] powerpc: Move delete_fdt_mem_rsv() to
 drivers/of/kexec.c
In-reply-to: <20201204195149.611-3-nramas@linux.microsoft.com>
Date:   Fri, 04 Dec 2020 23:22:43 -0300
Message-ID: <87ft4louto.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_13:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=2
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012050007
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hello Lakshmi,

Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> delete_fdt_mem_rsv() retrieves the memory reserve map entry, for
> the given starting address and size, from the device tree blob, and
> removes the entry from the device tree blob. This function is called
> to free the resources reserved for the buffer used for carrying forward
> the IMA measurement logs on kexec. This function does not have
> architecture specific code, but is currently limited to powerpc.
>
> Move delete_fdt_mem_rsv() to "drivers/of/kexec_fdt.c" so that it is

s/kexec_fdt.c/kexec.c/

> accessible for other architectures as well.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/kexec.h |  1 -
>  arch/powerpc/kexec/file_load.c   | 32 -----------------
>  drivers/of/Makefile              |  1 +
>  drivers/of/kexec.c               | 61 ++++++++++++++++++++++++++++++++
>  include/linux/kexec.h            |  5 +++
>  5 files changed, 67 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/of/kexec.c
>
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 55d6ede30c19..7c223031ecdd 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -126,7 +126,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>  int setup_new_fdt(const struct kimage *image, void *fdt,
>  		  unsigned long initrd_load_addr, unsigned long initrd_len,
>  		  const char *cmdline);
> -int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
>  
>  #ifdef CONFIG_PPC64
>  struct kexec_buf;
> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
> index 9a232bc36c8f..9efc98b1e2ae 100644
> --- a/arch/powerpc/kexec/file_load.c
> +++ b/arch/powerpc/kexec/file_load.c
> @@ -109,38 +109,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>  	return 0;
>  }
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
>  /*
>   * setup_new_fdt - modify /chosen and memory reservation for the next kernel
>   * @image:		kexec image being loaded.
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index 6e1e5212f058..77d24712c0c8 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -13,5 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>  obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>  obj-$(CONFIG_OF_OVERLAY) += overlay.o
>  obj-$(CONFIG_OF_NUMA) += of_numa.o
> +obj-$(CONFIG_OF_FLATTREE) += kexec.o

Isn't this too broad? kexec.o will only be useful to kernel configs
which enable CONFIG_KEXEC_FILE, so perhaps do:

ifdef CONFIG_OF_FLATTREE
ifdef CONFIG_KEXEC_FILE
obj-y += kexec.o
endif
endif

What do you think?

>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> new file mode 100644
> index 000000000000..b7d59105fcb8
> --- /dev/null
> +++ b/drivers/of/kexec.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2020 Microsoft Corporation
> + *
> + * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
> + *
> + * File: kexec.c
> + *	Defines kexec related functions.
> + */
> +
> +#define pr_fmt(fmt)	"OF: kexec: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/memblock.h>
> +#include <linux/kexec.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
> +
> +/**
> + * delete_fdt_mem_rsv - delete memory reservation with given address and size
> + *
> + * @fdt: Flattened Device Tree to update
> + * @start: Starting address of the reservation to delete
> + * @size: Size of the reservation to delete
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
> +{
> +	int i, ret, num_rsvs;
> +
> +	if (!IS_ENABLED(CONFIG_KEXEC_FILE))
> +		return 0;

If you agree with my suggestion, then this IS_ENABLED() wouldn't be
needed.

> +
> +	num_rsvs = fdt_num_mem_rsv(fdt);
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
> +			pr_debug("Freed reserved memory at %lu of size %lu\n",
> +				 start, size);
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}

The function code is unchanged apart from the addition of the
IS_ENABLED() and the pr_debug(), so that is good.

> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 9e93bef52968..d0234c4815da 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -407,6 +407,11 @@ static inline int kexec_crash_loaded(void) { return 0; }
>  #define kexec_in_progress false
>  #endif /* CONFIG_KEXEC_CORE */
>  
> +#if defined(CONFIG_OF_FLATTREE)

This would also change to require CONFIG_KEXEC_FILE.

> +extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
> +			      unsigned long size);
> +#endif /* CONFIG_OF_FLATTREE */
> +
>  #endif /* !defined(__ASSEBMLY__) */
>  
>  #endif /* LINUX_KEXEC_H */


-- 
Thiago Jung Bauermann
IBM Linux Technology Center
