Return-Path: <linux-integrity+bounces-6386-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69291AD286B
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 23:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E8E16631A
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jun 2025 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B57218BBB9;
	Mon,  9 Jun 2025 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTQZNdNb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639063D544;
	Mon,  9 Jun 2025 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502980; cv=none; b=lFf7z1WfLvEpC/cnK3oUL/mWRD6szJ9jrwrCtFNVU8xuYQfPy6XI0eQHQZChYqSJY4jeFHkpsHtwcepus1TaYPiO0KYzGPSmmlVZ1awvi/sTHd57+zb8vsQveJ6Fgy12mhofd0TNsjZBU/7/jG018RjBMaKJ8BfcVxzZm8DjCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502980; c=relaxed/simple;
	bh=RZLEtyFeskXKCxRKdITJbRi3Nefd865yDaYrHZ9TSMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R14gYHXfj4VDFdpjo8g9Ekgygep1+P53isBI6X4SdoC/Twt+ACQJYCujhQ2JVLJK9cF/xD1GBcLuSUgEOULuu84SJXsJqRDR4tmGc+phebYnb0e8QWDc29SfY5pbw3u0saKwiouSsFhze+rv9VQ/SQUO8HA5tlwh9VBtwvfatDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTQZNdNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3D6C4CEEB;
	Mon,  9 Jun 2025 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749502979;
	bh=RZLEtyFeskXKCxRKdITJbRi3Nefd865yDaYrHZ9TSMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTQZNdNb46CQSq31S+wVo1cKtEhV+Czr/d8j5ri/DnQGEaDrrM2HC8C1/lO9sBwM8
	 fepBZ5BNCoTfAHvzV1emSG/dudXhBLsp9yU10uHNhe5J4e6RS6gmHImXbMDHshSVED
	 h34Ld4QlLtLs03UsNQ65RUkkVSUOASlFdVJpZbOE9lSJrSRXVJDVMXAOKhReJqmFi0
	 tPm4R9KIdcZFoQey2u+ALlDAaFdqbzpDrSkNf04DfXrpAbyBENEWywagyJupyy1Lev
	 FBE8P5qRawXrFSSbaw8A/oqMgT428eFuFM4ZgVEzs3e7CeenJy3PQLYKQGDSNar3iJ
	 bb8/pXxoQEegA==
Date: Tue, 10 Jun 2025 00:02:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tpm_ffa_crb: handle tpm busy return code
Message-ID: <aEdMAELNiu1rQYRa@kernel.org>
References: <20250609141600.3601340-1-prachotan.bathi@arm.com>
 <20250609141600.3601340-2-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609141600.3601340-2-prachotan.bathi@arm.com>

On Mon, Jun 09, 2025 at 09:16:00AM -0500, Prachotan Bathi wrote:
> Platforms supporting direct message request v2 can
> support SPs that support multiple services.
> If the TPM service is sharing the SP with another service,
> it could get an error code of BUSY if the other service is
> in process.
> This patch adds a parameterized variable (default 2000ms)
>  that indicates the maximum time to keep retrying for.

Patch is not a patch once it is in a Git repository. Instead:
"Add a ...".

> 
> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 74 +++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 4ead61f01299..e47e110bac9e 100644
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
> @@ -191,34 +204,47 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
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
> +		if (ret == -EBUSY)
> +			pr_err("TPM says busy, trying again, value, ret: %d\n",
> +			       ret);
> +		else
> +			break;
> +		usleep_range(50, 100);
> +	} while (ktime_before(ktime_get(), stop));

I'd describe the code change also in more detail i.e. what is this loop
about.

>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 
> 

BR, Jarkko

