Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF956A662A
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 11:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfICJ7i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 05:59:38 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34107 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICJ7h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 05:59:37 -0400
Received: by mail-yw1-f66.google.com with SMTP id n126so5590168ywf.1;
        Tue, 03 Sep 2019 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6GJPfaZ/qFHUB6hWCAnPc1AvXnKbZ0hV6EedVYWQIY=;
        b=n6Wbb2T3OrHkOEgq1uG8OOlWUlKZxqrTTzNvvhQAaV19eOgKK9UnG8PAeWSuG3eUbM
         0uuahhp2XIVotI1WRCbiSh26qBrQTMvWx70uI1ryExcLni++qJvC216PDP21PnZ5iMXo
         UvCt3vGgjM0C+tmNo0IH2F+XBvRWDCCru6p0vgk68ZEzn4IKRfRsOuJwb3zy9+B9f3Bk
         mkhr6mn878OUdqx9h2fdFMIX7tPczzHIpQCrnMVY4cB6WPPAefMSSEgX3nmpc52EYXkh
         /E8JOXkoFSfUrX/zCu3KTbZ1X2Nn5c6eHmR+WhD6wXpY5XUc7jlao2ysd685fO/3c+Ei
         ekhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6GJPfaZ/qFHUB6hWCAnPc1AvXnKbZ0hV6EedVYWQIY=;
        b=dnn3pur/aa4pOLmcfrukAZiBf6rt+9gHXJuYOBEV4IYiDBey3ObNFcQ2tFDtrwuR95
         9pM1K/t6HPylein62WRuS25RnjUVY2CXgg+3ThuptMA+w2YmEIdXekKoJb8E0Kflb9oe
         CF5rSflLvTzJg/Oveoa0XFWAVz/MXIekL1IxyQAqr3PVUykPPiZ4PlVDgyb8BJdnyYNN
         rt2C8jRLOnf0WR8KH6SV3Oieij2+LBMuwEwMMsStbu5aTz3q6lrpu4f5U+fYhRv+pEeS
         VWRJiFm2fAbFXQZrdF3qsmfz6m4AFat8KVVBDOJw8kgwiy61NGNzOEhJ5cUH4W2zK+XR
         mbmA==
X-Gm-Message-State: APjAAAX3OwrszErphVQpn5/yxCuE6GwebVMu+WyuQ93YplpS6m4KuGYL
        aFldBmwkNcOssGuA4OFx3RVClUJTCRjHcikVAUo=
X-Google-Smtp-Source: APXvYqwzrafoKUXBaLnc2t75LcAVLHZwei0kNqZcFQbKY0COGotVWTmsOurD2E7nOR2WtZyCFLryEthGjUsfiAarOHo=
X-Received: by 2002:a81:c1:: with SMTP id 184mr15436891ywa.175.1567504776447;
 Tue, 03 Sep 2019 02:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190830095639.4562-1-kkamagui@gmail.com> <20190830095639.4562-3-kkamagui@gmail.com>
 <20190830124334.GA10004@ziepe.ca> <CAHjaAcQ0MrPCZUit7s0Rmqpwpp0w5jiYjNUNEEm2yc1AejZ3ng@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CC59@ALPMBAPA12.e2k.ad.ge.com>
 <CAHjaAcQu3jOSj0QV3u4GSgnhpkTmJTMqckY_cnuzeTY-HNUWcA@mail.gmail.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035F1CD06@ALPMBAPA12.e2k.ad.ge.com> <CAHjaAcRPg9-9MXiLH7AfJO6P1k25CSwJrSiuUwzFLwN5Ynr0DQ@mail.gmail.com>
In-Reply-To: <CAHjaAcRPg9-9MXiLH7AfJO6P1k25CSwJrSiuUwzFLwN5Ynr0DQ@mail.gmail.com>
From:   Seunghun Han <kkamagui@gmail.com>
Date:   Tue, 3 Sep 2019 18:59:25 +0900
Message-ID: <CAHjaAcSq5+o2_yawwUOhvi0NYWLOcsEP0uA6SKuCeznTsVaRSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for
 supporting AMD's fTPM
To:     "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

