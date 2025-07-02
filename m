Return-Path: <linux-integrity+bounces-6584-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D50AF6416
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4337A3A3BD7
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402FF242D7F;
	Wed,  2 Jul 2025 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOkCzqY0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166422DE705;
	Wed,  2 Jul 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492188; cv=none; b=Lc3H6qHISWk3Zci3LAj71hUWoIc6JvG3rG8jnqC7fFqG3HUt0YYBgztnXB+kLw6tyq3jUtSC6gzXSqH7tDrsrNE4vHwMXwFTLVqktHXxwvnKN6e+Di2C8h9AedsZe/TKPhLaI7p5NVGW9aC8q2OWT5B8P6MXoBg8BgsxyVQmL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492188; c=relaxed/simple;
	bh=+Q7ow2BtQ9RPcDzD+75SZg1MSy+L7HBftUp7mch2u8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV5hkdQImcMb64k8AXeLDgfYxhRwDyxVNt3AxoinsR6ZaWWPloZJJFAYcRTfBR95Sqvz+7d/WPP26K5nhQLO8gMFbIexYONAEgyIz9jndFOUFlelwpkMSd3wOtylwMcFt1ikNUA4mXj074gxrTWuj36nzY0gpoIUZC3kUI0Ubyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOkCzqY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F04AC4CEE7;
	Wed,  2 Jul 2025 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751492187;
	bh=+Q7ow2BtQ9RPcDzD+75SZg1MSy+L7HBftUp7mch2u8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOkCzqY05hTeL/CZ/jvQECf60LY51dIf8nFMAr9nszpNCCbchQe80uWwdYcks3icL
	 5MSt9Wg8F/woBfkio/l1ExdV8xS97d28BORKH/sKEUk3PhiUl0IqNWI1w6XI8YEjGP
	 VgtFwCrxgQwPZiKPBMBsOVug9WCugQjhs4Ejqs/WBhiPACPHe+d0zlv+5mSQh9T8li
	 LW8HZvV8JzXp0bdqOKI4lC3bQDIvyQZGPwoi2R+PXt565vHmhAC0Zwa+LuWqZmEzNB
	 nyLaF5wznDa6VOsu055KAjBYceHhA+4cavod6taRuSRfTW9gfCb2wm+lk7ui8GaK46
	 UlwZYw5J7s2Yw==
Date: Thu, 3 Jul 2025 00:36:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tpm: Replace scnprintf() with sysfs_emit() and
 sysfs_emit_at() in sysfs show functions
Message-ID: <aGWmV6DLiIc8f7N6@kernel.org>
References: <20250626125130.28553-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626125130.28553-1-chelsyratnawat2001@gmail.com>

On Thu, Jun 26, 2025 at 05:51:30AM -0700, Chelsy Ratnawat wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formating the value to be
> returned to user space. So replace scnprintf() with sysfs_emit().
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
> Changes in v5 : 
> - Fix alignment and coding style problems
> 
>  drivers/char/tpm/tpm_ppi.c | 52 ++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index bc7b1b4501b3..d53fce1c9d6f 100644
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
> @@ -87,12 +87,10 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
>  		else {
>  			req = obj->package.elements[1].integer.value;
>  			if (tpm_ppi_req_has_parameter(req))
> -				size = scnprintf(buf, PAGE_SIZE,
> -				    "%llu %llu\n", req,
> -				    obj->package.elements[2].integer.value);
> +				size = sysfs_emit(buf, "%llu %llu\n", req,
> +						  obj->package.elements[2].integer.value);
>  			else
> -				size = scnprintf(buf, PAGE_SIZE,
> -						"%llu\n", req);
> +				size = sysfs_emit(buf, "%llu\n", req);
>  		}
>  	} else if (obj->package.count == 2 &&
>  	    obj->package.elements[0].type == ACPI_TYPE_INTEGER &&
> @@ -100,8 +98,8 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
>  		if (obj->package.elements[0].integer.value)
>  			size = -EFAULT;
>  		else
> -			size = scnprintf(buf, PAGE_SIZE, "%llu\n",
> -				 obj->package.elements[1].integer.value);
> +			size = sysfs_emit(buf, "%llu\n",
> +					  obj->package.elements[1].integer.value);
>  	}
>  
>  	ACPI_FREE(obj);
> @@ -211,10 +209,10 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
>  	}
>  
>  	if (ret < ARRAY_SIZE(info) - 1)
> -		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret, info[ret]);
> +		status = sysfs_emit(buf, "%d: %s\n", ret, info[ret]);
>  	else
> -		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret,
> -				   info[ARRAY_SIZE(info)-1]);
> +		status = sysfs_emit(buf, "%d: %s\n", ret,
> +				    info[ARRAY_SIZE(info) - 1]);
>  	return status;
>  }
>  
> @@ -255,23 +253,23 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>  	res = ret_obj[2].integer.value;
>  	if (req) {
>  		if (res == 0)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> -					   "0: Success");
> +			status = sysfs_emit(buf, "%llu %s\n", req,
> +					    "0: Success");
>  		else if (res == 0xFFFFFFF0)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> -					   "0xFFFFFFF0: User Abort");
> +			status = sysfs_emit(buf, "%llu %s\n", req,
> +					    "0xFFFFFFF0: User Abort");
>  		else if (res == 0xFFFFFFF1)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> -					   "0xFFFFFFF1: BIOS Failure");
> +			status = sysfs_emit(buf, "%llu %s\n", req,
> +					    "0xFFFFFFF1: BIOS Failure");
>  		else if (res >= 1 && res <= 0x00000FFF)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
> -					   req, res, "Corresponding TPM error");
> +			status = sysfs_emit(buf, "%llu %llu: %s\n",
> +					    req, res, "Corresponding TPM error");
>  		else
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
> -					   req, res, "Error");
> +			status = sysfs_emit(buf, "%llu %llu: %s\n",
> +					    req, res, "Error");
>  	} else {
> -		status = scnprintf(buf, PAGE_SIZE, "%llu: %s\n",
> -				   req, "No Recent Request");
> +		status = sysfs_emit(buf, "%llu: %s\n",
> +				    req, "No Recent Request");
>  	}
>  
>  cleanup:
> @@ -284,7 +282,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>  {
>  	int i;
>  	u32 ret;
> -	char *str = buf;
> +	int len = 0;
>  	union acpi_object *obj, tmp;
>  	union acpi_object argv = ACPI_INIT_DSM_ARGV4(1, &tmp);
>  
> @@ -314,11 +312,11 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>  		}
>  
>  		if (ret > 0 && ret < ARRAY_SIZE(info))
> -			str += scnprintf(str, PAGE_SIZE, "%d %d: %s\n",
> -					 i, ret, info[ret]);
> +			len += sysfs_emit_at(buf, len, "%d %d: %s\n",
> +					     i, ret, info[ret]);
>  	}
>  
> -	return str - buf;
> +	return len;
>  }
>  
>  static ssize_t tpm_show_ppi_tcg_operations(struct device *dev,
> -- 
> 2.47.1
> 

Looks good to me.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

