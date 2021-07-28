Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFD3D97F1
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhG1V6Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 17:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhG1V6X (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 17:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5846C6103A;
        Wed, 28 Jul 2021 21:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627509501;
        bh=ezqX1FxBa8zEWu5cc4dGcLZ31b6wltzL2lhjCEjPd4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYhgaSpAaZQiBMxbtw8mLPqN6JjKBRWz67kC67zjYpveuseyI6B+0C4hFgLevqDA8
         7DQw2Yk+HFQt7g9PytIWaWF17EeqFM+rqDL/1v/piz3K+gaykO9917Ta7ogt5SjT0+
         sbvvQwVba8FwGTJQfVh6dOYtAQU1+EnSvd1W7TG4o9z9tUtHesZBVzScHGpGqNmZAu
         RquoQKp9lpu3wHv44y7dpwe/iN9Fl4+c0cUUkKnmYTcFBrogmTL/bsvNl1ly8/ot+s
         udzdqVWpV5W9pE/H+ktZjmB5dOsh43k1oCXYKzG+Xm0u53WxtFRcjuKw84WbqQlsc7
         tWsA7po0ENfjA==
Date:   Thu, 29 Jul 2021 00:58:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borys Movchan <borysmn@axis.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Message-ID: <20210728215819.vsdwh2fbct7wxwsu@kernel.org>
References: <20210728105730.10170-1-borysmn@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728105730.10170-1-borysmn@axis.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 28, 2021 at 12:57:30PM +0200, Borys Movchan wrote:
> If something went wrong during the TPM firmware upgrade,
> like power failure or the firmware image file get corrupted,
> the TPM might end up in Upgrade or Failure mode upon the
> next start. The state is persistent between the TPM power
> cycle/restart.
> 
> According to TPM specification:
>  * If the TPM is in Upgrade mode, it will answer with
>    TPM2_RC_UPGRADE to all commands except Field Upgrade
>    related ones.
>  * If the TPM is in Failure mode, it will allow performing
>    TPM initialization but will not provide any crypto
>    operations. Will happily respond to Field Upgrade calls.
> 
> The fix adds the possibility to detect an active state of
> the TPM and gives the user-space a chance to finish the
> firmware upgrade/recover the TPM.

This is different than telling what the patch does. It's just
describing a goal, but does not describe how the driver is
changed, and reasons for doing that.

For instance, you check 'limited_mode' flag in a few sites.
How can I know that those are exactly the locations where this
needs to be done?

> Signed-off-by: Borys Movchan <borysmn@axis.com>
> ---
> 
> Notes:
>     v2: The terms are changed to match the ones used in the TPM specification.
>     Rework the commit message to provide more details regarding TPM
>     behavior in Failure/Upgrade mode.
> 
>     The TPM specification describes TPM behavior in Upgrade mode very clearly.
>     Things are a bit more complex if we are talking about Failure mode.
>     The TPM behavior in this mode is highly vendor-specific. Although, there
>     is one thing clearly described in the TPM specification and can be relied
>     on to detect the Failure state: in Failure mode, the TPM doesn't provide
>     any crypto operations. Including access to attributes and configuration
>     registers.
>     It seems persistent between different TPM manufacturers, at least to the
>     degree I was able to verify.
> 
>  drivers/char/tpm/tpm-chip.c | 23 +++++++++++++++--------
>  drivers/char/tpm/tpm2-cmd.c | 12 ++++++++++--
>  include/linux/tpm.h         |  1 +
>  3 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..ff2367c447fb 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -574,20 +574,25 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
>  int tpm_chip_register(struct tpm_chip *chip)
>  {
>  	int rc;
> +	bool limited_mode = false;
>  
>  	rc = tpm_chip_start(chip);
>  	if (rc)
>  		return rc;
>  	rc = tpm_auto_startup(chip);
> -	if (rc) {
> +	if (rc == -EIO) {
> +		limited_mode = true;
> +	} else if (rc) {
>  		tpm_chip_stop(chip);
>  		return rc;
>  	}
>  
> -	rc = tpm_get_pcr_allocation(chip);
> -	tpm_chip_stop(chip);
> -	if (rc)
> -		return rc;
> +	if (!limited_mode) {
> +		rc = tpm_get_pcr_allocation(chip);
> +		tpm_chip_stop(chip);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	tpm_sysfs_add_device(chip);
>  
> @@ -595,9 +600,11 @@ int tpm_chip_register(struct tpm_chip *chip)
>  
>  	tpm_add_ppi(chip);
>  
> -	rc = tpm_add_hwrng(chip);
> -	if (rc)
> -		goto out_ppi;
> +	if (!limited_mode) {
> +		rc = tpm_add_hwrng(chip);
> +		if (rc)
> +			goto out_ppi;
> +	}
>  
>  	rc = tpm_add_char_device(chip);
>  	if (rc)
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index a25815a6f625..7468353ed67d 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -718,7 +718,8 @@ static int tpm2_startup(struct tpm_chip *chip)
>   *                     sequence
>   * @chip: TPM chip to use
>   *
> - * Returns 0 on success, < 0 in case of fatal error.
> + * Returns 0 on success, -ENODEV in case of fatal error,
> + *	    -EIO in case of Reduced/Upgrade mode
>   */
>  int tpm2_auto_startup(struct tpm_chip *chip)
>  {
> @@ -729,7 +730,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  		goto out;
>  
>  	rc = tpm2_do_selftest(chip);
> -	if (rc && rc != TPM2_RC_INITIALIZE)
> +	if (rc == TPM2_RC_UPGRADE) {
> +		rc = -EIO;
> +		goto out;
> +	} else if (rc && rc != TPM2_RC_INITIALIZE)
>  		goto out;
>  
>  	if (rc == TPM2_RC_INITIALIZE) {
> @@ -743,6 +747,10 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  	}
>  
>  	rc = tpm2_get_cc_attrs_tbl(chip);
> +	if (rc) { /* Succeeded until here, but failed -> reduced mode */
> +		rc = -EIO;
> +		goto out;
> +	}
>  
>  out:
>  	if (rc > 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index aa11fe323c56..e873c42907f0 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -207,6 +207,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
>  	TPM2_RC_FAILURE		= 0x0101,
>  	TPM2_RC_DISABLED	= 0x0120,
> +	TPM2_RC_UPGRADE		= 0x012D,
>  	TPM2_RC_COMMAND_CODE    = 0x0143,
>  	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>  	TPM2_RC_REFERENCE_H0	= 0x0910,
> -- 
> 2.20.1
> 
> 

/Jarkko
