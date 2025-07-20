Return-Path: <linux-integrity+bounces-6656-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF8B0B30B
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Jul 2025 03:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F45F3B92F0
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Jul 2025 01:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F028E3F;
	Sun, 20 Jul 2025 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laNYqIxM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC68195;
	Sun, 20 Jul 2025 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752973539; cv=none; b=NOPYVWIzVlQkQaiuimazDhc4ZJHp4x5rdJLQGgAYZKiS03vgklsNLxlyNPDLZ1U2RbspbqG8Jipa2WZqM79jywyhidAVhfnJwJ9fc+/svw52nMRLlGPyn6bPJav0a4qXdXojOQUwrKXLtfOj5ADhZAnEm+aTEt1MdGTIkSRNeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752973539; c=relaxed/simple;
	bh=Wy9HvyjMJcyUHBXYT+6hVFplod28t8tELh5gG/virg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euUW3xIxlDE9OeFmx2lRYSUkbz2rTMz3m2CPfv6Mi6K3067DRY3E8M2GNfYfVBBSkZW023QoroFRQ6jzvCsFZfEeWNQcL1kJQ8Q8Ty2RhGvZWq5tVC0TdBR0RvgZhIKgbO3p3+7Tv2GRCgB81kgGfSQeM2PU5w6YD0KXb6HwEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laNYqIxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27613C4CEF7;
	Sun, 20 Jul 2025 01:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752973538;
	bh=Wy9HvyjMJcyUHBXYT+6hVFplod28t8tELh5gG/virg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=laNYqIxMUIk/CS0ctv5qm4hOATPNtM+oT1fWYrvd0Sv4KzxzDD408YV7yaA4KlR0O
	 VsDCA6nCNTG3dQPZos32HpypexbWG/lyd1Hx6miwxekMQ0ULuFKJ6z1+814M0qJL4Z
	 fhr3o74m+4V5q59bCXTv+sSR4PJrOPDnHnf/2DrqFf7LOH/qeY355Zo9n47CzCvvNq
	 5TPEOvGjDr57yBcHvFffVq0J8RYLeW0xI8JTa78mbpZBE1tfcWLi1G/oilUoAwtQY3
	 N9a/l1VwJJxpxNEV1YU8NIamNurrH1b3w06WiIrzrqfGkp0Th1U4o7nO9kWnuy6GYQ
	 M62bH31bIGpYQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so5632605a12.3;
        Sat, 19 Jul 2025 18:05:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHKhVOzmHyeowWIPOG4AaJwB7jpMdfyqpns07llLmREIoS7Fe1cYbpeqA2Q5W5vQohGT4byS2j2WzfqHMs@vger.kernel.org, AJvYcCUxgYtuCoGORDP2weBcJlK6kFbTrZjrYSjzYT2LyihjQESM/cMuyKpR2OxVrYKcG0+jl34YDeUtpl0+x+I=@vger.kernel.org, AJvYcCXQmaA8ccHVNSI7pieA39316CD2Wk6nNr/pd2zRQaLWKJdXK19QwFL5avc7dTWopn97VYHBY6fXHhcjvnn2MIj5@vger.kernel.org
X-Gm-Message-State: AOJu0YytJHE3sNNEoUVJ3Evl9xvQHXDvGKEfJ5uSdt0EBx2o1Ha+8RwM
	PKY+lQObL8vV9i9Odke2Q/S/62Lvcqa0c5Jm8c/ODGNPrjqDkHymzQqbj+t0EDtKbn7oo23V9+y
	bNSbKfnm6r5opGx2y2JYoRPgOQ81CsMw=
X-Google-Smtp-Source: AGHT+IHk2PDp/9RmO2oo5L5BlV0YU4G/MBjwLeBhRCBEXyekkN4nrhj/X2Qev3Fn+qiq8dTMwSJCxqz2UBE51GvfA70=
X-Received: by 2002:a05:6402:2749:b0:5f6:fab2:9128 with SMTP id
 4fb4d7f45d1cf-612a4ed19e0mr9835314a12.19.1752973536619; Sat, 19 Jul 2025
 18:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn> <20250705072045.1067-4-zhaoqunqin@loongson.cn>
 <aHuK_pY2Ap4B7JWZ@kernel.org>
In-Reply-To: <aHuK_pY2Ap4B7JWZ@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 20 Jul 2025 09:05:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5QKBunqL0qnW8t+LJ+SJRHd5nUrPo1_fvKMvmw_oUosQ@mail.gmail.com>
X-Gm-Features: Ac12FXwPTh_AWmjx_VYa-G3YFiNCHCAsuwAzvh2TsFofH01f_AUGA7am5vgSG8I
Message-ID: <CAAhV-H5QKBunqL0qnW8t+LJ+SJRHd5nUrPo1_fvKMvmw_oUosQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] tpm: Add a driver for Loongson TPM device
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, lee@kernel.org, herbert@gondor.apana.org.au, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, Yinggang Gu <guyinggang@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jarkko,

