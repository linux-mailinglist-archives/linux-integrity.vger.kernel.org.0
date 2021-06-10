Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3418E3A2593
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 09:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFJHgj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 03:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhFJHgi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 03:36:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412EC061574
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jun 2021 00:34:28 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n17so3501203ljg.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jun 2021 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=whZ8Oikp5eEVLol9V4HjAY7/BKBCWE79+ODfDRRUzIE=;
        b=KK7I5CiKwC2htrnJ7Zdk2FDbW3ArHEPczYUJ0+rqA0DZ4T/iZVGWEa9Qu46oZy2WPf
         5Tx3MOWEG49ZKtjdPwr3A16oNxdmybV7HLqHoGV0iZSF7TXiNCp/X5Q3yLxp2U2UhYIO
         5vkCBePqUfb2SWGeAIo4a5HkaTLW58zyGFZwWHzhNhlhZD30yoYVPhgWJeJ5qCwCbePT
         uDhSPC3ptvCj9y882H72DjQBS/5Xy2sxX3oGv526vFKwj5zoo9hkvS7f4qkXEsOpYikM
         AzubVqnibc1cVfZ+ohIOTEb9RDWPCUydrIcWI1knax9jt6ksG3MtWt9G6SO4S3wUOddB
         2n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=whZ8Oikp5eEVLol9V4HjAY7/BKBCWE79+ODfDRRUzIE=;
        b=S5y52/Ow+1SxEcvEzJH6L91QVVyrpFpggSGoJVP7MZczB3idVYSH2/JoRG8t/PhbEc
         9oEBjL+eNN6AgKZP4Sm21WRQwXTjOpJMv3Ith9YqeK990T/yoiQ3yMAqFtRco1baOUL7
         C0tzXvnWJnPUlqbkAgxHGDjbr1FeMkp0jeO7r7cgywPOloHQkqKvnvi9sNlwR0xNI4p1
         S/ZHjXTzp53ALPtyZQxliCqaFdLwGiPecmI6wJYYnYHpCYXGAVKkiZz+z1HKPnynGRBU
         TKZc8bfRdpSLAJbjrWmntvXbo+KBW6QTHy3R3EeJffsHFfs3E01UqKdxLb448hn/0X1F
         lDPQ==
X-Gm-Message-State: AOAM530/wHUhYgSRjX8OYUbfPqZ4vLMhwSHrXx/gSm61USFamrEGG+Th
        1/ejnU+cTvz9PDtW7heQ2A+lbw==
X-Google-Smtp-Source: ABdhPJyNARFVBRl+jDTfaivI5fepF82mtnvJqXbiOe6o9QqAg7hj2A92XMi73QiaGIE5tCKS/5vE1w==
X-Received: by 2002:a05:651c:383:: with SMTP id e3mr1194265ljp.220.1623310466669;
        Thu, 10 Jun 2021 00:34:26 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id 15sm244384ljr.25.2021.06.10.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:34:26 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:34:24 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
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
Message-ID: <20210610073424.GB2753553@jade>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
 <20210609002326.210024-6-tyhicks@linux.microsoft.com>
 <CAFA6WYOZC0iHzZm6pOxz31eW_=8g2wyJdm4wiOGKggO6-a9MdA@mail.gmail.com>
 <20210609054621.GB4910@sequoia>
 <CAFA6WYOYt2vcQ4ng=Nwu2R7d6=R=DGXQKpQ-+UiENerEtQRKWg@mail.gmail.com>
 <20210609121533.GA2267052@jade>
 <20210609134225.GC4910@sequoia>
 <20210609135104.GD4910@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210609135104.GD4910@sequoia>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 09, 2021 at 08:51:04AM -0500, Tyler Hicks wrote:
[snip]
> > > I've just posted "[PATCH 0/7] tee: shared memory updates",
> > > https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander@linaro.org/
> > > 
> > > Where tee_shm_alloc() is replaced by among other functions
> > > tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
> > > problem with TEE_SHM_DMA_BUF.
> > 
> > Thanks! At first glance, that series would take care of the last three
> > patches in my kexec/kdump series.
> 
> Correction: Your series would not completely take care of the last three
> patches in my kexec/kdump series because your series doesn't implement
> the .shutdown() hook for tee_bnxt_fw.
> 
> Does it make sense to take my series first and then rebase your series
> on top of it? That would allow my fixes to flow back to stable, then
> your changes would greatly clean up the implementation in future
> releases.

Yes, we could try that. I'd like to see tee_shm_alloc_kernel_buf() being
used instead of tee_shm_alloc() in ftpm_tee_probe() and
tee_bnxt_fw_probe(). So it would be great if you could include "tee: add
tee_shm_alloc_kernel_buf()" in your patch set.

My patch set would then shrink a bit. By the way, thanks for reviewing
it.

Cheers,
Jens
