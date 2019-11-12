Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98ADEF9A32
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 21:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKLUDq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 15:03:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:12524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLUDq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 15:03:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 12:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="194436912"
Received: from joshbuck-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.20.68])
  by orsmga007.jf.intel.com with ESMTP; 12 Nov 2019 12:03:41 -0800
Date:   Tue, 12 Nov 2019 22:03:40 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191112200328.GA11213@linux.intel.com>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111233418.17676-1-jsnitsel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> With power gating moved out of the tpm_transmit code we need
> to power on the TPM prior to calling tpm_get_timeouts.
> 
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-stable@vger.kernel.org
> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> Reported-by: Christian Bundy <christianbundy@fraction.io>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 270f43acbb77..cb101cec8f8b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		 * to make sure it works. May as well use that command to set the
>  		 * proper timeouts for the driver.
>  		 */
> +		tpm_chip_start(chip);
>  		if (tpm_get_timeouts(chip)) {
>  			dev_err(dev, "Could not get TPM timeouts and durations\n");
>  			rc = -ENODEV;
> +			tpm_stop_chip(chip);
>  			goto out_err;
>  		}

Couldn't this call just be removed?

/Jarkko
