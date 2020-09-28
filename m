Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3930227A4B7
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 02:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1ARj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 20:17:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:50057 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1ARj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 20:17:39 -0400
IronPort-SDR: WWnLeQqmNLLvOlvdhbeDet2w91A6v4f1L1b/L4AUcQ/dxohOPW8heCWLuhgrnLvwU2d2W9mgLj
 b8F4OB+Y+30w==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="180071565"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="180071565"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 17:11:37 -0700
IronPort-SDR: 1wTE4Z1FmDFnhS0EPIKcjccUOpkd94ISiXOi3l8b1uWOUYPjn6Otv2bquyjlMyqD06ESqdcWFT
 tK0B4142WYWQ==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488342621"
Received: from memara-mobl.ger.corp.intel.com (HELO localhost) ([10.252.49.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 17:11:36 -0700
Date:   Mon, 28 Sep 2020 03:11:38 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: only export stand alone version of flush context
 command
Message-ID: <20200928001138.GE5283@linux.intel.com>
References: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 27, 2020 at 04:17:40PM -0700, James Bottomley wrote:
> Remove the currently exported version of flush context, which is
> designed for tpm core internal use only and substitute a corrected
> version that does the necessary tpm ops get/put.  This fixes a bug
> with trusted keys in that some TIS TPMs are unable to flush the
> loaded secret because the status register isn't reading correctly.
> 
> Fixes: 45477b3fe3d1 ("security: keys: trusted: fix lost handle flush")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/tpm.h                    |  1 +
>  drivers/char/tpm/tpm2-cmd.c               | 23 ++++++++++++++++++++++-
>  include/linux/tpm.h                       |  2 +-
>  security/keys/trusted-keys/trusted_tpm2.c |  2 +-
>  4 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 21ac88d4076c..cba09be7ce23 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -240,6 +240,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
>  		       size_t cmdsiz);
>  int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
>  		      size_t *bufsiz);
> +void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
>  
>  void tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 9b84158c5a9e..d5aaea72d578 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -362,7 +362,28 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
>  	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
>  	tpm_buf_destroy(&buf);
>  }
> -EXPORT_SYMBOL_GPL(tpm2_flush_context);
> +
> +/**
> + * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
> + * @chip:	TPM chip to use
> + * @handle:	context handle
> + *
> + * This version of the command is designed to be used outside the
> + * TPM core so acquires and releases the tpm ops.
> + */
> +void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle)
> +{
> +	int rc;
> +
> +	rc = tpm_try_get_ops(chip);
> +	if (rc) {
> +		dev_err(&chip->dev, "Failed to acquire tpm ops for flush\n");
> +		return;
> +	}
> +	tpm2_flush_context(chip, handle);
> +	tpm_put_ops(chip);
> +}
> +EXPORT_SYMBOL_GPL(tpm2_flush_context_cmd);

Otherwise fine but please rename the existing function as
__tpm2_flush_context() and exported as tpm2_flush_context().

>  struct tpm2_get_cap_out {
>  	u8 more_data;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index ae2482510f8c..c4ca52138e8b 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -411,7 +411,7 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
>  extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>  extern struct tpm_chip *tpm_default_chip(void);
> -void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
> +void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle);
>  #else
>  static inline int tpm_is_tpm2(struct tpm_chip *chip)
>  {
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 08ec7f48f01d..38bb33333cdf 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -309,7 +309,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>  		return rc;
>  
>  	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
> -	tpm2_flush_context(chip, blob_handle);
> +	tpm2_flush_context_cmd(chip, blob_handle);
>  
>  	return rc;

It will also elimintate this change.

Thank you.

/Jarkko
