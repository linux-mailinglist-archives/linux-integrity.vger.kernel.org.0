Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0649D3CD2C4
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Jul 2021 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhGSKJY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jul 2021 06:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbhGSKJX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jul 2021 06:09:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F5C061762
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jul 2021 02:58:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l7so21439378wrv.7
        for <linux-integrity@vger.kernel.org>; Mon, 19 Jul 2021 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izuO6gvI65i5N9voqwWRAxIjJnPgY0dtLzVTkR8nBPo=;
        b=k6FvzoDAJSW94zB39kfmFHDISI3yFTMUzn1gC61Vx6eoZyCD6lYdg1wA9VAdTUifZT
         CaTyfzOWFktyxbYqVOfyWBbqdlSR+JtngddRYbSNz2/nMqfNEY0my6w93kOIwwTrt3UY
         /trq4vQrsfCpKxbM9uTjxbp5UpdgKPdg2pBENE1o2WfluC0kfHVKlrdMZKHtxpC46B8+
         C8IQKJL5iQIL8V/jdUf+bRjXSZs0n+C1W2iBe/byxnB/MzDJwTlU/rWJR+jqOZ0AU7yv
         nyaUrtXPCPcr3JYHaxkSZKrLUBwWVqRrnNhxJAuOBgehnCcKVu4jfuZAoJ6NZHmP7aO0
         2P+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izuO6gvI65i5N9voqwWRAxIjJnPgY0dtLzVTkR8nBPo=;
        b=ArQQ+EsUCm6ExbuSqDG34JbNpdRc9f8lufeDZTX9l/pSSxfppA+6D5hSS1zsEcnRly
         l+CIP4nmfrcpIeHWLns7izq0rWKHOSqUk+mIR4a74i1d0XpBw8jylFDB1mI+MhPfsb4b
         +oFEfxBW6bDlaNUDc8xitQ7dhgRLTLmA+wUBT66N2mTDtGsygOrH8ywFs6PX9DkzCgaz
         3RitGMgQnHO4LSk4cIo+zAUFWAdP7QzMqR9WRBdVCbp1izCA/9lIC1dBiECkQKvHrCmk
         lx5zLqiCUKoqanXlbcx+hK8Lhr9dQhJYiyRZBdjWdqhSd/iOE/ngMf6cUjVHVBi80IBr
         7rpw==
X-Gm-Message-State: AOAM533QCsQmI9TR0t7oLJaM9D1r5wWQzuj7VlwjOBJ8vlKLEEltZ1Jk
        p8QLzxHXwwAkOYz3MX72LRPBbPMUWii7o1WhR9VSKQ==
X-Google-Smtp-Source: ABdhPJzUf1fsMNWHyhn42FHVh+pZyHssv36+V+/tCuvZ0KcZxOo+8M2I8EX37UE2nFduQe5u0Lrwyhm610xT5QNXuiw=
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr28517634wrs.7.1626691801564;
 Mon, 19 Jul 2021 03:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210716022332.GC3232@sequoia> <CAHLZf_t5U1bh1H8sULbJz7xrZ-r3Dcmxuw9MMmG2fehS3C72uQ@mail.gmail.com>
In-Reply-To: <CAHLZf_t5U1bh1H8sULbJz7xrZ-r3Dcmxuw9MMmG2fehS3C72uQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 19 Jul 2021 12:49:51 +0200
Message-ID: <CAHUa44EetPuA_5+UQLW-c=-_OApiRoiq+YjeFs6TRPj6=AJfHw@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
To:     Vikas Gupta <vikas.gupta@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta <vikas.gupta@broadcom.com> wrote:
>
> Hi Allen/Tyler,
>  The patch looks good to me.

Thanks.

Rafal, is it OK if I include this patch together with the rest of the
patches in this patch set in a pull request to arm-soc?

Thanks,
Jens

>
> Thanks,
> Vikas
>
>>
>> > From: Allen Pais <apais@linux.microsoft.com>
>> >
>> > Implement a .shutdown hook that will be called during a kexec operation
>> > so that the TEE shared memory, session, and context that were set up
>> > during .probe can be properly freed/closed.
>> >
>> > Additionally, don't use dma-buf backed shared memory for the
>> > fw_shm_pool. dma-buf backed shared memory cannot be reliably freed and
>> > unregistered during a kexec operation even when tee_shm_free() is called
>> > on the shm from a .shutdown hook. The problem occurs because
>> > dma_buf_put() calls fput() which then uses task_work_add(), with the
>> > TWA_RESUME parameter, to queue tee_shm_release() to be called before the
>> > current task returns to user mode. However, the current task never
>> > returns to user mode before the kexec completes so the memory is never
>> > freed nor unregistered.
>> >
>> > Use tee_shm_alloc_kernel_buf() to avoid dma-buf backed shared memory
>> > allocation so that tee_shm_free() can directly call tee_shm_release().
>> > This will ensure that the shm can be freed and unregistered during a
>> > kexec operation.
>> >
>> > Fixes: 246880958ac9 ("firmware: broadcom: add OP-TEE based BNXT f/w manager")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>> > Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> > ---
>> >  drivers/firmware/broadcom/tee_bnxt_fw.c | 14 +++++++++++---
>> >  1 file changed, 11 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
>> > index ed10da5313e8..a5bf4c3f6dc7 100644
>> > --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
>> > +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
>> > @@ -212,10 +212,9 @@ static int tee_bnxt_fw_probe(struct device *dev)
>> >
>> >       pvt_data.dev = dev;
>> >
>> > -     fw_shm_pool = tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
>> > -                                 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
>> > +     fw_shm_pool = tee_shm_alloc_kernel_buf(pvt_data.ctx, MAX_SHM_MEM_SZ);
>> >       if (IS_ERR(fw_shm_pool)) {
>> > -             dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
>> > +             dev_err(pvt_data.dev, "tee_shm_alloc_kernel_buf failed\n");
>> >               err = PTR_ERR(fw_shm_pool);
>> >               goto out_sess;
>> >       }
>> > @@ -242,6 +241,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
>> >       return 0;
>> >  }
>> >
>> > +static void tee_bnxt_fw_shutdown(struct device *dev)
>> > +{
>> > +     tee_shm_free(pvt_data.fw_shm_pool);
>> > +     tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
>> > +     tee_client_close_context(pvt_data.ctx);
>> > +     pvt_data.ctx = NULL;
>> > +}
>> > +
>> >  static const struct tee_client_device_id tee_bnxt_fw_id_table[] = {
>> >       {UUID_INIT(0x6272636D, 0x2019, 0x0716,
>> >                   0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
>> > @@ -257,6 +264,7 @@ static struct tee_client_driver tee_bnxt_fw_driver = {
>> >               .bus            = &tee_bus_type,
>> >               .probe          = tee_bnxt_fw_probe,
>> >               .remove         = tee_bnxt_fw_remove,
>> > +             .shutdown       = tee_bnxt_fw_shutdown,
>> >       },
>> >  };
>> >
>> > --
>> > 2.25.1
>> >
>>
>> ----- End forwarded message -----
