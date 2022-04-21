Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2B50A52F
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Apr 2022 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiDUQ1T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Apr 2022 12:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390500AbiDUQKY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Apr 2022 12:10:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9E647541
        for <linux-integrity@vger.kernel.org>; Thu, 21 Apr 2022 09:07:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p189so3485473wmp.3
        for <linux-integrity@vger.kernel.org>; Thu, 21 Apr 2022 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W/2Za70C1RHKqi8XDzjUDlZrNvCkjmOJSSy94nVWdeo=;
        b=V6zMP4bR03OtSHzQnhQ8C07/7liPhzxks7VIQDG9UyNJlBm3gL9cl4qycYdZpw/6/8
         gnRZzPoPbAm6EteTZIlMDohqau4tlXHabCZVBb8CNbV34fkBdNicaT8J7KVwITEkZ202
         MF+Jc+m5W5Nd6ChFOK7ImjudxfaZq5yp7KfW4iFKia9NQ2gtarCUKeCP1t3Ij7iJphyq
         bxp3IJ8k2nd9DtzjAWA/30ru4FTtDp8Cfli7RMLYwxFFZynSMhKH+hYRChs7nfdIceq7
         gc3SzrGQ7nDluILkLngZeZYVy8TBLepLx6mbM/bq0f9FBLKpE9t00Ah4un9atburVfsZ
         nBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W/2Za70C1RHKqi8XDzjUDlZrNvCkjmOJSSy94nVWdeo=;
        b=h1lTtdgEwT9fPcLdOa67UUQEhRvnP5/Udh8viA9KbrrFoA4UfuKBnaHJ+c9izFRfgC
         tk2sZU7T1ZENCm6BDspy3rP2sp/73zYuKgMdFL+uz+5vA+qqq+dwqfbr1aNodF+kuyGk
         5Ifk/mwFJ2K3iT+Cf2UUh4xf6Ma+/Sv/4Cko2wmaBx0usCaD18pQyirHOe4oU0QyFoTc
         xXyQzpENnLhDCaruYnWvFGkygn0/WaOYktPI98uFVS6UYKUEsAnrBbzJ2xI+/cMrKt/Z
         ZcpF7wrLybZfUIUvcU4EiL82dMZCnziD5RGkExHjOPdnosf6MgbV2b0NKiVYtJ72E2CB
         5Y3Q==
X-Gm-Message-State: AOAM530p3B1YifgmSNPb8L60p2ntSAZ9w9THJ2y7dXosX0TbWC6QA0IL
        Ajh1uWZCinmbLhRn4vE6qxPlVy1eUqxY5WByBuFakg==
X-Google-Smtp-Source: ABdhPJxqUYobkFKPsjnyNIvJy+aGvbRCq3IvWHSrRSfKqva8aaJVNAP6j8VnjdlZbx3EmrWdD1hpjE86W6KLq8k0p9U=
X-Received: by 2002:a05:600c:1990:b0:392:7119:b55d with SMTP id
 t16-20020a05600c199000b003927119b55dmr75078wmq.49.1650557252813; Thu, 21 Apr
 2022 09:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163749.1.Ica39bd8d1494f750a70a668e5929f6e5e63241f2@changeid>
 <c8f5ada2-c5cc-fe1b-bdeb-8b7d134250ee@molgen.mpg.de>
In-Reply-To: <c8f5ada2-c5cc-fe1b-bdeb-8b7d134250ee@molgen.mpg.de>
From:   Jes Klinke <jbk@google.com>
Date:   Thu, 21 Apr 2022 09:07:21 -0700
Message-ID: <CANMTAZRp5GPwrJNO4RY1KpvABgiuOMYEtwm+jdYfX5JRH8FpSA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: cr50: Add new device/vendor ID 0x504a6666
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Jes B. Klinke" <jbk@chromium.org>,
        linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Paul,

On Wed, Apr 20, 2022 at 3:52 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Jes,
>
>
> Am 20.04.22 um 01:37 schrieb Jes B. Klinke:
> > Accept one additional numerical value of DID:VID for next generation
> > Google TPM with new firmware, to be used in future Chromebooks.
> >
> > The TPM with the new firmware has the code name TI50, and is going to
> > use the same interfaces.
> >
> > Signed-off-by: Jes B. Klinke <jbk@chromium.org>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >
> >   drivers/char/tpm/tpm_tis_i2c_cr50.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm=
_tis_i2c_cr50.c
> > index f6c0affbb4567..4ddb8ff3a8569 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > @@ -31,6 +31,7 @@
> >   #define TPM_CR50_TIMEOUT_SHORT_MS   2               /* Short timeout =
during transactions */
> >   #define TPM_CR50_TIMEOUT_NOIRQ_MS   20              /* Timeout for TP=
M ready without IRQ */
> >   #define TPM_CR50_I2C_DID_VID                0x00281ae0L     /* Device=
 and vendor ID reg value */
> > +#define TPM_TI50_I2C_DID_VID         0x504a6666L     /* Device and ven=
dor ID reg value */
> >   #define TPM_CR50_I2C_MAX_RETRIES    3               /* Max retries du=
e to I2C errors */
> >   #define TPM_CR50_I2C_RETRY_DELAY_LO 55              /* Min usecs betw=
een retries on I2C */
> >   #define TPM_CR50_I2C_RETRY_DELAY_HI 65              /* Max usecs betw=
een retries on I2C */
> > @@ -742,15 +743,15 @@ static int tpm_cr50_i2c_probe(struct i2c_client *=
client)
> >       }
> >
> >       vendor =3D le32_to_cpup((__le32 *)buf);
> > -     if (vendor !=3D TPM_CR50_I2C_DID_VID) {
> > +     if (vendor !=3D TPM_CR50_I2C_DID_VID && vendor !=3D TPM_TI50_I2C_=
DID_VID) {
> >               dev_err(dev, "Vendor ID did not match! ID was %08x\n", ve=
ndor);
> >               tpm_cr50_release_locality(chip, true);
> >               return -ENODEV;
> >       }
> >
> > -     dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > +     dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > +              vendor =3D=3D TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
> >                client->addr, client->irq, vendor >> 16);
> > -
>
> Remove this blank line wasn=E2=80=99t needed, I gues.

You are right, I should probably have left the blank line untouched.
It does not hurt the readability of the code much to remove it,
though.

> >       return tpm_chip_register(chip);
> >   }
> >
>
> Thank for addressing the other comments, and congratulations on getting
> your first commit into the Linux kernel.

When I think about it, I did propose a kernel patch in 2002, to
introduce /proc/sys/kernel/core_pattern, so this is my second patch.
All the mailing lists, and formal review process this time seemed
daunting at first, though, so thank you for guiding me through the
process.

Regards
Jes
