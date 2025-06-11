Return-Path: <linux-integrity+bounces-6417-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D7AD5C91
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB1F172365
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14738198851;
	Wed, 11 Jun 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMVTcWwy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17462E610F;
	Wed, 11 Jun 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660345; cv=none; b=JtqoujcH5+cmfbcJuj9TBoM3iKOjeXYPLArwVT4Kp5qvHvLd8eKu43k+nH0eQrStPtB1TbMkQuIkyWuogiJ7OCzXu+SbEVt6XTCDXv3CeNjhgEQaeiuKLJDTWG9v5I3k2jC2HG/dMFaF1uIjnN8YzQZmAwRCc7t3y1zWM9akN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660345; c=relaxed/simple;
	bh=6YiYld9w2Hx+Iaj5LQHXe+nPaanJ0QWZp6uRgHqygvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqbPo8pK9woMxkbpi0auu+ivMHxP5rcbsS9a46Q7SPl7IRFS0Qry278MoRpkhZ8Z7Ifj8Ek7SysV6iIgiQMI7vu/6wXOtuIvgkR1Ak8LGkcRcJ33XSqh2luwsNXFTpp5maNaLUuXIOCdo4mF3ybVuuLCRlLN2C6oVaRqoxDpj/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMVTcWwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC1BC4CEE3;
	Wed, 11 Jun 2025 16:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660344;
	bh=6YiYld9w2Hx+Iaj5LQHXe+nPaanJ0QWZp6uRgHqygvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMVTcWwy/s+ucZwaGP8pT9hxCeH3a3YxGDrchK3bts5ut5zRaDXovnEb0zDVpFYKJ
	 YsTzZkpM0FK4qVF17OSvkGoXCqtdhzL0UNv0fGyqjtnwJP9Z+oLR54ZxtTvIc8BXSh
	 XhEclKcOLqwZ//oqKFdVlwv5o6zfKyDU38LvX6LQ9q9MTecVWLx5iTv5YWKpbhXnVu
	 PxWJCt3li6cKlcMv6clfO+y76bHU8jckGWcdM8psSNFRL713EH8q4PBHoZU3ZlTo9x
	 TJSgxbup7/bumeblBTC8UZyySOEJ0H1SY3mohqGSRBTtd9cEodSUoGrbOy+syWBjHu
	 Wl5gjiZ2AiAdA==
Date: Wed, 11 Jun 2025 19:45:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tpm_crb_ffa: handle tpm busy return code
Message-ID: <aEmys305qGjxa7G2@kernel.org>
References: <20250610213505.3881352-1-prachotan.bathi@arm.com>
 <20250610213505.3881352-2-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610213505.3881352-2-prachotan.bathi@arm.com>

On Tue, Jun 10, 2025 at 04:35:05PM -0500, Prachotan Bathi wrote:
> Platforms supporting direct message request v2 can
> support SPs that support multiple services.
> If the TPM service is sharing the SP with another service,
> it could get an error code of BUSY if the other service is
> in process.
> This adds a parameterized variable (default 2000ms)
>  that indicates the maximum time to keep retrying for.
> When the TPM service returns a BUSY error code, we sleep
>  50-100us before retrying again, until we are over the
> busy timeout.
> 
> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 78 +++++++++++++++++++++++-----------
>  1 file changed, 54 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 4ead61f01299..122984e15971 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -10,6 +10,8 @@
>  #define pr_fmt(fmt) "CRB_FFA: " fmt
>  
>  #include <linux/arm_ffa.h>
> +#include <linux/delay.h>
> +#include <linux/moduleparam.h>
>  #include "tpm_crb_ffa.h"
>  
>  /* TPM service function status codes */
> @@ -178,6 +180,17 @@ int tpm_crb_ffa_init(void)
>  }
>  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>  
> +static unsigned int busy_timeout = 2000;
> +/**
> + * busy_timeout - Maximum time to retry before giving up on busy
> + *
> + * This parameter defines the maximum time in milliseconds to retry
> + * sending a message to the TPM service before giving up.
> + */
> +module_param(busy_timeout, uint, 0644);
> +MODULE_PARM_DESC(busy_timeout,
> +		 "Maximum time to retry before giving up on busy");
> +
>  static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
>  				      unsigned long a0,
>  				      unsigned long a1,
> @@ -191,34 +204,51 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
>  
>  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
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
>  				&tpm_crb_ffa->direct_msg_data2);
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
> +		// Check if the TPM service returned busy
> +		if (ret == -EBUSY)
> +			pr_err("TPM says busy, trying again, value, ret: %d\n",
> +			       ret);
> +		else
> +			// If TPM did not return busy, we are done, exit the loop
> +			break;
> +		// Sleep for a short time before retrying to avoid busy looping
> +		usleep_range(50, 100);
> +	} while (ktime_before(ktime_get(), stop));
> +	// If we are here, we either got a valid response or we are over the busy timeout

Please use "/* */". We don't use C++ comment style:

https://www.kernel.org/doc/html/v6.14/process/coding-style.html#commenting

BR, Jarkko

