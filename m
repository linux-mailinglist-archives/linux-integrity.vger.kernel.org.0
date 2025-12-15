Return-Path: <linux-integrity+bounces-7980-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E5CBCCA0
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 08:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26BB300D48C
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7696931355A;
	Mon, 15 Dec 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKoIYD90"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552E31354E;
	Mon, 15 Dec 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784167; cv=none; b=JYcS/8J7OuM7/chrcQvwp3NMtEv/V2kt0rShrFXBm8OTYdE31Us4Bq38G8cRfbNAPg1xt2Pg0+vW+aq7JGjNghJtjgATCNlbkILE1jOK8RCaA6Xu7rWJ9mZFp5yMkuPZ0HLNQL0zbNK6n407EaRfKsRHhzCrthjRMXNuLnw3YjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784167; c=relaxed/simple;
	bh=SNNUq7KU8x7V29ijpjlfv//eZVaSmLl/pwwin6AI2Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9FYAVQAd7nmvIbGEaFduRFn8GzB8enKMree6V1mbnFzygQ2LOsPhRxSZGZDbUH7RujTOJqjHIZaojPYckYFADPnJFNqEANSefu30obzQMfyRZ4H1zCxhkPV3ZQpW0ZNtImj1ynT1y7B7l9xDU6TflNZLmsVfHtGcc/pD32jab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKoIYD90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9B0C4CEF5;
	Mon, 15 Dec 2025 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784167;
	bh=SNNUq7KU8x7V29ijpjlfv//eZVaSmLl/pwwin6AI2Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKoIYD90uMhvL1iKT6lsyEsfKo1ciIMwa87/Kxr9OUecFwxG7gh9QHOVQiGdWmvRb
	 VVD/JYfzHq1k7pZ5iDCgzZ+WMxUXYRlXqhsAOSxlOL547VDldypSJD3eBJLxbHVS0V
	 /I8FhmP8jqpM+6rX2VTe/DG33t8qA/CqMHoNkAZL7c+n/uMpWVlioZ9gLGyZqm5g/5
	 E8ob/bFFCirmOEx3fE2APOW59zAZ91UxMtUNQ6QK7ACtrlys8omR6RxIxeH/pjsCFa
	 uYNDcVAe7zMj0LxOCU0CZ5Sj29V6Tbuv/gokKX1TY/76V0XxYKHS8fJaqw8a+3ehr1
	 AX9q/Af5TPLVg==
Date: Mon, 15 Dec 2025 16:36:00 +0900
From: Sumit Garg <sumit.garg@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/17] KEYS: trusted: Migrate to use tee specific
 driver registration function
Message-ID: <aT-6YJJRaLq5BcvQ@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <0b3ce259fa26e59ef24a91ca070e2b08feeede82.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b3ce259fa26e59ef24a91ca070e2b08feeede82.1765472125.git.u.kleine-koenig@baylibre.com>

On Thu, Dec 11, 2025 at 06:15:08PM +0100, Uwe Kleine-König wrote:
> The tee subsystem recently got a set of dedicated functions to register
> (and unregister) a tee driver. Make use of them. These care for setting the
> driver's bus (so the explicit assignment can be dropped) and the driver
> owner (which is an improvement this driver benefits from).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> index aa3d477de6db..3cea9a377955 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -264,7 +264,6 @@ static struct tee_client_driver trusted_key_driver = {
>  	.id_table	= trusted_key_id_table,
>  	.driver		= {
>  		.name		= DRIVER_NAME,
> -		.bus		= &tee_bus_type,
>  		.probe		= trusted_key_probe,
>  		.remove		= trusted_key_remove,
>  	},
> @@ -272,12 +271,12 @@ static struct tee_client_driver trusted_key_driver = {
>  
>  static int trusted_tee_init(void)
>  {
> -	return driver_register(&trusted_key_driver.driver);
> +	return tee_client_driver_register(&trusted_key_driver);
>  }
>  
>  static void trusted_tee_exit(void)
>  {
> -	driver_unregister(&trusted_key_driver.driver);
> +	tee_client_driver_unregister(&trusted_key_driver);
>  }
>  
>  struct trusted_key_ops trusted_key_tee_ops = {
> -- 
> 2.47.3
> 

