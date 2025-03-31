Return-Path: <linux-integrity+bounces-5522-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B9A763F3
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 12:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBD23AA7A1
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7751E04AD;
	Mon, 31 Mar 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcTfgHME"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7F1DFE0A;
	Mon, 31 Mar 2025 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416150; cv=none; b=BYjXf+u75lukLAPyDEoPgVAXi9diSeGPbnPxKjC/eXLtu599lAi/4lz0rXY1fSF9e+N8CYbBrsX0LjcKjhNhsncR1oAOrmjZQ1XwkFb/SsFD84cixHvq6bADV1/iPlVuKBMQeazqITQp82ZX7R+iIco/yhDnXYbWgI8Em+6j4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416150; c=relaxed/simple;
	bh=xarSw2oz1TBNPFF+FSxuyylvE8IEaEtSettU4JXkkpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR4ycbl6LAn2UUi8jAkMeacwW5gwOMKtlyGJ9he/oe/Hby5Rp1irNgzjhLFn0n1AspE9PA+IrxDJly/4DXY2/5VyyWlo9PIY1I3tMr5o+w7ZF3Dh0/Wm4SbJxHNhAgH1fCLKkiOnOo2WjGKVnlmE5ckgBmCh4vr1ObO7z144iNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcTfgHME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F45C4CEE5;
	Mon, 31 Mar 2025 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743416149;
	bh=xarSw2oz1TBNPFF+FSxuyylvE8IEaEtSettU4JXkkpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BcTfgHMEUEaC8K52fmXTZnfu0oETja8uENtB5qW1p1/Ja2g4nGtbaYInr1/k25Dcc
	 rD/QbluJMu8KCOPxNVkfQ/flYOQhMgO/NO1xFS2RDLFotK5ShMVmvd0mYU6p8CrEwy
	 JnYi4zccN8IldfouC8sp6WCr6n9J0kod143SS9nKSWDwSu00pIWY7s/cuZ7BX9ey26
	 +Cplm4kReeftb7KCrApqczaDI/pQy9u8Dnh74/4cqCVa3bsFhpV5ao52O7QG7aq1N1
	 3aNdcX6K5Kz1AAs2YhkVArIGs42FiBimWw4HyiFBD3nns9VYfEZNPkqgVxGqDrZrA+
	 798TjxZgFMidQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so2977908a12.3;
        Mon, 31 Mar 2025 03:15:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSHBUKzCvR6MBDtkguGhEltHZlxVHPAZOp+yHax4ojX6IRAB6Li7K+f8XVq2V0gj+wKdAcsMuESIqoJaXv@vger.kernel.org, AJvYcCWCCvTczNpRXj5vVsdbyTL5j0QQ7SgHgp4IMRMHuExCLpo/4dm1eaUkVD73qNBtAqKHugQ8a5i2+Ag8s9I=@vger.kernel.org, AJvYcCWm5wW7Ax8XSpq2PSO6pLM4vyKldlLVCIJA9YbzX7RuFIWLTF65b/tQLsABZ3j7LNQcOtTXFUVJMvunTTTU/3Ww@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/JciHJYlVACtAJgJv8lv1+n5Bufud86Bs8nBPs1A3MlvWKZmv
	X2DTFLCTfUEtUSpUyptRU028bKC59i1jvmoUBtjRxONQGMbhtYD/fo3koIg2ZF1Cvsx1EdsrvZv
	bqzG8PzBcsEn32BeRcjk3i7U4jYQ=
X-Google-Smtp-Source: AGHT+IHiIrpZ2r0gNJCQ9+/qDMx0Judo1MQ99Nq9zc5YVsgXIa3hjRhHSC6dQuQWbnnMcx9BOEvpj1KCZR5pfIzWXVI=
X-Received: by 2002:a17:907:9726:b0:ac7:33d0:dbe with SMTP id
 a640c23a62f3a-ac738b5472amr703832466b.33.1743416148255; Mon, 31 Mar 2025
 03:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327021940.29969-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20250327021940.29969-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Mar 2025 18:15:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5aYiOCpXNsEvGCdPnS1KxYgjygvPFPP7pWXDoMPncTtg@mail.gmail.com>
X-Gm-Features: AQ5f1JrfZCA-ToCif9d9SrkW_m4ahIxqz6Q5tFtp2lPQpLXSI-cSKQifmwe6XOo
Message-ID: <CAAhV-H5aYiOCpXNsEvGCdPnS1KxYgjygvPFPP7pWXDoMPncTtg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tpm: Add a driver for Loongson TPM device
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de, 
	Yinggang Gu <guyinggang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

