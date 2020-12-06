Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9AF2D0768
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Dec 2020 22:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgLFVdv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 16:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFVdv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 16:33:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E43C0613D0;
        Sun,  6 Dec 2020 13:33:11 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607290389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0kvt6ku7dAshK929r0L7tdGjX3+YC59SkyEOBkJSfw=;
        b=ViQOkJ7y6DMyLlYw2pFNCVTsHYT9GQX+KFN7FN+6iKVQCrO3nwmjriqX669EFSMG5yd329
        v3a0aGmc7aViLV60ceiXGva2d7J/MXBparmVZo+0UOOtHkGm6MHksfFAuZ7uvo/tq7WXwd
        l+banRKjlAmprFfZDb8wu5DFOhVf/7wrK/7xjdmys22NF43KBmReMl0yw1qDBotj4lDcB6
        syzd5dIGhzb1SQpegOTY4TBmxTLuAq/ocxhhaPDBae/XoqbSuSViXRmKYotaqdYZFrPpBR
        zPmdc3AOy62qlpBZtmGzMga5lt2JAk15B4I+2Yo1WCxGnYphkC/oRDbHURsFNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607290389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0kvt6ku7dAshK929r0L7tdGjX3+YC59SkyEOBkJSfw=;
        b=qW6VGJay7Y1fRfpZcbDGnE0csxZUMMAVFl/445dozitpWgLzD9ZrsjtZhGTYRnXTNR7Y5U
        O+a1wpKLG8xbaeAg==
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
In-Reply-To: <875z5e99ez.fsf@nanos.tec.linutronix.de>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-3-jsnitsel@redhat.com> <875z5e99ez.fsf@nanos.tec.linutronix.de>
Date:   Sun, 06 Dec 2020 22:33:09 +0100
Message-ID: <87o8j67h7u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 06 2020 at 17:38, Thomas Gleixner wrote:
> On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:
>> Now that kstat_irqs is exported, get rid of count_interrupts in
>> i915_pmu.c
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

And as pointed out vs. that TPM thing this really could have been a
trivial

    i915->irqs++;

in the interrupt handler and a read of that instead of iterating over
all possible cpus and summing it up. Oh well...

Thanks,

        tglx
