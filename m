Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BCC1E1E6A
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbgEZJW5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388634AbgEZJWx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 05:22:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9FBC03E97E
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 02:22:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so23604789ljo.5
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2020 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHtMUTjIpKGUVpTGb6eXqa1GBMsHXSe04tQOYQTSzwk=;
        b=oEtC9JqLK6JUL+a09fup+E3zmswBCXWI3NHfhAeye40YMT/bZyDqHtuU4TEwB9FFaA
         PQyMqRt1usaUnx4ouAZuqxXbnvHXqIwQQQPVDsiNGWmZMtk4/0BiERce+XhIUzzEIG9f
         7YLBwF5B3zkUWkw0rrxo1FMolJJWsHiFs581btuKT1U/A1xmOuhWyS/10UwH/J8G5VrU
         lUN+3WznXNQ1n7yqOWXLAfW6fjDVbaBVuSMErOAUqdmMV3ykZ12gG3B5FLQ1VSVGngjQ
         WLz1ev/VKjH5X8ibPWTK8CEfNUv8+zvKU/GaOOYg9qOZxC+vlFi0QQ36SuGx+ZrpOifC
         njFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHtMUTjIpKGUVpTGb6eXqa1GBMsHXSe04tQOYQTSzwk=;
        b=gRx4g655uBVyQ0UuUXakWZbfxuYAtJrT0KiM7S4NylT48NWL2CKn+0mUr3BBW7Qc/A
         LBZh6r/mKB2fAOKhJNkA2gJ04dwACvUz61/wdDZoILkJcyKRykJoXLfZECVqw2cUqpN1
         iRYAk89k7eX42uJsgPA+Y0HG0Q7iaoGWgkqEqFjEMr6XPkuqHc6Fdk43gZhAa3Ai3A/6
         v9a4RRmtRrUGd9Yw8reqAEkJq3jgGjITRVXONlI5L09c+LIyfsjDBWBKWOcMCtraIoAC
         B0VFAnrlDhRIRR6rz5SIkuf/DRV0iwueOG79zDry6ujYgLE2+Rfd0LwgvxZuEj2IjxlO
         zmrw==
X-Gm-Message-State: AOAM530wKZhBND+UtcgF/DvKjTjvMI3Cz/W306yoc/zPRFOmgy6hBiAK
        NKqRIydeoE1E1Dl6HXL/hmoMBYiMp1cq0l140gL6+g==
X-Google-Smtp-Source: ABdhPJym48nO1qx6Xam2hpUVXTrGYHOl37dIdmsOtBDTKVNSlX2HngDefNjA8Df4YLq2vZMNOewwm8FZbTbAdvC9Nb4=
X-Received: by 2002:a2e:1451:: with SMTP id 17mr188903lju.30.1590484971486;
 Tue, 26 May 2020 02:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org> <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
 <20200522200346.GB150221@linux.intel.com> <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
In-Reply-To: <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 26 May 2020 14:52:39 +0530
Message-ID: <CAFA6WYMe8xOPwsBuxoKb0e4kAhXfTjwYGVd7fNUR07hgQ_9TJg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+ Thiru (original author), Ilias, Joakim

Hi Jarkko,

On Mon, 25 May 2020 at 12:20, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Fri, 22 May 2020 at 23:03, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, May 22, 2020 at 10:29:44PM +0300, Maxim Uvarov wrote:
> > > On Fri, 22 May 2020 at 20:15, Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Thu, May 21, 2020 at 09:47:43AM +0300, Maxim Uvarov wrote:
> > > > > Register driver on TEE bus. module tee registers bus,
> > > >
> > > > "on the TEE bus"
> > > >
> > > > "The module tee"
> > > >
> > > > > and module optee calls optee_enumerate_devices() to scan
> > > > > all devices on the bus. Trusted Application for this driver
> > > >
> > > > Looking at drivers/tee, it shows that tee and optee are in fact the same
> > > > module as opposed to what your commit message says.
> > > >
> > >
> > > In the current kernel it's 2 different modules.
> > >
> > > > > can be Early TA's (can be compiled into optee-os). In that
> > > > > case it will be on OPTEE bus before linux booting. Also
> > > > > optee-suplicant application is needed to be loaded between
> > > > > OPTEE module and ftpm module to maintain functionality
> > > > > for fTPM driver.
> > > >
> > > > Why is this needed and why things worked before having this?

If you remembered earlier discussions when this driver was added,
tee-supplicant dependency concern was raised at that time too. But the
response from author [1] was to use a workaround in firmware to
overcome the initialization issue of fTPM driver.

Basically while using upstream OP-TEE, fTPM NV RAM is implemented via
RPMB secure storage [2]. So any fTPM operation dependent on NV RAM may
fail without access to RPMB secure storage.

And during kernel boot, RPMB access isn't available (there were some
prior efforts [3] around this but unfortunately didn't land in
upstream) due to which we need to rely on user mode tee-supplicant for
corresponding access.

So we should only register fTPM device when the underlying
infrastructure is working, which is something this patch-set addresses
via registering fTPM device only when the tee-supplicant is up and
running.

[1] https://lkml.org/lkml/2019/7/4/779
[2] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#rpmb-secure-storage
[3] https://lwn.net/Articles/682276/

> > > >
> > >
> > > Before these changes user space has to drive boot sequence. I.e.  tee
> > > and optee modules loads, then application tee-supplicant has to start
> > > and only then module ftpm can be loaded. The reason for that is
> > > storage services are implemented in userspace and driver needs them.
> >
> > Is the TPM implementation uploaded to TEE from user space and or what
> > storage are we talking about? Not sure how these storage services
> > connect to the TPM.

Please see my response above.

-Sumit

> >
> > /Jarkko
>
> Jakko,
> tee-supplicant application provides state machine over callbacks with
> RPC messages.
> https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
> It also allocates shm. Without running tee-supplicant
> tee_client_open_session() will fail.
> optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
> Optee team wanted to remove some dependencies from tee-supplicant with
> moving code
> to the kernel. But for now I think that should be out of the scope of
> current patches due to
> they fix driver initialization on tee bus without breaking current
> functionality.
>
> Maxim.
