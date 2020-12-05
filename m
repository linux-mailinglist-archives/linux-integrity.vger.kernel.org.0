Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164782CFF4C
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 22:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgLEViR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Dec 2020 16:38:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725933AbgLEViR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Dec 2020 16:38:17 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B5LWPjg021605;
        Sat, 5 Dec 2020 16:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=vXk0Ry8r0udMrQMw9qlr3RrPhTQPkuTMBd5GSYiIIhA=;
 b=W1MV6cpLZMHOXBiJJI1o7Vld82fJFn4u4tg8sa9F+5v6mkPk6BeDjB4KgO7dNIGpt1K2
 8F2HGrG+77XMhw/R4+Zj73MEvbhbf2qG21VPeLMo2U1myTzVt5u2WpsHVbPy2FTN2eJC
 hpiUT4LuYjXwtl3XHi+i9HzJPtWGCeLZqEDdfplLSV31+dnANTW7SA6xOmGPIODHv9b0
 nU7TPtTMW1mCBzgW9CVqT/lRxo37P6E0MYhQkm42u/S9u7Esl8DNzjKW75A2lkyAEVn6
 p8YbJBccr9PsRkftxPcadOkb6B6opbBqyJOQG9RHylCO6xw/B548fGf5OxaJXaXSNP3R pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35877j30ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 16:36:57 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B5LYoku028911;
        Sat, 5 Dec 2020 16:36:57 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35877j30u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 16:36:57 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B5Latw5031067;
        Sat, 5 Dec 2020 21:36:56 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3581u8mqsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Dec 2020 21:36:56 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B5Late039387620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Dec 2020 21:36:55 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 953FEAC05B;
        Sat,  5 Dec 2020 21:36:55 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B8EDAC059;
        Sat,  5 Dec 2020 21:36:48 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.85.177.236])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 21:36:48 +0000 (GMT)
References: <20201204195149.611-1-nramas@linux.microsoft.com>
 <20201204195149.611-8-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v10 7/8] powerpc: Move arch_ima_add_kexec_buffer to ima
In-reply-to: <20201204195149.611-8-nramas@linux.microsoft.com>
Date:   Sat, 05 Dec 2020 18:36:46 -0300
Message-ID: <87k0twlytt.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-05_19:2020-12-04,2020-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012050142
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> arch_ima_add_kexec_buffer() sets the address and size of the IMA
> measurement log in the architecture specific field in struct kimage.
> This function does not have architecture specific code, but is
> currently limited to powerpc.
>
> Move arch_ima_add_kexec_buffer() to
> security/integrity/ima/ima_kexec.c so that it is accessible for
> other architectures as well.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Not sure if the maintainers will agree with me (see below), but FWIW:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>  arch/powerpc/include/asm/ima.h     |  3 ---
>  arch/powerpc/kexec/ima.c           | 21 ---------------------
>  security/integrity/ima/ima_kexec.c | 22 ++++++++++++++++++++++
>  3 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
> index d8444d27f0d8..d6ab5d944dcd 100644
> --- a/arch/powerpc/include/asm/ima.h
> +++ b/arch/powerpc/include/asm/ima.h
> @@ -7,9 +7,6 @@
>  struct kimage;
>  
>  #ifdef CONFIG_IMA_KEXEC
> -int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> -			      size_t size);
> -
>  int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
>  #else
>  static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
> index bf7084c0c4da..b2793be353a9 100644
> --- a/arch/powerpc/kexec/ima.c
> +++ b/arch/powerpc/kexec/ima.c
> @@ -13,27 +13,6 @@
>  #include <linux/libfdt.h>
>  #include <asm/ima.h>
>  
> -/**
> - * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> - *
> - * @image: kimage struct to set IMA buffer data
> - * @load_addr: Starting address where IMA buffer is loaded at
> - * @size: Number of bytes in the IMA buffer
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
>  static int write_number(void *p, u64 value, int cells)
>  {
>  	if (cells == 1) {
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 4d354593aecf..5263dafe8f4d 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -74,6 +74,28 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  	return ret;
>  }
>  
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
> +static int arch_ima_add_kexec_buffer(struct kimage *image,
> +				     unsigned long load_addr,
> +				     size_t size)
> +{
> +	image->arch.ima_buffer_addr = load_addr;
> +	image->arch.ima_buffer_size = size;
> +
> +	return 0;
> +}
> +

Both powerpc and arm64 use the definition above for
arch_ima_add_kexec_buffer(), so it makes sense to share them as you do
in this patch. This file isn't the best one to put arch-specific code
which happens to be identical among architectures, but I can't think of
somewhere else to put it.

For now this isn't an issue since powerpc and arm64 are the only arches
implementing tihs feature. If a third arch implemented it and also used
the same function definition as above, it wouldn't be an issue either so
perhaps this is good enough for the time being? :-)

With this patch, the `#include <asm/ima.h>` in
security/integrity/ima/ima.h can be removed. It was there just to
provide a declaration of arch_ima_add_kexec_buffer().

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
