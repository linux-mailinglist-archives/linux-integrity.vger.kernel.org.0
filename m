Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464913A7E9D
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFONGS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 09:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhFONGS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 09:06:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6988261468;
        Tue, 15 Jun 2021 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623762253;
        bh=ry99x+VlQjPK7efumwMdnhXfJRG8zvDuRrxE6Ux6eR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDvDqv8CLOWhE9drMsXT3eTVyW3tyOo1D1tbIUn/raoSEEyC5NL+OsLfKSll9XhwF
         9J1aBty8Nmxq1V00hXTgElu39a/vhaUyL6XeOuDBiRwFsbDyIw+9aRBJkigYJwu6qq
         oje+lVDELB/ILDfIf3qiYZG/5Q1W3nm+uVJCdGnjpV6oY0nBM6sLQuNQBfFVbXrKnG
         qZZrH/iqY9AJHCAmOvdJHP4489lXF23Id8tE7mQQVNjzfGINloc9SX6hf9GmyvdDgV
         x/7qD6GO4EH9zDLSLA1a+ey+USon9Hh/Rfp+Vosj6bEvmkmmAGsX2t1ZrR4cJybUYi
         mjd3FoMOOZyIg==
Date:   Tue, 15 Jun 2021 16:04:11 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] tpm_ftpm_tee: Free and unregister TEE shared
 memory during kexec
Message-ID: <20210615130411.hvpnaxnhimjloiz3@kernel.org>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
 <20210610210913.536081-8-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610210913.536081-8-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 10, 2021 at 04:09:12PM -0500, Tyler Hicks wrote:
> dma-buf backed shared memory cannot be reliably freed and unregistered
> during a kexec operation even when tee_shm_free() is called on the shm
> from a .shutdown hook. The problem occurs because dma_buf_put() calls
> fput() which then uses task_work_add(), with the TWA_RESUME parameter,
> to queue tee_shm_release() to be called before the current task returns
> to user mode. However, the current task never returns to user mode
> before the kexec completes so the memory is never freed nor
> unregistered.
> 
> Use tee_shm_alloc_kernel_buf() to avoid dma-buf backed shared memory
> allocation so that tee_shm_free() can directly call tee_shm_release().
> This will ensure that the shm can be freed and unregistered during a
> kexec operation.
> 
> Fixes: 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE")
> Fixes: 1760eb689ed6 ("tpm/tpm_ftpm_tee: add shutdown call back")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 2ccdf8ac6994..6e3235565a4d 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -254,11 +254,11 @@ static int ftpm_tee_probe(struct device *dev)
>  	pvt_data->session = sess_arg.session;
>  
>  	/* Allocate dynamic shared memory with fTPM TA */
> -	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
> -				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
> -				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	pvt_data->shm = tee_shm_alloc_kernel_buf(pvt_data->ctx,
> +						 MAX_COMMAND_SIZE +
> +						 MAX_RESPONSE_SIZE);
>  	if (IS_ERR(pvt_data->shm)) {
> -		dev_err(dev, "%s: tee_shm_alloc failed\n", __func__);
> +		dev_err(dev, "%s: tee_shm_alloc_kernel_buf failed\n", __func__);
>  		rc = -ENOMEM;
>  		goto out_shm_alloc;
>  	}
> -- 
> 2.25.1
> 
> 

/Jarkko
