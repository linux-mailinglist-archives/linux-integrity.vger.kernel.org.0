Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B09552682B
	for <lists+linux-integrity@lfdr.de>; Fri, 13 May 2022 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358820AbiEMRT2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 May 2022 13:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382966AbiEMRTW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 May 2022 13:19:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04B926F4AD;
        Fri, 13 May 2022 10:19:18 -0700 (PDT)
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7CE1120ECB86;
        Fri, 13 May 2022 10:19:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CE1120ECB86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652462357;
        bh=ZCTmHx3JqQZkedFPeKXF7MFRF2FXKl7ErItL3WvjCxs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qZniULXRXqkHGa0UWik4RNN2Ra+BZd46y3CcyVgv59oTrfffB+Mk7vkUfEOfeCiJj
         NTDwEurIJ7rA06Re5cdP2RfnFFGzZH+4/LoHhWt331I2LN1MLV149VEM5raV2bhxtA
         CJp4+OlLrR5T17U07rtfvwJH9e7vIb3C2z+sKJiQ=
Message-ID: <8bffb420-46d9-eb57-a944-b2389570f88d@linux.microsoft.com>
Date:   Fri, 13 May 2022 10:19:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Content-Language: en-US
To:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jonathan,

On 5/12/2022 9:25 AM, Jonathan McDowell wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it. The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA. A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data. This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.
> 
> powerpc and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so use the setup_data mechanism to pass the IMA buffer to
> the new kernel.
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> ---
> v4:
>   - Guard ima.h function prototypes with CONFIG_HAVE_IMA_KEXEC
> v3:
>   - Rebase on tip/master
>   - Pull ima_(free|get)_kexec_buffer into x86 code
>   - Push ifdefs into functions where possible
>   - Reverse fir tree variable declarations
>   - Fix section annotation on ima_free_kexec_buffer (__meminit)
>   - Only allocate ima_setup_data space when IMA_KEXEC is enabled
> v2:
>   - Fix operation with EFI systems
> ---
>   arch/x86/Kconfig                      |  1 +
>   arch/x86/include/uapi/asm/bootparam.h |  9 ++++
>   arch/x86/kernel/e820.c                |  6 +--
>   arch/x86/kernel/kexec-bzimage64.c     | 38 ++++++++++++++++
>   arch/x86/kernel/setup.c               | 62 +++++++++++++++++++++++++++
>   drivers/of/kexec.c                    |  1 +
>   include/linux/ima.h                   |  5 +++
>   include/linux/of.h                    |  2 -
>   security/integrity/ima/ima_kexec.c    |  2 +-
>   9 files changed, 120 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f1320d9a3da3..594636f02da4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2027,6 +2027,7 @@ config KEXEC_FILE
>   	bool "kexec file based system call"
>   	select KEXEC_CORE
>   	select BUILD_BIN2C
> +	select HAVE_IMA_KEXEC if IMA
>   	depends on X86_64
>   	depends on CRYPTO=y
>   	depends on CRYPTO_SHA256=y
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index bea5cdcdf532..ca0796ac4403 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -11,6 +11,7 @@
>   #define SETUP_APPLE_PROPERTIES		5
>   #define SETUP_JAILHOUSE			6
>   #define SETUP_CC_BLOB			7
> +#define SETUP_IMA			8
>   
>   #define SETUP_INDIRECT			(1<<31)
>   
> @@ -172,6 +173,14 @@ struct jailhouse_setup_data {
>   	} __attribute__((packed)) v2;
>   } __attribute__((packed));
>   
> +/*
> + * IMA buffer setup data information from the previous kernel during kexec
> + */
> +struct ima_setup_data {
> +	__u64 addr;
> +	__u64 size;
> +} __attribute__((packed));
> +
>   /* The so-called "zeropage" */
>   struct boot_params {
>   	struct screen_info screen_info;			/* 0x000 */
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index f267205f2d5a..9dac24680ff8 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1017,10 +1017,10 @@ void __init e820__reserve_setup_data(void)
>   		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>   
>   		/*
> -		 * SETUP_EFI is supplied by kexec and does not need to be
> -		 * reserved.
> +		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> +		 * to be reserved.
>   		 */
> -		if (data->type != SETUP_EFI)
> +		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
>   			e820__range_update_kexec(pa_data,
>   						 sizeof(*data) + data->len,
>   						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..54bd4ce5f908 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -186,6 +186,33 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>   }
>   #endif /* CONFIG_EFI */
>   
> +static void
> +setup_ima_state(const struct kimage *image, struct boot_params *params,
> +		unsigned long params_load_addr,
> +		unsigned int ima_setup_data_offset)
> +{
> +#ifdef CONFIG_IMA_KEXEC
> +	struct setup_data *sd = (void *)params + ima_setup_data_offset;
> +	unsigned long setup_data_phys;
> +	struct ima_setup_data *ima;
> +
> +	if (!image->ima_buffer_size)
> +		return;
> +
> +	sd->type = SETUP_IMA;
> +	sd->len = sizeof(*ima);
> +
> +	ima = (void *)sd + sizeof(struct setup_data);
> +	ima->addr = image->ima_buffer_addr;
> +	ima->size = image->ima_buffer_size;
> +
> +	/* Add setup data */
> +	setup_data_phys = params_load_addr + ima_setup_data_offset;
> +	sd->next = params->hdr.setup_data;
> +	params->hdr.setup_data = setup_data_phys;
> +#endif /* CONFIG_IMA_KEXEC */
> +}
> +
>   static int
>   setup_boot_parameters(struct kimage *image, struct boot_params *params,
>   		      unsigned long params_load_addr,
> @@ -247,6 +274,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>   	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>   			efi_setup_data_offset);
>   #endif
> +
> +	/* Setup IMA log buffer state */
> +	setup_ima_state(image, params, params_load_addr,
> +			efi_setup_data_offset +
> +			sizeof(struct setup_data) +
> +			sizeof(struct efi_setup_data));
Here you could check image->ima_buffer_size and call setup_ima_state() 
only if it is non-zero.

> +
>   	/* Setup EDD info */
>   	memcpy(params->eddbuf, boot_params.eddbuf,
>   				EDDMAXNR * sizeof(struct edd_info));
> @@ -403,6 +437,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>   				sizeof(struct setup_data) +
>   				sizeof(struct efi_setup_data);
>   
> +	if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +		kbuf.bufsz += sizeof(struct setup_data) +
> +			      sizeof(struct ima_setup_data);
> +
>   	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
>   	if (!params)
>   		return ERR_PTR(-ENOMEM);
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 249981bf3d8a..ab5e7a351845 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -11,6 +11,7 @@
>   #include <linux/dma-map-ops.h>
>   #include <linux/dmi.h>
>   #include <linux/efi.h>
> +#include <linux/ima.h>
>   #include <linux/init_ohci1394_dma.h>
>   #include <linux/initrd.h>
>   #include <linux/iscsi_ibft.h>
> @@ -145,6 +146,11 @@ __visible unsigned long mmu_cr4_features __ro_after_init;
>   __visible unsigned long mmu_cr4_features __ro_after_init = X86_CR4_PAE;
>   #endif
>   
> +#ifdef CONFIG_IMA
> +static phys_addr_t ima_kexec_buffer_phys;
> +static size_t ima_kexec_buffer_size;
> +#endif
> +
>   /* Boot loader ID and version as integers, for the benefit of proc_dointvec */
>   int bootloader_type, bootloader_version;
>   
> @@ -335,6 +341,59 @@ static void __init reserve_initrd(void)
>   }
>   #endif /* CONFIG_BLK_DEV_INITRD */
>   
> +static void __init add_early_ima_buffer(u64 phys_addr)
> +{
> +#ifdef CONFIG_IMA
> +	struct ima_setup_data *data;
> +
> +	data = early_memremap(phys_addr + sizeof(struct setup_data),
> +			      sizeof(*data));
> +	if (!data) {
> +		pr_warn("setup: failed to memremap ima_setup_data entry\n");
> +		return;
> +	}
Here if memory allocation fails, would kexec system call fail or would 
it only not add IMA buffer, but continue with the system call?

> +	if (data->size != 0) {
> +		memblock_reserve(data->addr, data->size);
> +		ima_kexec_buffer_phys = data->addr;
> +		ima_kexec_buffer_size = data->size;
> +	}
> +	early_memunmap(data, sizeof(*data));
> +#else
> +	pr_warn("Passed IMA kexec data, but CONFIG_IMA not set. Ignoring.\n");
Is this warning message useful? Can we just inline (NOP) this function 
if CONFIG_IMA is not set?

> +#endif
> +}
> +
> +#if defined(CONFIG_IMA) && !defined(CONFIG_OF_FLATTREE)
> +int __meminit ima_free_kexec_buffer(void)
> +{
ima_free_kexec_buffer() should be invoked if the previous kernel had 
passed the IMA buffer (i.e., CONFIG_HAVE_IMA_KEXEC is set). 
CONFIG_HAVE_IMA_KEXEC would be set only if CONFIG_IMA is set. Is the 
above check still required?

thanks,
  -lakshmi

> +	int rc;
> +
> +	if (ima_kexec_buffer_size == 0)
> +		return -ENOENT;
> +
> +	rc = memblock_phys_free(ima_kexec_buffer_phys,
> +				ima_kexec_buffer_size);
> +	if (rc)
> +		return rc;
> +
> +	ima_kexec_buffer_phys = 0;
> +	ima_kexec_buffer_size = 0;
> +
> +	return 0;
> +}
> +
> +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	if (ima_kexec_buffer_size == 0)
> +		return -ENOENT;
> +
> +	*addr = __va(ima_kexec_buffer_phys);
> +	*size = ima_kexec_buffer_size;
> +
> +	return 0;
> +}
> +#endif
> +
>   static void __init parse_setup_data(void)
>   {
>   	struct setup_data *data;
> @@ -360,6 +419,9 @@ static void __init parse_setup_data(void)
>   		case SETUP_EFI:
>   			parse_efi_setup(pa_data, data_len);
>   			break;
> +		case SETUP_IMA:
> +			add_early_ima_buffer(pa_data);
> +			break;
>   		default:
>   			break;
>   		}
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index b9bd1cff1793..74fdd490f7c0 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -9,6 +9,7 @@
>    *  Copyright (C) 2016  IBM Corporation
>    */
>   
> +#include <linux/ima.h>
>   #include <linux/kernel.h>
>   #include <linux/kexec.h>
>   #include <linux/memblock.h>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 426b1744215e..ff4bd993e432 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -140,6 +140,11 @@ static inline int ima_measure_critical_data(const char *event_label,
>   
>   #endif /* CONFIG_IMA */
>   
> +#ifdef CONFIG_HAVE_IMA_KEXEC
> +int ima_free_kexec_buffer(void);
> +int ima_get_kexec_buffer(void **addr, size_t *size);
> +#endif
> +
>   #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
>   extern bool arch_ima_get_secureboot(void);
>   extern const char * const *arch_get_ima_policy(void);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 04971e85fbc9..c2f58d2e3a0e 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -441,8 +441,6 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>   				   unsigned long initrd_load_addr,
>   				   unsigned long initrd_len,
>   				   const char *cmdline, size_t extra_fdt_size);
> -int ima_get_kexec_buffer(void **addr, size_t *size);
> -int ima_free_kexec_buffer(void);
>   #else /* CONFIG_OF */
>   
>   static inline void of_core_init(void)
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 13753136f03f..419dc405c831 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -137,7 +137,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>   /*
>    * Restore the measurement list from the previous kernel.
>    */
> -void ima_load_kexec_buffer(void)
> +void __init ima_load_kexec_buffer(void)
>   {
>   	void *kexec_buffer = NULL;
>   	size_t kexec_buffer_size = 0;
