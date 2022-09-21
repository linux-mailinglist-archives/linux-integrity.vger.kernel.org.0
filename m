Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF15E537D
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIUTDK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIUTDJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 15:03:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65489E0D8
        for <linux-integrity@vger.kernel.org>; Wed, 21 Sep 2022 12:03:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r18so15698508eja.11
        for <linux-integrity@vger.kernel.org>; Wed, 21 Sep 2022 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7feVe2Z6rcTKy2SDvo6HS8e1lVg9U6CuFNCTUYVU2Io=;
        b=Ygs+KqdlIK9gXgIHKkdIxoZzNSz9lQd1DupuCw2DqcE/FqqSKVFya1zK9f6ASyl1C+
         NO7apJQgQ/KMAAko1i3tt8ym5pqE8JWeFodtcxho07zVR4IzR9GpPzkFuFIcSUFy9uGY
         FYE9iZM8GoSCasz6Re57hnyu+VL/l71q5JfmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7feVe2Z6rcTKy2SDvo6HS8e1lVg9U6CuFNCTUYVU2Io=;
        b=mx7Rsf1q0skCw+q+6GtCNEqovXLrom2yxaYdybdIFhSZr+358KYhJQHRFNVSYGfw0y
         zGHGj5W18oS88mjcYFv7imLNyEW/J0KtpIBdv3X/15oAR/5RziqBYRfPUGFoU2XK8vyj
         QIRtz7LHIOsbVqVTAQEztECa9AuiLMvchhG/DFMDLMTOqmmzCx9vXdK3xuVP00gltbHm
         gXYfwTMRPsctqbpX0e2mLkxQHf4JtcJDGs0x2N3CHA4NuVxahCk2Mhj8ZKqXISQi+4ZR
         ao8M9OerIUWTf3gJiEfkuu73jMBVjh3aSKqhOtjTHHX8l7fG6XV5r2F+a5XOga6aUKJU
         tkIw==
X-Gm-Message-State: ACrzQf2yy1OK0yp/glnNrId4bkyZI5xr7uSL394uDBSPzVYG/cRQdbN4
        wJNZwOL4XZtVCRON0Hs6ni5bn5neWW03Gw==
X-Google-Smtp-Source: AMsMyM5uswNcxTsqoQyoV8WmF2uoyxVBvt3iPW6ts++pIYwyV2n7CffKpEHua/IGIe93KeY6FUB7zw==
X-Received: by 2002:a17:907:3d94:b0:780:afb5:43b7 with SMTP id he20-20020a1709073d9400b00780afb543b7mr20403130ejc.546.1663786985906;
        Wed, 21 Sep 2022 12:03:05 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id v8-20020aa7cd48000000b0044fc3c0930csm2278719edw.16.2022.09.21.12.03.04
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 12:03:05 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso4394273wms.5
        for <linux-integrity@vger.kernel.org>; Wed, 21 Sep 2022 12:03:04 -0700 (PDT)
X-Received: by 2002:a05:600c:524d:b0:3b4:8ad0:6d with SMTP id
 fc13-20020a05600c524d00b003b48ad0006dmr7135005wmb.194.1663786983431; Wed, 21
 Sep 2022 12:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <4308c2d0-94ae-8a65-e0c7-69270e31d447@linux.ibm.com> <YylGq7eUvaoSyA1u@kernel.org>
 <CAE=gft4-TLDvjtMH+qRJNppkJb798jpKXKXF8nytW7v9d2euRg@mail.gmail.com>
 <YytRqguZRuGPVz3G@kernel.org> <YytSgGQrInFGWQzE@kernel.org>
