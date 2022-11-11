Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63179626299
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Nov 2022 21:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiKKULF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Nov 2022 15:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiKKUK5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Nov 2022 15:10:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763C862E0
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 12:10:44 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id i10so6351456ejg.6
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 12:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VR4/vWLNP/xpllzCte/Py275g7C9+fB697+OV9oedrk=;
        b=ktkdUhxKAfB314ijcJ1QieX1M1io04hxWDfVwpSkQEyO9bXAXAwl4af3V9ngsWDdBJ
         MeCQThrc8DPsqV6JDLqTp43noqe1xjn3mxIzv3W4AIMIJpu8z2GASEntjNl6CQWXP8Zt
         +ut9MSQPxL1QlapXYkVX5MMvOEjz6lTnoIIVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VR4/vWLNP/xpllzCte/Py275g7C9+fB697+OV9oedrk=;
        b=HQDPTtQz2V3okqMIjN9PleIphCIlVPnsmoY5i7GdoEGyV/+1f4fSip4/TS3u3ggNgh
         id54F+IYOD9Gc2O67XjuCLHDDvD9/SUCtiiXODolnl4nNgin4AkxmoAYT7CZsJZr8Oi6
         X5nz3sWrJ24JJHt+suFHQTydw6s8RLTR1tbrfZ6UFYoLYmb999u056lyZetMSSdKKQxP
         qDaIHELPq7h8mCK/j6IyNK3Tex3S3T+LoRs8czsLRrHNV93sEplpvu9Q/1EFKKbwfCvn
         9nyk3VUc2nHtX5TJk+6FXxNF1h/W0CEDZsKP9vXZ53V2KvzTYSflNvNSBvfridgH17ec
         rb4g==
X-Gm-Message-State: ANoB5pkExcNn24u0eWNQ97kc56S03mkPnZauCY+gQ/lH8SnA4OmHgYA3
        XmLER26Zk2z3UFPJ+PsPXUQQ/i64zBJyvw==
X-Google-Smtp-Source: AA0mqf5GvaNc/Ss1YLncY4R08cLQMKVNPkC1foei/UHXitoOzl1nt3ngtNpuZiQXBzDN6gO7RJU9ug==
X-Received: by 2002:a17:906:3547:b0:7aa:40ea:faae with SMTP id s7-20020a170906354700b007aa40eafaaemr3159902eja.551.1668197442514;
        Fri, 11 Nov 2022 12:10:42 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b007aed2057eacsm631445eju.221.2022.11.11.12.10.42
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 12:10:42 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso3793311wmo.1
        for <linux-integrity@vger.kernel.org>; Fri, 11 Nov 2022 12:10:42 -0800 (PST)
X-Received: by 2002:a05:600c:4f53:b0:3cf:8896:e1de with SMTP id
 m19-20020a05600c4f5300b003cf8896e1demr2381421wmq.4.1668197088361; Fri, 11 Nov
 2022 12:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <Y2jujfZ01h5JriYc@kernel.org> <CAE=gft750QYs-AWQ9MC1Z1E==v=m-tf4aKUWjrjBtoWqRJz5dQ@mail.gmail.com>
In-Reply-To: <CAE=gft750QYs-AWQ9MC1Z1E==v=m-tf4aKUWjrjBtoWqRJz5dQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 11 Nov 2022 12:04:11 -0800
X-Gmail-Original-Message-ID: <CAE=gft628xoHYRp2Y8DE94ZVbx5TeMz8Gn3AvqeyCx4LZuTUeg@mail.gmail.com>
Message-ID: <CAE=gft628xoHYRp2Y8DE94ZVbx5TeMz8Gn3AvqeyCx4LZuTUeg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>,
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

