Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29C42BAD5
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhJMIw3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhJMIw3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 04:52:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AB3C061570;
        Wed, 13 Oct 2021 01:50:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 21so1314244plo.13;
        Wed, 13 Oct 2021 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVoyHG+ByS3hT7ja8NsnDLzpvX2wB0s7/rnkdNO8Z8M=;
        b=Psg1yNCAb/W7O+NArm2at+GjICGvF6Km7EVAdr7MoqjAHsAytjWz75YYY1m8mz98sv
         BXe/bcOkwZ8tgFfeAobmkkytkJ9Xkik9FJIZAYDWmouESWp/gnPagELjdsI08ej/Jbhz
         XGB5JnRLasrRCtGpuvPjug516Gfd/W8EQaeRh9i4byKZthI4siCnu1nTzxAZNBDVn5yK
         REjsGa2e7G+/iX0JGQnBjYEFJfMx9ZO6Qq99bHKx7rNHA1CLOOWhcwiP02jZtXBo23xX
         lMf9DDoC4EMuS2VpTYiBT6eu/BGzk9sQmEajaQ4dXBjvjABa1zJezvzNjHB7t8UywAHq
         X0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVoyHG+ByS3hT7ja8NsnDLzpvX2wB0s7/rnkdNO8Z8M=;
        b=awck2bpeF2U6wuBg1XdrrzvQhbGVyy2F5FORLfZVMSTPBYwLuvvlv01O8sLJT2vQdt
         6jIhuUAX3yN1jtrJeUcnvdzKiDaPDZOJPqx+Av5fWt4zY38m3Otkr3AvPWBzbyQQz6Gc
         qf/hyxWABf2fhKwwMcVKRknlPob/491a/zikqakAjFtBplVikmrC5Q87vy3LZDzHWk3H
         Kfdh7AggWWKBHZ3swJxKxlJcxmLebrA2u34CM8jypW7lGnqr8XipPklyLJ/TUi1A67HC
         NUtD+eJ+nlNlURuDcJivJUGgU2pPJRQx4PAqkgXlv5ocC9FabtL3bkPS0FGQuqWzjXvG
         9Bhg==
X-Gm-Message-State: AOAM5304sGQof024z03wF02V54PaWfw/4t+HI1o29i8hwS2iG40x1VhS
        87/tLH3BfgngMdh+zSDwi8+tFmodPokqSl8e6Ec=
X-Google-Smtp-Source: ABdhPJwKzwpIZpekOL2Rr83/DEzkRGyBlgWm0a1CXsPZmrNjYGf+FePfNALYBcflnQ856W3DNtcGSK0NHsUfmbJHaeA=
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id
 p15-20020a170903248fb0290128d5ea18a7mr34959008plw.83.1634115025923; Wed, 13
 Oct 2021 01:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210914151032.216122-1-amirmizi6@gmail.com> <20210914151032.216122-2-amirmizi6@gmail.com>
 <d9082b1b4c2e358c97bbc815c1b06e1b05011b0e.camel@kernel.org>
In-Reply-To: <d9082b1b4c2e358c97bbc815c1b06e1b05011b0e.camel@kernel.org>
From:   Amir Mizinski <amirmizi6@gmail.com>
Date:   Wed, 13 Oct 2021 11:49:49 +0300
Message-ID: <CAMHTsUXt7F0uWTe7qJSi8YnT-8JcXYYrdzEwi7UhN5m9c4hzYQ@mail.gmail.com>
Subject: Re: [PATCH v15 1/6] tpm_tis: Fix expected bit handling and send all
 bytes in one shot without last byte in exception
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eyal.Cohen@nuvoton.com, Oshri Alkobi <oshrialkoby85@gmail.com>,
        Alexander Steffen <alexander.steffen@infineon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Benoit HOUYERE <benoit.houyere@st.com>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        IS20 Oshri Alkoby <oshri.alkoby@nuvoton.com>,
        Tomer Maimon <tmaimon77@gmail.com>, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, IS30 Dan Morav <Dan.Morav@nuvoton.com>,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Jarkko, apologies for the delay and thank you for your comments.
