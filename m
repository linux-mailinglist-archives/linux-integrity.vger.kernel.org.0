Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6427A60D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 05:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1D6r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 23:58:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:37232 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1D6r (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 23:58:47 -0400
IronPort-SDR: H0KbsDqAC4HwYYWhF4B8HLoGQ+oTkMBuRrvak6uX5WY/Qv3m8uruD0OOvMLdtg2IQdr+5hwUB/
 6ncvDHrgCV1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159301856"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="159301856"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 17:15:30 -0700
IronPort-SDR: G3bpv15SFxQpqfe6ZKKSZv8GJxri1qhrVgk4q5TGUyr/hE1AtVcKIlrwKvYKdU/UUfgru/zG9f
 1Xvot87pKjGg==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488343287"
Received: from memara-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 17:15:28 -0700
Date:   Mon, 28 Sep 2020 03:15:30 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH 2/2] tpm: Revert "tpm_tis_core: Turn on the TPM before
 probing IRQ's"
Message-ID: <20200928001530.GF5283@linux.intel.com>
References: <20191126131753.3424363-1-stefanb@linux.vnet.ibm.com>
 <20191126131753.3424363-3-stefanb@linux.vnet.ibm.com>
 <1de642865a142dfbf9d7ef0da398c98d52228943.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de642865a142dfbf9d7ef0da398c98d52228943.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 27, 2020 at 01:06:03PM -0700, James Bottomley wrote:
> On Tue, 2019-11-26 at 08:17 -0500, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Revert the patch that was turning the TPM on before probing for IRQs.
> > 
> > Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing
> > IRQ's")
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c
> > b/drivers/char/tpm/tpm_tis_core.c
> > index 5dc52c4e2292..27c6ca031e23 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -1059,7 +1059,6 @@ int tpm_tis_core_init(struct device *dev,
> > struct tpm_tis_data *priv, int irq,
> >  			goto out_err;
> >  		}
> >  
> > -		tpm_chip_start(chip);
> >  		if (irq) {
> >  			tpm_tis_probe_irq_single(chip, intmask,
> > IRQF_SHARED,
> >  						 irq);
> > @@ -1069,7 +1068,6 @@ int tpm_tis_core_init(struct device *dev,
> > struct tpm_tis_data *priv, int irq,
> >  		} else {
> >  			tpm_tis_probe_irq(chip, intmask);
> >  		}
> > -		tpm_chip_stop(chip);
> >  	}
> >  
> >  	rc = tpm_chip_register(chip);
> 
> This patch is completely bogus: it's not a full revert of what it
> claims to be.  With this patch applied all my TIS TPMs are returning
> 0xff to the status reads because the locality hasn't been properly
> requested.  The chip has to be started somewhere for the interrupt
> probe to work on these TPMs ... what the original patch did was
> eliminate a bunch of start/stops for a global one.  However, if the
> global one isn't working we should have gone back to the bunch of
> smaller ones i.e. a full revert.
> 
> The only real manifestation of the problems this patch causes is that
> interrupts never get enabled on TIS TPMs that have this issue, but they
> still work via polling.
> 
> The below is what fixes this for me with the minimum possible extend of
> additional chip start/stop in the code.  This should be checked against
> the previous failing laptops.
> 
> James
> 
> ---
> 
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Subject: [PATCH] tpm_tis: fix interrupt probing
> 
> When we send a command into the TPM core, the TPM must be started
> otherwise the register reads can be bogus.  There have been several
> bug reports about doing this inside the TIS core, so fix the issue by
> adding an external version of the tpm2_get_tpm_pt() call which adds a
> tpm ops get/put to set up the TPM correctly before the command is
> sent.
> 
> Fixes: aa4a63dd9816 (tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm.h          |  2 ++
>  drivers/char/tpm/tpm2-cmd.c     | 30 ++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_tis_core.c |  2 +-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..041b0b5bd2a5 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -223,6 +223,8 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>  ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
>  			u32 *value, const char *desc);
> +ssize_t tpm2_get_tpm_pt_cmd(struct tpm_chip *chip, u32 property_id,
> +			    u32 *value, const char *desc);
>  
>  ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
>  int tpm2_auto_startup(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index eff1f12d981a..9b84158c5a9e 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -407,6 +407,36 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
>  }
>  EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
>  
> +/**
> + * tpm2_get_tpm_pt_cmd() - get value of a TPM_CAP_TPM_PROPERTIES type property
> + * @chip:		a &tpm_chip instance
> + * @property_id:	property ID.
> + * @value:		output variable.
> + * @desc:		passed to tpm_transmit_cmd()
> + *
> + * This calls the necessary tpm_try_get_ops()/tpm_put_ops() around
> + * tpm2_get_tpm_pt() and must be called where it is used stand alone
> + * outside the core code.
> + *
> + * Return:
> + *   0 on success,
> + *   -errno or a TPM return code otherwise
> + */
> +ssize_t tpm2_get_tpm_pt_cmd(struct tpm_chip *chip, u32 property_id,  u32 *value,
> +			    const char *desc)
> +{
> +	ssize_t rc;
> +
> +	rc = tpm_try_get_ops(chip);
> +	if (rc)
> +		return rc;
> +	rc = tpm2_get_tpm_pt(chip, property_id, value, desc);
> +	tpm_put_ops(chip);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt_cmd);

Hi, same comment as for the other, i.e. rename the function that does
not have get/put_ops as __tpm2_get_tpm_pt(). Otherwise, fine. Thank
you.

/Jarkko
