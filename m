Return-Path: <linux-integrity+bounces-8236-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D4CD20076
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 17:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DC48308BD71
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jan 2026 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3338E113;
	Wed, 14 Jan 2026 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6hJcupa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106FF39E6D6
	for <linux-integrity@vger.kernel.org>; Wed, 14 Jan 2026 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406188; cv=none; b=KvThBm8S5AIEumZnCXzMAWpY4DIr/sxb4Atc1iY2IAlmqX+78v369T1BnWpEsk4SnRMDrsVCefeCbHY71nn1jrqMdgVIgqO9dRK/7JRmm67tdCF0yVP3CblLD80glP67FKm1wwo/9FK2gonStCGstPoDSd6+GJ7pDEOKfC17z/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406188; c=relaxed/simple;
	bh=0GHb5Xg/OscfxB5PiZKprjQmGj16aAynMKilSPEB3pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/nqQxkzpgg0GiRl0esjedp4rPur5erJiCaVLgNJLlKoaNabkSAQWwDsJ5HA4wAQ8zvwxL1q+m0PBTwvEeoUNR37tvaAN7Vn/3RS+dbTJHe1tFmPqH5/Apogql1zg4gymkVcStMLGERXnmUtWY4t+kqyJwzTzo6wpC/nMUxzUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6hJcupa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DF5C19424;
	Wed, 14 Jan 2026 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406187;
	bh=0GHb5Xg/OscfxB5PiZKprjQmGj16aAynMKilSPEB3pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6hJcupalTL945Lbqa/YOWTlmoMXsqay0sTzPnglCHoPogNZVQd870abGa2q2DRki
	 6hRHnN9ujFBGN1QGYPREES7rQyBixAnTs835ep/qefcfd0HYaRe5ya7oCQhhApP8Qw
	 dirToSaOK2jIUbc6mqA71kGYxBPdOMIBTwUgMvcqSeM6Un0nUjT3yiTGeBjDP/h0DZ
	 0VRVCmE6BGdWdKOeCCRekwkECyosdaLvB6B+h5hCbXGXfi/mf0J6XKlMEPLfPhOKa6
	 RCXST8jyKrqG3FqeoiLxBUaZou/PmyjxUOknHA34jJU4JhICspXJZfD4JPtVuhyWIU
	 3kt1i0oTmKbPg==
Date: Wed, 14 Jan 2026 17:56:23 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	linux-integrity@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix kdoc after function renames
Message-ID: <aWe8p47KBwB9BASI@kernel.org>
References: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>

On Tue, Jan 13, 2026 at 03:38:15PM +0100, Uwe Kleine-König wrote:
> Recently ftpm_tee_probe() and ftpm_tee_remove() grew a suffix in their
> function name but I failed to adapt the kernel doc when doing so. This
> change aligns the kernel doc to the actual function name (again).
> 
> Fixes: 92fad96aea24 ("tpm/tpm_ftpm_tee: Make use of tee bus methods")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601132105.9lgSsC4U-lkp@intel.com/
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 20294d1953a3..b82490439633 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -163,7 +163,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
>  }
>  
>  /**
> - * ftpm_tee_probe() - initialize the fTPM
> + * ftpm_tee_probe_generic() - initialize the fTPM
>   * @dev: the device description.
>   *
>   * Return:
> @@ -266,7 +266,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
>  }
>  
>  /**
> - * ftpm_tee_remove() - remove the TPM device
> + * ftpm_tee_remove_generic() - remove the TPM device
>   * @dev: the device description.
>   *
>   * Return:
> 
> base-commit: 92fad96aea24fc19abe1eae2249402b61de3a3e2
> -- 
> 2.47.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

