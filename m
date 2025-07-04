Return-Path: <linux-integrity+bounces-6615-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004F2AF85CF
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 04:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1625482BC
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 02:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF621DEFF3;
	Fri,  4 Jul 2025 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDbUww+P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535554207F;
	Fri,  4 Jul 2025 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597930; cv=none; b=LU29m3KyMe2V90OuTDzLdl2Qnh+/rNJ8Qh7QXbJPSOVVeoiQDchhkediEKO//3VMS7vqWTXwKyDeMyzls3q7TWCcbd/C/7JmeDZUL5EZUoYtUsX4xgxQk7+DbF3Smj0B1+0WpOjqyoP4+7B+wftSoW1cxsga/u3r1XpMb1q7Yf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597930; c=relaxed/simple;
	bh=qO9mOBPpvlL4od66vpINa3TB8+oUKIGbu0TsfXlPscI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MakUma4F3xz2v+tQE3iwZ5wtAR7+/SPCD7pT9ti0SAAg/+oMxaB4caKofz/GOui+bd210wtFayziTXT4X7P5VA23Kuz+BOpNTl5SLhCNuICAPOEe8NSMWoaJOAIfCD7kF5OkipJan09Qs/pcvBvIUna/DnJuSFsZTqqXwBnZ0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDbUww+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535A4C4CEE3;
	Fri,  4 Jul 2025 02:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751597929;
	bh=qO9mOBPpvlL4od66vpINa3TB8+oUKIGbu0TsfXlPscI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDbUww+P0vHt0eG/vKEhPKqRHNJUT78diFAcTHIjbs6YdeK+S9PjBwLw02Ksy4/0J
	 pbbAqXNkXl1QqTJhjrj7KSL/j2LkGSxXEKK10ddB54iaqcrUnZkfBt8dv/13hNJmn8
	 INJDloX4XWMVCQw3guZ8HNdKc7dwsJdN759TmRO5M6FJ2hmW3jLZLnZ3CJXkdk3hg6
	 i2ldItQ2rJhdSSDpmFbgyvYjftfleE6tUiq9rNxl6bcKAGjImzFuSqorXTtcjyg9Xi
	 HM6tSahk4cjvD6gTnLt0kJtdrEY8kiknf0oX+EwhsDTqjvh9D/wR3mj5qVCAwyxakE
	 VJjyvMgpvJiQw==
Date: Fri, 4 Jul 2025 05:58:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Use of_reserved_mem_region_to_resource() for
 "memory-region"
Message-ID: <aGdDZodNndTfVEQ2@kernel.org>
References: <20250703183424.2073075-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703183424.2073075-1-robh@kernel.org>

On Thu, Jul 03, 2025 at 01:34:24PM -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/char/tpm/eventlog/of.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index 930fe43d5daf..92cec9722ee4 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -24,16 +24,10 @@
>  
>  static int tpm_read_log_memory_region(struct tpm_chip *chip)
>  {
> -	struct device_node *node;
>  	struct resource res;
>  	int rc;
>  
> -	node = of_parse_phandle(chip->dev.parent->of_node, "memory-region", 0);
> -	if (!node)
> -		return -ENODEV;
> -
> -	rc = of_address_to_resource(node, 0, &res);
> -	of_node_put(node);
> +	rc = of_reserved_mem_region_to_resource(chip->dev.parent->of_node, 0, &res);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.47.2
> 

Thanks. It is now applied to my master.

BR, Jarkko

