Return-Path: <linux-integrity+bounces-7981-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1DCBCC97
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 08:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85C763012767
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B794C3148C9;
	Mon, 15 Dec 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgHD24/X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CA313E3A;
	Mon, 15 Dec 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784214; cv=none; b=aOpmXTiLqygcl0t8GOTMX7Op2wX2LiY28XsJxwJtZclAe7r/o9JfwOvfHykWypHp/iKwtUCK/53HAOb3hwI1kpG0OYINXZyq7UmAecGYr6hzrklIO0iRgNAG5ni2u2FFs7D7R6utwFYHMYKvP7NsdyDmudK64I+9cB0JINWwy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784214; c=relaxed/simple;
	bh=2OORDja30gMmDgyUzWDMnzZHy7weS+LKrcxmBaHXsyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXmiNcATkdNKN97ujXuu2xwEMTGtVTxS3mWi5ZvxIoYHREpeY0Erx0zegXq+i5tuGI95NOckSMfLPCEU9CA/o58PiAdQ0B2P0EhxGHZCRL6+fRB3r7U4JY0i4Nu/RtOb3/yu1Di4Yffqbf3lsOZ/+7+vKjxAJjfwV7QjhZ2eXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgHD24/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857EBC4CEF5;
	Mon, 15 Dec 2025 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765784214;
	bh=2OORDja30gMmDgyUzWDMnzZHy7weS+LKrcxmBaHXsyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgHD24/X7wV/312UORX7oPByYndRHEuIcpls3eBGVVuiAKyuZWDBzXNzHyULu2Uqs
	 UJnvdrDkliHw1yJiyUEtsufuGp8afT1ayToFgM1So+/ihBws8tgadsKcRgVXsX5EAR
	 Xrx2037bgdCEmkOGeiv7uqe7VVfUzU3oqbSaVLKMF8hdv3tFxkv4HI/geTeeGOG63X
	 giudcdejoZ1sNxi6PeOggbNSHRsmrQ+zWdGMMpGQNJrSgl5CdWz3dmFW8KQo7BLAdX
	 mnuyplfoCOOi4nO0IEyHPamRjTZqUeP2KQhzCTq2AEok96vLhvHFn7G27+Dm8bgA78
	 OmUZl3pnRLa/A==
Date: Mon, 15 Dec 2025 16:36:46 +0900
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
Subject: Re: [PATCH v1 15/17] KEYS: trusted: Make use of tee bus methods
Message-ID: <aT-6jibmsCK6BPhP@sumit-X1>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <aab4c00b7e89abce7bcd8241c47f3398fb7227f8.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aab4c00b7e89abce7bcd8241c47f3398fb7227f8.1765472125.git.u.kleine-koenig@baylibre.com>

On Thu, Dec 11, 2025 at 06:15:09PM +0100, Uwe Kleine-König wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> index 3cea9a377955..6e465c8bef5e 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -202,9 +202,9 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  		return 0;
>  }
>  
> -static int trusted_key_probe(struct device *dev)
> +static int trusted_key_probe(struct tee_client_device *rng_device)
>  {
> -	struct tee_client_device *rng_device = to_tee_client_device(dev);
> +	struct device *dev = &rng_device->dev;
>  	int ret;
>  	struct tee_ioctl_open_session_arg sess_arg;
>  
> @@ -244,13 +244,11 @@ static int trusted_key_probe(struct device *dev)
>  	return ret;
>  }
>  
> -static int trusted_key_remove(struct device *dev)
> +static void trusted_key_remove(struct tee_client_device *dev)
>  {
>  	unregister_key_type(&key_type_trusted);
>  	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
>  	tee_client_close_context(pvt_data.ctx);
> -
> -	return 0;
>  }
>  
>  static const struct tee_client_device_id trusted_key_id_table[] = {
> @@ -261,11 +259,11 @@ static const struct tee_client_device_id trusted_key_id_table[] = {
>  MODULE_DEVICE_TABLE(tee, trusted_key_id_table);
>  
>  static struct tee_client_driver trusted_key_driver = {
> +	.probe		= trusted_key_probe,
> +	.remove		= trusted_key_remove,
>  	.id_table	= trusted_key_id_table,
>  	.driver		= {
>  		.name		= DRIVER_NAME,
> -		.probe		= trusted_key_probe,
> -		.remove		= trusted_key_remove,
>  	},
>  };
>  
> -- 
> 2.47.3
> 

