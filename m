Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5601A3822
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfH3NzM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 09:55:12 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45492 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfH3NzM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 09:55:12 -0400
Received: by mail-yw1-f68.google.com with SMTP id n69so2385107ywd.12;
        Fri, 30 Aug 2019 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwyr09OeKTgN7mrxVHx+2hnXAPzOPQfRzUlZ2zECK50=;
        b=LJQhakBK31minFRW4+8ZqTjPS3meQLKD9H4oU3dh9tMkpMp6sFAIeTMemX1uaJjgjR
         MXHO7nRFXUstF0WXKc7ByqGTy3QTteAYN8cOXjf7CG40/7dj59OjmKjymJ5Ty/GcqdA1
         3luwpNCClgEG5EYsRPc8ECjrSyQWMb+h0QOS37SXa66utV+Oq0IpUDXV9IteyCXnImOR
         +EM49X/KYXCkxRBd9CoCUp6iaY3eNN54YtTQ1jx+prWFPdyWyl4quO0DvBUKe816r7El
         epndZ4XYWWHJWIPcEjR6uuNEed3xh8ZL8inhpE0WVZS1YHTy6UWTdlC6rCsLXSPL8eHy
         ofng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwyr09OeKTgN7mrxVHx+2hnXAPzOPQfRzUlZ2zECK50=;
        b=EUc1/Cw3O0e1K5GB1HgcF/jMvE1ywRWpC1i+C/Hd/q1yTmP3eGQbHyV19oD4OrHv52
         APD7HW7xaRGamtmvnGL2bg+FLT/SqWyyVCdDLd1ENheUxY5cRAYRHqqNplfBci0Ml05a
         jDilSANqRHlpcNkUHcDXezfsoGPKONab+XywBIETDSl9gRteHauJNRqY719lh4dgMNUt
         CdnmuW4dImdY5mO39NZJ5G+nXUeoE1ckUEosbnSm5ZTDNzWEeI9N9FCoEwfpwzfEIP4l
         WvFT/qtwlDHRrC5cF3iX4NY6EaLNbMCmi+iRcc+S1ZcaWJnjgv1dYXC1nIoOtUPP/sRX
         Jg+Q==
X-Gm-Message-State: APjAAAXIjdDW2sLnvZCshXRng/K7+grBh0hxocja16m1/xVI7xtYL9Yk
        0xL4kd6wQKNcHNzQVECwhcvKKZEzzlQGVwHmB6M=
X-Google-Smtp-Source: APXvYqyKUdtdX4Fn6uwYsTcN5PRkZApmByK6IhOxrD/lRH6xihpu7XCLNslcRQr0GpGRhHl1KZcBpCGVcEJg+UKNPxM=
X-Received: by 2002:a81:9108:: with SMTP id i8mr11138441ywg.346.1567173311094;
 Fri, 30 Aug 2019 06:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190830095639.4562-1-kkamagui@gmail.com> <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca>
In-Reply-To: <20190830124334.GA10004@ziepe.ca>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Fri, 30 Aug 2019 22:54:59 +0900
Message-ID: <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Fri, Aug 30, 2019 at 06:56:39PM +0900, Seunghun Han wrote:
> > I got an AMD system which had a Ryzen Threadripper 1950X and MSI
> > mainboard, and I had a problem with AMD's fTPM. My machine showed an error
> > message below, and the fTPM didn't work because of it.
> >
> > [  5.732084] tpm_crb MSFT0101:00: can't request region for resource
> >              [mem 0x79b4f000-0x79b4ffff]
> > [  5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> >
> > When I saw the iomem, I found two fTPM regions were in the ACPI NVS area.
> > The regions are below.
> >
> > 79a39000-79b6afff : ACPI Non-volatile Storage
> >   79b4b000-79b4bfff : MSFT0101:00
> >   79b4f000-79b4ffff : MSFT0101:00
> >
> > After analyzing this issue, I found that crb_map_io() function called
> > devm_ioremap_resource() and it failed. The ACPI NVS didn't allow the TPM
> > CRB driver to assign a resource in it because a busy bit was set to
> > the ACPI NVS area.
> >
> > To support AMD's fTPM, I added a function to check intersects between
> > the TPM region and ACPI NVS before it mapped the region. If some
> > intersects are detected, the function just calls devm_ioremap() for
> > a workaround. If there is no intersect, it calls devm_ioremap_resource().
> >
> > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
>
> This still seems to result in two drivers controlling the same
> memory. Does this create bugs and races during resume?
>
> Jason

When I tested this patch in my machine, it seemed that ACPI NVS was
saved after TPM CRB driver sent "TPM2_Shutdown(STATE)" to the fTPM
while suspending. Then, ACPI NVS was restored while resuming.
After resuming, PCRs didn't change and TPM2 tools such as
tpm2_pcrlist, tpm2_extend, tpm2_getrandoms worked well.
So, according to my test result, it seems that the patch doesn't
create bugs and race during resume.

Seunghun
