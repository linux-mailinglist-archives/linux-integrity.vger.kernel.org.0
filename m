Return-Path: <linux-integrity+bounces-6492-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FBEAE2776
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Jun 2025 07:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F47189E726
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Jun 2025 05:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB819066D;
	Sat, 21 Jun 2025 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lklxg3aA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D019006B;
	Sat, 21 Jun 2025 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750482848; cv=none; b=mF/eXnScN8YTU3Rl0ESzLgM/nQxO/m9fUw2e2CcmZC/dzTrToDzNaKuFUHZRVV8gMhFsMp1XOZg4fD1AUqzC3u8d0I8YwQPdG0HLpC/7jWKcjQj5sPM0gTAxtPqmQtUJxVufEPIHoG1aRFs2WtovQg8e7ro21Iqd20t6463SjWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750482848; c=relaxed/simple;
	bh=Fs13S5mV2N+rapmpO5PMhl2lHEXr1e5vKrcHlEZHAwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZlZ6rYqJ63GrhQJIQq7lSaX0OHlYQnO88YMezwxDgEDSTtIGboyamBaKux7iQAzCNm81eJi075I4cHnfvC2qx4WpE0pnIXEdc/S2L0KG1IzoOyHwmrkA+LsXyBrKzCPYP+NU+xMz8cjYQOKNsbVO5ho9u1QzkSBqrGLqEVjdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lklxg3aA; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id SqY8ult9WtM5zSqY8u8f72; Sat, 21 Jun 2025 07:13:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750482837;
	bh=IYhV88Q6nKwevP/PKhZdWN/QZe4dYz40IUyaHhJ3CI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lklxg3aASpFJJtcsQqG1LQUQ/ZcSCn5T1QcnsoQILED/TWnQNnO9OhF57F3iaM3fH
	 /GMipG+UVB1KbY+oJxeo/XCAOd44294grIvD3ByjY9jyKfEp5Ydh3SPr2LnP6+zXGB
	 CPs2/GX9ECGwSzxbY2KKAIDF4PhE1c2PQzIcN72Mj79rGdj4T7EA7aa4AzRBUO9Xb9
	 qSgThA7gft2uqhlmkWr0uOnzT2Qs/P0YqoCXU/IgsdiHY37MEAu0XnWM/m/PizH5TV
	 cz0kubJvwAkPDdHLqxT1DPXRSSuIm+FYqTF3vvl6vVyBgUZxHByPgdUHQHiY2lojTF
	 C3fw9I9ALomHw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 21 Jun 2025 07:13:57 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <3c63b547-d3fc-40b8-9b7d-61660dc89425@wanadoo.fr>
Date: Sat, 21 Jun 2025 07:13:56 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: Replace scnprintf() with sysfs_emit() and
 sysfs_emit_at() in sysfs show functions
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, peterhuewe@gmx.de,
 jarkko@kernel.org
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250619131312.407615-1-chelsyratnawat2001@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250619131312.407615-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/06/2025 à 15:13, Chelsy Ratnawat a écrit :
> Replace calls to scnprintf() with sysfs_emit() and sysfs_emit_at() in
> sysfs show functions. These helpers are preferred in sysfs callbacks
> because they automatically handle buffer sizing (PAGE_SIZE) and
> improve safety and readability.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
> Changes in v2:
> - Corrected sysfs_emit_at() usage to pass buf as first argument
> 
>   drivers/char/tpm/tpm_ppi.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index bc7b1b4501b3..2c0d1859284d 100644
> --- a/drivers/char/tpm/tpm_ppi.c
> +++ b/drivers/char/tpm/tpm_ppi.c
> @@ -52,7 +52,7 @@ static ssize_t tpm_show_ppi_version(struct device *dev,
>   {
>   	struct tpm_chip *chip = to_tpm_chip(dev);
>   
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", chip->ppi_version);
> +	return sysfs_emit(buf, "%s\n", chip->ppi_version);
>   }
>   
>   static ssize_t tpm_show_ppi_request(struct device *dev,
> @@ -87,11 +87,11 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
>   		else {
>   			req = obj->package.elements[1].integer.value;
>   			if (tpm_ppi_req_has_parameter(req))
> -				size = scnprintf(buf, PAGE_SIZE,
> +				size = sysfs_emit(buf,
>   				    "%llu %llu\n", req,
>   				    obj->package.elements[2].integer.value);
>   			else
> -				size = scnprintf(buf, PAGE_SIZE,
> +				size = sysfs_emit(buf,
>   						"%llu\n", req);

Nitpick: Can fit on the same line now

>   		}
>   	} else if (obj->package.count == 2 &&
> @@ -100,7 +100,7 @@ static ssize_t tpm_show_ppi_request(struct device *dev,
>   		if (obj->package.elements[0].integer.value)
>   			size = -EFAULT;
>   		else
> -			size = scnprintf(buf, PAGE_SIZE, "%llu\n",
> +			size = sysfs_emit(buf, "%llu\n",
>   				 obj->package.elements[1].integer.value);
>   	}
>   
> @@ -211,9 +211,9 @@ static ssize_t tpm_show_ppi_transition_action(struct device *dev,
>   	}
>   
>   	if (ret < ARRAY_SIZE(info) - 1)
> -		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret, info[ret]);
> +		status = sysfs_emit(buf, "%d: %s\n", ret, info[ret]);
>   	else
> -		status = scnprintf(buf, PAGE_SIZE, "%d: %s\n", ret,
> +		status = sysfs_emit(buf, "%d: %s\n", ret,
>   				   info[ARRAY_SIZE(info)-1]);

Nitpick: Alignment could be updated (same for others below)

>   	return status;
>   }
> @@ -255,22 +255,22 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
>   	res = ret_obj[2].integer.value;
>   	if (req) {
>   		if (res == 0)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> +			status = sysfs_emit(buf, "%llu %s\n", req,
>   					   "0: Success");
>   		else if (res == 0xFFFFFFF0)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> +			status = sysfs_emit(buf, "%llu %s\n", req,
>   					   "0xFFFFFFF0: User Abort");
>   		else if (res == 0xFFFFFFF1)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %s\n", req,
> +			status = sysfs_emit(buf, "%llu %s\n", req,
>   					   "0xFFFFFFF1: BIOS Failure");
>   		else if (res >= 1 && res <= 0x00000FFF)
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
> +			status = sysfs_emit(buf, "%llu %llu: %s\n",
>   					   req, res, "Corresponding TPM error");
>   		else
> -			status = scnprintf(buf, PAGE_SIZE, "%llu %llu: %s\n",
> +			status = sysfs_emit(buf, "%llu %llu: %s\n",
>   					   req, res, "Error");
>   	} else {
> -		status = scnprintf(buf, PAGE_SIZE, "%llu: %s\n",
> +		status = sysfs_emit(buf, "%llu: %s\n",
>   				   req, "No Recent Request");
>   	}
>   
> @@ -314,7 +314,7 @@ static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, u32 start,
>   		}
>   
>   		if (ret > 0 && ret < ARRAY_SIZE(info))
> -			str += scnprintf(str, PAGE_SIZE, "%d %d: %s\n",
> +			str += sysfs_emit_at(buf, str - buf, "%d %d: %s\n",
>   					 i, ret, info[ret]);

You should remove 'str' and use an int for the length instead.
This would be much standard.

 > git grep sysfs_emit_at[^,]*,[^,-]*-
does not find any such pointer manipulation to compute the length.

CJ



>   	}
>   


