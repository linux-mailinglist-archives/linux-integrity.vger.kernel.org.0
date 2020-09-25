Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C45278106
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 09:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgIYHBJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 03:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYHBI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 03:01:08 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8992221EB;
        Fri, 25 Sep 2020 07:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601017268;
        bh=aOUjjDgtVWkcQodJAgxOumrSwAyHIJQ5o0no1CvLCso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sXkdNhgR8BtkcwNFqSrytDMDRQf7rIwVzL9UuurNMUsy4vExrC6rA9+X2JMEcEHWk
         vRz7Up4PJD2acJ8rdo2mrNnTUpFgWPR2gEopMxEOlsU3FjEfNOIZGZIwgNEIMOTG7k
         CqGe2WeeaascagdB2X6giJFmqsioo0Sv1adSe1Us=
Received: by mail-oi1-f173.google.com with SMTP id v20so1789737oiv.3;
        Fri, 25 Sep 2020 00:01:07 -0700 (PDT)
X-Gm-Message-State: AOAM530jDjqfP+e26scvhxZz3dKPNRzSWeBj5CoDIGgCSjted4fa6lWf
        YPC1Xphz3d/YPzfnN81PdaK9PrDi4DOhU2E8r5Q=
X-Google-Smtp-Source: ABdhPJzTIcPgRg3N/EEZgSGid4+8+hR0XtJxMO/6Gi0/0/erclCg7R46ka+Ii25iZa5FMsvpMy/oOuQlBzSbt2qEO4s=
X-Received: by 2002:a54:4517:: with SMTP id l23mr780843oil.174.1601017267272;
 Fri, 25 Sep 2020 00:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200922094128.26245-1-ardb@kernel.org> <20200925055626.GC165011@linux.intel.com>
In-Reply-To: <20200925055626.GC165011@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Sep 2020 09:00:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
Message-ID: <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: of: avoid __va() translation for event log address
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 25 Sep 2020 at 07:56, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Sep 22, 2020 at 11:41:28AM +0200, Ard Biesheuvel wrote:
> > The TPM event log is provided to the OS by the firmware, by loading
> > it into an area in memory and passing the physical address via a node
> > in the device tree.
> >
> > Currently, we use __va() to access the memory via the kernel's linear
> > map: however, it is not guaranteed that the linear map covers this
> > particular address, as we may be running under HIGHMEM on a 32-bit
> > architecture, or running firmware that uses a memory type for the
> > event log that is omitted from the linear map (such as EfiReserved).
>
> Makes perfect sense to the level that I wonder if this should have a
> fixes tag and/or needs to be backported to the stable kernels?
>

AIUI, the code was written specifically for ppc64, which is a
non-highmem, non-EFI architecture. However, when we start reusing this
driver for ARM, this issue could pop up.

The code itself has been refactored a couple of times, so I think it
will require different versions of the patch for different generations
of stable kernels.

So perhaps just add Cc: <stable@vger.kernel.org>, and wait and see how
far back it applies cleanly?


> > So instead, use memremap(), which will reuse the linear mapping if
> > it is valid, or create another mapping otherwise.
> >
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/char/tpm/eventlog/of.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> > index a9ce66d09a75..9178547589a3 100644
> > --- a/drivers/char/tpm/eventlog/of.c
> > +++ b/drivers/char/tpm/eventlog/of.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <linux/slab.h>
> > +#include <linux/io.h>
> >  #include <linux/of.h>
> >  #include <linux/tpm_eventlog.h>
> >
> > @@ -25,6 +26,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
> >       struct tpm_bios_log *log;
> >       u32 size;
> >       u64 base;
> > +     void *p;
>
> I'd just use 'ptr' for readability sake.
>

If you prefer

> >       log = &chip->log;
> >       if (chip->dev.parent && chip->dev.parent->of_node)
> > @@ -65,7 +67,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
> >               return -EIO;
> >       }
> >
> > -     log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
> > +     p = memremap(base, size, MEMREMAP_WB);
> > +     if (!p)
> > +             return -ENOMEM;
> > +     log->bios_event_log = kmemdup(p, size, GFP_KERNEL);
> > +     memunmap(p);
> >       if (!log->bios_event_log)
> >               return -ENOMEM;
> >
> > --
> > 2.17.1
> >
>
> This is a really great catch!
>
> I'm a bit late of my PR a bit because of SGX upstreaming madness
> (sending v39 soon). If you can answer to my question above, I can do
> that nitpick change to patch and get it to my v5.10 PR.
>

Yes, please.

> PS. Just so that you know, once I've applied it, it will be available
> here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>
> I'll include MAINTAINERS update to that PR.
>
> /Jarkko
