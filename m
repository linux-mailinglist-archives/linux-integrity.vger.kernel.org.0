Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4E447446
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Nov 2021 18:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhKGRHV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Nov 2021 12:07:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhKGRHU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Nov 2021 12:07:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 419BD6128B;
        Sun,  7 Nov 2021 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636304677;
        bh=hDYEyFC5WOZ4ixhuFP5RhKzJjSggOHETDf1BdhtkRmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fs9Q02bEeG8BhHJwPbtI1cu9pNhfQOAmlbycSa2VrKny7hDWJTU6jof5LuGtEMP86
         J/CpCe6FJELCDd2LiLi+V1xieXFpyVJ1Z9LWC7MTly5xPgbBr13ta7EHaFHvqTvv1O
         eH8VyTxnybxaFFncdC4Jj2Is1Vj1s4eP/F2A/7PB5ieenZkphh8H2YwYHVFq8CbOyT
         XWeHlSrZG8Q/Hei4yk+G6+7OXxm9f4Ht5xF4VnYo0Zl8Z9//MREEgIKLDdSaD+aKk2
         XuoqtzEz+g5DpJkfH2ugfoxFMhzYbiOceTHDSRr21y5nLiPrFVAdAe1SNmuC/M/h8S
         oZDx1vzkt8n+Q==
Date:   Sun, 7 Nov 2021 19:04:35 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, hao.wu@rubrik.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: Fix an error handling path in
 'tpm_tis_core_init()'
Message-ID: <YYgHI3vKzD2/b7R/@iki.fi>
References: <7391611c2f2c5ca9fcea5b960fe6f7cac12121f4.1636216848.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7391611c2f2c5ca9fcea5b960fe6f7cac12121f4.1636216848.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Nov 06, 2021 at 05:42:04PM +0100, Christophe JAILLET wrote:
> Commit 79ca6f74dae0 ("tpm: fix Atmel TPM crash caused by too frequent
> queries") has moved some code around without updating the error handling
> path.
> 
> This is now pointless to 'goto out_err' when neither 'clk_enable()' nor
> 'ioremap()' have been called yet.
> 
> Make a direct return instead to avoid undoing things that have not been
> done.
> 
> Fixes: 79ca6f74dae0 ("tpm: fix Atmel TPM crash caused by too frequent queries")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index b2659a4c4016..e672d2dc8937 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -952,7 +952,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  
>  	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
>  	if (rc < 0)
> -		goto out_err;
> +		return rc;
>  
>  	priv->manufacturer_id = vendor;
>  
> -- 
> 2.30.2
> 

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
