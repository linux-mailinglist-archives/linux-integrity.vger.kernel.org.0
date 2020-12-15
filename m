Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6C2DB381
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Dec 2020 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgLOSQt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Dec 2020 13:16:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40688 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgLOSQp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Dec 2020 13:16:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id j12so20296520ota.7;
        Tue, 15 Dec 2020 10:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qp1zv7HLJ1FFFDuet3N56fY6QoG3QMFA6pzxhnssSzM=;
        b=N5UV5AGnoSoR10Q6TzdH6fJgoLz5x0cOcg+JNEHWjGzE4+ZGVmmPumG1ZA6297LMtX
         f+ej+3qW9z2M0S7N2bgezEqOy+4XfCPEf+yDa8N/Ru9vVBYa9NCJC+7YZkNt0SrVPiv6
         q79LxwxvZk8n8GHN/aL/Z4h9U8/uv3dxpP2FqijhpVS2R4jASrdvHqxwPVkCQCzwiZhE
         AKoR3FMLRC4e4pelx0xAbVapJB+FBUoGYEvPuDfV7EoLHndSSjXgMSyypC5QT7YdIjp3
         unP0MS706LqD5/OBEKrezzd4daZ8eN5cN5/j4SBgjXdQNP9d36tK7PFFHd699cgFo4U1
         zh5Q==
X-Gm-Message-State: AOAM531Qo6U3MJfrBVH6txc1QeiTZS/s+epaEwp3lWubFbsCKrn4jkbc
        0sfx+Ihr2OHJna/fls6fEg==
X-Google-Smtp-Source: ABdhPJx7ZGAhIcT5tqcSF/ZtO334Ip1eQqY2cDQX5Y10pB47u8jzmOhVeEoWaywGRyiZwwNPpDX7gQ==
X-Received: by 2002:a9d:3e0d:: with SMTP id a13mr24547164otd.194.1608056163489;
        Tue, 15 Dec 2020 10:16:03 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t24sm4864456oou.4.2020.12.15.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:16:02 -0800 (PST)
Received: (nullmailer pid 4143024 invoked by uid 1000);
        Tue, 15 Dec 2020 18:16:01 -0000
Date:   Tue, 15 Dec 2020 12:16:01 -0600
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
Subject: Re: [PATCH v11 2/8] powerpc: Move ima buffer functions to
 drivers/of/kexec.c
Message-ID: <20201215181601.GA4105316@robh.at.kernel.org>
References: <20201214191854.9050-1-nramas@linux.microsoft.com>
 <20201214191854.9050-3-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214191854.9050-3-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 14, 2020 at 11:18:48AM -0800, Lakshmi Ramasubramanian wrote:
> The functions do_get_kexec_buffer() and get_addr_size_cells(),
> defined in arch/powerpc/kexec/ima.c, retrieve the address and size
> of the given property from the device tree blob. These functions do
> not have architecture specific code, but are currently limited to
> powerpc. do_get_kexec_buffer() correctly handles a device tree property
> that is a child node of the root node, but not anything other than
> the immediate root child nodes.
> 
> Move architecture independent functions get_ima_kexec_buffer() and
> get_root_addr_size_cells() to "drivers/of/kexec.c". These functions
> retrieve the chosen node "linux,ima-kexec-buffer" from the device tree,
> and return the address and size of the buffer used for carrying forward
> the IMA measurement log across kexec system call.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  drivers/of/kexec.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h |  3 ++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 66787be081fe..9af5371340b1 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -30,6 +30,10 @@
>  /**
>   * fdt_find_and_del_mem_rsv - delete memory reservation with given address and size
>   *
> + * @fdt: Flattened Device Tree to update
> + * @start: Starting address of the reservation to delete
> + * @size: Size of the reservation to delete
> + *

This belongs in the patch adding fdt_find_and_del_mem_rsv.

>   * Return: 0 on success, or negative errno on error.
>   */
>  static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned long size)
> @@ -226,3 +230,67 @@ int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
>  
>  	return 0;
>  }
> +
> +/**
> + * get_root_addr_size_cells - Get address and size of root node
> + *
> + * @addr_cells: Return address of the root node
> + * @size_cells: Return size of the root node
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int get_root_addr_size_cells(int *addr_cells, int *size_cells)
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
> + * get_ima_kexec_buffer - Get address and size of IMA kexec buffer
> + *
> + * @fdt: Flattened Device Tree
> + * @chosen_node: Offset of chosen node in the FDT
> + * @addr: Return address of the node
> + * @size: Return size of the node
> + *
> + * Return: 0 on success, or negative errno on error.
> + */
> +int get_ima_kexec_buffer(void *fdt, int chosen_node,
> +			 unsigned long *addr, size_t *size)
> +{
> +	const void *prop;
> +	int addr_cells, size_cells, prop_len;
> +	int rc;
> +
> +	rc = get_root_addr_size_cells(&addr_cells, &size_cells);
> +	if (rc)
> +		return rc;
> +
> +	if (fdt)
> +		prop = fdt_getprop(fdt, chosen_node,
> +				   "linux,ima-kexec-buffer", &prop_len);
> +	else
> +		prop = of_get_property(of_chosen,
> +				       "linux,ima-kexec-buffer", &prop_len);

This is an odd structure. The DT APIs are generally of_foo() for 
unflattened tree and of_flat_foo() for FDT.

> +
> +	if (!prop)
> +		return -ENOENT;
> +
> +	if (prop_len < 4 * (addr_cells + size_cells))
> +		return -EINVAL;
> +
> +	*addr = of_read_number(prop, addr_cells);
> +	*size = of_read_number(prop + 4 * addr_cells, size_cells);
> +
> +	return 0;
> +}
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 3375f5295875..fb2ef274135d 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -562,6 +562,9 @@ struct kimage;
>  int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
>  			   unsigned long initrd_load_addr, unsigned long initrd_len,
>  			   const char *cmdline);
> +int get_root_addr_size_cells(int *addr_cells, int *size_cells);
> +int get_ima_kexec_buffer(void *fdt, int chosen_node,
> +			 unsigned long *addr, size_t *size);

The whole point of moving code out of arch code was to avoid all these 
cross tree calls.

I was expecting the next step to be moving setup_ima_buffer() call into 
of_kexec_setup_new_fdt with all the code in powerpc/kexec/ima.c moved 
here. Then the end result to enable on arm64 is just selecting 
HAVE_IMA_KEXEC and adding fields to kimage_arch.

Rob
