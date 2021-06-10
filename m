Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025B63A3556
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 23:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJVC4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 17:02:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:59198 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhFJVCz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 17:02:55 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 10DE820B7178;
        Thu, 10 Jun 2021 14:00:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10DE820B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623358859;
        bh=1gwFEPolZQHFZwTUj828RxfqMs5M/HAdxQV/Mcrv+ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHNY9mBKYgSjccyLTgX+NTkRaXnIpaq95F0fA0A4p2s58w+Ww8Kp12++AuJRIZelM
         Zm0YtQcqJziAe4YI+rUqPVCvD/jvTVmTz659UiZeKcFNorNJGq4LDGZazICn3WjIFF
         sV8u7pgA6lJUbjtcOSV/BQ7qH9sCu8JECqLQpgzA=
Date:   Thu, 10 Jun 2021 16:00:56 -0500
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
Message-ID: <20210610210056.GO4910@sequoia>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
 <20210609002326.210024-6-tyhicks@linux.microsoft.com>
 <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
 <20210609054621.GB4910@sequoia>
 <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>
 <20210609121533.GA2267052@jade>
 <20210609134225.GC4910@sequoia>
 <20210609135104.GD4910@sequoia>
 <20210610073424.GB2753553@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610073424.GB2753553@jade>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-06-10 09:34:24, Jens Wiklander wrote:
> On Wed, Jun 09, 2021 at 08:51:04AM -0500, Tyler Hicks wrote:
> [snip]
> > > > I've just posted "[PATCH 0/7] tee: shared memory updates",
> > > > https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander@linaro.org/
> > > > 
> > > > Where tee_shm_alloc() is replaced by among other functions
> > > > tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
> > > > problem with TEE_SHM_DMA_BUF.
> > > 
> > > Thanks! At first glance, that series would take care of the last three
> > > patches in my kexec/kdump series.
> > 
> > Correction: Your series would not completely take care of the last three
> > patches in my kexec/kdump series because your series doesn't implement
> > the .shutdown() hook for tee_bnxt_fw.
> > 
> > Does it make sense to take my series first and then rebase your series
> > on top of it? That would allow my fixes to flow back to stable, then
> > your changes would greatly clean up the implementation in future
> > releases.
> 
> Yes, we could try that. I'd like to see tee_shm_alloc_kernel_buf() being
> used instead of tee_shm_alloc() in ftpm_tee_probe() and
> tee_bnxt_fw_probe(). So it would be great if you could include "tee: add
> tee_shm_alloc_kernel_buf()" in your patch set.

That would be no problem at all. I like that idea and I've prepared a v4
with that change. I'll send it out shortly once I've finished testing.

> My patch set would then shrink a bit. By the way, thanks for reviewing
> it.

No problem! I feel like I'm starting to understand the TEE subsystem and
OP-TEE driver a bit so I'm happy to help out.

Tyler

> 
> Cheers,
> Jens
> 
