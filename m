Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10150E5DC
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Apr 2022 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiDYQdO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Apr 2022 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiDYQdM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Apr 2022 12:33:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF313F07;
        Mon, 25 Apr 2022 09:30:07 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PEhvwi009798;
        Mon, 25 Apr 2022 16:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=r4qkiLwhya5oWZXoi5ouFooIYkto4KiJzfBMS5CvVYM=;
 b=H3hq947eLC+CFFdD35aKY0hERPS+HEmVriGh1o8Cf8MuVy6P8ziyl9cksWwKUWzswkz4
 FzGGj/O993TdLOuutE1C9j7WNJFvc/yPhmXj5NHRL5GglpjQs6pp/WMvM189cfc3ukoj
 d98Nw16kYpRTNGiB2Wd+btFImlPExKvcXoTd8rFpq4azXYsdYrlOva6Zpy1OkWaeLnvy
 6U+TCrkS+KM7Q0KT4uWGoREo1pXp97QhFC5sD3b74h8Z3P+AbM5L9J2FqmUhRWqa5aYJ
 e1ZR7KwXrn8rvV6otwQvCNCVThVNkD8XeYz5wT2bTQzgbPmWHDPtyT/mGmjxf/MewGb+ bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnwng2mgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 16:29:39 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23PFKJPY014482;
        Mon, 25 Apr 2022 16:29:39 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnwng2mg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 16:29:39 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PGIeo1016077;
        Mon, 25 Apr 2022 16:29:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3fm938t6dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 16:29:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PGTYFu45810120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 16:29:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9E8E42041;
        Mon, 25 Apr 2022 16:29:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBF644203F;
        Mon, 25 Apr 2022 16:29:32 +0000 (GMT)
Received: from sig-9-65-74-143.ibm.com (unknown [9.65.74.143])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 16:29:32 +0000 (GMT)
Message-ID: <12108732c287a85a417927de37cb027cefae6e06.camel@linux.ibm.com>
Subject: Re: [PATCH] Carry forward IMA measurement log on kexec on x86_64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Mon, 25 Apr 2022 12:29:17 -0400
In-Reply-To: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4FwVakIQWg86GLLMMxT-Ze_t5LsdqQFz
X-Proofpoint-ORIG-GUID: 9JPt9lCb21sjsaUK0mdH3MYBGlCHKxiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_08,2022-04-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jonathan,

On Fri, 2022-04-22 at 13:50 +0000, Jonathan McDowell wrote:
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
> device tree, so the IMA infrastructure is extended to allow non device
> tree platforms to provide a log buffer. x86 then passes the IMA buffer
> to the new kernel via the setup_data mechanism.
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>

FYI, after applying, building, and booting a kernel with this patch,
"kexec -s -l /boot/vmlinuz-5.18.0-rc4+ --reuse-cmdline --
initrd=/boot/initramfs-5.18.0-rc4+.img" properly loads the kernel, but
"kexec -s -e" fails to reboot, at least on a test laptop even with only
the "boot_aggregate" measurement record.

Without enabling CONFIG_IMA_KEXEC, kexec boots properly.

thanks,

Mimi

