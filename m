Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B404318320
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 02:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBKBoJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 20:44:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8224 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhBKBoG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 20:44:06 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11B1WMT6078703;
        Wed, 10 Feb 2021 20:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=vDDRZUahYyXldUj68jibr2HXimj2YM2P2Jgn9LzlN24=;
 b=FUGCUGH+Eqd5Fa5UGlaHe0jjtLtAxYgfMDuDHiom7D/vEbg9+Ebu63p7XUTWZRXPtjU7
 3Q+eEClsYMJBZTtZrmTKpgDaWUBlj4G63gFJK335oD+5bimoPA0ZXw+WVKjXbQuKtRGP
 +sg1Op+s+320fDztY2VfLUtzVKYhpcjbzFLScbVpjgPX4ruKJgbcR0Zgcwdvzt17+mC4
 xu12+P5I1ojcrnO2dHTJXfozdFdg/p0cc3zBgE5NWUB0ENpvq9jHqkrJnTr1Lx5noPoO
 zx+ywCeGxhkfjdgzEhdevjSLETB3GDH+ytkvvhT544BTiylqvGaCY5AqrHa6KZd+Ar6a MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mtjd90ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 20:42:47 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11B1XRrp083811;
        Wed, 10 Feb 2021 20:42:45 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36mtjd90kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 20:42:45 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11B1gIHx001102;
        Thu, 11 Feb 2021 01:42:41 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 36hjraayme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 01:42:41 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11B1gel418416028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 01:42:40 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91ECFBE04F;
        Thu, 11 Feb 2021 01:42:40 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B86C0BE054;
        Thu, 11 Feb 2021 01:42:30 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.160.95.194])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Feb 2021 01:42:30 +0000 (GMT)
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-5-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org, joe@perches.com,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v17 04/10] powerpc: Use common
 of_kexec_alloc_and_setup_fdt()
In-reply-to: <20210209182200.30606-5-nramas@linux.microsoft.com>
Date:   Wed, 10 Feb 2021 22:42:27 -0300
Message-ID: <87sg63nzwc.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_11:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110004
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> From: Rob Herring <robh@kernel.org>
>
> The code for setting up the /chosen node in the device tree
> and updating the memory reservation for the next kernel has been
> moved to of_kexec_alloc_and_setup_fdt() defined in "drivers/of/kexec.c".
>
> Use the common of_kexec_alloc_and_setup_fdt() to setup the device tree
> and update the memory reservation for kexec for powerpc.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/kexec.h  |   1 +
>  arch/powerpc/kexec/elf_64.c       |  29 ++++---
>  arch/powerpc/kexec/file_load.c    | 132 +-----------------------------
>  arch/powerpc/kexec/file_load_64.c |   3 +
>  4 files changed, 25 insertions(+), 140 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index dbf09d2f36d0..bdd0ddb9ac4d 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -111,6 +111,7 @@ struct kimage_arch {
>  	unsigned long elf_headers_mem;
>  	unsigned long elf_headers_sz;
>  	void *elf_headers;
> +	void *fdt;
>  
>  #ifdef CONFIG_IMA_KEXEC
>  	phys_addr_t ima_buffer_addr;
> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> index d0e459bb2f05..bfabd06f99b1 100644
> --- a/arch/powerpc/kexec/elf_64.c
> +++ b/arch/powerpc/kexec/elf_64.c
> @@ -19,6 +19,7 @@
>  #include <linux/kexec.h>
>  #include <linux/libfdt.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -29,7 +30,6 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>  			unsigned long cmdline_len)
>  {
>  	int ret;
> -	unsigned int fdt_size;
>  	unsigned long kernel_load_addr;
>  	unsigned long initrd_load_addr = 0, fdt_load_addr;
>  	void *fdt;
> @@ -102,19 +102,13 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>  		pr_debug("Loaded initrd at 0x%lx\n", initrd_load_addr);
>  	}
>  
> -	fdt_size = fdt_totalsize(initial_boot_params) * 2;
> -	fdt = kmalloc(fdt_size, GFP_KERNEL);
> +	fdt = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
> +					   initrd_len, cmdline);
>  	if (!fdt) {
>  		pr_err("Not enough memory for the device tree.\n");

This error string can be a bit misleading now, since
of_kexec_alloc_and_setup_fdt() can fail for reasons other than lack of
memory. I suggest changing it to the error string from fdt_open_into()
below:

		pr_err("Error setting up the new device tree.\n");

With this change:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

And also:

Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
