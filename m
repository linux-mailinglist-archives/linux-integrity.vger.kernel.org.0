Return-Path: <linux-integrity+bounces-5520-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52110A763EA
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAC0167EA9
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE31DF735;
	Mon, 31 Mar 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUPtWS+M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570531D7E57;
	Mon, 31 Mar 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416090; cv=none; b=h+lD80HxndDSn6dI9Xhr8Myryqwyzy1M8GTwbpyvGKRif7xQbmmEpHpFe/A6wX7O701BghKogRuXfryoLMBHM2X11xmY9cUEZTa7LDVMiWSAF8yNkhjXLGlUOimFEjlzzEWv/fmua1M0Ts0ZihS/ie2Y7Y3Mw3QfzpCCTenzQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416090; c=relaxed/simple;
	bh=1AqSi1p24wD4DNJlyiz5K+5BupPM8tUpVQ9NMMvUIwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQC0UH6eGkDlCh/9SUdpIVpfW2ZQJaeu2prmkAkPhtLOhwZk3aU2PXkVBBysavvXA9xDcKWbBgE+I0BeLrcCeMMyDvdBylOPdc2mCJYyiwJLI6tGdzZqzDh8EXazDanlNnQQegu8+SGZTT0LKHoIdosAiRlRHnl69mixuZuuRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUPtWS+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA44C4CEEB;
	Mon, 31 Mar 2025 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743416089;
	bh=1AqSi1p24wD4DNJlyiz5K+5BupPM8tUpVQ9NMMvUIwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CUPtWS+McfHg6Swqjh1VRUTSPe6b463dJPPphs4WWhf5IrZVHdp7raYWs6kHksiAM
	 zHUQKfjFjV0twTrgNiQQIOp724lv0JGy3vYss9aIXDeB91Z1auqXtlKBYTD4nso+mE
	 QD3wUwQlllimDDdcv9GLsV6LjuEJaCqkWo/O+BUz3Ue67liyZP34gTtpL6dTynnr9v
	 /OsuyF2JscmGKcNQbVbY1Bwmy4BezxCF/ixoftNMu3QuXYhNWOjdLpNQIo8H2wZk5F
	 3BuD6hsXHkvft8XF3hGqrE5SjZmiX1J1pl1zdNgzuJpFMgmSqgL3Q6SP4jRKtY7Qg8
	 v/G5PmPq3BuBw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so706871566b.0;
        Mon, 31 Mar 2025 03:14:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCjUKzF0VlgN5kiXjfEOyt0wRyeGE+fdfvBZNlbR2FW5TvjfBuxuAx8x4QpFt1cU8g0yvRsHClw7UNbx23MO/T@vger.kernel.org, AJvYcCV6Cd+b1qFDisDGE/BQ7fyE015Ma0mFL8oW5OLU/SAAQxNacFKw7gC4/MFf0bQsst/0Z+CSq5YX+J9PbUhP@vger.kernel.org, AJvYcCXqMGaZ8G0b9YrS1jwF/xD0zHpZ+ihSNUayAu6Mj4Xc0d9Vlqq+DuQ27O8PEOfkPEgXeUrqO+yu45qaRrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztK7h8YcGoT/D5ENRW0nPGCrvIplF059gSHlFLvKijjlmzz7Hw
	s1ummUJ8eAF9oFti9915/0CCAx2IarTw/LjLyz7wSuiY5lWRoYKoh/y0o6IES4/jO0Q8NHk8gjt
	xsfznIsu7OMPXPk6CerhLmud4wF0=
X-Google-Smtp-Source: AGHT+IHJqJEnzM7IHoaBimLQZhw25r2L3iYKhxkNOQG/mUR0g7f5kA9k4S+fAFhk8NQgBjDM2/uOqu8IQmrCmYKrldQ=
X-Received: by 2002:a17:907:d25:b0:abf:4708:8644 with SMTP id
 a640c23a62f3a-ac738bbebedmr693287466b.43.1743416088297; Mon, 31 Mar 2025
 03:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327021809.29954-1-zhaoqunqin@loongson.cn> <20250327021809.29954-2-zhaoqunqin@loongson.cn>
