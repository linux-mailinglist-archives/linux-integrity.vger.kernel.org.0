Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E793D8C6B
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhG1LEy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 07:04:54 -0400
Received: from smtp2.axis.com ([195.60.68.18]:40611 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhG1LEy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 07:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1627470293;
  x=1659006293;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xAwcql3/jqc11a3K8vx0HFLQ+MboOeW719h4Q37llfI=;
  b=SiGxHhUc/mCVxGLUi71ApumMygMFMxevmWSJ5WavVzvE231AautbiPKM
   +TRjLZR6uZUb2GeFMruSMDNs7Pdn0B8A0/02akpuwG1YANEdBS7FzcjAm
   +tAfIA3V/ahKkSvUX8CUbvJC7Y8ytD6FYYK1/pK2mp4xZpKYYWgfHh8hs
   ZnXVTKAXbUoUQz3N4SI3JRjhVqXNxA+97iXlNiohPmpIb/zu5udJpW+Vb
   IXq8nUJEzUkcU+7MCLrBVrNDMV3AMBTUWs1qucNsuLMbMP5yWduUJvNMn
   hQOvDeLnXHlKF40COhDVL00td52mUfwfrY5C5TzK5T5wV8YENDAMLbTaG
   w==;
Subject: Re: [PATCH] tpm: Add Upgrade/Reduced mode support for TPM2 modules
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210719133717.18797-1-borysmn@axis.com>
 <20210727025828.giynspbcz7zdmosa@kernel.org>
From:   Borys Movchan <borysmn@axis.com>
Message-ID: <7f67f4ec-5d68-5134-6529-93eaf3921571@axis.com>
Date:   Wed, 28 Jul 2021 13:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727025828.giynspbcz7zdmosa@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/27/21 4:58 AM, Jarkko Sakkinen wrote:
> On Mon, Jul 19, 2021 at 03:37:17PM +0200, Borys Movchan wrote:
> > On some systems, especially embedded, TPM might start in
> > Upgrade/Reduced mode due to the previous failure of a firmware
> > upgrade process. Allow the TPM driver to handle such situations
> > properly. Enables a possibility for userspace application to
> > finalize TPM upgrade or recovery if required.
>
>
> Please add short explanation what you mean by upgrade/reduced mode.
>
> Maybe for clarity speak about upgrade mode.

I have send v2 patch with updated commit message and some notes.

Hope that would be more clear.

>
> >
> > Signed-off-by: Borys Movchan <borysmn@axis.com>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 23 +++++++++++++++--------
> >  drivers/char/tpm/tpm2-cmd.c | 12 ++++++++++--
> >  include/linux/tpm.h         |  1 +
> >  3 files changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index ddaeceb7e109..ff2367c447fb 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -574,20 +574,25 @@ static int tpm_get_pcr_allocation(struct 
> tpm_chip *chip)
> >  int tpm_chip_register(struct tpm_chip *chip)
> >  {
> >        int rc;
> > +     bool limited_mode = false;
> >
> >        rc = tpm_chip_start(chip);
> >        if (rc)
> >                return rc;
> >        rc = tpm_auto_startup(chip);
> > -     if (rc) {
> > +     if (rc == -EIO) {
> > +             limited_mode = true;
> > +     } else if (rc) {
> >                tpm_chip_stop(chip);
> >                return rc;
> >        }
> >
> > -     rc = tpm_get_pcr_allocation(chip);
> > -     tpm_chip_stop(chip);
> > -     if (rc)
> > -             return rc;
> > +     if (!limited_mode) {
> > +             rc = tpm_get_pcr_allocation(chip);
> > +             tpm_chip_stop(chip);
> > +             if (rc)
> > +                     return rc;
> > +     }
> >
> >        tpm_sysfs_add_device(chip);
> >
> > @@ -595,9 +600,11 @@ int tpm_chip_register(struct tpm_chip *chip)
> >
> >        tpm_add_ppi(chip);
> >
> > -     rc = tpm_add_hwrng(chip);
> > -     if (rc)
> > -             goto out_ppi;
> > +     if (!limited_mode) {
> > +             rc = tpm_add_hwrng(chip);
> > +             if (rc)
> > +                     goto out_ppi;
> > +     }
> >
> >        rc = tpm_add_char_device(chip);
> >        if (rc)
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index a25815a6f625..7468353ed67d 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -718,7 +718,8 @@ static int tpm2_startup(struct tpm_chip *chip)
> >   *                     sequence
> >   * @chip: TPM chip to use
> >   *
> > - * Returns 0 on success, < 0 in case of fatal error.
> > + * Returns 0 on success, -ENODEV in case of fatal error,
> > + *       -EIO in case of Reduced/Upgrade mode
> >   */
> >  int tpm2_auto_startup(struct tpm_chip *chip)
> >  {
> > @@ -729,7 +730,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >                goto out;
> >
> >        rc = tpm2_do_selftest(chip);
> > -     if (rc && rc != TPM2_RC_INITIALIZE)
> > +     if (rc == TPM2_RC_UPGRADE) {
> > +             rc = -EIO;
> > +             goto out;
> > +     } else if (rc && rc != TPM2_RC_INITIALIZE)
> >                goto out;
> >
> >        if (rc == TPM2_RC_INITIALIZE) {
> > @@ -743,6 +747,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >        }
> >
> >        rc = tpm2_get_cc_attrs_tbl(chip);
> > +     if (rc) { /* Succeeded until here, but failed -> reduced mode */
> > +             rc = -EIO;
> > +             goto out;
> > +     }
> >
> >  out:
> >        if (rc > 0)
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index aa11fe323c56..e873c42907f0 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -207,6 +207,7 @@ enum tpm2_return_codes {
> >        TPM2_RC_INITIALIZE      = 0x0100, /* RC_VER1 */
> >        TPM2_RC_FAILURE         = 0x0101,
> >        TPM2_RC_DISABLED        = 0x0120,
> > +     TPM2_RC_UPGRADE         = 0x012D,
> >        TPM2_RC_COMMAND_CODE    = 0x0143,
> >        TPM2_RC_TESTING         = 0x090A, /* RC_WARN */
> >        TPM2_RC_REFERENCE_H0    = 0x0910,
> > --
> > 2.20.1
> >
> >
>
> /Jarkko

Kind regards,

Borys

