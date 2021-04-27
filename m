Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D823736CFA1
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 01:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbhD0Xpa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 19:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236547AbhD0Xpa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 19:45:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E32D761401;
        Tue, 27 Apr 2021 23:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619567086;
        bh=5Wh903gHRpUnzcivGQzCYZlxht+wyr1i9SWS0iNHOSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWZcn8GBSnd+6zV0SKnC2NxlLQIOOJKrpsLDjGbYF9jtuH3vBi3aQKNGBewMMuNuO
         MiLHt2B31Hld8zDLzWvWPpDG2tM4XeVjZALLA1FeBXj8QgwO06Ust9jxCr/jJkIfaJ
         z4sqBwoC/IDcSUbW+DfBoK05+Qprl88dxCjszazRLjpo7zB6YAXgfjZO7Tmn7BY0qu
         wN0MnoOLFrZ6m5eXhk3WQZrSMcsYzmub6Nm0z73u43FyfSeMWCBlrYXCKsfeciQOYI
         HUn+4zlk2zuoIFnZSdPNrLvWyfXMsZLVPAJVx8IHlJsrrIL4Zjta579Grj01MTnzJD
         W5e22P+Ipa62A==
Date:   Wed, 28 Apr 2021 02:44:42 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Use IOMEM_ERR_PTR when function returns iomem
Message-ID: <YIih6nWshf7XfNTU@kernel.org>
References: <1618888245-31604-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618888245-31604-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 20, 2021 at 11:10:45AM +0800, Tian Tao wrote:
> Function returns 'void __iomem *' so use IOMEM_ERR_PTR for returning
> an error.

You should also tell why we want to to use IOMEM_ERR_PTR in the
description. If it makes sense, then you should know why it makes
sense.

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
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

/Jarkko
