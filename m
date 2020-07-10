Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD321BCE7
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGJS0A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgGJSZ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 14:25:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D19C08C5DD
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 11:25:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f12so7097487eja.9
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxvJ+Fty4K+1j3Y1eh6Bkx0XaBM+d2fy42IQC4UlRuo=;
        b=NXWKXJ6GQCKHQi13Z7gjc88eeS0hvvz4tGk2iYMcV5QSgNUJNYTnmS7BTx0yqrNtsz
         SFUJc1wRLVwL2p3HNbsfUm1WbLedW+TT+PyxxvwRydpPFVDDdOKPgKD0UySUkBqJrz5O
         bQrGlYWFWDaiujnsTzPboDZpoTdVs7RiQSGNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxvJ+Fty4K+1j3Y1eh6Bkx0XaBM+d2fy42IQC4UlRuo=;
        b=Pij9yS35UmFuLrIfphKh3/706FV5+5YhE2XsZGED3WiwudGtI11kkq+7Yb3duL5ehl
         NT6bylPX5t+g0oBluS3joVX5HUP/yCXP3vHSKKETeXqWrrDidEjjQe0e49mCcMo+yY8S
         6g7d4Qti5Ag/nvu7M4B9oMPB2ZZVXMqNrbGCr1OloHyOjWbVLDMuDPpMEEQyeXbowoAl
         uuB1dx5nlQ/hL5BEewBqB6nKDJiVe5QNogXwF05Nb3eMMBGiaUIlPtl1Ag075vIzu/yO
         XS72Q1qzccdQ1IxLy7n/Ift2l5TtwflvAExnNjYtR1WiniS+gzUdomd5ogrZQZbl0xLY
         HUEw==
X-Gm-Message-State: AOAM530N64LuTwJZVNXDsiHJZFKxVw3OVFTw8iIekd5JIV2LSfnAergr
        Xg7gKUto1/WzCC88RPKjq/9PGGQK5NI=
X-Google-Smtp-Source: ABdhPJzfIIDstJBPEvID4kVKelIsRfMBlZ87hRle3hCoQzbfcDP2qOr8vqEUv3bxVdZESJQ8chancw==
X-Received: by 2002:a17:906:2988:: with SMTP id x8mr55827203eje.141.1594405557717;
        Fri, 10 Jul 2020 11:25:57 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id i2sm5106928edk.30.2020.07.10.11.25.56
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 11:25:56 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id p20so7076863ejd.13
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 11:25:56 -0700 (PDT)
X-Received: by 2002:a17:906:c04d:: with SMTP id bm13mr53490468ejb.321.1594405555807;
 Fri, 10 Jul 2020 11:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200710002209.6757-1-apronin@chromium.org> <20200710114000.GD2614@linux.intel.com>
In-Reply-To: <20200710114000.GD2614@linux.intel.com>
From:   Andrey Pronin <apronin@chromium.org>
Date:   Fri, 10 Jul 2020 11:25:44 -0700
X-Gmail-Original-Message-ID: <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
Message-ID: <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 10, 2020 at 4:40 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jul 09, 2020 at 05:22:09PM -0700, Andrey Pronin wrote:
> > This patch prevents NULL dereferencing when using chip->ops while
> > sending TPM2_Shutdown command if both tpm_class_shutdown handler and
> > tpm_del_char_device are called during system shutdown.
> >
> > Both these handlers set chip->ops to NULL but don't check if it's
> > already NULL when they are called before using it.
> >
> > This issue was revealed in Chrome OS after a recent set of changes
> > to the unregister order for spi controllers, such as:
> >   b4c6230bb0ba spi: Fix controller unregister order
> >   f40913d2dca1 spi: pxa2xx: Fix controller unregister order
> > and similar for other controllers.
>
> I'm not sure I fully understand the scenario. When does thi happen?

This happens during system shutdown.
Here a sample stack trace from the panic:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
...
Call Trace:
 tpm_transmit_cmd+0x21/0x7f
 tpm2_shutdown+0x84/0xc6
 tpm_chip_unregister+0xa2/0xb9
 cr50_spi_remove+0x19/0x26
 spi_drv_remove+0x2a/0x42
 device_release_driver_internal+0x123/0x1ec
 bus_remove_device+0xe8/0x111
 device_del+0x1bf/0x319
 ? spi_unregister_controller+0xfc/0xfc
 device_unregister+0x12/0x28
 __unregister+0xe/0x12
 device_for_each_child+0x79/0xb8
 spi_unregister_controller+0x27/0xfc
 pxa2xx_spi_remove+0x45/0xb4
 device_shutdown+0x181/0x1d3
 kernel_restart+0x12/0x56
 SyS_reboot+0x16a/0x1e7
 do_syscall_64+0x6b/0xf7
 entry_SYSCALL_64_after_hwframe+0x41/0xa6

> Why does not tpm_del_char_device need this?

"Not" is a typo in the sentence above, right? tpm_del_char_device *does*
need the fix. When tpm_class_shutdown is called it sets chip->ops to
NULL. If tpm_del_char_device is called after that, it doesn't check if
chip->ops is NULL (normal kernel API and char device API calls go
through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
call tpm2_shutdown(), which tries sending the command and dereferences
chip->ops.

> The changes listed tell
> me nothing. Why they have this effect?

"spi: pxa2xx: Fix controller unregister order" adds a spi_unregister_controller
call to pxa2xx_spi_remove, which internally calls tpm_del_char_device, which
results in the stack trace leading to the panic above.

>
> I'm just trying to understand whether this could be a regression or
> not.
>
> I neither understand what you mean by "and similar for other
> controllers."

There was a series of spi unregister order changes for various
spi controllers, including the following:
1c6221b430a0 spi: bcm2835: Fix controller unregister order
f40913d2dca1 spi: pxa2xx: Fix controller unregister order
b4c6230bb0ba spi: Fix controller unregister order
54000d2e15e9 spi: dw: Fix controller unregister order
c8f309db490e spi: bcm2835aux: Fix controller unregister order

>
> NAK for the reason that I don't understand what I'm merging.
>
> /Jarkko
>
> >
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 8c77e88012e9..a410ca40a3c5 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
> >       struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
> >
> >       down_write(&chip->ops_sem);
> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >               if (!tpm_chip_start(chip)) {
> >                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> >                       tpm_chip_stop(chip);
> > @@ -479,7 +479,7 @@ static void tpm_del_char_device(struct tpm_chip *chip)
> >
> >       /* Make the driver uncallable. */
> >       down_write(&chip->ops_sem);
> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >               if (!tpm_chip_start(chip)) {
> >                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> >                       tpm_chip_stop(chip);
> > --
> > 2.25.1
> >



-- 
Andrey
