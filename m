Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EBD25CD45
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgICWMz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Sep 2020 18:12:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728309AbgICWMy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Sep 2020 18:12:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083M2I4g088162;
        Thu, 3 Sep 2020 18:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=vfAxjaSURqVQkdPQBM6+/IzRa+Uk6OykdgGVzRffals=;
 b=ByB0e8PBQLcON3bXwl5sX4lNJG76MDoMxpAGwYXt94MSuRVtHeYezYCwDwJV6hcoq4yi
 rwJFqRrHIc9n9u5NBUwmtXNwz80TS4pnVyhJLiBvj14kFOMu+qZD9drJ/RqG7s79sJ/H
 AZilOvUMjJCGGXTVGMcrMJZ2QQCCw7a6TBW9fZD0guQ/x+9jpJDcRZvTlsCIqj0bzacm
 eTE2LfUfK6Fuvom08bTrrdSjtJMy9K1RN2X/j98vAymPtqwM2u7mfg6s2BfDeNyrBtlY
 rvotHgOKnVi6w/fBIGXh99EKFWf65SV/veSSFbwG2FoHoXYeMRkhLKpUmgmOewuBd7FW ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33b8n60m1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 18:12:01 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 083M2kT7090455;
        Thu, 3 Sep 2020 18:12:00 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33b8n60m0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 18:12:00 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 083MBYkK028762;
        Thu, 3 Sep 2020 22:12:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 337ena2xht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 22:11:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 083MBtXH30671564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Sep 2020 22:11:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E322A78086;
        Thu,  3 Sep 2020 22:11:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D95378083;
        Thu,  3 Sep 2020 22:11:51 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.155.22])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Sep 2020 22:11:51 +0000 (GMT)
References: <20200901195029.30039-1-nramas@linux.microsoft.com>
 <20200901195029.30039-4-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v5 3/3] arm64: Add IMA kexec buffer to DTB
In-reply-to: <20200901195029.30039-4-nramas@linux.microsoft.com>
Date:   Thu, 03 Sep 2020 19:11:48 -0300
Message-ID: <87sgbyy0gr.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_14:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030189
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
> ARM64 and reserve the memory for storing the IMA log.
> Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to
> indicate that the IMA measurement log information is present in
> the device tree.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/arm64/Kconfig                     |  1 +
>  arch/arm64/kernel/machine_kexec_file.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
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
> index 361a1143e09e..0fe3d629eefe 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -136,6 +136,21 @@ static int setup_dtb(struct kimage *image,
>  				FDT_PROP_KASLR_SEED);
>  	}
>  
> +	/* add ima-kexec-buffer */
> +	if (image->arch.ima_buffer_size > 0) {
> +		ret = fdt_appendprop_addrrange(dtb, 0, off,
> +				FDT_PROP_IMA_KEXEC_BUFFER,
> +				image->arch.ima_buffer_addr,
> +				image->arch.ima_buffer_size);
> +		if (ret)
> +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> +
> +		ret = fdt_add_mem_rsv(dtb, image->arch.ima_buffer_addr,
> +				      image->arch.ima_buffer_size);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	/* add rng-seed */
>  	if (rng_is_initialized()) {
>  		void *rng_seed;

I just noticed one more thing this code isn't doing compared to the
powerpc version (sorry to bring these issues piecemeal, I didn't realize
this before):

You're not checking whether there already is a device tree property and
corresponding memory reservation for an IMA kexec buffer that the
currently running kernel might have received from a previous kernel. In
that case, this code will do the wrong thing because
fdt_appendprop_addrrange() will append the range to the existing
property, which is not what you want. You'll also have a memory
reservation entry for a stale IMA kexec buffer, which just wastes
memory.

So one thing you need to do, whether or not there's an IMA kexec buffer
to be passed to the next kernel, is to remove any existing
FDT_PROP_IMA_KEXEC_BUFFER property and also its corresponding memory
reservation, so that you avoid accumulating stale memory reservations
for non-existing IMA kexec buffers from previous kexecs.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
