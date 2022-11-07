Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C261EF49
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 10:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKGJmG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 04:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiKGJmF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 04:42:05 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A713D3A
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 01:42:03 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 7so5553246ilg.11
        for <linux-integrity@vger.kernel.org>; Mon, 07 Nov 2022 01:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=68+kzzLzGiiUyS2HF6Xc9NopV2KTQspTIOHfoEm5As8=;
        b=IdDPU3OYS+UaP3QgP1909FRe1rND25sM9F545z7IASLM8j6BWJCfeVzkxev7aCBNsk
         /2xyI+1AY/S7afeZsVqZk8Kc0yLGvgtjWFN4+9vslBGRDscTafMF57JWzO3S006T5IDB
         cdBk31YyYZmNYTIKAGc90cv7FTIzLRG251KCLIAApnGkKJx8YowWmWjLBFLVBb6kqlzv
         LBoagTSPInNMztytqEZEBCyByoiwPf40RJ810oo6icMw8Qxi70jizG7ypzv6MxmTkBoI
         XS53JoEX1ZI+e5dyDfo1uip3k+3K9vLPs3NClerP9Qn02pDjgiVM3I0xcOuEq+u0+9fC
         439A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68+kzzLzGiiUyS2HF6Xc9NopV2KTQspTIOHfoEm5As8=;
        b=c6fIMsfZxMgmLbJ8M0GN8lxLa4nDB/uPBYT+081tk4eM0lzkycns60kFgDv6KH6c+8
         x3p5Mub/fLShhNRcQCBOHPF5HqPykk5+ce2ks+OFZOGxi0yt6hzay97sq05xOSjwxy0R
         WrLAr8I3ACU0UVfNHDWSRdAuH0U0Hva87s+TToT7jaMg/cChj7jc+kGeuCC/iBxUcWNj
         OTaXwDU6EXzxUNOh48SAFNjgsP1NOGEwFg1U0nbt1hpq/Dyu6ukxj+fjp/e2FgxD4FSo
         MPUC3okyrec4VdjlAmSmOZ+L44Ja4RHt0oD05I9ZSJp1ZWudmrIJUOdkZkZf3NwXDElP
         98nQ==
X-Gm-Message-State: ACrzQf2YpeMJ8YiBn+43nCnOCYl0yoy+AL1docdQNP12ZEbgDYOyzbTh
        HtpISs95mW/OOacz+ycGJpJkxFoP2Pys897dbt3Lhg==
X-Google-Smtp-Source: AMsMyM4gGOz03/D3XiHATIXQ1e/2c7wLmdrtZB0swcVP20oQhRLurrdvuvmZuNxNgEIUgzYBTu6MTS3em4tYvXQETpo=
X-Received: by 2002:a92:c7ce:0:b0:300:5bd1:265d with SMTP id
 g14-20020a92c7ce000000b003005bd1265dmr19682970ilk.261.1667814122720; Mon, 07
 Nov 2022 01:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20221103145450.1409273-1-jsd@semihalf.com> <20221103145450.1409273-3-jsd@semihalf.com>
 <Y2jNw5JymJ+upOaQ@kernel.org>
In-Reply-To: <Y2jNw5JymJ+upOaQ@kernel.org>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 7 Nov 2022 10:41:52 +0100
Message-ID: <CAOtMz3PcgK32GhUN=p3aHsHe3Obv2_P7UfCBnzUzd4GgNi_7Mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] char: tpm: cr50: Use generic request/relinquish
 locality ops
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Thu, Nov 03, 2022 at 03:54:49PM +0100, Jan Dabros wrote:
> > Instead of using static functions tpm_cr50_request_locality and
> > tpm_cr50_release_locality register callbacks from tpm class chip->ops
> > created for this purpose.
> >
> > Signed-off-by: Jan Dabros <jsd@semihalf.com>
>
> I get that architecturally using the standard callbacks is a good idea.
> Still, you should explicitly document the gain because the existing code
> is working and field tested.

ACK. I will mention here about the overall idea I have.

