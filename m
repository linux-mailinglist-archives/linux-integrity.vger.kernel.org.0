Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD23D6C30
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 04:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhG0CSD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234410AbhG0CSD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:18:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D78B460FEE;
        Tue, 27 Jul 2021 02:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627354711;
        bh=D7jyy3lazrgfTZyaTB4BgIHxwFeOv1IymHhq8hiVd6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRj5czzYT0B8Rs3pS9KNkyps8ctAbVF3UVgWE8niEpqntkQ4ysSl8FRLhb9ojA7Cm
         5+/bBBJvaHVT2BSK09wGeRlIAyxUN/OD4ZhDVJaRD2crpaAwZ5YgNv7wVJMTwU82Pn
         bqhESmUmolDB376+8gbPP3Irj1HpSq9bnzqaXjyLziwGboE5sGzzUqHNKbX1dKO29c
         hxRWbY/28dMrsVUt91JlWanaQx0rt/779c1ByLzUWBJGeGDKmXgpVm9b5HKtsa2KoA
         riSZilBHxPwpYcSenitshPZl36PBt1dSJoK78KzLsgJJiAaNFT1b6HhXSdsNh3sCDl
         yjiiOqqPEgPCw==
Date:   Tue, 27 Jul 2021 05:58:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borys Movchan <borysmn@axis.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Message-ID: <20210727025828.giynspbcz7zdmosa@kernel.org>
References: <20210719133717.18797-1-borysmn@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719133717.18797-1-borysmn@axis.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 19, 2021 at 03:37:17PM +0200, Borys Movchan wrote:
> On some systems, especially embedded, TPM might start in
> Upgrade/Reduced mode due to the previous failure of a firmware
> upgrade process. Allow the TPM driver to handle such situations
> properly. Enables a possibility for userspace application to
> finalize TPM upgrade or recovery if required.


Please add short explanation what you mean by upgrade/reduced mode.

Maybe for clarity speak about upgrade mode.

> 
> Signed-off-by: Borys Movchan <borysmn@axis.com>
> ---
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
