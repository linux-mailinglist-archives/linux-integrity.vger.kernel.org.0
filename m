Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4141722BE
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 17:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgB0QDY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 11:03:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:61415 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgB0QDY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 11:03:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 08:02:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="385198407"
Received: from asliwa-mobl.ger.corp.intel.com (HELO localhost) ([10.252.26.84])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2020 08:02:51 -0800
Date:   Thu, 27 Feb 2020 18:02:50 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, linux-kernel@vger.kernel.org,
        nayna@linux.vnet.ibm.com, gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] tpm: Implement tpm2_init_commands to use in
 non-auto startup case
Message-ID: <20200227160250.GB5140@linux.intel.com>
References: <20200227002654.7536-1-stefanb@linux.vnet.ibm.com>
 <20200227002654.7536-4-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227002654.7536-4-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 26, 2020 at 07:26:53PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> The IBM vTPM device driver will not use TPM_OPS_AUTO_STARTUP since we
> assume the firmware has initialized the TPM 2 and TPM2_Startup() need
> not be sent. Therefore, tpm2_auto_startup() will not be called. To cover
> the tpm_chip's initialization of timeouts, command durations, and
> command attributes we implement tpm2_init_commands() function that will
> be called instead of tpm2_auto_startup().
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm-interface.c |  5 ++++-
>  drivers/char/tpm/tpm.h           |  1 +
>  drivers/char/tpm/tpm2-cmd.c      | 14 ++++++++++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index a438b1206fcb..30d80b94db33 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -371,8 +371,11 @@ int tpm_auto_startup(struct tpm_chip *chip)
>  {
>  	int rc;
>  
> -	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP))
> +	if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP)) {
> +		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +			return tpm2_init_commands(chip);
>  		return 0;
> +	}
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		rc = tpm2_auto_startup(chip);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 5620747da0cf..30da942d714a 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -222,6 +222,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
>  			u32 *value, const char *desc);
>  
>  ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
> +int tpm2_init_commands(struct tpm_chip *chip);
>  int tpm2_auto_startup(struct tpm_chip *chip);
>  void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
>  unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 13696deceae8..2d0c5a3b65c0 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -709,6 +709,20 @@ static int tpm2_startup(struct tpm_chip *chip)
>  	return rc;
>  }
>  
> +/**
> + * tpm2_init_commands - Get timeouts, durations and command code attributes
> + *                      in case tpm2_auto_startup is not used.
> + * @chip: TPM chip to use
> + *
> + * Return 0 on success, < 0 in case of fatal error.
> + */
> +int tpm2_init_commands(struct tpm_chip *chip)
> +{
> +	tpm2_get_timeouts(chip);
> +
> +	return tpm2_get_cc_attrs_tbl(chip);

Call * locally in vtpm instead of adding quirks to the TPM driver.

/Jarkko
