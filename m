Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E90213E9
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 08:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfEQG53 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 02:57:29 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36446 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfEQG53 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 02:57:29 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so3974601vsp.3
        for <linux-integrity@vger.kernel.org>; Thu, 16 May 2019 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hc0HmzH6OT39dn85lsyoXsO/ryHfm7mgqA3KpAw+uOM=;
        b=W+bv7VhQuiNbe6C4ETIQQxuBkl+ezqdwrhRzaMh5nNmSX8oL00TG4Z+bgQNTnCDynp
         6tB66HhmBBeGUnNo904nRgfZZD9GR/YlUpcpAWjfTOy8/4pCooAaxt72jfuhn8Y/L+73
         9Gn7b0ExQj7uXgkky5cbt+jV4OJ2MwLxnYxPQZgXIrljixmgbVqD7wNW6Q2IJC0HhPT/
         RbS5RN0dWuj3zr3UIlgQBcIgGnlhoaHpSv/YYPItHryTkUz1nbFhTUIyO+zLgnqFDbYa
         ShN3ebb38/7oHDtrV0jjPNxl2/k4ySAD4cQ2V9qgxB0J0MGddAIs6ibuIMDwoRDF+H8m
         PVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hc0HmzH6OT39dn85lsyoXsO/ryHfm7mgqA3KpAw+uOM=;
        b=uVvGpTHruxPEyY1GNqpZNtdtF8nRSCScP8Pp/eKIcRvdAzBB5+haViImo4QmD2cr9h
         fI/jvwFN0DdYxbKYSYHeFVGhIvsK8Y4ocWkcaRt0qvDejSxkwUNmzwfKM0ls82qjBERT
         +lXOIWBB/zNFcv95OFeUMxLO7Dcw2bFh9ufDpHsQFDMtU8RBMXvcQ1KUCh4Lco14wiUr
         gL8NzZqikKhN7MBvk/YDyLmRBvZZlb51EFpNxMJZcBAP23gotjlFjDxSJ62xJYK2gy1Y
         zCjeAWFL2ghQpljbMlOyH3L/eHyxq21dqrhFedvuLchSV+psnZeeN4D/IwE8WrL9x+uE
         Mv8w==
X-Gm-Message-State: APjAAAVoy9iwKx791u6MD9KKQIfYX8J8AUwBKmAkX7BW0TGk0E0824IR
        3dTo9v5641Fn6go7WR9X//o8WOEMYWMJ6YFUaqhypA==
X-Google-Smtp-Source: APXvYqz2DwB9AIFN/f/Don/xWEYRgZOj8oBbn3PBY345zvNQQSfRPWSLNWMqQomwB7XRLAhx836ifXxnCKD0Xogi3t4=
X-Received: by 2002:a67:f693:: with SMTP id n19mr26380878vso.89.1558076247825;
 Thu, 16 May 2019 23:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190415155636.32748-1-sashal@kernel.org> <20190507174020.GH1747@sasha-vm>
 <20190508124436.GE7642@linux.intel.com> <20190514193056.GN11972@sasha-vm>
 <CAFA6WYM06E0y9o6+CLNPe48spiL=UDEqoGsidMbk1dBa5Rbmkg@mail.gmail.com>
 <CY4PR21MB0279339E8B0A15414C8F9E14BC0A0@CY4PR21MB0279.namprd21.prod.outlook.com>
 <CAFA6WYMvuF+tAA_GmkVg=FTvuuAhMuM=um7kakq=YARaP8un5Q@mail.gmail.com> <CY4PR21MB02790D399645EFCA02FBE124BC0A0@CY4PR21MB0279.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB02790D399645EFCA02FBE124BC0A0@CY4PR21MB0279.namprd21.prod.outlook.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 17 May 2019 12:27:15 +0530
Message-ID: <CAFA6WYMsQ53L=Ge5_yX+mvQNgKQRxPq=GxAn6zCksaDU18aTtw@mail.gmail.com>
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
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+ Rob

