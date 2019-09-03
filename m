Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68270A72CF
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfICSwf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 14:52:35 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40436 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfICSwf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 14:52:35 -0400
Received: by mail-yw1-f65.google.com with SMTP id k200so1960468ywa.7;
        Tue, 03 Sep 2019 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvN3tEABI8j9RhzV3JG9hjBCQ1Sc1MREYVujeWztLHA=;
        b=ZUvKv9wfq5zCoQ0l1Cj5oVdGMp9YSolF6Gaa8vf2aKoid3Ple2w4pNYT05ZLK9U0mp
         BN2Vgf55QYXZd42VV/YGJ1BSqMLbiOIDsJZK5yQJFXZeIGZROQ+fXEA2D0kPEe1Ii7x2
         AynRTRqaMJXSupZTHDs87FPG1yRQqZUbgVuv7mz1g3jHwFUTYEaJl+bWrhIPBt8MWzG9
         MvsyDSvpvYyD1BwhIuLBuPy3dml5k78qopmwxfdDkk5mn34tN4PQsfbPVvqeLLk7V/Re
         tFfklfr8Ow2rJE6BmmNnJ4Pzi87blDptCs2CuJQTMoekXxfeNh9p6PdOYHSzpPjn5OIM
         TX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvN3tEABI8j9RhzV3JG9hjBCQ1Sc1MREYVujeWztLHA=;
        b=Dv3j4gwfh0Isp9Xk5mawkwAMu1IWrrjYZ9S4Ja8tR8viKioiIOAi/byljafBVj+sw0
         vbaU0YiH7ELsmwUjiR8jx2Icb4yPB6ryjIntP/yMXqWOM3sVdJA4FKXKiHVwJJXkg49j
         UBV2GpNgvGY0B3d0XrO97yAUOuMGagbiBDo0fNUMHnUMfZzxLYd+QdgDQ0Jvi0WuTKoG
         TrjTWV8mVveItl9mJeH3FF+18fHVbx0P7KkaRPyheEw9aMCeQFrFcd/7RMG0RniUBJ5u
         ccu9+w6aqQAlfQI8lrKU3HOtaJhC3HhdG+ks75vc0PY2HMKGtsHPaA71MUIKrlAwAxlI
         s4Dg==
X-Gm-Message-State: APjAAAWF0T/PlE0sPY5W0YXC/TUJLCIPlyCIUj3joT1CLgh8FrfGoEfx
        AGZ9+nODMHB7Dd56x47GC35yD2EO0mf7BooeXGU=
X-Google-Smtp-Source: APXvYqxMjCISiR1Fyudln+rFJnaD4DlR1o7fJ/dFxxPiq2eryQQdPtkgJt+pQOZ/hqR7ZI10OS2aYRFMfPeXgryy4GU=
X-Received: by 2002:a81:9108:: with SMTP id i8mr25633727ywg.346.1567536754195;
 Tue, 03 Sep 2019 11:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190830095639.4562-1-kkamagui@gmail.com> <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca> <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcRPg9-9MXiLH7AfJO6P1k25CSwJrSiuUwzFLwN5Ynr0DQ@mail.gmail.com> <3f3ce42707f09eded801ff8543be6aee6ef35cf8.camel@linux.intel.com>
In-Reply-To: <3f3ce42707f09eded801ff8543be6aee6ef35cf8.camel@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Wed, 4 Sep 2019 03:52:20 +0900
Message-ID: <CAHjaAcSftPfPNEHFco9Y609r+s=z8cy8Nnq-A368JgjQSEmJkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>
Cc:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Tue, 2019-09-03 at 18:56 +0900, Seunghun Han wrote:
> > Thank you for your notification. I am sorry. I missed it and
> > misunderstood Jarkko's idea. So, I would like to invite Matthew
> > Garrett to this thread and attach my opinion on that. The problem is
> > that command and response buffers are in ACPI NVS area. ACPI NVS area
> > is saved and restored by drivers/acpi/nvs.c during hibernation, so
> > command and response buffers in ACPI NVS are also handled by nvs.c
> > file. However, TPM CRB driver uses the buffers to control a TPM
> > device, therefore, something may break.
> >
> > I agree on that point. To remove uncertainty and find the solution,
> > I read the threads we discussed and did research about two points, 1)
> > the race condition and 2) the unexpected behavior of the TPM device.
> >
> > 1) The race condition concern comes from unknowing buffer access order
> > while hibernation.
> > If nvs.c and TPM CRB driver access the buffers concurrently, the race
> > condition occurs. Then, we can't know the contents of the buffers
> > deterministically, and it may occur the failure of TPM device.
> > However, hibernation_snapshot() function calls dpm_suspend() and
> > suspend_nvs_save() in order when the system enters into hibernation.
> > It also calls suspend_nvs_restore() and dpm_resume() in order when the
> > system exits from hibernation. So, no race condition occurs while
> > hibernation, and we always guarantee the contents of buffers as we
> > expect.
> >
> > 2) The unexpected behavior of the TPM device.
> > If nvs.c saves and restores the contents of the TPM CRB buffers while
> > hibernation, it may occur the unexpected behavior of the TPM device
> > because the buffers are used to control the TPM device. When the
> > system entered into hibernation, suspend_nvs_save() saved the command
> > and response buffers, and they had the last command and response data.
> > After exiting from hibernation, suspend_nvs_restore() restored the
> > last command and response data into the buffers and nothing happened.
> > I realized that they were just buffers. If we want to send a command
> > to the TPM device, we have to set the CRB_START_INVOKE bit to a
> > control_start register of a control area. The control area was not in
> > the ACPI NVS area, so it was not affected by nvs.c file. We can
> > guarantee the behavior of the TPM device.
> >
> > Because of these two reasons, I agreed on Jarkko's idea in
> > https://lkml.org/lkml/2019/8/29/962 . It seems that removing or
> > changing regions described in the ACPI table is not natural after
> > setup. In my view, saving and restoring buffers was OK like other NVS
> > areas were expected because the buffers were in ACPI NVS area.
> >
> > So, I made and sent this patch series. I would like to solve this
> > AMD's fTPM problem because I have been doing research on TPM and this
> > problem is critical for me (as you know fTPM doesn't work). If you
> > have any other concern or advice on the patch I made, please let me
> > know.
>
> Please take time to edit your responses. Nobody will read that properly
> because it is way too exhausting. A long prose only indicates unclear
> thoughts in the end. If you know what you are doing, you can put things
> into nutshell only in few senteces.
>
> /Jarkko
>

I'm sorry about that. I would like to invite Matthew Garrett and
discuss ACPI NVS and command/response buffer mapping again. So, I want
to summarize my test result and explain my opinion on that. I think
the data and result are important to make a decision clearly.
According to my test results, it seems that intersects between ACPI
NVS and command/response buffers will not make a problem.

Additionally, according to Dave's test results, this patch series can
cover not only an intersection with ACPI NVS area but also an
intersection with the reserved area. Here is the link,
https://lkml.org/lkml/2019/9/3/481 . Considering these results, my
patch series can solve AMD's fTPM problems.

Matthew,
what do you think about test results and this patch? In my view, if
the command/response buffers are in ACPI NVS area, saving and
restoring the buffers are ok and couldn't break anything.
I would like to get some feedback from you.

Seunghun
