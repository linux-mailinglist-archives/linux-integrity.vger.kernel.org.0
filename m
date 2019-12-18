Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080571248B1
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 14:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfLRNpQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 08:45:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37359 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfLRNpQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 08:45:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so1580416qky.4
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 05:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C4ntQvciQzVGbr4/WEhkSDFzmYZWWBqD5uxngUjOBow=;
        b=Dd8yzJbfYhuzey0d0UWujCUQkz0PCjyl+HSrTDFSBJVPYv9jrH4IP3eKn0xaWYwE4C
         au/dkZzJoc8xHC7T64qBT/VyV6Hfo0O3sq1FaLwvrTxeKAAfiNFX043RhLwb0GRkhU9a
         xhXpLjuiFo2Fafci4oS2ibyur5E6hetSYnwf01xTJdjgSg9g+kjZcASPSvrGvANmzJN3
         NGB45DkJ5QmhtWHfC5HGtZWBylowj3VK8bKla7TckqbI6HfxEuaLB7u3Bu2F5zRfEoMc
         qll3sMQMy+TrhTRl57jjm8savvbPzL1JC6MPxeBIuybiHX2u/GkiNWUSXHoHB/ixTExX
         onpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C4ntQvciQzVGbr4/WEhkSDFzmYZWWBqD5uxngUjOBow=;
        b=LbUN+cgHzuhnfFmnRrA+wJjL1gyxBDEnNaVagRMjDDfKayMcZWfflJMIAsxXX9eMKS
         M6bXa7xMW64bpoMDh+brV9c4vOwhPNjT6y7QUoVXn8Mn3t4se0zqi/zQxSB4SyoilBCM
         vHwtQ06aUydCK/DxFdbRT1+LXohT9Xg80R27Dc/BU2G/073JHy2KlernBCfSeH5I+1/e
         aHZbHDgIkBblpQMDC4TM0bv8ag9yEbFlQt8UuYlLWLFZKnDtMKCOYN3PLFEhMtpkT8WK
         6wnLKC1eauk2XH8gPwjQKyVr8RQbhTpAJ7PiXBdTOWvXb0JMDfxMX+UR3HC5urQRjSwu
         5+kA==
X-Gm-Message-State: APjAAAXoeWk6XtgDp+4K8pBPYya2zti7DGcGFphtjc0sPLLOAr+h4cF7
        qn8aIQVqaWZGY2hZwJDqvUFE3g==
X-Google-Smtp-Source: APXvYqxKR+OvOVDgF3lNL/dBSAkb0u6QiN+0z3MaDkJ/DaaeoIYdHPk2y5sfSExH2I8XHxhlWtvQmw==
X-Received: by 2002:a37:a18b:: with SMTP id k133mr2560191qke.83.1576676714706;
        Wed, 18 Dec 2019 05:45:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i90sm736223qtd.49.2019.12.18.05.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 05:45:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ihZdZ-0007bb-Ls; Wed, 18 Dec 2019 09:45:13 -0400
Date:   Wed, 18 Dec 2019 09:45:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/ppi: replace assertion code with recovery in
 tpm_eval_dsm
Message-ID: <20191218134513.GE17227@ziepe.ca>
References: <20191215182314.32208-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215182314.32208-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 15, 2019 at 12:23:14PM -0600, Aditya Pakki wrote:
> In tpm_eval_dsm, BUG_ON on ppi_handle is used as an assertion.
> By returning NULL to the callers, instead of crashing, the error
> can be better handled.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>  drivers/char/tpm/tpm_ppi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index b2dab941cb7f..4b6f6a9c0b48 100644
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -42,7 +42,9 @@ static inline union acpi_object *
>  tpm_eval_dsm(acpi_handle ppi_handle, int func, acpi_object_type type,
>  	     union acpi_object *argv4, u64 rev)
>  {
> -	BUG_ON(!ppi_handle);
> +	if (!ppi_handle)
> +		return NULL;

If it can't happen the confusing if should either be omitted entirely
or written as 

if (WARN_ON(!ppi_handle))
       return NULL;

Leaving it as apparently operational code just creates confusion for
the reader that now has the task to figure out why ppi_handle can be
null.

I favour not including tests for impossible conditions. The kernel
will crash immediately if ppi_handle is null anyhow.

Jason
