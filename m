Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45D3A3563
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFJVHB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:07:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59734 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJVHB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:07:01 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1A69520B7178;
        Thu, 10 Jun 2021 14:05:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A69520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623359104;
        bh=9heYwDg7HkXqmnRyjiu31yAcnxTkKMw3sVGVK8qX7II=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NL/mZr/sTjypmf8YXwF9PG/hiD3wixy3Z8rZov3Q4mL477kgo3L+JGWgn5s1E/IhJ
         ok1Q2mM+7sKmkUGr4th02hNY+gb2HRC533UHj4s/mXCKrzfqjZeeNL1WvBMeab1g3z
         TJczE2jmC3xVo/G1up5fiW4ZFLlX5bKSWA+85HKs=
Date:   Thu, 10 Jun 2021 16:05:01 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, Rijo-john.Thomas@amd.com,
        Allen Pais <apais@linux.microsoft.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf
 backing
Message-ID: <20210610210501.GP4910@sequoia>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
 <20210609002326.210024-6-tyhicks@linux.microsoft.com>
 <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
 <20210609054621.GB4910@sequoia>
 <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>
 <20210609121533.GA2267052@jade>
 <20210609134225.GC4910@sequoia>
 <20210610074948.GC2753553@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610074948.GC2753553@jade>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-06-10 09:49:48, Jens Wiklander wrote:
> On Wed, Jun 09, 2021 at 08:42:25AM -0500, Tyler Hicks wrote:
> [snip]
> > > I've just posted "[PATCH 0/7] tee: shared memory updates",
> > > https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander@linaro.org/
> > > 
> > > Where tee_shm_alloc() is replaced by among other functions
> > > tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
> > > problem with TEE_SHM_DMA_BUF.
> > 
> > Thanks! At first glance, that series would take care of the last three
> > patches in my kexec/kdump series.
> > 
> > I'm a bit worried that it is a rewrite of the shm allocator. Do you plan
> > to send all of that to stable? (I mentioned earlier in this thread that
> > I'm affected by these bugs in linux-5.4.y.)
> 
> No, that might be a bit much.
> 
> > Also, you and Sumit don't seem to have the same opinion on kernel
> > drivers making use of tee_shm_register() for allocations that are only
> > used internally. Can you comment on that?
> > 
> > I'm not clear on the next steps for fixing these kexec/kdump bugs in
> > older releases. I appreciate any guidance here.
> 
> Neither am I be honest. You're the only one that has brought up this
> problem so perhaps it's enough to focus on the stable branch you need to
> have fixed.

I've already added Fixes tags to all of my patches. If you are
comfortable with them going to stable, you'd add
'Cc: stable@vger.kernel.org' to them if/when you merge them so that the
stable team will ensure that they're applied.

Note that I'm not the only person that brought up this bug:

 https://github.com/OP-TEE/optee_os/issues/3637

Once I started digging in, I realized that there were more kexec/kdump
bugs and the series grew.

> If I've understood it correctly it's best if it's possible to
> cherry-pick the fixes from mainline to the stable branch in question.
> So we must make sure to get your needed patches in before any rewrites
> that would make cherry-picking impossible. The rewrite I'm proposing
> isn't urgent so it can be held off for a while.

Thanks for holding off. I'll be quick on my revisions so that you don't
have to moth ball your series for too much longer.

Tyler

> 
> Cheers,
> Jens
> 
