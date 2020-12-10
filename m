Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBA42D6212
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Dec 2020 17:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391237AbgLJQgi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 11:36:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54896 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387497AbgLJQga (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 11:36:30 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607618146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tedn7ymzbpjBuwONM7mrejLqIAj0SfIl9BNyEo5uI8Y=;
        b=KSh5MFgKhKV2r++wKQZfsUKt7eCfO/xJn6HjBp4Nglh9z5HFvTcfcLDksgQz0sGXAP7hqf
        nLCCQoI9DObj4QYOPCpfXgLJGflGvvhjGLT27w0BqrDI5I84IRLRjwjGOAFWxpjXwscPB2
        Y6gEwAVllaW1m7ib4fV5KVDXGI4cVA9jedNYzURdIzPE1wnLVzorfHM4qUln87EXe5Bsb0
        6+nTg1coMHAexhAIxt3odg8QXMDU2app2/gCYQG8sQymCxFm83NhYUdOZ3+oZ2TojeStIa
        sCSQEkcoGTBecC3pHY/OOJ5f0eXU9U8WUvqYkPmDzOOR4/DceEQFJiUycAMaig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607618146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tedn7ymzbpjBuwONM7mrejLqIAj0SfIl9BNyEo5uI8Y=;
        b=j3pyJVh6vB5Rn5BUoY8WosYAfGOnLLmOr8onRpTOw1D0awi2VezrJSrbi6GPfNbIwXIaOL
        mxLB6fFc/8WJ3yBg==
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
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
Subject: Re: [Intel-gfx] [PATCH v3 2/4] drm/i915/pmu: Use kstat_irqs to get interrupt count
In-Reply-To: <e9892cc4-6344-be07-66b5-236b8576100e@linux.intel.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-3-jsnitsel@redhat.com> <875z5e99ez.fsf@nanos.tec.linutronix.de> <160758677957.5062.15497765500689083558@jlahtine-mobl.ger.corp.intel.com> <e9892cc4-6344-be07-66b5-236b8576100e@linux.intel.com>
Date:   Thu, 10 Dec 2020 17:35:45 +0100
Message-ID: <87v9d9k49q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 10 2020 at 10:45, Tvrtko Ursulin wrote:
> On 10/12/2020 07:53, Joonas Lahtinen wrote:
>> I think later in the thread there was a suggestion to replace this with
>> simple counter increment in IRQ handler.
>
> It was indeed unsafe until recent b00bccb3f0bb ("drm/i915/pmu: Handle 
> PCI unbind") but now should be fine.
>
> If kstat_irqs does not get exported it is easy enough for i915 to keep a 
> local counter. Reasoning was very infrequent per cpu summation is much 
> cheaper than very frequent atomic add. Up to thousands of interrupts per 
> second vs "once per second" PMU read kind of thing.

Why do you need a atomic_add? It's ONE interrupt which can only be
executed on ONE CPU at a time. Interrupt handlers are non-reentrant.

The core code function will just return an accumulated counter nowadays
which is only 32bit wide, which is what the interface provided forever.
That needs to be fixed first.

Aside of that the accounting is wrong when the interrupt line is shared
because the core accounts interrupt per line not per device sharing the
line. Don't know whether you care or not.

I'll send out a series addressing irq_to_desc() (ab)use all over the
place shortly. i915 is in there...

Thanks,

        tglx
