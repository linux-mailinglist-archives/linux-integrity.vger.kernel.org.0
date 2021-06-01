Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8F39798E
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhFAR7N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 13:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhFAR7M (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 13:59:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A6DA6023E;
        Tue,  1 Jun 2021 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622570251;
        bh=KfdVVv/WsdwLVI24wjWaU43qdgKYa3UWiuxNTbPnq8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKKI1oD/UTeAoSn9v2r/TkCQ2au1vln30Br6GvgxvwghuZ1TEYI8Iaa14nTYuD84z
         LC71lnvzDA4AQZUfUMJIOg9aJZx8yeLYJD/Z2hGI13TxRuwv3rvQI8TxMvSOqFUsQV
         wDYDsA4VgNzNdx788CQOM96Wz3zh8pg9856lrxc6jSl2/l4umrQofp1P3F9rW60qC3
         IqsqB9B+jjILY+1Aqm6SOLcj6UAX3gyJ7klvzLRN2lAkrSL1yBOMa6BsZ6bYE/5A+P
         K2nxVyANUEMPFKnS0XxTXmyVA6y+CUJNG3xvz+mQqV82L2OxGToo7ufllExcH8rByT
         u5FCGuV9n7L8A==
Date:   Tue, 1 Jun 2021 20:57:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tpm_tis: Use DEFINE_RES_MEM() to simplify code
Message-ID: <20210601175728.gyi3yepdtvu4hald@kernel.org>
References: <20210601064507.9989-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601064507.9989-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 01, 2021 at 02:45:07PM +0800, Zhen Lei wrote:
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

No change, no need to apply?

/Jarkko

> ---
>  drivers/char/tpm/tpm_tis.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 4ed6e660273a414..d3f2e5364c275f4 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -363,11 +363,7 @@ static int tpm_tis_force_device(void)
>  {
>  	struct platform_device *pdev;
>  	static const struct resource x86_resources[] = {
> -		{
> -			.start = 0xFED40000,
> -			.end = 0xFED40000 + TIS_MEM_LEN - 1,
> -			.flags = IORESOURCE_MEM,
> -		},
> +		DEFINE_RES_MEM(0xFED40000, TIS_MEM_LEN)
>  	};
>  
>  	if (!force)
> -- 
> 2.26.0.106.g9fadedd
> 
> 
> 
