Return-Path: <linux-integrity+bounces-8002-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638FCC0152
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 23:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5634E3013E96
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301502E54DE;
	Mon, 15 Dec 2025 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUKm5xfU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002341DED63;
	Mon, 15 Dec 2025 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765836263; cv=none; b=X9qNo8RiGzDTGdcQXiVLRZmhSKF7VnOLyYjO4WJaDDRgQt4sovYbUOMkmZs1M49PfbiR/OL2kFsay95/sVkFdP3Q0gJVS2VGA/s8V6OUBVY9hVx6P9MScOIFJpMwjBKT1RHeAVCArEq+jRowEZUjOfanydWmw+VM5lD33wRLcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765836263; c=relaxed/simple;
	bh=vGjzAFwNR6AwMM6AHlInRy9NxfEhAAxRUMwgbnwUrRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcuZXgLnKHBWekSjnKygxc/Ucb5G4vnJ8/M6jr2iT1TGxhKlXVuxqyuJR61GTasQN96Y+y3ZzDUojwb/hq0CxuWdqNJZ9D2qAPYjGxV4yWVWrX0cQ/CqLlu9jC0quh3XDvQ6c6gc7HhykrTO1jEIIekb61Jk2prvaOwNSS8wd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUKm5xfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAC0C4CEF5;
	Mon, 15 Dec 2025 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765836262;
	bh=vGjzAFwNR6AwMM6AHlInRy9NxfEhAAxRUMwgbnwUrRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUKm5xfUsV5V4rQCL33sfiBzcllYGtrINx8fdzN1II6y8s9L8bFrS/WjreGUe2mF3
	 LTRi7dAJIUKT4ezPv2jS8o4tQDUG0Dnk/8ObVQnvpo6dy3kLKpyn+DrYuPyHa3tbXO
	 0zkUeWtgS0WQH8a4oFMLXnff6NTWFbcaI+9Bely9b/wYt+ANdxw+y11zrakHvYrs9M
	 fTJQb2OHTokhmcpxPMagNeHIEBIzuZ++htRPAIpnFObryhskdWwadJExa02VBVM0L/
	 beaDosIYe76m6M4vdTs8wxC4bSLA+ZVEv4LMM8VoRb3AdlhWbXMg2jJLnOUdS6mJ4P
	 addsMDYiks5Fg==
Date: Tue, 16 Dec 2025 00:04:18 +0200
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
Subject: Re: [PATCH v2 15/17] KEYS: trusted: Make use of tee bus methods
Message-ID: <aUCF4hW5xkvpv9lt@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <ad8aaa343c1e8523659259290f63aea8be906977.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad8aaa343c1e8523659259290f63aea8be906977.1765791463.git.u.kleine-koenig@baylibre.com>

On Mon, Dec 15, 2025 at 03:16:45PM +0100, Uwe Kleine-König wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
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

I'm sorry but cannot help saying but these not being in reverse tree
order hurts my eyes ;-)

I.e., I'd personally move declaration of sess_arg right after rng_device
despite being additional change to the scope of the patch.

That said, Sumit has the ultimate veto right here, and this not any kind
of fault in this patch so I will obviously ack the patch;

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


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

BR, Jarkko

