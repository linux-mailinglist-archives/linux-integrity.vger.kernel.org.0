Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360122D2839
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 10:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgLHJzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 04:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgLHJzU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 04:55:20 -0500
Date:   Tue, 8 Dec 2020 11:54:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607421279;
        bh=XaAiKY++wv+M/pEQ1YMGklfnktr6P64K75FF//gLABU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=QaB10O3rXRlsz3jL/My6bXO3XK0Nt8oWAtezsz2d6c8xEOp09HWJfMHLPyW47A9o5
         acD+9HQ8TOhBioB6ICPp8erOZNmu0tqsM0cSLPQxiCXt30p5namEDToHhhfxHygra1
         ijoy3TJghKlWlRBo20u+fHI8krrFK1qWWBjWmieU090Pk4QglIxsfAzFWEYBXo6zcD
         ozrHclftiywg7TvFA+UMAEyDRDuc6C2IzCtzf3bucwszo/yl7WU/r0nsxgd9l7kUBe
         gdFo1qPgEJgJM98lQ5pNlGd8UIwdL+KLpFLA8Y5mBgy/4jmooYgc9ga4jc+IWUTar2
         KJ9EghZZxxaTQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/4] drm/i915/pmu: Use kstat_irqs to get interrupt
 count
Message-ID: <20201208095432.GA44672@kernel.org>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-3-jsnitsel@redhat.com>
 <875z5e99ez.fsf@nanos.tec.linutronix.de>
 <87o8j67h7u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8j67h7u.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 06, 2020 at 10:33:09PM +0100, Thomas Gleixner wrote:
> On Sun, Dec 06 2020 at 17:38, Thomas Gleixner wrote:
> > On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:
> >> Now that kstat_irqs is exported, get rid of count_interrupts in
> >> i915_pmu.c
> >
> > May I ask why this has been merged in the first place?
> >
> > Nothing in a driver has ever to fiddle with the internals of an irq
> > descriptor. We have functions for properly accessing them. Just because
> > C allows to fiddle with everything is not a justification. If the
> > required function is not exported then adding the export with a proper
> > explanation is not asked too much.
> >
> > Also this lacks protection or at least a comment why this can be called
> > safely and is not subject to a concurrent removal of the irq descriptor.
> > The same problem exists when calling kstat_irqs(). It's even documented
> > at the top of the function.
> 
> And as pointed out vs. that TPM thing this really could have been a
> trivial
> 
>     i915->irqs++;
> 
> in the interrupt handler and a read of that instead of iterating over
> all possible cpus and summing it up. Oh well...

I'm fine with that. 

> Thanks,
> 
>         tglx

/Jarkko
