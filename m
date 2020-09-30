Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EE527DE8D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 04:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgI3CkY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 22:40:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:56010 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729446AbgI3CkY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 22:40:24 -0400
IronPort-SDR: 0i7LSEoHok4bWaNK5KxPxt8yg+Z8vJto73+NhZpR8yl+710FhJLVBOn3YS4OlzDUIDAFRmlrlM
 5/rC3mOHdQRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="247074210"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="247074210"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:40:21 -0700
IronPort-SDR: T/WynNN4pM6n90Mg/m2wjiPcQv/wmjscc6c3O44Xr1me99ogJSNyg+kQn0SWpk/dBWQCMkizr1
 dNB6VBb8t4nQ==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="457493077"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:40:18 -0700
Date:   Wed, 30 Sep 2020 05:40:15 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 3/4] tpm_tis: fix IRQ probing
Message-ID: <20200930024015.GK808399@linux.intel.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
 <20200929223216.22584-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929223216.22584-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 29, 2020 at 03:32:15PM -0700, James Bottomley wrote:
> Unless the TPM_CHIP_FLAG_IRQ is set somewhere, an initial probe of the
> IRQ never gets done.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Please add a clear statement what the patch does in imperative form.

> ---
>  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 02cc384fdaea..b8ab26077cb1 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -808,6 +808,19 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
>  	}
>  	priv->irq = irq;
>  
> +	/*
> +	 * note writes to the interrupt registers are only effective
> +	 * when the TPM is in the active locality, so we have to
> +	 * request the locality here to get the interrupt set up.
> +	 * This request has no corresponding release, because the
> +	 * locality will be relinquished at the end of the tpm command
> +	 * that probes the interrupts
> +	 */
> +	if (request_locality(chip, 0) != 0) {
> +		dev_err(&chip->dev, "failed to gain locality for irq probe\n");
> +		return -EBUSY;
> +	}
> +
>  	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>  			   &original_int_vec);
>  	if (rc < 0)
> @@ -835,6 +848,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
>  		return rc;
>  
>  	priv->irq_tested = false;
> +	chip->flags |= TPM_CHIP_FLAG_IRQ;
>  
>  	/* Generate an interrupt by having the core call through to
>  	 * tpm_tis_send
> -- 
> 2.28.0
> 

Agree with the code change tho.

/Jarkko
