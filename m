Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D473C2884
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhGIRkS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 13:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGIRkS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 13:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66141613C1;
        Fri,  9 Jul 2021 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852254;
        bh=qOOAAdhQ1intYRWW/AffL+13hLjsPs0v5MNLdeXti60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JD9fWf1C61xVXTZ0R/Bnsntvp8kRogDb6GmW5t+2GThXtoHcZ4vVm8LmNJGVZ/9W/
         79k8f2bS740ipgLU5xbKRBZmxanpis95oT6Z96yAobMSkuBB1YnC6Mu1c9LSZOS5OI
         mvmJKO7DWuHK3eKuhy9iaiyoPEIi5hDQ/Jq4uZT46NyUvGrQ7TGu1SROCz7iwtdtJs
         9ffaBXFw9GwO2h81pBnTpxSo+vH3arRBDT2DZ6tjTzSjA9PS5NeUB+TcdW8HeLbj1j
         2lE8szpY+4BmANn6nKUPq1yoA+SqsU8QBei8W1Xv8tasOf8dV25Y7tQx6IbEAb+MlU
         1sBrt02lSWH0A==
Date:   Fri, 9 Jul 2021 20:37:32 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
Subject: Re: [PATCH v2] char: tpm: vtpm_proxy: Fix race in init
Message-ID: <20210709173732.tr6bdiesnqg22xro@kernel.org>
References: <20210708095259.27915-1-saubhik.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708095259.27915-1-saubhik.mukherjee@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 08, 2021 at 03:22:59PM +0530, Saubhik Mukherjee wrote:
> vtpm_module_init calls vtpmx_init which calls misc_register. The file
> operations callbacks are registered. So, vtpmx_fops_ioctl can execute in
> parallel with rest of vtpm_module_init. vtpmx_fops_ioctl calls
> vtpmx_ioc_new_dev, which calls vtpm_proxy_create_device, which calls
> vtpm_proxy_work_start, which could read uninitialized workqueue.
> 
> To avoid this, create workqueue before vtpmx init.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
> Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
> ---
> 
> Changes since v1 ([0]):
> - Add Fixes tag to commit message, as requested by Jarkko in [1].
> 
> [0]: https://lkml.org/lkml/2021/6/23/572
> [1]: https://lkml.org/lkml/2021/6/29/695
> 
>  drivers/char/tpm/tpm_vtpm_proxy.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 91c772e38bb5..225dfa026a8f 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -697,23 +697,22 @@ static int __init vtpm_module_init(void)
>  {
>  	int rc;
>  
> -	rc = vtpmx_init();
> -	if (rc) {
> -		pr_err("couldn't create vtpmx device\n");
> -		return rc;
> -	}
> -
>  	workqueue = create_workqueue("tpm-vtpm");
>  	if (!workqueue) {
>  		pr_err("couldn't create workqueue\n");
> -		rc = -ENOMEM;
> -		goto err_vtpmx_cleanup;
> +		return -ENOMEM;
> +	}
> +
> +	rc = vtpmx_init();
> +	if (rc) {
> +		pr_err("couldn't create vtpmx device\n");
> +		goto err_destroy_workqueue;
>  	}
>  
>  	return 0;
>  
> -err_vtpmx_cleanup:
> -	vtpmx_cleanup();
> +err_destroy_workqueue:
> +	destroy_workqueue(workqueue);
>  
>  	return rc;
>  }
> -- 
> 2.30.2
> 
> 

Thanks, I applied this.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