On Fri, 17 May 2019 at 00:54, Thirupathaiah Annapureddy
<thiruan@microsoft.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Sumit Garg <sumit.garg@linaro.org>
> > Sent: Thursday, May 16, 2019 12:06 AM
> > To: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> > Cc: Sasha Levin <sashal@kernel.org>; Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com>; peterhuewe@gmx.de; jgg@ziepe.ca;
> > corbet@lwn.net; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>;
> > linux-doc@vger.kernel.org; linux-integrity@vger.kernel.org; Microsoft Linux
> > Kernel List <linux-kernel@microsoft.com>; Bryan Kelly (CSI)
> > <bryankel@microsoft.com>
> > Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
> >
> > On Thu, 16 May 2019 at 06:30, Thirupathaiah Annapureddy
> > <thiruan@microsoft.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Sumit Garg <sumit.garg@linaro.org>
> > > > Sent: Tuesday, May 14, 2019 7:02 PM
> > > > To: Sasha Levin <sashal@kernel.org>
> > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>;
> > peterhuewe@gmx.de;
> > > > jgg@ziepe.ca; corbet@lwn.net; Linux Kernel Mailing List <linux-
> > > > kernel@vger.kernel.org>; linux-doc@vger.kernel.org; linux-
> > > > integrity@vger.kernel.org; Microsoft Linux Kernel List <linux-
> > > > kernel@microsoft.com>; Thirupathaiah Annapureddy
> > <thiruan@microsoft.com>;
> > > > Bryan Kelly (CSI) <bryankel@microsoft.com>
> > > > Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
> > > >
> > > > On Wed, 15 May 2019 at 01:00, Sasha Levin <sashal@kernel.org> wrote:
> > > > >
> > > > > On Wed, May 08, 2019 at 03:44:36PM +0300, Jarkko Sakkinen wrote:
> > > > > >On Tue, May 07, 2019 at 01:40:20PM -0400, Sasha Levin wrote:
> > > > > >> On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
> > > > > >> > From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
> > > > > >> >
> > > > > >> > Changes since v2:
> > > > > >> >
> > > > > >> > - Drop the devicetree bindings patch (we don't add any new
> > ones).
> > > > > >> > - More code cleanups based on Jason Gunthorpe's review.
> > > > > >> >
> > > > > >> > Sasha Levin (2):
> > > > > >> >  ftpm: firmware TPM running in TEE
> > > > > >> >  ftpm: add documentation for ftpm driver
> > > > > >>
> > > > > >> Ping? Does anyone have any objections to this?
> > > > > >
> > > > > >Sorry I've been on vacation week before last week and last week
> > > > > >I was extremely busy because I had been on vacation. This in
> > > > > >my TODO list. Will look into it tomorrow in detail.
> > > > > >
> > > > > >Apologies for the delay with this!
> > > > >
> > > > > Hi Jarkko,
> > > > >
> > > > > If there aren't any big objections to this, can we get it merged in?
> > > > > We'll be happy to address any comments that come up.
> > > >
> > > > I guess you have missed or ignored this comment [1]. Please address it.
> > > >
> > > > [1]
> > > >
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%
> > > >
> > 2Flkml%2F2019%2F5%2F8%2F11&amp;data=01%7C01%7Cthiruan%40microsoft.com%7Cf2a
> > > >
> > 80c7b94434329eaee08d6d8d962b1%7C72f988bf86f141af91ab2d7cd011db47%7C1&amp;sd
> > > > ata=hyJRc23NwEFLDuaIMkbSCGetd%2BObQWiAg%2BJtMMR6z9U%3D&amp;reserved=0
> > > >
> > > > -Sumit
> > >
> > > Thanks for reviewing and adding comments.
> > >
> > > We tried to use TEE bus framework you suggested for fTPM enumeration.
> > > We were not able to pass the TCG Logs collected by the boot loaders.
> > >
> > > Currently there are 3 ways to pass TCG Logs based on the code
> > > in drivers/char/tpm/eventlog:
> > >
> > > 1. ACPI Table
> > > 2. EFI Table
> > > 3. OF Device node properties
> > >
> > > Our ARM system is booting using U-boot and Device Tree.
> > > So ACPI/EFI table mechanism to pass TCG2 logs won't be applicable.
> > > We needed to use OF device node properties to pass TCG2 Logs.
> > > TEE bus enumeration framework does not work for our use case due to the
> > above.
> >
> > Firstly let me clarify that this framework is intended to communicate
> > with TEE based services/devices rather than boot loader. And in this
> > case fTPM being a TEE based service, so this framework should be used.
> >
> It does not work for our use case. We gave enough justification so far.
> TEE bus enumeration needs to be flexible to support our use case and
> more future use cases.
>

