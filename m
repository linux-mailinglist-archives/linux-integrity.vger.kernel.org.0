Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F088371713
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 16:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhECOvI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 10:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhECOvH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 10:51:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F4133611C2;
        Mon,  3 May 2021 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620053414;
        bh=gsdFuApW5+4lUWhmYGuxvZAJHfL+L6FpNWciPn9G6Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IX9K8Ll9nueLs63l7TcW4Zsq2J+gdmrKW72vcLHM6v1SHd8l0unkQRNta6y/oKucI
         SYY/g4Cg8IEZ6E1o64j8R4BsNKCUkRIOyU9FxAW5+6n8+1dvKkdO4yydoAQXgycdmd
         yT8LuFO12trjgjJJoZ0JY2Uc7b0ZCGJ/KZ+6FwP8OLoJqWIe8Hh2IMR3Imrf7d9cIk
         pvcAfO9JMntRIkZN9zkHrW13V8ibGK08Smo8jm9WCC2Go4EZCHaOxN4mlK4+cZYIxU
         7RU0oth7SAcHMyzsAhC7Z/eFkksV+DlGmBVtiFKc5y2AtV9lBFE/cYe915yllkfKN1
         lTLrdpTgMHEDQ==
Date:   Mon, 3 May 2021 17:50:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] tpm_crb: Use IOMEM_ERR_PTR when function returns iomem
Message-ID: <YJANo9Jq5/dgHIn6@kernel.org>
References: <1619681979-542-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619681979-542-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 29, 2021 at 03:39:39PM +0800, Tian Tao wrote:
> This is to simplify the code, and IOMEM_ERR_PTR(err) is same with
> (__force void __iomem *)ERR_PTR(err).
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
> 
> v2: rewrite the commit message.
> ---
>  drivers/char/tpm/tpm_crb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index a9dcf31..1860665 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -464,7 +464,7 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
>  
>  	/* Detect a 64 bit address on a 32 bit system */
>  	if (start != new_res.start)
> -		return (void __iomem *) ERR_PTR(-EINVAL);
> +		return IOMEM_ERR_PTR(-EINVAL);
>  
>  	if (!iores)
>  		return devm_ioremap_resource(dev, &new_res);
> -- 
> 2.7.4
> 
> 
