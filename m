Return-Path: <linux-integrity+bounces-5521-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74BEA763ED
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 12:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD5416825E
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E641DAC81;
	Mon, 31 Mar 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikzoz86/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9427726;
	Mon, 31 Mar 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416136; cv=none; b=SVdmHbkUYKnAWvsMrHryGCog1KoiDp0/oOYn2jpb2mneODbEIHgW9Of2tp79/rxgUDmHNrJXiGImqeAr5MlqyZQxlmk1pTwfGmy/F788TAAdAEw8BLNo9mjPIlpVx3Nq8B3fVqGpYu/RUgX0OdsbGVRS2zw7Y1ygOTJy1I8xZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416136; c=relaxed/simple;
	bh=n/4COzO4gMf0SnjP1aJaKrr7So+8HZxWI/tdajgQLHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cApNB0f9v9cWrMQOCIdOpOShOOp+cQaRN0WlGKm78SO+93t3P4zeNHK/SJ0D3YDPIOU11ckcPMlSpOtmaIAqUnW1E/ovCxSVhvn6v3n544DjuoevXGvdJ0P/64Zgt8ZkSvPSASV43GnHjo7eTxNaY4G03h4d0W7GNWCTg9IdnNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikzoz86/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E224FC4CEED;
	Mon, 31 Mar 2025 10:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743416135;
	bh=n/4COzO4gMf0SnjP1aJaKrr7So+8HZxWI/tdajgQLHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ikzoz86/mJBFdLZmuKXOmswQ9V53sVhfI33od6Q7MkLwr7vwQQVwA3zLC3ZX2kc3k
	 pPHNuj52VImTcWMy3avlBQ6dyx68swDb1Oq0XC3MjpKVDC5go5GrQZI50LDdOF8VCv
	 CEbUO3YYXtvS32+XxZBxh5IGPzBQonRrJyt+9PoW3bOH6JORyKO2Bcds3keR36FV21
	 jcwjGdpUcF4juRFlWfQ99NPhC2BlG9r4sFcxiUz1s7FRusT6s/hElxCUakMzvyCx/l
	 PiRyZR7fM4xaaucnJVHKCtmbLzNXlBLpRyXMsQ7V4Be3msP1fSxA0TCuKE1ASLAM0+
	 ZEIfiLLHdtSIw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso9547989a12.1;
        Mon, 31 Mar 2025 03:15:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXpfML6LZJkRNsHBpyi64OTZ/wHrWb/edUTE7JqO2mLowCvG1HcoU24jIKaNiwbIEz08X6fikU+fI4pa0Re8BT@vger.kernel.org, AJvYcCV5ASWZdlZLRnDaJDaekxs341frQL30M7wN/BHufttL7ICmHqBssa45HnqXhj1EWrz2yaupYWSM2I0iSAEF@vger.kernel.org, AJvYcCVJB3AZ9G+Qlx/aOBjT8fY0n3cbR1badYZihoK5x172dCqkOQdqQMFRBlXmHAfq4OsEbiK9Qk20dACwTw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGZZPshjSUiqM2wT4CYGuWyYAXtj1qlys1MOFDskNy9g/YwFa
	bs5xyJ+1JZfQWxi8I9x54XXm8OxcWqzpOhsIdTcNmbPPgec7WqtuzJATYFOLRiLKt+Zwc59OGFP
	9jzoPg9hhc6Fs1i+zA25PhzmFang=
X-Google-Smtp-Source: AGHT+IFvFYObft2zKhI8nax3MvCXP4CIDl94lJKKoyX3Fte0jLIZ2CNZL9CRyoJud42hvncTtq9u8PJTs1GVTz88TqQ=
X-Received: by 2002:a17:907:c0f:b0:ac6:e20d:c3c0 with SMTP id
 a640c23a62f3a-ac71eca8b58mr1117145266b.16.1743416134168; Mon, 31 Mar 2025
 03:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327021809.29954-1-zhaoqunqin@loongson.cn> <20250327021809.29954-4-zhaoqunqin@loongson.cn>
In-Reply-To: <20250327021809.29954-4-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Mar 2025 18:15:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4AvnVX50iSCaAsmzEe3WZe=4LGjU2VmuTN4q9o9-FpHg@mail.gmail.com>
X-Gm-Features: AQ5f1Joz7Z3luYpq13-yQCFvoGkxeUBEdKxMuLXoQ8NcX2RlyvjWKtKvm9bL_i0
Message-ID: <CAAhV-H4AvnVX50iSCaAsmzEe3WZe=4LGjU2VmuTN4q9o9-FpHg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] crypto: loongson - add Loongson RNG driver support
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de, 
	Yinggang Gu <guyinggang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

