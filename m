Return-Path: <linux-integrity+bounces-6092-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBBFAA5028
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C13BB7A57ED
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D9717CA17;
	Wed, 30 Apr 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxd8CmGo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019531EB5B;
	Wed, 30 Apr 2025 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026693; cv=none; b=SwIoWoP7jJtPk8M6Cg/Qhw3h5D5I7Co9+pM2SnE9uLieWMQp8tIG+aEaJFRUJ3yScQ0GpHFV5KPH6PKdmqJBPDco2ONgPXnBnQCH3vYCYZt2sMq75E+AjfAyMyAs87qHewDA92oTSeHwBZ/cg4O+utnKWEE/7mGAENKG7Ipmtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026693; c=relaxed/simple;
	bh=SnEoU/saBPoKvnEQ7FuO0rhZTMGCnIWkqfHAccy41Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2aggUx75Ft02G5UlDiGlj/cPq+6Pqfl6Inaic4ksyX2BBXvnHs8YGGEzGJIG3KIZLS1cL61d1miXwYPwCSZ9u3cCe9m0oTVenigmpZOO3A2aLY2RIoy4WXJHsR/A4/3hzc2sNm5TPmwVKe9hCEd438XKr/dKH1ftAGHdsvqI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxd8CmGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC883C4CEE7;
	Wed, 30 Apr 2025 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746026692;
	bh=SnEoU/saBPoKvnEQ7FuO0rhZTMGCnIWkqfHAccy41Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxd8CmGofxwCWfvmQjXSUv/XjcNvEV8Y5t3G2RAMjDPqKDqlCCeXQ4e6ox9W81UvW
	 Dn7RVdXSlQE57DavBXnVyvTrQh6Je1GKU43U7VarIy2YLMEVE6hbgSlxl8ABwjLWxJ
	 KdbjTWmLpBanWAn2VdfEtUnqMaVq4xQ1lhaLO3/XKjqzu5zspooA0EBdQqgFr54igx
	 mQGj8BJ2Z593+D7tsHEPjlkJTcdIRiiAUiQDUADaGaxU5gOXkRSgRdzv3ncLTGi1kP
	 M71lcjj2yNHCZI6SPHcPC+s6PjSZm9jHpmqL+UpDTXwS42iSJ7oHAh4Ew2Q/BWbtav
	 LSutI56ixyCmQ==
Date: Wed, 30 Apr 2025 18:24:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V4] tpm: remove kmalloc failure error message
Message-ID: <aBJAwAg_92fZ-how@kernel.org>
References: <20250430083435.860146-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430083435.860146-1-colin.i.king@gmail.com>

On Wed, Apr 30, 2025 at 09:34:35AM +0100, Colin Ian King wrote:
> The kmalloc failure message is just noise. Remove it and
> replace -EFAULT with -ENOMEM as standard for out of memory
> allocation error returns.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V1: remove trailing space after \n
> V2: remove entire message, originally just removed a trailing space
> V3: replace -EFAULT with -ENOMEM
> V4: send correct fix for V3, actually return -ENOMEM
> ---
> 
>  drivers/char/tpm/eventlog/tpm1.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index 12ee42a31c71..e7913b2853d5 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -257,11 +257,8 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
>  	    (unsigned char *)(v + sizeof(struct tcpa_event));
>  
>  	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
> -	if (!eventname) {
> -		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
> -		       __func__);
> -		return -EFAULT;
> -	}
> +	if (!eventname)
> +		return -ENOMEM;
>  
>  	/* 1st: PCR */
>  	seq_printf(m, "%2d ", do_endian_conversion(event->pcr_index));
> -- 
> 2.49.0
> 

Ya, I think this make sense.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

