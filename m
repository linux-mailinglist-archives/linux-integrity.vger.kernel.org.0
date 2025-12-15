Return-Path: <linux-integrity+bounces-8003-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB0CC020A
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 23:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CF5300DA52
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 22:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56392417F2;
	Mon, 15 Dec 2025 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtjJv3Sb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC817A31C;
	Mon, 15 Dec 2025 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765838904; cv=none; b=MynLCGDEwDwlJ8MMLwjxVUHZ7GUim+z3yW1ND971zUUIWdwNwyC0yCMR7obkjFB2gBCYhGuFiwHQL69EfoxbM20ysMvDhjqe9vAbkzvA8PA+xAC9oZbM7LxYRC885glz0OoJXEdhRnRC7V814soh5gtZ5e8C9nOcpTGIOn3V3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765838904; c=relaxed/simple;
	bh=gzI/8qh+r5aIKGfXOsjin56/O6OgyOXJRRtbBvPR/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvtrsWnCMS3MWpyPrZN/V4JnfnYDWZsypFLwXg18mh00pM2ZZYF0WxpKHTbFTMij2M9YE4NgIySUuBIZpWxRpupTeSGjuojWs+9SvKSDYXbVt4xg8x+zVxd0PEKRTLyqQRd4g0YO+F31KlJ3H3UgASCaBf6h3+nCqH2KUmyXDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtjJv3Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B8EC4CEF5;
	Mon, 15 Dec 2025 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765838904;
	bh=gzI/8qh+r5aIKGfXOsjin56/O6OgyOXJRRtbBvPR/SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtjJv3SbNRWuU26ZrNudj4avpvMZXsHcSZ11zSfe9+nQCZkjsOkeJlX20wsy708zr
	 hKEeZG3zWtsoNfyOiNwP3MA5ocmqyjtDoXBSMpRix93jg1eHBBXUkazMQLTekszbff
	 U94MIz2MLpAoded/RyRCWR+k1YDKIMq1K+q8rQUgVf/k2CRl61asQnYKCyktOO2sJL
	 nhfRR2FWWyOxS6r/PeIvUXbM5bjyHtdm6SkGmojSgoFMihL76cH/UK0qh29RL+wzwr
	 nDFB0GC3Jy1xGH7Dxd5Gcbtz+GaFYA4zQ/7AQTSQNz7we6MkZLIbr2yDK5TzXyeWuo
	 tIgU6ZPE10qBg==
Date: Tue, 16 Dec 2025 00:48:20 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@kernel.org>, linux-integrity@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 16/17] tpm/tpm_ftpm_tee: Make use of tee specific
 driver registration
Message-ID: <aUCQNO1ovSifxO9F@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <5c8d6d420338d0d028f785680520d375e8a49673.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c8d6d420338d0d028f785680520d375e8a49673.1765791463.git.u.kleine-koenig@baylibre.com>

On Mon, Dec 15, 2025 at 03:16:46PM +0100, Uwe Kleine-König wrote:
> tee_client_driver_register() is typed more strongly and cares about
> assigning the driver's bus. Similar for tee_client_driver_unregister().
> 
> Make use of these functions.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 4e63c30aeaf1..e5fbc70b0eca 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -338,7 +338,6 @@ static struct tee_client_driver ftpm_tee_driver = {
>  	.id_table	= optee_ftpm_id_table,
>  	.driver		= {
>  		.name		= "optee-ftpm",
> -		.bus		= &tee_bus_type,
>  		.probe		= ftpm_tee_probe,
>  		.remove		= ftpm_tee_remove,
>  	},
> @@ -352,7 +351,7 @@ static int __init ftpm_mod_init(void)
>  	if (rc)
>  		return rc;
>  
> -	rc = driver_register(&ftpm_tee_driver.driver);
> +	rc = tee_client_driver_register(&ftpm_tee_driver);
>  	if (rc) {
>  		platform_driver_unregister(&ftpm_tee_plat_driver);
>  		return rc;
> @@ -364,7 +363,7 @@ static int __init ftpm_mod_init(void)
>  static void __exit ftpm_mod_exit(void)
>  {
>  	platform_driver_unregister(&ftpm_tee_plat_driver);
> -	driver_unregister(&ftpm_tee_driver.driver);
> +	tee_client_driver_unregister(&ftpm_tee_driver);
>  }
>  
>  module_init(ftpm_mod_init);
> -- 
> 2.47.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

