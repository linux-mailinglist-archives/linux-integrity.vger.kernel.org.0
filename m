Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767D812B1A6
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2019 07:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfL0GMF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Dec 2019 01:12:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:28703 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfL0GMF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Dec 2019 01:12:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2019 22:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,362,1571727600"; 
   d="scan'208";a="269004612"
Received: from psklarow-mobl.ger.corp.intel.com ([10.252.31.109])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2019 22:12:00 -0800
Message-ID: <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of
 tpm_tis_core_init" has been added to the 5.4-stable tree
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
References: <1577122577157232@kroah.com>
         <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
         <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 27 Dec 2019 08:11:50 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dan, please also test the branch and tell if other patches are needed.
I'm a bit blind with this as I don't have direct access to the faulting
hardware. Thanks. [*]

[*] https://lkml.org/lkml/2019/12/27/12

/Jarkko

On Fri, 2019-12-27 at 08:05 +0200, Jarkko Sakkinen wrote:
> Hi,
> 
> It is getting done on the PR. Hold on for testing and I'll send the
> PR later today.
> 
> /Jarkko
> 
> On Mon, 2019-12-23 at 11:46 -0800, Dan Williams wrote:
> > Hi Greg,
> > 
> > Please drop the:
> > 
> >    Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
> > 
> > ...tag. I had asked Jarkko to do that here:
> > 
> > https://lore.kernel.org/r/CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com/
> > 
> > ...but it didn't get picked up.
> > 
> > On Mon, Dec 23, 2019 at 9:37 AM <gregkh@linuxfoundation.org> wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     tpm_tis: reserve chip for duration of tpm_tis_core_init
> > > 
> > > to the 5.4-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      tpm_tis-reserve-chip-for-duration-of-tpm_tis_core_init.patch
> > > and it can be found in the queue-5.4 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > 
> > > From 21df4a8b6018b842d4db181a8b24166006bad3cd Mon Sep 17 00:00:00 2001
> > > From: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Date: Wed, 11 Dec 2019 16:54:55 -0700
> > > Subject: tpm_tis: reserve chip for duration of tpm_tis_core_init
> > > 
> > > From: Jerry Snitselaar <jsnitsel@redhat.com>
> > > 
> > > commit 21df4a8b6018b842d4db181a8b24166006bad3cd upstream.
> > > 
> > > Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> > > issuing commands to the tpm during initialization, just reserve the
> > > chip after wait_startup, and release it when we are ready to call
> > > tpm_chip_register.
> > > 
> > > Cc: Christian Bundy <christianbundy@fraction.io>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > Cc: stable@vger.kernel.org
> > > Cc: linux-integrity@vger.kernel.org
> > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> > > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > ---
> > >  drivers/char/tpm/tpm_tis_core.c |   35 ++++++++++++++++++-----------------
> > >  1 file changed, 18 insertions(+), 17 deletions(-)
> > > 
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -899,13 +899,13 @@ int tpm_tis_core_init(struct device *dev
> > > 
> > >         if (wait_startup(chip, 0) != 0) {
> > >                 rc = -ENODEV;
> > > -               goto out_err;
> > > +               goto err_start;
> > >         }
> > > 
> > >         /* Take control of the TPM's interrupt hardware and shut it off */
> > >         rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> > >         if (rc < 0)
> > > -               goto out_err;
> > > +               goto err_start;
> > > 
> > >         intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
> > >                    TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
> > > @@ -914,21 +914,21 @@ int tpm_tis_core_init(struct device *dev
> > > 
> > >         rc = tpm_chip_start(chip);
> > >         if (rc)
> > > -               goto out_err;
> > > +               goto err_start;
> > > +
> > >         rc = tpm2_probe(chip);
> > > -       tpm_chip_stop(chip);
> > >         if (rc)
> > > -               goto out_err;
> > > +               goto err_probe;
> > > 
> > >         rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
> > >         if (rc < 0)
> > > -               goto out_err;
> > > +               goto err_probe;
> > > 
> > >         priv->manufacturer_id = vendor;
> > > 
> > >         rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
> > >         if (rc < 0)
> > > -               goto out_err;
> > > +               goto err_probe;
> > > 
> > >         dev_info(dev, "%s TPM (device-id 0x%X, rev-id %d)\n",
> > >                  (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2",
> > > @@ -937,13 +937,13 @@ int tpm_tis_core_init(struct device *dev
> > >         probe = probe_itpm(chip);
> > >         if (probe < 0) {
> > >                 rc = -ENODEV;
> > > -               goto out_err;
> > > +               goto err_probe;
> > >         }
> > > 
> > >         /* Figure out the capabilities */
> > >         rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
> > >         if (rc < 0)
> > > -               goto out_err;
> > > +               goto err_probe;
> > > 
> > >         dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
> > >                 intfcaps);
> > > @@ -977,10 +977,9 @@ int tpm_tis_core_init(struct device *dev
> > >                 if (tpm_get_timeouts(chip)) {
> > >                         dev_err(dev, "Could not get TPM timeouts and durations\n");
> > >                         rc = -ENODEV;
> > > -                       goto out_err;
> > > +                       goto err_probe;
> > >                 }
> > > 
> > > -               tpm_chip_start(chip);
> > >                 chip->flags |= TPM_CHIP_FLAG_IRQ;
> > >                 if (irq) {
> > >                         tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
> > > @@ -991,18 +990,20 @@ int tpm_tis_core_init(struct device *dev
> > >                 } else {
> > >                         tpm_tis_probe_irq(chip, intmask);
> > >                 }
> > > -               tpm_chip_stop(chip);
> > >         }
> > > 
> > > +       tpm_chip_stop(chip);
> > > +
> > >         rc = tpm_chip_register(chip);
> > >         if (rc)
> > > -               goto out_err;
> > > -
> > > -       if (chip->ops->clk_enable != NULL)
> > > -               chip->ops->clk_enable(chip, false);
> > > +               goto err_start;
> > > 
> > >         return 0;
> > > -out_err:
> > > +
> > > +err_probe:
> > > +       tpm_chip_stop(chip);
> > > +
> > > +err_start:
> > >         if ((chip->ops != NULL) && (chip->ops->clk_enable != NULL))
> > >                 chip->ops->clk_enable(chip, false);
> > > 
> > > 
> > > 
> > > Patches currently in stable-queue which might be from jsnitsel@redhat.com are
> > > 
> > > queue-5.4/iommu-fix-kasan-use-after-free-in-iommu_insert_resv_region.patch
> > > queue-5.4/iommu-vt-d-fix-dmar-pte-read-access-not-set-error.patch
> > > queue-5.4/iommu-set-group-default-domain-before-creating-direct-mappings.patch
> > > queue-5.4/tpm_tis-reserve-chip-for-duration-of-tpm_tis_core_init.patch
> > > queue-5.4/iommu-vt-d-allocate-reserved-region-for-isa-with-correct-permission.patch
> > > queue-5.4/iommu-vt-d-set-isa-bridge-reserved-region-as-relaxable.patch

