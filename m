Return-Path: <linux-integrity+bounces-7982-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12403CBCCB5
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 08:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A89B330054A8
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF621328B43;
	Mon, 15 Dec 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/Nz8fNF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6F328633;
	Mon, 15 Dec 2025 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784302; cv=none; b=OVym/58rxTdLztJ8waLhs3LuNyU8J3s4vYso0VQatsGMZ4L8xKg+MKmsSpyH5JljEMT8t2pH9kyySJWt+i/eaPA4JpYAdDtqHIAjhuYdtsRCg1u64BFAdkI04TCXT8J5XBDmTLfl630Pa3HfTKfBNdIKPZSquEGJ5A3k478PbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784302; c=relaxed/simple;
	bh=U3cC7k6Isie63Z6FqsnXxtE9EV4pc6zGst140+xRdL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJKFB9f72ac0Ph4fEn20CC27VUVm25BSxqVxM5XjRKm6ip9iM/+tFhgL8F9W9/7xQYCe6uO4Wq7kyYA4dCRByWfTba/J92lj/pK/PIaWbFQMcnWgi5epC7SsNohq8HpwQ3oKEaL54noKfDailj1g+S4xVeBLu92/HsTrtqEgj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/Nz8fNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E417FC4CEF5;
	Mon, 15 Dec 2025 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784301;
	bh=U3cC7k6Isie63Z6FqsnXxtE9EV4pc6zGst140+xRdL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/Nz8fNFmrBJ01MnfF60HKhK2CtEYyA5zr2dg1xtfZcjLUqHdKlu/NwdTE7x2Y7+H
	 vc0J15aFZS8dRbATt2vKNwg/m4DDDPJdBzqVfPRyrb8n9yybsScx1jDn8MowHO0tF5
	 G4DQn4BK8SuxuDAgUdL1IvTdj19rTTHc9WXsF36L703N7Vp6LIYm2kR7+NKMulTtUl
	 NHrep+wTJrHdZSQ9khs5KyZoZUrHrYv/qqJneBkvTyNLUATRokQZ0NTlO0irMrD+yW
	 9sRecq2SOtd8FS7m6j5byB4u5Upc8JQyL8o5ft5umBYjgqc9/ZZ8thzeDNfcn+BWk1
	 ZDrnO/uIZXg5g==
Date: Mon, 15 Dec 2025 16:38:16 +0900
From: Sumit Garg <sumit.garg@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 16/17] tpm/tpm_ftpm_tee: Make use of tee specific
 driver registration
Message-ID: <aT-66JZEVUmCUBc1@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <812e5c580599b27d4f752ba8cfc35ad5371ab545.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <812e5c580599b27d4f752ba8cfc35ad5371ab545.1765472125.git.u.kleine-koenig@baylibre.com>

On Thu, Dec 11, 2025 at 06:15:10PM +0100, Uwe Kleine-König wrote:
> tee_client_driver_register() is typed more strongly and cares about
> assigning the driver's bus. Similar for tee_client_driver_unregister().
> 
> Make use of these functions.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

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
> 

