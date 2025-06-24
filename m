Return-Path: <linux-integrity+bounces-6505-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690AAE7363
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 01:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B165A049D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jun 2025 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51225B1F9;
	Tue, 24 Jun 2025 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHwwrfCy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E1219E0;
	Tue, 24 Jun 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808612; cv=none; b=IVsdog/ggwELIJrzeqv79oWfHtAsMRjp+qTNGTej7KIqOfKl4E301mkjJ0b/rB/JCwM+Dsoaiw33Orv6QMFWZrcii0wGXgMEUNwErA4YaytjXfNd3cwhkF9RV7DpBWXudAjm6wTNwJtZYuOzUkVtghfHeshOaCcXAWbXXWeFJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808612; c=relaxed/simple;
	bh=O7gUVsiIlylvvNC3RSqE8rBUotK/U95fpKbW95m9p58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG/MDkMoDP5D3Du194EJUuLIYyn6D3B8alvKauyhrros2ivl9FC+fJt6M9ASJKbba5liSPipwQqSjFuWQ6aRDE1xd989Ab78Vqi8hxicJDI3Z0m3R0xZ4xF9JIPEA527gPVhxCoyqnJLM2f9k4dsrM7fQpR6yJRuJbzPOcgPc6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHwwrfCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC17C4CEE3;
	Tue, 24 Jun 2025 23:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808611;
	bh=O7gUVsiIlylvvNC3RSqE8rBUotK/U95fpKbW95m9p58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHwwrfCyEPK1ZvwufktAdST/5SL1Dyk5N2PfWoDnXP8YCHiamCGRPPk52K1osjc82
	 w+Bh0mYdEW2connnnt7i0zSVDB6cCLPFlNxcWIHGLW6aNW11v42BxHWWdf1JMoj706
	 kdTWYNvfom/3ZMgA88KjL9scMIQ2tw8wDExlwn/07bIsLvleUqV2wSC7jCCFEF3kpH
	 Adu+IIjCgkhRo06OByzM327Ov8OlSp2YoCTxHKollTyWLNuTGDAvG5NJtb/xozMnhU
	 70bt6tx/xI7Nd6574PoWiphu1OZkp/ffPnYb6x7WVI9s+BhM9Rx/M3suZfAz84IaHE
	 +q3Egn2jTI2tQ==
Date: Wed, 25 Jun 2025 02:43:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Replace scnprintf() with sysfs_emit() and
 sysfs_emit_at() in sysfs show functions
Message-ID: <aFs4H0gT286-cmvC@kernel.org>
References: <20250619123707.399022-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619123707.399022-1-chelsyratnawat2001@gmail.com>

On Thu, Jun 19, 2025 at 05:37:07AM -0700, Chelsy Ratnawat wrote:
> Replace calls to scnprintf() with sysfs_emit() and sysfs_emit_at() in
> sysfs show functions. These helpers are preferred in sysfs callbacks
> because they automatically handle buffer sizing (PAGE_SIZE) and
> improve safety and readability.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>

Some comments about the commit message.

Don't use "readability" as an argument as it is something that we cannot
measure, and thus useless documentation.

I neither don't understand "PAGE_SIZE" in the parentheses, or how it
"connects" to the sentence. And what do you mean exactly by safety?

Off-topic'ish:

In the Jargon world, safety is actually different than security :-)
Commercial airline planes have great safety (through redundancy)
and not as great (information) security. Just to reflect why
"safety" is neither an argument ...


> ---
>  drivers/char/tpm/tpm_ppi.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index bc7b1b4501b3..421c6264bac9 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -52,7 +52,7 @@ static ssize_t tpm_show_ppi_version(struct device *dev,
>  {
>  	struct tpm_chip *chip = to_tpm_chip(dev);
>  
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", chip->ppi_version);
> +	return sysfs_emit(buf, "%s\n", chip->ppi_version);
>  }
>  
>  static ssize_t tpm_show_ppi_request(struct device *dev,
> @@ -87,11 +87,11 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
>  		else {
>  			req = obj->package.elements[1].integer.value;
>  			if (tpm_ppi_req_has_parameter(req))
> -				size = scnprintf(buf, PAGE_SIZE,
> +				size = sysfs_emit(buf,
>  				    "%llu %llu\n", req,
>  				    obj->package.elements[2].integer.value);
>  			else
> -				size = scnprintf(buf, PAGE_SIZE,
> +				size = sysfs_emit(buf,
>  						"%llu\n", req);
>  		}
>  	} else if (obj->package.count == 2 &&
> @@ -100,7 +100,7 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
>  		if (obj->package.elements[0].integer.value)
>  			size = -EFAULT;
>  		else
> -			size = scnprintf(buf, PAGE_SIZE, "%llu\n",
> +			size = sysfs_emit(buf, "%llu\n",
>  				 obj->package.elements[1].integer.value);
>  	}
>  
> @@ -211,9 +211,9 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
>  	}
>  
>  	if (ret < ARRAY_SIZE(info) - 1)
> -		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret, info[ret]);
> +		status = sysfs_emit(buf, "%d: %s\n", ret, info[ret]);
>  	else
> -		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret,
> +		status = sysfs_emit(buf, "%d: %s\n", ret,
>  				   info[ARRAY_SIZE(info)-1]);
>  	return status;
>  }
> @@ -255,22 +255,22 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>  	res = ret_obj[2].integer.value;
>  	if (req) {
>  		if (res == 0)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> +			status = sysfs_emit(buf, "%llu %s\n", req,
>  					   "0: Success");
>  		else if (res == 0xFFFFFFF0)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> +			status = sysfs_emit(buf, "%llu %s\n", req,
>  					   "0xFFFFFFF0: User Abort");
>  		else if (res == 0xFFFFFFF1)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> +			status = sysfs_emit(buf, "%llu %s\n", req,
>  					   "0xFFFFFFF1: BIOS Failure");
>  		else if (res >= 1 && res <= 0x00000FFF)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
> +			status = sysfs_emit(buf, "%llu %llu: %s\n",
>  					   req, res, "Corresponding TPM error");
>  		else
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
> +			status = sysfs_emit(buf, "%llu %llu: %s\n",
>  					   req, res, "Error");
>  	} else {
> -		status = scnprintf(buf, PAGE_SIZE, "%llu: %s\n",
> +		status = sysfs_emit(buf, "%llu: %s\n",
>  				   req, "No Recent Request");
>  	}
>  
> @@ -314,7 +314,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>  		}
>  
>  		if (ret > 0 && ret < ARRAY_SIZE(info))
> -			str += scnprintf(str, PAGE_SIZE, "%d %d: %s\n",
> +			str += sysfs_emit_at(str, "%d %d: %s\n",
>  					 i, ret, info[ret]);
>  	}
>  
> -- 
> 2.47.1
> 

BR, Jarkko

