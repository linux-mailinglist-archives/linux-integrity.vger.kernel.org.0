Return-Path: <linux-integrity+bounces-6500-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34617AE7302
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 01:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF447B189D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jun 2025 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF25B226CF3;
	Tue, 24 Jun 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4nDqZ8w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCD307496;
	Tue, 24 Jun 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807287; cv=none; b=A1NXvKc0Qz3+rWe8WfZII+OxveBC6F4f+kpwJ1ii13I0JEX06xEwz0eT1AkUs3bLaDayB7co7cFskMfzPE5ZNz10Af4YCzbjda+jIaPHRZ3A7coRVlVPMk4Bt3jRciN6PQP1yf7jCWjx19THY70hgNDOpJR21RqPjGmth7LlySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807287; c=relaxed/simple;
	bh=IVLu0jvRpScb1EentAF1kgYqVy677NaqRlJ88/wzjXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2ak7ZmHqfflxq2ZYj1g1bbquE8xw5I2Dk8F2QZizsVXSO3JciH+lwK9UfABheSvHTXdUO17tTed1epIVM+yqKB0m7Wz0I3XcsM+7YAKjmSIN99Lcm64R6CkVtArH9ROt86pozLMm/Kyy6WYVtEcSaq1fCu7uRSn+kDBtgN4Ytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4nDqZ8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8929C4CEE3;
	Tue, 24 Jun 2025 23:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750807287;
	bh=IVLu0jvRpScb1EentAF1kgYqVy677NaqRlJ88/wzjXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4nDqZ8waSVV4RHx4J1qoWahKdW8kFA8fw5B2cnhbshwEAW+JI1rge2zd4rwqzaLc
	 UEb9XHq4jJ1PZiP5KNtPeee/+0JI0KpDO/d5xhM7/EtIrZ8h0w/FVp3gKP1qKMplkh
	 zIFDHsj5GCs8BBJWPcmp7KznFaX0OwR9uigBcshKPUSWx7dP9hxbdepZq4s4UMQY2i
	 XFgWSjf6IZgx4lEZpyWlA5wHrgRQ2kAZKtFiQh8pfiYLxF2Je5udqf/gLVfMmcmh3s
	 queC0J0xiMSedJ2oPHbh0xn+1x+blvWA6zn+0zHXaNvfs7n1VbcYwPewsbmEztV7xw
	 UtT7J55rdeoXg==
Date: Wed, 25 Jun 2025 02:21:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tpm_crb_ffa: handle tpm busy return code
Message-ID: <aFsy8wFnmm6usEDH@kernel.org>
References: <20250617160544.444321-1-prachotan.bathi@arm.com>
 <20250617160544.444321-3-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617160544.444321-3-prachotan.bathi@arm.com>

