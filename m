Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FCF306154
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 17:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhA0Qw7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 11:52:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232813AbhA0Qw6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 11:52:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4121064D99;
        Wed, 27 Jan 2021 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611766337;
        bh=TPAwVwylMOwu7ugV8ihGQhafwnssH7CpBZ1z8+IAFxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7/znJdaXqb5IGKBd/MWJB1ehL8MRYbSdZ7sX3+oqdh1pWrdtxgvq24MUB/zJZu72
         brlpD1+m24CV3uzGmPoWkkOfvqa5mvlbOv9lwQfRFYuHchVe9E+JDvxNsMx/D0lrNA
         LdQ6ZNeZZ0YDjI2VSQQUgb8tU+KZZpvWHStkMfMyKT13yEWksRWKe01bh6TFbozCMv
         yAp3XDc0lu+QLBBVx90w/Lwnnehc9VcfBdEkEuWHl8J4Vk+rxyFZLTcWZrYjip3UF6
         8nBOV0N8fDx2Jmehpa141jGcrASzYN2l7FliDykcwRcRvpeCH1LvdpXHYE4k5S2ccg
         EcQB/4Sp7K3LA==
Date:   Wed, 27 Jan 2021 16:52:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
Message-ID: <20210127165208.GA358@willie-the-truck>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115173017.30617-10-nramas@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 15, 2021 at 09:30:16AM -0800, Lakshmi Ramasubramanian wrote:
> create_dtb() function allocates kernel virtual memory for
> the device tree blob (DTB).  This is not consistent with other
> architectures, such as powerpc, which calls kmalloc() for allocating
> memory for the DTB.
> 
> Call kmalloc() to allocate memory for the DTB, and kfree() to free
> the allocated memory.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 7de9c47dee7c..51c40143d6fa 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
>  
>  int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  {
> -	vfree(image->arch.dtb);
> +	kfree(image->arch.dtb);
>  	image->arch.dtb = NULL;
>  
>  	vfree(image->arch.elf_headers);
> @@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
>  			+ cmdline_len + DTB_EXTRA_SPACE;
>  
>  	for (;;) {
> -		buf = vmalloc(buf_size);
> +		buf = kmalloc(buf_size, GFP_KERNEL);

Is there a functional need for this patch? I build the 'dtbs' target just
now and sdm845-db845c.dtb is approaching 100K, which feels quite large
for kmalloc().

Will
