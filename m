Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D7C5A1F31
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Aug 2022 05:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiHZDCU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Aug 2022 23:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244066AbiHZDCS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Aug 2022 23:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E89C7429;
        Thu, 25 Aug 2022 20:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5185461E69;
        Fri, 26 Aug 2022 03:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C61FC433C1;
        Fri, 26 Aug 2022 03:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661482934;
        bh=VbL0nAmH2Klred+v5b72GoaYRxetUy7nlR4YWBVkvWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VleN9Nv2Blt0CG8NzEm0Z40Adtd5kw/T14v1Oe6ythvlzjIRjhZBfbjQgqVbC2ZWS
         uhmq2yUGkc6BQUeH0u+MF+5pIZej9oMCrAYJGpOBq2X9B38xA6Bh0imI9KZrcFtB97
         k5CDMZARMfVt+mxA7qSuWDNuBmsI3Xd6jl9MPLdydKYa3FJ5NsoFz+Dsj29XxsKSx6
         wmkGv34OKFIMvouUGYemphXFZ1OnN++xyV52FJ1dAp2OZif3QpSuWfKrieH+Y1X3Ek
         33wSbXjz87Ij8oxKIOf9mFJeYGBbxI+hAXkF4ny6t+rIAp2gby0JOgQCEQ8scuts6Y
         x1y5NligsbQqg==
Date:   Fri, 26 Aug 2022 06:02:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, dlunev@google.com, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, corbet@lwn.net, jejb@linux.ibm.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 02/10] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <Ywg3r5bJs+5QAll0@kernel.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 23, 2022 at 03:25:18PM -0700, Evan Green wrote:
> From: Matthew Garrett <matthewgarrett@google.com>
> 
> Under certain circumstances it might be desirable to enable the creation
> of TPM-backed secrets that are only accessible to the kernel. In an
> ideal world this could be achieved by using TPM localities, but these
> don't appear to be available on consumer systems. An alternative is to
> simply block userland from modifying one of the resettable PCRs, leaving
> it available to the kernel. If the kernel ensures that no userland can
> access the TPM while it is carrying out work, it can reset PCR 23,
> extend it to an arbitrary value, create or load a secret, and then reset
> the PCR again. Even if userland somehow obtains the sealed material, it
> will be unable to unseal it since PCR 23 will never be in the
> appropriate state.
> 
> From: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Same issues as the other patch.

> ---
> Matthew's original version of this patch is at:
> https://patchwork.kernel.org/patch/12096491/

Suggestion: find a lore URL instead for Matthew's patch,
and then add "Link: <lore URL>" to your commit before
sob's. It's a useful reference also in the commit log.

> 
> Changes in v2:
>  - Fixed sparse warnings
> 
>  drivers/char/tpm/Kconfig          | 10 +++++++++
>  drivers/char/tpm/tpm-dev-common.c |  8 +++++++
>  drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
>  drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
>  drivers/char/tpm/tpm2-space.c     |  2 +-
>  6 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3f2..4483b61a428b11 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -211,4 +211,14 @@ config TCG_FTPM_TEE
>  	  This driver proxies for firmware TPM running in TEE.
>  
>  source "drivers/char/tpm/st33zp24/Kconfig"
> +
> +config TCG_TPM_RESTRICT_PCR
> +	bool "Restrict userland access to PCR 23"
> +	depends on TCG_TPM
> +	help
> +	  If set, block userland from extending or resetting PCR 23. This
> +	  allows it to be restricted to in-kernel use, preventing userland
> +	  from being able to make use of data sealed to the TPM by the kernel.
> +	  This is required for secure hibernation support, but should be left
> +	  disabled if any userland may require access to PCR23.
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index dc4c0a0a512903..7a4e618c7d1942 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	priv->response_read = false;
>  	*off = 0;
>  
> +	if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
> +		ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> +	else
> +		ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
> +
> +	if (ret)
> +		goto out;
> +
>  	/*
>  	 * If in nonblocking mode schedule an async job to send
>  	 * the command return the size.
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index a80b341d38eb8c..077c3ca0a127ba 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -229,6 +229,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
>  unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm2_probe(struct tpm_chip *chip);
>  int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
> +int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
> +			     const void *buf, size_t bufsiz);
>  int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
>  int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> @@ -244,4 +246,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
>  int tpm_dev_common_init(void);
>  void tpm_dev_common_exit(void);
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +#define TPM_RESTRICTED_PCR 23
> +
> +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> +#else
> +static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> +				      size_t size)
> +{
> +	return 0;
> +}
> +
> +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> +				      size_t size)
> +{
> +	return 0;
> +}
> +#endif
>  #endif
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 8ec743dec26544..318e75ae42fb85 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -845,3 +845,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
>  
>  	return 0;
>  }
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	struct tpm_header *header = (struct tpm_header *)buffer;
> +	char len, offset;
> +	__be32 *pcr;
> +	int pos;
> +
> +	switch (be32_to_cpu(header->ordinal)) {
> +	case TPM_ORD_PCR_EXTEND:
> +		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> +			return -EINVAL;
> +		pcr = (__be32 *)&buffer[TPM_HEADER_SIZE];
> +		if (be32_to_cpu(*pcr) == TPM_RESTRICTED_PCR)
> +			return -EPERM;
> +		break;
> +	case TPM_ORD_PCR_RESET:
> +		if (size < (TPM_HEADER_SIZE + 1))
> +			return -EINVAL;
> +		len = buffer[TPM_HEADER_SIZE];
> +		if (size < (TPM_HEADER_SIZE + 1 + len))
> +			return -EINVAL;
> +		offset = TPM_RESTRICTED_PCR/3;
> +		if (len < offset)
> +			break;
> +		pos = TPM_HEADER_SIZE + 1 + offset;
> +		if (buffer[pos] & (1 << (TPM_RESTRICTED_PCR - 2 * offset)))
> +			return -EPERM;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +#endif
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 69126a6770386e..dbf7f5552c6782 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -821,3 +821,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
>  
>  	return -1;
>  }
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	int cc = tpm_find_and_validate_cc(chip, NULL, buffer, size);
> +	__be32 *handle;
> +
> +	switch (cc) {
> +	case TPM2_CC_PCR_EXTEND:
> +	case TPM2_CC_PCR_RESET:
> +		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> +			return -EINVAL;
> +
> +		handle = (__be32 *)&buffer[TPM_HEADER_SIZE];
> +		if (be32_to_cpu(*handle) == TPM_RESTRICTED_PCR)
> +			return -EPERM;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +#endif
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index ffb35f0154c16c..6f51cd92c6400f 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -262,7 +262,7 @@ static int tpm2_map_command(struct tpm_chip *chip, u32 cc, u8 *cmd)
>  	return 0;
>  }
>  
> -static int tpm_find_and_validate_cc(struct tpm_chip *chip,
> +int tpm_find_and_validate_cc(struct tpm_chip *chip,
>  				    struct tpm_space *space,
>  				    const void *cmd, size_t len)

Split the export to a separate commit.

>  {
> -- 
> 2.31.0
> 

BR, Jarkko
