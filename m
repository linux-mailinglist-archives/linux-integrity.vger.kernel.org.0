Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC363B7731
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhF2R3b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 13:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233106AbhF2R3a (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 13:29:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB1C561D8E;
        Tue, 29 Jun 2021 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624987623;
        bh=Fiyq8xQDH18p8i42/BBHJsOdmil86LfKlHbmik4QPqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEkr2G062XoUHkfTNTd+ZcmImQUgBmpzv8OzOKQQysYTfcTC/TfvKJTgJj9sufFdW
         sD15/6ICokwg14m4PEOVikUlyhXUhvJCacA6GEfcLQdGwO6Pvt0Awg0CTfg51ohpDz
         sNK6saZ+0Cm8G5OyTnD7/galyNEE/5Jkv5LQIOhdBXM6gEowO7fb34kOPEUmWhmaWT
         WpD3BvyYX1Fv64U0C4T8w5anoh4s7Kh8HU/gzZBpO289iGQV5KcwVzqvw9IVH0LOo6
         ViyWOSN42cNna8np4bhIuLJ8G4/OYrCNcukBTVZX5NaUEU9Ob/epK9OAiqqJ/m2cxP
         gvJSt641F/nQw==
Date:   Tue, 29 Jun 2021 20:27:00 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
Subject: Re: [PATCH] char: tpm: vtpm_proxy: Fix race in init
Message-ID: <20210629172700.yxqnedbayumo5f24@kernel.org>
References: <20210623132226.140341-1-saubhik.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623132226.140341-1-saubhik.mukherjee@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 23, 2021 at 06:52:26PM +0530, Saubhik Mukherjee wrote:
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
> Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
> ---
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
