Return-Path: <linux-integrity+bounces-6490-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BBBAE2312
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 21:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD863AFF92
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE3224B0C;
	Fri, 20 Jun 2025 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tSnZnlBp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27B2ECE9B;
	Fri, 20 Jun 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750449210; cv=none; b=N0hl44+gVoSNF6E/IbskMyWnGZKDo544cindB+9uFJiTTrextmN3NCr7lw3C8DzbxmvHjY4ahQacAtQJiQwesoUnSA90kEsqmC9aR3iTez4o7gNACWr6lJ2OcVkSAj+ccxQQeqfRNUVDP/qyJseLVWvZIzY+/qiluBof5u2TajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750449210; c=relaxed/simple;
	bh=RNFe6OsXiIa25lThIwwSEn6qb0BH3hZlmmOumOwKmL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaHYxQWOjUiSbvbNes+IZeu+KFy1uvkIuvft4apovDSK1xO0woS6eHkO/EUc6c44SFRe1rlATc1RmkMSx4BCzV5CLFJ81bfbdLP33rElXUPhJOwLjNWSKxNdGKAJcVmgDpi9eagvvJ0EOaCdH7MwC889GFvsWWSa7CgXxQWOEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tSnZnlBp; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id ShmauIDQsBqt7Shmauhv5q; Fri, 20 Jun 2025 21:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750449136;
	bh=2bElo9HwhnRSM0NAT+XlQ6v5ReuWUrVRquq0Qs1cSFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tSnZnlBpqXBKoYO84tVJ44EYQOtH3COuTe5YqwirKz/RLlfZCR+99hjQVvErnZJIq
	 UJslU3anrpYhVkh6fr4b6zyhVexsACxeNhipuhthLWx6smtD0etTBxD6kTFfnDCoiX
	 eag906y51+aGJDcUXM17MTkQZLZvgacjFub3ahci/G/S2PkvLWaQSOHbgVMxbauzQ6
	 TK7ontWUHFFOJD7YwstaKnCsRcO2YKUrZd8KpHHeqUIZinvy9vHtvtmnXZXppsnU5+
	 BzZAN1WvXtQGSP4qGf8X3EwBAk2KiBqN6wD1XuT9nfsl6mqKma6cJFGoVUlz6r7U7J
	 OOGYLIPvaRBFw==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 20 Jun 2025 21:52:16 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <72d03217-16a4-4700-952b-a98b68a37140@wanadoo.fr>
Date: Fri, 20 Jun 2025 21:52:14 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Replace scnprintf() with sysfs_emit() and
 sysfs_emit_at() in sysfs show functions
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, peterhuewe@gmx.de,
 jarkko@kernel.org
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250619123707.399022-1-chelsyratnawat2001@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250619123707.399022-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/06/2025 à 14:37, Chelsy Ratnawat a écrit :
> Replace calls to scnprintf() with sysfs_emit() and sysfs_emit_at() in
> sysfs show functions. These helpers are preferred in sysfs callbacks
> because they automatically handle buffer sizing (PAGE_SIZE) and
> improve safety and readability.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
>   drivers/char/tpm/tpm_ppi.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> index bc7b1b4501b3..421c6264bac9 100644
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
> +			str += sysfs_emit_at(str, "%d %d: %s\n",

sysfs_emit_at() does not work like that.
But does this code even compile?

CJ

>   					 i, ret, info[ret]);
>   	}
>   


