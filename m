Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F32CA1A2
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgLALk1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 06:40:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730646AbgLALk0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 06:40:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BWoOc194166;
        Tue, 1 Dec 2020 06:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3R71xWX7EOICe2ryEC+thn9RyY+wps7xMitcUuPVvGQ=;
 b=qNeWEgcEULQYZHtcw8diO0EaB1t++qgyhsOrCbkp+yUvP3qz6mVgwRhcD/OeWjRVWglV
 +wOronTo9KDcfO0RlX5D/8+NuQp2Hz8wEPpNDDeC8ikzU9u5+/plvAnJliJIfqPrZU29
 ZajDNPwbVobmd/SJ7qQMboyWpGKXwb8TzDYqKSImWvbpD1tW+ZtYpmdBumlOBIg+Dn2s
 8Mfa4cZZZAu6QndTFl10BPi++DL03i1oatATo59p4AIzQNy8m62ULNMZEqc3ysBrbR1W
 qDB8eYiYzKZTicKJ68Z8Qxks2S2z5joEn1KW2tJtTEGkkaBAoZTntjPA1IrFViCzX7FA lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjncvdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:39:17 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B1BXHfK004063;
        Tue, 1 Dec 2020 06:39:17 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jjncvcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:39:16 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BN0V4029991;
        Tue, 1 Dec 2020 11:39:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 353e68b32v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 11:39:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1BdCFn56951058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 11:39:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E33974203F;
        Tue,  1 Dec 2020 11:39:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00F2742045;
        Tue,  1 Dec 2020 11:39:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.13])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 11:39:04 +0000 (GMT)
Message-ID: <f0ac42878a713b270f7bad22d44f61739d582db8.camel@linux.ibm.com>
Subject: Re: [PATCH v9 7/8] arm64: Store IMA log information in kimage used
 for kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Date:   Tue, 01 Dec 2020 06:39:04 -0500
In-Reply-To: <20201113192243.1993-8-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
         <20201113192243.1993-8-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_04:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010075
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-11-13 at 11:22 -0800, Lakshmi Ramasubramanian wrote:
> Address and size of the buffer containing the IMA measurement log need
> to be passed from the current kernel to the next kernel on kexec.
> 
> Add address and size fields to "struct kimage_arch" for ARM64 platform
> to hold the address and size of the IMA measurement log buffer.
> Define an architecture specific function for ARM64 namely
> arch_ima_add_kexec_buffer() that will set the address and size of
> the current kernel's IMA buffer to be passed to the next kernel on kexec.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/arm64/include/asm/ima.h   | 18 ++++++++++++++++++
>  arch/arm64/include/asm/kexec.h |  3 +++
>  arch/arm64/kernel/Makefile     |  1 +
>  arch/arm64/kernel/ima_kexec.c  | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+)
>  create mode 100644 arch/arm64/include/asm/ima.h
>  create mode 100644 arch/arm64/kernel/ima_kexec.c
> 
> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
> new file mode 100644
> index 000000000000..507fc94ddaba
> --- /dev/null
> +++ b/arch/arm64/include/asm/ima.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2019 Microsoft Corporation
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
> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> +			      size_t size);
> +#endif /* CONFIG_IMA_KEXEC */
> +
> +#endif /* _ASM_ARCH_IMA_H */
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index d24b527e8c00..7bd60c185ad3 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -100,6 +100,9 @@ struct kimage_arch {
>  	void *elf_headers;
>  	unsigned long elf_headers_mem;
>  	unsigned long elf_headers_sz;
> +
> +	phys_addr_t ima_buffer_addr;
> +	size_t ima_buffer_size;
>  };

Any reason these definitions are not conditionally defined based on
CONFIG_IMA_KEXEC, like on powerpc?

> 
> diff --git a/arch/arm64/kernel/ima_kexec.c b/arch/arm64/kernel/ima_kexec.c
> new file mode 100644
> index 000000000000..1847f1230710
> --- /dev/null
> +++ b/arch/arm64/kernel/ima_kexec.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 Microsoft Corporation
> + *
> + * Author: Prakhar Srivastava <prsriva@linux.microsoft.com>
> + *
> + * File: ima_kexec.c
> + *       Defines IMA kexec functions.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/types.h>
> +#include <asm/ima.h>
> +
> +/**
> + * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> + *
> + * @image: kimage structure to set ima buffer information in for kexec
> + * @load_addr: Start address of the IMA buffer
> + * @size: size of the IMA buffer
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

This is exactly the same as the powerpc version.  Couldn't there be a
common version of this as well?

Mimi



