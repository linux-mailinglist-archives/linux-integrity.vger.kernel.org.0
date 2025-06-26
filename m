Return-Path: <linux-integrity+bounces-6547-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A8BAE9DCA
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 14:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B4C18865B0
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 12:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110E92E11BF;
	Thu, 26 Jun 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHn4Bk3o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5EB21CA18;
	Thu, 26 Jun 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942134; cv=none; b=Vtkut796Q1+tDNIhZcUQfGJLPsrWRcFk8WAb4/ga+U6d4B0hXrFlEM5a7OId8P437pjH0jd+QUs2lGu+7kiHA2Z2U2oUMwXYZTOVuAOKDscDDTlPumIPAi75+mkOYQ3VREMnXZUOyMjjwC7oV79Ade4MJe9ILddj1Wer5SNihW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942134; c=relaxed/simple;
	bh=GBR2+0OFYN1ZObHhvIHvnH034PkknP6dXVPJKHAFliY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDBtRO9WUEa50lUdnOJrOIPzGHMJep0+xrorEBz/nEys9Yvjxk6IUnYu4xvC25n38utT0BYefgQNuJPh4E4KiSea3/2OQ8SV4Mdwq9Twa8Sk44zJ/tBDwwo4rlCUcUfh6uHyRIBCmG00FTF1a0ehU/pzxGpEBZZbxvBQaWh2u9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHn4Bk3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE28C4AF09;
	Thu, 26 Jun 2025 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750942133;
	bh=GBR2+0OFYN1ZObHhvIHvnH034PkknP6dXVPJKHAFliY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LHn4Bk3ovVRMZ6P5ps+8nxc1HkM3GvD5D+YpTxvtZAbblU8XqIAMTBOZ/sc6DlpvR
	 c3PcAUQIGABFbnIS7kaC/KWP5ICNMfQ4Cpe6hod0KW0KDY8156MnQso7MzfQHSdXbn
	 DcohcdW/cnNCRKOjxmDDc+gsElTA1ge3VIyIlS1NXwl9qrv161iB5HlyrrdGNONjrZ
	 HUiC7qDhbMLZ68SXkz+EVI9PKf6xQ7XYM0yZIqyN1kN/a/NrtgdFzpRYcbenGI9adL
	 yhJ9fbT/wy7pXYYwwiGyZ9rRUQ8XDgCARAJ3n5W3DEXGtmH0Z0lof5537oWEGnWOwE
	 n+BAGFglB4wBQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so1957669a12.2;
        Thu, 26 Jun 2025 05:48:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3ZXmgohZTJOdGQK6khucX64JSlzricLi0DTMdOO/520dIAYL4GXd1sM30Dr4mDlURenAuyTZ7Hqna1ITS@vger.kernel.org, AJvYcCUfB+IQ/ZuLwprFrlemlw+wE7ChL+zrFR8+kpoLucpoWWzBhDQ43mXkvYbY/x9MjankY5ayEBlNlXsgMrY=@vger.kernel.org, AJvYcCUsdGKH/gd7vqwhnsFgUL82M3YfXbAjat2TTvFaqqOOztG9kO3KpfVjbBOpOq5Zha/0/0dzeDn9OMdkCoSPk15h@vger.kernel.org
X-Gm-Message-State: AOJu0YzynMoHJKrQpPEE3qT9pI9YpJimSs5lhZW9cjyfx79MYVD5BE70
	QVgKONKnsYq6V5MKk+07sPChoee/sEa99bQ3MqckFej9Mo+OucDZxKgvbFsLWspL8F1s30cVtSb
	6p8BDsYWd+UdcGgHVgKCrbqtzOXS5HM8=
