Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB13A5E61
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 10:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhFNIaU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 04:30:20 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39547 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhFNIaU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 04:30:20 -0400
Received: by mail-lf1-f43.google.com with SMTP id p17so19705973lfc.6
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jun 2021 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lKShWs6TAgVDNzfvLDvoWvURVhGxJq2LT0tIZHvVVo0=;
        b=tN6TUcF1TaNeAv5IgKoqjQFB0qVI0cHpgVdomlqe+8Pj3SSETdMRfS7bj0kO71T7C9
         On/qnrk8Yi6Rp9P9MPKQejEJj+M1+uvKuBgoUmmyegx3spH/RDiAgP/ruvV1HVaD5kDS
         fEUhLAISCUTrPZm3WmOjpufgAiCbN5S5ZAlaN1wnCVZAW3JGI8n7uzr8GibXmqzYaOQ3
         i8XiNp07KWXX8VbPtK6W6qWbomiNDwD173c6milPN/HNRDRy/4FTU45XIH6/QRThKsiq
         oiZwJVAjcdLM2GSF2v63/zDQh3yDPINJ8QiyerHYl98+6nxfL6KB8TXJrDRCEo/y2IHC
         LGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKShWs6TAgVDNzfvLDvoWvURVhGxJq2LT0tIZHvVVo0=;
        b=IIQoq6uXrJvodDKMHUZGF5JxDsGHvjfbllDm3vjQQgHW6hWktTz4BrL/POp0uJKS0F
         9bIDX0hqLl397m54Lv0fYMgOeDi0COY8udrbAw6rnjv5Z6bbZUdxKBzNjOxGAsMUUoUe
         yyBfbjQV63jH2c5EMmgrwllLDjuZEBXR/kGmLX0vQ1G7iN+L8bG2DW2udJgo/mxdxV3B
         clC+JCKl2Mwop6Id+1LfTMu+tpIqisKCFqbueTET9aj6ye7auE5Y8bUa9/VY0k9FPtpm
         eTQOckFCrxnzMCS/8a1zpwiq0KjERvtC7/VNcf7k4r5ZnrJxwYx45g+VgJgwwR6sfNFd
         x2ZQ==
X-Gm-Message-State: AOAM533nLjxIEannHgg1bzyI72wySKv4F0G0Qg3g6aPxK5nDi6LNKW5z
        zwAxUYpvkj0zAbyIxmVe553DFQ==
X-Google-Smtp-Source: ABdhPJz42E9QOqr7X/zeify/amV4v5uusvVtstK1olJuD9DDoUwb8Z/vy6Y/+TZYLNLJI9S0U9Lmng==
X-Received: by 2002:a05:6512:398a:: with SMTP id j10mr11424003lfu.636.1623659237016;
        Mon, 14 Jun 2021 01:27:17 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id a1sm1406066lfu.45.2021.06.14.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 01:27:16 -0700 (PDT)
Date:   Mon, 14 Jun 2021 10:27:15 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] optee: Clear stale cache entries during
 initialization
Message-ID: <20210614082715.GC1033436@jade>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
 <20210610210913.536081-5-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210610210913.536081-5-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 10, 2021 at 04:09:09PM -0500, Tyler Hicks wrote:
> The shm cache could contain invalid addresses if
> optee_disable_shm_cache() was not called from the .shutdown hook of the
> previous kernel before a kexec. These addresses could be unmapped or
> they could point to mapped but unintended locations in memory.
> 
> Clear the shared memory cache, while being careful to not translate the
> addresses returned from OPTEE_SMC_DISABLE_SHM_CACHE, during driver
> initialization. Once all pre-cache shm objects are removed, proceed with
> enabling the cache so that we know that we can handle cached shm objects
> with confidence later in the .shutdown hook.
> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/call.c          | 11 ++++++++++-
>  drivers/tee/optee/core.c          | 13 +++++++++++--
>  drivers/tee/optee/optee_private.h |  2 +-
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 6e6eb836e9b6..5dcba6105ed7 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -419,8 +419,10 @@ void optee_enable_shm_cache(struct optee *optee)
>   * optee_disable_shm_cache() - Disables caching of some shared memory allocation
>   *			      in OP-TEE
>   * @optee:	main service struct
> + * @is_mapped:	true if the cached shared memory addresses were mapped by this
> + *		kernel, are safe to dereference, and should be freed
>   */
> -void optee_disable_shm_cache(struct optee *optee)
> +void optee_disable_shm_cache(struct optee *optee, bool is_mapped)
>  {
>  	struct optee_call_waiter w;
>  
> @@ -439,6 +441,13 @@ void optee_disable_shm_cache(struct optee *optee)
>  		if (res.result.status == OPTEE_SMC_RETURN_OK) {
>  			struct tee_shm *shm;
>  
> +			/*
> +			 * Shared memory references that were not mapped by
> +			 * this kernel must be ignored to prevent a crash.
> +			 */
> +			if (!is_mapped)
> +				continue;
> +
>  			shm = reg_pair_to_ptr(res.result.shm_upper32,
>  					      res.result.shm_lower32);
>  			tee_shm_free(shm);
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 0987074d7ed0..6974e1104bd4 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -589,7 +589,7 @@ static int optee_remove(struct platform_device *pdev)
>  	 * reference counters and also avoid wild pointers in secure world
>  	 * into the old shared memory range.
>  	 */
> -	optee_disable_shm_cache(optee);
> +	optee_disable_shm_cache(optee, true);

Naked "true" or "false" parameters are normally not very descriptive.
Would it make sense to write this as:
optee_disable_shm_cache(optee, true /*is_mapped*/);
instead (same for the other call sites in this patch)? That way it would
be easier to see what it is that is true or false.

/Jens

>  
>  	/*
>  	 * The two devices have to be unregistered before we can free the
> @@ -619,7 +619,7 @@ static int optee_remove(struct platform_device *pdev)
>   */
>  static void optee_shutdown(struct platform_device *pdev)
>  {
> -	optee_disable_shm_cache(platform_get_drvdata(pdev));
> +	optee_disable_shm_cache(platform_get_drvdata(pdev), true);
>  }
>  
>  static int optee_probe(struct platform_device *pdev)
> @@ -716,6 +716,15 @@ static int optee_probe(struct platform_device *pdev)
>  	optee->memremaped_shm = memremaped_shm;
>  	optee->pool = pool;
>  
> +	/*
> +	 * Ensure that there are no pre-existing shm objects before enabling
> +	 * the shm cache so that there's no chance of receiving an invalid
> +	 * address during shutdown. This could occur, for example, if we're
> +	 * kexec booting from an older kernel that did not properly cleanup the
> +	 * shm cache.
> +	 */
> +	optee_disable_shm_cache(optee, false);
> +
>  	optee_enable_shm_cache(optee);
>  
>  	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index e25b216a14ef..16d8c82213e7 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -158,7 +158,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
>  int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
>  
>  void optee_enable_shm_cache(struct optee *optee);
> -void optee_disable_shm_cache(struct optee *optee);
> +void optee_disable_shm_cache(struct optee *optee, bool is_mapped);
>  
>  int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>  		       struct page **pages, size_t num_pages,
> -- 
> 2.25.1
> 
