Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0138B487
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhETQol (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 12:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhETQol (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 12:44:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E3BC60FDC;
        Thu, 20 May 2021 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528999;
        bh=z2oOpaIdAemS/NJKyoJhRsl9xYkGM0IF40ygHpxA8lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cg7kfNPGcuAuehFxxD580CxaAQINBNGsENm52dRZXXzBEkL2s/5sAK1YpDCwzobTs
         lRpcC3mFe1K1a97wuZyyeG6AxA7jEHH4aKHwTaXWlNWEYb0cjNTyJQYnGeIFdlkPNb
         GroKvbAU+YxF6k+/HzNtS3oBY/CxrWOCLdCQPdHwz/mDpjP+XlENq5RPQ1ar//zmCS
         dzrmePBXpkwqZ1ql8ZDI1OyD7VhU3/Az+ztOoiG4hpOgHrLHVysdKZi1C7AoWsu/t7
         6AoYzAnSByb8V2Lkc8E5JUtjTGCKuTiE+PtvZnkRBIt77OSZYAbjus/f9uM5OAzUGl
         6Y7E58neSqTxw==
Date:   Thu, 20 May 2021 19:43:17 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 08/16] char: tpm: tpm_ftpm_tee: Fix a couple of
 kernel-doc misdemeanours
Message-ID: <YKaRpdpxTVr8Igm1@kernel.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <20210520121347.3467794-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520121347.3467794-9-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 20, 2021 at 01:13:39PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Function parameter or member 'dev' not described in 'ftpm_tee_probe'
>  drivers/char/tpm/tpm_ftpm_tee.c:218: warning: Excess function parameter 'pdev' description in 'ftpm_tee_probe'
>  drivers/char/tpm/tpm_ftpm_tee.c:314: warning: Function parameter or member 'dev' not described in 'ftpm_tee_remove'
>  drivers/char/tpm/tpm_ftpm_tee.c:314: warning: Excess function parameter 'pdev' description in 'ftpm_tee_remove'
>  drivers/char/tpm/tpm_ftpm_tee.c:349: warning: expecting prototype for ftpm_tee_shutdown(). Prototype was for ftpm_plat_tee_shutdown() instead
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 2ccdf8ac69948..2d9c0ecd43f0a 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -209,7 +209,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
>  
>  /**
>   * ftpm_tee_probe() - initialize the fTPM
> - * @pdev: the platform_device description.
> + * @dev: the platform_device description.
>   *
>   * Return:
>   *	On success, 0. On failure, -errno.
> @@ -305,7 +305,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
>  
>  /**
>   * ftpm_tee_remove() - remove the TPM device
> - * @pdev: the platform_device description.
> + * @dev: the platform_device description.
>   *
>   * Return:
>   *	0 always.
> @@ -342,7 +342,7 @@ static int ftpm_plat_tee_remove(struct platform_device *pdev)
>  }
>  
>  /**
> - * ftpm_tee_shutdown() - shutdown the TPM device
> + * ftpm_plat_tee_shutdown() - shutdown the TPM device
>   * @pdev: the platform_device description.
>   */
>  static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
> -- 
> 2.31.1
> 
> 
