Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF882CFF0C
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgLEVDh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Dec 2020 16:03:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725270AbgLEVDg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Dec 2020 16:03:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B5KZinU172460;
        Sat, 5 Dec 2020 16:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=RtedBLX2+TsYnSc7y8UU7YZr7ycYL7nIEyY97NlbG/c=;
 b=sMTf1Nzxsy1ckClRq3LhFCEiu2fSrzCr1y3nHjwGHmLwVwOPRLaro9Pa+7ZoFLK4INDD
 ghcYy1RKMlijB2HeZWV5aZ+jN3amFPi4eSIDJSOc7O3V5mzx+uoLTBnbntxmJDNSD6mx
 DWL0P3KmEoV/HTiZwWIMbChuoKDmPkAtl+04cHa1rievXywNxyhOWaUfxcBUxpoyF47K
 kx/BIXhn03GQnB6V0Z5dTUPFrTpmp4pFEAmDgM/tAEA6jfDtCJ9wi9TTXdXiZU0SXbX1
 fsdDoEcFpx3EKzEz+hKlle+tsWY7GEdu5+2aV7BRgptYoJBsExi7swG6kGi680teA+1K xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3587ks1be7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 16:02:19 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B5KqwDk051522;
        Sat, 5 Dec 2020 16:02:18 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3587ks1bdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 16:02:18 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B5Kup16026541;
        Sat, 5 Dec 2020 21:02:17 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 3581u8nq9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 21:02:17 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B5L2Gns11141856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Dec 2020 21:02:16 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 669ADAC05E;
        Sat,  5 Dec 2020 21:02:16 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A455AC059;
        Sat,  5 Dec 2020 21:02:09 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.177.236])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 21:02:09 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-7-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v10 6/8] powerpc: Move ima_get_kexec_buffer() and
 ima_free_kexec_buffer() to ima
In-reply-to: <20201204195149.611-7-nramas@linux.microsoft.com>
Date:   Sat, 05 Dec 2020 18:02:07 -0300
Message-ID: <87mtysm0fk.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-05_18:2020-12-04,2020-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=814 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012050138
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> ima_get_kexec_buffer() retrieves the address and size of the buffer
> used for carrying forward the IMA measurement logs on kexec from
> the device tree.
>
> ima_free_kexec_buffer() removes the chosen node
> "linux,ima-kexec-buffer" from the device tree, and frees the buffer
> used for carrying forward the IMA measurement logs on kexec.
>
> These functions do not have architecture specific code, but are
> currently limited to powerpc. Move ima_get_kexec_buffer() and
> ima_free_kexec_buffer() to ima_kexec.c in IMA so that they are
> accessible for other architectures as well.
>
> With the above change the functions in arch/powerpc/kexec/ima.c are
> defined only when the kernel config CONFIG_IMA_KEXEC is enabled.
> Update the Makefile to build arch/powerpc/kexec/ima.c only when
> CONFIG_IMA_KEXEC is enabled and remove "#ifdef CONFIG_IMA_KEXEC"
> in arch/powerpc/kexec/ima.c.

Nice.

> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Just a small nit below:

> ---
>  arch/powerpc/include/asm/ima.h     |  3 --
>  arch/powerpc/kexec/Makefile        |  7 +---
>  arch/powerpc/kexec/ima.c           | 50 -----------------------------
>  security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++++++++++++++
>  4 files changed, 52 insertions(+), 59 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
> index a2fc71bc3b23..d8444d27f0d8 100644
> --- a/arch/powerpc/include/asm/ima.h
> +++ b/arch/powerpc/include/asm/ima.h
> @@ -6,9 +6,6 @@
>  
>  struct kimage;
>  
> -int ima_get_kexec_buffer(void **addr, size_t *size);
> -int ima_free_kexec_buffer(void);
> -
>  #ifdef CONFIG_IMA_KEXEC
>  int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
>  			      size_t size);
> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> index 4aff6846c772..f54a9dbff4c8 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -9,12 +9,7 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
>  
>  obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
>  
> -ifdef CONFIG_HAVE_IMA_KEXEC
> -ifdef CONFIG_IMA
> -obj-y				+= ima.o
> -endif
> -endif
> -
> +obj-$(CONFIG_IMA_KEXEC)		+= ima.o
>  
>  # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_core_$(BITS).o := n
> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
> index 68017123b07d..bf7084c0c4da 100644
> --- a/arch/powerpc/kexec/ima.c
> +++ b/arch/powerpc/kexec/ima.c
> @@ -13,55 +13,6 @@
>  #include <linux/libfdt.h>
>  #include <asm/ima.h>

With this patch, the following includes become unnecessary and can be
removed from this file:

#include <linux/of.h>
#include <linux/memblock.h>

> -/**
> - * ima_get_kexec_buffer - get IMA buffer from the previous kernel
> - * @addr:	On successful return, set to point to the buffer contents.
> - * @size:	On successful return, set to the buffer size.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int ima_get_kexec_buffer(void **addr, size_t *size)
> -{
> -	int ret;
> -	unsigned long tmp_addr;
> -	size_t tmp_size;
> -
> -	ret = get_ima_kexec_buffer(NULL, 0, &tmp_addr, &tmp_size);
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
> -	ret = get_ima_kexec_buffer(NULL, 0, &addr, &size);
> -	if (ret)
> -		return ret;
> -
> -	ret = of_remove_property(of_chosen, prop);
> -	if (ret)
> -		return ret;
> -
> -	return memblock_free(addr, size);
> -}
> -
> -#ifdef CONFIG_IMA_KEXEC
>  /**
>   * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
>   *
> @@ -154,4 +105,3 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_IMA_KEXEC */

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
