Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91862D6425
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Dec 2020 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392195AbgLJR4A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 12:56:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:38323 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392468AbgLJRxA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 12:53:00 -0500
IronPort-SDR: 1Aq82sxJUnJJuzN4daFGRIY+GQpuuODCQCaPcy7OD6dufrCXGvuER3diRoSMUqScA2jZBKqmtR
 LYOSRYl5Px2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="154110160"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="154110160"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:51:15 -0800
IronPort-SDR: O9xj5AStRn1R/+n9qHsHejcuXQqjPe2N7zBcihmXhLps93EdZZo2Vwdx+lzK7LvWiIO3KGBQ+L
 xuouzydGXi3A==
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="320190821"
Received: from nabuhijl-mobl.ger.corp.intel.com (HELO [10.251.185.230]) ([10.251.185.230])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 09:51:10 -0800
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
 <e01e321d-d4ea-fcec-a3dc-16e641e49056@linux.intel.com>
 <87pn3hk12r.fsf@nanos.tec.linutronix.de>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <118a2e24-12f8-8a5c-193e-67e5ac37cac1@linux.intel.com>
Date:   Thu, 10 Dec 2020 17:51:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn3hk12r.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/12/2020 17:44, Thomas Gleixner wrote:
> On Thu, Dec 10 2020 at 17:09, Tvrtko Ursulin wrote:
>> On 10/12/2020 16:35, Thomas Gleixner wrote:
>>> I'll send out a series addressing irq_to_desc() (ab)use all over the
>>> place shortly. i915 is in there...
>>
>> Yep we don't need atomic, my bad. And we would care about the shared
>> interrupt line. And without atomic the extra accounting falls way below
>> noise.
> 
> You have to be careful though. If you make the accumulated counter 64
> bit wide then you need to be careful vs. 32bit machines.

Yep, thanks, I am bad jumping from one thing to another. Forgot about 
the read side atomicity completely..

>> So in the light of it all, it sounds best I just quickly replace our
>> abuse with private counting and then you don't have to deal with it in
>> your series.
> 
> I mostly have it. Still chewing on the 32bit vs. 64bit thing. And
> keeping it in my series allows me to remove the export of irq_to_desc()
> at the end without waiting for your tree to be merged.
> 
> Give me a few.

Ok.

Regards,

Tvrtko
