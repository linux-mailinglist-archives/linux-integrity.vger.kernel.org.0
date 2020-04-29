Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319671BE717
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2020 21:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD2TPV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Apr 2020 15:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726974AbgD2TPT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Apr 2020 15:15:19 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE508C035495
        for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2020 12:15:18 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s63so3235233qke.4
        for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2020 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L70Lu4UkPRTEDG8gb+/xmKCe8SzfFhoJnEpRxIIeFqA=;
        b=fpYAIUKFWTtRbiyM00izT/fFtpEEUzzgAYX5RWTjg6k+9hsakDXW2+39f1p9s/drqy
         cNHLDJHD57SLl6tsqIW7ArxiFPoeu/a0Ra9+ALQObhnkHGNBwnE64zPrlMbwAr5X4zDj
         qgJSr0Tne+KAeZ6wNQhflV7sQ5VmHGcUwqKVt+nZmYRCloY95EPGzlqvZz+aQ4eUtzGn
         TPz/jx9BhYi0twCyopSjoG6jJrCz8B78PntvIg+4pCXYaIoKJK023np7U+orRedWeDoT
         y1kHSDkcjfMO58BpdelMoRPh4zhq9WiB1PRrX+2ZxgGyrz5lxlEwQKfhY1s9fIR6B4tM
         U1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L70Lu4UkPRTEDG8gb+/xmKCe8SzfFhoJnEpRxIIeFqA=;
        b=OnMgWjsuDZ1vXS5kgmGmdjnW644fLJw5r2hWwcbomYOfTvRFX3F7z7jOCQUkBnwqor
         +k5AM14GfUafwQE9xhWl2BKjOhP/J4WxenMO/w5Gi6Jm1BAWPYSoPAhe/0m8np+lq9Ga
         S0Hr58UnJkrLE9xvIBrT+do0irB5xXrQmUbBUJt5li/SDqRAnTU4/+QaBTtSj/ALzq8S
         paV8uXlYXa+Z4pLELsb4WUhDHesT3AZ189SIUg7mNzheQRQQi4UorZ4IZ6o9Ea2x0dqS
         W2ScABH9ID9IoFguU/vvd89bj2IEuwi+0wpcnLazDXKFWVjLUvLZvPJNywn0dLOCQ3tK
         C3MA==
X-Gm-Message-State: AGi0Pub3nyKJ041wNVIvf7PTOT65H8xa+7lDSmvWgyt8bNVQA3QkmGKs
        OfYP6CwDhVqjQ259pXna3gl0aA==
X-Google-Smtp-Source: APiQypLo2Uv9TAEfSh+IISXH+Kg0NVSAYiXUQI2v0pVCREPH82taZ3U2fhV+jvGvfOzlTOwh6hOZkg==
X-Received: by 2002:a37:61d3:: with SMTP id v202mr25564529qkb.142.1588187718111;
        Wed, 29 Apr 2020 12:15:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k43sm104680qtk.67.2020.04.29.12.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 12:15:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTsAu-0002Eq-J1; Wed, 29 Apr 2020 16:15:16 -0300
Date:   Wed, 29 Apr 2020 16:15:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Scott Talbert <swt@techie.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/tpm: fix section mismatch warning
Message-ID: <20200429191516.GK26002@ziepe.ca>
References: <20200429190119.43595-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429190119.43595-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 29, 2020 at 09:01:08PM +0200, Arnd Bergmann wrote:
> Building with gcc-10 causes a harmless warning about a section mismatch:
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0x5e191): Section mismatch in reference from the function tpm2_calc_event_log_size() to the function .init.text:early_memunmap()
> The function tpm2_calc_event_log_size() references
> the function __init early_memunmap().
> This is often because tpm2_calc_event_log_size lacks a __init
> annotation or the annotation of early_memunmap is wrong.
> 
> Add the missing annotation.
> 
> Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/efi/tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
