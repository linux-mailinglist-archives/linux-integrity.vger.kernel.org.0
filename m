Return-Path: <linux-integrity+bounces-6542-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 539DDAE9C14
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 13:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB377A9426
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913626E71E;
	Thu, 26 Jun 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0CuWPM+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186526E710;
	Thu, 26 Jun 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935438; cv=none; b=gi8mqxUeEBUwei126Kk3oIPuah35/86LlCbfFzGe97ay2LsT3T5oVijir3+AJbDM+nrpR8TQ5I4ikWJUv1oEjZqV1ApNyuQT9zsQ9Zhz1xW17DpIaz1Hctr16qXcz2epe1qQGP7M9jGn5wOtwp1fi8CKZlL3WTh/BrMm+SiA8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935438; c=relaxed/simple;
	bh=HmL2eUnZOx0oxA9H0Kysq9FQxWGRdtWXM7wU+tBu/dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKsE/Y2M3nW/g94DKX3esnZgANqj72lQI2/ZTMupKCMWWsAA7kzC/yDzI1gIVBzm2O3wD1exrPrX0f92ePnAq0cvtUcSkvWo++eJf0H3vp2T0H+cWZk3wuZG1bvqirlwYLNwkO35LwPkMeJnypto6/XYfFimdjFfDHeIEPY1sak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0CuWPM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671C6C4CEEB;
	Thu, 26 Jun 2025 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750935437;
	bh=HmL2eUnZOx0oxA9H0Kysq9FQxWGRdtWXM7wU+tBu/dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0CuWPM+0ScnPjI/1J3RsCgVv3qev9baytyHMUUYFLqkwPBau/apiFU1dWgjg+C+k
	 y1YrI34Z9kjm220xseqpZq8Vt/TP1QmddFy9RPD7zTv6z+qH2ksPHsanm/5V7Q4Ezn
	 73x+YypRny64U/KfCuElyI2sVTDFbD/pZ6fTlGG3qKfzmDnhbp2bS+jG6TgOoIhcOL
	 V1JY1O3tqeb63OncMi7XzMEY+CfntGZslN2H9eTHnFJGhH/MoceMJvkWBmNb9NxWTh
	 n3jc3bGGcYv5gxbDOB8GuJ5ZPpF1Kky5tREczLz8lPpcBWuFqLZjh7+cUnl2w46s4K
	 e72jyZFayTyxw==
Date: Thu, 26 Jun 2025 13:57:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] tpm_crb_ffa: handle tpm busy return code
Message-ID: <aF0nis6M5ddf668S@kernel.org>
References: <20250625191943.1009830-1-prachotan.bathi@arm.com>
 <20250625191943.1009830-3-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625191943.1009830-3-prachotan.bathi@arm.com>

On Wed, Jun 25, 2025 at 02:19:43PM -0500, Prachotan Bathi wrote:
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
>  .../admin-guide/kernel-parameters.txt         |  8 +++
>  drivers/char/tpm/tpm_crb_ffa.c                | 65 +++++++++++++++----
>  2 files changed, 60 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9..5cb5dbfd761f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7214,6 +7214,14 @@
>  			causing a major performance hit, and the space where
>  			machines are deployed is by other means guarded.
>  
> +	tpm_crb_ffa.busy_timeout_ms= [ARM64,TPM]
> +			Maximum time in milliseconds to retry sending a message 
> +			to the TPM service before giving up. This parameter controls 
> +			how long the system will continue retrying when the TPM 
> +			service is busy.
> +			Format: <unsigned int>
> +			Default: 2000 (2 seconds)
> +
>  	tpm_suspend_pcr=[HW,TPM]
>  			Format: integer pcr id
>  			Specify that at suspend time, the tpm driver
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 089d1e54bb46..1a51c966e42c 100644
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

This is a spurious change i.e., out of scope of the topic.

If you wanted to do this, you'd need to have a separate patch for it.

Otherwise, stick to memset(). This is the "split to logical changes"
part of SubmittingPatches document.

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
> @@ -214,11 +214,50 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
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
> + *
> + * This parameter defines the maximum time in milliseconds to retry
> + * sending a message to the TPM service before giving up.

I'd keep this single line and save the effort to kernel-parameters.rst.
Otherwise, this will be pain to maintain.

> + */
> +module_param(busy_timeout_ms, uint, 0644);
> +MODULE_PARM_DESC(busy_timeout_ms,
> +		 "Maximum time(in ms) to retry before giving up on busy");

"Maximum time (in ms)", or rather "Maximum time in ms" because you
really need to know the unit every single time you use the parameter.

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
> +		if (ret != -EBUSY)
> +			break;
> +
> +		usleep_range(50, 100);
> +		if (ktime_after(ktime_get(), stop)) {
> +			dev_warn(&tpm_crb_ffa->ffa_dev->dev,
> +				 "Busy retry timed out\n");
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