In-Reply-To: <20250327021809.29954-2-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 31 Mar 2025 18:14:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7m7Rmp=0Wdksi_LhqsKU1zw3U-iQtt2FT2pjZJwohi6A@mail.gmail.com>
X-Gm-Features: AQ5f1Jp_Qjs6hA377J-lhlu2e_SJvL2pW6ob0DiNp59jrqUXAclJglPxPDK7oQ0
Message-ID: <CAAhV-H7m7Rmp=0Wdksi_LhqsKU1zw3U-iQtt2FT2pjZJwohi6A@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] mfd: Add support for Loongson Security Module
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
> This driver supports Loongson Security Module, which provides the control
> for it's hardware encryption acceleration child devices.
>
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
> v6: Replace all "ls6000se" with "loongson"
> v5: Registered "ls6000se-rng" device.
> v3-v4: None
>
> v2: Removed "ls6000se-sdf" device, added "ls6000se-tpm" device.
>     Passed dmamem size to SE firmware in se_init_hw() function.
>
>  drivers/mfd/Kconfig             |  10 +
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/loongson-se.c       | 374 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/loongson-se.h |  75 +++++++
>  4 files changed, 461 insertions(+)
>  create mode 100644 drivers/mfd/loongson-se.c
>  create mode 100644 include/linux/mfd/loongson-se.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 22b936310..a31ccb1b0 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2422,5 +2422,15 @@ config MFD_UPBOARD_FPGA
>           To compile this driver as a module, choose M here: the module w=
ill be
>           called upboard-fpga.
>
> +config MFD_LOONGSON_SE
> +       tristate "Loongson Security Module Interface"
> +       depends on LOONGARCH && ACPI
> +       select MFD_CORE
> +       help
> +         The Loongson security module provides the control for hardware
> +         encryption acceleration devices. Each device uses at least one
> +         channel to interact with security module, and each channel may
> +         have its own buffer provided by security module.
This file is mostly sorted by alpha-betical order, so moving this
between MFD_INTEL_M10_BMC_PMCI and MFD_QNAP_MCU is better.

> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 948cbdf42..fc50601ca 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -290,3 +290,5 @@ obj-$(CONFIG_MFD_RSMU_I2C)  +=3D rsmu_i2c.o rsmu_core=
.o
>  obj-$(CONFIG_MFD_RSMU_SPI)     +=3D rsmu_spi.o rsmu_core.o
>
>  obj-$(CONFIG_MFD_UPBOARD_FPGA) +=3D upboard-fpga.o
> +
> +obj-$(CONFIG_MFD_LOONGSON_SE)  +=3D loongson-se.o
> diff --git a/drivers/mfd/loongson-se.c b/drivers/mfd/loongson-se.c
> new file mode 100644
> index 000000000..bf16f7df8
> --- /dev/null
> +++ b/drivers/mfd/loongson-se.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/loongson-se.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * The Loongson Security Module provides the control for hardware
> + * encryption acceleration child devices. The SE framework is
> + * shown as follows:
> + *
> + *                   +------------+
> + *                   |    CPU     |
> + *                   +------------+
> + *                     ^       ^
> + *                 DMA |       | IRQ
> + *                     v       v
> + *        +-----------------------------------+
> + *        |     Loongson Security Module      |
> + *        +-----------------------------------+
> + *             ^                ^
> + *    channel1 |       channel2 |
> + *             v                v
> + *        +-----------+    +----------+
> + *        | sub-dev1  |    | sub-dev2 |  ..... Max sub-dev31
> + *        +-----------+    +----------+
> + *
> + * The CPU cannot directly communicate with SE's sub devices,
> + * but sends commands to SE, which processes the commands and
> + * sends them to the corresponding sub devices.
> + */
> +
> +struct loongson_se {
> +       void __iomem *base;
> +       u32 version;
> +       spinlock_t dev_lock;
> +       struct completion cmd_completion;
> +
> +       /* dma memory */
> +       void *mem_base;
> +       int mem_map_pages;
> +       unsigned long *mem_map;
> +
> +       /* channel */
> +       struct mutex ch_init_lock;
> +       struct lsse_ch chs[SE_CH_MAX];
lsse_ch is confusing, rename it to se_channel is better.

> +};
> +
> +union se_request {
> +       u32 info[8];
> +       struct se_cmd {
> +               u32 cmd;
> +               u32 info[7];
> +       } req;
> +       struct se_res {
> +               u32 cmd;
> +               u32 cmd_ret;
> +               u32 info[6];
> +       } res;
> +};
> +
> +static inline u32 se_readl(struct loongson_se *se, u32 off)
> +{
> +       return readl(se->base + off);
> +}
> +
> +static inline void se_writel(struct loongson_se *se, u32 val, u32 off)
> +{
> +       writel(val, se->base + off);
> +}
> +
> +static void se_enable_int_locked(struct loongson_se *se, u32 int_bit)
> +{
> +       u32 tmp;
> +
> +       tmp =3D se_readl(se, SE_S2LINT_EN);
> +       tmp |=3D int_bit;
> +       se_writel(se, tmp, SE_S2LINT_EN);
> +}
> +
> +static void se_disable_int(struct loongson_se *se, u32 int_bit)
> +{
> +       unsigned long flag;
> +       u32 tmp;
> +
> +       spin_lock_irqsave(&se->dev_lock, flag);
> +
> +       tmp =3D se_readl(se, SE_S2LINT_EN);
> +       tmp &=3D ~(int_bit);
> +       se_writel(se, tmp, SE_S2LINT_EN);
> +
> +       spin_unlock_irqrestore(&se->dev_lock, flag);
> +}
Enable/disable interrupt is not symmetric, it is better to rename
se_enable_int_locked() to se_enable_int(), then move the lock out of
se_disable_int().

