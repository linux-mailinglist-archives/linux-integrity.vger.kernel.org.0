Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1181E5A64
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 10:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE1IIa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgE1II3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 04:08:29 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC143C05BD1E
        for <linux-integrity@vger.kernel.org>; Thu, 28 May 2020 01:08:29 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id b131so11174264ybg.13
        for <linux-integrity@vger.kernel.org>; Thu, 28 May 2020 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sgr4FWL5XcxGztFSaEzO/2WTVUopl2JavBDY6LgOg2c=;
        b=vSYtPY90mTL/I0S2v5moz9urniRI1jiWbplaYPKse/12CdTp7n9h/BAactoqWym/R2
         TAR/suxU51W2PpSq3nzn1NwmiUS52W81E6jvYS5g7NHqV7D/DB5mimpPgyN7AQR7AXE4
         NTgHcDfMfBOq8hggnjVP6x1CMFUPQ+vKo5JU1BkVCDMG4TqpYfjZxUwJpb2F3soXZp4N
         F70gHvzSE7Q5XpQeRIDU2IeCnsCh9PvSsr2dkP4vB9/JFuVnk2HyGBPMx6Kk6025kalj
         0OGlxjG9yTCk4b7qZIcaypK+/C0W4VRNxgI7zY/F+O7P8zL2gZQWtK+KtHUE/AdJAeCC
         x8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sgr4FWL5XcxGztFSaEzO/2WTVUopl2JavBDY6LgOg2c=;
        b=MsEkt02iML5bNKI5cQK+HLkGz2J990dlOnWAnd7Nkkd/a0+1KQ68kBrNMOu8SVR9Ac
         GhocJdFfA/dVBxDxgF4ZnE59GCCDkVHdKBpPfDrLUJ/SDxjxtp0xfpahLsWAg2Jl5PoE
         jQTF85QGG1whLJrDGUF/PT5arcRMqem9jnYO5CN1viiiLnGuSmHR+k5vVzW5N3jMcKPh
         15E3aooz1wQwzQVHYufSu501NO09QSb6TJolTcjpo4XTPLG0r55KC157b2DPIZPJ+eWD
         xQmiIvfQfc42mDEWFbL1WfKZjFYVthpJPoSt7XGXJbSPcGWOb8ewNb5ONSv5fe/src+R
         QoGQ==
X-Gm-Message-State: AOAM532+atxvfbViOQrUoR17kqiVFyo3dOSs6r8eqskH7rbYaO2qwXs+
        LwAL1zfy/yYAheZNvwVl1kowQU0NGqpJPKM+/hKKqg==
X-Google-Smtp-Source: ABdhPJzEIkU4sEoMsH6HbMA0rKdN14Pnda9RFsx12btvyCWWyy9/uQxg3/VavyE9M24Lx8vJHM15P22rZn3xUwzdfFw=
X-Received: by 2002:a25:8202:: with SMTP id q2mr3238918ybk.243.1590653308906;
 Thu, 28 May 2020 01:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org> <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
 <20200522200346.GB150221@linux.intel.com> <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
 <81c59da1dc2a255c58e7e338f30285e68b4664d6.camel@linux.intel.com>
In-Reply-To: <81c59da1dc2a255c58e7e338f30285e68b4664d6.camel@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 28 May 2020 11:08:18 +0300
Message-ID: <CAD8XO3a5Xqw3oDAn=VH25Fb0j-_GSripEgQjwurhqGQRW_mq5g@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 27 May 2020 at 22:42, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, 2020-05-25 at 09:50 +0300, Maxim Uvarov wrote:
> > Jakko,
> > tee-supplicant application provides state machine over callbacks with
> > RPC messages.
> > https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
> > It also allocates shm. Without running tee-supplicant
> > tee_client_open_session() will fail.
> > optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
> > Optee team wanted to remove some dependencies from tee-supplicant with
> > moving code
> > to the kernel. But for now I think that should be out of the scope of
> > current patches due to
> > they fix driver initialization on tee bus without breaking current
> > functionality.
>
> So what is the role in high-level for tee-supplicant? Why does it
> exist? No time to dive into code unfortunately.
>

Original implementation for tee-supplicant does several things:
1. allocate shm
2. load ta from user space (fs file)
3. emulate rpmb
4. also there are some ftrace and socket functions which I did not use.

As I I understand, current implementation uses tee-supplicant and it's
library as
API from user land to Trusted OS.

Some docs can be found here:
https://optee.readthedocs.io/en/latest/architecture/index.html



> These kernel commits do not explain in simple terms enough how all
> of these entities connect with each other, if you don't have that
> understanding beforehand.
>

Yes, that is true. But I think it's something new and good docs will
be some time later.

> /Jarkko
>

Regards,
Maxim.
