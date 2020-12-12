Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6892D873B
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439230AbgLLPVh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Dec 2020 10:21:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58858 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLLPVg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Dec 2020 10:21:36 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8676C20B717A;
        Sat, 12 Dec 2020 07:20:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8676C20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607786455;
        bh=De4rpOU7R3cbE0tgBHmdBeaCpxGO9h+TqzXJ25bLXU0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qp6NDi1/+kT4y61jN2rVY9no55vb/n4icGCopAQWuS6saUQ43bWnFH9QWLVOGwTQX
         yNtVAwGFsctW/yo0jBcsc8P4ToeUWNdQQfbLnpCmFVpwVNU5/Ao0VFuJU3aLbRxgvA
         /Bpm/oxpAuzEjQivPFlywVC3nsIs6eTDEpl01hvI=
Subject: Re: [RFC PATCH 3/4] arm64: Use common of_kexec_setup_new_fdt()
To:     Rob Herring <robh@kernel.org>, takahiro.akashi@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        zohar@linux.ibm.com, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20201211221006.1052453-1-robh@kernel.org>
 <20201211221006.1052453-4-robh@kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f0346242-2232-2c2a-a60f-316d4809ee5e@linux.microsoft.com>
Date:   Sat, 12 Dec 2020 07:20:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211221006.1052453-4-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/20 2:10 PM, Rob Herring wrote:
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   arch/arm64/kernel/machine_kexec_file.c | 123 +------------------------
>   1 file changed, 3 insertions(+), 120 deletions(-)
> 

This change looks good to me.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 5b0e67b93cdc..7de9c47dee7c 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -15,23 +15,12 @@
>   #include <linux/kexec.h>
>   #include <linux/libfdt.h>
>   #include <linux/memblock.h>
> +#include <linux/of.h>
>   #include <linux/of_fdt.h>
> -#include <linux/random.h>
>   #include <linux/slab.h>
>   #include <linux/string.h>
>   #include <linux/types.h>
>   #include <linux/vmalloc.h>
> -#include <asm/byteorder.h>
> -
> -/* relevant device tree properties */
> -#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
> -#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
> -#define FDT_PROP_INITRD_START	"linux,initrd-start"
> -#define FDT_PROP_INITRD_END	"linux,initrd-end"
> -#define FDT_PROP_BOOTARGS	"bootargs"
> -#define FDT_PROP_KASLR_SEED	"kaslr-seed"
> -#define FDT_PROP_RNG_SEED	"rng-seed"
> -#define RNG_SEED_SIZE		128
>   
>   const struct kexec_file_ops * const kexec_file_loaders[] = {
>   	&kexec_image_ops,
> @@ -50,112 +39,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>   	return kexec_image_post_load_cleanup_default(image);
>   }
>   
> -static int setup_dtb(struct kimage *image,
> -		     unsigned long initrd_load_addr, unsigned long initrd_len,
> -		     char *cmdline, void *dtb)
> -{
> -	int off, ret;
> -
> -	ret = fdt_path_offset(dtb, "/chosen");
> -	if (ret < 0)
> -		goto out;
> -
> -	off = ret;
> -
> -	ret = fdt_delprop(dtb, off, FDT_PROP_KEXEC_ELFHDR);
> -	if (ret && ret != -FDT_ERR_NOTFOUND)
> -		goto out;
> -	ret = fdt_delprop(dtb, off, FDT_PROP_MEM_RANGE);
> -	if (ret && ret != -FDT_ERR_NOTFOUND)
> -		goto out;
> -
> -	if (image->type == KEXEC_TYPE_CRASH) {
> -		/* add linux,elfcorehdr */
> -		ret = fdt_appendprop_addrrange(dtb, 0, off,
> -				FDT_PROP_KEXEC_ELFHDR,
> -				image->arch.elf_headers_mem,
> -				image->arch.elf_headers_sz);
> -		if (ret)
> -			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> -
> -		/* add linux,usable-memory-range */
> -		ret = fdt_appendprop_addrrange(dtb, 0, off,
> -				FDT_PROP_MEM_RANGE,
> -				crashk_res.start,
> -				crashk_res.end - crashk_res.start + 1);
> -		if (ret)
> -			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> -	}
> -
> -	/* add bootargs */
> -	if (cmdline) {
> -		ret = fdt_setprop_string(dtb, off, FDT_PROP_BOOTARGS, cmdline);
> -		if (ret)
> -			goto out;
> -	} else {
> -		ret = fdt_delprop(dtb, off, FDT_PROP_BOOTARGS);
> -		if (ret && (ret != -FDT_ERR_NOTFOUND))
> -			goto out;
> -	}
> -
> -	/* add initrd-* */
> -	if (initrd_load_addr) {
> -		ret = fdt_setprop_u64(dtb, off, FDT_PROP_INITRD_START,
> -				      initrd_load_addr);
> -		if (ret)
> -			goto out;
> -
> -		ret = fdt_setprop_u64(dtb, off, FDT_PROP_INITRD_END,
> -				      initrd_load_addr + initrd_len);
> -		if (ret)
> -			goto out;
> -	} else {
> -		ret = fdt_delprop(dtb, off, FDT_PROP_INITRD_START);
> -		if (ret && (ret != -FDT_ERR_NOTFOUND))
> -			goto out;
> -
> -		ret = fdt_delprop(dtb, off, FDT_PROP_INITRD_END);
> -		if (ret && (ret != -FDT_ERR_NOTFOUND))
> -			goto out;
> -	}
> -
> -	/* add kaslr-seed */
> -	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
> -	if (ret == -FDT_ERR_NOTFOUND)
> -		ret = 0;
> -	else if (ret)
> -		goto out;
> -
> -	if (rng_is_initialized()) {
> -		u64 seed = get_random_u64();
> -		ret = fdt_setprop_u64(dtb, off, FDT_PROP_KASLR_SEED, seed);
> -		if (ret)
> -			goto out;
> -	} else {
> -		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
> -				FDT_PROP_KASLR_SEED);
> -	}
> -
> -	/* add rng-seed */
> -	if (rng_is_initialized()) {
> -		void *rng_seed;
> -		ret = fdt_setprop_placeholder(dtb, off, FDT_PROP_RNG_SEED,
> -				RNG_SEED_SIZE, &rng_seed);
> -		if (ret)
> -			goto out;
> -		get_random_bytes(rng_seed, RNG_SEED_SIZE);
> -	} else {
> -		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
> -				FDT_PROP_RNG_SEED);
> -	}
> -
> -out:
> -	if (ret)
> -		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
> -
> -	return 0;
> -}
> -
>   /*
>    * More space needed so that we can add initrd, bootargs, kaslr-seed,
>    * rng-seed, userable-memory-range and elfcorehdr.
> @@ -185,8 +68,8 @@ static int create_dtb(struct kimage *image,
>   		if (ret)
>   			return -EINVAL;
>   
> -		ret = setup_dtb(image, initrd_load_addr, initrd_len,
> -				cmdline, buf);
> +		ret = of_kexec_setup_new_fdt(image, buf, initrd_load_addr,
> +					     initrd_len, cmdline);
>   		if (ret) {
>   			vfree(buf);
>   			if (ret == -ENOMEM) {
> 

