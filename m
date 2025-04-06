Return-Path: <linux-integrity+bounces-5618-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD4A7CD5F
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Apr 2025 11:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2BE188EFD1
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Apr 2025 09:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D319E96A;
	Sun,  6 Apr 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwOrasoD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A4019D07C;
	Sun,  6 Apr 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743930327; cv=none; b=R7/6E6AX53SuEouGZWKt+g1b2uy95qKUDBngecYeSYlOswbw1NSkwVRHDWYb31ik34u8R+ZulHqiPQowJUVmagxmfXESu9zgxbnNaOxSKeBtTQa3gSQHQEFobLhvqPDsejjhkvcaOGJWCb9AYoq7V97gZzbi0uN2pj5/lXKza3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743930327; c=relaxed/simple;
	bh=8HppInsbIo8ANnv0KzVr7mCU0OkTEyE/7eBNjt7qig8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI+MNdaPw2MWkECiOgpcZ/V+cmjF7RacrQjH3fKslbhCraqq+rsP72ZWpfveGg5iRKRjHXH3VMQNdji6mRY+KtJt6YncvUbohMUeeNcU8Pb2Dhp0Wm9JE+UwIYcnAPQ7Yh5qZ71ukrFb8T2zuBEPGmVGlX1aV9qT+Xx6m1KWueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwOrasoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C68C4AF09;
	Sun,  6 Apr 2025 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743930326;
	bh=8HppInsbIo8ANnv0KzVr7mCU0OkTEyE/7eBNjt7qig8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IwOrasoDeDzS3yUBfr8g94+5gZoiu+5AgF6rMrv7SteF7Bc8nm13Y7vRz3FvVjRf2
	 T12ORznnepbij0kgIrpYgWtUJsBMGicgVNNZ9LKjXeav94jZ9oQXVEpfI5zX1EhFtD
	 GpjiaDs0q/V1Il+bKxV0TH9E0j27Mz75wlFtjdeLGzfHXZZ3DkdvwXjFHOukKFtgy6
	 lmrfugunHjzDBzTyORKeQroDL0gRpCwAZrdPMvVeXtteVwzf9ODeL/tvUTIgqIL/t1
	 k6bDIJ3pzuMmDYykjX84dtvqtMI0dLdyTTzFtQBKjdx2Qco8cTpPYoaXRsXLP5pohA
	 0vUcscdLjHqfQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso290417066b.1;
        Sun, 06 Apr 2025 02:05:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWLcmQ9o3vOXFOESGhnAPZuAlzr+v9M/GaaIWgEG5P8QmfZ+9qJ39TDL3ll8dx2Ccl7ptGMtunmkRZIrJC@vger.kernel.org, AJvYcCVXuHny/Pp79Wq58knUpmbCCRjKtXe56EWEochNIhsciImFnU8S6RwAA/ZeMa/pMMJ1SSbhWED5XOgWa6uxwRp+@vger.kernel.org, AJvYcCVmJGAO04tnBt/PnAriULN+BmGSDM/ltF1Dhy9xdzrFeqyVefkeEaK3Hn+QeDfFM/7OeI0veVKcQ50YsLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUvJD1sgNMPqF96KWf1qSZFPVkbJ0+vLIFSzfB/JLFX7HJ/437
	H2yNV50jrawUK4/KnKHAoJar3XUrfy+1oJ242jAWVBhxoVWAikLAZ3l8Q9+NWFfgWRxLgtWZeWb
	GnQEasvQRxtJIZg8SLU6CEcAHzOQ=
X-Google-Smtp-Source: AGHT+IGnNuCrgMy9P3d6NcUjmzNvarGtmG4DsB2kEka2+JK8o2USJQLfNhexkE7Myk6TQhY8RdwX6T2Run352Tj2b/I=
X-Received: by 2002:a17:907:7207:b0:ac7:95b0:d0fb with SMTP id
 a640c23a62f3a-ac7d18ccf44mr582095566b.34.1743930325304; Sun, 06 Apr 2025
 02:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403024645.4427-1-zhaoqunqin@loongson.cn> <20250403024645.4427-4-zhaoqunqin@loongson.cn>
