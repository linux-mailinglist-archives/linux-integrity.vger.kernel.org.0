Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0F51E755D
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2020 07:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE2F2v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 May 2020 01:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2F2u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 May 2020 01:28:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA7AC08C5C6
        for <linux-integrity@vger.kernel.org>; Thu, 28 May 2020 22:28:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a25so1044735ljp.3
        for <linux-integrity@vger.kernel.org>; Thu, 28 May 2020 22:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtB2LFCwGlcL1VaxzIrehfNf8TpYkOn5N85lj//StkI=;
        b=tfdUS3VW/pKmUDBp2mr5coRHksBW07+ShUkPGrNp5uPuYE8H1H/xc8uNd4p8tvycPE
         bIydIJWamMeEoiCsJ5Q8qNS0xC+M8kKtaqWoMI4gzV+x9w9fIIPFkS/VvEB9rCj/SBMq
         1KVHWLWqc71LcusNdMXyr+XwiXcs4S+RdsvIGl4i+9oIEvL9wsLiJuPC/rS4upckvWAy
         pI/HDpJpiO2qdojnN7208WImc3NKD1tgKWWI8lIftxFMu1BcrYlDWrQ6KRvtP43xO5jz
         tn6a0bz7zI+guhFvX3YeP5icO6TIilBHLsnDeOSSPP/fUqNmOrDWSRCouZrFuBkqOj7U
         IQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtB2LFCwGlcL1VaxzIrehfNf8TpYkOn5N85lj//StkI=;
        b=XkGaVemkfToj3f9GuXN6uRhxX1nAeV0CzmM/cL1gzvxC/87Wqvl0uUeNR41S3Og6yw
         rZVTJTdLWPsRI0VpRDxEzGHztL9KnuBJAAtGrqy0kNn7A1bb0VXJzhZ9/jjV+yPgZgYR
         bhQAosbkFt9TIlTq6skMuRsNNRFBoMSc6q6oFJesqKHqY3rI5/gRafN+S8lhGnxejjp4
         ysXNn07lJY0g8UEwp/5Zyy8s116MWrUg5jhx3CgdipWcisRJTSom3sYOOiLUizYwz0dV
         hUQEAzHsz0DpPZIMlT6SxE9GTxsxkhZ8fWDRWX/mGe+dQQ54GVVCcng+GVDh4LpHywEp
         /UbQ==
X-Gm-Message-State: AOAM530aGn4fnHVySDoTnghBAheCKY3TffEd2Eu6fI0HBoTl/i8DVLqc
        geTxQljcg338bDFdKgeO3Q+oP5Eo17+zUJjk8nsf/eWZ
X-Google-Smtp-Source: ABdhPJx9ZUCfMHdnNeGqUsyohC4SXQK+0g6QaR7+1+b7DZGWVE4x65Qhuw6/B+CXOsfNRdpEg/2e3VAOb05D2w+0S/U=
X-Received: by 2002:a2e:8006:: with SMTP id j6mr2931003ljg.256.1590730127309;
 Thu, 28 May 2020 22:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org> <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
 <20200522200346.GB150221@linux.intel.com> <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
 <81c59da1dc2a255c58e7e338f30285e68b4664d6.camel@linux.intel.com>
 <CAD8XO3a5Xqw3oDAn=VH25Fb0j-_GSripEgQjwurhqGQRW_mq5g@mail.gmail.com> <20200528101150.GA156014@jade>
In-Reply-To: <20200528101150.GA156014@jade>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 29 May 2020 10:58:35 +0530
Message-ID: <CAFA6WYOJ1-Hy38hg3ALU3Uzjh8J4Mo8H3k1pFz3G_7h-N=+W9w@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 28 May 2020 at 15:41, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Thu, May 28, 2020 at 11:08:18AM +0300, Maxim Uvarov wrote:
> > On Wed, 27 May 2020 at 22:42, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Mon, 2020-05-25 at 09:50 +0300, Maxim Uvarov wrote:
> > > > Jakko,
> > > > tee-supplicant application provides state machine over callbacks with
> > > > RPC messages.
> > > > https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
> > > > It also allocates shm. Without running tee-supplicant
> > > > tee_client_open_session() will fail.
> > > > optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
> > > > Optee team wanted to remove some dependencies from tee-supplicant with
> > > > moving code
> > > > to the kernel. But for now I think that should be out of the scope of
> > > > current patches due to
> > > > they fix driver initialization on tee bus without breaking current
> > > > functionality.
> > >
> > > So what is the role in high-level for tee-supplicant? Why does it
> > > exist? No time to dive into code unfortunately.
> > >
> >
> > Original implementation for tee-supplicant does several things:
> > 1. allocate shm
> > 2. load ta from user space (fs file)
> > 3. emulate rpmb
> > 4. also there are some ftrace and socket functions which I did not use.
> >
> > As I I understand, current implementation uses tee-supplicant and it's
> > library as
> > API from user land to Trusted OS.
> >
> > Some docs can be found here:
> > https://optee.readthedocs.io/en/latest/architecture/index.html
> >
> >
> >
> > > These kernel commits do not explain in simple terms enough how all
> > > of these entities connect with each other, if you don't have that
> > > understanding beforehand.
> > >
> >
> > Yes, that is true. But I think it's something new and good docs will
> > be some time later.
>
> There's already some in Documentation/tee.txt, but it will get outdated
> if we don't update it when we architectural changes like this. It's a
> pity we missed updating it with the introduction of the bus. It seems a
> good time to do it now so it easier to follow what's done.

Agree, let me try to update documentation for TEE bus. Will share it
as a separate patch.

-Sumit

>
> Cheers,
> Jens
>
> >
> > > /Jarkko
> > >
> >
> > Regards,
> > Maxim.