> +static int se_poll(struct loongson_se *se, u32 int_bit)
> +{
> +       u32 status;
> +       int err;
> +
> +       spin_lock_irq(&se->dev_lock);
> +
> +       se_enable_int_locked(se, int_bit);
> +       se_writel(se, int_bit, SE_L2SINT_SET);
> +       err =3D readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_ST=
AT, status,
> +                                               !(status & int_bit), 1, 1=
0000);
> +
> +       spin_unlock_irq(&se->dev_lock);
> +
> +       return err;
> +}
> +
> +static int se_send_requeset(struct loongson_se *se, union se_request *re=
q)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(req->info); i++)
> +               se_writel(se, req->info[i], SE_DATA_S + i * 4);
> +
> +       return se_poll(se, SE_INT_SETUP);
> +}
> +
> +/*
> + * Called by SE's child device driver.
> + * Send a request to the corresponding device.
> + */
> +int se_send_ch_requeset(struct lsse_ch *ch)
> +{
> +       return se_poll(ch->se, ch->int_bit);
> +}
> +EXPORT_SYMBOL_GPL(se_send_ch_requeset);
> +
> +static int se_get_res(struct loongson_se *se, u32 cmd, union se_request =
*res)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(res->info); i++)
> +               res->info[i] =3D se_readl(se, SE_DATA_L + i * 4);
> +
> +       if (res->res.cmd !=3D cmd)
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static int se_send_genl_cmd(struct loongson_se *se, union se_request *re=
q)
What does genl stand for? Maybe you can simply rename it to se_send_cmd().


Huacai

