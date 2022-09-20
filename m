Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8820D5BDBCE
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Sep 2022 06:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiITEvC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Sep 2022 00:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiITEvA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Sep 2022 00:51:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A15852DC7;
        Mon, 19 Sep 2022 21:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 001E5B818B6;
        Tue, 20 Sep 2022 04:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E9FC433D6;
        Tue, 20 Sep 2022 04:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663649456;
        bh=fzjnfFvXaoLalr68n3B2MZyIURza6L8/C5Yc3Wy/osI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oX7GvtQRx5hPjag0bbNf26qO81fekuU0755+qCCtZxI00VfTgFLg/j7/suGU+f0dL
         BhH2cIEwfRo3I2lA2GS//8IkXQXMo1LQ7xSBsmPoKDZXPbXJSIYOuYWbTQzpQsG7l8
         RE4lRC9d3vNLddHPdFIOMPRKIskmZtsbkbihaSp6qwrY3EyZE9iuKOhesLAhM3IBUr
         mxRe01nWD/AjhC83Jd1VrnevgW/wW1qnBy5WDp+FHTths2Y2OnwTfI6QHNrQaCpW09
         SdJYvV3SGeS2odprJfSpI8qFRmXVVezO+mnShkDhE9k4X0zpnnZbEiKY/4asR0F4gN
         z5CEoJGxa7p8g==
Date:   Tue, 20 Sep 2022 07:50:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
        gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, dlunev@google.com, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, corbet@lwn.net, jejb@linux.ibm.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 02/10] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <YylGq7eUvaoSyA1u@kernel.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <4308c2d0-94ae-8a65-e0c7-69270e31d447@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4308c2d0-94ae-8a65-e0c7-69270e31d447@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 13, 2022 at 08:26:09AM -0400, Stefan Berger wrote:
> 
> 
> On 8/23/22 18:25, Evan Green wrote:
> > From: Matthew Garrett <matthewgarrett@google.com>
> > 
> > Under certain circumstances it might be desirable to enable the creation
> > of TPM-backed secrets that are only accessible to the kernel. In an
> > ideal world this could be achieved by using TPM localities, but these
> > don't appear to be available on consumer systems. An alternative is to
> > simply block userland from modifying one of the resettable PCRs, leaving
> > it available to the kernel. If the kernel ensures that no userland can
> > access the TPM while it is carrying out work, it can reset PCR 23,
> > extend it to an arbitrary value, create or load a secret, and then reset
> > the PCR again. Even if userland somehow obtains the sealed material, it
> > will be unable to unseal it since PCR 23 will never be in the
> > appropriate state.
> > 
> > From: Matthew Garrett <mjg59@google.com>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > 
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> > Matthew's original version of this patch is at:
> > https://patchwork.kernel.org/patch/12096491/
> > 
> > Changes in v2:
> >   - Fixed sparse warnings
> > 
> >   drivers/char/tpm/Kconfig          | 10 +++++++++
> >   drivers/char/tpm/tpm-dev-common.c |  8 +++++++
> >   drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
> >   drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
> >   drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
> >   drivers/char/tpm/tpm2-space.c     |  2 +-
> >   6 files changed, 97 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index 927088b2c3d3f2..4483b61a428b11 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -211,4 +211,14 @@ config TCG_FTPM_TEE
> >   	  This driver proxies for firmware TPM running in TEE.
> >   source "drivers/char/tpm/st33zp24/Kconfig"
> > +
> > +config TCG_TPM_RESTRICT_PCR
> > +	bool "Restrict userland access to PCR 23"
> > +	depends on TCG_TPM
> > +	help
> > +	  If set, block userland from extending or resetting PCR 23. This
> > +	  allows it to be restricted to in-kernel use, preventing userland
> > +	  from being able to make use of data sealed to the TPM by the kernel.
> > +	  This is required for secure hibernation support, but should be left
> > +	  disabled if any userland may require access to PCR23.
> >   endif # TCG_TPM
> > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> > index dc4c0a0a512903..7a4e618c7d1942 100644
> > --- a/drivers/char/tpm/tpm-dev-common.c
> > +++ b/drivers/char/tpm/tpm-dev-common.c
> > @@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
> >   	priv->response_read = false;
> >   	*off = 0;
> > +	if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
> > +		ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> > +	else
> > +		ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
> > +
> > +	if (ret)
> > +		goto out;
> > +
> >   	/*
> >   	 * If in nonblocking mode schedule an async job to send
> >   	 * the command return the size.
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index a80b341d38eb8c..077c3ca0a127ba 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -229,6 +229,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
> >   unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> >   int tpm2_probe(struct tpm_chip *chip);
> >   int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
> > +int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
> > +			     const void *buf, size_t bufsiz);
> >   int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
> >   int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
> >   void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> > @@ -244,4 +246,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
> >   void tpm_bios_log_teardown(struct tpm_chip *chip);
> >   int tpm_dev_common_init(void);
> >   void tpm_dev_common_exit(void);
> > +
> > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > +#define TPM_RESTRICTED_PCR 23
> > +
> > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > +#else
> > +static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > +				      size_t size)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > +				      size_t size)
> > +{
> > +	return 0;
> > +}
> > +#endif
> >   #endif
> > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > index 8ec743dec26544..318e75ae42fb85 100644
> > --- a/drivers/char/tpm/tpm1-cmd.c
> > +++ b/drivers/char/tpm/tpm1-cmd.c
> > @@ -845,3 +845,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> >   	return 0;
> >   }
> > +
> > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> > +{
> > +	struct tpm_header *header = (struct tpm_header *)buffer;
> > +	char len, offset;
> > +	__be32 *pcr;
> > +	int pos;
> > +
> > +	switch (be32_to_cpu(header->ordinal)) {
> > +	case TPM_ORD_PCR_EXTEND:
> > +		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> > +			return -EINVAL;
> > +		pcr = (__be32 *)&buffer[TPM_HEADER_SIZE];
> > +		if (be32_to_cpu(*pcr) == TPM_RESTRICTED_PCR)
> > +			return -EPERM;
> 
> FYI: TPM 1.2 has transport sessions where the command is tunneled in an
> encrypted channel and this check could be circumvented...

BTW, Why do we want to support TPM 1.2 at all.

I would not support it for new features. This could be just TPM2 only
feeature.

BR, Jarkko
