Return-Path: <linux-integrity+bounces-5003-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB52A479CA
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 11:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C847D16C58E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79B227E9F;
	Thu, 27 Feb 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a55WvY9y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8A1E833A;
	Thu, 27 Feb 2025 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650894; cv=none; b=iJgnwmzeehX96c/6tLTgc32U3T+nRIXMBrwer4qEPBjaO3MsSJHFJe0Hyd5L1DU8+PBDzNKw53tEYfbr3tfaQxa/DA3VBlSKhlFN912kOyrlWFr2nF8OUzXF0TuRHPhv7Tiqh4DMdO65b12jiGjCtVnuUluxvXZSSruh4imXZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650894; c=relaxed/simple;
	bh=1n1OiaaN37BCrmYRPde40tuuS4Xcqlkkf3w3yU4hC70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpimICQmLPuGMsy/EtLeBxG6KoGG+QESHGaiuZdoRwJykzb+Fq7qxQHS9xVO/sAwAsnh68GFZl5D6vZPjyflUs8LtDpci/d9fYQKXotF9VXw5V6kuB0dw/ZW65NDeUUrKSITtz2djJkEXSRdMsZvR2Yyx3hKiaO289SukJxLIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a55WvY9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906DAC4CEDD;
	Thu, 27 Feb 2025 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740650893;
	bh=1n1OiaaN37BCrmYRPde40tuuS4Xcqlkkf3w3yU4hC70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a55WvY9yQcKC6PrYjShqh4ox6SoFC9GhDogEFVRQIgOC6bLHsCimgRhOYUf4VpF3I
	 FUl5p6sjs3Y/Qw9njeQtjdYdbt9lq5twAuSWJ1eFfmyOxenLzMpJsd/sioPUvE/N9A
	 3FKTOR9xDJuy5cjojp7jTgJAKvOT1cwE7vz0dYBNI0xjsmgh+m3YcFLnA8VW8BiT4O
	 gNA/VheOH5h84z39CB43vdDvXfLdG62ggKCyJOF3INzYKMdTkCkcDeaIBvbi8oHfZr
	 1/NPIx3S0gydLW9bnLm5+nPHBLJ1qGsRJR3QIp2VmLnz5Ic9rFTni6QnYOQweXd/sb
	 50tKIULl8VwUg==
Date: Thu, 27 Feb 2025 15:38:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: ftpm_tee: remove incorrect of_match_ptr annotation
Message-ID: <Z8A5h3WlNFjfNHMT@sumit-X1>
References: <20250225163718.4169649-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225163718.4169649-1-arnd@kernel.org>

On Tue, Feb 25, 2025 at 05:37:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=1 shows a warning about of_ftpm_tee_ids being unused when
> CONFIG_OF is disabled:
> 
>     drivers/char/tpm/tpm_ftpm_tee.c:356:34: error: unused variable 'of_ftpm_tee_ids' [-Werror,-Wunused-const-variable]
> 
> Drop the unnecessary of_match_ptr().
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> An earlier version had this combined with other changes, I made it
> a separate patch now
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@kernel.org>

-Sumit

> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 139556b21cc6..8d9209dfc384 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -362,7 +362,7 @@ MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
>  static struct platform_driver ftpm_tee_plat_driver = {
>  	.driver = {
>  		.name = "ftpm-tee",
> -		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
> +		.of_match_table = of_ftpm_tee_ids,
>  	},
>  	.shutdown = ftpm_plat_tee_shutdown,
>  	.probe = ftpm_plat_tee_probe,
> -- 
> 2.39.5
> 
> 