In-Reply-To: <20250403024645.4427-4-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 6 Apr 2025 17:05:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H45vYe3Brgy=0_+ciTjcJ-+x3zwoeY-ym20o5PGGxvJCw@mail.gmail.com>
X-Gm-Features: ATxdqUE_15XGhijQDn39K9ebew3z8rFKKC1Cu8MxG-GMMAfETFR9hD85GjMWF6E
Message-ID: <CAAhV-H45vYe3Brgy=0_+ciTjcJ-+x3zwoeY-ym20o5PGGxvJCw@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] crypto: loongson - add Loongson RNG driver support
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de, 
	Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

On Thu, Apr 3, 2025 at 10:46=E2=80=AFAM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
> Loongson's Random Number Generator is found inside Loongson security
> engine.
>
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> v7: Change the lsrng_ prefix to loongson_rng_
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
> index 000000000..307014992
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
> +struct loongson_rng_list {
> +       struct mutex lock;
> +       struct list_head list;
> +       int is_init;
> +};
> +
> +struct lsrng {
> +       bool is_used;
> +       struct se_channel *se_ch;
> +       struct list_head list;
> +       struct completion rng_completion;
> +};
Since there are other comments that should be addressed, you can
rename lsrng to loongson_rng to keep consistency.

Huacai

> +
> +struct loongson_rng_ctx {
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
> +static struct loongson_rng_list rng_devices;
> +
> +static void loongson_rng_complete(struct se_channel *ch)
> +{
> +       struct lsrng *rng =3D (struct lsrng *)ch->priv;
> +
> +       complete(&rng->rng_completion);
> +}
> +
> +static int loongson_rng_generate(struct crypto_rng *tfm, const u8 *src,
> +                         unsigned int slen, u8 *dstn, unsigned int dlen)
> +{
> +       struct loongson_rng_ctx *ctx =3D crypto_rng_ctx(tfm);
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
> +static int loongson_rng_init(struct crypto_tfm *tfm)
> +{
> +       struct loongson_rng_ctx *ctx =3D crypto_tfm_ctx(tfm);
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
> +static void loongson_rng_exit(struct crypto_tfm *tfm)
> +{
> +       struct loongson_rng_ctx *ctx =3D crypto_tfm_ctx(tfm);
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
> +static struct rng_alg loongson_rng_alg =3D {
> +       .generate =3D loongson_rng_generate,
> +       .seed =3D no_seed,
> +       .base =3D {
> +               .cra_name =3D "stdrng",
> +               .cra_driver_name =3D "loongson_stdrng",
> +               .cra_priority =3D 300,
> +               .cra_ctxsize =3D sizeof(struct loongson_rng_ctx),
> +               .cra_module =3D THIS_MODULE,
> +               .cra_init =3D loongson_rng_init,
> +               .cra_exit =3D loongson_rng_exit,
> +       },
> +};
> +
> +static void loongson_rng_add_to_list(struct lsrng *rng)
> +{
> +       mutex_lock(&rng_devices.lock);
> +       list_add_tail(&rng->list, &rng_devices.list);
> +       mutex_unlock(&rng_devices.lock);
> +}
> +
> +static int loongson_rng_probe(struct platform_device *pdev)
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
> +                               sizeof(struct rng_msg) * 2, rng, loongson=
_rng_complete);
> +       if (!rng->se_ch)
> +               return -ENODEV;
> +       msg =3D rng->se_ch->smsg;
> +       msg->cmd =3D SE_CMD_RNG;
> +       msg->out_off =3D rng->se_ch->off;
> +
> +       if (!rng_devices.is_init) {
> +               ret =3D crypto_register_rng(&loongson_rng_alg);
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
> +       loongson_rng_add_to_list(rng);
> +       atomic_inc(&rng_active_devs);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver loongson_rng_driver =3D {
> +       .probe          =3D loongson_rng_probe,
> +       .driver         =3D {
> +               .name   =3D "loongson-rng",
> +       },
> +};
> +module_platform_driver(loongson_rng_driver);
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

