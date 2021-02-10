Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29AE316C6C
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 18:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhBJRVC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 12:21:02 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34750 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhBJRVB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 12:21:01 -0500
Received: by mail-oi1-f169.google.com with SMTP id i3so2872187oif.1;
        Wed, 10 Feb 2021 09:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PyHCqKSZ7LgiZ32rRV/p4xV7AmTvzAq1WHN+H1p4Y0U=;
        b=rqdaZqVn5iHfP3aEvJCIwZXDGzCezLC6C2E86OPK+pF+IkkpihklrBwb0K7py5qeKj
         j4ZHvbUMyKmPs3wQvu/CgNn1AIPbth8e2SqI3qy/t4Iot6SLN/urhhEZcUt0/lw5m4T9
         tAcP3qwwieQdPMsrMUomsSxsFoz9VRcGKY68Q49ABUcY2NQNFr1szbD1pW84FzW1B02M
         n2uDyrAuzJEYp2DANkbmMwpMWlQuW7VM8fIbq1n/mr6NG9TW5i4dC8lppVMc9zQpW2td
         NybYBIYfsNkvcH3IEWg/1/4ngpyolv696UFBOTBrO8ITWuJDjmvL9CqUSxEGviY/OGN/
         xxqQ==
X-Gm-Message-State: AOAM530wk+HRwxBgWDN0GCE3099gTFMFkmZt2XxfiU563TQnxxl55rO+
        NvDd13DfA/gZ/xgCSOq7tg==
X-Google-Smtp-Source: ABdhPJyB/NGA2/hTE5nTz1gzWgZOyECIvUaOtJm511egF+I5ViAeiURWzn7lJaRvMq7DAnkf2GQHpQ==
X-Received: by 2002:aca:554d:: with SMTP id j74mr2851552oib.96.1612977621768;
        Wed, 10 Feb 2021 09:20:21 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s189sm561858oif.19.2021.02.10.09.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:20:20 -0800 (PST)
Received: (nullmailer pid 2370413 invoked by uid 1000);
        Wed, 10 Feb 2021 17:20:18 -0000
Date:   Wed, 10 Feb 2021 11:20:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v17 05/10] powerpc: Move ima buffer fields to struct
 kimage
Message-ID: <20210210172018.GA2361245@robh.at.kernel.org>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-6-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209182200.30606-6-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 09, 2021 at 10:21:55AM -0800, Lakshmi Ramasubramanian wrote:
> The fields ima_buffer_addr and ima_buffer_size in "struct kimage_arch"
> for powerpc are used to carry forward the IMA measurement list across
> kexec system call.  These fields are not architecture specific, but are
> currently limited to powerpc.
> 
> arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
> sets ima_buffer_addr and ima_buffer_size for the kexec system call.
> This function does not have architecture specific code, but is
> currently limited to powerpc.
> 
> Move ima_buffer_addr and ima_buffer_size to "struct kimage".
> Rename arch_ima_add_kexec_buffer() to of_ima_add_kexec_buffer()
> and move it in drivers/of/kexec.c.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Will Deacon <will@kernel.org>
> ---
>  arch/powerpc/include/asm/ima.h     |  3 ---
>  arch/powerpc/include/asm/kexec.h   |  5 -----
>  arch/powerpc/kexec/ima.c           | 29 ++++++-----------------------
>  drivers/of/kexec.c                 | 23 +++++++++++++++++++++++
>  include/linux/kexec.h              |  3 +++
>  include/linux/of.h                 |  5 +++++
>  security/integrity/ima/ima_kexec.c |  3 ++-
>  7 files changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
> index ead488cf3981..51f64fd06c19 100644
> --- a/arch/powerpc/include/asm/ima.h
> +++ b/arch/powerpc/include/asm/ima.h
> @@ -14,9 +14,6 @@ static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
>  #endif
>  
>  #ifdef CONFIG_IMA_KEXEC
> -int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> -			      size_t size);
> -
>  int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
>  #else
>  static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index bdd0ddb9ac4d..ecf88533d6b4 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -112,11 +112,6 @@ struct kimage_arch {
>  	unsigned long elf_headers_sz;
>  	void *elf_headers;
>  	void *fdt;
> -
> -#ifdef CONFIG_IMA_KEXEC
> -	phys_addr_t ima_buffer_addr;
> -	size_t ima_buffer_size;
> -#endif
>  };
>  
>  char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
> diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
> index 720e50e490b6..ed38125e2f87 100644
> --- a/arch/powerpc/kexec/ima.c
> +++ b/arch/powerpc/kexec/ima.c
> @@ -128,23 +128,6 @@ void remove_ima_buffer(void *fdt, int chosen_node)
>  }
>  
>  #ifdef CONFIG_IMA_KEXEC
> -/**
> - * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
> - *
> - * Architectures should use this function to pass on the IMA buffer
> - * information to the next kernel.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> -			      size_t size)
> -{
> -	image->arch.ima_buffer_addr = load_addr;
> -	image->arch.ima_buffer_size = size;
> -
> -	return 0;
> -}
> -
>  static int write_number(void *p, u64 value, int cells)
>  {
>  	if (cells == 1) {
> @@ -180,7 +163,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>  	u8 value[16];
>  
>  	remove_ima_buffer(fdt, chosen_node);
> -	if (!image->arch.ima_buffer_size)
> +	if (!image->ima_buffer_size)
>  		return 0;
>  
>  	ret = get_addr_size_cells(&addr_cells, &size_cells);
> @@ -192,11 +175,11 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>  	if (entry_size > sizeof(value))
>  		return -EINVAL;
>  
> -	ret = write_number(value, image->arch.ima_buffer_addr, addr_cells);
> +	ret = write_number(value, image->ima_buffer_addr, addr_cells);
>  	if (ret)
>  		return ret;
>  
> -	ret = write_number(value + 4 * addr_cells, image->arch.ima_buffer_size,
> +	ret = write_number(value + 4 * addr_cells, image->ima_buffer_size,
>  			   size_cells);
>  	if (ret)
>  		return ret;
> @@ -206,13 +189,13 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
> -			      image->arch.ima_buffer_size);
> +	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
> +			      image->ima_buffer_size);
>  	if (ret)
>  		return -EINVAL;
>  
>  	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
> -		 image->arch.ima_buffer_addr, image->arch.ima_buffer_size);
> +		 image->ima_buffer_addr, image->ima_buffer_size);
>  
>  	return 0;
>  }
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 469e09613cdd..9f33d215b9f2 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -63,6 +63,29 @@ static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned lon
>  	return -ENOENT;
>  }
>  
> +#ifdef CONFIG_IMA_KEXEC
> +/**
> + * of_ima_add_kexec_buffer - Add IMA buffer for next kernel
> + *
> + * @image: kimage struct to set IMA buffer data
> + * @load_addr: Starting address where IMA buffer is loaded at
> + * @size: Number of bytes in the IMA buffer
> + *
> + * Use this function to pass on the IMA buffer information to
> + * the next kernel across kexec system call.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int of_ima_add_kexec_buffer(struct kimage *image,
> +			    unsigned long load_addr, size_t size)
> +{
> +	image->ima_buffer_addr = load_addr;
> +	image->ima_buffer_size = size;
> +

There's nothing DT specific about this function, so this is the wrong 
place for it. I would just remove it and directly set the members.

Rob
