Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC125623E
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 22:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH1UvH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 16:51:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbgH1UvF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 16:51:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07SKWZ8d029115;
        Fri, 28 Aug 2020 16:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=Ny7eNfWhtcq4Ar5c7KEMz0IptA0ExTcP1Tp3zXIUI3o=;
 b=OHEg8KITkuARJ/TpltkffH95tKQ/B5JQbeV5YBbX3V73zR20f5QyOgwD3nSG8aIMkKB7
 4RXDNhR9mQNuVqa17HEA7RuyIafMfZFJ7/ETWs1LJqT8uYWsXHfY+2HDcNAZiUUehoKV
 DMsfLfJH9oLF/MKUMwS1dTPCOfgMuFAxy829J36MzijUfIfQ3rGT/Vb3239qc3qpwLJU
 6D6tG+dZeiaIGWBk5UK0uwIw715HgeQSWzeQjICR2IBdJioABr1me1ECZCMMqZa0S2PB
 a602zbmobZrEyfrp7WSUKhiw/W1j1Sbd6inwNfZaKubZv0VUfzcWX1vvrJJKTykcuSu8 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3378hms2dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 16:50:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07SKWqB5029504;
        Fri, 28 Aug 2020 16:50:25 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3378hms2d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 16:50:25 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07SKlBNH020665;
        Fri, 28 Aug 2020 20:50:23 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 332utu9ujg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 20:50:23 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07SKoN4423462308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 20:50:23 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CD23AE05C;
        Fri, 28 Aug 2020 20:50:23 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91C44AE05F;
        Fri, 28 Aug 2020 20:50:12 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.108.111])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Aug 2020 20:50:12 +0000 (GMT)
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
 <20200819172134.11243-5-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v4 4/5] arm64: Store IMA log information in kimage used
 for kexec
In-reply-to: <20200819172134.11243-5-nramas@linux.microsoft.com>
Date:   Fri, 28 Aug 2020 17:50:09 -0300
Message-ID: <875z928pha.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_15:2020-08-28,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

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

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

IMHO this patch and the next one can be squashed together. Also, a minor
comment below.

> ---
>  arch/arm64/include/asm/ima.h           | 17 +++++++++++++++++
>  arch/arm64/include/asm/kexec.h         |  3 +++
>  arch/arm64/kernel/machine_kexec_file.c | 17 +++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 arch/arm64/include/asm/ima.h
>
> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
> new file mode 100644
> index 000000000000..70ac39b74607
> --- /dev/null
> +++ b/arch/arm64/include/asm/ima.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARCH_IMA_H
> +#define _ASM_ARCH_IMA_H
> +
> +struct kimage;
> +
> +#ifdef CONFIG_IMA_KEXEC
> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> +			      size_t size);
> +#else
> +static inline int arch_ima_add_kexec_buffer(struct kimage *image,
> +			unsigned long load_addr, size_t size)
> +{
> +	return 0;
> +}

There's no need to define arch_ima_add_kexec_buffer() if
CONFIG_IMA_KEXEC isn't set because in that case, the code which calls
this function in ima_add_kexec_buffer() won't be part of the build.

> +#endif /* CONFIG_IMA_KEXEC */
> +#endif /* _ASM_ARCH_IMA_H */

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
