Return-Path: <linux-integrity+bounces-7163-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86EB85D93
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E102A175B77
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827E313521;
	Thu, 18 Sep 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oszcRfOf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A7313D50;
	Thu, 18 Sep 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210851; cv=none; b=l5TIXqq2X4S+oXzLXG2jHefG2ohUFxa3sBGjJS7mFRYkLkFJazLjZQWwOb70XdL+L4Y9excIz4N2aR+0RQkhMujchlTCuRiSKhZ9A+YjvzupIM+BMUTO/ucJ4lXGq8AFU/+Pjg7dI+0gg/y2gKaVH+93ljlKTQRnMRQcdeUHQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210851; c=relaxed/simple;
	bh=Ck87Yl4wh9oh3RbwhTOwoPbRENKQZVnVJcsNvelqtZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF484xaMROreNcZecVKw/qXgZ6JBcIrbtZ84sGPfQk+mvnN1qKZCRPW5fy6pSYMmJdI2vUYy/Mo8F6h7y2I+AI43mueOjeE/4r1SXzdIG4e82f4sofp3BVhSHrFJtxBpscvjZoUEY4k+gObyPpPPZyL4sFHq+fR/KcwerVy5ihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oszcRfOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93674C4CEE7;
	Thu, 18 Sep 2025 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210851;
	bh=Ck87Yl4wh9oh3RbwhTOwoPbRENKQZVnVJcsNvelqtZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oszcRfOfN2NZ1UJGL5hQFQQbPnEY4Hdd64CtkzcK1H4bMYAg4AryvWooIiQUnkbhy
	 oc6yip2cBCm3ayWMNwhofrDj/zg5KQbSr3lfmF92KK4SD13OtxqPVKqMMqkKc1MLB8
	 ngGkdr+kqzeES8ngyS7a8os/1z7Xja0IUI5qofuAoZe8HS+297B4bSskMX/ubPXi9G
	 jVPVPQrVaOzks0a8M3SnZrxgmPdyIPNNWysFb1zZnYuheGP8IEpixKLCpmS9wyTiBj
	 xcqjtcGNWK5ac5emM0hjtkfahPIJCg9lLJvGyzi3wgmuIEhuxRfB9qNqYvYYceYqpZ
	 IJ+1+Z2RwPKRA==
Date: Thu, 18 Sep 2025 18:54:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, kyarlagadda@nvidia.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Justinien Bouron <jbouron@amazon.com>
Subject: Re: [PATCH] tpm_tis: Fix undefined behavior in
 tpm_tis_spi_transfer_half()
Message-ID: <aMwrH5dWQo9nG1D7@kernel.org>
References: <20250917153022.18567-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917153022.18567-1-gunnarku@amazon.com>

On Wed, Sep 17, 2025 at 03:29:56PM +0000, Gunnar Kudrjavets wrote:
> When len is 0, the while loop in tpm_tis_spi_transfer_half() never
> executes, leaving ret uninitialized. This will lead to undefined
> behavior when the function returns.
> 
> The issue was introduced when tpm_tis_spi_transfer() was refactored
> to call tpm_tis_spi_transfer_half() or tpm_tis_spi_transfer_full().
> While ret is properly initialized in tpm_tis_spi_transfer_full(), it
> was missed in tpm_tis_spi_transfer_half().
> 
> Initialize ret to 0 at the beginning of the function to ensure
> defined behavior in all code paths.
> 
> Found by GCC 14.2.0 static analyzer with -fanalyzer.
> 
> Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
> Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> Reviewed-by: Justinien Bouron <jbouron@amazon.com>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 61b42c83ced8..1b6d79662ca1 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -85,7 +85,7 @@ static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr,
>  	struct spi_transfer spi_xfer[3];
>  	struct spi_message m;
>  	u8 transfer_len;
> -	int ret;
> +	int ret = 0;
> 
>  	while (len) {
>  		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
> 
> base-commit: 5aca7966d2a7255ba92fd5e63268dd767b223aa5
> --
> 2.47.3
> 

Thank you.

I just applied the earlier fix, and I'll apply this too (before next
PR).

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

