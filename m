Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC945E192
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGCKD3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 06:03:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38544 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfGCKD2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 06:03:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so1340262lfa.5
        for <linux-integrity@vger.kernel.org>; Wed, 03 Jul 2019 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BieYfjEM2Jzy6tm0eGzkxdcdk7kSkZqMecgJYNDMGV0=;
        b=cG8ia6T7OSJ5BOL1ofr6Yg66FOfMfhI610OF3HU8QW3RUP4A/X2jPWhVUeZ85PwBj4
         ZmquHHnWL0GNgchXP1S9U2K6BVJ9pcnkaEIkUbxdIBOt5NNYriWSWPKi3WbhecXYVOH2
         ZmHRdorb89XdclWQ9Hrt2uS9CQHedIkTcZCEMckCv3M/Qyaa0NcXx8NSCGd7QbaO+6bW
         cRIpePtoyGfOYjpzzHM/U5mL+SyMWVmlOKf0UNDKW/ESVJRocMh+CRFqXG+nL3kQoMDv
         sefMYakUGTLZvoKRHziRK4GbgLIs2NMWTNu7U8JM+Bieg2yBD5fIFYNGI8GqGP2rJOfU
         bOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BieYfjEM2Jzy6tm0eGzkxdcdk7kSkZqMecgJYNDMGV0=;
        b=E4k8xGOeHDybKg4K+PBoOipt0S7LEIvQ6vSIJSLbMHt7OSPY1Tz13j3iKealnCda78
         ripX7645eqvjHimqluE+kEg7viyNSFb5/1aPVfMIMcXAQ0QGh/Lvth/idjdLGKeXAcK3
         ptefdZ+nT84XRV+EYrT/bZbR7is/rxhiMqaeVQRHzXiZQs2rcM0dVpoj47bHpFXVJsJV
         RbhPnqHVdDYKCeDlMvuTNZRCt4DUyPwPVsrgUL6KYqGrKmX2dR6Wis/jRfkPaiJiVD95
         DWmA8Ebtr5NFJZgtJOtzxT6evaACXYL0YjaNopab5uD1G1PDMi+PxmFheMYsxc2PUZkG
         7GUw==
X-Gm-Message-State: APjAAAVG3gNK/Hf0x61+9XFELQMHY3LWagtD3MmoJsxtruDkA4P7ShVe
        BjRLpCrK5V1WYgbFU40iztBVuCk9bu04eZw7jh3csoaGpr8=
X-Google-Smtp-Source: APXvYqzd5df7P2Ve5Dj0iF8FUI6E47apo8EuyFqbBlrStQnDxozwztwb/DIvjR31to5jsxl+7VSGjbnNr/cq9+NxdNA=
X-Received: by 2002:a05:6512:15a:: with SMTP id m26mr17277395lfo.71.1562148206208;
 Wed, 03 Jul 2019 03:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190625201341.15865-1-sashal@kernel.org> <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm> <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos> <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
 <20190702142109.GA32069@apalos> <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
 <20190703065813.GA12724@apalos> <CAC_iWjK2F13QxjuvqzqNLx00SiGz_FQ5X=MQxJyDev57bo3=LQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK2F13QxjuvqzqNLx00SiGz_FQ5X=MQxJyDev57bo3=LQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Jul 2019 15:33:14 +0530
Message-ID: <CAFA6WYMvd1BVGppYM230Bd1XjO11uU4WQf-F+ZtmtpasP4AjxQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Joakim Bech <joakim.bech@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 3 Jul 2019 at 13:42, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Thirupathaiah,
>
> (+Joakim)
>
> On Wed, 3 Jul 2019 at 09:58, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Thirupathaiah,
> > >
> > > First of all, Thanks a lot for trying to test the driver.
> > >
> > np
> >
> > [...]
> > > > I managed to do some quick testing in QEMU.
> > > > Everything works fine when i build this as a module (using IBM's TPM 2.0
> > > > TSS)
> > > >
> > > > - As module
> > > > # insmod /lib/modules/5.2.0-rc1/kernel/drivers/char/tpm/tpm_ftpm_tee.ko
> > > > # getrandom -by 8
> > > > randomBytes length 8
> > > > 23 b9 3d c3 90 13 d9 6b
> > > >
> > > > - Built-in
> > > > # dmesg | grep optee
> > > > ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session failed,
> > > > err=ffff0008
> > > This (0xffff0008) translates to TEE_ERROR_ITEM_NOT_FOUND.
> > >
> > > Where is fTPM TA located in the your test setup?
> > > Is it stitched into TEE binary as an EARLY_TA or
> > > Is it expected to be loaded during run-time with the help of user mode OP-TEE supplicant?
> > >
> > > My guess is that you are trying to load fTPM TA through user mode OP-TEE supplicant.
> > > Can you confirm?
> > I tried both
> >
>
> Ok apparently there was a failure with my built-in binary which i
> didn't notice. I did a full rebuilt and checked the elf this time :)
>
> Built as an earlyTA my error now is:
> ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session
> failed, err=ffff3024 (translates to TEE_ERROR_TARGET_DEAD)
> Since you tested it on real hardware i guess you tried both
> module/built-in. Which TEE version are you using?
>

> > > U-boot and Linux driver stacks work seamlessly without dependency on supplicant.

Is this true?

It looks like this fTPM driver can't work as a built-in driver. The
reason seems to be secure storage access required by OP-TEE fTPM TA
that is provided via OP-TEE supplicant that's not available during
kernel boot.

Snippet from ms-tpm-20-ref/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/fTPM.c +145:

    // If we fail to open fTPM storage we cannot continue.
    if (_plat__NVEnable(NULL) == 0) {
        TEE_Panic(TEE_ERROR_BAD_STATE);
    }

So it seems like this module will work as a loadable module only after
OP-TEE supplicant is up.

-Sumit

> Thanks
> /Ilias