>
> > From: Seunghun Han <kkamagui@gmail.com>
> > Sent: Friday, August 30, 2019 12:55 PM
> > To: Safford, David (GE Global Research, US) <david.safford@ge.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>; Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com>; Peter Huewe <peterhuewe@gmx.de>;
> > open list:TPM DEVICE DRIVER <linux-integrity@vger.kernel.org>; Linux
> > Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: EXT: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping
> > mechanism for supporting AMD's fTPM
> >
> > >
> > > > From: linux-integrity-owner@vger.kernel.org <linux-integrity-
> > > > owner@vger.kernel.org> On Behalf Of Seunghun Han
> > > > Sent: Friday, August 30, 2019 9:55 AM
> > > > To: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Peter Huewe
> > > > <peterhuewe@gmx.de>; open list:TPM DEVICE DRIVER <linux-
> > > > integrity@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > > kernel@vger.kernel.org>
> > > > Subject: EXT: Re: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping
> > > > mechanism for supporting AMD's fTPM
> > > >
> > > > >
> > > > > On Fri, Aug 30, 2019 at 06:56:39PM +0900, Seunghun Han wrote:
> > > > > > I got an AMD system which had a Ryzen Threadripper 1950X and MSI
> > > > > > mainboard, and I had a problem with AMD's fTPM. My machine
> > > > > > showed
> > > > an
> > > > > > error message below, and the fTPM didn't work because of it.
> > > > > >
> > > > > > [  5.732084] tpm_crb MSFT0101:00: can't request region for resource
> > > > > >              [mem 0x79b4f000-0x79b4ffff] [  5.732089] tpm_crb:
> > > > > > probe of MSFT0101:00 failed with error -16
> > > > > >
> > > > > > When I saw the iomem, I found two fTPM regions were in the ACPI
> > > > > > NVS
> > > > area.
> > > > > > The regions are below.
> > > > > >
> > > > > > 79a39000-79b6afff : ACPI Non-volatile Storage
> > > > > >   79b4b000-79b4bfff : MSFT0101:00
> > > > > >   79b4f000-79b4ffff : MSFT0101:00
> > > > > >
> > > > > > After analyzing this issue, I found that crb_map_io() function
> > > > > > called
> > > > > > devm_ioremap_resource() and it failed. The ACPI NVS didn't allow
> > > > > > the TPM CRB driver to assign a resource in it because a busy bit
> > > > > > was set to the ACPI NVS area.
> > > > > >
> > > > > > To support AMD's fTPM, I added a function to check intersects
> > > > > > between the TPM region and ACPI NVS before it mapped the region.
> > > > > > If some intersects are detected, the function just calls
> > > > > > devm_ioremap() for a workaround. If there is no intersect, it
> > > > > > calls
> > > > devm_ioremap_resource().
> > > > > >
> > > > > > Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> > > > > > ---
> > > > > >  drivers/char/tpm/tpm_crb.c | 25 +++++++++++++++++++++++--
> > > > > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > > > >
> > > > > This still seems to result in two drivers controlling the same memory.
> > > > > Does this create bugs and races during resume?
> > > > >
> > > > > Jason
> > > >
> > > > When I tested this patch in my machine, it seemed that ACPI NVS was
> > > > saved after TPM CRB driver sent "TPM2_Shutdown(STATE)" to the fTPM
> > > > while suspending. Then, ACPI NVS was restored while resuming.
> > > > After resuming, PCRs didn't change and TPM2 tools such as
> > > > tpm2_pcrlist, tpm2_extend, tpm2_getrandoms worked well.
> > > > So, according to my test result, it seems that the patch doesn't
> > > > create bugs and race during resume.
> > > >
> > > > Seunghun
> > >
> > > This was discussed earlier on the list.
> > > The consensus was that, while safe now, this would be fragile, and
> > > subject to unexpected changes in ACPI/NVS, and we really need to tell
> > > NVS to exclude the regions for long term safety.
> >
> > Thank you for your advice. We also discussed earlier and concluded that
> > checking and raw remapping are enough to work around this. The link is
> > here, https://lkml.org/lkml/2019/8/29/962 .
>
> I don't see Matthew Garrett's agreement on that thread.

Thank you for your notification. I am sorry. I missed it and
misunderstood Jarkko's idea. So, I would like to invite Matthew
Garrett to this thread and attach my opinion on that. The problem is
that command and response buffers are in ACPI NVS area. ACPI NVS area
is saved and restored by drivers/acpi/nvs.c during hibernation, so
command and response buffers in ACPI NVS are also handled by nvs.c
file. However, TPM CRB driver uses the buffers to control a TPM
device, therefore, something may break.

I agree on that point. To remove uncertainty and find the solution,
I read the threads we discussed and did research about two points, 1)
the race condition and 2) the unexpected behavior of the TPM device.

1) The race condition concern comes from unknowing buffer access order
while hibernation.
If nvs.c and TPM CRB driver access the buffers concurrently, the race
condition occurs. Then, we can't know the contents of the buffers
deterministically, and it may occur the failure of TPM device.
However, hibernation_snapshot() function calls dpm_suspend() and
suspend_nvs_save() in order when the system enters into hibernation.
It also calls suspend_nvs_restore() and dpm_resume() in order when the
system exits from hibernation. So, no race condition occurs while
hibernation, and we always guarantee the contents of buffers as we
expect.