> +{
> +       int err;
> +
> +       err =3D se_send_requeset(se, req);
> +       if (err)
> +               return err;
> +
> +       if (!wait_for_completion_timeout(&se->cmd_completion, HZ))
> +               return -ETIME;
> +
> +       return se_get_res(se, req->req.cmd, req);
> +}
> +
> +static int se_set_msg(struct lsse_ch *ch)
> +{
> +       struct loongson_se *se =3D ch->se;
> +       union se_request req;
> +
> +       req.req.cmd =3D SE_CMD_SETMSG;
> +       req.req.info[0] =3D ch->id;
> +       req.req.info[1] =3D ch->smsg - se->mem_base;
> +       req.req.info[2] =3D ch->msg_size;
> +
> +       return se_send_genl_cmd(se, &req);
> +}
> +
> +static irqreturn_t se_irq(int irq, void *dev_id)
> +{
> +       struct loongson_se *se =3D (struct loongson_se *)dev_id;
> +       struct lsse_ch *ch;
> +       u32 int_status;
> +       int id;
> +
> +       int_status =3D se_readl(se, SE_S2LINT_STAT);
> +       se_disable_int(se, int_status);
> +       if (int_status & SE_INT_SETUP) {
> +               complete(&se->cmd_completion);
> +               int_status &=3D ~SE_INT_SETUP;
> +               se_writel(se, SE_INT_SETUP, SE_S2LINT_CL);
> +       }
> +
> +       while (int_status) {
> +               id =3D __ffs(int_status);
> +
> +               ch =3D &se->chs[id];
> +               if (ch->complete)
> +                       ch->complete(ch);
> +               int_status &=3D ~BIT(id);
> +               se_writel(se, BIT(id), SE_S2LINT_CL);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int se_init_hw(struct loongson_se *se, dma_addr_t addr, int size)
> +{
> +       union se_request req;
> +       int err;
> +
> +       /* Start engine */
> +       req.req.cmd =3D SE_CMD_START;
> +       err =3D se_send_genl_cmd(se, &req);
> +       if (err)
> +               return err;
> +
> +       /* Get Version */
> +       req.req.cmd =3D SE_CMD_GETVER;
> +       err =3D se_send_genl_cmd(se, &req);
> +       if (err)
> +               return err;
> +       se->version =3D req.res.info[0];
> +
> +       /* Setup dma memory */
> +       req.req.cmd =3D SE_CMD_SETBUF;
> +       req.req.info[0] =3D addr & 0xffffffff;
> +       req.req.info[1] =3D addr >> 32;
> +       req.req.info[2] =3D size;
> +
> +       return se_send_genl_cmd(se, &req);
> +}
> +
> +/*
> + * se_init_ch() - Init the channel used by child device.
> + *
> + * Allocate dma memory as agreed upon with SE on SE probe,
> + * and register the callback function when the data processing
> + * in this channel is completed.
> + */
> +struct lsse_ch *se_init_ch(struct device *dev, int id, int data_size, in=
t msg_size,
> +                          void *priv, void (*complete)(struct lsse_ch *s=
e_ch))
> +{
> +       struct loongson_se *se =3D dev_get_drvdata(dev);
> +       struct lsse_ch *ch;
> +       int data_first, data_nr;
> +       int msg_first, msg_nr;
> +
> +       mutex_lock(&se->ch_init_lock);
> +
> +       ch =3D &se->chs[id];
> +       ch->se =3D se;
> +       ch->id =3D id;
> +       ch->int_bit =3D BIT(id);
> +
> +       data_nr =3D round_up(data_size, PAGE_SIZE) / PAGE_SIZE;
> +       data_first =3D bitmap_find_next_zero_area(se->mem_map, se->mem_ma=
p_pages,
> +                                               0, data_nr, 0);
> +       if (data_first >=3D se->mem_map_pages) {
> +               ch =3D NULL;
> +               goto out_unlock;
> +       }
> +
> +       bitmap_set(se->mem_map, data_first, data_nr);
> +       ch->off =3D data_first * PAGE_SIZE;
> +       ch->data_buffer =3D se->mem_base + ch->off;
> +       ch->data_size =3D data_size;
> +
> +       msg_nr =3D round_up(msg_size, PAGE_SIZE) / PAGE_SIZE;
> +       msg_first =3D bitmap_find_next_zero_area(se->mem_map, se->mem_map=
_pages,
> +                                              0, msg_nr, 0);
> +       if (msg_first >=3D se->mem_map_pages) {
> +               ch =3D NULL;
> +               goto out_unlock;
> +       }
> +
> +       bitmap_set(se->mem_map, msg_first, msg_nr);
> +       ch->smsg =3D se->mem_base + msg_first * PAGE_SIZE;
> +       ch->rmsg =3D ch->smsg + msg_size / 2;
> +       ch->msg_size =3D msg_size;
> +       ch->complete =3D complete;
> +       ch->priv =3D priv;
> +       ch->version =3D se->version;
> +
> +       if (se_set_msg(ch))
> +               ch =3D NULL;
> +
> +out_unlock:
> +       mutex_unlock(&se->ch_init_lock);
> +
> +       return ch;
> +}
> +EXPORT_SYMBOL_GPL(se_init_ch);
> +
> +static const struct mfd_cell se_devs[] =3D {
> +       { .name =3D "loongson-rng" },
> +       { .name =3D "loongson-tpm" },
> +};
> +
> +static int loongson_se_probe(struct platform_device *pdev)
> +{
> +       struct loongson_se *se;
> +       struct device *dev =3D &pdev->dev;
> +       int nr_irq, irq, err, size;
> +       dma_addr_t paddr;
> +
> +       se =3D devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
> +       if (!se)
> +               return -ENOMEM;
> +       dev_set_drvdata(dev, se);
> +       init_completion(&se->cmd_completion);
> +       spin_lock_init(&se->dev_lock);
> +       mutex_init(&se->ch_init_lock);
> +       dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +       if (device_property_read_u32(dev, "dmam_size", &size))
> +               return -ENODEV;
> +       size =3D roundup_pow_of_two(size);
> +       se->mem_base =3D dmam_alloc_coherent(dev, size, &paddr, GFP_KERNE=
L);
> +       if (!se->mem_base)
> +               return -ENOMEM;
> +       se->mem_map_pages =3D size / PAGE_SIZE;
> +       se->mem_map =3D devm_bitmap_zalloc(dev, se->mem_map_pages, GFP_KE=
RNEL);
> +       if (!se->mem_map)
> +               return -ENOMEM;
> +
> +       se->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(se->base))
> +               return PTR_ERR(se->base);
> +
> +       nr_irq =3D platform_irq_count(pdev);
> +       if (nr_irq <=3D 0)
> +               return -ENODEV;
> +       while (nr_irq) {
> +               irq =3D platform_get_irq(pdev, --nr_irq);
> +               /* Use the same interrupt handler address.
> +                * Determine which irq it is accroding
> +                * SE_S2LINT_STAT register.
> +                */
> +               err =3D devm_request_irq(dev, irq, se_irq, 0, "loongson-s=
e", se);
> +               if (err)
> +                       dev_err(dev, "failed to request irq: %d\n", irq);
> +       }
> +
> +       err =3D se_init_hw(se, paddr, size);
> +       if (err)
> +               return err;
> +
> +       return devm_mfd_add_devices(dev, 0, se_devs, ARRAY_SIZE(se_devs),
> +                                   NULL, 0, NULL);
> +}
> +
> +static const struct acpi_device_id loongson_se_acpi_match[] =3D {
> +       {"LOON0011", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_se_acpi_match);
> +
> +static struct platform_driver loongson_se_driver =3D {
> +       .probe   =3D loongson_se_probe,
> +       .driver  =3D {
> +               .name  =3D "loongson-se",
> +               .acpi_match_table =3D loongson_se_acpi_match,
> +       },
> +};
> +module_platform_driver(loongson_se_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
> +MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson Security Module driver");
> diff --git a/include/linux/mfd/loongson-se.h b/include/linux/mfd/loongson=
-se.h
> new file mode 100644
> index 000000000..f70e9f196
> --- /dev/null
> +++ b/include/linux/mfd/loongson-se.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
> +
> +#ifndef __LOONGSON_SE_H__
> +#define __LOONGSON_SE_H__
> +
> +#define SE_DATA_S                      0x0
> +#define SE_DATA_L                      0x20
> +#define SE_S2LINT_STAT                 0x88
> +#define SE_S2LINT_EN                   0x8c
> +#define SE_S2LINT_SET                  0x90
> +#define SE_S2LINT_CL                   0x94
> +#define SE_L2SINT_STAT                 0x98
> +#define SE_L2SINT_EN                   0x9c
> +#define SE_L2SINT_SET                  0xa0
> +#define SE_L2SINT_CL                   0xa4
> +
> +/* INT bit definition */
> +#define SE_INT_SETUP                   BIT(0)
> +#define SE_INT_TPM                     BIT(5)
> +
> +#define SE_CMD_START                   0x0
> +#define SE_CMD_STOP                    0x1
> +#define SE_CMD_GETVER                  0x2
> +#define SE_CMD_SETBUF                  0x3
> +#define SE_CMD_SETMSG                  0x4
> +
> +#define SE_CMD_RNG                     0x100
> +#define SE_CMD_SM2_SIGN                        0x200
> +#define SE_CMD_SM2_VSIGN               0x201
> +#define SE_CMD_SM3_DIGEST              0x300
> +#define SE_CMD_SM3_UPDATE              0x301
> +#define SE_CMD_SM3_FINISH              0x302
> +#define SE_CMD_SM4_ECB_ENCRY           0x400
> +#define SE_CMD_SM4_ECB_DECRY           0x401
> +#define SE_CMD_SM4_CBC_ENCRY           0x402
> +#define SE_CMD_SM4_CBC_DECRY           0x403
> +#define SE_CMD_SM4_CTR                 0x404
> +#define SE_CMD_TPM                     0x500
> +#define SE_CMD_ZUC_INIT_READ           0x600
> +#define SE_CMD_ZUC_READ                        0x601
> +#define SE_CMD_SDF                     0x700
> +
> +#define SE_CH_MAX                      32
> +#define SE_CH_RNG                      1
> +#define SE_CH_SM2                      2
> +#define SE_CH_SM3                      3
> +#define SE_CH_SM4                      4
> +#define SE_CH_TPM                      5
> +#define SE_CH_ZUC                      6
> +#define SE_CH_SDF                      7
> +
> +struct lsse_ch {
> +       struct loongson_se *se;
> +       void *priv;
> +       u32 version;
> +       u32 id;
> +       u32 int_bit;
> +
> +       void *smsg;
> +       void *rmsg;
> +       int msg_size;
> +
> +       void *data_buffer;
> +       int data_size;
> +       u32 off;
> +
> +       void (*complete)(struct lsse_ch *se_ch);
> +};
> +
> +struct lsse_ch *se_init_ch(struct device *dev, int id, int data_size, in=
t msg_size,
> +                          void *priv, void (*complete)(struct lsse_ch *s=
e_ch));
> +int se_send_ch_requeset(struct lsse_ch *ch);
> +
> +#endif
> --
> 2.45.2
>
>

