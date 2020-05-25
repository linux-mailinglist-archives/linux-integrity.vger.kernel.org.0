Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AED1E0747
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 08:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbgEYGu6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 02:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388487AbgEYGu6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 02:50:58 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5320C061A0E
        for <linux-integrity@vger.kernel.org>; Sun, 24 May 2020 23:50:57 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id u73so5463335ybi.2
        for <linux-integrity@vger.kernel.org>; Sun, 24 May 2020 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLMRtJrXxF/KIRzWVXOQPJWRHqdMyNwc6DMD7m4ZeeQ=;
        b=wOotrqX2ldR8fNeNoc1dIZNlAxcy18iSOAwS6u2D9eXMPH37ZAuhxXV2tTOg5IFD4Q
         qwuJamEkdNglQRvP3aSxwpCQTgTtrua0T59Sd+eAKqooq0VD2DAQuQVA6Ty4osplIkMA
         FtXb1sIUrxczDyWkP04izFLZtDouDF2K/V5xuRpF7p9GsiZXPLzvDRQR8lBTCJrgAam4
         Zojqid9RoiGr3iVMLBghA6fGKqHc/YF2Kys4IHLNMVmxM9HJuDruSO702XgvAtiLxrZG
         ullbczLDSH3cgnxrHjcp93f64zeAZpXnlXAVbWARUSF/UowJ2wbZ3HpuluuQ5RVOy+X+
         UZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLMRtJrXxF/KIRzWVXOQPJWRHqdMyNwc6DMD7m4ZeeQ=;
        b=GFLR734BAfHEngvdmh+NWn2ADlZ031O6Kuj94Ci8+spTYmnhxg20oOuFT1ORD6blZc
         AiRC5t87fWnO3PCudG3DXBestkUx2MhuGfycINhiYFrLw329s7HzsU1055WcGWueWfOg
         jd146GI26H0x6+toibxvCcXdu/uWMpYU1q6nOfyB+5GKoHsSq2OTkvqOmt+0j6aAXhUw
         f9a9WpjJYU8r2LFcsjGwyGEjmnrLJHz+Rcbl74H/YRvFZCzWBatodCuht7MsQPnbsMtZ
         D6tU/x4MeUx/9oomiodg3NE63NnAKuVhou+2tXgrhbN0+IiX7eqXOlD1J/E2J02ZH+3M
         YwVg==
X-Gm-Message-State: AOAM530eVX7qhB/8uWwT6fKC8uMbmKJ0yq7wVv1qK8abRVdWcnQzGRpB
        7jvSSiZHPcFpCbGsJ4IotQHiSdcQ+7FSbN80wHK7/g==
X-Google-Smtp-Source: ABdhPJziehBSD54NDEg4MSbVVy3e03fQg4Toq3RQagDdfqXUV6sEi4K6OcxRE+R0+V7W4gOsR2y9ZTeCLDEntZFpMaA=
X-Received: by 2002:a25:209:: with SMTP id 9mr29888792ybc.153.1590389457134;
 Sun, 24 May 2020 23:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org> <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com> <20200522200346.GB150221@linux.intel.com>
In-Reply-To: <20200522200346.GB150221@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 25 May 2020 09:50:46 +0300
Message-ID: <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 22 May 2020 at 23:03, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, May 22, 2020 at 10:29:44PM +0300, Maxim Uvarov wrote:
> > On Fri, 22 May 2020 at 20:15, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Thu, May 21, 2020 at 09:47:43AM +0300, Maxim Uvarov wrote:
> > > > Register driver on TEE bus. module tee registers bus,
> > >
> > > "on the TEE bus"
> > >
> > > "The module tee"
> > >
> > > > and module optee calls optee_enumerate_devices() to scan
> > > > all devices on the bus. Trusted Application for this driver
> > >
> > > Looking at drivers/tee, it shows that tee and optee are in fact the same
> > > module as opposed to what your commit message says.
> > >
> >
> > In the current kernel it's 2 different modules.
> >
> > > > can be Early TA's (can be compiled into optee-os). In that
> > > > case it will be on OPTEE bus before linux booting. Also
> > > > optee-suplicant application is needed to be loaded between
> > > > OPTEE module and ftpm module to maintain functionality
> > > > for fTPM driver.
> > >
> > > Why is this needed and why things worked before having this?
> > >
> >
> > Before these changes user space has to drive boot sequence. I.e.  tee
> > and optee modules loads, then application tee-supplicant has to start
> > and only then module ftpm can be loaded. The reason for that is
> > storage services are implemented in userspace and driver needs them.
>
> Is the TPM implementation uploaded to TEE from user space and or what
> storage are we talking about? Not sure how these storage services
> connect to the TPM.
>
> /Jarkko

Jakko,
tee-supplicant application provides state machine over callbacks with
RPC messages.
https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
It also allocates shm. Without running tee-supplicant
tee_client_open_session() will fail.
optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
Optee team wanted to remove some dependencies from tee-supplicant with
moving code
to the kernel. But for now I think that should be out of the scope of
current patches due to
they fix driver initialization on tee bus without breaking current
functionality.

Maxim.