TEE based services are virtual devices which could be very well be
aware about the platform and device driver could easily query these
devices for platform specific properties. In case of firmware TPM as a
TEE based service, it could easily store the event logs generated
during PCR extend operations which could be fetched at runtime. But a
real TPM device doesn't possess that storage capability leading to
software managing these event logs.

> > >
> > > Is it possible to add flexibility in TEE bus enumeration framework to
> > support
> > > platform specific properties through OF nodes or ACPI?
> > >
> >
> > As you mentioned above, TCG logs are collected by boot loader. So it
> > should find a way to pass them to Linux.
> >
> > How about if boot loader register these TCG logs with fTPM TA which
> > could be fetched during fTPM driver probe or new api like
> > tpm_read_log_tee()?
>
> And then how does fTPM driver pass TCG Logs to the TPM framework?
> It requires changes to the upstream TPM framework to ask the driver
> explicitly for the TCG Logs.

My suggestion was to add 4th way to pass TCG logs as follows:

--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -95,6 +95,10 @@ static int tpm_read_log(struct tpm_chip *chip)
        if (rc != -ENODEV)
                return rc;

+       rc = tpm_read_log_tee(chip);
+       if (rc != -ENODEV)
+               return rc;
+
        return tpm_read_log_of(chip);
 }
--- /dev/null
+++ b/drivers/char/tpm/eventlog/tee.c
@@ -0,0 +1,43 @@
<snip>
+int tpm_read_log_tee(struct tpm_chip *chip)
+{
+       struct tpm_bios_log *log;
+       struct ftpm_tee_private *pvt_data;
+
+       log = &chip->log;
+       if (!strcmp(chip->dev.bus->name, tee_bus_type.name))
+               pvt_data = dev_get_drvdata(chip->dev.parent);
+       else
+               return -ENODEV;
+
+       // Here you could simply do an invoke command to fetch the TCG logs.
+
+       if (chip->flags & TPM_CHIP_FLAG_TPM2)
+               return EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+       return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+}

>
> Note that this also requires changes to the fTPM TA that has been existing for few years.
>

That's not a sane reason to avoid implementing generic stuff. As there
could be other fTPM implementations and specific DT nodes for each
which might not be maintainable. BTW, in current implementation also I
don't find DT bindings corresponding to DT node used in this
patch-set.

> Is it not possible to add flexibility in TEE bus enumeration framework to
> support platform specific properties through OF nodes or ACPI?
>

TEE bus framework was designed specifically to avoid OF nodes or ACPI
properties. As devices could be intelligent enough to be queried for
required properties.

> Devices enumerated by buses such as i2c can read platform specific properties.

i2c devices are real hardware which could be platform agnostic, so you
need to have platform specific properties.

-Sumit

> With this flexibility added, more future use cases through TEE bus.
>
>
> > This is something similar to what I used in
> > optee-rng [1] driver to fetch RNG properties.
> >
> > [1]
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.co
> > m%2Ftorvalds%2Flinux%2Fblob%2Fmaster%2Fdrivers%2Fchar%2Fhw_random%2Foptee-
> > rng.c%23L176&amp;data=02%7C01%7Cthiruan%40microsoft.com%7Cd37438eaf4f9483e4
> > 0c708d6d9ccfe0c%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63693587179549
> > 3006&amp;sdata=As9sC45Bl7sZdJKOq0sHz6GmXttMxS80Nn5yvN4vqng%3D&amp;reserved=
> > 0
> >
> > -Sumit
> >
> > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > > Sasha
