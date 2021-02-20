Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676A732034D
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 03:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBTCxN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 21:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhBTCxM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 21:53:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB5B464E57;
        Sat, 20 Feb 2021 02:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613789551;
        bh=IshvD1skejssrDWILgPwdyGSe2QXYmwraex7kk2PWWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKZ/hSuPXbX3XnVzse86yJWGCGjGz68vEB9aq80fY1QQU6k3oKZIMyRDpNY+7wR/d
         mDQsyJ1WVWDKR6EfdhRWXM+nhOruy2E+b9JF23yuxSw/zNjzncbjmk7BeD9AckCA45
         0xNUeFwG/CGp+BNxFynDqLwFKd3MoJFIi783ajwRKf1YMgJlzOa3srFF5CNLUzEPEQ
         WFa3UqjTALUaMURqTn8bPc9qIkvGJkADp54vRbv5HErw5CG3bhtX/tClUiVVRxtkD3
         fQ0+0/NwT32Jh7BY+rTMEVLxgcBJOAHwTfN++7f0A5ZBmtqtkH7LcJoa2XwCYIb5h4
         X8kopTsOnqHIQ==
Date:   Sat, 20 Feb 2021 04:52:15 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 1/9] tpm: Add support for in-kernel resetting of PCRs
Message-ID: <YDB5X9mUiIso3gnr@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-2-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220013255.1083202-2-matthewgarrett@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 20, 2021 at 01:32:47AM +0000, Matthew Garrett wrote:

Perhaps, prepend with a paragraph elaborating the background just a bit:

"When entering to hibernation, PCR 23 will be used to store a known value.
This value defines a policy for the decryption of the key used to encrypt
the hibernate image."

At minimum that. You can of course edit this however you see fit.

> Add an internal command for resetting a PCR.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++++++++++
>  drivers/char/tpm/tpm.h           |  2 ++
>  drivers/char/tpm/tpm1-cmd.c      | 34 ++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  7 +++++++
>  5 files changed, 107 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce818705..17b8643ee109 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -342,6 +342,34 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  }
>  EXPORT_SYMBOL_GPL(tpm_pcr_extend);
>  
> +/**
> + * tpm_pcr_reset - reset the specified PCR
> + * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> + * @pcr_idx:	the PCR to be reset
> + *
> + * Return: same as with tpm_transmit_cmd()
> + */
> +int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
> +{
> +	int rc;
> +
> +	chip = tpm_find_get_ops(chip);
> +	if (!chip)
> +		return -ENODEV;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		rc = tpm2_pcr_reset(chip, pcr_idx);
> +		goto out;
> +	}
> +
> +	rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");
> +
> +out:
> +	tpm_put_ops(chip);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tpm_pcr_reset);
> +
>  /**
>   * tpm_send - send a TPM command
>   * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..746f7696bdc0 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -176,6 +176,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip);
>  unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
>  		    const char *log_msg);
> +int tpm1_pcr_reset(struct tpm_chip *chip, u32 pcr_idx, const char *log_msg);
>  int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
>  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  		    const char *desc, size_t min_cap_length);
> @@ -220,6 +221,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  		  struct tpm_digest *digest, u16 *digest_size_ptr);
>  int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		    struct tpm_digest *digests);
> +int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>  ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
>  			u32 *value, const char *desc);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index ca7158fa6e6c..36990e9d2dc1 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -478,6 +478,40 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
>  	return rc;
>  }
>  
> +struct tpm_pcr_selection {
> +	u16 size_of_select;
> +	u8  pcr_select[3];
> +} __packed;
> +
> +#define TPM_ORD_PCR_RESET 200
> +int tpm1_pcr_reset(struct tpm_chip *chip, u32 pcr_idx, const char *log_msg)
> +{
> +	struct tpm_pcr_selection selection;
> +	struct tpm_buf buf;
> +	int i, rc;
> +	char tmp;
> +
> +	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_RESET);
> +	if (rc)
> +		return rc;
> +
> +	selection.size_of_select = 3;
> +
> +	for (i = 0; i < selection.size_of_select; i++) {
> +		tmp = 0;
> +		if (pcr_idx / 3 == i) {
> +			pcr_idx -= i * 8;
> +			tmp |= 1 << pcr_idx;
> +		}
> +		selection.pcr_select[i] = tmp;
> +	}
> +	tpm_buf_append(&buf, (u8 *)&selection, sizeof(selection));
> +
> +	rc = tpm_transmit_cmd(chip, &buf, sizeof(selection), log_msg);
> +	tpm_buf_destroy(&buf);
> +	return rc;
> +}
> +
>  #define TPM_ORD_GET_CAP 101
>  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  		    const char *desc, size_t min_cap_length)
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index eff1f12d981a..9609ae8086c6 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -269,6 +269,42 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  	return rc;
>  }
>  
> +/**
> + * tpm2_pcr_reset() - reset a PCR
> + *
> + * @chip:	TPM chip to use.
> + * @pcr_idx:	index of the PCR.
> + *
> + * Return: Same as with tpm_transmit_cmd.
> + */
> +int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
> +{
> +	struct tpm_buf buf;
> +	struct tpm2_null_auth_area auth_area;
> +	int rc;
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_RESET);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_append_u32(&buf, pcr_idx);
> +
> +	auth_area.handle = cpu_to_be32(TPM2_RS_PW);
> +	auth_area.nonce_size = 0;
> +	auth_area.attributes = 0;
> +	auth_area.auth_size = 0;
> +
> +	tpm_buf_append_u32(&buf, sizeof(struct tpm2_null_auth_area));
> +	tpm_buf_append(&buf, (const unsigned char *)&auth_area,
> +		       sizeof(auth_area));
> +
> +	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to reset a PCR");
> +
> +	tpm_buf_destroy(&buf);
> +
> +	return rc;
> +}
> +
>  struct tpm2_get_random_out {
>  	__be16 size;
>  	u8 buffer[TPM_MAX_RNG_DATA];
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 8f4ff39f51e7..e2075e2242a0 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -211,6 +211,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
>  	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
>  	TPM2_CC_CREATE_PRIMARY          = 0x0131,
> +	TPM2_CC_PCR_RESET		= 0x013D,
>  	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
>  	TPM2_CC_SELF_TEST	        = 0x0143,
>  	TPM2_CC_STARTUP		        = 0x0144,
> @@ -399,6 +400,7 @@ static inline u32 tpm2_rc_value(u32 rc)
>  extern int tpm_is_tpm2(struct tpm_chip *chip);
>  extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  			struct tpm_digest *digest);
> +extern int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
>  extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  			  struct tpm_digest *digests);
>  extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
> @@ -417,6 +419,11 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
>  	return -ENODEV;
>  }
>  
> +static inline int tpm_pcr_reset(struct tpm_chip *chip, int pcr_idx)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  				 struct tpm_digest *digests)
>  {
> -- 
> 2.30.0.617.g56c4b15f3c-goog
> 
> 

/Jarkko
