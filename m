Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEEF521286
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbiEJKuP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbiEJKuO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 06:50:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A39D1EEEA;
        Tue, 10 May 2022 03:46:16 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AED31EC06C1;
        Tue, 10 May 2022 12:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652179571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4DDOWWRV7Er4XCaVWMn1PqNM7w3NtFOcI3YkCzw/Dw8=;
        b=cE2x/If3bYFZbnhb+kryG298EjzsztVhLrtoy+q33SNqOnRXP4vyrlivpc4QpKa2jbz9r2
        f+iAsG+bAPMPYrDKDSEQ9mJaeFPy5eDYosSCNLPIjyNtGnO+1PLuO63UZaa2JrrtwoZX28
        svbNkIzVEfvDq9gl55aTMG83mtE5ubY=
Date:   Tue, 10 May 2022 12:46:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Message-ID: <YnpCeje+VXBVChhS@zn.tnic>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 26, 2022 at 04:52:49PM +0000, Jonathan McDowell wrote:
> Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.

I guess in your case

"x86/kexec: Carry ..."

> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index b25d3f82c2f3..2f7b138a9388 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -10,6 +10,7 @@
>  #define SETUP_EFI			4
>  #define SETUP_APPLE_PROPERTIES		5
>  #define SETUP_JAILHOUSE			6
> +#define SETUP_IMA			7

There's already

 #define SETUP_CC_BLOB                  7

in the tip tree - please redo your patch against current tip/master.

> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..cdc73e081585 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -186,6 +186,32 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  }
>  #endif /* CONFIG_EFI */
>  
> +#ifdef CONFIG_IMA_KEXEC
> +static void
> +setup_ima_state(const struct kimage *image, struct boot_params *params,

You can push that ugly ifdeffery inside the function like so:

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index cdc73e081585..47ba7083fd44 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -186,12 +186,12 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 }
 #endif /* CONFIG_EFI */
 
-#ifdef CONFIG_IMA_KEXEC
 static void
 setup_ima_state(const struct kimage *image, struct boot_params *params,
 		unsigned long params_load_addr,
 		unsigned int ima_setup_data_offset)
 {
+#ifdef CONFIG_IMA_KEXEC
 	struct setup_data *sd = (void *)params + ima_setup_data_offset;
 	struct ima_setup_data *ima = (void *)sd + sizeof(struct setup_data);
 	unsigned long setup_data_phys;
@@ -209,8 +209,8 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
 	setup_data_phys = params_load_addr + ima_setup_data_offset;
 	sd->next = params->hdr.setup_data;
 	params->hdr.setup_data = setup_data_phys;
-}
 #endif /* CONFIG_IMA_KEXEC */
+}
 
 static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
@@ -274,13 +274,11 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 			efi_setup_data_offset);
 #endif
 
-#ifdef CONFIG_IMA_KEXEC
 	/* Setup IMA log buffer state */
 	setup_ima_state(image, params, params_load_addr,
 			efi_setup_data_offset +
 			sizeof(struct setup_data) +
 			sizeof(struct efi_setup_data));
-#endif
 
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,

> +		unsigned long params_load_addr,
> +		unsigned int ima_setup_data_offset)
> +{
> +	struct setup_data *sd = (void *)params + ima_setup_data_offset;
> +	struct ima_setup_data *ima = (void *)sd + sizeof(struct setup_data);
> +	unsigned long setup_data_phys;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> +
> +	if (!image->ima_buffer_size)
> +		return;
> +
> +	sd->type = SETUP_IMA;
> +	sd->len = sizeof(*ima);
> +
> +	ima->addr = image->ima_buffer_addr;
> +	ima->size = image->ima_buffer_size;
> +
> +	/* Add setup data */
> +	setup_data_phys = params_load_addr + ima_setup_data_offset;
> +	sd->next = params->hdr.setup_data;
> +	params->hdr.setup_data = setup_data_phys;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
> +
>  static int
>  setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  		      unsigned long params_load_addr,
> @@ -247,6 +273,15 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>  			efi_setup_data_offset);
>  #endif
> +
> +#ifdef CONFIG_IMA_KEXEC
> +	/* Setup IMA log buffer state */
> +	setup_ima_state(image, params, params_load_addr,
> +			efi_setup_data_offset +
> +			sizeof(struct setup_data) +
> +			sizeof(struct efi_setup_data));
> +#endif
> +
>  	/* Setup EDD info */
>  	memcpy(params->eddbuf, boot_params.eddbuf,
>  				EDDMAXNR * sizeof(struct edd_info));
> @@ -401,7 +436,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
>  	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
>  				sizeof(struct setup_data) +
> -				sizeof(struct efi_setup_data);
> +				sizeof(struct efi_setup_data) +
> +				sizeof(struct setup_data) +
> +				sizeof(struct ima_setup_data);

