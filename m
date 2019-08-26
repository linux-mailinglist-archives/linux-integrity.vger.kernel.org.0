Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8817D9CC52
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2019 11:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfHZJNA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 05:13:00 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38415 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730749AbfHZJNA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 05:13:00 -0400
Received: by mail-yb1-f193.google.com with SMTP id j199so6719389ybg.5;
        Mon, 26 Aug 2019 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4Cy8L8bB4Jw3AVIBtSZIHp5FVOMiVRH7OYkAYvDcFU=;
        b=aY5IgOtK9Y1R0OVqpRVN6dp+Avd/R10BQdvyge27urqxHRphjhah8kdbGiU+/65d7j
         FzV5/i49fIHpyG58qKvFJFBI9FVJ/W54YjryVbP4uis4fAArB0y8KKD1YKEXn8nXkp+/
         tzwq1336zUqIXYsAYMi21Q+4yVEkEVW1GATqrNYze4o/MIFSNV1RdNgJvxL+rmgYJGKX
         kZFBwBbBkWL9ias0Bwx5YaoBf01CFqGkQEGSwLSnSY7Dm7w6f388e+twPef6mz5UG9nt
         vYbhS3XPOnS1UwschchfLuav7pthlV2k0QH3GicagEx+v+q5F18vmkRFve7s1R2ULqqf
         7xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4Cy8L8bB4Jw3AVIBtSZIHp5FVOMiVRH7OYkAYvDcFU=;
        b=BxS9N17/1N+hnEbKSMOouTuU6ZSuBJ97atZMktnoR3tReqvTSXXxDQ4aDDZSqeh7lf
         jEDh/LQo5rSbQF0MK8dGEDqgN0emYt6OF6aUYwv/n5U5fTgfU0LbcDfL8Vze3nQU/VMg
         wwbbT0nhlsm1J8iI34Uz3xFAAA7L4WpSFqVHbkK6ba7tr4bmwikswrTi/BHni2uSsaoQ
         6NSHmX0JyR9pO81O/XYGcMVKCLj0rEVNI5ezY2a/2DtN/7jdJ4ku9eEpkazytzgr+Eb+
         PX/dRQl0q7avZ+uR3/a0cuFBdz3SD8K9bHVoyT27Jf7cIFCb5cG5hcCU6wZmlu/jFOGH
         08Xw==
X-Gm-Message-State: APjAAAV3LchGw762u2w2AL5RM1dNyiSSpTjVUngBnXJEGTqKEDtOx9EA
        qZZwFCR8MhfHK84ElyFYaM/p55ZJiFkiDC4LgHM=
X-Google-Smtp-Source: APXvYqymIcX9MTQRTDDVMra8V0dV9qxpC9rLOcIlKQ/lbNeKTzSREvV6LnuDB4Nbwyt2d0IntiEF2yHdZhoxvHDISPc=
X-Received: by 2002:a25:d751:: with SMTP id o78mr13265833ybg.101.1566810778665;
 Mon, 26 Aug 2019 02:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190825174019.5977-1-kkamagui@gmail.com> <20190826055903.5um5pfweoszibem3@linux.intel.com>
In-Reply-To: <20190826055903.5um5pfweoszibem3@linux.intel.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Mon, 26 Aug 2019 18:12:47 +0900
Message-ID: <CAHjaAcQ5ArtrGzKsPRasFfTmdE59cYWLVbOT4pMHhgJZ_fXUcQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: tpm_crb: Add an AMD fTPM support feature
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> On Mon, Aug 26, 2019 at 02:40:19AM +0900, Seunghun Han wrote:
> > I'm Seunghun Han and work at the Affiliated Institute of ETRI. I got an AMD
> > system which had a Ryzen Threadripper 1950X and MSI mainboard, and I had
> > a problem with AMD's fTPM. My machine showed an error message below, and
> > the fTPM didn't work because of it.
> >
> > [    5.732084] tpm_crb MSFT0101:00: can't request region for resource
> >                [mem 0x79b4f000-0x79b4ffff]
> > [    5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> >
> > When I saw the iomem areas and found two TPM CRB regions were in the ACPI
> > NVS area.  The iomem regions are below.
> >
> > 79a39000-79b6afff : ACPI Non-volatile Storage
> >   79b4b000-79b4bfff : MSFT0101:00
> >   79b4f000-79b4ffff : MSFT0101:00
> >
> > After analyzing this issue, I found out that a busy bit was set to the ACPI
> > NVS area, and the current Linux kernel allowed nothing to be assigned in
> > it. I also found that the kernel couldn't calculate the sizes of command
> > and response buffers correctly when the TPM regions were two or more.
> >
> > To support AMD's fTPM, I removed the busy bit from the ACPI NVS area
> > so that AMD's fTPM regions could be assigned in it. I also fixed the bug
> > that did not calculate the sizes of command and response buffer correctly.
> >
> > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
>
> You need to split this into multiple patches e.g. if you think you've
> fixed a bug, please write a patch with just the bug fix and nothing
> else.
>
> For further information, read the section three of
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> I'd also recommend to check out the earlier discussion on ACPI NVS:
>
> https://lore.kernel.org/linux-integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com/
>
> /Jarkko

Thank you for your advice. I have made two separated patches on your advice.
Please check these patches, https://lkml.org/lkml/2019/8/26/125 and
https://lkml.org/lkml/2019/8/26/163.

In my opinion, the last link you gave me had two problems with AMD's
fTPM. One problem was the ACPI NVS area was set to the busy area, and
TPM regions of the ACPI table were in it. Therefore, TPM CRB driver
couldn't allocate command and response buffers in it because ACPI NVS
area was busy. The other problem was buffer size calculation bugs.
Because of it, TPM CRB driver requested larger than the size ACPI
table described. So, TPM CRB driver also couldn't map command and
response buffers even though the reserved area was not busy.

It seems that my separated patches could handle those two problems and
enable AMD's fTPM in any case.

Seunghun
