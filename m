Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36C2CFEB2
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 21:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLEUPs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Dec 2020 15:15:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgLEUPr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Dec 2020 15:15:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B5K8Z1x007054;
        Sat, 5 Dec 2020 15:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=6jCw3kmDy3jkFZm6wOewN6uB9Ft+47BOXo7a0wPzJKI=;
 b=SbkQdl9drpK6ty22uAnulF72mNXB2wp6aIOz9ycbIOVD5/Falq8zYihvVi9D49TGVqfg
 4ye41/DCHF6jeE2ilrBjA9GkP/wt0LSpJ+zU0YyNIL4vbGDUSNN0POrhiLFIOckpNeKn
 /tIvKoULd1fw/14oF5ZiUJoA2rv9z0ASggK2WdWlUpVzkThKcjM/IBFbFl+l1py8dSkX
 oDfHInYSC3HZ5s++VTMsOkcxU19ocZFDZ+caL48dZ+XUy2IHMQEnGF3iPdRsUd+I6n/h
 2pMh+NxQL+5+BjwednF9GRHJc+xLAp+pHi1clEqHQmdRdcqHKWab2xyUjthxQe9NEUze QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 358ams67wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 15:14:34 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B5KAUVu014080;
        Sat, 5 Dec 2020 15:14:34 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 358ams67wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 15:14:34 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B5KDnR3016821;
        Sat, 5 Dec 2020 20:14:32 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 3581u8md78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 20:14:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B5KEVbY21692728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Dec 2020 20:14:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C473378063;
        Sat,  5 Dec 2020 20:14:31 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71BB97805E;
        Sat,  5 Dec 2020 20:14:24 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.177.236])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 20:14:24 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-6-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v10 5/8] powerpc: Move remove_ima_buffer() to
 drivers/of/kexec.c
In-reply-to: <20201204195149.611-6-nramas@linux.microsoft.com>
Date:   Sat, 05 Dec 2020 17:14:22 -0300
Message-ID: <87sg8km2n5.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-05_15:2020-12-04,2020-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=2
 mlxlogscore=938 mlxscore=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012050134
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> remove_ima_buffer() removes the chosen node "linux,ima-kexec-buffer"
> from the device tree and frees the memory reserved for carrying forward
> the IMA measurement logs on kexec. This function does not have
> architecture specific code, but is currently limited to powerpc.
>
> Move remove_ima_buffer() to "drivers/of/ima_kexec.c" so that it is

s/ima_kexec./kexec.c/

> accessible for other architectures as well.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Looks good. Just minor comments below. Nevertheless:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>  arch/powerpc/include/asm/ima.h |  8 ++------
>  arch/powerpc/kexec/ima.c       | 26 --------------------------
>  drivers/of/kexec.c             | 29 +++++++++++++++++++++++++++++
>  include/linux/kexec.h          |  1 +
>  4 files changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
> index ead488cf3981..a2fc71bc3b23 100644
> --- a/arch/powerpc/include/asm/ima.h
> +++ b/arch/powerpc/include/asm/ima.h
> @@ -2,17 +2,13 @@
>  #ifndef _ASM_POWERPC_IMA_H
>  #define _ASM_POWERPC_IMA_H
>  
> +#include <linux/kexec.h>
> +
>  struct kimage;

When you include <linux/kexec.h>, there's no need anymore for the
`struct kimage` forward declaration so you can remove it.

>  
>  int ima_get_kexec_buffer(void **addr, size_t *size);
>  int ima_free_kexec_buffer(void);
>  
> -#ifdef CONFIG_IMA
> -void remove_ima_buffer(void *fdt, int chosen_node);
> -#else
> -static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
> -#endif
> -

This patch introduces a slight behaviour change on powerpc when
CONFIG_IMA isn't set: since remove_ima_buffer() is now defined,
kexec_file_load() will remove the IMA kexec buffer when creating the FDT
for the next kernel. Before this patch, it will leave it there.

I think it's actually an improvement since a stale IMA kexec buffer
isn't useful and just wastes memory. This should be mentioned on the
commit message.

>  #ifdef CONFIG_IMA_KEXEC
>  int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>  			      size_t size);
> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
> index 906e8212435d..68017123b07d 100644
> --- a/arch/powerpc/kexec/ima.c
> +++ b/arch/powerpc/kexec/ima.c
> @@ -61,32 +61,6 @@ int ima_free_kexec_buffer(void)
>  	return memblock_free(addr, size);
>  }
>  
> -/**
> - * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> - *
> - * @fdt: Flattened Device Tree to update
> - * @chosen_node: Offset to the chosen node in the device tree
> - *
> - * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> - * remove it from the device tree.
> - */
> -void remove_ima_buffer(void *fdt, int chosen_node)
> -{
> -	int ret;
> -	unsigned long addr;
> -	size_t size;
> -
> -	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
> -	if (ret)
> -		return;
> -
> -	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
> -
> -	ret = delete_fdt_mem_rsv(fdt, addr, size);
> -	if (!ret)
> -		pr_debug("Removed old IMA buffer reservation.\n");
> -}
> -
>  #ifdef CONFIG_IMA_KEXEC
>  /**
>   * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 516b86f7113a..42d16dfff78d 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -129,3 +129,32 @@ int get_ima_kexec_buffer(void *fdt, int chosen_node,
>  
>  	return 0;
>  }
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
> +	int ret;
> +	unsigned long addr;
> +	size_t size;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return;
> +
> +	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
> +	if (ret)
> +		return;
> +
> +	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
> +
> +	ret = delete_fdt_mem_rsv(fdt, addr, size);
> +	if (!ret)
> +		pr_debug("Removed old IMA buffer reservation.\n");
> +}
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 10ff704ab670..52a0efff184d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -411,6 +411,7 @@ static inline int kexec_crash_loaded(void) { return 0; }
>  extern int get_root_addr_size_cells(int *addr_cells, int *size_cells);
>  extern int get_ima_kexec_buffer(void *fdt, int chosen_node,
>  				unsigned long *addr, size_t *size);
> +extern void remove_ima_buffer(void *fdt, int chosen_node);
>  extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
>  			      unsigned long size);
>  #endif /* CONFIG_OF_FLATTREE */

Same comment as before: remove the `extern` keyword.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
