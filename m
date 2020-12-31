Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178882E8236
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Dec 2020 23:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgLaW3R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Dec 2020 17:29:17 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:42296 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgLaW3R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Dec 2020 17:29:17 -0500
Received: by mail-io1-f41.google.com with SMTP id q137so18074414iod.9;
        Thu, 31 Dec 2020 14:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7NBsAO2KE+z+yQWJcX6vzv7SJGSJPPSWnCUrDbDsAc=;
        b=UOl/dDw3hMU/yzoUS2FxR2dH/EWwCgnkY030Z4ba1KcK+JU2Fw0Kdf/hzkJ9AswSyn
         niZqKS6AsvgwTdcfslRPcfEP2pT8g3yC9oRJwoRytra0TpDTOEzXRP0v2MBPJumQpmNE
         eX3pZqu08HM6d6cnqL3S33y5QRgBfMuKdyyyJB1rxxRffh9BiR9e6V7UsPsIeF25Lw9/
         W2HXM7he7kuxqDWjGeuHCf99/2Ke8/5SQkgPRFcOdKUGJG9VS0hPgrG4RFRFVJH5qXYm
         GMhQUlDOHF2wnq9mIsC2urp9f/U7LIum6LABme0NrT8XMIqA1IBc4LAWAGJPDSyZCtYe
         hg9g==
X-Gm-Message-State: AOAM5314ITHxKQBY4oERr2jgAWniTsCswiJNtIJ8TBfHNM9xPU2lqfAH
        A6rHVTDGwVta1UfpwLdKrg==
X-Google-Smtp-Source: ABdhPJwhVLrGlaHbOUaDZ0baiJlPdkJsY6FTy4vTxmvuPeyp0XbkRHPU3rq3aOTrVWLSJ3YmVHk9Mw==
X-Received: by 2002:a6b:8b88:: with SMTP id n130mr47758169iod.122.1609453716086;
        Thu, 31 Dec 2020 14:28:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q5sm33813004ilg.62.2020.12.31.14.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 14:28:35 -0800 (PST)
Received: (nullmailer pid 2489841 invoked by uid 1000);
        Thu, 31 Dec 2020 22:28:33 -0000
Date:   Thu, 31 Dec 2020 15:28:33 -0700
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
Message-ID: <20201231222833.GA2466706@robh.at.kernel.org>
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-3-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219175713.18888-3-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 19, 2020 at 09:57:09AM -0800, Lakshmi Ramasubramanian wrote:
> The functions defined in "arch/powerpc/kexec/ima.c" handle setting up
> and freeing the resources required to carry over the IMA measurement
> list from the current kernel to the next kernel across kexec system call.
> These functions do not have architecture specific code, but are
> currently limited to powerpc.
> 
> Move setup_ima_buffer() call into of_kexec_setup_new_fdt() defined in
> "drivers/of/kexec.c".
> 
> Move the remaining architecture independent functions from
> "arch/powerpc/kexec/ima.c" to "drivers/of/kexec.c".
> Delete "arch/powerpc/kexec/ima.c" and "arch/powerpc/include/asm/ima.h".
> Remove references to the deleted files in powerpc and in ima.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/ima.h     |  27 ----
>  arch/powerpc/kexec/Makefile        |   7 -
>  arch/powerpc/kexec/file_load.c     |   7 -
>  arch/powerpc/kexec/ima.c           | 202 -------------------------
>  drivers/of/kexec.c                 | 235 +++++++++++++++++++++++++++++
>  include/linux/of.h                 |   2 +
>  security/integrity/ima/ima.h       |   4 -
>  security/integrity/ima/ima_kexec.c |   1 +
>  8 files changed, 238 insertions(+), 247 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/ima.h
>  delete mode 100644 arch/powerpc/kexec/ima.c


> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 66787be081fe..33d97106f176 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/kexec.h>
> +#include <linux/memblock.h>
>  #include <linux/libfdt.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> @@ -59,6 +60,181 @@ static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned lon
>  	return -ENOENT;
>  }
>  
> +/**
> + * get_addr_size_cells - Get address and size of root node
> + *
> + * @addr_cells: Return address of the root node
> + * @size_cells: Return size of the root node
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +static int get_addr_size_cells(int *addr_cells, int *size_cells)
> +{
> +	struct device_node *root;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return -EINVAL;
> +
> +	*addr_cells = of_n_addr_cells(root);
> +	*size_cells = of_n_size_cells(root);
> +
> +	of_node_put(root);
> +
> +	return 0;
> +}
> +
> +/**
> + * do_get_kexec_buffer - Get address and size of device tree property
> + *
> + * @prop: Device tree property
> + * @len: Size of @prop
> + * @addr: Return address of the node
> + * @size: Return size of the node
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
> +			       size_t *size)
> +{
> +	int ret, addr_cells, size_cells;
> +
> +	ret = get_addr_size_cells(&addr_cells, &size_cells);
> +	if (ret)
> +		return ret;
> +
> +	if (len < 4 * (addr_cells + size_cells))
> +		return -ENOENT;
> +
> +	*addr = of_read_number(prop, addr_cells);
> +	*size = of_read_number(prop + 4 * addr_cells, size_cells);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_HAVE_IMA_KEXEC
> +/**
> + * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
> + *
> + * @fdt: Flattened Device Tree to update
> + * @chosen_node: Offset to the chosen node in the device tree
> + *
> + * The IMA measurement buffer is of no use to a subsequent kernel, so we always
> + * remove it from the device tree.
> + */
> +static void remove_ima_buffer(void *fdt, int chosen_node)
> +{
> +	int ret, len;
> +	unsigned long addr;
> +	size_t size;
> +	const void *prop;
> +

Should be able to do this instead of #ifdef:

if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
	return;

Otherwise, I think it looks good.

Rob