On Tue, Jun 17, 2025 at 11:05:44AM -0500, Prachotan Bathi wrote:
> Platforms supporting direct message request v2 [1] can support secure
> partitions that support multiple services. For CRB over FF-A interface,
> if the firmware TPM or TPM service [1] shares its Secure Partition (SP)
> with another service, message requests may fail with a -EBUSY error.
> 
> To handle this, replace the single check and call with a retry loop
> that attempts the TPM message send operation until it succeeds or a
> configurable timeout is reached. Implement a _try_send_receive function
> to do a single send/receive and modify the existing send_receive to
> add this retry loop.
> The retry mechanism introduces a module parameter (`busy_timeout_ms`,
> default: 2000ms) to control how long to keep retrying on -EBUSY
> responses. Between retries, the code waits briefly (50-100 microseconds)
> to avoid busy-waiting and handling TPM BUSY conditions more gracefully.
> 
> The parameter can be modified at run-time as such:
> echo 3000 | tee /sys/module/tpm_crb_ffa/parameters/busy_timeout_ms
> This changes the timeout from the default 2000ms to 3000ms.
> 
> [1] TPM Service Command Response Buffer Interface Over FF-A
> https://developer.arm.com/documentation/den0138/latest/
> 
> Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 66 +++++++++++++++++++++++++++-------
>  1 file changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 089d1e54bb46..4615347795fa 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -10,8 +10,12 @@
>  #define pr_fmt(fmt) "CRB_FFA: " fmt
>  
>  #include <linux/arm_ffa.h>
> +#include <linux/delay.h>
> +#include <linux/moduleparam.h>
>  #include "tpm_crb_ffa.h"
>  
> +#define memzero(s, n) memset((s), 0, (n))
> +
>  /* TPM service function status codes */
>  #define CRB_FFA_OK			0x05000001
>  #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
> @@ -178,22 +182,18 @@ int tpm_crb_ffa_init(void)
>  }
>  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>  
> -static int __tpm_crb_ffa_send_receive(unsigned long func_id,
> -				      unsigned long a0,
> -				      unsigned long a1,
> -				      unsigned long a2)
> +static int __tpm_crb_ffa_try_send_receive(unsigned long func_id,
> +					  unsigned long a0, unsigned long a1,
> +					  unsigned long a2)
>  {
>  	const struct ffa_msg_ops *msg_ops;
>  	int ret;
>  
> -	if (!tpm_crb_ffa)
> -		return -ENOENT;
> -
>  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
>  
>  	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> -		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
> -		       sizeof(struct ffa_send_direct_data2));
> +		memzero(&tpm_crb_ffa->direct_msg_data2,
> +			sizeof(struct ffa_send_direct_data2));
>  
>  		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
>  		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> @@ -201,12 +201,12 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>  		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
>  
>  		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
> -				&tpm_crb_ffa->direct_msg_data2);
> +						&tpm_crb_ffa->direct_msg_data2);
>  		if (!ret)
>  			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
>  	} else {
> -		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> -		       sizeof(struct ffa_send_direct_data));
> +		memzero(&tpm_crb_ffa->direct_msg_data,
> +			sizeof(struct ffa_send_direct_data));
>  
>  		tpm_crb_ffa->direct_msg_data.data1 = func_id;
>  		tpm_crb_ffa->direct_msg_data.data2 = a0;
> @@ -214,11 +214,51 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>  		tpm_crb_ffa->direct_msg_data.data4 = a2;
>  
>  		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
> -				&tpm_crb_ffa->direct_msg_data);
> +						 &tpm_crb_ffa->direct_msg_data);
>  		if (!ret)
>  			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
>  	}
>  
> +	return ret;
> +}
> +
> +static unsigned int busy_timeout_ms = 2000;
> +/**
> + * busy_timeout_ms - Maximum time to retry before giving up on busy

nit: s/busy_timeout_ms/busy_timeout_ms()/

> + *
> + * This parameter defines the maximum time in milliseconds to retry
> + * sending a message to the TPM service before giving up.
> + */
> +module_param(busy_timeout_ms, uint, 0644);
> +MODULE_PARM_DESC(busy_timeout_ms,
> +		 "Maximum time(in ms) to retry before giving up on busy");

Patch lacks update to Documentation/admin-guide/kernel-parameters.rst
(and also document that the default value is two seconds).

> +
> +static int __tpm_crb_ffa_send_receive(unsigned long func_id, unsigned long a0,
> +				      unsigned long a1, unsigned long a2)
> +{
> +	ktime_t start, stop;
> +	int ret;
> +
> +	if (!tpm_crb_ffa)
> +		return -ENOENT;
> +
> +	start = ktime_get();
> +	stop = ktime_add(start, ms_to_ktime(busy_timeout_ms));
> +
> +	for (;;) {
> +		ret = __tpm_crb_ffa_try_send_receive(func_id, a0, a1, a2);
> +
> +		if (ret == -EBUSY) {

This loop would be less convoluted if you instead:

	if (ret != -EBUSY)
		break;

	/* ... */

> +			usleep_range(50, 100);

I wonder where this range comes from.

> +			if (ktime_after(ktime_get(), stop)) {
> +				dev_warn(&tpm_crb_ffa->ffa_dev->dev,
> +					 "Busy retry timed out\n");
> +				break;
> +			}
> +		} else {
> +			break;
> +		}
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 

BR, Jarkko

