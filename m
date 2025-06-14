Return-Path: <linux-integrity+bounces-6454-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16070AD9A30
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Jun 2025 07:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8425B17F99A
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Jun 2025 05:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588C57C9F;
	Sat, 14 Jun 2025 05:22:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BF3FD1;
	Sat, 14 Jun 2025 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749878569; cv=none; b=PvFdm8ENHtNXHiwcluT2Z3dcFTPhs7CZg7dD5QrQ74oP/g5rx8ZZj63VMXIcc9Hi7DolrjutLdKLdRJ2BYnPTE5SmYnaXZjxftWTsXTHnB6OMxYfS5svz7EPdnP3egChQLzrueh5njEn9aGkUgHaDJFq6naHyRac422Xeiabm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749878569; c=relaxed/simple;
	bh=xPBoIC57lomTpssob0brmLc00CtOa6EfqZaAE4Ac+qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzsR7F1eKm/9+SyTFZQKsmMidc5WTaw5+PZTMgVu3IHNAjtSIEk/t21BxhvfeIe/5kAHVVheRFxnJ2Ct9Qe6ZrDcQ7R2fiJtRXP0Quxss6V8G8AqBZP8F0slqZn+p3USrjTA5sIpH0eFma5hc8CyJDBcLQ50Dt+ffsCSWZTklUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.111] (p57bd96ac.dip0.t-ipconnect.de [87.189.150.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 77E8B61E647A7;
	Sat, 14 Jun 2025 07:22:32 +0200 (CEST)
Message-ID: <2c3fe153-150b-4439-93e1-f1b218033ba6@molgen.mpg.de>
Date: Sat, 14 Jun 2025 07:22:31 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] tpm_crb_ffa: handle tpm busy return code
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Stuart Yoder <stuart.yoder@arm.com>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250613233132.4167653-1-prachotan.bathi@arm.com>
 <20250613233132.4167653-2-prachotan.bathi@arm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250613233132.4167653-2-prachotan.bathi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Praochotan,


Am 14.06.25 um 01:31 schrieb Prachotan Bathi:
> For CRB over FF-A interface, if the firmwre TPM or TPM service [1] shares

firmw*a*re

> its Secure Partition (SP) with another service, message requests may
> fail with a -EBUSY error. Platforms supporting direct message request v2[1]
>   can support secure partitions that support multiple services.

Please remove the two leading spaces. Also I’d swap the sentences.

> To handle this, replace the single check and call with a retry loop
> that attempts the TPM message send operation until it succeeds or a
> configurable timeout is reached. The retry mechanism introduces a
> module parameter (`busy_timeout`, default: 2000ms) to control how long

Please append the unit to the name.

> to keep retrying on -EBUSY responses. Between retries, the code waits
> briefly (50-100 microseconds) to avoid busy-waiting and handling
> TPM BUSY conditions more gracefully.

It’d be great if you documented your test setup and how to test this.

Out of curiosity: Can the parameter be changed during runtime?

> [1] TPM Service Command Response Buffer Interface Over FF-A
> https://developer.arm.com/documentation/den0138/latest/
> 
> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
> ---
>   drivers/char/tpm/tpm_crb_ffa.c | 74 +++++++++++++++++++++++-----------
>   1 file changed, 50 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 4ead61f01299..e47e110bac9e 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -10,6 +10,8 @@
>   #define pr_fmt(fmt) "CRB_FFA: " fmt
>   
>   #include <linux/arm_ffa.h>
> +#include <linux/delay.h>
> +#include <linux/moduleparam.h>
>   #include "tpm_crb_ffa.h"
>   
>   /* TPM service function status codes */
> @@ -178,6 +180,17 @@ int tpm_crb_ffa_init(void)
>   }
>   EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>   
> +static unsigned int busy_timeout = 2000;

Please append _ms to the variable name.

> +/**
> + * busy_timeout - Maximum time to retry before giving up on busy
> + *
> + * This parameter defines the maximum time in milliseconds to retry
> + * sending a message to the TPM service before giving up.
> + */
> +module_param(busy_timeout, uint, 0644);
> +MODULE_PARM_DESC(busy_timeout,
> +		 "Maximum time to retry before giving up on busy");

Please name the unit.

> +
>   static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
>   				      unsigned long a0,
>   				      unsigned long a1,
> @@ -191,34 +204,47 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
>   
>   	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>   
> -	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> -		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
> -		       sizeof(struct ffa_send_direct_data2));
> +	ktime_t start;
> +	ktime_t stop;
> +
> +	start = ktime_get();
> +	stop = ktime_add(start, ms_to_ktime(busy_timeout));
> +
> +	do {
> +		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> +			memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
> +			       sizeof(struct ffa_send_direct_data2));
>   
> -		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> -		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> -		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> -		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
> +			tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> +			tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> +			tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> +			tpm_crb_ffa->direct_msg_data2.data[3] = a2;
>   
> -		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
> +			ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
>   				&tpm_crb_ffa->direct_msg_data2);
> -		if (!ret)
> -			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
> -	} else {
> -		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> -		       sizeof(struct ffa_send_direct_data));
> -
> -		tpm_crb_ffa->direct_msg_data.data1 = func_id;
> -		tpm_crb_ffa->direct_msg_data.data2 = a0;
> -		tpm_crb_ffa->direct_msg_data.data3 = a1;
> -		tpm_crb_ffa->direct_msg_data.data4 = a2;
> -
> -		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
> -				&tpm_crb_ffa->direct_msg_data);
> -		if (!ret)
> -			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
> -	}
> +			if (!ret)
> +				ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
> +		} else {
> +			memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> +			       sizeof(struct ffa_send_direct_data));
>   
> +			tpm_crb_ffa->direct_msg_data.data1 = func_id;
> +			tpm_crb_ffa->direct_msg_data.data2 = a0;
> +			tpm_crb_ffa->direct_msg_data.data3 = a1;
> +			tpm_crb_ffa->direct_msg_data.data4 = a2;
> +
> +			ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
> +				&tpm_crb_ffa->direct_msg_data);
> +			if (!ret)
> +				ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
> +		}
> +		if (ret == -EBUSY)
> +			pr_err("TPM says busy, trying again, value, ret: %d\n",
> +			       ret);
> +		else
> +			break;
> +		usleep_range(50, 100);
> +	} while (ktime_before(ktime_get(), stop));

Log a message with the timeout in case the timeout is reached?

>   
>   	return ret;
>   }


Kind regards,

Paul

