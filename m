Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F805A3CAD
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfH3QzF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 12:55:05 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41006 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfH3QzF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 12:55:05 -0400
Received: by mail-yb1-f194.google.com with SMTP id 1so2690147ybj.8;
        Fri, 30 Aug 2019 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zR1h+vGYJyeUeDG1mokDAqx+WVVcy0d2C0aijgBy6Sg=;
        b=iwLIm/bMRtCqwe31fh+OjU3JGE3jDmVEVetak7Ghk2JejpIhVSKOR/sL1ZYdIKY2fi
         PhqbztD8gGwUlhTAiuiVp3yAHYWZixWIMYTvQiT1XXDuShKn9qZ5BhuMrR9eRdyxT20i
         p5KutSa7LrDz/1oszehHD+nleo6fEnj7GMyjkg32lV4itKvorUSrHltQohiMeLit1ou/
         dhqmPDBjGaEx65h30iMQ1BQqRpD0AjdOswoiol7HEsrhy7EyDStldvPxlVc+jQCeFdF8
         48FTClPdIbdOPL/YxWu6VFnKVbUfSavBk+FjhbVF5jjVv9boOTmAif2wQcIE47wmRcZJ
         FbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zR1h+vGYJyeUeDG1mokDAqx+WVVcy0d2C0aijgBy6Sg=;
        b=UCXz5qd0rhNLPO8ighV6HwtmnxYLPK4p+WoIUaYGUugrlR/hwlfnJyclRwbCq/Tj1D
         4zQ76xJ0k5/hSBrFOzVkSpxu1VVBxRRL6b6P+h9L57LwhlruFsQpApnUSGmD700V85Np
         Y4flSzTzai7x+tVDTU+kvM23R9Ss+fIdg372nzPkYPNX8w153kqJrMkhqmKdcpaXG9Kc
         Vv+whumNLxhm25uPNGhP3i+/9KQrda7WHlQuwaoQMZIF/wtAM6d2ED7m3ZFQUYaJ7dcf
         pTK2OlXpav3lxd0gXrU3Tc3sOjTjSDl6CyVCC/FQETWDZTQu7rfUOcNZvaEK4hUPk+P7
         QjFg==
X-Gm-Message-State: APjAAAWFk8Oe2ArdBk40zV0jRQ/x9YiWLKxrDumW1+duaeHCogw7gB6F
        kpyU2uaM7k8orU7DlA/pM1FFBKV3w+Nzvuk6wq8=
X-Google-Smtp-Source: APXvYqzilrbCGag60xEhZJ4LiskMCN2uyFTvAV+Jw9y8YbT130oukmCNmpegTB7jMwBIo0ons/9RHj9ta33LsLFU7Ok=
X-Received: by 2002:a25:2f42:: with SMTP id v63mr11761420ybv.228.1567184103781;
 Fri, 30 Aug 2019 09:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190830095639.4562-1-kkamagui@gmail.com> <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca> <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Sat, 31 Aug 2019 01:54:51 +0900
