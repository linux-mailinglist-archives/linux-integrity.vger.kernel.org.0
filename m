Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05B175D86
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2020 15:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCBOs6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Mar 2020 09:48:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64970 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbgCBOs5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Mar 2020 09:48:57 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022Emf55057226
        for <linux-integrity@vger.kernel.org>; Mon, 2 Mar 2020 09:48:56 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfkn9k1ae-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Mar 2020 09:48:55 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 2 Mar 2020 14:48:51 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 14:48:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022EmkZv56623236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 14:48:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF63A11C05C;
        Mon,  2 Mar 2020 14:48:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 840F811C052;
        Mon,  2 Mar 2020 14:48:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.229.179])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 14:48:45 +0000 (GMT)
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 09:48:44 -0500
In-Reply-To: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030214-0016-0000-0000-000002EC4F1B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030214-0017-0000-0000-0000334F9204
Message-Id: <1583160524.8544.91.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_05:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-02-26 at 14:10 -0500, Nayna Jain wrote:
> Every time a new architecture defines the IMA architecture specific
> functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
> include file needs to be updated. To avoid this "noise", this patch
> defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
> the different architectures to select it.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Kconfig           | 2 +-
>  arch/s390/Kconfig              | 1 +
>  arch/x86/Kconfig               | 1 +
>  include/linux/ima.h            | 3 +--
>  security/integrity/ima/Kconfig | 9 +++++++++
>  5 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 497b7d0b2d7e..b8ce1b995633 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -246,6 +246,7 @@ config PPC
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
>  	select VIRT_TO_BUS			if !PPC64
> +	select IMA_SECURE_AND_OR_TRUSTED_BOOT	if PPC_SECURE_BOOT
>  	#
>  	# Please keep this list sorted alphabetically.
>  	#
> @@ -978,7 +979,6 @@ config PPC_SECURE_BOOT
>  	prompt "Enable secure boot support"
>  	bool
>  	depends on PPC_POWERNV
> -	depends on IMA_ARCH_POLICY
>  	help
>  	  Systems with firmware secure boot enabled need to define security
>  	  policies to extend secure boot to the OS. This config allows a user
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 8abe77536d9d..90ff3633ade6 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -195,6 +195,7 @@ config S390
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	select SWIOTLB
>  	select GENERIC_ALLOCATOR
> +	select IMA_SECURE_AND_OR_TRUSTED_BOOT
>  
>  
>  config SCHED_OMIT_FRAME_POINTER
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index beea77046f9b..cafa66313fe2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -230,6 +230,7 @@ config X86
>  	select VIRT_TO_BUS
>  	select X86_FEATURE_NAMES		if PROC_FS
>  	select PROC_PID_ARCH_STATUS		if PROC_FS
> +	select IMA_SECURE_AND_OR_TRUSTED_BOOT	if EFI

Not everyone is interested in enabling IMA or requiring IMA runtime
policies.  With this patch, enabling IMA_ARCH_POLICY is therefore
still left up to the person building the kernel.  As a result, I'm
seeing the following warning, which is kind of cool.

WARNING: unmet direct dependencies detected for
IMA_SECURE_AND_OR_TRUSTED_BOOT
  Depends on [n]: INTEGRITY [=y] && IMA [=y] && IMA_ARCH_POLICY [=n]
  Selected by [y]:
  - X86 [=y] && EFI [=y]

Ard, Michael, Martin, just making sure this type of warning is
acceptable before upstreaming this patch.  I would appreciate your
tags.

thanks!

Mimi

>  
>  config INSTRUCTION_DECODER
>  	def_bool y
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 1659217e9b60..aefe758f4466 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int size);
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  #endif
>  
> -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) || defined(CONFIG_S390) \
> -	|| defined(CONFIG_PPC_SECURE_BOOT)
> +#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
>  extern bool arch_ima_get_secureboot(void);
>  extern const char * const *arch_get_ima_policy(void);
>  #else
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 3f3ee4e2eb0d..d17972aa413a 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>  	depends on IMA_MEASURE_ASYMMETRIC_KEYS
>  	depends on SYSTEM_TRUSTED_KEYRING
>  	default y
> +
> +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> +	bool
> +	depends on IMA
> +	depends on IMA_ARCH_POLICY
> +	default n
> +	help
> +	   This option is selected by architectures to enable secure and/or
> +	   trusted boot based on IMA runtime policies.




