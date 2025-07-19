Return-Path: <linux-integrity+bounces-6651-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AFDB0B056
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61826AA486D
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B282264B3;
	Sat, 19 Jul 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mddt3MXm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA7881E;
	Sat, 19 Jul 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752933540; cv=none; b=K1OvtbBw+0TmiMZcrUL7VKUk3uJ7M3D2qEmbVbMI8FI5cru5nXjCvYmn2mXy2MvO5f5fBzaRQBBNHendWuDgzJ+3LT6vduUiEdZYYlyzCAPTWrUDtB2933AgTG/jHbOgE4DOLwkj11Bisth8kGaOt4CYIn40ldUPJ9YjbU9W6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752933540; c=relaxed/simple;
	bh=FX2zqpV2tjgyqGIyi8AqrAuPniMgxLIOdMQ3WwoSvdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbT+ZZmUblNZwQ19xo9A5QYRien+DMXhCFHt4XQwZ2XVHB+t/k3LYKiKcgGhSzC1F8/27CA9qwncusxihnT9Cu9biKZe8RzDmVjbSccuQ1gfAfCuPcJShNxRwnX1jRnTBuIrG1Q5NsGXXMWGjT01RA/9ohmvW1VJT0YIKevGDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mddt3MXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE723C4CEE3;
	Sat, 19 Jul 2025 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752933540;
	bh=FX2zqpV2tjgyqGIyi8AqrAuPniMgxLIOdMQ3WwoSvdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mddt3MXmdSp8aEoFNzPQU9LYz+HYFxOZZhTgEsS9RrD432AaTVxuk9VGy157IABbk
	 +NWO0fKDNVlaJHvHF2sGm8JKT2Rph0xiHPOZJehqoPpfJv4wOtaGmBCSCNvYAURyTx
	 1ju+Wx53xokYs9Urmqdg7I1xxqSyVyzrAzIa4VTMPQBCaq4PxCOBr1i+5i47tAVw4C
	 dLnvCJAkbKY+whOObBtS5EtjUrXQISNvMd5vQ2ChIru62eX9GdcnqNUaKR5KjMozMO
	 l2arY4zR4KGHdAzpCe7NtSJXGbeAp0vv9/qte7cgpga1+EGbg6qwX1K03c7pdwYDGz
	 kjFSnSYuRshjg==
Date: Sat, 19 Jul 2025 16:58:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Prachotan Bathi <prachotan.bathi@arm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] tpm_crb_ffa: handle tpm busy return code
Message-ID: <aHukoB5Xz4wyx7Yw@kernel.org>
References: <20250708225151.2473657-1-prachotan.bathi@arm.com>
 <20250708225151.2473657-4-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708225151.2473657-4-prachotan.bathi@arm.com>

On Tue, Jul 08, 2025 at 05:51:51PM -0500, Prachotan Bathi wrote:
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
>  .../admin-guide/kernel-parameters.txt         |  8 ++++
>  drivers/char/tpm/tpm_crb_ffa.c                | 45 ++++++++++++++++---
>  2 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 07e22ba5bfe3..343377538fe9 100644
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
> index 7faed6f3bf66..06599c07b746 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -10,8 +10,16 @@
>  #define pr_fmt(fmt) "CRB_FFA: " fmt
>  
>  #include <linux/arm_ffa.h>
> +#include <linux/delay.h>
> +#include <linux/moduleparam.h>
>  #include "tpm_crb_ffa.h"
>  
> +static unsigned int busy_timeout_ms = 2000;
> +
> +module_param(busy_timeout_ms, uint, 0644);
> +MODULE_PARM_DESC(busy_timeout_ms,
> +		 "Maximum time in ms to retry before giving up on busy");
> +
>  /* TPM service function status codes */
>  #define CRB_FFA_OK			0x05000001
>  #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
> @@ -178,17 +186,13 @@ int tpm_crb_ffa_init(void)
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
> @@ -214,6 +218,33 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
>  			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
>  	}
>  
> +	return ret;
> +}
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

I think these patches look totally fine now. If you don't mind I'll add
suggested-by to 2/3?

Anyhow, I can pick these to my tree. Just coming from holiday but
they'll end up the 6.17 PR.

BR, Jarkko

