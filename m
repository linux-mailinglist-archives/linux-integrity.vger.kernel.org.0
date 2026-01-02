Return-Path: <linux-integrity+bounces-8159-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B9CEF121
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 18:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BDDF30133BF
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 17:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E522D248C;
	Fri,  2 Jan 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEuRAc7H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB692D0C8F;
	Fri,  2 Jan 2026 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374951; cv=none; b=mw79sIbo8mwYKYS6m8k3KSQdce6OxKbNnEnOnUC4dA4GnxBOlmCh4rtJGRODMGS4ALR12WrevHNOgDpDxdUozjOaJXeN5ieOOtdClU3ChjBfBk8weoV3SaADSlJPGZF6mYS6Y6dtw0exRy5oQKMxSq+X60E50Oy6GeHWMQM+VxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374951; c=relaxed/simple;
	bh=6q3jVdJALnX5TDyPEkxn+Ndossn5NIw32iIjOQXwbfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbF03grBiV6WHSMoyLuRSbL8yASONFRIqq2Hpo7v4R3o+0Nechxz1byFb90QPxeVtUKH5VniPxblBEpUhMahTZzD49Pkh5AcK/efV18s07dsk4iz2NKi4i0v8yQYs8ixnfV51ffEU5Ln6JIZXkBhtatkLI1uUD4hlNRUWSYZyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEuRAc7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6303C116D0;
	Fri,  2 Jan 2026 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767374948;
	bh=6q3jVdJALnX5TDyPEkxn+Ndossn5NIw32iIjOQXwbfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEuRAc7HnPiVuOdHTKV+hEulW5BGiX0MZoFGRLczhemXtIXierA4v+6Bf5uyK2ki4
	 E3aWxuKaZA4cYr6IK+i3Zg1UBlv1WWnHR5B11rmgeHf4J5N7H5ojhqacaCjeJ7yAuX
	 ZuIe48SLofuNrdJ1J5tmMX26kS7Z8h95FYLK/yJj8C/0Z/hqmjTDiwHZMDuBt1N1wY
	 pZ3FqMcLNoifuEEB6y2biMEyLTqh5wRAdA91aI95gFM4NI6AziYU17QTHZHvWOwX1A
	 t87Qtl5bW1gJEQy65oQYzOx5f0Sjp3Rr3NquB9JXuTl/HOzumefyJm+lvBJ7msRLnZ
	 xt0gopoCUkqIw==
Date: Fri, 2 Jan 2026 19:29:03 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: st33zp24: Fix missing cleanup on get_burstcount()
 error
Message-ID: <aVgAX5C5ih1VsNAD@kernel.org>
References: <20251226120929.61630-1-alperyasinak1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226120929.61630-1-alperyasinak1@gmail.com>

On Fri, Dec 26, 2025 at 03:09:27PM +0300, Alper Ak wrote:
> get_burstcount() can return -EBUSY on timeout. When this happens,
> st33zp24_send() returns directly without releasing the locality
> acquired earlier.
> 
> Use goto out_err to ensure proper cleanup when get_burstcount() fails.
> 
> Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
> ---
>  drivers/char/tpm/st33zp24/st33zp24.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index 2ed7815e4899..e2b7451ea7cc 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -328,8 +328,10 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
>  
>  	for (i = 0; i < len - 1;) {
>  		burstcnt = get_burstcount(chip);
> -		if (burstcnt < 0)
> -			return burstcnt;
> +		if (burstcnt < 0) {
> +			ret = burstcnt;
> +			goto out_err;
> +		}
>  		size = min_t(int, len - i - 1, burstcnt);
>  		ret = tpm_dev->ops->send(tpm_dev->phy_id, TPM_DATA_FIFO,
>  					 buf + i, size);
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

