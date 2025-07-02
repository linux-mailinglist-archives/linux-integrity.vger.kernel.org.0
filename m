Return-Path: <linux-integrity+bounces-6587-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B29AF650E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 00:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3896A4A860F
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76892441A0;
	Wed,  2 Jul 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syn2/Ulz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CB23D282;
	Wed,  2 Jul 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494966; cv=none; b=qHt2ndBa8Lpm0CVyQq5uNp3RPsnal2npMbtsIB3FGax7yOdFhueKvmXD0PFr9LfNI7s+oxAktuYeOovgFO8SCXrcBnrV7B6h9wYqumJAIj0E9L2OmRzmg8DpbZDwvjIFs0jQBvx9fKwyDZXICIoBpLT8YCVGwrWenkyU/SugOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494966; c=relaxed/simple;
	bh=MHYe54Yd5zdrM9DPJtAxY51WptPZuZ/3C2xcHrrGUGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqYt1OfwbzNzlw5sttqUwURE7eTgB44hstdxxG8fYYJ8YoDnSI72LyHCKlI/lSlvA+AqlEE29OtozrBGQKCquyey6lSB0nIhOWySIh2DDRl9MAbGDvW1yFcWxVqGlVGLrx2TA2BnYBvnUbwXyVDrPVhhEh2akkSE3z8vNn3gOm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syn2/Ulz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A10C4CEE7;
	Wed,  2 Jul 2025 22:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751494966;
	bh=MHYe54Yd5zdrM9DPJtAxY51WptPZuZ/3C2xcHrrGUGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syn2/UlzoVSXYVRXHsWZcza0zb74nTGbHM5BrXEbqRoRVhX9JeAq3yq2vsqHZhoN9
	 EcRXq4TmZi5LXh7qf9B0L5uYog2wmdDX3PbHSaydmBaBQNYqk/JvUEcHe4nvYw/irQ
	 gIMLX1wtzmtifOAo0QMrLc+69o+XGHSwqEaq45St10DeBBIL9P4WWEGfnM/La0kQFO
	 5jWsoiNg+H+kiv1aLX9MOOwX7kEbJLZb1/YksAPIX8ugtPs+wyxVOoLnfPhjppW/oc
	 Hdbb80gtC5FmZf4yEFuazOHqWkEEmYXgJijnFar5499yn/UOTcdqwcb90tGWWT7isG
	 9oGIf3RGReUEQ==
Date: Thu, 3 Jul 2025 01:22:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] tpm_crb_ffa: handle tpm busy return code
Message-ID: <aGWxMuwtRDR5TGCg@kernel.org>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
 <20250626184521.1079507-4-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626184521.1079507-4-prachotan.bathi@arm.com>

On Thu, Jun 26, 2025 at 01:45:21PM -0500, Prachotan Bathi wrote:
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
>  drivers/char/tpm/tpm_crb_ffa.c                | 49 ++++++++++++++++---
>  2 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f1f2c0874da9..eb1ebbc328ab 100644
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
> index 397cc3b0a478..a6c9e9c2c344 100644
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
>  #define memzero(s, n) memset((s), 0, (n))
> @@ -180,17 +182,13 @@ int tpm_crb_ffa_init(void)
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
> @@ -221,6 +219,43 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>  			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
>  	}
>  
> +	return ret;
> +}
> +
> +static unsigned int busy_timeout_ms = 2000;

Add an empty line here.

> +/**
> + * This parameter defines the maximum time in milliseconds to retry
> + * sending a message to the TPM service before giving up.
> + */

Since it is already documented in kernel-parameters.rst, you could just
as well remove this comment. It is only extra burden to maintain later
on.

> +module_param(busy_timeout_ms, uint, 0644);
> +MODULE_PARM_DESC(busy_timeout_ms,
> +		 "Maximum time in ms to retry before giving up on busy");

It's somewhat de-facto to put module parameters to the beginning of the
file, which I'd advice to do also here.

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

I'd remove this newline (but it is your choice, not going to nak for this).

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

