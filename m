Return-Path: <linux-integrity+bounces-7662-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FF7C7B9F9
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 21:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED6D54E13FB
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C502FFDFC;
	Fri, 21 Nov 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3IBgL9A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607DA21D3F4;
	Fri, 21 Nov 2025 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755921; cv=none; b=HwJsePTQW0ZleEMwmPMnVVh7SmRYX+a6jXFcVBitbwWpBY9O2GhFFtHQkKs85DaWZQg2KZHSkRHVPEUmucNsNFJypBGMnZRC6qXI4+K3SRfT88CnSsfLCygaMIm4IsKkiq3TSragpGeXlcLyqz2/TjhF7jZF4ke4VLJzKDLsSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755921; c=relaxed/simple;
	bh=t8WuAagLnagFTNPF+qV1fvQjQU7fsUNuW4m2jbbCn10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPMKJNW7IWrs0XbUONNjafjHMKjGPack5WZOOMF3eV0015GFjQPC4BrTv/J01X9hUKlBCC+sUrGkTsG2Ra+AaVWchxvtTrTH9tIFX3vyGJOtwXRrXW+odA78noA7OlGNIA17GjLVtoBBmBVU/GHLAlwci5Rddq2taGQzVgN2NtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3IBgL9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2E6C4CEF1;
	Fri, 21 Nov 2025 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763755918;
	bh=t8WuAagLnagFTNPF+qV1fvQjQU7fsUNuW4m2jbbCn10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3IBgL9AdA3fvomyhMijUHxZtnWg8zoXuq0oxN1aWq0tm2pOjWulhbSnfP+b31WuF
	 wWFJ++8nZsglYrN77dn40bqHycqNI72Ik6U23eAn7NrtXPPxHdET+ZNASY1umlRyFU
	 K6i5zYLlTQSEcYjrgw9tY1w7IH3YvwOdFJtF6dS3ls6i9Qw+rqyNawsLTLrnOI7T4A
	 +sFeASoj9+18jJQKhGeXRNa6xg9xjkmDmXSO1BbSiAVMi7GL1vZ5WmAmg6LZkZa1Gq
	 LKNEjy5MzUP11WU6G1hewpeIjO1vQOGnyn3Xa49m8Xmh8tcbFw4T3rs6ReQ9X+YyNo
	 JiiomL2BlHsIw==
Date: Fri, 21 Nov 2025 22:11:54 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 15/44] drivers/char/tpm: use min() instead of min_t()
Message-ID: <aSDHihcWOHGLAjTb@kernel.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-16-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119224140.8616-16-david.laight.linux@gmail.com>

On Wed, Nov 19, 2025 at 10:41:11PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> min_t(int, a, b) casts an 'long' to 'int'.
> Use min(a, b) instead as it promotes any 'int' to 'long'
> and so cannot discard significant bits.
> 
> In this case the 'long' value is small enough that the result is ok.
> 
> Detected by an extra check added to min_t().
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  drivers/char/tpm/tpm1-cmd.c     | 2 +-
>  drivers/char/tpm/tpm_tis_core.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index cf64c7385105..11088bda4e68 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -530,7 +530,7 @@ struct tpm1_get_random_out {
>  int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  {
>  	struct tpm1_get_random_out *out;
> -	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
> +	u32 num_bytes =  min(max, TPM_MAX_RNG_DATA);
>  	struct tpm_buf buf;
>  	u32 total = 0;
>  	int retries = 5;
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 8954a8660ffc..2676e3a241b5 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -310,7 +310,7 @@ static int get_burstcount(struct tpm_chip *chip)
>  	return -EBUSY;
>  }
>  
> -static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
> +static int recv_data(struct tpm_chip *chip, u8 *buf, u32 count)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int size = 0, burstcnt, rc;
> @@ -453,7 +453,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  			rc = burstcnt;
>  			goto out_err;
>  		}
> -		burstcnt = min_t(int, burstcnt, len - count - 1);
> +		burstcnt = min(burstcnt, len - count - 1);
>  		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
>  					 burstcnt, buf + count);
>  		if (rc < 0)
> -- 
> 2.39.5
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

