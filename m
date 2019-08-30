Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18D7A3492
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfH3KCD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 06:02:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45455 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfH3KCD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 06:02:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id n69so2172949ywd.12;
        Fri, 30 Aug 2019 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIMw0qKaytre7FG6jFJWV4iDfNINre/R6oO7ZIuT+RM=;
        b=a/iH+APt7PbRkzLKE6KRlBQQvNjly6EgIh2Equ0T3wdPNvBCM9eYU3/uElXpVQVpJP
         fIvORJDofPBr7LkutP4IBsVTrLCIsU0t10urIJmElXgiOXH4e9q1yYzyFv3+K2IuvN7P
         /Ri6HQg6AofF4T7y54qZ8rGDJnhYQ1axF/RdpptNCVAXHT7zXuUpoiPM7qmzBIXPDxkc
         yz43N32iSTODuXLhklnvg4xO3pFOf4iekY9g7XtUsy8MNVjxoZFssoP7e0AC4xiwpx7w
         LhUzFXBsgsK2+Z7kNAbqDpvfakxDCbYzgiv5ZQqwOCQA3uq2h0SksKwaWhinmCGs9EZi
         g2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIMw0qKaytre7FG6jFJWV4iDfNINre/R6oO7ZIuT+RM=;
        b=o7467a9hQ2wg4Zp3nDa1ingY56rPNguUXkiOeQydiaOiCGeAk8zo5CPMRD1sti7E2t
         7wrBY6KN0LS5NZXGIUCloFJHNGUSgOsGkR2CX9yPJGE460MJh5p+HdJ23LuherNrHSba
         ruTpdc0PMy+HRgZ0nfNUVbExIiz/1GRj0q+MKeJHtNjJRzOj4tLsm27V60wezjbO9rcw
         XVOhN+0/sPQ3iQL51+7/rRSofc1w/RZOrIAO/yMDm4maWJwYNvei2+Z1IIuFfME5LHty
         On0bY991M5Vf4KR2HnbTnY9PLcZ1vaC27UDdwAPSL8S/K1ryUQs2CkPj8dljKXRItGjL
         Ihlg==
X-Gm-Message-State: APjAAAXX6aMTQp0ipPVje9gl0oY5TJVbQ/wUzm/CYedTRwgajvcqP5Zj
        K9PH+renSiOV5TFuaOXrquhHpRaUtnBUvSYIL+4=
X-Google-Smtp-Source: APXvYqzYIhbifbnfgdIKzmR3aU+cJzCuIaJQl3BUNyvyAZVabAy2aY3yZydYfvfnALekrK7oN9gYZXu8g0KQgBdsQKs=
X-Received: by 2002:a0d:d596:: with SMTP id x144mr9971364ywd.69.1567159321875;
 Fri, 30 Aug 2019 03:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com> <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
 <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
 <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com>
 <20190827171106.owkvt6slwwg5ypyl@srcf.ucam.org> <CAHjaAcSu04J3WqT_vnSnaQuYpFQ+xiXXWxhcCeLQccEq6eQGcQ@mail.gmail.com>
 <20190829153437.gjcqfolsc26vyt4x@linux.intel.com> <20190829153917.glq6eoka2eufy42w@linux.intel.com>
 <CAHjaAcQ2OmrFO2wWCXocR9xO_aTRYU4vLf3aBr4v5Fn2A89wvg@mail.gmail.com>
In-Reply-To: <CAHjaAcQ2OmrFO2wWCXocR9xO_aTRYU4vLf3aBr4v5Fn2A89wvg@mail.gmail.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Fri, 30 Aug 2019 19:01:50 +0900
Message-ID: <CAHjaAcQv+8ZqYwcYLj57rM9wMRvsoUczzE8uXjsTY+yxNB7vFw@mail.gmail.com>
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

> > On Thu, Aug 29, 2019 at 06:34:37PM +0300, Jarkko Sakkinen wrote:
> > > On Wed, Aug 28, 2019 at 06:36:04PM +0900, Seunghun Han wrote:
> > > > >
> > > > > On Wed, Aug 28, 2019 at 01:36:30AM +0900, Seunghun Han wrote:
> > > > >
> > > > > > I got your point. Is there any problem if some regions which don't
> > > > > > need to be handled in NVS area are saved and restored? If there is a
> > > > > > problem, how about adding code for ignoring the regions in NVS area to
> > > > > > the nvs.c file like Jarkko said? If we add the code, we can save and
> > > > > > restore NVS area without driver's interaction.
> > > > >
> > > > > The only thing that knows which regions should be skipped by the NVS
> > > > > driver is the hardware specific driver, so the TPM driver needs to ask
> > > > > the NVS driver to ignore that region and grant control to the TPM
> > > > > driver.
> > > > >
> > > > > --
> > > > > Matthew Garrett | mjg59@srcf.ucam.org
> > > >
> > > > Thank you, Matthew and Jarkko.
> > > > It seems that the TPM driver needs to handle the specific case that
> > > > TPM regions are in the NVS. I would make a patch that removes TPM
> > > > regions from the ACPI NVS by requesting to the NVS driver soon.
> > > >
> > > > Jarkko,
> > > > I would like to get some advice on it. What do you think about
> > > > removing TPM regions from the ACPI NVS in TPM CRB driver? If you don't
> > > > mind, I would make the patch about it.
> > >
> > > I'm not sure if ignoring is right call. Then the hibernation behaviour
> > > for TPM regions would break.
> > >
> > > Thus, should be "ask access" rather than "grant control".
>
> I agree with your idea. It seems to make trouble. So, I would like to
> do like your idea below.
>
> > Or "reserve access" as NVS driver does not have intelligence to do any
> > policy based decision here.
> >
> > A function that gets region and then checks if NVS driver has matching
> > one and returns true/false based on that should be good enough. Then
> > you raw ioremap() in the TPM driver.
> >
> > /Jarkko
>
> This solution is great and clear to me. I will make a new patch on
> your advice and test it in my machine. After that, I will send it
> again soon.
> I really appreciate it.
>
> Seunghun

I have made and sent patches on your advice.
The patch links are below and please review them.
[PATCH 0/2] https://lkml.org/lkml/2019/8/30/372
[PATCH 1/2] https://lkml.org/lkml/2019/8/30/373
[PATCH 2/2] https://lkml.org/lkml/2019/8/30/374

Thank you again for your sincere advice.

Seunghun
