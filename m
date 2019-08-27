Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05DE9DEE1
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 09:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbfH0HiO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 03:38:14 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35177 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0HiN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 03:38:13 -0400
Received: by mail-yb1-f193.google.com with SMTP id c9so7911803ybf.2;
        Tue, 27 Aug 2019 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5t3yKi3JvE68h42FmRJi4n/mX6sXwSRuRZAsy+XJ94=;
        b=Qs24p3vrIjL2JENTyrSrUuq7SRxVgNGPwTyhwGz90SOTwCKxinNYHDRVhEBMdVY6v3
         WUqFFsvbFFbwi4EO9pKc77251ExDtEJFjz7GaCGqKKWoHbXoWVJzkV8AS/E+7Y4RbOlB
         nYlT2Bn4z3AcdLjB7WBgUjhmQxwxgTn/edfPfonxaIQiVNNXnq7oyKzyAf410KNtz3vk
         K+BgDM0c9MMAH8rAaLsVA+19T2GCoHETrRcsiym4A1CPTBCn/yUz8epeeyVSjGONRJ+C
         VAJIfLYvPH3eksIHrpvMpXJV+Gg5Rg6RQ2EbYE+RGHTQPgZMVszwGE8eNijXYm4svlfM
         JfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5t3yKi3JvE68h42FmRJi4n/mX6sXwSRuRZAsy+XJ94=;
        b=NPhklZnXldPYLjBmM+0w+Z870tTD4zwybfSrarsUky6OSDoFG29SecRUR+TesV02B3
         n2isfQHy5wWt8SBOSn7QXdX7eeNdfv8AuieHJoUK+pKQtV5QAuoux1IgrlqjHvlINUcH
         7JsC28BfiKD2eTJ1evkduCifrtuoLiEVFDoZPrBLmbZQp5Du/GuoUABm0TUw7sr7DMkj
         MhkE63mN96G+y2pND8Io4GVPOHeNZHi6L/ovqkgUQdm5b6pNxlOH3GZ4RYGm7+0OUQ1T
         1OvkfE5IqO1+S2Z5G0OKHVSVDrZscHOGTXcNJ2TGJWaNQSpw21QApMOMWhyngbC8okw0
         7gOQ==
X-Gm-Message-State: APjAAAWa8TXmDMIxHVOoWzppfIEqPXVpOXpjMTc/rkrkgKAJGvHyOTAi
        Dw5L/OpEpq+9ZRuIAk2hGkGF0Ld5iyxzYS0W4BI=
X-Google-Smtp-Source: APXvYqz3t8et+hBhBvULjPhpq1VE1nHFuvYlNwRCThACJzK7JhuN4eX++azKSlBncv7DmkmKvUucZLbFXs4086cwgis=
X-Received: by 2002:a25:2f42:: with SMTP id v63mr15474926ybv.228.1566891492571;
 Tue, 27 Aug 2019 00:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190825174019.5977-1-kkamagui@gmail.com> <20190826055903.5um5pfweoszibem3@linux.intel.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1BAA7@ALPMBAPA12.e2k.ad.ge.com>
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1BAA7@ALPMBAPA12.e2k.ad.ge.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Tue, 27 Aug 2019 16:38:01 +0900
Message-ID: <CAHjaAcR51FKgBMF736-qsW0gKHxzf4jMJDsDnh0mm2dACOV65A@mail.gmail.com>
Subject: Re: [PATCH] tpm: tpm_crb: Add an AMD fTPM support feature
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> > From: linux-integrity-owner@vger.kernel.org <linux-integrity-
> > owner@vger.kernel.org> On Behalf Of Jarkko Sakkinen
> > Sent: Monday, August 26, 2019 1:59 AM
> > To: Seunghun Han <kkamagui@gmail.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>; Thomas Gleixner
> > <tglx@linutronix.de>; linux-kernel@vger.kernel.org; linux-
> > integrity@vger.kernel.org
> > Subject: EXT: Re: [PATCH] tpm: tpm_crb: Add an AMD fTPM support feature
> >
> > On Mon, Aug 26, 2019 at 02:40:19AM +0900, Seunghun Han wrote:
> > > I'm Seunghun Han and work at the Affiliated Institute of ETRI. I got
> > > an AMD system which had a Ryzen Threadripper 1950X and MSI mainboard,
> > > and I had a problem with AMD's fTPM. My machine showed an error
> > > message below, and the fTPM didn't work because of it.
> > >
> > > [    5.732084] tpm_crb MSFT0101:00: can't request region for resource
> > >                [mem 0x79b4f000-0x79b4ffff]
> > > [    5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16
> > >
> > > When I saw the iomem areas and found two TPM CRB regions were in the
> > > ACPI NVS area.  The iomem regions are below.
> > >
> > > 79a39000-79b6afff : ACPI Non-volatile Storage
> > >   79b4b000-79b4bfff : MSFT0101:00
> > >   79b4f000-79b4ffff : MSFT0101:00
> > >
> > > After analyzing this issue, I found out that a busy bit was set to the
> > > ACPI NVS area, and the current Linux kernel allowed nothing to be
> > > assigned in it. I also found that the kernel couldn't calculate the
> > > sizes of command and response buffers correctly when the TPM regions
> > were two or more.
> > >
> > > To support AMD's fTPM, I removed the busy bit from the ACPI NVS area
> > > so that AMD's fTPM regions could be assigned in it. I also fixed the
> > > bug that did not calculate the sizes of command and response buffer
> > correctly.
>
> The problem is that the acpi tables are _wrong_ in this and other cases.
> They not only incorrectly report the area as reserved, but also report
> the command and response buffer sizes incorrectly. If you look at
> the addresses for the buffers listed in the crb control area, the sizes
> are correct (4Kbytes).  My patch uses the control area values, and
> everything works. The remaining problem is that if acpi reports the
> area as NVS, then the linux nvs driver will try to use the space.
> I'm looking at how to fix that. I'm not sure, if simply removing
> the busy bit is sufficient.
> Dave

Thank you for your reply. I have read your patch. However, I would
like to solve this problem without a kernel parameter. In my view, I'd
better change the crb_fixup_cmd_size() function because the TPM CRB
driver wants to get the command buffer and response buffer sizes by
using the function.

I agree on that removing the busy bit is sufficient.

Seunghun

>
> > >
> > > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> >
> > You need to split this into multiple patches e.g. if you think you've fixed a
> > bug, please write a patch with just the bug fix and nothing else.
> >
> > For further information, read the section three of
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> >
> > I'd also recommend to check out the earlier discussion on ACPI NVS:
> >
> > https://lore.kernel.org/linux-
> > integrity/BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e
> > 2k.ad.ge.com/
> >
> > /Jarkko