I'll answer your comments below.


On Tue, 14 Sept 2021 at 19:58, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, 2021-09-14 at 18:10 +0300, amirmizi6@gmail.com wrote:
> > From: Amir Mizinski <amirmizi6@gmail.com>
> >
> > Detected an incorrect implementation of the send command.
> > Currently, the driver polls the TPM_STS.stsValid field until TRUE; then it
> > reads TPM_STS register again to verify only that TPM_STS.expect field is
> > FALSE (i.e., it ignores TPM_STS.stsValid).
> > Since TPM_STS.stsValid represents the TPM_STS.expect validity, both fields
> > fields should be checked in the same TPM_STS register read value.
>
> This is missing description of what kind of error/consquence this caused.
> Perhaps you got something to the klog, or how did you find out about the
> issue? Since you have reproduced, please connect it to the reality.
>

We found out about this issue in a code review, and there's no
specific error i can reproduce.
The main problem here is that the current check is meaningless. Since
TPM_STS.stsValid represents only the validity of the other bits on
TPM_STS it makes no sense to check it on its own.
Maybe it's better if i'll add a fix tag in here?

> > Modify the signature of 'wait_for_tpm_stat()', add an additional
> > "mask_result" parameter to its call and rename it to
> > 'tpm_tis_wait_for_stat()' for better alignment with other naming.
> > 'tpm_tis_wait_for_stat()' is now polling the TPM_STS with a mask and waits
> > for the value in mask_result. Add the ability to check if certain TPM_STS
> > bits have been cleared.
>
> The commit description is probably out of sync (not only rename, there is no
> parameter called mask_result).
>
> It's also lacking description, how this new parameter is taken advantage of.
>
> E.g.
>
> "Use the new parameter to check that status TPM_STS_VALID is set,
>  in addition that TPM_STS_EXPECT is zeroed. This prevents a racy
>  checkk
>
Duly noted, ill fix this for next version.
>
> > In addition, the send command was changed to comply with
> > TCG_DesignPrinciples_TPM2p0Driver_vp24_pubrev.pdf as follows:
> > - send all command bytes in one loop
> > - remove special handling of the last byte
> >
> > Suggested-by: Benoit Houyere <benoit.houyere@st.com>
> > Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 68 +++++++++++++++--------------------------
> >  1 file changed, 25 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index 69579ef..7d5854b 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -44,9 +44,9 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
> >       return false;
> >  }
> >
> > -static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> > -             unsigned long timeout, wait_queue_head_t *queue,
> > -             bool check_cancel)
> > +static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, u8 stat,
> > +                              unsigned long timeout,
> > +                              wait_queue_head_t *queue, bool check_cancel)
>
> This naming is not too great, considering that there is already local variable
> called status.
>
i will change this to result. is that better?
>
> >  {
> >       unsigned long stop;
> >       long rc;
> > @@ -55,7 +55,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> >
> >       /* check current status */
> >       status = chip->ops->status(chip);
> > -     if ((status & mask) == mask)
> > +     if ((status & mask) == stat)
> >               return 0;
> >
> >       stop = jiffies + timeout;
> > @@ -83,7 +83,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> >                       usleep_range(TPM_TIMEOUT_USECS_MIN,
> >                                    TPM_TIMEOUT_USECS_MAX);
> >                       status = chip->ops->status(chip);
> > -                     if ((status & mask) == mask)
> > +                     if ((status & mask) == stat)
> >                               return 0;
> >               } while (time_before(jiffies, stop));
> >       }
> > @@ -260,9 +260,10 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
> >
> >       while (size < count) {
> >               rc = wait_for_tpm_stat(chip,
> > -                              TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> > -                              chip->timeout_c,
> > -                              &priv->read_queue, true);
> > +                                        TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> > +                                        TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> > +                                        chip->timeout_c, &priv->read_queue,
> > +                                        true);
> >               if (rc < 0)
> >                       return rc;
> >               burstcnt = get_burstcount(chip);
> > @@ -315,8 +316,9 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> >               goto out;
> >       }
> >
> > -     if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> > -                             &priv->int_queue, false) < 0) {
> > +     if (wait_for_tpm_stat(chip, TPM_STS_VALID, TPM_STS_VALID,
> > +                               chip->timeout_c, &priv->int_queue,
> > +                               false) < 0) {
> >               size = -ETIME;
> >               goto out;
> >       }
> > @@ -342,61 +344,40 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> >       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >       int rc, status, burstcnt;
> >       size_t count = 0;
> > -     bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
> >
> >       status = tpm_tis_status(chip);
> >       if ((status & TPM_STS_COMMAND_READY) == 0) {
> >               tpm_tis_ready(chip);
> > -             if (wait_for_tpm_stat
> > -                 (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> > -                  &priv->int_queue, false) < 0) {
> > +             if (wait_for_tpm_stat(chip, TPM_STS_COMMAND_READY,
> > +                                       TPM_STS_COMMAND_READY,
> > +                                       chip->timeout_b, &priv->int_queue,
> > +                                       false) < 0) {
> >                       rc = -ETIME;
> >                       goto out_err;
> >               }
> >       }
> >
> > -     while (count < len - 1) {
> > +     while (count < len) {
>
> This.
>
> >               burstcnt = get_burstcount(chip);
> >               if (burstcnt < 0) {
> >                       dev_err(&chip->dev, "Unable to read burstcount\n");
> >                       rc = burstcnt;
> >                       goto out_err;
> >               }
> > -             burstcnt = min_t(int, burstcnt, len - count - 1);
> > +             burstcnt = min_t(int, burstcnt, len - count);
>
> What are these two changes (loop condition and the right above change)?
>

These changes are related to unnecessary handling of the last byte,
this is described on the last paragraph of the commit message.

> >               rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
> >                                        burstcnt, buf + count);
> >               if (rc < 0)
> >                       goto out_err;
> >
> >               count += burstcnt;
> > -
> > -             if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> > -                                     &priv->int_queue, false) < 0) {
> > -                     rc = -ETIME;
> > -                     goto out_err;
> > -             }
> > -             status = tpm_tis_status(chip);
> > -             if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
> > -                     rc = -EIO;
> > -                     goto out_err;
> > -             }
> >       }
> > -
> > -     /* write last byte */
> > -     rc = tpm_tis_write8(priv, TPM_DATA_FIFO(priv->locality), buf[count]);
> > -     if (rc < 0)
> > -             goto out_err;
> > -
> > -     if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> > -                             &priv->int_queue, false) < 0) {
> > +     if (wait_for_tpm_stat(chip, TPM_STS_VALID | TPM_STS_DATA_EXPECT,
> > +                               TPM_STS_VALID, chip->timeout_a,
> > +                               &priv->int_queue, false) < 0) {
> >               rc = -ETIME;
> >               goto out_err;
> >       }
> > -     status = tpm_tis_status(chip);
> > -     if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
> > -             rc = -EIO;
> > -             goto out_err;
> > -     }
> >
> >       return 0;
> >
> > @@ -451,9 +432,10 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> >               ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> >
> >               dur = tpm_calc_ordinal_duration(chip, ordinal);
> > -             if (wait_for_tpm_stat
> > -                 (chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID, dur,
> > -                  &priv->read_queue, false) < 0) {
> > +             if (wait_for_tpm_stat(chip,
> > +                                       TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> > +                                       TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> > +                                       dur, &priv->read_queue, false) < 0) {
> >                       rc = -ETIME;
> >                       goto out_err;
> >               }
>
> /Jarkko
>
Thank you,
Amir Mizinski
