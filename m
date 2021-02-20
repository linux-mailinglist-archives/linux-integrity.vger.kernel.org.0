Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB5320362
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 04:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBTDDx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 22:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBTDDu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 22:03:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82EB664ECA;
        Sat, 20 Feb 2021 03:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613790189;
        bh=GH+2O6KD5MEIhlMf6/HszdBP9FzLwKyidhQiQesqIoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpl6s9Wwe8TllUthV8Etr/NlqI5NrwCB47ZAGpQxqJ+7Ej6KgdQbOWBHHxmmOw3s/
         F8srAvqMgb9oPFm0aJp2ajgg55ZdALKvnbRG1zwAEq4OkFnpZNJ5CNO8LDtUzQZSsI
         kK3osWyjw1Hd+530MiA1nGiHLEH+beQgiNf74varFYSbT3TIUyIcu9KZrOyVT7+bbI
         y6FiTpe5W6fjIC2JhWWdv6Ak4Nd1ZGc2KlKNhRa7si4loZhZXeqg5pa+jf2f6eMhBM
         BGKmC23MetD3iijGzT8/Ud4i0goVEIeVVxeh6W4IcLDwhgPcrqopMoK+p+R2YAvtgB
         jOwTsIxL4c4kg==
Date:   Sat, 20 Feb 2021 05:02:53 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 2/9] tpm: Allow PCR 23 to be restricted to kernel-only use
Message-ID: <YDB73bffXa8df17j@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-3-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220013255.1083202-3-matthewgarrett@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 20, 2021 at 01:32:48AM +0000, Matthew Garrett wrote:
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

Does this leave room to use them *if* they are available? Not saying
that this patch set must support them, but neither would like to
disclude them from unforseeable future.

> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  drivers/char/tpm/Kconfig          | 10 +++++++++
>  drivers/char/tpm/tpm-dev-common.c |  8 +++++++
>  drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
>  drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
>  drivers/char/tpm/tpm2-space.c     |  2 +-
>  6 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index a18c314da211..bba30fb16a2e 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -190,4 +190,14 @@ config TCG_FTPM_TEE
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
> index 1784530b8387..d3db4fd76257 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -193,6 +193,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
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

I have to admit my knowledge is limited here. I'm not sure how widely is 23
used by the pre-existing user space in the wild.

>  	/*
>  	 * If in nonblocking mode schedule an async job to send
>  	 * the command return the size.
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 746f7696bdc0..8eed5016d733 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -232,6 +232,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
>  unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm2_probe(struct tpm_chip *chip);
>  int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
> +int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
> +			     const void *buf, size_t bufsiz);
>  int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
>  int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> @@ -245,4 +247,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
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
> index 36990e9d2dc1..2dab1647d89c 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -840,3 +840,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
>  
>  	return 0;
>  }
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	struct tpm_header *header = (struct tpm_header *)buffer;
> +	char len, offset;
> +	u32 *pcr;
> +	int pos;
> +
> +	switch (be32_to_cpu(header->ordinal)) {
> +	case TPM_ORD_PCR_EXTEND:
> +		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> +			return -EINVAL;
> +		pcr = (u32 *)&buffer[TPM_HEADER_SIZE];
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
> index 9609ae8086c6..7dbd4590dee8 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -795,3 +795,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
>  
>  	return -1;
>  }
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	int cc = tpm_find_and_validate_cc(chip, NULL, buffer, size);
> +	u32 *handle;
> +
> +	switch (cc) {
> +	case TPM2_CC_PCR_EXTEND:
> +	case TPM2_CC_PCR_RESET:
> +		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> +			return -EINVAL;
> +
> +		handle = (u32 *)&buffer[TPM_HEADER_SIZE];
> +		if (be32_to_cpu(*handle) == TPM_RESTRICTED_PCR)
> +			return -EPERM;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +#endif
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 784b8b3cb903..76a993492962 100644
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
>  {
> -- 
> 2.30.0.617.g56c4b15f3c-goog
> 
> 

What are the consumer use cases anyway? Why wouldn't locality based
solution make sense to those use cases where this makes sense.

Finally, where does hibernate make sense? :-)

This comes more down to on how lay out the requirements.

/Jarkko
