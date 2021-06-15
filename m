Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7713A7779
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 09:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFOHCx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 03:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhFOHCw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 03:02:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF669C061767
        for <linux-integrity@vger.kernel.org>; Tue, 15 Jun 2021 00:00:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso961301wmh.4
        for <linux-integrity@vger.kernel.org>; Tue, 15 Jun 2021 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxV9YrfPTMckE68tXN+z29g+tg5T03Yl2qalXJXkNkc=;
        b=r1wXG2g3Ij7IpQjP3ce3rAGLFuR/t7fpjpPV3DAsvtb0rvkoXniW0jXUy+NFu5v6an
         x/aIbngSA6Xg7x/oLGbVkkYcRzXPDK5ehnrd9eM/25bUwjs8Y522tphG2C8cfXnne7cV
         xYpaXi3tIr/v9hFceGqOcf3cmqMGNeB5OhuSQPWArWyZo7OL3/WlWSn2Okuae5hbnq3V
         w6HUmWtV46Zm7eZnxeEHgBVovzkqzs24QKVAq3w7iUtVgpsCplS98uWkG/9iCS6Bhwf6
         2jTsZeaM3ZocTTRy2Qly0vGDBHFL/M+tjK+eo7swwiNa25dlYsPKVLTybPI84W9C1ghE
         ZCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxV9YrfPTMckE68tXN+z29g+tg5T03Yl2qalXJXkNkc=;
        b=ub01wYjlbk/LxefEoWQdvboGP8efqUBZeL12O0LDQZhcgX2vR3J5pg3IXcK/8gOrSE
         ZNWQby3VLQectK9PB0FYRepiPr2n6wRKgjxXbyfr+5cE6ySfUdllBQZ/ZtdrobWXLjGC
         nBDwcYq1R5UXsUGvCCGvHE8AE4lFHBtPUh8QBERB9kN1XmkfXz8NMFgWunKBoQD0ANbQ
         Db13S7gtLZzjHtH2ziBosISXpSL3/mbDL1GoXMCuQ7f9fWsrAOGN2blI0AgAQBJMrvz6
         CWtud+9d1av3Ww8CftyxOm+8Uwg0Bepbf/we8yIBbimi0XF0ifLBEEwA39EMkTbtl5Ys
         kI3w==
X-Gm-Message-State: AOAM532hyCOWUpXUi3u62tMPyKGup6OkA7YQOk68QXN9/+sfYc6wgc1i
        NhEFKbU90JxDOC72Pe2rNCVzBtcnXsXxsBis+3J/ug==
X-Google-Smtp-Source: ABdhPJywx870VvTJLcC/IUKQvu1pmDshczTbWjQNPyhg5UovPLLVsbpeCyE2WdcabCSWVbVPXbT8GqEPYMFv9vt2Oh4=
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr3401371wma.60.1623740447101;
 Tue, 15 Jun 2021 00:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210614223317.999867-1-tyhicks@linux.microsoft.com> <20210614223317.999867-5-tyhicks@linux.microsoft.com>
In-Reply-To: <20210614223317.999867-5-tyhicks@linux.microsoft.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 15 Jun 2021 09:00:36 +0200
Message-ID: <CAHUa44HeJu9_33H3V=ms5=Z4tKSgQ8=3nWqUDvvNgJvaUB4H=A@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] optee: Clear stale cache entries during initialization
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 15, 2021 at 12:33 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> The shm cache could contain invalid addresses if
> optee_disable_shm_cache() was not called from the .shutdown hook of the
> previous kernel before a kexec. These addresses could be unmapped or
> they could point to mapped but unintended locations in memory.
>
> Clear the shared memory cache, while being careful to not translate the
> addresses returned from OPTEE_SMC_DISABLE_SHM_CACHE, during driver
> initialization. Once all pre-cache shm objects are removed, proceed with
> enabling the cache so that we know that we can handle cached shm objects
> with confidence later in the .shutdown hook.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/call.c          | 36 ++++++++++++++++++++++++++++---
>  drivers/tee/optee/core.c          |  9 ++++++++
>  drivers/tee/optee/optee_private.h |  1 +
>  3 files changed, 43 insertions(+), 3 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
