Return-Path: <linux-integrity+bounces-8001-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 753ACCC00F3
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 23:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81133300F5BE
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7E2D9EE8;
	Mon, 15 Dec 2025 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS6VJZ5P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FECD296BC0;
	Mon, 15 Dec 2025 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765836080; cv=none; b=AGmBfygtzBf/6AFDYxROaOfuWBcvLmwo1CQFDb8CRDWJOJT6OK+epdp8tWaO4hYPu4Eu5l29mjG3eupRuehN5FhfYQ7Dlwe9Wi8ZN8oJ2bPTl/UBKSQPWJNqNTp+NY/oiL/tStkLvplPDJm6AzOoxA98KhpcEqnMUcNJs6zTDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765836080; c=relaxed/simple;
	bh=gAyZ9dbbvlTKeak8iAsSIImqvtdOTUL/71rbHjPUa6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpuf7K0OWGigSgBSOUpTRI5VUoyhyIMVLP5Z3CO0UlxuZgjDus2bGc3GCv4UaJkbZeyjA/TB0S1jIKGPB6hUBcul/Rhl3Pdvf/Ao94zfC04BHYtpJOjFnWNdUJSNs48MAOJLc+M8TyJDJD5Qbd1RlDNoDKNyEYV8zMevizkdaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS6VJZ5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9FDC4CEF5;
	Mon, 15 Dec 2025 22:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765836080;
	bh=gAyZ9dbbvlTKeak8iAsSIImqvtdOTUL/71rbHjPUa6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aS6VJZ5PrfH/K6eL/rM/XNgxf76zYlRkVZQd21pGJfpgcpISpHFc76y9WEtTG6Yz4
	 rhgdG2PlMcP34UrS2bzOvWgD4WdO+10Qfe3OfE+PK+Cd3HNhMRFgoRh0clQDABIutw
	 ezJ9Hh3uamekOqwkJxRkKDZ/LKs+lEIi7zXa2nUVApEAg/+I4ewmr2pmM7aujDleue
	 rtgQKrwRbGNIksnX/3Df7ENeqEOo9fZe26g7abk2jhccIXu22QklpLceiwd8Et6y7t
	 2QagNvb7KjegK+/x5rate6fHLWZjPa7edrhDbDSd4WapO6rgVvKuzc4Itt+ZX8HDX2
	 dkI9XdLKCfF0Q==
Date: Tue, 16 Dec 2025 00:01:16 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 14/17] KEYS: trusted: Migrate to use tee specific
 driver registration function
Message-ID: <aUCFLJe6k_5UAmM0@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <687c004c32718ba7044ffa9165f33842267a745d.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <687c004c32718ba7044ffa9165f33842267a745d.1765791463.git.u.kleine-koenig@baylibre.com>

On Mon, Dec 15, 2025 at 03:16:44PM +0100, Uwe Kleine-König wrote:
> The tee subsystem recently got a set of dedicated functions to register
> (and unregister) a tee driver. Make use of them. These care for setting the
> driver's bus (so the explicit assignment can be dropped) and the driver
> owner (which is an improvement this driver benefits from).
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

