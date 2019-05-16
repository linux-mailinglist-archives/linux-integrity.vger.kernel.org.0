Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08CE1FFF3
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2019 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEPHGT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 May 2019 03:06:19 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38280 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEPHGS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 May 2019 03:06:18 -0400
Received: by mail-vs1-f68.google.com with SMTP id x184so602757vsb.5
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tuyRdp1kiTY23EHvc9NEBL/dfI6XqAQnryU6YgN88k=;
        b=VXisOUaRMulel+iyFbX21Xi2jHYGI6moKFyX5kvQe7al8mpkl0q80RJl6c5kjnsh1h
         yWGuLg1y5NZPcm7p+Cw47rCHhC+0XjiL8ZxQniuJ0M8kQmjlD3hcn2PsQw+7K/Wr92xt
         Ym9VT+hZVUxX6HKFvEbHNWvSD5ZzczOTri+dD3Q/TaQAj+RpiCw/TJFip78oFa1mAnjw
         eY6fVaVTm8jK+vUgj6YSwGVV5STazrNbXYDN8soNzs9QjR+a4N/WdtBXU1Sll2PyYtuz
         qe0rorZxQjBQriGR++jFIqbXLslnfOZxl+HPeTqApkxq1TtXLr4ASaBy8bbTSaXK+evi
         p8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tuyRdp1kiTY23EHvc9NEBL/dfI6XqAQnryU6YgN88k=;
        b=kgfVplwREWlw0SZoymOfLjLt1w6YWePp3TeGZNjFlgJ1INbURX+g90cdzr+9Pj2TOW
         47EBgC3ceJyHYreIwatcnxyKQ1aq/8X97kNExGc1wXutv0D9kihCrVVcgP+uYSThoK9a
         Udn7sxUuMeQdli7JupGZVzJg6snYPm6ABlDYXc0AvUQeX8Fv9kVZWF2VuS7kz2cINOB/
         Aaz/GRMdPNMLMMIFDyEHZljqNn7Bc11+ziKyynFxE3sEuKFuJI667deTJMxrXuNCnRyy
         ad7z72HSnuXokr9MoV/JOv2g7Bh2GBAUbI+v1qI6g/0pAY/XhnQFjCnvGMCJE9zXPIiW
         PPUQ==
X-Gm-Message-State: APjAAAXVvU2lInjNugKJPFW9+FPrtaPtuyA0VRHXzTcRAuIpy7e2Sr3A
        Ppd3kzDFwbBMci+QZFyesYmRgkUz187OSGylU+Qn+w==
X-Google-Smtp-Source: APXvYqyViiR+25Q5khqd7QCbhk03N20cWs1hjwkUwhl4DGOsX3b3Ue0RL6+ZKESk/A7zZpAsuR5BcBvLLt4soUS7uOA=
X-Received: by 2002:a67:2781:: with SMTP id n123mr5270839vsn.141.1557990377174;
 Thu, 16 May 2019 00:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190415155636.32748-1-sashal@kernel.org> <20190507174020.GH1747@sasha-vm>
 <20190508124436.GE7642@linux.intel.com> <20190514193056.GN11972@sasha-vm>
 <CAFA6WYM06E0y9o6+CLNPe48spiL=UDEqoGsidMbk1dBa5Rbmkg@mail.gmail.com> <CY4PR21MB0279339E8B0A15414C8F9E14BC0A0@CY4PR21MB0279.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB0279339E8B0A15414C8F9E14BC0A0@CY4PR21MB0279.namprd21.prod.outlook.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 16 May 2019 12:36:05 +0530
Message-ID: <CAFA6WYMvuF+tAA_GmkVg=FTvuuAhMuM=um7kakq=YARaP8un5Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
To:     Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 16 May 2019 at 06:30, Thirupathaiah Annapureddy
<thiruan@microsoft.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Sumit Garg <sumit.garg@linaro.org>
> > Sent: Tuesday, May 14, 2019 7:02 PM
> > To: Sasha Levin <sashal@kernel.org>
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; peterhuewe@gmx.de;
> > jgg@ziepe.ca; corbet@lwn.net; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; linux-doc@vger.kernel.org; linux-
> > integrity@vger.kernel.org; Microsoft Linux Kernel List <linux-
> > kernel@microsoft.com>; Thirupathaiah Annapureddy <thiruan@microsoft.com>;
> > Bryan Kelly (CSI) <bryankel@microsoft.com>
> > Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
> >
> > On Wed, 15 May 2019 at 01:00, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > On Wed, May 08, 2019 at 03:44:36PM +0300, Jarkko Sakkinen wrote:
> > > >On Tue, May 07, 2019 at 01:40:20PM -0400, Sasha Levin wrote:
> > > >> On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
> > > >> > From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
> > > >> >
> > > >> > Changes since v2:
> > > >> >
> > > >> > - Drop the devicetree bindings patch (we don't add any new ones).
> > > >> > - More code cleanups based on Jason Gunthorpe's review.
> > > >> >
> > > >> > Sasha Levin (2):
> > > >> >  ftpm: firmware TPM running in TEE
> > > >> >  ftpm: add documentation for ftpm driver
> > > >>
> > > >> Ping? Does anyone have any objections to this?
> > > >
> > > >Sorry I've been on vacation week before last week and last week
> > > >I was extremely busy because I had been on vacation. This in
> > > >my TODO list. Will look into it tomorrow in detail.
> > > >
> > > >Apologies for the delay with this!
> > >
> > > Hi Jarkko,
> > >
> > > If there aren't any big objections to this, can we get it merged in?
> > > We'll be happy to address any comments that come up.
> >
> > I guess you have missed or ignored this comment [1]. Please address it.
> >
> > [1]
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%
> > 2Flkml%2F2019%2F5%2F8%2F11&amp;data=01%7C01%7Cthiruan%40microsoft.com%7Cf2a
> > 80c7b94434329eaee08d6d8d962b1%7C72f988bf86f141af91ab2d7cd011db47%7C1&amp;sd
> > ata=hyJRc23NwEFLDuaIMkbSCGetd%2BObQWiAg%2BJtMMR6z9U%3D&amp;reserved=0
> >
> > -Sumit
>
> Thanks for reviewing and adding comments.
>
> We tried to use TEE bus framework you suggested for fTPM enumeration.
> We were not able to pass the TCG Logs collected by the boot loaders.
>
> Currently there are 3 ways to pass TCG Logs based on the code
> in drivers/char/tpm/eventlog:
>
> 1. ACPI Table
> 2. EFI Table
> 3. OF Device node properties
>
> Our ARM system is booting using U-boot and Device Tree.
> So ACPI/EFI table mechanism to pass TCG2 logs won't be applicable.
> We needed to use OF device node properties to pass TCG2 Logs.
> TEE bus enumeration framework does not work for our use case due to the above.

Firstly let me clarify that this framework is intended to communicate
with TEE based services/devices rather than boot loader. And in this
case fTPM being a TEE based service, so this framework should be used.

>
> Is it possible to add flexibility in TEE bus enumeration framework to support
> platform specific properties through OF nodes or ACPI?
>

As you mentioned above, TCG logs are collected by boot loader. So it
should find a way to pass them to Linux.

How about if boot loader register these TCG logs with fTPM TA which
could be fetched during fTPM driver probe or new api like
tpm_read_log_tee()? This is something similar to what I used in
optee-rng [1] driver to fetch RNG properties.

[1] https://github.com/torvalds/linux/blob/master/drivers/char/hw_random/optee-rng.c#L176

-Sumit

> >
> > >
> > > --
> > > Thanks,
> > > Sasha
