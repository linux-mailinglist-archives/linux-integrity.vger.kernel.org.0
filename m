Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A852D0606
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Dec 2020 17:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgLFQj0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 11:39:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58988 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgLFQj0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 11:39:26 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607272724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=orscdnWsxTjeOjrX4mZ7RlgaGlM/iHr3hxGeVG/5B5o=;
        b=S9U+yLW+RMD4XJ+DVjlUuG1Ta3scM6aUrIt7ysUfUnpo2Lk9yrcK1AlcgrZWgFWCtYoJTF
        VExnxFo/ryb4R7eRQEVwMsDGha92iA0oI81k+3gGLFB1nonwAisjC3/jKTSUf/nGy1d64W
        /i1uYHhHy/jPj6waERlxa7GsrP6eM2yH0numGnZwlG3dEBTbqM59AhAzaFX9Pkk1y9qak3
        dhXHo9nnSGnB608LNXSZ0BSANnW+ESKfmIzwLrnY3Zp+ef11yigXhYhPrhNWafb4cMW6lM
        JyoZkKlnRO1jdjGoihuwGfLZqyXfJAFPDlho62hQLrm5QKAPcdCuOpSMM3JdkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607272724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=orscdnWsxTjeOjrX4mZ7RlgaGlM/iHr3hxGeVG/5B5o=;
        b=AksEazRjmD+yqQmgK8+KYrxZfIF8IEb97GXwe2YdDqzKrwXlC8Rc+QhlrKd/lk5AZdXYm6
        zdJsYoIctUvQBdCw==
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/4] drm/i915/pmu: Use kstat_irqs to get interrupt count
In-Reply-To: <20201205014340.148235-3-jsnitsel@redhat.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-3-jsnitsel@redhat.com>
Date:   Sun, 06 Dec 2020 17:38:44 +0100
Message-ID: <875z5e99ez.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:

> Now that kstat_irqs is exported, get rid of count_interrupts in
> i915_pmu.c
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -423,22 +423,6 @@ static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
>  	return HRTIMER_RESTART;
>  }
>  
> -static u64 count_interrupts(struct drm_i915_private *i915)
> -{
> -	/* open-coded kstat_irqs() */
> -	struct irq_desc *desc = irq_to_desc(i915->drm.pdev->irq);
> -	u64 sum = 0;
> -	int cpu;
> -
> -	if (!desc || !desc->kstat_irqs)
> -		return 0;
> -
> -	for_each_possible_cpu(cpu)
> -		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
> -
> -	return sum;
> -}

May I ask why this has been merged in the first place?

Nothing in a driver has ever to fiddle with the internals of an irq
descriptor. We have functions for properly accessing them. Just because
C allows to fiddle with everything is not a justification. If the
required function is not exported then adding the export with a proper
explanation is not asked too much.

Also this lacks protection or at least a comment why this can be called
safely and is not subject to a concurrent removal of the irq descriptor.
The same problem exists when calling kstat_irqs(). It's even documented
at the top of the function.

Thanks,

        tglx


