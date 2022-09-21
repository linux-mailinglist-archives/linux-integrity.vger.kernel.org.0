Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F335D1C6B
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiIUSGB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIUSF7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC0177578;
        Wed, 21 Sep 2022 11:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E814FB80EAA;
        Wed, 21 Sep 2022 18:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33911C433C1;
        Wed, 21 Sep 2022 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663783555;
        bh=s6E+77AfK4clLa5qlOd75aCOlVi/PMkKtl5zm0NwxLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oov41gcbDJPbZaTgEHJ18nA56JrrdTEahWZsy8nZIh4dS+Naby+CdRMwDQhyVB20a
         NS3oB2ysfzu+Y6nJoK2Qa3KIO+20cTTv0nMH3TBvoaeXjS1SCcZpQH3ug1wVbjjzL+
         7Q4yt/D2VFRLW7QermgJMN0c0iE/Wmo03Vu1OdQOQFz7vartk5KwbMZPbUySEw5EBv
         Cj0I6DO+kbBo43m+SnFEYoppcEqilS3YSh+uqar0JfmSyMkHrevH3wg7LdQg3G2LUE
         ZbPsOS0/c4+167OY+wegj78isxOGub2uXsq7KvtvUl7Jx04B4GNDy3NGcRZXxfYByo
         3Bfd75/AWDrHg==
Date:   Wed, 21 Sep 2022 21:05:52 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 02/10] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <YytSgGQrInFGWQzE@kernel.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <4308c2d0-94ae-8a65-e0c7-69270e31d447@linux.ibm.com>
 <YylGq7eUvaoSyA1u@kernel.org>
 <CAE=gft4-TLDvjtMH+qRJNppkJb798jpKXKXF8nytW7v9d2euRg@mail.gmail.com>
 <YytRqguZRuGPVz3G@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YytRqguZRuGPVz3G@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 21, 2022 at 09:02:29PM +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 21, 2022 at 08:35:35AM -0700, Evan Green wrote:
