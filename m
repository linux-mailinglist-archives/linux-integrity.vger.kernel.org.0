Return-Path: <linux-integrity+bounces-5476-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B97A73362
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 14:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746B03B6F34
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70E215789;
	Thu, 27 Mar 2025 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG2URvM4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FF215780;
	Thu, 27 Mar 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082277; cv=none; b=QfO5tPVbSh5wkYY4HfSeBQTnQwvmmE5mvFC0ef5se/R6yRNsYfDaWWQMBM5k3Gz+9u/8u8M6ym0GxHnSmsn+g9+r3ZynHStXzLtNbwG8lwVXRQ2G8lg98bpwhE45d7Up0YBsFceqBo0nba7qMlZgLKZRWL8yN6eeSJkCIPErX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082277; c=relaxed/simple;
	bh=GHulqPHKw3iqVeCcCtvnxCaVG2mRKgrixEqdo1y6Vqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzJYUuJX4oPY/fLORaDTh3KFBPYcxj5Wqwowf8ngTJ4nKJcgEVxEcYLhRnOKzLC3kn51Egb4fxnre1nuokccldux5DmdxUecPik3EcRPSBPtJL1H2z1FH9Yn5pwqCrVhcVIApNibIyfz9/l5Wk3WP3cZw76SVZ/Ld4JTHOAMO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG2URvM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE94C4CEDD;
	Thu, 27 Mar 2025 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743082276;
	bh=GHulqPHKw3iqVeCcCtvnxCaVG2mRKgrixEqdo1y6Vqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FG2URvM4RGjGxLrlpC4w1CKL3hED6OjErz/e7ZLPt9CwAgzwgRACn0DHPndSUzBO9
	 mpbVq6P7miWNE54yRHIZRal/rtzI5KdrcPskMY6ZYIEJW8aGzYIQdft/Re5uLcY/iH
	 Xd4/uEkdtIOZeoVr8MxY5wV+4KtoC5/YyRsV5zc6q/4OtQpOeVZeLq0FjnbDRLkUaH
	 LpWDYB1BcrwlUk8sBkaA3BSiXB1jIdAQL32DIowfbZWrzYVyXkme7wYXXTvZL3uiza
	 AP0KLNNHMwctwoWGWG8hVV3uXImxcvHktIIaHt4pLJd7Uft+P1wojiinswwKj3sJe1
	 tSvmzndKykmpQ==
Date: Thu, 27 Mar 2025 15:31:12 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
	peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de
Subject: Re: [PATCH v6 6/6] MAINTAINERS: Add tpm_loongson.c to LOONGSON
 CRYPTO DRIVER entry
Message-ID: <Z-VTIFNZjCkX4eYC@kernel.org>
References: <20250327021940.29969-1-zhaoqunqin@loongson.cn>
 <20250327021940.29969-2-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327021940.29969-2-zhaoqunqin@loongson.cn>

On Thu, Mar 27, 2025 at 10:19:40AM +0800, Qunqin Zhao wrote:
> Changes to Loongson TPM driver would be best reviewed by the Loongson
> crypto driver maintainers.
> 
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
> v6: "tpm_lsse.c" -> "tpm_loongson"
> v4-v5: None
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 814205642..16fcd35ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13606,6 +13606,7 @@ LOONGSON CRYPTO DRIVER
>  M:	Qunqin Zhao <zhaoqunqin@loongson.com>
>  L:	linux-crypto@vger.kernel.org
>  S:	Maintained
> +F:	drivers/char/tpm/tpm_loongson.c
>  F:	drivers/crypto/loongson/
>  
>  LOONGSON-2 APB DMA DRIVER
> -- 
> 2.45.2
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

