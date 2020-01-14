Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3FD613A6C5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 11:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbgANKN3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 05:13:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35272 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733190AbgANKN0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 05:13:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so13018681wmb.0
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2020 02:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVJ9vsBKjNHAquu2wHQplGsVSsF8ZvsB04D/QJeGvO0=;
        b=QkBD7bGtsftShAVXrNLgP1GUir8zjpVH0BFB90Jq5fahbPDtUfMTZaLzyDbhXOmO2A
         nmmqavi/LtNmqfhcGG7sHpIdRdVeANyAR8RL4ouV2QsNHaRbPadxRhtHfIck56dD+8uQ
         amPWIBI+kZVA3StySeTyIOizmVdjxn4elq6Rdd/Vu1fbnzP1X5G5zN3FMNkpg/tfZKNO
         UGRQ/dsX9XyZDxTxyBVv3AiujdGMR3zooptycedYQPYqK3O/q7SqsUJzB2EFcT7aHdzZ
         U49U6xkIT+sSUuwO26vUpxKWZ8RlksiqQkZ2jKW9qn3klff/vprVctHRbtLhH98FzmK7
         a1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVJ9vsBKjNHAquu2wHQplGsVSsF8ZvsB04D/QJeGvO0=;
        b=Z7ToyR12giTD2OdZXsovwS1pWMM7hMm2CSwjZ1Wh+9lzznj6OALw4Rw0D0czUVUZ4c
         RuTiFaYhdF+mjsaoqoIl/JzmzMk+6cYWpL/0n74XCQWvpfrTmxt8eI9iXRSJXJnyM3p5
         8l0mL3aDtkxXNbJ8NVXGMeBflM9zzLtI8VYBNz4wLGmeIfaIpoWdFzplIKTNXdnG8Ji6
         o5qANI0fn/d8uoPyWO4myUmWq1HiBBkb6w6fQsVumYsdyleGk4h9lgPcTzUQR/GRep5J
         zoelLIjt8HEY+l13BxTxVLDbJxoW1UCUE/H7zIwzkLxtStRYluTKh5ZkxZ0myagtX/M6
         cIHA==
X-Gm-Message-State: APjAAAV7Q/D/mZLpTxwQSJ9+gtxJrmrbMKiqgQfZNoMSrqKs001PpHbo
        FCrAVzrFww125WGzo6GUsq0R8xKSxLzNwquUTmwXJQ==
X-Google-Smtp-Source: APXvYqxJZ24GiVlk9lUMDjJkGJEI6s3pmAanrQrR6ZjPBl+XBfGQsJAevyPjLoW5Oxheg/hE/D/XAZSaJTq3QWFkOzU=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr26748340wmc.9.1578996805060;
 Tue, 14 Jan 2020 02:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20200114094505.11855-1-ardb@kernel.org> <20200114094505.11855-3-ardb@kernel.org>
In-Reply-To: <20200114094505.11855-3-ardb@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 14 Jan 2020 11:13:13 +0100
Message-ID: <CAKv+Gu93rePi1MctP9ffr3wT2r-8OCBoO7Pw5ivWOcXgwfS4Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tis: add support for MMIO TPM on SynQuacer
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 14 Jan 2020 at 10:46, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> window that is backed by the SPI command sequencer in the SPI bus
> controller. This arrangement has the limitation that only byte size
> accesses are supported, and so we'll need to provide a separate set
> of read and write accessors that take this into account.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis.c | 31 ++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index e7df342a317d..693e48096035 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -32,6 +32,7 @@
>
>  struct tpm_info {
>         struct resource res;
> +       const struct tpm_tis_phy_ops *ops;
>         /* irq > 0 means: use irq $irq;
>          * irq = 0 means: autoprobe for an irq;
>          * irq = -1 means: no irq support
> @@ -186,6 +187,29 @@ static const struct tpm_tis_phy_ops tpm_tcg = {
>         .write32 = tpm_tcg_write32,
>  };
>
> +static int tpm_tcg_read16_bw(struct tpm_tis_data *data, u32 addr, u16 *result)
> +{
> +       return tpm_tcg_read_bytes(data, addr, 2, (u8 *)result);
> +}
> +
> +static int tpm_tcg_read32_bw(struct tpm_tis_data *data, u32 addr, u32 *result)
> +{
> +       return tpm_tcg_read_bytes(data, addr, 4, (u8 *)result);
> +}
> +
> +static int tpm_tcg_write32_bw(struct tpm_tis_data *data, u32 addr, u32 value)
> +{
> +       return tpm_tcg_write_bytes(data, addr, 4, (u8 *)&value);
> +}
> +

These are wrong - I'll need to respin. Apologies for the noise.

> +static const struct tpm_tis_phy_ops tpm_tcg_bw = {
> +       .read_bytes     = tpm_tcg_read_bytes,
> +       .write_bytes    = tpm_tcg_write_bytes,
> +       .read16         = tpm_tcg_read16_bw,
> +       .read32         = tpm_tcg_read32_bw,
> +       .write32        = tpm_tcg_write32_bw,
> +};
> +
>  static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>  {
>         struct tpm_tis_tcg_phy *phy;
> @@ -210,7 +234,7 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>         if (itpm || is_itpm(ACPI_COMPANION(dev)))
>                 phy->priv.flags |= TPM_TIS_ITPM_WORKAROUND;
>
> -       return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
> +       return tpm_tis_core_init(dev, &phy->priv, irq, tpm_info->ops,
>                                  ACPI_HANDLE(dev));
>  }
>
> @@ -219,7 +243,7 @@ static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
>  static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
>                             const struct pnp_device_id *pnp_id)
>  {
> -       struct tpm_info tpm_info = {};
> +       struct tpm_info tpm_info = { .ops = &tpm_tcg };
>         struct resource *res;
>
>         res = pnp_get_resource(pnp_dev, IORESOURCE_MEM, 0);
> @@ -295,6 +319,8 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
>                         tpm_info.irq = 0;
>         }
>
> +       tpm_info.ops = of_device_get_match_data(&pdev->dev) ?: &tpm_tcg;
> +
>         return tpm_tis_init(&pdev->dev, &tpm_info);
>  }
>
> @@ -311,6 +337,7 @@ static int tpm_tis_plat_remove(struct platform_device *pdev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id tis_of_platform_match[] = {
>         {.compatible = "tcg,tpm-tis-mmio"},
> +       {.compatible = "socionext,synquacer-tpm-mmio", .data = &tpm_tcg_bw},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, tis_of_platform_match);
> --
> 2.20.1
>
