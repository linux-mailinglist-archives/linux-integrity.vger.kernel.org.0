Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C012D6329
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Dec 2020 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404043AbgLJRL4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 12:11:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:17797 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392581AbgLJRLt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 12:11:49 -0500
IronPort-SDR: d41Y+XWzAeTMKrgzKEl09M9eSv7KI2jSvgh145xZvFm066gfrrjUZuEYHduJ/hP2oCbV9PXPSn
 wY37elf7r3vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="162051068"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="162051068"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:09:43 -0800
IronPort-SDR: WE0hWg/82iCdDqPN3YvhJW4jlnyplmaYkBa3XkZQjjL3reiaF42Zga7gdGwHogLRW60Z0eWbWH
 4ViCmjePZsXg==
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="320011341"
Received: from nabuhijl-mobl.ger.corp.intel.com (HELO [10.251.185.230]) ([10.251.185.230])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:09:36 -0800
Subject: Re: [Intel-gfx] [PATCH v3 2/4] drm/i915/pmu: Use kstat_irqs to get
 interrupt count
To:     Thomas Gleixner <tglx@linutronix.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
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
 <e9892cc4-6344-be07-66b5-236b8576100e@linux.intel.com>
 <87v9d9k49q.fsf@nanos.tec.linutronix.de>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <e01e321d-d4ea-fcec-a3dc-16e641e49056@linux.intel.com>
Date:   Thu, 10 Dec 2020 17:09:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87v9d9k49q.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/12/2020 16:35, Thomas Gleixner wrote:
> On Thu, Dec 10 2020 at 10:45, Tvrtko Ursulin wrote:
>> On 10/12/2020 07:53, Joonas Lahtinen wrote:
>>> I think later in the thread there was a suggestion to replace this with
>>> simple counter increment in IRQ handler.
>>
>> It was indeed unsafe until recent b00bccb3f0bb ("drm/i915/pmu: Handle
>> PCI unbind") but now should be fine.
>>
>> If kstat_irqs does not get exported it is easy enough for i915 to keep a
>> local counter. Reasoning was very infrequent per cpu summation is much
>> cheaper than very frequent atomic add. Up to thousands of interrupts per
>> second vs "once per second" PMU read kind of thing.
> 
> Why do you need a atomic_add? It's ONE interrupt which can only be
> executed on ONE CPU at a time. Interrupt handlers are non-reentrant.
> 
> The core code function will just return an accumulated counter nowadays
> which is only 32bit wide, which is what the interface provided forever.
> That needs to be fixed first.
> 
> Aside of that the accounting is wrong when the interrupt line is shared
> because the core accounts interrupt per line not per device sharing the
> line. Don't know whether you care or not.
> 
> I'll send out a series addressing irq_to_desc() (ab)use all over the
> place shortly. i915 is in there...

Yep we don't need atomic, my bad. And we would care about the shared 
interrupt line. And without atomic the extra accounting falls way below 
noise.

So in the light of it all, it sounds best I just quickly replace our 
abuse with private counting and then you don't have to deal with it in 
your series.

Regards,

Tvrtko
