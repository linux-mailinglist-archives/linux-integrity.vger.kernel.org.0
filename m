Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1662E2CFF5F
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 22:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgLEVre (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Dec 2020 16:47:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725270AbgLEVre (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Dec 2020 16:47:34 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B5LXCfR034299;
        Sat, 5 Dec 2020 16:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=aoWuL0tfCxQXEp/PaI7xW2zgdw+Vh4PQgd0zPAE7UQA=;
 b=Vx1I1QrbT0Yc5r+X/uGwtAL053cN/eU7MmXpL6je0Y01llc/TjeVYWGVgedKZCzQkFVq
 UdaQzw2o0Bg+KPLaG4/GjYRRXk/knOZhXLXQFXa9j1bRTzJoB/GbooKhrHezHaZg5JD0
 7n7FbxXshhfKuwo2LLOcRfPcIfa+ABw7/RShpBs62BdB4VxRQaz6c/D0bv7medP9BoFJ
 rrcxczNAB6ZDqpIXrqN9eY4YiMJIByOwLIgRmiDcd5l129GeooGr8hcdQidsEHHQkbDj
 RlflGJ9Jc98d37N78uxDawttx8BUO4GxfPHmTUWAydGwdtcxF4QDK3lWYuyscR0RItNO Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3587ks20c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 16:46:23 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B5LYQrm040724;
        Sat, 5 Dec 2020 16:46:22 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3587ks20bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 16:46:22 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B5La5CC005825;
        Sat, 5 Dec 2020 21:46:21 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3581u8dgc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 21:46:21 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B5Lj55K10093382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Dec 2020 21:45:05 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0AE6AE064;
        Sat,  5 Dec 2020 21:45:04 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3241AE05C;
        Sat,  5 Dec 2020 21:44:57 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.177.236])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 21:44:57 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-9-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v10 8/8] arm64: Add IMA log information in kimage used
 for kexec
In-reply-to: <20201204195149.611-9-nramas@linux.microsoft.com>
Date:   Sat, 05 Dec 2020 18:44:56 -0300
Message-ID: <87ft4klyg7.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-05_19:2020-12-04,2020-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012050146
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> Address and size of the buffer containing the IMA measurement log need
> to be passed from the current kernel to the next kernel on kexec.
>
> Any existing "linux,ima-kexec-buffer" property in the device tree
> needs to be removed and its corresponding memory reservation in
> the currently running kernel needs to be freed. The address and
> size of the current kernel's IMA measurement log need to be added
> to the device tree's IMA kexec buffer node and memory for the buffer
> needs to be reserved for the log to be carried over to the next kernel
> on the kexec call.
>
> Add address and size fields to "struct kimage_arch" for ARM64 platform
> to hold the address and size of the IMA measurement log buffer. Remove
> any existing "linux,ima-kexec-buffer" property in the device tree and
> free the corresponding memory reservation in the currently running
> kernel. Add "linux,ima-kexec-buffer" property to the device tree and
> reserve the memory for storing the IMA log that needs to be passed from
> the current kernel to the next one.
>
> Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to indicate
> that the IMA measurement log information is present in the device tree
> for ARM64.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>  arch/arm64/Kconfig                     |  1 +
>  arch/arm64/include/asm/ima.h           | 22 ++++++++++++++
>  arch/arm64/include/asm/kexec.h         |  5 ++++
>  arch/arm64/kernel/Makefile             |  1 +
>  arch/arm64/kernel/ima.c                | 41 ++++++++++++++++++++++++++
>  arch/arm64/kernel/machine_kexec_file.c |  8 +++++
>  6 files changed, 78 insertions(+)
>  create mode 100644 arch/arm64/include/asm/ima.h
>  create mode 100644 arch/arm64/kernel/ima.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..bcca4a467eda 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1094,6 +1094,7 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "kexec file based system call"
>  	select KEXEC_CORE
> +	select HAVE_IMA_KEXEC
>  	help
>  	  This is new version of kexec system call. This system call is
>  	  file based and takes file descriptors as system call argument
> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
> new file mode 100644
> index 000000000000..354adc8b444c
> --- /dev/null
> +++ b/arch/arm64/include/asm/ima.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2019 Microsoft Corporation

Shouldn't the year here be 2020?

> + *
> + * Author: Prakhar Srivastava <prsriva@linux.microsoft.com>
> + *
> + */
> +#ifndef _ASM_ARCH_IMA_H
> +#define _ASM_ARCH_IMA_H
> +
> +struct kimage;
> +
> +#ifdef CONFIG_IMA_KEXEC
> +extern int setup_ima_buffer(struct kimage *image, void *dtb, int off);
> +#else
> +static inline int setup_ima_buffer(struct kimage *image, void *dtb, int off)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
> +
> +#endif /* _ASM_ARCH_IMA_H */

<snip>

> diff --git a/arch/arm64/kernel/ima.c b/arch/arm64/kernel/ima.c
> new file mode 100644
> index 000000000000..d65bdbe1adf6
> --- /dev/null
> +++ b/arch/arm64/kernel/ima.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2016 IBM Corporation

Same question: shouldn't the year here be 2020?

> + *
> + * Authors:
> + * Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> + */
> +
> +#include <linux/kexec.h>
> +#include <linux/of.h>
> +#include <linux/libfdt.h>
> +#include <asm/ima.h>
> +
> +/**
> + * setup_ima_buffer - add IMA buffer information to the fdt
> + *
> + * @image:	kexec image being loaded.
> + * @dtb:	Flattened device tree for the next kernel.
> + * @off:	Offset to the chosen node.
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int setup_ima_buffer(struct kimage *image, void *dtb, int off)
> +{
> +	int ret = 0;
> +
> +	/* add ima-kexec-buffer */
> +	if (image->arch.ima_buffer_size > 0) {
> +		ret = fdt_appendprop_addrrange(dtb, 0, off,
> +				"linux,ima-kexec-buffer",
> +				image->arch.ima_buffer_addr,
> +				image->arch.ima_buffer_size);
> +		if (ret)
> +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> +
> +		ret = fdt_add_mem_rsv(dtb, image->arch.ima_buffer_addr,
> +				      image->arch.ima_buffer_size);
> +	}
> +
> +	return ret;
> +}

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