On Thu, Mar 27, 2025 at 10:17=E2=80=AFAM Qunqin Zhao <zhaoqunqin@loongson.c=
n> wrote:
>
> Loongson's Random Number Generator is found inside Loongson security
> engine.
>
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
> v6: Replace all "ls6000se" with "loongson"
> v2-v5: None
>
>  drivers/crypto/Kconfig                 |   1 +
>  drivers/crypto/Makefile                |   1 +
>  drivers/crypto/loongson/Kconfig        |   6 +
>  drivers/crypto/loongson/Makefile       |   2 +
>  drivers/crypto/loongson/loongson-rng.c | 190 +++++++++++++++++++++++++
>  5 files changed, 200 insertions(+)
>  create mode 100644 drivers/crypto/loongson/Kconfig
>  create mode 100644 drivers/crypto/loongson/Makefile
>  create mode 100644 drivers/crypto/loongson/loongson-rng.c
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 19ab145f9..567ed81b0 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -855,5 +855,6 @@ config CRYPTO_DEV_SA2UL
>
>  source "drivers/crypto/aspeed/Kconfig"
>  source "drivers/crypto/starfive/Kconfig"
> +source "drivers/crypto/loongson/Kconfig"
>
>  endif # CRYPTO_HW
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index fef18ffdb..643c3710b 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -50,3 +50,4 @@ obj-y +=3D hisilicon/
>  obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) +=3D amlogic/
>  obj-y +=3D intel/
>  obj-y +=3D starfive/
> +obj-y +=3D loongson/
> diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kc=
onfig
> new file mode 100644
> index 000000000..4368701ad
> --- /dev/null
> +++ b/drivers/crypto/loongson/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config CRYPTO_DEV_LOONGSON_RNG
> +        tristate "Support for Loongson RNG Driver"
> +        depends on MFD_LOONGSON_SE
> +        help
> +          Support for Loongson RNG Driver.
> diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/M=
akefile
> new file mode 100644
> index 000000000..b8b013c86
> --- /dev/null
> +++ b/drivers/crypto/loongson/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_CRYPTO_DEV_LOONGSON_RNG)  +=3D loongson-rng.o
> diff --git a/drivers/crypto/loongson/loongson-rng.c b/drivers/crypto/loon=
gson/loongson-rng.c
> new file mode 100644
> index 000000000..c80346cf7
> --- /dev/null
> +++ b/drivers/crypto/loongson/loongson-rng.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019 HiSilicon Limited. */
> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> +
> +#include <linux/crypto.h>
> +#include <linux/err.h>
> +#include <linux/hw_random.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mfd/loongson-se.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/random.h>
> +#include <crypto/internal/rng.h>
> +
> +struct lsrng_list {
> +       struct mutex lock;
> +       struct list_head list;
> +       int is_init;
> +};
For all data struct and function name, it is better to change the
lsrng_ prefix to loongson_rng_ which matches the file name.


Huacai