X-Google-Smtp-Source: AGHT+IG241ireDSwccz0E1Aketjghy187dnSlteXhMqy5mR3RyzT/SQgU6uQGbbjvwWfQLW80GsRT42xbOMpmIrhHsQ=
X-Received: by 2002:a05:6402:3513:b0:608:4945:ca47 with SMTP id
 4fb4d7f45d1cf-60c6698f22dmr3303398a12.17.1750942132056; Thu, 26 Jun 2025
 05:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn> <20250619025138.2854-4-zhaoqunqin@loongson.cn>
 <aFs2RDOeOKvWUN2L@kernel.org> <20250625080527.GN795775@google.com>
 <aFvhorr3kZSuzVpv@kernel.org> <20250625134047.GX795775@google.com>
 <aFwsIs6ri3HZictC@kernel.org> <20250626103030.GA10134@google.com> <aF0oHDVQKVfGZNV2@kernel.org>
In-Reply-To: <aF0oHDVQKVfGZNV2@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Jun 2025 20:48:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7nyKHS70BGh7nwjuGwSWayCbUY=1-zWMU4N3bJZtH1gQ@mail.gmail.com>
X-Gm-Features: Ac12FXyKHwBO2MzQTxDMQ09xuJXSBLQFTQuAYHXcZc2O_q5wOUNjfptrkg3vMvc
Message-ID: <CAAhV-H7nyKHS70BGh7nwjuGwSWayCbUY=1-zWMU4N3bJZtH1gQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Qunqin Zhao <zhaoqunqin@loongson.cn>, herbert@gondor.apana.org.au, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, Yinggang Gu <guyinggang@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 6:59=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Thu, Jun 26, 2025 at 11:30:30AM +0100, Lee Jones wrote:
> > On Wed, 25 Jun 2025, Jarkko Sakkinen wrote:
> >
> > > On Wed, Jun 25, 2025 at 02:40:47PM +0100, Lee Jones wrote:
> > > > On Wed, 25 Jun 2025, Jarkko Sakkinen wrote:
> > > >
> > > > > On Wed, Jun 25, 2025 at 09:05:27AM +0100, Lee Jones wrote:
> > > > > > On Wed, 25 Jun 2025, Jarkko Sakkinen wrote:
> > > > > >
> > > > > > > On Thu, Jun 19, 2025 at 10:51:37AM +0800, Qunqin Zhao wrote:
> > > > > > > > Loongson Security Engine supports random number generation,=
 hash,
> > > > > > > > symmetric encryption and asymmetric encryption. Based on th=
ese
> > > > > > > > encryption functions, TPM2 have been implemented in the Loo=
ngson
> > > > > > > > Security Engine firmware. This driver is responsible for co=
pying data
> > > > > > > > into the memory visible to the firmware and receiving data =
from the
> > > > > > > > firmware.
> > > > > > > >
> > > > > > > > Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > > > > > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > > > > > > > Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> > > > > > > > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > > > ---
> > > > > > > >  drivers/char/tpm/Kconfig        |  9 ++++
> > > > > > > >  drivers/char/tpm/Makefile       |  1 +
> > > > > > > >  drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++=
++++++++++++
> > > > > > > >  3 files changed, 94 insertions(+)
> > > > > > > >  create mode 100644 drivers/char/tpm/tpm_loongson.c
> > > > > > > >
> > > > > > > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kc=
onfig
> > > > > > > > index dddd702b2..ba3924eb1 100644
> > > > > > > > --- a/drivers/char/tpm/Kconfig
> > > > > > > > +++ b/drivers/char/tpm/Kconfig
> > > > > > > > @@ -189,6 +189,15 @@ config TCG_IBMVTPM
> > > > > > > >     will be accessible from within Linux.  To compile this =
driver
> > > > > > > >     as a module, choose M here; the module will be called t=
pm_ibmvtpm.
> > > > > > > >
> > > > > > > > +config TCG_LOONGSON
> > > > > > > > + tristate "Loongson TPM Interface"
> > > > > > > > + depends on MFD_LOONGSON_SE
> > > > > > > > + help
> > > > > > > > +   If you want to make Loongson TPM support available, say=
 Yes and
