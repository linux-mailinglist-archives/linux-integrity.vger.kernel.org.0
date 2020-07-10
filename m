Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1621BE8A
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 22:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGJUeo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 16:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGJUeo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 16:34:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA756C08C5DD
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 13:34:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so5641797edy.1
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/SBX7F0TUuVX6qnc8J+wosE+QUcqZiPheTHOsrFz+o=;
        b=cSghd0A1bHl6W8BQItpavDDiPVX9ofld8ObVhrg13LiaUthO66J/KJplp2qR3dzsMZ
         /u7c/45w7w7s73JYiydlitSF//6ydNly6eZdccTZaDdszRaimsFMYdgyAlOZ35xoLVDm
         R61ZzHcKOAH1/n39wljQZh0t5jNcRo4QhhJhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/SBX7F0TUuVX6qnc8J+wosE+QUcqZiPheTHOsrFz+o=;
        b=NmbepSWB4HpCT/ru4Kq49pIgljvDB/hqwVTFCPnn0TP/1tIKfWjj6F8BP80XHqsWx9
         Ake68fuOjBzZnl0uoHXPfqWQlNDxfJxhSwN2jKCf+XduLW9oMRMF9XvI5z5ji8PrjBi+
         0KZE2Gk5tqMKzDefd6rNravM2/QlT0lSCU6RZ/lDJaIeB8HpR9MCW+BpTELOc1mfeC9u
         t6ZFaXudZW2IwCDVKdzD7MhO+n+8DSxkf3thZnVuSPA2Q2P5LF9o9AFtIy+IZej7/DaA
         lUzN0ZN0ZWntyjUaE+alTW1x0iK7lo0GG8DGIJhTymPvC53t2GbXpazN6OfL1aFdSY9r
         AvQg==
X-Gm-Message-State: AOAM532EVNLKmIq6OZ0YjEjuABv0IPvbi4qvBgUkOCuRX3J1883eanw+
        5JWUQzSl46jazPS3ldMnifohVkXFJNE=
X-Google-Smtp-Source: ABdhPJyR8K+tdRsjVLEizaeDZSTrRwS0Tz1lW4N39xoZVtVoZeUTDK7aiF0auo6ROe93UaooYQeYhQ==
X-Received: by 2002:a50:f9c9:: with SMTP id a9mr82781701edq.89.1594413282118;
        Fri, 10 Jul 2020 13:34:42 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id t21sm4224925ejr.68.2020.07.10.13.34.40
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 13:34:41 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id lx13so7428257ejb.4
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 13:34:40 -0700 (PDT)
X-Received: by 2002:a17:906:7005:: with SMTP id n5mr43500276ejj.130.1594413280262;
 Fri, 10 Jul 2020 13:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200710002209.6757-1-apronin@chromium.org> <1594408113.4494.16.camel@HansenPartnership.com>
In-Reply-To: <1594408113.4494.16.camel@HansenPartnership.com>
From:   Andrey Pronin <apronin@chromium.org>
Date:   Fri, 10 Jul 2020 13:34:28 -0700
X-Gmail-Original-Message-ID: <CAP7wa8+0Bkbm-QCW=xwJ7auZ18Bj1jJev9LcMxuA=i=6ZfT9yA@mail.gmail.com>
Message-ID: <CAP7wa8+0Bkbm-QCW=xwJ7auZ18Bj1jJev9LcMxuA=i=6ZfT9yA@mail.gmail.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 10, 2020 at 12:08 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2020-07-09 at 17:22 -0700, Andrey Pronin wrote:
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
> >
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-
> > chip.c
> > index 8c77e88012e9..a410ca40a3c5 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
> >       struct tpm_chip *chip = container_of(dev, struct tpm_chip,
> > dev);
> >
> >       down_write(&chip->ops_sem);
> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >               if (!tpm_chip_start(chip)) {
> >                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> >                       tpm_chip_stop(chip);
> > @@ -479,7 +479,7 @@ static void tpm_del_char_device(struct tpm_chip
> > *chip)
> >
> >       /* Make the driver uncallable. */
> >       down_write(&chip->ops_sem);
> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >               if (!tpm_chip_start(chip)) {
> >                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> >                       tpm_chip_stop(chip);
>
> I really don't think this is the right fix.  The problem is that these
> two functions are trying to open code tpm_try_get_ops/tpm_put_ops (only
> really for the tpm2 shutdown) because they want to NULL out the ops
> before final mutex unlock.  The problem with the current open coding is
> it doesn't shut down the clock if required (not really a problem for
> shutdown, but might cause issues for simple rmmod).  I think this is
> because no-one noticed the open coding when get/put was updated.
>
> This code should all be abstracted into a single function and shared
> with tpm_try_get_ops/tpm_put_ops so we can't have this happen in
> future.  Possibly there should be a chip shutdown function which is
> only active for TPM2 which does the correct try_get/shutdown/put
> operation and then a separate simple get mutex, null ops, put mutex one
> that's guaranteed to be called last.

Yes, went for a minimal patch here to stop kernel panics, didn't try to
refactor. Note that we do hold chip->ops_sem in both cases, and it's a
write-lock, not a read-lock (as tpm_try_get_ops uses) since we are
changing chip->ops. Thanks to this write-lock there, shouldn't be parallel
operations that use chip->ops (so not locking chip->tpm_mutex shouldn't
affect it).

So, if I understand the idea right, can refactor to something like:
1) extract common code between tpm_del_char_device and
tpm_class_shutdown into a shared method;
2) further extract the part between up/down(chip->ops_sem) to be
re-used between tpm_try_get_ops/tpm_put_ops and this flow;
3) still have down_write/up_write in this flow vs
get/put_device + down_read/up_read in tpm_try_get_ops case.

Please let me know if that's a bad idea.

Will be unavailable next week, but will continue after that.

>
> James
>


-- 
Andrey