> +
> +struct lsrng {
> +       bool is_used;
> +       struct lsse_ch *se_ch;
> +       struct list_head list;
> +       struct completion rng_completion;
> +};
> +
> +struct lsrng_ctx {
> +       struct lsrng *rng;
> +};
> +
> +struct rng_msg {
> +       u32 cmd;
> +       union {
> +               u32 len;
> +               u32 ret;
> +       } u;
> +       u32 resved;
> +       u32 out_off;
> +       u32 pad[4];
> +};
> +
> +static atomic_t rng_active_devs;
> +static struct lsrng_list rng_devices;
> +
> +static void lsrng_complete(struct lsse_ch *ch)
> +{
> +       struct lsrng *rng =3D (struct lsrng *)ch->priv;
> +
> +       complete(&rng->rng_completion);
> +}
> +
> +static int lsrng_generate(struct crypto_rng *tfm, const u8 *src,
> +                         unsigned int slen, u8 *dstn, unsigned int dlen)
> +{
> +       struct lsrng_ctx *ctx =3D crypto_rng_ctx(tfm);
> +       struct lsrng *rng =3D ctx->rng;
> +       struct rng_msg *msg;
> +       int err, len;
> +
> +       do {
> +               len =3D min(dlen, PAGE_SIZE);
> +               msg =3D rng->se_ch->smsg;
> +               msg->u.len =3D len;
> +               err =3D se_send_ch_requeset(rng->se_ch);
> +               if (err)
> +                       return err;
> +
> +               wait_for_completion_interruptible(&rng->rng_completion);
> +
> +               msg =3D rng->se_ch->rmsg;
> +               if (msg->u.ret)
> +                       return -EFAULT;
> +
> +               memcpy(dstn, rng->se_ch->data_buffer, len);
> +               dlen -=3D len;
> +               dstn +=3D len;
> +       } while (dlen > 0);
> +
> +       return 0;
> +}
> +
> +static int lsrng_init(struct crypto_tfm *tfm)
> +{
> +       struct lsrng_ctx *ctx =3D crypto_tfm_ctx(tfm);
> +       struct lsrng *rng;
> +       int ret =3D -EBUSY;
> +
> +       mutex_lock(&rng_devices.lock);
> +       list_for_each_entry(rng, &rng_devices.list, list) {
> +               if (!rng->is_used) {
> +                       rng->is_used =3D true;
> +                       ctx->rng =3D rng;
> +                       ret =3D 0;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&rng_devices.lock);
> +
> +       return ret;
> +}
> +
> +static void lsrng_exit(struct crypto_tfm *tfm)
> +{
> +       struct lsrng_ctx *ctx =3D crypto_tfm_ctx(tfm);
> +
> +       mutex_lock(&rng_devices.lock);
> +       ctx->rng->is_used =3D false;
> +       mutex_unlock(&rng_devices.lock);
> +}
> +
> +static int no_seed(struct crypto_rng *tfm, const u8 *seed, unsigned int =
slen)
> +{
> +       return 0;
> +}
> +
> +static struct rng_alg lsrng_alg =3D {
> +       .generate =3D lsrng_generate,
> +       .seed =3D no_seed,
> +       .base =3D {
> +               .cra_name =3D "stdrng",
> +               .cra_driver_name =3D "loongson_stdrng",
> +               .cra_priority =3D 300,
> +               .cra_ctxsize =3D sizeof(struct lsrng_ctx),
> +               .cra_module =3D THIS_MODULE,
> +               .cra_init =3D lsrng_init,
> +               .cra_exit =3D lsrng_exit,
> +       },
> +};
> +
> +static void lsrng_add_to_list(struct lsrng *rng)
> +{
> +       mutex_lock(&rng_devices.lock);
> +       list_add_tail(&rng->list, &rng_devices.list);
> +       mutex_unlock(&rng_devices.lock);
> +}
> +
> +static int lsrng_probe(struct platform_device *pdev)
> +{
> +       struct rng_msg *msg;
> +       struct lsrng *rng;
> +       int ret;
> +
> +       rng =3D devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
> +       if (!rng)
> +               return -ENOMEM;
> +
> +       init_completion(&rng->rng_completion);
> +       rng->se_ch =3D se_init_ch(pdev->dev.parent, SE_CH_RNG, PAGE_SIZE,
> +                               sizeof(struct rng_msg) * 2, rng, lsrng_co=
mplete);
> +       if (!rng->se_ch)
> +               return -ENODEV;
> +       msg =3D rng->se_ch->smsg;
> +       msg->cmd =3D SE_CMD_RNG;
> +       msg->out_off =3D rng->se_ch->off;
> +
> +       if (!rng_devices.is_init) {
> +               ret =3D crypto_register_rng(&lsrng_alg);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to register crypto(%d=
)\n", ret);
> +                       return ret;
> +               }
> +               INIT_LIST_HEAD(&rng_devices.list);
> +               mutex_init(&rng_devices.lock);
> +               rng_devices.is_init =3D true;
> +       }
> +
> +       lsrng_add_to_list(rng);
> +       atomic_inc(&rng_active_devs);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver lsrng_driver =3D {
> +       .probe          =3D lsrng_probe,
> +       .driver         =3D {
> +               .name   =3D "loongson-rng",
> +       },
> +};
> +module_platform_driver(lsrng_driver);
> +
> +MODULE_ALIAS("platform:loongson-rng");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
> +MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson random number generator driver");
> --
> 2.45.2
>
>

