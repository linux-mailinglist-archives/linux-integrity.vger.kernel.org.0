Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E932D83A8
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Dec 2020 01:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437922AbgLLAy5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 19:54:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33700 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437926AbgLLAy4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 19:54:56 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7B8120B717A;
        Fri, 11 Dec 2020 16:54:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7B8120B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607734455;
        bh=ZTM/idn6P5IEpBxe4MiiCDIuG4Mf+65/Gf6iGB0ePnY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OT4GD6X6FzrliU2c+Z2miKvd634vRVb61q6tWwzQkew6S/0uDgSxQ7oO8gY7XKyiV
         qhFcZIT0vSMInz54g2JcrCGsBCozLc3oFBwAIIBB6w3RKtCsXfMQ0NIue2GhdyTfSa
         OvMSn5Q9fCDGKvtjpWWk2KkIXJW9z59Lbxtta5r0=
Subject: Re: [RFC PATCH 1/4] powerpc: Rename kexec elfcorehdr_addr to
 elf_headers_mem
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
 <20201211221006.1052453-2-robh@kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <39d0e68e-12f2-ddd0-4010-bb0ec216ac5d@linux.microsoft.com>
Date:   Fri, 11 Dec 2020 16:54:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211221006.1052453-2-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/20 2:10 PM, Rob Herring wrote:

Hi Rob,

> Align with arm64 name so common code can use it.

As you'd stated in the cover letter, a better patch description would be 
good to have here.

Code changes look good to me.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

thanks,
  -lakshmi

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   arch/powerpc/include/asm/kexec.h  | 2 +-
>   arch/powerpc/kexec/file_load.c    | 4 ++--
>   arch/powerpc/kexec/file_load_64.c | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 55d6ede30c19..dbf09d2f36d0 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -108,7 +108,7 @@ struct kimage_arch {
>   	unsigned long backup_start;
>   	void *backup_buf;
>   
> -	unsigned long elfcorehdr_addr;
> +	unsigned long elf_headers_mem;
>   	unsigned long elf_headers_sz;
>   	void *elf_headers;
>   
> diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
> index 9a232bc36c8f..e452b11df631 100644
> --- a/arch/powerpc/kexec/file_load.c
> +++ b/arch/powerpc/kexec/file_load.c
> @@ -45,7 +45,7 @@ char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>   		return NULL;
>   
>   	elfcorehdr_strlen = sprintf(cmdline_ptr, "elfcorehdr=0x%lx ",
> -				    image->arch.elfcorehdr_addr);
> +				    image->arch.elf_headers_mem);
>   
>   	if (elfcorehdr_strlen + cmdline_len > COMMAND_LINE_SIZE) {
>   		pr_err("Appending elfcorehdr=<addr> exceeds cmdline size\n");
> @@ -263,7 +263,7 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
>   		 * Avoid elfcorehdr from being stomped on in kdump kernel by
>   		 * setting up memory reserve map.
>   		 */
> -		ret = fdt_add_mem_rsv(fdt, image->arch.elfcorehdr_addr,
> +		ret = fdt_add_mem_rsv(fdt, image->arch.elf_headers_mem,
>   				      image->arch.elf_headers_sz);
>   		if (ret) {
>   			pr_err("Error reserving elfcorehdr memory: %s\n",
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index c69bcf9b547a..a05c19b3cc60 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -815,7 +815,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
>   		goto out;
>   	}
>   
> -	image->arch.elfcorehdr_addr = kbuf->mem;
> +	image->arch.elf_headers_mem = kbuf->mem;
>   	image->arch.elf_headers_sz = headers_sz;
>   	image->arch.elf_headers = headers;
>   out:
> @@ -851,7 +851,7 @@ int load_crashdump_segments_ppc64(struct kimage *image,
>   		return ret;
>   	}
>   	pr_debug("Loaded elf core header at 0x%lx, bufsz=0x%lx memsz=0x%lx\n",
> -		 image->arch.elfcorehdr_addr, kbuf->bufsz, kbuf->memsz);
> +		 image->arch.elf_headers_mem, kbuf->bufsz, kbuf->memsz);
>   
>   	return 0;
>   }
> 

