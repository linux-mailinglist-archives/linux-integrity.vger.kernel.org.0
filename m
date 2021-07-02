Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE84C3B9C3A
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 08:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGBGk0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 02:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhGBGkX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 02:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B0F3613FB;
        Fri,  2 Jul 2021 06:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625207871;
        bh=t9p7+88H7JJGMLnUmEIqoSf+caS+4mkwK5K4/fkCx9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aktlaaVqLwbTh0zvx3fDm8ajjyAZDl9LeUXRoub9KOybl0ETnwQ/3NIMcBNWQYnaX
         7i8f9Wg46l4q2KfIAk21yBFXUdqrd4D0Cloja94oW5jLdNWLheyfgZtzEs5eYy+gsr
         gJZw3iGOv6sPGxwgv1zd36POqxbQ5fSprqgGov1aDRgIeLnRbwRQ0pFRdQaPyDcTh4
         Yg7rQKHKulttlWdpylpyS194rAOoYTNqdNvQvNBur5cK/71VdD2eyBBYXyEiRT7beV
         yJFaJk3dyg/H/d5Cp2Bfov5oBllxr2e3WY/7Xh8zqF0SXPYLlBp3VrcppGYz+paLhB
         JEk4ieTK30j/Q==
Date:   Fri, 2 Jul 2021 09:37:49 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
Subject: Re: [PATCH] char: tpm: vtpm_proxy: Fix race in init
Message-ID: <20210702063749.xnjbdfv6p2lxhzxw@kernel.org>
References: <20210629210524.hze6yb23pps3flnv@kernel.org>
 <20210630071451.15507-1-saubhik.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630071451.15507-1-saubhik.mukherjee@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 30, 2021 at 12:44:51PM +0530, Saubhik Mukherjee wrote:
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

Is this v2? What was changed?

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

/Jarkko