Just because the EFI thing did it unconditionally, regardless of
CONFIG_EFI, you don't have to copy that sloppiness:

	unsigned long ima_buf_sz = 0;

	...

	if (IS_ENABLED(CONFIG_IMA_EXEC))
		ima_buf_sz = ...

	kbuf.bufsz = ... + ima_buf_sz);

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index c95b9ac5a457..8b0e7725f918 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -11,6 +11,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/dmi.h>
>  #include <linux/efi.h>
> +#include <linux/ima.h>
>  #include <linux/init_ohci1394_dma.h>
>  #include <linux/initrd.h>
>  #include <linux/iscsi_ibft.h>
> @@ -335,6 +336,28 @@ static void __init reserve_initrd(void)
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
>  
> +#ifdef CONFIG_IMA_KEXEC
> +static void __init add_early_ima_buffer(u64 phys_addr)
> +{
> +	struct ima_setup_data *data;
> +
> +	data = early_memremap(phys_addr + sizeof(struct setup_data),
> +			      sizeof(*data));
> +	if (!data) {
> +		pr_warn("setup: failed to memremap ima_setup_data entry\n");
> +		return;
> +	}
> +	memblock_reserve(data->addr, data->size);
> +	ima_set_kexec_buffer(data->addr, data->size);
> +	early_memunmap(data, sizeof(*data));
> +}
> +#else
> +static void __init add_early_ima_buffer(u64 phys_addr)
> +{
> +	pr_warn("Passed IMA kexec data, but CONFIG_IMA_KEXEC not set. Ignoring.\n");
> +}
> +#endif

ditto:

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 9324c30755c5..32403d693bf3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -336,9 +336,9 @@ static void __init reserve_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-#ifdef CONFIG_IMA_KEXEC
 static void __init add_early_ima_buffer(u64 phys_addr)
 {
+#ifdef CONFIG_IMA_KEXEC
        struct ima_setup_data *data;
 
        data = early_memremap(phys_addr + sizeof(struct setup_data),
@@ -350,13 +350,10 @@ static void __init add_early_ima_buffer(u64 phys_addr)
        memblock_reserve(data->addr, data->size);
        ima_set_kexec_buffer(data->addr, data->size);
        early_memunmap(data, sizeof(*data));
-}
 #else
-static void __init add_early_ima_buffer(u64 phys_addr)
-{
        pr_warn("Passed IMA kexec data, but CONFIG_IMA_KEXEC not set. Ignoring.\n");
-}
 #endif
+}
 
 static void __init parse_setup_data(void)
 {

> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 13753136f03f..419c50cfe6b9 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -10,6 +10,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
> +#include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/ima.h>
>  #include "ima.h"
> @@ -134,10 +135,66 @@ void ima_add_kexec_buffer(struct kimage *image)
>  }
>  #endif /* IMA_KEXEC */
>  
> +#ifndef CONFIG_OF
> +static phys_addr_t ima_early_kexec_buffer_phys;
> +static size_t ima_early_kexec_buffer_size;
> +
> +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> +{
> +	if (size == 0)
> +		return;
> +
> +	ima_early_kexec_buffer_phys = phys_addr;
> +	ima_early_kexec_buffer_size = size;
> +}
> +
> +int __init ima_free_kexec_buffer(void)

WARNING: modpost: vmlinux.o(.text+0xe4e785): Section mismatch in reference from the function ima_free_kexec_buffer() to the function .meminit.text:memblock_phys_free()
The function ima_free_kexec_buffer() references
the function __meminit memblock_phys_free().
This is often because ima_free_kexec_buffer lacks a __meminit 
annotation or the annotation of memblock_phys_free is wrong.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
