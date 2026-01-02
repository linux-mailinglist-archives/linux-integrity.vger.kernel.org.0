Return-Path: <linux-integrity+bounces-8157-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB1CEF109
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 18:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA86B3012758
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2CF2D23A3;
	Fri,  2 Jan 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfQUlCTc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A082D2382;
	Fri,  2 Jan 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374915; cv=none; b=S1VlBSUtSZl57EBkkXBsALROFcw9Vm1xyy7hk96ka/jMWi5UKabw4jGsQM1rl37xuP3GtHwEVCKPcRo/+pS3Dnd0gIoHNs/yO5TG5hie8bMS3MTNkQaKD5Bvffrw6h1fP8822/Bdj2K4Syx47avoGabLVTSO27yWG6MK69Iim1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374915; c=relaxed/simple;
	bh=bs2GvNWwZfFmylvYduIu1U/QnyCy57sDsOVdefq7bG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1/zT+6zKmZW+0FXQoDp5gQlaimDCSil12vhzwrB+NIomYqoth9+twgyCw1MRmxaWHoTC8oN/WUl7RtWG0LCDsOVTi+2OACr83tTWg53eWPA+x5kb43IEacfqdnHtsUkxsTsTh0mV6+R5O2KhMnJMEibljKlvEeQKc9INGu9jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfQUlCTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9154C116B1;
	Fri,  2 Jan 2026 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767374913;
	bh=bs2GvNWwZfFmylvYduIu1U/QnyCy57sDsOVdefq7bG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfQUlCTcTQCT6BrVYflOxSodnf0dNPWmfIwFwaRMdCxjxbuprnSmvfB8lG7LpioK3
	 WHFEyXgXFYL1PPk26+0aDuq+Yo0FhZy0RveutVL/ZeYYtosZHqD5Dtruz8CbE+cCfM
	 +H7w2CVa2+lbpfrSvke+rRhKAMYm2hNMW4ZmIUEVBI/VTPN6ZovyZoNqKZevMyPE8X
	 5ZCgkbfxp2VYNeKYIBUAtaCuiEItCAxaQre2oR/e5iVbsCdfpAbLRkvRY6w/OQkR71
	 z2IwmQyPmEBT4rnH+BRKzAyNeFsLrcwP2uwuUjGnc1D1MCZlK0maVBKhJxdHFtzb6G
	 7g0eJeEeWEcow==
Date: Fri, 2 Jan 2026 19:28:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
	Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_tis_spi: Initialize ret variable in
 tpm_tis_spi_transfer_half()
Message-ID: <aVgAPP_bI1if2y6C@kernel.org>
References: <20251226113505.53740-1-alperyasinak1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226113505.53740-1-alperyasinak1@gmail.com>

On Fri, Dec 26, 2025 at 02:35:04PM +0300, Alper Ak wrote:
> When len is 0, the while loop in tpm_tis_spi_transfer_half() is never
> entered and the function returns an uninitialized ret variable.
> 
> Initialize ret to 0 to correctly handle this case. This is consistent
> with tpm_tis_spi_transfer_full(), which already initializes ret to 0
> before the loop.
> 
> Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
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
> -- 
> 2.43.0
> 

OK, despite agreeing that 'ret' should be initialized I did not find a
call path where 'len' would end up being zero.

While acking the change in the sense that this function should be robust
enough to handle zero value for 'len', I'm just trying to figure out if
this is a regression from reproducability perspective, or just an 
improvement.

BR, Jarkko

