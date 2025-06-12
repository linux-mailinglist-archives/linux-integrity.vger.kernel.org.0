Return-Path: <linux-integrity+bounces-6443-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E4AD6E05
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 12:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C2A3A3802
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jun 2025 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB7233D9E;
	Thu, 12 Jun 2025 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOdWp8b2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6BB1F92E;
	Thu, 12 Jun 2025 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724859; cv=none; b=u/k+YhYb4cOuDGuYDQ0PBMrMEfnlirEE012yzG1wS6TYXLtbraj4rgssOzsQJGb9JphV/jHigHb3tzvWSZIWll5xpw5OEQs4uyvRGIut2iUz/fJiVRvy1M6JKuCokbSCRGce4/bk+S0U5eIPepI2299dDJm+UdxGtxQFpmI1rkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724859; c=relaxed/simple;
	bh=IGseCNuZuDaz/lm8jRoy5U/gC1+Grl0hSR0NO4hnO+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3U32MuoxZn3Alx6jCmtD15v9EnwoEk0DjCIIdYNPBhtYS1GUYQPFKyDVfPPqiFlujXMCbysJO9k8/y3n+iCjASeoxtpbGlkeHUOGEVVfHeF+6my+BGMNHQcybYrgHr4YTD6xvnW3mEJbPW/VvHzo8VFWLy5+v+yV69lorCstI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOdWp8b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8E4C4CEEA;
	Thu, 12 Jun 2025 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724858;
	bh=IGseCNuZuDaz/lm8jRoy5U/gC1+Grl0hSR0NO4hnO+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WOdWp8b2U+M5RbBcY3ywIRDDW/JsQXJluubRcvguCDgshaBzfJIz6/unl5tzio3Mv
	 9w9NzmQTU2sslCY1SLRIPVuD64Qry3+/BkmQgq6XzAMUKDDV83R5pqQmUBOHc4aEAL
	 oeHok690Ge4pb1rslSQ+vDy1mvRSnboU7a1w/JX0BtTxIMdnVCLZQe4J1QfLlqBcuP
	 Uaqjt5ntBISmdVZl8lYi5afoMjKoFQkO3ESzKtmAW3yTFK3cbdS1DHMJFbw7b7cGse
	 YfO+ZG0Nw1HpzP+bsPdJpaRN/ql+GgcesjM6s8pO7Bj/XpCgnMoy+QsO4hSSbcVCZ/
	 iKPJL1dM7M4qw==
Date: Thu, 12 Jun 2025 13:40:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tpm_crb_ffa: handle tpm busy return code
Message-ID: <aEqut7qHnugl_vN_@kernel.org>
References: <20250611193009.3941971-1-prachotan.bathi@arm.com>
 <20250611193009.3941971-2-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611193009.3941971-2-prachotan.bathi@arm.com>

On Wed, Jun 11, 2025 at 02:30:09PM -0500, Prachotan Bathi wrote:
> Platforms supporting direct message request v2 can
> support SPs that support multiple services.
> If the TPM service is sharing the SP with another service,

What is "TPM service" and "SP"?

> it could get an error code of BUSY if the other service is
> in process.
> This adds a parameterized variable (default 2000ms)

What is "this"?

"Add a ..."

>  that indicates the maximum time to keep retrying for.
> When the TPM service returns a BUSY error code, we sleep

s/we sleep/sleep/


>  50-100us before retrying again, until we are over the
> busy timeout.
> 
> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>

I'd consider rewriting the commit message as it lacks any explanation
of the code change. You replace condition statement with a loop. Start
with that.

I'd strip some of the comments too i.e, those that state the obvious.

> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 78 +++++++++++++++++++++++-----------
>  1 file changed, 54 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 4ead61f01299..5f0a30a20b57 100644
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
> +		/* Check if the TPM service returned busy */

Strip.

> +		if (ret == -EBUSY)
> +			pr_err("TPM says busy, trying again, value, ret: %d\n",
> +			       ret);
> +		else
> +			/* If TPM did not return busy, we are done, exit the loop */

Ditto.

> +			break;
> +		/* Sleep for a short time before retrying to avoid busy looping */

Ditto.

> +		usleep_range(50, 100);
> +	} while (ktime_before(ktime_get(), stop));
> +	/* If we are here, we either got a valid response or over the busy timeout */

Ditto.

>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 

BR, Jarkko

