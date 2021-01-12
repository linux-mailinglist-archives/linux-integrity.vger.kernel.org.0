Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4EA2F4046
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 01:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbhALXaF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 18:30:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390320AbhALXaE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 18:30:04 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10CNKvoW078385;
        Tue, 12 Jan 2021 18:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OQx0rO6K2WJroZF2ljY3MmxVQhPq2LrvX6P/Du4U7oM=;
 b=ssB0vhAzO9kkbz4indt3prFm2bfj9uVK9Czs3ZCef3ldNFHOCU3YwiqXrBvpZ0CZrF7i
 c6+PQJRge7tiC3WL5jO+JaMpBJ3H8SodrshqjcNJvqPd64FmNqzWptGcdXIqr059KMRB
 GsQmgiWMkCnV93sLPMKcAWr+XUP/oNHmYsL++TMKdT9ojKtAhRK9Jc4Whx66xmiLv/qZ
 m9+I79YjMLIeVyXV74pkNaXP/+L8CP8LB4ZZi3IGcCLwIc00zQNbyRKM9UILV3CXeuyB
 ga0xVGT5PRLDqbbdrt9mYzf9bn9DWjZaoA9G8mp71Qt5pi1bonnGRPqJuR/0r0HlQin0 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 361nbv041f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 18:28:43 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10CNSgxE105620;
        Tue, 12 Jan 2021 18:28:42 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 361nbv040r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 18:28:42 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10CNSLQv030115;
        Tue, 12 Jan 2021 23:28:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 35y448a72n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 23:28:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10CNSX2x20251078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 23:28:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F3EA4C040;
        Tue, 12 Jan 2021 23:28:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 820484C044;
        Tue, 12 Jan 2021 23:28:31 +0000 (GMT)
Received: from sig-9-65-221-171.ibm.com (unknown [9.65.221.171])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jan 2021 23:28:31 +0000 (GMT)
Message-ID: <4fef02cb3b330128e6d5d9bc9aab4d7e603d2945.camel@linux.ibm.com>
Subject: Re: [PATCH v14 6/6] arm64: Add IMA log information in kimage used
 for kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@vger.kernel.org
Date:   Tue, 12 Jan 2021 18:28:30 -0500
In-Reply-To: <20210104192602.10131-7-nramas@linux.microsoft.com>
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
         <20210104192602.10131-7-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_19:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Mon, 2021-01-04 at 11:26 -0800, Lakshmi Ramasubramanian wrote:
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

Perhaps for some previous version of this patch set, this patch
description was appropriate, but for the code below it's kind of
overkill.

Mimi
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/arm64/Kconfig             | 1 +
>  arch/arm64/include/asm/kexec.h | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a6b5b7ef40ae..312b4d5ad232 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1095,6 +1095,7 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "kexec file based system call"
>  	select KEXEC_CORE
> +	select HAVE_IMA_KEXEC if IMA
>  	help
>  	  This is new version of kexec system call. This system call is
>  	  file based and takes file descriptors as system call argument
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index d24b527e8c00..2bd19ccb6c43 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -100,6 +100,11 @@ struct kimage_arch {
>  	void *elf_headers;
>  	unsigned long elf_headers_mem;
>  	unsigned long elf_headers_sz;
> +
> +#ifdef CONFIG_IMA_KEXEC
> +	phys_addr_t ima_buffer_addr;
> +	size_t ima_buffer_size;
> +#endif
>  };
>  
>  extern const struct kexec_file_ops kexec_image_ops;


