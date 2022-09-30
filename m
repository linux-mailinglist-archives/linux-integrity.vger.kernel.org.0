Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF77F5F142D
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiI3UwP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiI3UwN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 16:52:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C7618F42D;
        Fri, 30 Sep 2022 13:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 058A5B82A16;
        Fri, 30 Sep 2022 20:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A64AC433D6;
        Fri, 30 Sep 2022 20:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664571128;
        bh=VODAPY9MFUlINuWvNwiM7pk481HORIyr7zEOicTyiqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmPCV1o0iZlen8Af4lNjRr6Mi/CbMf8/pE2gRZMBipGJVYTjGHHyksSVJJ5lDz0jj
         70r7c8d+Nbv27ONnuABQTRAus3qQZAEp20g7Gbxadg5JormgsEGbh58WxVPbTE/hrL
         gHGs5gU86fkh5I/tY3qejGWnQbxKhAz+CarwcptJyoHcCU05/JTzNBv9bEdJLBZ9zj
         /JgMRD9fxdWFOV/pWpbo1X+K5fkGthndnaZqEbvPyZgDgp54f8uUzIMhKfgLrrDKNI
         XkK8ig15IKUO+y62wMC5hKyFrN6sOgRCBdwjx435LDK9ki64bQW9teN5lFAuq6zU7V
         NxymKc5qX9/uw==
Date:   Fri, 30 Sep 2022 23:52:05 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        apronin@chromium.org, dlunev@google.com,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, corbet@lwn.net, linux-pm@vger.kernel.org,
        zohar@linux.ibm.com, Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>, jejb@linux.ibm.com,
        gwendal@chromium.org, Matthew Garrett <mgarrett@aurora.tech>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>, Hao Wu <hao.wu@rubrik.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Subject: Re: [PATCH v3 01/11] tpm: Add support for in-kernel resetting of PCRs
Message-ID: <YzdW9R8pINcpRgLI@kernel.org>
References: <20220927164922.3383711-1-evgreen@chromium.org>
 <20220927094559.v3.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927094559.v3.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 27, 2022 at 09:49:12AM -0700, Evan Green wrote:
> From: Matthew Garrett <matthewgarrett@google.com>
> 
> Add an internal command for resetting a PCR. This will be used by the
> encrypted hibernation code to set PCR23 to a known value. The
> hibernation code will seal the hibernation key with a policy specifying
> PCR23 be set to this known value as a mechanism to ensure that the
> hibernation key is genuine. But to do this repeatedly, resetting the PCR
> is necessary as well.
> 
> Link: https://lore.kernel.org/lkml/20210220013255.1083202-2-matthewgarrett@google.com/
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> Changes in v3:
>  - Unify tpm1/2_pcr_reset prototypes (Jarkko)
>  - Wait no, remove the TPM1 stuff altogether (Jarkko)
>  - Remove extra From tag and blank in commit msg (Jarkko).
> 
>  drivers/char/tpm/tpm-interface.c | 25 ++++++++++++++++++++++
>  drivers/char/tpm/tpm.h           |  1 +
>  drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++++++++++++++++++
>  include/linux/tpm.h              |  7 +++++++
>  4 files changed, 69 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce8187052c..2ac9079860b1e0 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -342,6 +342,31 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  }
>  EXPORT_SYMBOL_GPL(tpm_pcr_extend);
>  
> +/**
> + * tpm_pcr_reset - reset the specified PCR
> + * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> + * @pcr_idx:	the PCR to be reset
> + *
> + * Return: same as with tpm_transmit_cmd(), or ENOTTY for TPM1 devices.
> + */
> +int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
> +{
> +	int rc;
> +
> +	chip = tpm_find_get_ops(chip);
> +	if (!chip)
> +		return -ENODEV;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		rc = tpm2_pcr_reset(chip, pcr_idx);
> +	else
> +		rc = -ENOTTY;
> +
> +	tpm_put_ops(chip);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tpm_pcr_reset);

Please rename this as tpm2_pcr_reset() and open code the contents
of the current tpm2_pcd_reset() into it, as this layering is now
obsolete.

> +
>  /**
>   * tpm_send - send a TPM command
>   * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 24ee4e1cc452a0..34e20b3192f833 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -217,6 +217,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  		  struct tpm_digest *digest, u16 *digest_size_ptr);
>  int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		    struct tpm_digest *digests);
> +int tpm2_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
>  ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
>  			u32 *value, const char *desc);
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 65d03867e114c5..69126a6770386e 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -269,6 +269,42 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  	return rc;
>  }
>  
> +/**
> + * tpm2_pcr_reset() - reset a PCR
> + *

Remove empty line and "Reset a PCR" with a capital.

There might be random conventions in this but I'm now referring
to just what this says:

https://www.kernel.org/doc/html/v5.19/doc-guide/kernel-doc.html

I.e. better to align with documentation for this and future patches.

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
> index dfeb25a0362dee..8320cbac6f4009 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -219,6 +219,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
>  	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
>  	TPM2_CC_CREATE_PRIMARY          = 0x0131,
> +	TPM2_CC_PCR_RESET		= 0x013D,
>  	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
>  	TPM2_CC_SELF_TEST	        = 0x0143,
>  	TPM2_CC_STARTUP		        = 0x0144,
> @@ -423,6 +424,7 @@ extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
>  				size_t min_rsp_body_length, const char *desc);
>  extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  			struct tpm_digest *digest);
> +extern int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx);
>  extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  			  struct tpm_digest *digests);
>  extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
> @@ -440,6 +442,11 @@ static inline int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx,
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
> 2.31.0
> 

BR, Jarkko