2) The unexpected behavior of the TPM device.
If nvs.c saves and restores the contents of the TPM CRB buffers while
hibernation, it may occur the unexpected behavior of the TPM device
because the buffers are used to control the TPM device. When the
system entered into hibernation, suspend_nvs_save() saved the command
and response buffers, and they had the last command and response data.
After exiting from hibernation, suspend_nvs_restore() restored the
last command and response data into the buffers and nothing happened.
I realized that they were just buffers. If we want to send a command
to the TPM device, we have to set the CRB_START_INVOKE bit to a
control_start register of a control area. The control area was not in
the ACPI NVS area, so it was not affected by nvs.c file. We can
guarantee the behavior of the TPM device.

Because of these two reasons, I agreed on Jarkko's idea in
https://lkml.org/lkml/2019/8/29/962 . It seems that removing or
changing regions described in the ACPI table is not natural after
setup. In my view, saving and restoring buffers was OK like other NVS
areas were expected because the buffers were in ACPI NVS area.

So, I made and sent this patch series. I would like to solve this
AMD's fTPM problem because I have been doing research on TPM and this
problem is critical for me (as you know fTPM doesn't work). If you
have any other concern or advice on the patch I made, please let me
know.

>
> > > As separate issues, the patches do not work at all on some of my AMD
> > systems.
> > > First, you only force the remap if the overlap is with NVS, but I have
> > > systems where the overlap is with other reserved regions. You should
> > > force the remap regardless, but if it is NVS, grab the space back from NVS.
> >
> > I didn't know about that. I just found the case from your thread that AMD
> > system assigned TPM region into the reserved area. However, as I know, the
> > reserved area has no busy bit so that TPM CRB driver could assign buffer
> > resources in it. Right? In my view, if you patched your TPM driver with my
> > patch series, then it could work. Would you explain what happened in TPM
> > CRB driver and reserved area?
>
> Good question. I'll try it out this weekend.

Thank you for your help.

>
> > > Second, the patch extends the wrong behavior of the current driver to
> > > both buffer regions. If there is a conflict between what the device's
> > > control register says, and what ACPI says, the existing driver explicitly
> > "trusts the ACPI".
> > > This is just wrong. The actual device will use the areas as defined by
> > > its control registers regardless of what ACPI says. I talked to
> > > Microsoft, and their driver trusts the control register values, and
> > > doesn't even look at the ACPI values.
> >
> > As you know, the original code trusts the ACPI table because of the
> > workaround for broken BIOS, and this code has worked well for a long time.
> > In my view, if we change this code to trust control register value, we could
> > make new problems and need a lot of time to check the workaround. So, I
> > want to trust the ACPI value now.
>
> I don't think the workaround has every really worked, other than the
> Helpful firmware error it emits.  I don't think anyone has tested the
> workaround with large requests. The tpm_crb device itself is telling
> us the buffers it is using. Why are we ignoring that and trusting the
> known bad ACPI tables? Makes no sense to me.
>

Yes, you are right. However, crb_fixup_cmd_size() function have worked
for handling broken BIOS well. I meant if we changed the function to
trust control register, we may need to test all broken BIOS the
function covered. To solve AMD's fTPM case, supporting separated
command and response buffers was enough. If your concern is the buffer
size calculation and you would like to solve it, I would make another
patch after this one.

> > >
> > > In practice, I have tested several systems in which the device
> > > registers show The correct 4K buffers, but the driver instead trusts
> > > the ACPI values, which list just 1K buffers. 1K buffers will not work
> > > for large requests, and the device is going to read and write the 4K buffers
> > regardless.
> > >
> > > dave
> >
> > I know about that. However, the device driver is not going to read and write
> > 4K buffers if you patch your TPM driver with my patch series.
> > One of my patches has an enhancement feature that could calculate the
> > buffer size well. The TPM driver uses exactly 1K buffer for this case, not 4K
> > buffer, and it works.
>
> Have you tested large requests (well over 1K) to make sure?

First of all, I misunderstood your message.
I have to tell you about the buffer size exactly. The command and
response buffer sizes in ACPI table were 0x1000 and this was 4K, not
1K. The sizes in the control register were 0x4000 and this was 16K
(large buffer size), not 4K.
I have been using the TPM for my research and the typical cases like
creating public/private keys, encrypting/decrypting data,
sealing/unsealing a secrete, and getting random numbers are not over
4K buffer. So, as you know, I think the 4K buffer can handle the most
cases and the current implementation of crb_fixup_cmd_size() works
well. If you concern the specific case that uses over 4K buffer,
please let me know.

If you have more ideas and advice on this patch, please let me know. I
will improve my patch.

Seunghun

>
> dave
> >
> > Seunghun