In-Reply-To: <YytSgGQrInFGWQzE@kernel.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 21 Sep 2022 12:02:26 -0700
X-Gmail-Original-Message-ID: <CAE=gft6CLDb+C9D0NGjzeSokTAbKOtRxutwG-2pMgOnscFdF-A@mail.gmail.com>
Message-ID: <CAE=gft6CLDb+C9D0NGjzeSokTAbKOtRxutwG-2pMgOnscFdF-A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 21, 2022 at 11:05 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 09:02:29PM +0300, Jarkko Sakkinen wrote:
> > On Wed, Sep 21, 2022 at 08:35:35AM -0700, Evan Green wrote:
> > > On Mon, Sep 19, 2022 at 9:51 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Tue, Sep 13, 2022 at 08:26:09AM -0400, Stefan Berger wrote:
> > > > >
> > > > >
> > > > > On 8/23/22 18:25, Evan Green wrote:
> > > > > > From: Matthew Garrett <matthewgarrett@google.com>
> > > > > >
> > > > > > Under certain circumstances it might be desirable to enable the creation
> > > > > > of TPM-backed secrets that are only accessible to the kernel. In an
> > > > > > ideal world this could be achieved by using TPM localities, but these
> > > > > > don't appear to be available on consumer systems. An alternative is to
> > > > > > simply block userland from modifying one of the resettable PCRs, leaving
> > > > > > it available to the kernel. If the kernel ensures that no userland can
> > > > > > access the TPM while it is carrying out work, it can reset PCR 23,
> > > > > > extend it to an arbitrary value, create or load a secret, and then reset
> > > > > > the PCR again. Even if userland somehow obtains the sealed material, it
> > > > > > will be unable to unseal it since PCR 23 will never be in the
> > > > > > appropriate state.
> > > > > >
> > > > > > From: Matthew Garrett <mjg59@google.com>
> > > > > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > > > > >
> > > > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > > > ---
> > > > > > Matthew's original version of this patch is at:
> > > > > > https://patchwork.kernel.org/patch/12096491/
> > > > > >
> > > > > > Changes in v2:
> > > > > >   - Fixed sparse warnings
> > > > > >
> > > > > >   drivers/char/tpm/Kconfig          | 10 +++++++++
> > > > > >   drivers/char/tpm/tpm-dev-common.c |  8 +++++++
> > > > > >   drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
> > > > > >   drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
> > > > > >   drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
> > > > > >   drivers/char/tpm/tpm2-space.c     |  2 +-
> > > > > >   6 files changed, 97 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > > > > index 927088b2c3d3f2..4483b61a428b11 100644
> > > > > > --- a/drivers/char/tpm/Kconfig
> > > > > > +++ b/drivers/char/tpm/Kconfig
> > > > > > @@ -211,4 +211,14 @@ config TCG_FTPM_TEE
> > > > > >       This driver proxies for firmware TPM running in TEE.
> > > > > >   source "drivers/char/tpm/st33zp24/Kconfig"
> > > > > > +
> > > > > > +config TCG_TPM_RESTRICT_PCR
> > > > > > +   bool "Restrict userland access to PCR 23"
> > > > > > +   depends on TCG_TPM
> > > > > > +   help
> > > > > > +     If set, block userland from extending or resetting PCR 23. This
> > > > > > +     allows it to be restricted to in-kernel use, preventing userland
> > > > > > +     from being able to make use of data sealed to the TPM by the kernel.
> > > > > > +     This is required for secure hibernation support, but should be left
> > > > > > +     disabled if any userland may require access to PCR23.
> > > > > >   endif # TCG_TPM
> > > > > > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> > > > > > index dc4c0a0a512903..7a4e618c7d1942 100644
> > > > > > --- a/drivers/char/tpm/tpm-dev-common.c
> > > > > > +++ b/drivers/char/tpm/tpm-dev-common.c
> > > > > > @@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
> > > > > >     priv->response_read = false;
> > > > > >     *off = 0;
> > > > > > +   if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
> > > > > > +           ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> > > > > > +   else
> > > > > > +           ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
> > > > > > +
> > > > > > +   if (ret)
> > > > > > +           goto out;
> > > > > > +
> > > > > >     /*
> > > > > >      * If in nonblocking mode schedule an async job to send
> > > > > >      * the command return the size.
> > > > > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > > > > index a80b341d38eb8c..077c3ca0a127ba 100644
> > > > > > --- a/drivers/char/tpm/tpm.h
> > > > > > +++ b/drivers/char/tpm/tpm.h
> > > > > > @@ -229,6 +229,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
> > > > > >   unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> > > > > >   int tpm2_probe(struct tpm_chip *chip);
> > > > > >   int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
> > > > > > +int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
> > > > > > +                        const void *buf, size_t bufsiz);
> > > > > >   int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
> > > > > >   int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
> > > > > >   void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> > > > > > @@ -244,4 +246,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
> > > > > >   void tpm_bios_log_teardown(struct tpm_chip *chip);
> > > > > >   int tpm_dev_common_init(void);
> > > > > >   void tpm_dev_common_exit(void);
> > > > > > +
> > > > > > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > > > > > +#define TPM_RESTRICTED_PCR 23
> > > > > > +
> > > > > > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > > > > > +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > > > > > +#else
> > > > > > +static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > > > > > +                                 size_t size)
> > > > > > +{
> > > > > > +   return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > > > > > +                                 size_t size)
> > > > > > +{
> > > > > > +   return 0;
> > > > > > +}
> > > > > > +#endif
> > > > > >   #endif
> > > > > > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > > > > > index 8ec743dec26544..318e75ae42fb85 100644
> > > > > > --- a/drivers/char/tpm/tpm1-cmd.c
> > > > > > +++ b/drivers/char/tpm/tpm1-cmd.c
> > > > > > @@ -845,3 +845,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> > > > > >     return 0;
> > > > > >   }
> > > > > > +
> > > > > > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > > > > > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> > > > > > +{
> > > > > > +   struct tpm_header *header = (struct tpm_header *)buffer;
> > > > > > +   char len, offset;
> > > > > > +   __be32 *pcr;
> > > > > > +   int pos;
> > > > > > +
> > > > > > +   switch (be32_to_cpu(header->ordinal)) {
> > > > > > +   case TPM_ORD_PCR_EXTEND:
> > > > > > +           if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> > > > > > +                   return -EINVAL;
> > > > > > +           pcr = (__be32 *)&buffer[TPM_HEADER_SIZE];
> > > > > > +           if (be32_to_cpu(*pcr) == TPM_RESTRICTED_PCR)
> > > > > > +                   return -EPERM;
> > > > >
> > > > > FYI: TPM 1.2 has transport sessions where the command is tunneled in an
> > > > > encrypted channel and this check could be circumvented...
> > > >
> > > > BTW, Why do we want to support TPM 1.2 at all.
> > > >
> > > > I would not support it for new features. This could be just TPM2 only
> > > > feeature.
> > >
> > > I didn't know about the TPM1.2 tunnelling thing, thanks Stefan. Yes,
> > > maybe in light of that and Jarkko's comment we shouldn't bend over
> > > backwards to make this work on TPM1 and just make it a TPM2-only
> > > feature.
> > >
> > > Downstream of this decision, in the other patch, "Add support for
> > > in-kernel resetting of PCRs", my instinct is to keep the addition of
> > > tpm1_pcr_reset() just so the newly introduced generic tpm_pcr_reset()
> > > is fully implemented. Let me know if instead I should also drop the
> > > tpm1 side of that as well, in the name of "don't add stuff you're not
> > > using".
> > > -Evan
> >
> > You should drop TPM 1.2 support.
> >
> > General policy with TPM 1.2:
> >
> > 1. Support legacy.
> > 2. Do no extend the functionality.
>
> Why? Because we do not want to add legacy to something that is dying.

Sounds good, I'll drop the TPM1 stuff from the next spin. Thanks!
-Evan