> > > > > > > > +   it will be accessible from within Linux. To compile thi=
s
> > > > > > > > +   driver as a module, choose M here; the module will be c=
alled
> > > > > > > > +   tpm_loongson.
> > > > > > > > +
> > > > > > > >  config TCG_XEN
> > > > > > > >   tristate "XEN TPM Interface"
> > > > > > > >   depends on TCG_TPM && XEN
> > > > > > > > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/M=
akefile
> > > > > > > > index 9de1b3ea3..5b5cdc0d3 100644
> > > > > > > > --- a/drivers/char/tpm/Makefile
> > > > > > > > +++ b/drivers/char/tpm/Makefile
> > > > > > > > @@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) +=3D tpm_cr=
b_ffa.o
> > > > > > > >  obj-$(CONFIG_TCG_VTPM_PROXY) +=3D tpm_vtpm_proxy.o
> > > > > > > >  obj-$(CONFIG_TCG_FTPM_TEE) +=3D tpm_ftpm_tee.o
> > > > > > > >  obj-$(CONFIG_TCG_SVSM) +=3D tpm_svsm.o
> > > > > > > > +obj-$(CONFIG_TCG_LOONGSON) +=3D tpm_loongson.o
> > > > > > > > diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char=
/tpm/tpm_loongson.c
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000..5cbdb37f8
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/char/tpm/tpm_loongson.c
> > > > > > > > @@ -0,0 +1,84 @@
> > > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > > +/* Copyright (c) 2025 Loongson Technology Corporation Limi=
ted. */
> > > > > > > > +
> > > > > > > > +#include <linux/device.h>
> > > > > > > > +#include <linux/mfd/loongson-se.h>
> > > > > > > > +#include <linux/platform_device.h>
> > > > > > > > +#include <linux/wait.h>
> > > > > > > > +
> > > > > > > > +#include "tpm.h"
> > > > > > > > +
> > > > > > > > +struct tpm_loongson_cmd {
> > > > > > > > + u32 cmd_id;
> > > > > > > > + u32 data_off;
> > > > > > > > + u32 data_len;
> > > > > > > > + u32 pad[5];
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *bu=
f, size_t count)
> > > > > > > > +{
> > > > > > > > + struct loongson_se_engine *tpm_engine =3D dev_get_drvdata=
(&chip->dev);
> > > > > > > > + struct tpm_loongson_cmd *cmd_ret =3D tpm_engine->command_=
ret;
> > > > > > > > +
> > > > > > > > + if (cmd_ret->data_len > count)
> > > > > > > > +         return -EIO;
> > > > > > > > +
> > > > > > > > + memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> > > > > > > > +
> > > > > > > > + return cmd_ret->data_len;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int tpm_loongson_send(struct tpm_chip *chip, u8 *bu=
f, size_t count)
> > > > > > > > +{
> > > > > > > > + struct loongson_se_engine *tpm_engine =3D dev_get_drvdata=
(&chip->dev);
> > > > > > > > + struct tpm_loongson_cmd *cmd =3D tpm_engine->command;
> > > > > > > > +
> > > > > > > > + if (count > tpm_engine->buffer_size)
> > > > > > > > +         return -E2BIG;
> > > > > > > > +
> > > > > > > > + cmd->data_len =3D count;
> > > > > > > > + memcpy(tpm_engine->data_buffer, buf, count);
> > > > > > > > +
> > > > > > > > + return loongson_se_send_engine_cmd(tpm_engine);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static const struct tpm_class_ops tpm_loongson_ops =3D {
> > > > > > > > + .flags =3D TPM_OPS_AUTO_STARTUP,
> > > > > > > > + .recv =3D tpm_loongson_recv,
> > > > > > > > + .send =3D tpm_loongson_send,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static int tpm_loongson_probe(struct platform_device *pdev=
)
> > > > > > > > +{
> > > > > > > > + struct loongson_se_engine *tpm_engine;
> > > > > > > > + struct device *dev =3D &pdev->dev;
> > > > > > > > + struct tpm_loongson_cmd *cmd;
> > > > > > > > + struct tpm_chip *chip;
> > > > > > > > +
> > > > > > > > + tpm_engine =3D loongson_se_init_engine(dev->parent, SE_EN=
GINE_TPM);
> > > > > > > > + if (!tpm_engine)
> > > > > > > > +         return -ENODEV;
> > > > > > > > + cmd =3D tpm_engine->command;
> > > > > > > > + cmd->cmd_id =3D SE_CMD_TPM;
> > > > > > > > + cmd->data_off =3D tpm_engine->buffer_off;
> > > > > > > > +
> > > > > > > > + chip =3D tpmm_chip_alloc(dev, &tpm_loongson_ops);
> > > > > > > > + if (IS_ERR(chip))
> > > > > > > > +         return PTR_ERR(chip);
> > > > > > > > + chip->flags =3D TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> > > > > > > > + dev_set_drvdata(&chip->dev, tpm_engine);
> > > > > > > > +
> > > > > > > > + return tpm_chip_register(chip);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static struct platform_driver tpm_loongson =3D {
> > > > > > > > + .probe   =3D tpm_loongson_probe,
> > > > > > > > + .driver  =3D {
> > > > > > > > +         .name  =3D "loongson-tpm",
> > > > > > >
> > > > > > > This patch looks otherwise great but I'd prefer here tho use
> > > > > > > "tpm_loongson_probe" for the value of the name field.
> > > > > >
> > > > > > Where does this stipulation come from?  No other driver does th=
is [0].
> > > > > > driver.name should be a nicely formatted, human readable string
> > > > > > describing the name of the device.  Not a function name.
> > > > >
> > > > > What defines "human-readable" here? I see both as somewhat the
> > > > > same level of "readability" ;-)
> > > > >
> > > > > >
> > > > > > [0] git grep -A15 "static struct platform_driver" | grep ".name=
 =3D .*probe"
> > > > >
> > > > > What I'm getting:
> > > > >
> > > > > $ git grep -l -e platform_driver_register --or -e module_platform=
_driver
> > > > > drivers/char/tpm | xargs git grep "\.name"
> > > > > drivers/char/tpm/tpm_atmel.c:           .name =3D "tpm_atmel",
> > > > > drivers/char/tpm/tpm_ftpm_tee.c:                .name =3D "ftpm-t=
ee",
> > > > > drivers/char/tpm/tpm_ftpm_tee.c:                .name           =
=3D
> > > > > "optee-ftpm",
> > > > > drivers/char/tpm/tpm_nsc.c:             .name    =3D "tpm_nsc",
> > > > > drivers/char/tpm/tpm_svsm.c:            .name =3D "tpm-svsm",
> > > > > drivers/char/tpm/tpm_tis.c:     .name =3D "tpm_tis",
> > > > > drivers/char/tpm/tpm_tis.c:             .name           =3D "tpm_=
tis",
> > > > > drivers/char/tpm/tpm_tis_synquacer.c:           .name           =
=3D
> > > > > "tpm_tis_synquacer",
> > > > >
> > > > > Do you consider e.g, "tpm_tis" as "less human-readable".
> > > > >
> > > > > I don't necessarily fight against the name chosen. Your arguments
> > > > > just plain no make sense, so I just merely want to understand thi=
s.
> > > > > That's all.
> > > >
> > > > In 64% of cases '-' is preferred to '_' for device names.
> > > >
> > > > Human readable is probably a bit of a stretch in this context, so I=
'll
> > > > retract that part of the statement.  However, we should be using de=
vice
> > > > names, not names of functions which remain meaningless (which is wh=
at I
> > > > really meant by 'readable') to the user.  Where else do you see the
> > > > .probe() function name being used as a device name?
> > >
> > > Oops now I see what you mean. I meant to write "tpm_loongson", i.e.
> > > matching tpm_tis, tpm_crb etc. Sorry my bad.
> >
> > Ah, gotcha.  No worries.
> >
> > "tpm_loongson" wouldn't be my preference, but is acceptable.
>
> It's more like that I'm worried about coherency. There's now bunch
> of convention (looking at grep). So I need to pick one and not
> increase chaos further :-) tpm_* is the preference as it is still
> dominating convention.
But there is another coherency, you can see this in the 1st patch:

+static const struct mfd_cell engines[] =3D {
+ { .name =3D "loongson-rng" },
+ { .name =3D "loongson-tpm" },
+};

Huacai

>
>
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>
> BR, Jarkko
>