> ---
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/include/uapi/asm/bootparam.h |  9 ++++
>  arch/x86/kernel/e820.c                |  6 +--
>  arch/x86/kernel/kexec-bzimage64.c     | 37 ++++++++++++++++-
>  arch/x86/kernel/setup.c               | 26 ++++++++++++
>  include/linux/ima.h                   |  1 +
>  security/integrity/ima/ima_kexec.c    | 59 ++++++++++++++++++++++++++-
>  7 files changed, 134 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b0142e01002e..bde4959d9bdc 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2017,6 +2017,7 @@ config KEXEC_FILE
>  	bool "kexec file based system call"
>  	select KEXEC_CORE
>  	select BUILD_BIN2C
> +	select HAVE_IMA_KEXEC if IMA
>  	depends on X86_64
>  	depends on CRYPTO=y
>  	depends on CRYPTO_SHA256=y
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index b25d3f82c2f3..2f7b138a9388 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -10,6 +10,7 @@
>  #define SETUP_EFI			4
>  #define SETUP_APPLE_PROPERTIES		5
>  #define SETUP_JAILHOUSE			6
> +#define SETUP_IMA			7
>  
>  #define SETUP_INDIRECT			(1<<31)
>  
> @@ -171,6 +172,14 @@ struct jailhouse_setup_data {
>  	} __attribute__((packed)) v2;
>  } __attribute__((packed));
>  
> +/*
> + * IMA buffer setup data information from the previous kernel during kexec
> + */
> +struct ima_setup_data {
> +	__u64 addr;
> +	__u64 size;
> +} __attribute__((packed));
> +
>  /* The so-called "zeropage" */
>  struct boot_params {
>  	struct screen_info screen_info;			/* 0x000 */
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index f267205f2d5a..9dac24680ff8 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1017,10 +1017,10 @@ void __init e820__reserve_setup_data(void)
>  		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>  
>  		/*
> -		 * SETUP_EFI is supplied by kexec and does not need to be
> -		 * reserved.
> +		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> +		 * to be reserved.
>  		 */
> -		if (data->type != SETUP_EFI)
> +		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
>  			e820__range_update_kexec(pa_data,
>  						 sizeof(*data) + data->len,
>  						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..07625da33075 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -186,6 +186,32 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  }
>  #endif /* CONFIG_EFI */
>  
> +#ifdef CONFIG_IMA_KEXEC
> +static void
> +setup_ima_state(const struct kimage *image, struct boot_params *params,
> +		unsigned long params_load_addr,
> +		unsigned int ima_setup_data_offset)
> +{
> +	struct setup_data *sd = (void *)params + ima_setup_data_offset;
> +	struct ima_setup_data *ima = (void *)sd + sizeof(struct setup_data);
> +	unsigned long setup_data_phys;
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
> @@ -247,6 +273,13 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>  			efi_setup_data_offset);
>  #endif
> +
> +#ifdef CONFIG_IMA_KEXEC
> +	/* Setup IMA log buffer state */
> +	setup_ima_state(image, params, params_load_addr,
> +			efi_setup_data_offset + ALIGN(efi_map_sz, 16) + sizeof(struct setup_data));
> +#endif
> +
>  	/* Setup EDD info */
>  	memcpy(params->eddbuf, boot_params.eddbuf,
>  				EDDMAXNR * sizeof(struct edd_info));
> @@ -401,7 +434,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
>  	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
>  				sizeof(struct setup_data) +
> -				sizeof(struct efi_setup_data);
> +				sizeof(struct efi_setup_data) +
> +				sizeof(struct setup_data) +
> +				sizeof(struct ima_setup_data);
>  
>  	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
>  	if (!params)
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
> +
>  static void __init parse_setup_data(void)
>  {
>  	struct setup_data *data;
> @@ -360,6 +383,9 @@ static void __init parse_setup_data(void)
>  		case SETUP_EFI:
>  			parse_efi_setup(pa_data, data_len);
>  			break;
> +		case SETUP_IMA:
> +			add_early_ima_buffer(pa_data);
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 426b1744215e..f58aed7acad4 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -48,6 +48,7 @@ static inline void ima_appraise_parse_cmdline(void) {}
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size);
>  #endif
>  
>  #else
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
> +{
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -ENOTSUPP;
> +
> +	if (ima_early_kexec_buffer_size == 0)
> +		return -ENOENT;
> +
> +	rc = memblock_phys_free(ima_early_kexec_buffer_phys,
> +				ima_early_kexec_buffer_size);
> +	if (rc)
> +		return rc;
> +
> +	ima_early_kexec_buffer_phys = 0;
> +	ima_early_kexec_buffer_size = 0;
> +
> +	return 0;
> +}
> +
> +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> +{
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +		return -ENOTSUPP;
> +
> +	if (ima_early_kexec_buffer_size == 0)
> +		return -ENOENT;
> +
> +	*addr = __va(ima_early_kexec_buffer_phys);
> +	*size = ima_early_kexec_buffer_size;
> +
> +	return 0;
> +}
> +
> +#else
> +
> +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> +{
> +	pr_warn("CONFIG_OF enabled, ignoring call to set buffer details.\n");
> +}
> +#endif /* CONFIG_OF */
> +
>  /*
>   * Restore the measurement list from the previous kernel.
>   */
> -void ima_load_kexec_buffer(void)
> +void __init ima_load_kexec_buffer(void)
>  {
>  	void *kexec_buffer = NULL;
>  	size_t kexec_buffer_size = 0;


