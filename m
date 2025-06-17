Return-Path: <linux-integrity+bounces-6460-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4CAADD03D
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C683B928B
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638D1FFC41;
	Tue, 17 Jun 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd/OpOql"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ABE2EF650;
	Tue, 17 Jun 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171229; cv=none; b=GaUkQhvXDZuqw5bAGTNeL0U5MY3ZnewDL7LwKq4aLF77NsplGbV6hh+3Snlf2FrZkelStojUdmNhSWz/2eAswxswKgGfjWsO+lw75LtfdP8K3s6UFCn6ZvySXRFeb7fNANUJST9G8XIhCn9UBIOqIx0bdIbx5dEu5Veyvyq4sB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171229; c=relaxed/simple;
	bh=1sJ5uWIyOK0PQu9DY5SEJMP6Y603O+MTzVrgiX+WWWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqh3V5ibS8EKUPgLgwPdIZ/D7/+nAvuKG4uE5TT5ynhYAgSwmaMPKYY+qImTYc+7re/H7+XBuNhGGzIF2cZdRjNoahmkR1XauM5nx94N/9E0z8tC8VhB1PRHuvjeje2QHAzC+VxVVDns0mx+RSodVexrdbIPdq7i4Zw8Ex7Q0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd/OpOql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DECC4CEE3;
	Tue, 17 Jun 2025 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750171228;
	bh=1sJ5uWIyOK0PQu9DY5SEJMP6Y603O+MTzVrgiX+WWWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dd/OpOqle3v9pBIn0wbR/lhVL7fG5NubWL79DTXE8GaZhu7yETpIVDN1UDnzdPoTt
	 u53t5A2GG4VvYecoFkbiXWQuwi28VVIhuN22J/CPVAcG+dVfwUcaHC64fxXIqEcf6M
	 mGV0pioxsB1tDCqt085N5f2Q5Q+85XjfZlpFQu0o11snNphd/ml/2FxFOxUqIv5BBw
	 yt+8jrLV/JfgOchJA/DNn6WY+V/ARiVCUDS+Kdz41HVOZ8Zkj0DTb0ouvA35I3H4uz
	 CCqoQe7TThtnBq3KGhg23lJz1aEmnd0iJglNJxBcHkqI82kEpEl3aRmCNvPHM3fgv5
	 rJ3Cb6E5uaXoA==
Date: Tue, 17 Jun 2025 17:40:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tpm_crb_ffa: handle tpm busy return code
Message-ID: <aFF-WNSolTdV9PZG@kernel.org>
References: <20250613233132.4167653-1-prachotan.bathi@arm.com>
 <20250613233132.4167653-2-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613233132.4167653-2-prachotan.bathi@arm.com>

On Fri, Jun 13, 2025 at 06:31:32PM -0500, Prachotan Bathi wrote:
> For CRB over FF-A interface, if the firmwre TPM or TPM service [1] shares
> its Secure Partition (SP) with another service, message requests may
> fail with a -EBUSY error. Platforms supporting direct message request v2[1]
>  can support secure partitions that support multiple services.
> 
> To handle this, replace the single check and call with a retry loop
> that attempts the TPM message send operation until it succeeds or a
> configurable timeout is reached. The retry mechanism introduces a
> module parameter (`busy_timeout`, default: 2000ms) to control how long
> to keep retrying on -EBUSY responses. Between retries, the code waits
> briefly (50-100 microseconds) to avoid busy-waiting and handling
> TPM BUSY conditions more gracefully.
> 
> [1] TPM Service Command Response Buffer Interface Over FF-A
> https://developer.arm.com/documentation/den0138/latest/
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

there's BTW a typo ;-) s/recieve/receive

Not your fault but maybe it would make sense to correct that anyhow...

>  				      unsigned long a0,
>  				      unsigned long a1,
> @@ -191,34 +204,47 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,

Maybe this would be less exhausting if you instead would work out the
existing function something like __tpm_crb_ffa_try_send_receive() and
call that in a loop? It would be then similar organization as with
tpm_transmit().

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

nit: could use memzero() instead.

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

This is not an error condition but instead a legit condition, as far as
kernel is considered. Please, remove pr_err().

> +		else
> +			break;
> +		usleep_range(50, 100);
> +	} while (ktime_before(ktime_get(), stop));
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 

BR, Jarkko


