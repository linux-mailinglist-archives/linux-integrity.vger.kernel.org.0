Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2998346AEA8
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 00:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbhLFX4p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 18:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239491AbhLFX4p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 18:56:45 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD4C0613F8
        for <linux-integrity@vger.kernel.org>; Mon,  6 Dec 2021 15:53:15 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id m9so15061691iop.0
        for <linux-integrity@vger.kernel.org>; Mon, 06 Dec 2021 15:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SV6k5iBsamRiaBBJ+XghJWZ1yW1g/a451QbHMJtyEDo=;
        b=AkBCzFkWKx/0YErAx/8XHysU7q8jl3DDecJO2xouTgDrzVcYntI4CoMWD+lqASIz9L
         QLQaucPMWPS19wtwO3McgDniKsFJhOIjpJhAn805Blx/nWCdI4biSnbJHyF2/AJ2F2rI
         MDOic/LHgcJtEZBWk2BF/WCQDwN5WnsLIaY7YdwqQHVJoWOyfKfExj1sBzPCyQ3JSMvg
         018gCbZCx3G1nXlOlzGULh3J7kLcFWErYVx38hfY5EzORMuYLZIiUuK4klpzoPWV41ar
         Cf6m19VXY/CnfpZKxBmPt9/feNCtau86O5pPV2Le2TE3Pnh0vlQpedNxJ2hZje/c33Pw
         iw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SV6k5iBsamRiaBBJ+XghJWZ1yW1g/a451QbHMJtyEDo=;
        b=alkdp8nLi7HLuvfXRZH5/rYEZUU8ed5v93EAEIA6NDgifGFgQj74Lqb59WCuhk/1+T
         naZWM0C7/T3Vj6O/rIWbbI4JT04Egi6vbdE2DGTYP15ENXKpc6QhYDGCcsr++VbDbKhm
         v0az5M7p0l+03RduLSgANCm2uf5V6XxfAax8OFT5u6vkl7hzKg+I15dG7dcfy7dp4uMR
         7pySzcy/xbJSUZ3yPQTBmtfHusDdDrqOvNygcVJWhy2/Zbyo0sHWHnDnxC/qrq8Sk/w5
         T6+MRdwC7XjCkuvTxYFPXA2R9D4j2+pdgqmZQr6LlW10eYdhtDPICTUbk/XkpS3OLw2q
         Ma6A==
X-Gm-Message-State: AOAM532YCJ2q8py/G/k12hGsEhXrqheTRvQ42lBSxQmq/ltiVaWdibBB
        WEQeZfPOXqDteG7UTk3UVHG0q0bpcsfMIDL0sFc3PQ==
X-Google-Smtp-Source: ABdhPJxV6ye8m1MGpJEfYBb99EFdxCQ2MfcK7jNrsrrk2JwyUjZ+A2Tpu80aCK/WUozu2m7t+lsNSlYsSb/1kA4FYbs=
X-Received: by 2002:a05:6638:d46:: with SMTP id d6mr45633841jak.129.1638834795140;
 Mon, 06 Dec 2021 15:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20211130235918.2216110-1-robbarnes@google.com>
In-Reply-To: <20211130235918.2216110-1-robbarnes@google.com>
From:   Rob Barnes <robbarnes@google.com>
Date:   Mon, 6 Dec 2021 16:52:39 -0700
Message-ID: <CA+Dqm30i6axAHkB4Dagu8uN-_Vx56RiWPVYqheddLjvvYoT0dQ@mail.gmail.com>
Subject: Re: [PATCH] char: tpm: cr50: Set TPM_FIRMWARE_POWER_MANAGED based on
 device property
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Including tpmdd-devel@lists.sourceforge.net

>
> Set TPM_FIRMWARE_POWER_MANAGED flag based on 'firmware-power-managed'
> ACPI DSD property. For the CR50 TPM, this flag defaults to true when
> the property is unset.
>
> When this flag is set to false, the CR50 TPM driver will always send
> a shutdown command whenever the system suspends.
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 14 +++++++++++++-
>  drivers/char/tpm/tpm_tis_spi_cr50.c | 14 +++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index c89278103703..70143cc4f4e8 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -628,6 +628,17 @@ static bool tpm_cr50_i2c_req_canceled(struct tpm_chip *chip, u8 status)
>         return status == TPM_STS_COMMAND_READY;
>  }
>
> +static bool tpm_cr50_i2c_is_firmware_power_managed(struct device *dev)
> +{
> +       u8 val;
> +       int ret;
> +       /* This flag should default true when the device property is not present */
> +       ret = device_property_read_u8(dev, "firmware-power-managed", &val);
> +       if (ret)
> +               return 1;
> +       return val;
> +}
> +
>  static const struct tpm_class_ops cr50_i2c = {
>         .flags = TPM_OPS_AUTO_STARTUP,
>         .status = &tpm_cr50_i2c_tis_status,
> @@ -686,7 +697,8 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>
>         /* cr50 is a TPM 2.0 chip */
>         chip->flags |= TPM_CHIP_FLAG_TPM2;
> -       chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> +       if (tpm_cr50_i2c_is_firmware_power_managed(dev))
> +               chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
>
>         /* Default timeouts */
>         chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
> diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
> index dae98dbeeeac..e01f7cc258ca 100644
> --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> @@ -185,6 +185,17 @@ static int cr50_spi_flow_control(struct tpm_tis_spi_phy *phy,
>         return 0;
>  }
>
> +static bool tpm_cr50_spi_is_firmware_power_managed(struct device *dev)
> +{
> +       u8 val;
> +       int ret;
> +       /* This flag should default true when the device property is not present */
> +       ret = device_property_read_u8(dev, "firmware-power-managed", &val);
> +       if (ret)
> +               return 1;
> +       return val;
> +}
> +
>  static int tpm_tis_spi_cr50_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>                                      u8 *in, const u8 *out)
>  {
> @@ -309,7 +320,8 @@ int cr50_spi_probe(struct spi_device *spi)
>         cr50_print_fw_version(&phy->priv);
>
>         chip = dev_get_drvdata(&spi->dev);
> -       chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> +       if (tpm_cr50_spi_is_firmware_power_managed(dev))
> +               chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
>
>         return 0;
>  }
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