>
> > ---
> >  drivers/char/tpm/tpm_tis_i2c_cr50.c | 106 ++++++++++++++++++----------
> >  1 file changed, 70 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > index 77cea5b31c6e4..517d8410d7da0 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > @@ -17,6 +17,7 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/bug.h>
> >  #include <linux/completion.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> > @@ -35,6 +36,7 @@
> >  #define TPM_CR50_I2C_MAX_RETRIES     3               /* Max retries due to I2C errors */
> >  #define TPM_CR50_I2C_RETRY_DELAY_LO  55              /* Min usecs between retries on I2C */
> >  #define TPM_CR50_I2C_RETRY_DELAY_HI  65              /* Max usecs between retries on I2C */
> > +#define TPM_CR50_I2C_DEFAULT_LOC     0
> >
> >  #define TPM_I2C_ACCESS(l)    (0x0000 | ((l) << 4))
> >  #define TPM_I2C_STS(l)               (0x0001 | ((l) << 4))
> > @@ -286,20 +288,21 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
> >  }
> >
> >  /**
> > - * tpm_cr50_check_locality() - Verify TPM locality 0 is active.
> > + * tpm_cr50_check_locality() - Verify if required TPM locality is active.
> >   * @chip: A TPM chip.
> > + * @loc: Locality to be verified
> >   *
> >   * Return:
> >   * - 0:              Success.
> >   * - -errno: A POSIX error code.
> >   */
> > -static int tpm_cr50_check_locality(struct tpm_chip *chip)
> > +static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
> >  {
> >       u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
> >       u8 buf;
> >       int rc;
> >
> > -     rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> > +     rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
> >       if (rc < 0)
> >               return rc;
> >
> > @@ -312,48 +315,57 @@ static int tpm_cr50_check_locality(struct tpm_chip *chip)
> >  /**
> >   * tpm_cr50_release_locality() - Release TPM locality.
> >   * @chip:    A TPM chip.
> > - * @force:   Flag to force release if set.
> > + * @loc:     Locality to be released
> > + *
> > + * Return:
> > + * - 0:              Success.
> > + * - -errno: A POSIX error code.
> >   */
> > -static void tpm_cr50_release_locality(struct tpm_chip *chip, bool force)
> > +static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
> >  {
> >       u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
> > -     u8 addr = TPM_I2C_ACCESS(0);
> > +     u8 addr = TPM_I2C_ACCESS(loc);
> >       u8 buf;
> > +     int rc;
> >
> > -     if (tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf)) < 0)
> > -             return;
> > +     rc = tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf));
> > +     if (rc < 0)
> > +             return rc;
> >
> > -     if (force || (buf & mask) == mask) {
> > +     if ((buf & mask) == mask) {
> >               buf = TPM_ACCESS_ACTIVE_LOCALITY;
> > -             tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
> > +             rc = tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
> >       }
> > +
> > +     return rc;
> >  }
> >
> >  /**
> > - * tpm_cr50_request_locality() - Request TPM locality 0.
> > + * tpm_cr50_request_locality() - Request TPM locality.
> >   * @chip: A TPM chip.
> > + * @loc: Locality to be requested.
> >   *
> >   * Return:
> > - * - 0:              Success.
> > + * - loc:    Success.
> >   * - -errno: A POSIX error code.
> >   */
> > -static int tpm_cr50_request_locality(struct tpm_chip *chip)
> > +static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
> >  {
> >       u8 buf = TPM_ACCESS_REQUEST_USE;
> >       unsigned long stop;
> >       int rc;
> >
> > -     if (!tpm_cr50_check_locality(chip))
> > -             return 0;
> > +     if (!tpm_cr50_check_locality(chip, loc))
> > +             return loc;
> >
> > -     rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> > +     rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
> >       if (rc < 0)
> >               return rc;
> >
> >       stop = jiffies + chip->timeout_a;
> >       do {
> > -             if (!tpm_cr50_check_locality(chip))
> > -                     return 0;
> > +             if (!tpm_cr50_check_locality(chip, loc))
> > +                     return loc;
> >
> >               msleep(TPM_CR50_TIMEOUT_SHORT_MS);
> >       } while (time_before(jiffies, stop));
> > @@ -374,7 +386,12 @@ static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *chip)
> >  {
> >       u8 buf[4];
> >
> > -     if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
> > +     if (chip->locality < 0){
> > +             WARN_ONCE(1, "Incorrect tpm locality value\n");
>
> Never ever add WARN() for a success case. It can ultimately crash the whole
> system, if panic_on_warn is enabled.
>
> Since this is a success case, judging from the return value, at most you
> should use pr_info() here.

ACK.

Best Regards,
Jan
