Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE3320F22
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 02:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhBVBc7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 20:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhBVBcu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 20:32:50 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD042C061574;
        Sun, 21 Feb 2021 17:32:09 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id b8so10579330oti.7;
        Sun, 21 Feb 2021 17:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=urSTMy9t6cTiTrhHbL96lNEFLr5gM8etKvvG8YybOtM=;
        b=RiKpsUd2eg9pq2eKx9PgQDgKlS6S2TMP1cA6OmvM+0aHJN1D+Fxatx7zLPScl4ZvP1
         z0qfvtLpR+HDDilB8prIpl46msQycXNibiUYYCf1kto7cDyfvgtxVKRI9ZSyyvcl3ZKp
         6JBAGiAbBDBlaRu8DbGbpHN8pvSQ+rk81NktKSs/nBI+1M2aoBpkxjSBIkaFd8An7F12
         tFHljIX96wMyJpDhZO9594jJ13VQxiZjSjSnv1IBAor0PzRNmhjg0BWxLWZkBRd06PFD
         K7d/0XsrGKDw2UK+ViumxfVoK96HtpH/Sdl+TJkEgMQC8MGj+XmO3FBglsLneyIIE6YI
         G1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=urSTMy9t6cTiTrhHbL96lNEFLr5gM8etKvvG8YybOtM=;
        b=sw6ysVdaGbfgS712zmMMhIkQvcfw6UlNftu9cxfaPJnmbdJ8jX1DLDjIcXQs/jnsMu
         nIWVP/kLYmomMJ7QQQ9nEXOUT8FJKDg2OGxO+O0Y5atqtpENlzAhzLGZEoZLoKvYAaLU
         LlbSRP/NY3m8RZ+8rKGReN+HOEGLUN2z138julAg7irtMwLoquHGWVrF5s6gqeYNEuQl
         lhgQkKIxy0f3G8vzRsxl3XCSBRn+sE40Fig3HDJJ5ukCXDqM95qV6dcsUBk5MY5UjrFt
         l3P9ollg6GmzCesLPMwLFrWFdFvJkciCmFXGzWtb+c3WxdnFC+o3xr1BNb68KsLAavOI
         xzDw==
X-Gm-Message-State: AOAM531RoCByz7gUfAj9L/Ptdy52uhnqmkLcbd1BnNIk0bt8Auwc8BTg
        x95N4NxvxvODp8LEpMXBdqk=
X-Google-Smtp-Source: ABdhPJy9/ek5tQDmOCC4jipCZCItMiaiSmbk31Qp56NGSfXHrJmQjQYbxDtf5G5zBFDY1OH+xstrXg==
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr1142078ots.194.1613957529125;
        Sun, 21 Feb 2021 17:32:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3sm1046484otf.22.2021.02.21.17.32.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Feb 2021 17:32:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 21 Feb 2021 17:32:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, mark.rutland@arm.com, benh@kernel.crashing.org,
        tao.li@vivo.com, paulus@samba.org, vincenzo.frascino@arm.com,
        frowand.list@gmail.com, sashal@kernel.org, masahiroy@kernel.org,
        jmorris@namei.org, allison@lohutok.net, serge@hallyn.com,
        devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
        prsriva@linux.microsoft.com, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
        mbrugger@suse.com, balajib@linux.microsoft.com,
        dmitry.kasatkin@gmail.com, linux-kernel@vger.kernel.org,
        james.morse@arm.com, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v18 03/11] of: Add a common kexec FDT setup function
Message-ID: <20210222013207.GA142216@roeck-us.net>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
 <20210213161049.6190-4-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213161049.6190-4-nramas@linux.microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 13, 2021 at 08:10:41AM -0800, Lakshmi Ramasubramanian wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Both arm64 and powerpc do essentially the same FDT /chosen setup for
> kexec.  The differences are either omissions that arm64 should have
> or additional properties that will be ignored.  The setup code can be
> combined and shared by both powerpc and arm64.
> 
> The differences relative to the arm64 version:
>  - If /chosen doesn't exist, it will be created (should never happen).
>  - Any old dtb and initrd reserved memory will be released.
>  - The new initrd and elfcorehdr are marked reserved.
>  - "linux,booted-from-kexec" is set.
> 
> The differences relative to the powerpc version:
>  - "kaslr-seed" and "rng-seed" may be set.
>  - "linux,elfcorehdr" is set.
>  - Any existing "linux,usable-memory-range" is removed.
> 
> Combine the code for setting up the /chosen node in the FDT and updating
> the memory reservation for kexec, for powerpc and arm64, in
> of_kexec_alloc_and_setup_fdt() and move it to "drivers/of/kexec.c".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

s390:allmodconfig:

drivers/of/kexec.c: In function 'of_kexec_alloc_and_setup_fdt':
drivers/of/kexec.c:378:10: error: 'const struct kimage' has no member named 'arch'
  378 |     image->arch.elf_load_addr,
      |          ^~
drivers/of/kexec.c:379:10: error: 'const struct kimage' has no member named 'arch'
  379 |     image->arch.elf_headers_sz);
      |          ^~
drivers/of/kexec.c:387:35: error: 'const struct kimage' has no member named 'arch'
  387 |   ret = fdt_add_mem_rsv(fdt, image->arch.elf_load_addr,
      |                                   ^~
drivers/of/kexec.c:388:16: error: 'const struct kimage' has no member named 'arch'
  388 |           image->arch.elf_headers_sz);
      |                ^~

Guenter
