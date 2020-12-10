Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387422D63F5
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Dec 2020 18:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392895AbgLJRpa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Dec 2020 12:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392897AbgLJRp0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Dec 2020 12:45:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D515C0613CF;
        Thu, 10 Dec 2020 09:44:46 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607622284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oeioyqpxNmG6CK8lLuYIEgegZmVE7BiOpQp+xJs/g5M=;
        b=nFpOge/3DK/YrVphh+ZKWZYuF1Z9nOGge7xU97iWnUyzPbaEFKCmHRLc8uXkq/UajGCT5N
        OncAX1nMt1jLZ9Zpu2A3eiw5nnrk2Wc6fPLw8c8bJAQ/WAxLUszBEbdn8OLNplLWrI/2Gb
        F7KcieQGQ4eBqcsJV7BUSYwmoMRFFvGtOLAVBkDpMemGux1f0WYLqf210QcCp3hX34VjmK
        PPuojzqSecXQCIRBtQb4VSB46fptypIDq6BQrST9YDHc1v+XDLurqAo59LaSQrHrh8+CB4
        +Dmw0dMvmpPZC/70Y48xr5qEpr5O4MomnWtOqao1KuNEg06CM0OceEHjHLpO7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607622284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oeioyqpxNmG6CK8lLuYIEgegZmVE7BiOpQp+xJs/g5M=;
        b=rWL5Y9Xn9fN7dzBlg88tnUbJnatJ/mJ8Nef3j1Bgh0vv4WhDAu4D4F9E4/waF+d2Zh+v12
        EW4+HqySJVUXLIBA==
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
In-Reply-To: <e01e321d-d4ea-fcec-a3dc-16e641e49056@linux.intel.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-3-jsnitsel@redhat.com> <875z5e99ez.fsf@nanos.tec.linutronix.de> <160758677957.5062.15497765500689083558@jlahtine-mobl.ger.corp.intel.com> <e9892cc4-6344-be07-66b5-236b8576100e@linux.intel.com> <87v9d9k49q.fsf@nanos.tec.linutronix.de> <e01e321d-d4ea-fcec-a3dc-16e641e49056@linux.intel.com>
Date:   Thu, 10 Dec 2020 18:44:44 +0100
Message-ID: <87pn3hk12r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 10 2020 at 17:09, Tvrtko Ursulin wrote:
> On 10/12/2020 16:35, Thomas Gleixner wrote:
>> I'll send out a series addressing irq_to_desc() (ab)use all over the
>> place shortly. i915 is in there...
>
> Yep we don't need atomic, my bad. And we would care about the shared 
> interrupt line. And without atomic the extra accounting falls way below 
> noise.

You have to be careful though. If you make the accumulated counter 64
bit wide then you need to be careful vs. 32bit machines.

> So in the light of it all, it sounds best I just quickly replace our 
> abuse with private counting and then you don't have to deal with it in 
> your series.

I mostly have it. Still chewing on the 32bit vs. 64bit thing. And
keeping it in my series allows me to remove the export of irq_to_desc()
at the end without waiting for your tree to be merged.

Give me a few.

Thanks,

        tglx
