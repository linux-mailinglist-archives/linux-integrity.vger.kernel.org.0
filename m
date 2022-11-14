Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8F6274E2
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 04:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiKNDSN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 22:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiKNDSN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 22:18:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8DA46C;
        Sun, 13 Nov 2022 19:18:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 129-20020a1c0287000000b003cfe48519a6so7344wmc.0;
        Sun, 13 Nov 2022 19:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+Q9KbaAFZbygPhp1KCWuuQ4gItXhxtl0NMQHmTaOdw=;
        b=a50T9z7I5pSuCMHx89AB7d56tCRC9n8y9OABNi1nOQBK+Gpr3QPBCzHiiq8LWZvouS
         ASZ+1kZJAJcF6msYKlN3bHle2qFVZPourEwZYeCncc8wpwtPzo43MIOPbNiaiEMJW6uB
         k1f5nSS2E88yDb/5DnjDWMSGFD9LJ81LZn1kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+Q9KbaAFZbygPhp1KCWuuQ4gItXhxtl0NMQHmTaOdw=;
        b=3vCAUwsOGoQHgJvFlbrsIu3tGIbsHRJCoxlige7Mp6M2fJjNHuA6MTmSCJui54ZAV8
         FMswdok9VjeToNTDKx3hJtZuk0eKi8f4cF9eVVTL8geO3q73Ku7PeI4+vLFlt74fMlA1
         f9APHb7bspSZYTU7rEaQYo2KwkrBmBvSoUWh6H5BszS25FftFZVgWTjbGNVD8okuz2Ec
         AcZMvWydkki6BwEz6N7knjqj9k7dbuS7b7n17Bbeclo5ckJXmXJVJVeLxGSELkYuQSA9
         A1k2am5lVm85JC/xdMa848462dfFdT7E8UakcMyRTIv2bdeR2mvQRkpwkkzWNgnInF8X
         1USw==
X-Gm-Message-State: ANoB5pnY+M9Q30jCzQgkBI23qi+7i4VsEc9XjSwXKb9N+lrM6oqR7QsB
        /Xvpm6fLEulQ4crY2nRYFU1iq+02AwN8ZxciGXo=
X-Google-Smtp-Source: AA0mqf6mARp2ng8/zCN9z2scsVJkIOl1oyP9Pa9mnl0kSupm89CiPVlO3FFj3w7pz7Zcfh3YbtjiMjiMbyW5l6Ro/wI=
X-Received: by 2002:a05:600c:21cc:b0:3cf:8b32:a52 with SMTP id
 x12-20020a05600c21cc00b003cf8b320a52mr6824596wmj.72.1668395890511; Sun, 13
 Nov 2022 19:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20221107171423.51019-1-eajames@linux.ibm.com>
In-Reply-To: <20221107171423.51019-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Nov 2022 03:17:59 +0000
Message-ID: <CACPK8XeiVs4Nq=gXTWmZCs7unk--NXCNJZQKG2vUiL6iWFwTFA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Add flag to use default cancellation policy
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 7 Nov 2022 at 17:14, Eddie James <eajames@linux.ibm.com> wrote:
>
> The check for cancelled request depends on the VID of the chip, but
> some chips share VID which shouldn't share their cancellation
> behavior. This is the case for the Nuvoton NPCT75X, which should use
> the default cancellation check, not the Winbond one.
> To avoid changing the existing behavior, add a new flag to indicate
> that the chip should use the default cancellation check and set it
> for the I2C TPM2 TIS driver.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Tested-by: Joel Stanley <joel@jms.id.au>
Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")

With this patch, and "tpm: tis_i2c: Fix sanity check interrupt enable
mask", and the extra compatible strings the driver correctly probes on
boot with the Nuvoton part.


> ---
> Changes since v1:
>  - Update switch statement with default: break;
>
>  drivers/char/tpm/tpm_tis_core.c | 20 ++++++++++++--------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  drivers/char/tpm/tpm_tis_i2c.c  |  1 +
>  3 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 757623bacfd5..3f98e587b3e8 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -682,15 +682,19 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>  {
>         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>
> -       switch (priv->manufacturer_id) {
> -       case TPM_VID_WINBOND:
> -               return ((status == TPM_STS_VALID) ||
> -                       (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
> -       case TPM_VID_STM:
> -               return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
> -       default:
> -               return (status == TPM_STS_COMMAND_READY);
> +       if (!test_bit(TPM_TIS_DEFAULT_CANCELLATION, &priv->flags)) {
> +               switch (priv->manufacturer_id) {
> +               case TPM_VID_WINBOND:
> +                       return ((status == TPM_STS_VALID) ||
> +                               (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
> +               case TPM_VID_STM:
> +                       return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
> +               default:
> +                       break;
> +               }
>         }
> +
> +       return status == TPM_STS_COMMAND_READY;
>  }
>
>  static irqreturn_t tis_int_handler(int dummy, void *dev_id)
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 66a5a13cd1df..b68479e0de10 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -86,6 +86,7 @@ enum tis_defaults {
>  enum tpm_tis_flags {
>         TPM_TIS_ITPM_WORKAROUND         = BIT(0),
>         TPM_TIS_INVALID_STATUS          = BIT(1),
> +       TPM_TIS_DEFAULT_CANCELLATION    = BIT(2),
>  };
>
>  struct tpm_tis_data {
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 45f388127f4b..91451ee1ef8d 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -329,6 +329,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
>         if (!phy->io_buf)
>                 return -ENOMEM;
>
> +       set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
>         phy->i2c_client = dev;
>
>         /* must precede all communication with the tpm */
> --
> 2.31.1
>
