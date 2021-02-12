Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82B3197EB
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhBLBSj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 20:18:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36180 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhBLBSi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 20:18:38 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3434B20B6C40;
        Thu, 11 Feb 2021 17:17:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3434B20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613092677;
        bh=Y7BtTH5ulPnacnf3FX5f0RFcRSYsD0USlFVkCyasTd4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gyo459klbjM84xwkX6PXkazK+7OzLyws3VPz679/pgnVlag/yYxfVMm7nXbGMrkcm
         tMcaGkes9he/hxnfLrRRLCNmuf6kZxit5kxbALc4vmgd+a1J78MYVjD93gERNjxLcM
         U979bY8a948Kz/YGiY2ldd16eUNbb2nnfsD1Ybms=
Subject: Re: [PATCH v17 02/10] of: Add a common kexec FDT setup function
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org, joe@perches.com,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-3-nramas@linux.microsoft.com>
 <87k0reozwh.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8a3aa3d2-2eba-549a-9970-a2b0fe3586c9@linux.microsoft.com>
Date:   Thu, 11 Feb 2021 17:17:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0reozwh.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/11/21 5:09 PM, Thiago Jung Bauermann wrote:
> 
> There's actually a complication that I just noticed and needs to be
> addressed. More below.
> 

<...>

>> +
>> +/*
>> + * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
>> + *
>> + * @image:		kexec image being loaded.
>> + * @initrd_load_addr:	Address where the next initrd will be loaded.
>> + * @initrd_len:		Size of the next initrd, or 0 if there will be none.
>> + * @cmdline:		Command line for the next kernel, or NULL if there will
>> + *			be none.
>> + *
>> + * Return: fdt on success, or NULL errno on error.
>> + */
>> +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>> +				   unsigned long initrd_load_addr,
>> +				   unsigned long initrd_len,
>> +				   const char *cmdline)
>> +{
>> +	void *fdt;
>> +	int ret, chosen_node;
>> +	const void *prop;
>> +	unsigned long fdt_size;
>> +
>> +	fdt_size = fdt_totalsize(initial_boot_params) +
>> +		   (cmdline ? strlen(cmdline) : 0) +
>> +		   FDT_EXTRA_SPACE;
> 
> Just adding 4 KB to initial_boot_params won't be enough for crash
> kernels on ppc64. The current powerpc code doubles the size of
> initial_boot_params (which is normally larger than 4 KB) and even that
> isn't enough. A patch was added to powerpc/next today which uses a more
> precise (but arch-specific) formula:
> 
> https://lore.kernel.org/linuxppc-dev/161243826811.119001.14083048209224609814.stgit@hbathini/
> 
> So I believe we need a hook here where architectures can provide their
> own specific calculation for the size of the fdt. Perhaps a weakly
> defined function providing a default implementation which an
> arch-specific file can override (a la arch_kexec_kernel_image_load())?
> 
> Then the powerpc specific hook would be the kexec_fdt_totalsize_ppc64()
> function from the patch I linked above.
> 

Do you think it'd better to add "fdt_size" parameter to 
of_kexec_alloc_and_setup_fdt() so that the caller can provide the 
desired FDT buffer size?

thanks,
  -lakshmi
