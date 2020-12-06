Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1972D077A
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Dec 2020 22:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgLFVtQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 16:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727375AbgLFVtQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 16:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607291269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTK3a2EpgqcMFsmrPHPH78wqX4JkIQW5zqkRG3GIknw=;
        b=Hj0gyByvgDu0Rq1YE5neEAyLLyFJ9SXYRtEusp6RezfuEcypIUlm/pX/rYommhUVMYC7Yp
        +1g3x5Qxf8Srx7/o4IN8BAO7H8kndoatyrx7Wx4RIRqnfGJQpII0441YlDtdBmhoIyzog9
        HT9mEOqAgK5OQy6rhseB94qg75+UgYA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-ubgBTMetMxSKOG4hveI7Qg-1; Sun, 06 Dec 2020 16:47:47 -0500
X-MC-Unique: ubgBTMetMxSKOG4hveI7Qg-1
Received: by mail-qk1-f200.google.com with SMTP id t127so5793690qkf.0
        for <linux-integrity@vger.kernel.org>; Sun, 06 Dec 2020 13:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=OTK3a2EpgqcMFsmrPHPH78wqX4JkIQW5zqkRG3GIknw=;
        b=PHSP80RYYg506WYSGFKG0D5rMsHlNwf0gN/EYl6+tKKqq/ZEU1v4VVu73r05bpi31D
         2juIVjSy7+FgAVW+eLfuZ/dn5k2H0aOff9tAOlGmcPfow81JgG1VHMg6apnDPUii5sut
         tLCKdKi93TcbMZXgMddhoVEfYiYt3+JUw8zDlNhuroyo53recjLYQW8nWLnqhO/97qva
         iUwV6nSXQ9AZA+6S0KbbgzaamT/gK10QyJgrBKj/1slgLQiOeXjyT7wNzIkxNTi7bmyW
         gNUQJ9iUXiThoJrwjVAXqqb3P1fpdwO7Ul3CXUTb6Hl5fAR2X3PI4YaHtdwDO0P6lFDk
         jCbA==
X-Gm-Message-State: AOAM533E/sqwP8xFX4pcrIqmb1BdXD1F5zL6Ch3LXJYcwCAp1jZmcGfQ
        tCb/Ps1WDIw3QmE86T9ATJ1w1Cwa49SjqPDBWhU6KC+2NeMZMnSd8Ofcg9gXm8IP44mvNtku2QW
        Hopx57EXyIXdcFQv5NYUtz/3Q1Ldp
X-Received: by 2002:a37:9301:: with SMTP id v1mr20962176qkd.419.1607291267447;
        Sun, 06 Dec 2020 13:47:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTSYUz8GprH7ZZQl7rfRTzOkUrvIm8134juk0lMfV/+12SIrmCKNfTzdhZMT6UYl2b500iiQ==
X-Received: by 2002:a37:9301:: with SMTP id v1mr20962158qkd.419.1607291267253;
        Sun, 06 Dec 2020 13:47:47 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o5sm565190qti.47.2020.12.06.13.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 13:47:46 -0800 (PST)
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-3-jsnitsel@redhat.com>
 <875z5e99ez.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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
In-reply-to: <875z5e99ez.fsf@nanos.tec.linutronix.de>
Date:   Sun, 06 Dec 2020 14:47:45 -0700
Message-ID: <87im9ehaim.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Thomas Gleixner @ 2020-12-06 09:38 MST:

> On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:
>
>> Now that kstat_irqs is exported, get rid of count_interrupts in
>> i915_pmu.c
>> --- a/drivers/gpu/drm/i915/i915_pmu.c
>> +++ b/drivers/gpu/drm/i915/i915_pmu.c
>> @@ -423,22 +423,6 @@ static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
>>  	return HRTIMER_RESTART;
>>  }
>>  
>> -static u64 count_interrupts(struct drm_i915_private *i915)
>> -{
>> -	/* open-coded kstat_irqs() */
>> -	struct irq_desc *desc = irq_to_desc(i915->drm.pdev->irq);
>> -	u64 sum = 0;
>> -	int cpu;
>> -
>> -	if (!desc || !desc->kstat_irqs)
>> -		return 0;
>> -
>> -	for_each_possible_cpu(cpu)
>> -		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
>> -
>> -	return sum;
>> -}
>
> May I ask why this has been merged in the first place?
>
> Nothing in a driver has ever to fiddle with the internals of an irq
> descriptor. We have functions for properly accessing them. Just because
> C allows to fiddle with everything is not a justification. If the
> required function is not exported then adding the export with a proper
> explanation is not asked too much.
>
> Also this lacks protection or at least a comment why this can be called
> safely and is not subject to a concurrent removal of the irq descriptor.
> The same problem exists when calling kstat_irqs(). It's even documented
> at the top of the function.
>
> Thanks,
>
>         tglx

I don't know the history behind this bit. I stumbled across it in cscope
when looking for places using kstat_irqs.