On Mon, Nov 7, 2022 at 10:15 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Mon, Nov 7, 2022 at 3:40 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Thu, Nov 03, 2022 at 11:01:11AM -0700, Evan Green wrote:
> > > From: Matthew Garrett <matthewgarrett@google.com>
> > >
> > > Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> > > restricts usermode's ability to extend or reset PCR 23.
> > >
> > > Under certain circumstances it might be desirable to enable the creation
> > > of TPM-backed secrets that are only accessible to the kernel. In an
> > > ideal world this could be achieved by using TPM localities, but these
> > > don't appear to be available on consumer systems. An alternative is to
> > > simply block userland from modifying one of the resettable PCRs, leaving
> > > it available to the kernel. If the kernel ensures that no userland can
> > > access the TPM while it is carrying out work, it can reset PCR 23,
> > > extend it to an arbitrary value, create or load a secret, and then reset
> > > the PCR again. Even if userland somehow obtains the sealed material, it
> > > will be unable to unseal it since PCR 23 will never be in the
> > > appropriate state.
> > >
> > > This Kconfig is only properly supported for systems with TPM2 devices.
> > > For systems with TPM1 devices, having this Kconfig enabled completely
> > > restricts usermode's access to the TPM. TPM1 contains support for
> > > tunnelled transports, which usermode could use to smuggle commands
> > > through that this Kconfig is attempting to restrict.
> > >
> > > Link: https://lore.kernel.org/lkml/20210220013255.1083202-3-matthewgarrett@google.com/
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > >  - Augment the commit message (Jarkko)
> > >
> > > Changes in v3:
> > >  - Fix up commit message (Jarkko)
> > >  - tpm2_find_and_validate_cc() was split (Jarkko)
> > >  - Simply fully restrict TPM1 since v2 failed to account for tunnelled
> > >    transport sessions (Stefan and Jarkko).
> > >
> > > Changes in v2:
> > >  - Fixed sparse warnings
> > >
> > >  drivers/char/tpm/Kconfig          | 12 ++++++++++++
> > >  drivers/char/tpm/tpm-dev-common.c |  8 ++++++++
> > >  drivers/char/tpm/tpm.h            | 19 +++++++++++++++++++
> > >  drivers/char/tpm/tpm1-cmd.c       | 13 +++++++++++++
> > >  drivers/char/tpm/tpm2-cmd.c       | 22 ++++++++++++++++++++++
> > >  5 files changed, 74 insertions(+)
> > >
> > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > index 927088b2c3d3f2..c8ed54c66e399a 100644
> > > --- a/drivers/char/tpm/Kconfig
> > > +++ b/drivers/char/tpm/Kconfig
> > > @@ -211,4 +211,16 @@ config TCG_FTPM_TEE
> > >         This driver proxies for firmware TPM running in TEE.
> > >
> > >  source "drivers/char/tpm/st33zp24/Kconfig"
> > > +
> > > +config TCG_TPM_RESTRICT_PCR
> > > +     bool "Restrict userland access to PCR 23"
> > > +     depends on TCG_TPM
> > > +     help
> > > +       If set, block userland from extending or resetting PCR 23. This allows it
> > > +       to be restricted to in-kernel use, preventing userland from being able to
> > > +       make use of data sealed to the TPM by the kernel. This is required for
> > > +       secure hibernation support, but should be left disabled if any userland
> > > +       may require access to PCR23. This is a TPM2-only feature, and if enabled
> > > +       on a TPM1 machine will cause all usermode TPM commands to return EPERM due
> > > +       to the complications introduced by tunnelled sessions in TPM1.2.
> > >  endif # TCG_TPM
> > > diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> > > index dc4c0a0a512903..7a4e618c7d1942 100644
> > > --- a/drivers/char/tpm/tpm-dev-common.c
> > > +++ b/drivers/char/tpm/tpm-dev-common.c
> > > @@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
> > >       priv->response_read = false;
> > >       *off = 0;
> > >
> > > +     if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
> > > +             ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> > > +     else
> > > +             ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
> > > +
> > > +     if (ret)
> > > +             goto out;
> > > +
> > >       /*
> > >        * If in nonblocking mode schedule an async job to send
> > >        * the command return the size.
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index f1e0f490176f01..c0845e3f9eda17 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -245,4 +245,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
> > >  void tpm_bios_log_teardown(struct tpm_chip *chip);
> > >  int tpm_dev_common_init(void);
> > >  void tpm_dev_common_exit(void);
> > > +
> > > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > > +#define TPM_RESTRICTED_PCR 23
> > > +
> > > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > > +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> > > +#else
> > > +static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > > +                                   size_t size)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> > > +                                   size_t size)
> > > +{
> > > +     return 0;
> > > +}
> > > +#endif
> > >  #endif
> > > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > > index cf64c738510529..1869e89215fcb9 100644
> > > --- a/drivers/char/tpm/tpm1-cmd.c
> > > +++ b/drivers/char/tpm/tpm1-cmd.c
> > > @@ -811,3 +811,16 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> > >
> > >       return 0;
> > >  }
> > > +
> > > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > > +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> > > +{
> > > +     /*
> > > +      * Restrict all usermode commands on TPM1.2. Ideally we'd just restrict
> > > +      * TPM_ORD_PCR_EXTEND and TPM_ORD_PCR_RESET, but TPM1.2 also supports
> > > +      * tunnelled transport sessions where the kernel would be unable to filter
> > > +      * commands.
> > > +      */
> > > +     return -EPERM;
> > > +}
> > > +#endif
> > > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > > index 303ce2ea02a4b0..e0503cfd7bcfee 100644
> > > --- a/drivers/char/tpm/tpm2-cmd.c
> > > +++ b/drivers/char/tpm/tpm2-cmd.c
> > > @@ -778,3 +778,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
> > >
> > >       return -1;
> > >  }
> > > +
> > > +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> > > +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> > > +{
> > > +     int cc = tpm2_find_and_validate_cc(chip, NULL, buffer, size);
> > > +     __be32 *handle;
> > > +
> > > +     switch (cc) {
> > > +     case TPM2_CC_PCR_EXTEND:
> > > +     case TPM2_CC_PCR_RESET:
> > > +             if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> > > +                     return -EINVAL;
> > > +
> > > +             handle = (__be32 *)&buffer[TPM_HEADER_SIZE];
> > > +             if (be32_to_cpu(*handle) == TPM_RESTRICTED_PCR)
> > > +                     return -EPERM;
> > > +             break;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +#endif
> > > --
> > > 2.38.1.431.g37b22c650d-goog
> > >
> >
> > This looks otherwise good but I have still one remark: what is the reason
> > for restricting PCR23 for TPM 1.x?
>
> Mostly I was trying to do the least surprising thing for someone who
> had compiled with this RESTRICT_PCR Kconfig enabled but booted a TPM1
> system. If we do nothing for TPM1, then the encrypted hibernation
> mechanism appears to work fine, but leaves a gaping hole where
> usermode can manipulate PCR23 themselves to create forged encrypted
> hibernate images. Denying all usermode access makes the Kconfig
> correct on TPM1 systems, at the expense of all usermode access (rather
> than just access to PCR23).
>
> An alternative that might be friendlier to users would be to do a
> runtime check in the encrypted hibernate code to simply fail if this
> isn't TPM2. The tradeoff there is that it waters down the Kconfig
> significantly to "RESTRICT_PCR sometimes, if you can, otherwise meh".
> That seemed a bit dangerous, as any future features that may want to
> rely on this Kconfig would have to remember to restrict their support
> to TPM2 as well.

I got talked into revising my stance here, in that breaking usermode
access to TPM1.2 if this Kconfig is set means virtually nobody can
enable this Kconfig. Plus I think doing nothing for TPM1.2 will make
Jarkko happier :). So my new plan is to rename this config to
TCG_TPM2_RESTRICT_PCR, and then try to document very clearly that this
Kconfig only restricts usermode access to the PCR on TPM2.0 devices.
The hibernate code already blocks TPM1.2 devices, so from this series'
perspective the upcoming change should be a no-op.



-Evan
