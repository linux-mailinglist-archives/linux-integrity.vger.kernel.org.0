Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBFA206C
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 18:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfH2QNG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 12:13:06 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37450 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfH2QNF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 12:13:05 -0400
Received: by mail-yb1-f196.google.com with SMTP id t5so1382436ybt.4;
        Thu, 29 Aug 2019 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNznxc1elQs9GK9cu3jq6YkqkQEUKZhFLbPtaGv0C7o=;
        b=Kg0eD7aNyxUxwwHK5ETgxsz5XldzcAgvsJUzNfvpReGhHOVR2p+874TdwEXnXR9zQ2
         K9h3T4xDrjrK8j4+dYWIXFkFPPpKRg7Tw76OfrkTNwwV8dzbGtTE3Vx9uSi7skwRwiXL
         Wz7QG0/CBZ0++nKYNWMsl4mgSFICLzr7VLX1x7QbzZt5D2MEkkRQ8BE4A3Dk79c8I5dk
         X8RHnt18Ofzeh3b9D7E8hnI97l58deFHhK+/NyftX5pRcqTaY/vRzCCLgAUiKT/SgEUF
         1B5fixfjE4QImmhs+0/1xvvFK+xXN2T2wl+RZ0mjgVDw9NAr+w2vadGJqEGjDtVsYrY+
         VaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNznxc1elQs9GK9cu3jq6YkqkQEUKZhFLbPtaGv0C7o=;
        b=adk9d0Dwfc6Kew0WVc1tly3JbjLDW8Gd0Cv8QSnjCERA4Je0LwmMu2xOywhtcTpxaO
         +zDQj3mQ+KKYp1SH6c7M56F9Jtbpgb1rybiNsRkn8i9R0eEm7d1fyn2BI6zW40FB6y3v
         2PcysyDIh44skUBo8zDVL1UTc146AQe5nSuyLXNIDbU9iW3+NM/zXKn45QY/zEjTLcFO
         YjP/WnbO+N61IU0rzHsx6n1zbNRgbN70a4kJwosmfOBQkvfO9KSOZs2lsOrL9Mz21vyr
         Nwf6wDGbpnITkJ3O/NIsl39Z1bjjUe2tRhm0ZqJgS/KlgEKTqpywbWXD0MCNzQLiXgTF
         GlBg==
X-Gm-Message-State: APjAAAUsHXRtOD3RQSRIrxdRCbEI0b12rnwLipYxe5JYmXSXwlI0PKNo
        XVfTUCK82yIpUfRd0vmpu9JFuA5qffvHnc3MiPA=
X-Google-Smtp-Source: APXvYqxOiciOtyiybUGhnpKGmM1DjYJIs5IYPSDqHbwUFYOmyJV/fnnpTn6QkBGE0FEPgWf28bsP8P7NLrHxQy9Y8Rk=
X-Received: by 2002:a25:9cc9:: with SMTP id z9mr7850415ybo.496.1567095184713;
 Thu, 29 Aug 2019 09:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com> <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
 <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
 <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com>
 <20190827171106.owkvt6slwwg5ypyl@srcf.ucam.org> <CAHjaAcSu04J3WqT_vnSnaQuYpFQ+xiXXWxhcCeLQccEq6eQGcQ@mail.gmail.com>
 <20190829153437.gjcqfolsc26vyt4x@linux.intel.com> <20190829153917.glq6eoka2eufy42w@linux.intel.com>
In-Reply-To: <20190829153917.glq6eoka2eufy42w@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Fri, 30 Aug 2019 01:12:53 +0900
Message-ID: <CAHjaAcQ2OmrFO2wWCXocR9xO_aTRYU4vLf3aBr4v5Fn2A89wvg@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Thu, Aug 29, 2019 at 06:34:37PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Aug 28, 2019 at 06:36:04PM +0900, Seunghun Han wrote:
> > > >
> > > > On Wed, Aug 28, 2019 at 01:36:30AM +0900, Seunghun Han wrote:
> > > >
> > > > > I got your point. Is there any problem if some regions which don't
> > > > > need to be handled in NVS area are saved and restored? If there is a
> > > > > problem, how about adding code for ignoring the regions in NVS area to
> > > > > the nvs.c file like Jarkko said? If we add the code, we can save and
> > > > > restore NVS area without driver's interaction.
> > > >
> > > > The only thing that knows which regions should be skipped by the NVS
> > > > driver is the hardware specific driver, so the TPM driver needs to ask
> > > > the NVS driver to ignore that region and grant control to the TPM
> > > > driver.
> > > >
> > > > --
> > > > Matthew Garrett | mjg59@srcf.ucam.org
> > >
> > > Thank you, Matthew and Jarkko.
> > > It seems that the TPM driver needs to handle the specific case that
> > > TPM regions are in the NVS. I would make a patch that removes TPM
> > > regions from the ACPI NVS by requesting to the NVS driver soon.
> > >
> > > Jarkko,
> > > I would like to get some advice on it. What do you think about
> > > removing TPM regions from the ACPI NVS in TPM CRB driver? If you don't
> > > mind, I would make the patch about it.
> >
> > I'm not sure if ignoring is right call. Then the hibernation behaviour
> > for TPM regions would break.
> >
> > Thus, should be "ask access" rather than "grant control".

I agree with your idea. It seems to make trouble. So, I would like to
do like your idea below.

> Or "reserve access" as NVS driver does not have intelligence to do any
> policy based decision here.
>
> A function that gets region and then checks if NVS driver has matching
> one and returns true/false based on that should be good enough. Then
> you raw ioremap() in the TPM driver.
>
> /Jarkko

This solution is great and clear to me. I will make a new patch on
your advice and test it in my machine. After that, I will send it
again soon.
I really appreciate it.

Seunghun
