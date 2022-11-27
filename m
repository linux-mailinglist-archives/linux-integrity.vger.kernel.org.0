Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647A1639BBD
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Nov 2022 17:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiK0Q3O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 11:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0Q3O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 11:29:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF94CE34;
        Sun, 27 Nov 2022 08:29:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E2160C98;
        Sun, 27 Nov 2022 16:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B815FC433D6;
        Sun, 27 Nov 2022 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669566552;
        bh=LNnwaNE37OL+Qz4c/qdAC6vQ3k+UpHL8R1qAIwz3z4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6a/2tEFfgB/RXEmkvw9apWIS8XwGSjSKIYXQnF1nHBr9nf+AeIcdkjwFfaLjsgLc
         Ko8q9T38q1D+UN9c7ROmBWXad1GqUU7YlIQ1dO9S8YyaiJDfrby1TO5dOKDdvZHVEy
         P1G4fL8+s0Mz9HkZj52R+zs5cfjVx5Gbmdw33t4hLtHpspVMXDXeuNviFaohRg5q7z
         zxhoM8JAhPtslbA1eQYy0gLns41zXcUmUH2/+zzNaoRMv0M5xEOint1g4/c1ZX1oEQ
         y03TuF+XgaDBKlU9CiZjjjJevNmQuq6rU2RRs0pSHEYIx3l0eaSWRKYupvozvFbDGL
         tDey2rBi1tKEw==
Date:   Sun, 27 Nov 2022 18:29:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <Y4OQUxDrHWNJpl62@kernel.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:28PM -0800, Evan Green wrote:
> Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> restricts usermode's ability to extend or reset PCR 23.

TCG_TPM_KERNEL_PCR would be a more descriptive name, and the
description should be less abstract, e.g.

"Introduce TCG_TPM_RESTRICT_PCR to Kconfig. If enabled, filter out
TPM2_CC_PCR_{EXTEND, RESET} concerning PCR 23 in tpm_common_write()."

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

This should be the first paragraph (motivation).

> This Kconfig is only properly supported for systems with TPM2 devices.
> For systems with TPM1 devices, having this Kconfig enabled completely
> restricts usermode's access to the TPM. TPM1 contains support for
> tunnelled transports, which usermode could use to smuggle commands
> through that this Kconfig is attempting to restrict.
> 
> Link: https://lore.kernel.org/lkml/20210220013255.1083202-3-matthewgarrett@google.com/
> Co-developed-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> 
> Changes in v5:
>  - Change tags on RESTRICT_PCR patch (Kees)
>  - Rename to TCG_TPM2_RESTRICT_PCR
>  - Do nothing on TPM1.2 devices (Jarkko, Doug)
> 
> Changes in v4:
>  - Augment the commit message (Jarkko)
> 
> Changes in v3:
>  - Fix up commit message (Jarkko)
>  - tpm2_find_and_validate_cc() was split (Jarkko)
>  - Simply fully restrict TPM1 since v2 failed to account for tunnelled
>    transport sessions (Stefan and Jarkko).
> 
> Changes in v2:
>  - Fixed sparse warnings
> 
>  drivers/char/tpm/Kconfig          | 12 ++++++++++++
>  drivers/char/tpm/tpm-dev-common.c |  6 ++++++
>  drivers/char/tpm/tpm.h            | 12 ++++++++++++
>  drivers/char/tpm/tpm2-cmd.c       | 22 ++++++++++++++++++++++
>  4 files changed, 52 insertions(+)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3f2..e6d3aa9f6c694f 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -211,4 +211,16 @@ config TCG_FTPM_TEE
>  	  This driver proxies for firmware TPM running in TEE.
>  
>  source "drivers/char/tpm/st33zp24/Kconfig"
> +
> +config TCG_TPM2_RESTRICT_PCR
> +	bool "Restrict userland access to PCR 23 on TPM2 devices"
> +	depends on TCG_TPM
> +	help
> +	  If set, block userland from extending or resetting PCR 23 on TPM2.0
> +	  and later systems. This allows the PCR to be restricted to in-kernel
> +	  use, preventing userland from being able to make use of data sealed to
> +	  the TPM by the kernel. This is required for secure hibernation
> +	  support, but should be left disabled if any userland may require
> +	  access to PCR23. This is a TPM2-only feature, enabling this on a TPM1
> +	  machine is effectively a no-op.
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index dc4c0a0a512903..66d15a2a967443 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -198,6 +198,12 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	priv->response_read = false;
>  	*off = 0;
>  
> +	if (priv->chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	/*
>  	 * If in nonblocking mode schedule an async job to send
>  	 * the command return the size.
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f1e0f490176f01..7fb746d210f59d 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -245,4 +245,16 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
>  int tpm_dev_common_init(void);
>  void tpm_dev_common_exit(void);
> +
> +#ifdef CONFIG_TCG_TPM2_RESTRICT_PCR
> +#define TPM_RESTRICTED_PCR 23
> +
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> +#else
> +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> +				      size_t size)
> +{
> +	return 0;
> +}
> +#endif

Why do you need to export this? That was not discussed in the commit
message.

The function name is quite undescriptive IMHO.

>  #endif
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 303ce2ea02a4b0..3bc5546fddc792 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -778,3 +778,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
>  
>  	return -1;
>  }
> +
> +#ifdef CONFIG_TCG_TPM2_RESTRICT_PCR
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	int cc = tpm2_find_and_validate_cc(chip, NULL, buffer, size);

Please discuss this call in the commit message.

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
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

BR, Jarkko
