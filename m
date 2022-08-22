Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD34059C596
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Aug 2022 19:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbiHVR7b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Aug 2022 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiHVR73 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Aug 2022 13:59:29 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720013EA4;
        Mon, 22 Aug 2022 10:59:27 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id a133so5306035oif.4;
        Mon, 22 Aug 2022 10:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3TuVf54GgPydYoGd51XaXL3tfz0KadvwC9z8/Fy+sls=;
        b=3v9yCy+M1HSa7s5GrzJ8Yeolm2QsufS72EDOEKwiM/5m+3T58koxFY1E6VlV66oupy
         /wJVN9Kv6YUrdWzRFcVvrX60wtHr7WVMStkJ8cPH0zH5ipvzsqTDQbbq/DNxWu7gTFOG
         ui1OX96Jk2Bu6xlhyLdOovvGTzZa/U47Yt1Be5FEcHwPztKoVLZYyEC5r5FRg23xg0nO
         nO/ovHR8zw6yDKqyWoIBFgIpClc1t/W2EO5IVM7ecb847quRMtIf6TRF1q3YTLqfpqzE
         upuYQsk5SVxbMV95hLaP0RH/bojUOXBGUrYZqaIXgnCHNzU53pkDJKaRW+a8Hh43l6Le
         E/vg==
X-Gm-Message-State: ACgBeo2d+yV8qAE+6WGSdvVeOPi2HP1kOuFO+XZZHYBupT/GInO2Z9/m
        yBm/z6nM4CMc7e5tMeMLXA==
X-Google-Smtp-Source: AA6agR602WMERbYZ3uSCPQSQ/AhC9EWTsVLdvnnS5HXY696Jr8IN6ZBdolcGmNue7hlW5WqBeaMdnQ==
X-Received: by 2002:a05:6808:302b:b0:2f9:eeef:f03 with SMTP id ay43-20020a056808302b00b002f9eeef0f03mr11736503oib.128.1661191166666;
        Mon, 22 Aug 2022 10:59:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r11-20020a4a964b000000b0041b49c19a00sm2478019ooi.18.2022.08.22.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:59:26 -0700 (PDT)
Received: (nullmailer pid 62586 invoked by uid 1000);
        Mon, 22 Aug 2022 17:59:24 -0000
Date:   Mon, 22 Aug 2022 12:59:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, mpe@ellerman.id.au,
        devicetree@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        nayna@linux.ibm.com, nasastry@in.ibm.com,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 6/6] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <20220822175924.GA62553-robh@kernel.org>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220812164305.2056641-7-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812164305.2056641-7-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 12 Aug 2022 12:43:05 -0400, Stefan Berger wrote:
> The memory area of the TPM measurement log is currently not properly
> duplicated for carrying it across kexec when an Open Firmware
> Devicetree is used. Therefore, the contents of the log get corrupted.
> Fix this for the kexec_file_load() syscall by allocating a buffer and
> copying the contents of the existing log into it. The new buffer is
> preserved across the kexec and a pointer to it is available when the new
> kernel is started. To achieve this, store the allocated buffer's address
> in the flattened device tree (fdt) under the name linux,tpm-kexec-buffer
> and search for this entry early in the kernel startup before the TPM
> subsystem starts up. Adjust the pointer in the of-tree stored under
> linux,sml-base to point to this buffer holding the preserved log. The TPM
> driver can then read the base address from this entry when making the log
> available. Invalidate the log by removing 'linux,sml-base' from the
> devicetree if anything goes wrong with updating the buffer.
> 
> Use subsys_initcall() to call the function to restore the buffer even if
> the TPM subsystem or driver are not used. This allows the buffer to be
> carried across the next kexec without involvement of the TPM subsystem
> and ensures a valid buffer pointed to by the of-tree.
> 
> Use the subsys_initcall(), rather than an ealier initcall, since
> page_is_ram() in get_kexec_buffer() only starts working at this stage.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> 
> ---
> v6:
>  - Define prototype for tpm_add_kexec_buffer under same config options
>    as drivers/of/kexec.c is compiled, provide inline function otherwise.
>    (kernel test robot)
> 
> v4:
>  - Added #include <linux/vmalloc.h> due to parisc
>  - Use phys_addr_t for physical address rather than void *
>  - Remove linux,sml-base if the buffer cannot be updated after a kexec
>  - Added __init to functions where possible
> ---
>  drivers/of/kexec.c    | 216 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/kexec.h |   6 ++
>  include/linux/of.h    |   9 +-
>  kernel/kexec_file.c   |   6 ++
>  4 files changed, 234 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
