Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC663DBA5D
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jul 2021 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhG3OWE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Jul 2021 10:22:04 -0400
Received: from smtp2.axis.com ([195.60.68.18]:10649 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239471AbhG3OV6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Jul 2021 10:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1627654913;
  x=1659190913;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GHPMChsYrdUbgtvP/8bEvC7/AuXf6mJFF5tzdRVyFJY=;
  b=F94ZFbFosgw96/lWy8zwyYP/PMHK5uMhRMOlYjx9S8DJtbBsRGEQwfBG
   uhEqeDd191JjgQ4IxFTwj2wVTaitpqH7sx+wu+SLfshGQVavCoNrEi7+z
   HszfNadaxHGWOM1bI49X1jTYyx941SeYaRO0SFAhdAhfqH/Wlrrp1GnfO
   Duzrc3KM76jZTEm3yIA5YySZ+7l+G8T3Rbg38J3gSfrgp4X4UzV91E4Ag
   XIkszCVeMsdsOsnbYUBzpfrLgy3TdtNyyOkwXQ5+KsLL/Vs+W9h8QkmIH
   CUYoAfuj9FpMKuFUSMHBH+WF9My3OS/2OicKRKzgXsM6jSM9sPVJ9ZlOX
   Q==;
Subject: Re: [PATCH v2] tpm: Add Upgrade/Reduced mode support for TPM2 modules
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Borys Movchan <Borys.Movchan@axis.com>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210728105730.10170-1-borysmn@axis.com>
 <20210728215819.vsdwh2fbct7wxwsu@kernel.org>
From:   Borys Movchan <borysmn@axis.com>
Message-ID: <b12dad90-c9ed-2331-7e96-78ca5c3994e8@axis.com>
Date:   Fri, 30 Jul 2021 16:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728215819.vsdwh2fbct7wxwsu@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/28/21 11:58 PM, Jarkko Sakkinen wrote:
 > On Wed, Jul 28, 2021 at 12:57:30PM +0200, Borys Movchan wrote:
 > > If something went wrong during the TPM firmware upgrade,
 > > like power failure or the firmware image file get corrupted,
 > > the TPM might end up in Upgrade or Failure mode upon the
 > > next start. The state is persistent between the TPM power
 > > cycle/restart.
 > >
 > > According to TPM specification:
 > >  * If the TPM is in Upgrade mode, it will answer with
 > >    TPM2_RC_UPGRADE to all commands except Field Upgrade
 > >    related ones.
 > >  * If the TPM is in Failure mode, it will allow performing
 > >    TPM initialization but will not provide any crypto
 > >    operations. Will happily respond to Field Upgrade calls.
 > >
 > > The fix adds the possibility to detect an active state of
 > > the TPM and gives the user-space a chance to finish the
 > > firmware upgrade/recover the TPM.
 >
 > This is different than telling what the patch does. It's just
 > describing a goal, but does not describe how the driver is
 > changed, and reasons for doing that.
 >
 > For instance, you check 'limited_mode' flag in a few sites.
 > How can I know that those are exactly the locations where this
 > needs to be done?
 >

Seems like I got what you are looking for. Let me try to explain the 
reasoning
and doubts regarding what I meant under my change.

According to my previous comments the reason of the change is to provide 
a way
to user-space application to safely perform the TPM firmware update and 
cover
all corner cases like power failure, corrupted firmware image, bad
communication channel and so on.

In original implementation, if TPM is in Upgrade or Failure (some 
vendors call
it Reduced) mode the driver will simple fail during initialization and 
will not
provide any conventional way for the user-space application to address the
situation.

So the fix changes the behavior of `tpm_chip_start` function in a way 
that it
will try to distinguish between actual TPM start failure and  having TPM in
Upgrade/Failure mode.

The Upgrade mode is easy to distinguish. According to the TPM 
specification, in
this mode the TPM will answer to only 2 calls: 
`TPM_CC_FieldUpgradeStart` and
`TPM_CC_FieldUpgradeData`. It will respond `TPM_RC_UPGRADE` to any other 
call.

Failure mode, as mentioned earlier, a bit trickier, but possible to detect.
In this mode very limited functionality is supported as TPM runs some 
form of
fallback firmware or in fallback mode due to failure of upgrade. Different
vendors implement it slightly different. The way how the fix tries to 
address
this mode is by making sure that `TPM_CC_SelfTest` and `TPM_CC_Startup` are
executed correctly but all the consequent calls to address crypto 
functionality
of the TPM are failing. In other words, functions like 
`tpm2_get_cc_attrs_tbl`,
`tpm_add_hwrng` and `tpm_get_pcr_allocation` will fail.

Below you also can find more detailed comments inline regarding every 
part of
the change.

Important to note that the fix addresses only TPM2.0 compatible devices 
as that
is what I am working with.

 > > Signed-off-by: Borys Movchan <borysmn@axis.com>
 > > ---
 > >
 > > Notes:
 > >     v2: The terms are changed to match the ones used in the TPM 
specification.
 > >     Rework the commit message to provide more details regarding TPM
 > >     behavior in Failure/Upgrade mode.
 > >
 > >     The TPM specification describes TPM behavior in Upgrade mode 
very clearly.
 > >     Things are a bit more complex if we are talking about Failure mode.
 > >     The TPM behavior in this mode is highly vendor-specific. 
Although, there
 > >     is one thing clearly described in the TPM specification and can 
be relied
 > >     on to detect the Failure state: in Failure mode, the TPM 
doesn't provide
 > >     any crypto operations. Including access to attributes and 
configuration
 > >     registers.
 > >     It seems persistent between different TPM manufacturers, at 
least to the
 > >     degree I was able to verify.
 > >
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
tpm_chip *chip)
 > >  int tpm_chip_register(struct tpm_chip *chip)
 > >  {
 > >        int rc;
 > > +     bool limited_mode = false;

Introduce this flat to mark that TPM is in Upgrade/Failure mode and the
functionality is limited.

 > >
 > >        rc = tpm_chip_start(chip);
 > >        if (rc)
 > >                return rc;
 > >        rc = tpm_auto_startup(chip);
 > > -     if (rc) {
 > > +     if (rc == -EIO) {
 > > +             limited_mode = true;
 > > +     } else if (rc) {

As described earlier, during startup we can distinguish what mode TPM is
running in.

So check the return value here and set limited_mode flag accordingly.

I am not sure that returning one of the errno values here is good choice
as it might correlate with legit error returned by hardware 
communication layer.
Any comments/suggestions are welcome.

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

As mentioned above, if TPM is in Upgrade/Failure mode, the call to
tpm_get_pcr_allocation will 100% fail, so avoid calling it.

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

Same as with tpm_get_pcr_allocation. Call to tpm_add_hwrng will fail when
limited_mode is set to true;

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

Checking explicitly if TPM is in Upgrade mode. If it is, return immediately
as all other calls (except Firmware upgrade ones) to TPM will be failing.

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

If execution context reaches this point but fails here, the conclusion 
can be
drawn that that TPM is in Failure mode and needs recovery. Indicate it by
settings appropriate return value and exit.

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

Hope that's give a bit more light to what is it all about. Let me know 
if you
have any other questions, I would be glad to help.

 >
 > /Jarkko

Kind regards,
Borys