> > On Mon, Sep 19, 2022 at 9:51 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Tue, Sep 13, 2022 at 08:26:09AM -0400, Stefan Berger wrote:
> > > >
> > > >
> > > > On 8/23/22 18:25, Evan Green wrote:
> > > > > From: Matthew Garrett <matthewgarrett@google.com>
> > > > >
> > > > > Under certain circumstances it might be desirable to enable the creation
> > > > > of TPM-backed secrets that are only accessible to the kernel. In an
> > > > > ideal world this could be achieved by using TPM localities, but these
> > > > > don't appear to be available on consumer systems. An alternative is to
> > > > > simply block userland from modifying one of the resettable PCRs, leaving
> > > > > it available to the kernel. If the kernel ensures that no userland can
> > > > > access the TPM while it is carrying out work, it can reset PCR 23,
> > > > > extend it to an arbitrary value, create or load a secret, and then reset
> > > > > the PCR again. Even if userland somehow obtains the sealed material, it
> > > > > will be unable to unseal it since PCR 23 will never be in the
> > > > > appropriate state.
> > > > >
> > > > > From: Matthew Garrett <mjg59@google.com>
> > > > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > > > >
> > > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > > ---
> > > > > Matthew's original version of this patch is at:
> > > > > https://patchwork.kernel.org/patch/12096491/
> > > > >
> > > > > Changes in v2:
> > > > >   - Fixed sparse warnings
> > > > >
> > > > >   drivers/char/tpm/Kconfig          | 10 +++++++++
> > > > >   drivers/char/tpm/tpm-dev-common.c |  8 +++++++
> > > > >   drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
> > > > >   drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
> > > > >   drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
> > > > >   drivers/char/tpm/tpm2-space.c     |  2 +-
> > > > >   6 files changed, 97 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > > > index 927088b2c3d3f2..4483b61a428b11 100644
> > > > > --- a/drivers/char/tpm/Kconfig
> > > > > +++ b/drivers/char/tpm/Kconfig
> > > > > @@ -211,4 +211,14 @@ config TCG_FTPM_TEE
> > > > >       This driver proxies for firmware TPM running in TEE.
> > > > >   source "drivers/char/tpm/st33zp24/Kconfig"
> > > > > +
> > > > > +config TCG_TPM_RESTRICT_PCR
> > > > > +   bool "Restrict userland access to PCR 23"
> > > > > +   depends on TCG_TPM
> > > > > +   help
> > > > > +     If set, block userland from extending or resetting PCR 23. This
> > > > > +     allows it to be restricted to in-kernel use, preventing userland
> > > > > +     from being able to make use of data sealed to the TPM by the kernel.
> > > > > +     This is required for secure hibernation support, but should be left
> > > > > +     disabled if any userland may require access to PCR23.
> > > > >   endif # TCG_TPM
> > > > > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> > > > > index dc4c0a0a512903..7a4e618c7d1942 100644
> > > > > --- a/drivers/char/tpm/tpm-dev-common.c
> > > > > +++ b/drivers/char/tpm/tpm-dev-common.c
> > > > > @@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
> > > > >     priv->response_read = false;
> > > > >     *off = 0;
> > > > > +   if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
> > > > > +           ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> > > > > +   else
> > > > > +           ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
> > > > > +
> > > > > +   if (ret)
> > > > > +           goto out;
> > > > > +
> > > > >     /*
> > > > >      * If in nonblocking mode schedule an async job to send
> > > > >      * the command return the size.
> > > > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > > > index a80b341d38eb8c..077c3ca0a127ba 100644
> > > > > --- a/drivers/char/tpm/tpm.h
> > > > > +++ b/drivers/char/tpm/tpm.h
> > > > > @@ -229,6 +229,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
> > > > >   unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> > > > >   int tpm2_probe(struct tpm_chip *chip);
> > > > >   int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
> > > > > +int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
> > > > > +                        const void *buf, size_t bufsiz);
> > > > >   int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
> > > > >   int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
> > > > >   void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> > > > > @@ -244,4 +246,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
> > > > >   void tpm_bios_log_teardown(struct tpm_chip *chip);
> > > > >   int tpm_dev_common_init(void);
> > > > >   void tpm_dev_common_exit(void);
> > > > > +
> > > > > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > > > > +#define TPM_RESTRICTED_PCR 23
> > > > > +
> > > > > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > > > > +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > > > > +#else
> > > > > +static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > > > > +                                 size_t size)
> > > > > +{
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > > +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > > > > +                                 size_t size)
> > > > > +{
> > > > > +   return 0;
> > > > > +}
> > > > > +#endif
> > > > >   #endif
> > > > > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > > > > index 8ec743dec26544..318e75ae42fb85 100644
> > > > > --- a/drivers/char/tpm/tpm1-cmd.c
> > > > > +++ b/drivers/char/tpm/tpm1-cmd.c
> > > > > @@ -845,3 +845,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> > > > >     return 0;
> > > > >   }
> > > > > +
> > > > > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > > > > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> > > > > +{
> > > > > +   struct tpm_header *header = (struct tpm_header *)buffer;
> > > > > +   char len, offset;
> > > > > +   __be32 *pcr;
> > > > > +   int pos;
> > > > > +
> > > > > +   switch (be32_to_cpu(header->ordinal)) {
> > > > > +   case TPM_ORD_PCR_EXTEND:
> > > > > +           if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> > > > > +                   return -EINVAL;
> > > > > +           pcr = (__be32 *)&buffer[TPM_HEADER_SIZE];
> > > > > +           if (be32_to_cpu(*pcr) == TPM_RESTRICTED_PCR)
> > > > > +                   return -EPERM;
> > > >
> > > > FYI: TPM 1.2 has transport sessions where the command is tunneled in an
> > > > encrypted channel and this check could be circumvented...
> > >
> > > BTW, Why do we want to support TPM 1.2 at all.
> > >
> > > I would not support it for new features. This could be just TPM2 only
> > > feeature.
> > 
> > I didn't know about the TPM1.2 tunnelling thing, thanks Stefan. Yes,
> > maybe in light of that and Jarkko's comment we shouldn't bend over
> > backwards to make this work on TPM1 and just make it a TPM2-only
> > feature.
> > 
> > Downstream of this decision, in the other patch, "Add support for
> > in-kernel resetting of PCRs", my instinct is to keep the addition of
> > tpm1_pcr_reset() just so the newly introduced generic tpm_pcr_reset()
> > is fully implemented. Let me know if instead I should also drop the
> > tpm1 side of that as well, in the name of "don't add stuff you're not
> > using".
> > -Evan
> 
> You should drop TPM 1.2 support.
> 
> General policy with TPM 1.2:
> 
> 1. Support legacy.
> 2. Do no extend the functionality.

Why? Because we do not want to add legacy to something that is dying.

BR, Jarkko