On Thu, Mar 27, 2025 at 10:18=E2=80=AFAM Qunqin Zhao <zhaoqunqin@loongson.c=
n> wrote:
>
> Loongson security engine supports random number generation, hash,
> symmetric encryption and asymmetric encryption. Based on these
> encryption functions, TPM2 have been implemented in the Loongson
> security engine firmware. This driver is responsible for copying data
> into the memory visible to the firmware and receiving data from the
> firmware.
>
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
> v6: Replace all "ls6000se" with "loongson"
>     Prefix all with tpm_loongson instead of tpm_lsse.
>     Removed Jarkko's tag cause there are some changes in v6
>
> v5: None
> v4: Prefix all with tpm_lsse instead of tpm.
>     Removed MODULE_AUTHOR fields.
>
> v3: Added reminder about Loongson security engine to git log.
>
>  drivers/char/tpm/Kconfig        |   9 +++
>  drivers/char/tpm/Makefile       |   1 +
>  drivers/char/tpm/tpm_loongson.c | 103 ++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_loongson.c
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 0fc9a510e..5d0e7a1f8 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -225,5 +225,14 @@ config TCG_FTPM_TEE
>         help
>           This driver proxies for firmware TPM running in TEE.
>
> +config TCG_LOONGSON
> +       tristate "Loongson TPM Interface"
> +       depends on MFD_LOONGSON_SE
> +       help
> +         If you want to make Loongson TPM support available, say Yes and
> +         it will be accessible from within Linux. To compile this
> +         driver as a module, choose M here; the module will be called
> +         tpm_loongson.
Moving this entry between TCG_IBMVTPM and TCG_XEN is better
(alpha-betical order), others look good to me.


Huacai

> +
>  source "drivers/char/tpm/st33zp24/Kconfig"
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9bb142c75..e84a2f7a9 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) +=3D xen-tpmfront.o
>  obj-$(CONFIG_TCG_CRB) +=3D tpm_crb.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) +=3D tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) +=3D tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_LOONGSON) +=3D tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loong=
son.c
> new file mode 100644
> index 000000000..91e0390c8
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_loongson.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> +
> +#include <linux/device.h>
> +#include <linux/mfd/loongson-se.h>
> +#include <linux/platform_device.h>
> +#include <linux/wait.h>
> +
> +#include "tpm.h"
> +
> +struct tpm_loongson_msg {
> +       u32 cmd;
> +       u32 data_off;
> +       u32 data_len;
> +       u32 info[5];
> +};
> +
> +struct tpm_loongson_dev {
> +       struct lsse_ch *se_ch;
> +       struct completion tpm_loongson_completion;
> +};
> +
> +static void tpm_loongson_complete(struct lsse_ch *ch)
> +{
> +       struct tpm_loongson_dev *td =3D ch->priv;
> +
> +       complete(&td->tpm_loongson_completion);
> +}
> +
> +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t coun=
t)
> +{
> +       struct tpm_loongson_dev *td =3D dev_get_drvdata(&chip->dev);
> +       struct tpm_loongson_msg *rmsg;
> +       int sig;
> +
> +       sig =3D wait_for_completion_interruptible(&td->tpm_loongson_compl=
etion);
> +       if (sig)
> +               return sig;
> +
> +       rmsg =3D td->se_ch->rmsg;
> +       memcpy(buf, td->se_ch->data_buffer, rmsg->data_len);
> +
> +       return rmsg->data_len;
> +}
> +
> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t coun=
t)
> +{
> +       struct tpm_loongson_dev *td =3D dev_get_drvdata(&chip->dev);
> +       struct tpm_loongson_msg *smsg =3D td->se_ch->smsg;
> +
> +       memcpy(td->se_ch->data_buffer, buf, count);
> +       smsg->data_len =3D count;
> +
> +       return se_send_ch_requeset(td->se_ch);
> +}
> +
> +static const struct tpm_class_ops tpm_loongson_ops =3D {
> +       .flags =3D TPM_OPS_AUTO_STARTUP,
> +       .recv =3D tpm_loongson_recv,
> +       .send =3D tpm_loongson_send,
> +};
> +
> +static int tpm_loongson_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct tpm_loongson_msg *smsg;
> +       struct tpm_loongson_dev *td;
> +       struct tpm_chip *chip;
> +
> +       td =3D devm_kzalloc(dev, sizeof(struct tpm_loongson_dev), GFP_KER=
NEL);
> +       if (!td)
> +               return -ENOMEM;
> +
> +       init_completion(&td->tpm_loongson_completion);
> +       td->se_ch =3D se_init_ch(dev->parent, SE_CH_TPM, PAGE_SIZE,
> +                              2 * sizeof(struct tpm_loongson_msg), td,
> +                              tpm_loongson_complete);
> +       if (!td->se_ch)
> +               return -ENODEV;
> +       smsg =3D td->se_ch->smsg;
> +       smsg->cmd =3D SE_CMD_TPM;
> +       smsg->data_off =3D td->se_ch->off;
> +
> +       chip =3D tpmm_chip_alloc(dev, &tpm_loongson_ops);
> +       if (IS_ERR(chip))
> +               return PTR_ERR(chip);
> +       chip->flags =3D TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> +       dev_set_drvdata(&chip->dev, td);
> +
> +       return tpm_chip_register(chip);
> +}
> +
> +static struct platform_driver tpm_loongson_driver =3D {
> +       .probe   =3D tpm_loongson_probe,
> +       .driver  =3D {
> +               .name  =3D "loongson-tpm",
> +       },
> +};
> +module_platform_driver(tpm_loongson_driver);
> +
> +MODULE_ALIAS("platform:loongson-tpm");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Loongson TPM driver");
> --
> 2.45.2
>
>