On Sat, Jul 19, 2025 at 8:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Sat, Jul 05, 2025 at 03:20:44PM +0800, Qunqin Zhao wrote:
> > Loongson Security Engine supports random number generation, hash,
> > symmetric encryption and asymmetric encryption. Based on these
> > encryption functions, TPM2 have been implemented in the Loongson
> > Security Engine firmware. This driver is responsible for copying data
> > into the memory visible to the firmware and receiving data from the
> > firmware.
> >
> > Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/char/tpm/Kconfig        |  9 ++++
> >  drivers/char/tpm/Makefile       |  1 +
> >  drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++++++++++++++
> >  3 files changed, 94 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_loongson.c
> >
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index dddd702b2..ba3924eb1 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -189,6 +189,15 @@ config TCG_IBMVTPM
> >         will be accessible from within Linux.  To compile this driver
> >         as a module, choose M here; the module will be called tpm_ibmvt=
pm.
> >
> > +config TCG_LOONGSON
> > +     tristate "Loongson TPM Interface"
> > +     depends on MFD_LOONGSON_SE
> > +     help
> > +       If you want to make Loongson TPM support available, say Yes and
> > +       it will be accessible from within Linux. To compile this
> > +       driver as a module, choose M here; the module will be called
> > +       tpm_loongson.
> > +
> >  config TCG_XEN
> >       tristate "XEN TPM Interface"
> >       depends on TCG_TPM && XEN
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index 9de1b3ea3..5b5cdc0d3 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) +=3D tpm_crb_ffa.o
> >  obj-$(CONFIG_TCG_VTPM_PROXY) +=3D tpm_vtpm_proxy.o
> >  obj-$(CONFIG_TCG_FTPM_TEE) +=3D tpm_ftpm_tee.o
> >  obj-$(CONFIG_TCG_SVSM) +=3D tpm_svsm.o
> > +obj-$(CONFIG_TCG_LOONGSON) +=3D tpm_loongson.o
> > diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loo=
ngson.c
> > new file mode 100644
> > index 000000000..a4ec23639
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm_loongson.c
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> > +
> > +#include <linux/device.h>
> > +#include <linux/mfd/loongson-se.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/wait.h>
> > +
> > +#include "tpm.h"
> > +
> > +struct tpm_loongson_cmd {
> > +     u32 cmd_id;
> > +     u32 data_off;
> > +     u32 data_len;
> > +     u32 pad[5];
> > +};
> > +
> > +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t co=
unt)
> > +{
> > +     struct loongson_se_engine *tpm_engine =3D dev_get_drvdata(&chip->=
dev);
> > +     struct tpm_loongson_cmd *cmd_ret =3D tpm_engine->command_ret;
> > +
> > +     if (cmd_ret->data_len > count)
> > +             return -EIO;
> > +
> > +     memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> > +
> > +     return cmd_ret->data_len;
> > +}
> > +
> > +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t co=
unt)
> > +{
> > +     struct loongson_se_engine *tpm_engine =3D dev_get_drvdata(&chip->=
dev);
> > +     struct tpm_loongson_cmd *cmd =3D tpm_engine->command;
> > +
> > +     if (count > tpm_engine->buffer_size)
> > +             return -E2BIG;
> > +
> > +     cmd->data_len =3D count;
> > +     memcpy(tpm_engine->data_buffer, buf, count);
> > +
> > +     return loongson_se_send_engine_cmd(tpm_engine);
> > +}
> > +
> > +static const struct tpm_class_ops tpm_loongson_ops =3D {
> > +     .flags =3D TPM_OPS_AUTO_STARTUP,
> > +     .recv =3D tpm_loongson_recv,
> > +     .send =3D tpm_loongson_send,
> > +};
> > +
> > +static int tpm_loongson_probe(struct platform_device *pdev)
> > +{
> > +     struct loongson_se_engine *tpm_engine;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct tpm_loongson_cmd *cmd;
> > +     struct tpm_chip *chip;
> > +
> > +     tpm_engine =3D loongson_se_init_engine(dev->parent, SE_ENGINE_TPM=
);
> > +     if (!tpm_engine)
> > +             return -ENODEV;
> > +     cmd =3D tpm_engine->command;
> > +     cmd->cmd_id =3D SE_CMD_TPM;
> > +     cmd->data_off =3D tpm_engine->buffer_off;
> > +
> > +     chip =3D tpmm_chip_alloc(dev, &tpm_loongson_ops);
> > +     if (IS_ERR(chip))
> > +             return PTR_ERR(chip);
> > +     chip->flags =3D TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> > +     dev_set_drvdata(&chip->dev, tpm_engine);
> > +
> > +     return tpm_chip_register(chip);
> > +}
> > +
> > +static struct platform_driver tpm_loongson =3D {
> > +     .probe   =3D tpm_loongson_probe,
> > +     .driver  =3D {
> > +             .name  =3D "tpm_loongson",
> > +     },
> > +};
> > +module_platform_driver(tpm_loongson);
> > +
> > +MODULE_ALIAS("platform:tpm_loongson");
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Loongson TPM driver");
> > --
> > 2.45.2
> >
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Can you take this through loongson tree? It's highly unlikely to
> conflict with anything.
It is better to get upstream through the tpmdd tree, and Stefano's
suggestions should be addressed first.

Huacai

>
> BR, Jarkko
>

