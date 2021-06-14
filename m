Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338093A6EA8
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Jun 2021 21:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhFNTR0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Jun 2021 15:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhFNTRZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jun 2021 15:17:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E551C061767
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jun 2021 12:15:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p7so22877777lfg.4
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jun 2021 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wy8kQavMtXmWXRWEMXyBLTsbu5eZVxKlmyQPGuM6Q58=;
        b=FWr0n7oPVWQ+3ixl2B6aJCUI1aaCUd3rD6xJGopgi+G3S51eI5WKQ6RLQjpPrczgUw
         Uv0FHlvR2bzE518D6Y8Nnd/A9KiVMaCI2gSxXq8KXbC9nPq7xPZUmdAb20/xqNrBMm2Q
         CGXZz1OHoOXQIUe+85wv+Fkcar+3OSXseqHfWbcgWwW0BU6jkdXwsT97JMQNw7Tf/2+X
         p7oPoA/6/h+DD9SL5oa6HWhxT5QuVdVfooxkkHO+C3hr+rcIBRMMAX8k0bck9jBNCTh1
         Jm3gyrqgrVOn9jD0nZlU0ZGZpJBRY8kw5pL418zBh/RpWSEEhpl0Xk+GqptBgSYtL73c
         9Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wy8kQavMtXmWXRWEMXyBLTsbu5eZVxKlmyQPGuM6Q58=;
        b=OHIWWn4kaCRuFcMOqr3MEwlrxV84HM1bPJNVf2Dkvexx6Ncuj/ENMy2s6USaVMWiBi
         coMqUooNTT0y5MCYoNM+e0xFlg5aYTU5baQVENSoY5zIqJPgBMMK5cCVuLYIDQBgZkg9
         Bxtko6fm3b14vp7lwndGHKaAkHPdqtqYMEzPm95N22izdcNEzhIgaDUThP4s4b18YViK
         B8SZHFxQ3PsyRQwEmDcAzZiDlTQCZwbzyvSkPz3Vn6ZlrT9EQ1Ei0u1uNaJGpcMFlc6M
         fHxoOoBFbU1orXH2nhyM6nZiHgB6a1rke9fqAc1PNtSOkuV2YMkSR11MjbaSXw+MokJt
         lLEA==
X-Gm-Message-State: AOAM533IxXQ8kCw+7YI+sDeEJ/iWgeOC02Y+OE4dU03iLDP7z5bgZPV+
        S5be9LXufl3ZEtdh33hkus95SA==
X-Google-Smtp-Source: ABdhPJzy3L13GiiOVq+u0errQIuLZDbWTXWtPICnFywU3zpYMn5wnv69XzZ5bLPGkSg6b7LUTT5JwA==
X-Received: by 2002:a19:480a:: with SMTP id v10mr12826757lfa.565.1623698108333;
        Mon, 14 Jun 2021 12:15:08 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id i5sm1559817lfe.113.2021.06.14.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:15:07 -0700 (PDT)
Date:   Mon, 14 Jun 2021 21:15:06 +0200
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
Message-ID: <20210614191506.GA1373417@jade>
References: <20210610210913.536081-1-tyhicks@linux.microsoft.com>
 <20210610210913.536081-5-tyhicks@linux.microsoft.com>
 <20210614082715.GC1033436@jade>
 <20210614190646.GW4910@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210614190646.GW4910@sequoia>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 14, 2021 at 02:06:46PM -0500, Tyler Hicks wrote:
> On 2021-06-14 10:27:15, Jens Wiklander wrote:
> > On Thu, Jun 10, 2021 at 04:09:09PM -0500, Tyler Hicks wrote:
> > > The shm cache could contain invalid addresses if
> > > optee_disable_shm_cache() was not called from the .shutdown hook of the
> > > previous kernel before a kexec. These addresses could be unmapped or
> > > they could point to mapped but unintended locations in memory.
> > > 
> > > Clear the shared memory cache, while being careful to not translate the
> > > addresses returned from OPTEE_SMC_DISABLE_SHM_CACHE, during driver
> > > initialization. Once all pre-cache shm objects are removed, proceed with
> > > enabling the cache so that we know that we can handle cached shm objects
> > > with confidence later in the .shutdown hook.
> > > 
> > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > ---
> > >  drivers/tee/optee/call.c          | 11 ++++++++++-
> > >  drivers/tee/optee/core.c          | 13 +++++++++++--
> > >  drivers/tee/optee/optee_private.h |  2 +-
> > >  3 files changed, 22 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > index 6e6eb836e9b6..5dcba6105ed7 100644
> > > --- a/drivers/tee/optee/call.c
> > > +++ b/drivers/tee/optee/call.c
> > > @@ -419,8 +419,10 @@ void optee_enable_shm_cache(struct optee *optee)
> > >   * optee_disable_shm_cache() - Disables caching of some shared memory allocation
> > >   *			      in OP-TEE
> > >   * @optee:	main service struct
> > > + * @is_mapped:	true if the cached shared memory addresses were mapped by this
> > > + *		kernel, are safe to dereference, and should be freed
> > >   */
> > > -void optee_disable_shm_cache(struct optee *optee)
> > > +void optee_disable_shm_cache(struct optee *optee, bool is_mapped)
> > >  {
> > >  	struct optee_call_waiter w;
> > >  
> > > @@ -439,6 +441,13 @@ void optee_disable_shm_cache(struct optee *optee)
> > >  		if (res.result.status == OPTEE_SMC_RETURN_OK) {
> > >  			struct tee_shm *shm;
> > >  
> > > +			/*
> > > +			 * Shared memory references that were not mapped by
> > > +			 * this kernel must be ignored to prevent a crash.
> > > +			 */
> > > +			if (!is_mapped)
> > > +				continue;
> > > +
> > >  			shm = reg_pair_to_ptr(res.result.shm_upper32,
> > >  					      res.result.shm_lower32);
> > >  			tee_shm_free(shm);
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index 0987074d7ed0..6974e1104bd4 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -589,7 +589,7 @@ static int optee_remove(struct platform_device *pdev)
> > >  	 * reference counters and also avoid wild pointers in secure world
> > >  	 * into the old shared memory range.
> > >  	 */
> > > -	optee_disable_shm_cache(optee);
> > > +	optee_disable_shm_cache(optee, true);
> > 
> > Naked "true" or "false" parameters are normally not very descriptive.
> > Would it make sense to write this as:
> > optee_disable_shm_cache(optee, true /*is_mapped*/);
> > instead (same for the other call sites in this patch)? That way it would
> > be easier to see what it is that is true or false.
> 
> Yeah, I understand the issue with the naked bools. What about turning
> 'optee_disable_shm_cache(struct optee *optee, bool is_mapped)' into
> '__optee_disable_shm_cache(struct optee *optee, bool is_mapped)' and
> introducing these two wrappers:
> 
> /**
>  * optee_disable_shm_cache() - Disables caching of mapped shared memory
>  *                             allocations in OP-TEE
>  * @optee:     main service struct
>  */
> void optee_disable_shm_cache(struct optee *optee)
> {
>        return __optee_disable_shm_cache(optee, true);
> }
> 
> /**
>  * optee_disable_unmapped_shm_cache() - Disables caching of shared memory
>  *                                      allocations in OP-TEE which are not
>  *                                      currently mapped
>  * @optee:     main service struct
>  */
> void optee_disable_unmapped_shm_cache(struct optee *optee)
> {
>        return __optee_disable_shm_cache(optee, false);
> }
> 
> Existing callers of optee_disable_shm_cache() remain unchanged and we just add
> one caller of optee_disable_unmapped_shm_cache() with this patch.
> 

Sounds good.

Jens
