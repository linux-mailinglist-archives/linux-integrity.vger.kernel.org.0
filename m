Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375AE2D5889
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Dec 2020 11:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389050AbgLJKra (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 05:47:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:14595 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389008AbgLJKr2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 05:47:28 -0500
IronPort-SDR: 3DQ5cz0pGvnkGCg3HtsKNemPimHYB74sbnSCgxxB0mTTAWNxZ5O32b5oFn5p8yoEw4qgx3A/C8
 qzPRetHQWbBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="192546249"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="192546249"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 02:45:42 -0800
IronPort-SDR: 8B5JILFNwgpLoTaLek6lDBxucy5SOqjmME7GMXrefffU9h3aOhRW/kkWr7tMkBT7Ul/eo4ThxS
 Po3iPyr1yLcg==
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="319007397"
Received: from nabuhijl-mobl.ger.corp.intel.com (HELO [10.251.185.230]) ([10.251.185.230])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 02:45:37 -0800
Subject: Re: [Intel-gfx] [PATCH v3 2/4] drm/i915/pmu: Use kstat_irqs to get
 interrupt count
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        intel-gfx@lists.freedesktop.org,
        Matthew Garrett <mjg59@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Airlie <airlied@linux.ie>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-integrity@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-3-jsnitsel@redhat.com>
 <875z5e99ez.fsf@nanos.tec.linutronix.de>
 <160758677957.5062.15497765500689083558@jlahtine-mobl.ger.corp.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <e9892cc4-6344-be07-66b5-236b8576100e@linux.intel.com>
Date:   Thu, 10 Dec 2020 10:45:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160758677957.5062.15497765500689083558@jlahtine-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/12/2020 07:53, Joonas Lahtinen wrote:
> + Tvrtko and Chris for comments
> 
> Code seems to be added in:
> 
> commit 0cd4684d6ea9a4ffec33fc19de4dd667bb90d0a5
> Author: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Date:   Tue Nov 21 18:18:50 2017 +0000
> 
>      drm/i915/pmu: Add interrupt count metric
> 
> I think later in the thread there was a suggestion to replace this with
> simple counter increment in IRQ handler.

It was indeed unsafe until recent b00bccb3f0bb ("drm/i915/pmu: Handle 
PCI unbind") but now should be fine.

If kstat_irqs does not get exported it is easy enough for i915 to keep a 
local counter. Reasoning was very infrequent per cpu summation is much 
cheaper than very frequent atomic add. Up to thousands of interrupts per 
second vs "once per second" PMU read kind of thing.

Regards,

Tvrtko

> Quoting Thomas Gleixner (2020-12-06 18:38:44)
>> On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:
>>
>>> Now that kstat_irqs is exported, get rid of count_interrupts in
>>> i915_pmu.c
>>> --- a/drivers/gpu/drm/i915/i915_pmu.c
>>> +++ b/drivers/gpu/drm/i915/i915_pmu.c
>>> @@ -423,22 +423,6 @@ static enum hrtimer_restart i915_sample(struct hrtimer *hrtimer)
>>>        return HRTIMER_RESTART;
>>>   }
>>>   
>>> -static u64 count_interrupts(struct drm_i915_private *i915)
>>> -{
>>> -     /* open-coded kstat_irqs() */
>>> -     struct irq_desc *desc = irq_to_desc(i915->drm.pdev->irq);
>>> -     u64 sum = 0;
>>> -     int cpu;
>>> -
>>> -     if (!desc || !desc->kstat_irqs)
>>> -             return 0;
>>> -
>>> -     for_each_possible_cpu(cpu)
>>> -             sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
>>> -
>>> -     return sum;
>>> -}
>>
>> May I ask why this has been merged in the first place?
>>
>> Nothing in a driver has ever to fiddle with the internals of an irq
>> descriptor. We have functions for properly accessing them. Just because
>> C allows to fiddle with everything is not a justification. If the
>> required function is not exported then adding the export with a proper
>> explanation is not asked too much.
>>
>> Also this lacks protection or at least a comment why this can be called
>> safely and is not subject to a concurrent removal of the irq descriptor.
>> The same problem exists when calling kstat_irqs(). It's even documented
>> at the top of the function.
>>
>> Thanks,
>>
>>          tglx
>>
>>
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 
