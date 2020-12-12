Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2382D873E
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 16:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439256AbgLLPW7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Dec 2020 10:22:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59074 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439255AbgLLPW7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Dec 2020 10:22:59 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4997020B717A;
        Sat, 12 Dec 2020 07:22:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4997020B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607786537;
        bh=BtIRQkWov9YJUVmerRIbFF7Rh3Yzt5VxVWb+6PFNe3o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W0yDY4BEiRN2lCJRoUEguoFZzDQk6PhmOHyom5/tu7Za1OkdqaxxNc3xN4yXIQp4N
         tAb5BelU2ivcIi0Uaa9pB1LM+iBdQaSvuqJP4fDzlEuLT0ymYeLivoymE8EwyNlO+Y
         3aiZFuzyd437g5yZkg+G0urm4VPL7bdMg7QT5K2M=
Subject: Re: [RFC PATCH 4/4] powerpc: Use common of_kexec_setup_new_fdt()
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
 <20201211221006.1052453-5-robh@kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c9501263-b97b-e715-fe7b-730ffee4bb3f@linux.microsoft.com>
Date:   Sat, 12 Dec 2020 07:22:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211221006.1052453-5-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/20 2:10 PM, Rob Herring wrote:
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> 
> After the IMA changes, delete_fdt_mem_rsv() can also be removed.
> 
>   arch/powerpc/kexec/file_load.c | 125 ++-------------------------------
>   1 file changed, 6 insertions(+), 119 deletions(-)
> 

This change looks good to me.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
> index e452b11df631..956bcb2d1ec2 100644
> --- a/arch/powerpc/kexec/file_load.c
> +++ b/arch/powerpc/kexec/file_load.c
> @@ -16,6 +16,7 @@
> 
>   #include <linux/slab.h>
>   #include <linux/kexec.h>
> +#include <linux/of.h>
>   #include <linux/of_fdt.h>
>   #include <linux/libfdt.h>
>   #include <asm/setup.h>
> @@ -156,132 +157,18 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
>   		  unsigned long initrd_load_addr, unsigned long initrd_len,
>   		  const char *cmdline)
>   {
> -	int ret, chosen_node;
> -	const void *prop;
> -
> -	/* Remove memory reservation for the current device tree. */
> -	ret = delete_fdt_mem_rsv(fdt, __pa(initial_boot_params),
> -				 fdt_totalsize(initial_boot_params));
> -	if (ret == 0)
> -		pr_debug("Removed old device tree reservation.\n");
> -	else if (ret != -ENOENT)
> -		return ret;
> -
> -	chosen_node = fdt_path_offset(fdt, "/chosen");
> -	if (chosen_node == -FDT_ERR_NOTFOUND) {
> -		chosen_node = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
> -					      "chosen");
> -		if (chosen_node < 0) {
> -			pr_err("Error creating /chosen.\n");
> -			return -EINVAL;
> -		}
> -	} else if (chosen_node < 0) {
> -		pr_err("Malformed device tree: error reading /chosen.\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Did we boot using an initrd? */
> -	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
> -	if (prop) {
> -		uint64_t tmp_start, tmp_end, tmp_size;
> -
> -		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
> -
> -		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
> -		if (!prop) {
> -			pr_err("Malformed device tree.\n");
> -			return -EINVAL;
> -		}
> -		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
> -
> -		/*
> -		 * kexec reserves exact initrd size, while firmware may
> -		 * reserve a multiple of PAGE_SIZE, so check for both.
> -		 */
> -		tmp_size = tmp_end - tmp_start;
> -		ret = delete_fdt_mem_rsv(fdt, tmp_start, tmp_size);
> -		if (ret == -ENOENT)
> -			ret = delete_fdt_mem_rsv(fdt, tmp_start,
> -						 round_up(tmp_size, PAGE_SIZE));
> -		if (ret == 0)
> -			pr_debug("Removed old initrd reservation.\n");
> -		else if (ret != -ENOENT)
> -			return ret;
> -
> -		/* If there's no new initrd, delete the old initrd's info. */
> -		if (initrd_len == 0) {
> -			ret = fdt_delprop(fdt, chosen_node,
> -					  "linux,initrd-start");
> -			if (ret) {
> -				pr_err("Error deleting linux,initrd-start.\n");
> -				return -EINVAL;
> -			}
> -
> -			ret = fdt_delprop(fdt, chosen_node, "linux,initrd-end");
> -			if (ret) {
> -				pr_err("Error deleting linux,initrd-end.\n");
> -				return -EINVAL;
> -			}
> -		}
> -	}
> -
> -	if (initrd_len) {
> -		ret = fdt_setprop_u64(fdt, chosen_node,
> -				      "linux,initrd-start",
> -				      initrd_load_addr);
> -		if (ret < 0)
> -			goto err;
> -
> -		/* initrd-end is the first address after the initrd image. */
> -		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-end",
> -				      initrd_load_addr + initrd_len);
> -		if (ret < 0)
> -			goto err;
> -
> -		ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
> -		if (ret) {
> -			pr_err("Error reserving initrd memory: %s\n",
> -			       fdt_strerror(ret));
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (cmdline != NULL) {
> -		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
> -		if (ret < 0)
> -			goto err;
> -	} else {
> -		ret = fdt_delprop(fdt, chosen_node, "bootargs");
> -		if (ret && ret != -FDT_ERR_NOTFOUND) {
> -			pr_err("Error deleting bootargs.\n");
> -			return -EINVAL;
> -		}
> -	}
> +	int ret;
> 
> -	if (image->type == KEXEC_TYPE_CRASH) {
> -		/*
> -		 * Avoid elfcorehdr from being stomped on in kdump kernel by
> -		 * setting up memory reserve map.
> -		 */
> -		ret = fdt_add_mem_rsv(fdt, image->arch.elf_headers_mem,
> -				      image->arch.elf_headers_sz);
> -		if (ret) {
> -			pr_err("Error reserving elfcorehdr memory: %s\n",
> -			       fdt_strerror(ret));
> -			goto err;
> -		}
> -	}
> +	ret = of_kexec_setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
> +	if (ret)
> +		goto err;
> 
> -	ret = setup_ima_buffer(image, fdt, chosen_node);
> +	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
>   	if (ret) {
>   		pr_err("Error setting up the new device tree.\n");
>   		return ret;
>   	}
> 
> -	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
> -	if (ret)
> -		goto err;
> -
>   	return 0;
> 
>   err:
> --
> 2.25.1
> 