Message-ID: <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> > From: linux-integrity-owner@vger.kernel.org <linux-integrity-
> > owner@vger.kernel.org> On Behalf Of Seunghun Han
> > Sent: Friday, August 30, 2019 9:55 AM
> > To: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
> > <peterhuewe@gmx.de>; open list:TPM DEVICE DRIVER <linux-
> > integrity@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>
> > Subject: EXT: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping
> > mechanism for supporting AMD's fTPM
> >
> > >
> > > On Fri, Aug 30, 2019 at 06:56:39PM +0900, Seunghun Han wrote:
> > > > I got an AMD system which had a Ryzen Threadripper 1950X and MSI
> > > > mainboard, and I had a problem with AMD's fTPM. My machine showed
> > an
> > > > error message below, and the fTPM didn't work because of it.
> > > >
> > > > [  5.732084] tpm_crb MSFT0101:00: can't request region for resource
> > > >              [mem 0x79b4f000-0x79b4ffff] [  5.732089] tpm_crb: probe
> > > > of MSFT0101:00 failed with error -16
> > > >
> > > > When I saw the iomem, I found two fTPM regions were in the ACPI NVS
> > area.
> > > > The regions are below.
> > > >
> > > > 79a39000-79b6afff : ACPI Non-volatile Storage
> > > >   79b4b000-79b4bfff : MSFT0101:00
> > > >   79b4f000-79b4ffff : MSFT0101:00
> > > >
> > > > After analyzing this issue, I found that crb_map_io() function
> > > > called
> > > > devm_ioremap_resource() and it failed. The ACPI NVS didn't allow the
> > > > TPM CRB driver to assign a resource in it because a busy bit was set
> > > > to the ACPI NVS area.
> > > >
> > > > To support AMD's fTPM, I added a function to check intersects
> > > > between the TPM region and ACPI NVS before it mapped the region. If
> > > > some intersects are detected, the function just calls devm_ioremap()
> > > > for a workaround. If there is no intersect, it calls
> > devm_ioremap_resource().
> > > >
> > > > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> > > > ---
> > > >  drivers/char/tpm/tpm_crb.c | 25 +++++++++++++++++++++++--
> > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > >
> > > This still seems to result in two drivers controlling the same memory.
> > > Does this create bugs and races during resume?
> > >
> > > Jason
> >
> > When I tested this patch in my machine, it seemed that ACPI NVS was saved
> > after TPM CRB driver sent "TPM2_Shutdown(STATE)" to the fTPM while
> > suspending. Then, ACPI NVS was restored while resuming.
> > After resuming, PCRs didn't change and TPM2 tools such as tpm2_pcrlist,
> > tpm2_extend, tpm2_getrandoms worked well.
> > So, according to my test result, it seems that the patch doesn't create bugs
> > and race during resume.
> >
> > Seunghun
>
> This was discussed earlier on the list.
> The consensus was that, while safe now, this would be fragile, and subject to
> unexpected changes in ACPI/NVS, and we really need to tell NVS to exclude the
> regions for long term safety.

Thank you for your advice. We also discussed earlier and concluded
that checking and raw remapping are enough to work around this. The
link is here, https://lkml.org/lkml/2019/8/29/962 .

> As separate issues, the patches do not work at all on some of my AMD systems.
> First, you only force the remap if the overlap is with NVS, but I have systems
> where the overlap is with other reserved regions. You should force the remap
> regardless, but if it is NVS, grab the space back from NVS.

I didn't know about that. I just found the case from your thread that
AMD system assigned TPM region into the reserved area. However, as I
know, the reserved area has no busy bit so that TPM CRB driver could
assign buffer resources in it. Right? In my view, if you patched your
TPM driver with my patch series, then it could work. Would you explain
what happened in TPM CRB driver and reserved area?

>
> Second, the patch extends the wrong behavior of the current driver to both
> buffer regions. If there is a conflict between what the device's control
> register says, and what ACPI says, the existing driver explicitly "trusts the ACPI".
> This is just wrong. The actual device will use the areas as defined by its
> control registers regardless of what ACPI says. I talked to Microsoft, and
> their driver trusts the control register values, and doesn't even look at the
> ACPI values.

As you know, the original code trusts the ACPI table because of the
workaround for broken BIOS, and this code has worked well for a long
time. In my view, if we change this code to trust control register
value, we could make new problems and need a lot of time to check the
workaround. So, I want to trust the ACPI value now.

>
> In practice, I have tested several systems in which the device registers show
> The correct 4K buffers, but the driver instead trusts the ACPI values, which
> list just 1K buffers. 1K buffers will not work for large requests, and the
> device is going to read and write the 4K buffers regardless.
>
> dave

I know about that. However, the device driver is not going to read and
write 4K buffers if you patch your TPM driver with my patch series.
One of my patches has an enhancement feature that could calculate the
buffer size well. The TPM driver uses exactly 1K buffer for this case,
not 4K buffer, and it works.

Seunghun
