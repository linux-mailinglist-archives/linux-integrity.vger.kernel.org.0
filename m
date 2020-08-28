Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1E256298
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgH1VoG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 17:44:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgH1VoF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 17:44:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07SLXJFc093893;
        Fri, 28 Aug 2020 17:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=tYYENsGw1bDKIf30hQvsz8tH9P7UHOVJ9I4qySJAdvo=;
 b=czTFxr9OHKMyTSCw3vi2NNj1JHKEBSTf6AXJFMyMtt9jxSkT3CSJPIwjp8QuphvNhWYx
 hJa7Gu3077orZ9UJZvAPVfjN2RST2e1az83XlX6Qr43pjdtMabSoUOsGMm/9PqdJpzyX
 dc7zX2xpZdOSVzH2xe0SD9gNAZflK2ePilS4UMTAVqK852qJKOZD10wsMXzP825gy/FG
 oDhiSz6h/OAV/1KD9PlEnO8kFn+7/zNgy5FFqrildEevguDEQb1TqWu+Yg+PSqUMeAmD
 RNsYJ8vyWMu9SHsj5ZqPmMNzqrrR0OODAnR29UkIPIhPgKlAIV28so385cKArVomfePj /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3379aa12jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 17:43:32 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07SLevPr114707;
        Fri, 28 Aug 2020 17:43:32 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3379aa12j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 17:43:32 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07SLbAt9012715;
        Fri, 28 Aug 2020 21:43:30 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 332uwb4x60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 21:43:30 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07SLhQ2660686768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 21:43:26 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC3507805C;
        Fri, 28 Aug 2020 21:43:29 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49ADB7805F;
        Fri, 28 Aug 2020 21:43:22 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.108.111])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Aug 2020 21:43:21 +0000 (GMT)
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
 <20200819172134.11243-6-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v4 5/5] arm64: Add IMA kexec buffer to DTB
In-reply-to: <20200819172134.11243-6-nramas@linux.microsoft.com>
Date:   Fri, 28 Aug 2020 18:43:19 -0300
Message-ID: <8736468n0o.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_18:2020-08-28,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280156
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> The address and size of the current kernel's IMA measurement log
> need to be added to the device tree's IMA kexec buffer node for
> the log to be carried over to the next kernel on the kexec call.
>
> Add the IMA measurement log buffer properties to the device tree for
> ARM64. Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to
> indicate that the IMA measurement log information is present in
> the device tree.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/arm64/Kconfig                     |  1 +
>  arch/arm64/kernel/machine_kexec_file.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..9f03c8245e5b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1077,6 +1077,7 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "kexec file based system call"
>  	select KEXEC_CORE
> +	select HAVE_IMA_KEXEC
>  	help
>  	  This is new version of kexec system call. This system call is
>  	  file based and takes file descriptors as system call argument
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 4c54723e7a04..8488f8e87d1a 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -153,6 +153,17 @@ static int setup_dtb(struct kimage *image,
>  				FDT_PROP_KASLR_SEED);
>  	}
>  
> +	/* add ima-kexec-buffer */
> +	if (image->arch.ima_buffer_size > 0) {
> +
> +		ret = fdt_appendprop_addrrange(dtb, 0, off,
> +				FDT_PROP_IMA_KEXEC_BUFFER,
> +				image->arch.ima_buffer_addr,
> +				image->arch.ima_buffer_size);
> +		if (ret)
> +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> +	}
> +
>  	/* add rng-seed */
>  	if (rng_is_initialized()) {
>  		void *rng_seed;

I believe you need to add a memory reservation to the dtb covering the
IMA kexec buffer, otherwise nothing stops the new kernel from stomping
over it. E.g., powerpc does:

	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
			      image->arch.ima_buffer_size);

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
