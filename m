Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16B69C300
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2019 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfHYLZ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Aug 2019 07:25:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36701 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYLZ2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Aug 2019 07:25:28 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so30604456iom.3;
        Sun, 25 Aug 2019 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIuyrG3/dTHyGA/J/KYequizhWcmMaNv8m8PYDwNWI4=;
        b=fcwCzLr2Oyfngu50pqfzqF552F9pwU+iIcIoIWSJsaPcfRHw8O8jyLeg2+7vfTS83w
         KmgvC13akzfojk5+E0580ibiUQjf6MPrnGYkfWDrOBCeoPfetof7RBu8DjfRF46e4exl
         7abMklO7B5s77Z9U/PKq+XBfZ6mGM8WT7czVVkGGdSmEA/3W3xeDwACrNib1KRRdNRzL
         TB242cenbOrZh7WNmWSusSMO+bYgzVFULlGlAxjpSGL5lPPuWMMWCC7c8U4Un1fEq70Z
         fh3ROfj6+5IsWiiFsGDpFAfsoOycVT8MM1cNkTtkoPmdy/2r0pXKn/WBQ10R7b5RmCE2
         WsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIuyrG3/dTHyGA/J/KYequizhWcmMaNv8m8PYDwNWI4=;
        b=kFYOt1zv/3Tz7HJpjW6X++fNne43iU1W9VwKa5NzDxKmkglcCsHFybH3Hy/Tli6elY
         SWxXCniMSv0sFN/j4S/e/oVi56PV/8dCTfiCPSgbtbce5xDzdproe08Hy1SrG5q6vuBj
         eIGaodhXzyS9FysyGi098FZEH5NV+j3/uHxgnNBeOGNZztZTYbpjA+2i1n+oINjzzwDG
         KxAb/Wo3PhHHrDjD3ITG2ZlnwnHf+vIuliHorzobAhho3hV6Tjt+TmbHCqjNE6orNZdy
         dbWSHqxpLlp26GyDjmejOSjrbXxuuGiSQlUz7W/2bSAkhf7UfJOEPMBOpMDDGMNGBnLd
         PiTA==
X-Gm-Message-State: APjAAAVb5RWHTeNuY7aEswLu+yhBIH3aQh+tKSQAOTfObJV5anB/Gc+b
        rfg3Yc7+SGah5ho+osPgq4fqUn878RHeueAGrG8=
X-Google-Smtp-Source: APXvYqwvEo+Td14aRT0PjhhgoTej9aKxEX7xld6WL/Ul4aBPePGWEZJs4Djx1s/U1N1jbPjwJwC4Ez25O/btr4FOww4=
X-Received: by 2002:a6b:5d0d:: with SMTP id r13mr1365601iob.89.1566732326980;
 Sun, 25 Aug 2019 04:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
 <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com> <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
 <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
 <6e7ff1b958d84f6e8e585fd3273ef295@NTILML02.nuvoton.com> <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
 <20190715094541.zjqxainggjuvjxd2@linux.intel.com> <9c8e216dbc4f43dbaa1701dc166b05e0@NTILML02.nuvoton.com>
 <548d3727-4a8f-38d4-2193-8a09cbae1e64@infineon.com> <CAM9mBwL=5+pGTYUKbSdw5F6soR=tW-cqfbEQ9_NmCQTO=fSVZQ@mail.gmail.com>
 <528c9364-f4f4-d7c1-5e58-6ba6b8e90a6c@infineon.com>
In-Reply-To: <528c9364-f4f4-d7c1-5e58-6ba6b8e90a6c@infineon.com>
From:   Oshri Alkobi <oshrialkoby85@gmail.com>
Date:   Sun, 25 Aug 2019 14:25:17 +0300
Message-ID: <CAM9mBw+bz4OLoaWqJVs-+O0Wuovcx9bbj+PJWMHq_60WNbgTCg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Eyal.Cohen@nuvoton.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        tmaimon77@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, oshri.alkoby@nuvoton.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        amir.mizinski@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 16, 2019 at 7:12 PM Alexander Steffen
<Alexander.Steffen@infineon.com> wrote:
>
> On 15.08.2019 19:03, Oshri Alkobi wrote:
> > On Thu, Jul 18, 2019 at 8:10 PM Alexander Steffen
> > <Alexander.Steffen@infineon.com> wrote:
> >>
> >> On 18.07.2019 14:51, Eyal.Cohen@nuvoton.com wrote:
> >>> Hi Jarkko and Alexander,
> >>>
> >>> We have made an additional code review on the TPM TIS core driver, it looks quite good and we can connect our new I2C driver to this layer.
> >>
> >> Great :) In the meantime, I've done some experiments creating an I2C
> >> driver based on tpm_tis_core, see
> >> https://patchwork.kernel.org/patch/11049363/ Please have a look at that
> >> and provide your feedback (and/or use it as a basis for further
> >> implementations).
> >>
> >
> > Sorry for the late response.
> >
> > Thanks Alexander, indeed it looks much simpler.
> > I've checked it with Nuvoton's TPM - basic TPM commands work
>
> Nice :)
>
> > I only
> > had to remove the first msg from the read/write I2C transmitting
> > (from/to TPM_LOC_SEL), the TPM couldn't handle two register writes in
> > a sequence.
> > Actually it is more efficient to set TPM_LOC_SEL only before locality
> > check/request/relinquish - it is sticky.
>
> There is one problem though: Do we assume that only the kernel driver
> will communicate with the TPM or might there be something else that also
> talks to the TPM?
>
> If it is only the kernel driver, we could probably skip setting
> TPM_LOC_SEL at all, since it defaults to 0 and the driver will never use
> anything else. If something else does its own I2C communication with the
> TPM, it might write different values to TPM_LOC_SEL at any time, causing
> the kernel driver to use a different locality than intended. This was
> the reason I always set TPM_LOC_SEL within the same transaction.
>
> > I still didn't manage to work with interrupts, will debug it.
>
> Interrupt support might be broken in general at the moment, see this
> thread: https://www.spinics.net/lists/linux-integrity/msg08663.html
>
> > We weren't aware to the implementation of Christophe/ST which looks
> > good and can be complement to yours.
> > If no one is currently working on that, we can prepare a new patch
> > that is based on both.
> > Please let us know.
>
> I won't have the time to do anything, at least for the next two weeks,
> so feel free to pick it up.
>

Great, we will start working on it.

> >>> However, there are several differences between the SPI interface and the I2C interface that will require changes to the TIS core.
> >>> At a minimum we thought of:
> >>> 1. Handling TPM Localities in I2C is different
> >>
> >> It turned out not to be that different in the end, see the code
> >> mentioned above and my comment here:
> >> https://patchwork.kernel.org/cover/11049365/
> >>
> >>> 2. Handling I2C CRC - relevant only to I2C bus hence not supported today by TIS core
> >>
> >> That is completely optional, so there is no need to implement it in the
> >> beginning. Also, do you expect a huge benefit from that functionality?
> >> Are bit flips that much more likely on I2C compared to SPI, which has no
> >> CRC at all, but still works fine?
> >>
> >
> > I2C is noisy bus with potentially more devices with larger variety
> > than SPI. I2C may have more than one master and may have collisions
> > and/or arbitration.
>
> If multi-master usage is a concern, there are probably a lot more places
> in the driver that need to be adapted to deal with concurrent
> access/data corruption. For now, I'd assume a single master, similar to SPI.
>
> Alexander

Oshri
