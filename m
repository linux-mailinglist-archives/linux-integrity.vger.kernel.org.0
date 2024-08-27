Return-Path: <linux-integrity+bounces-3407-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AFA961339
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2024 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8EBB21577
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2024 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B21C93A3;
	Tue, 27 Aug 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MdltamPQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB071C93B0
	for <linux-integrity@vger.kernel.org>; Tue, 27 Aug 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773735; cv=none; b=cN0jCSm0iSSpIYL3V6pUZEhLt0M0ez1tB+JxOjl14sRrORr92abEYW36E6cwUK/rR5PX1jga3gXMfiGDLXFFAFpr4LyALsfD2baKUfQC9NMlQi0ziVREb3JskkXlwH/HjCjpVRAJaXpXdha4wjCw0QZGT+g/Fgj/L7j6IKix+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773735; c=relaxed/simple;
	bh=yMIqIqsHc58PbYXTEzoWmcGe7WxkG66Dfoev7TszcS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpiXHtDR8RQ0ELxpRfued48wFmHJ7Ui2K5vIzEVMfKJxW7B2Uu79VwTQ1EjLwZF9ktdR9X5aLKVLjT8FWpG/ADZ4pcLtOp4LJLt5Cqajyxlr2eu2mdiiBUdfYWath+eJvMR9Rvqd6ArrIT7BrKsstfsId6KirQwHl0pvf1RqIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MdltamPQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714186ce2f2so4349544b3a.0
        for <linux-integrity@vger.kernel.org>; Tue, 27 Aug 2024 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724773733; x=1725378533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyZU/kJprJK+uVidaloko4y85cSY8MDsjFf1FeduaFk=;
        b=MdltamPQciG6RU3dSTnCanxGx2xuSZDcHIE0JQ7fNxJnrpJm5983BtfBWiO0MzihhN
         QxOXlUtBIbKr0ixV43oQmZW5+a8qSLYCpSh5mkObweiE4nyKGhHsy/0G+/eLpAIQbA0D
         F8pjxsgKEI26w0vtowJxpM+g1vS9bfzDLUsf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773733; x=1725378533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyZU/kJprJK+uVidaloko4y85cSY8MDsjFf1FeduaFk=;
        b=Pe+Z9HE5huhVfMQoO9r9iz9Mk8N2P4rqTR7cwsPJpYghSkb5YgtBEK9X55/Uasagq9
         GZekWSfylXS6o2hPzuJ2Da6ijE0V13P9cF5mXnEmQQCK8TkS0NyQl2GeYliQ9tBW9/E7
         2+cf/XLFVFR+2Aw3OPXMtMSJOVuVAKUmL0br/UStLXG8GskgjqpR4HdopfmTpYq2kmRg
         i0wCpMaUuyhBN9uLJtjqK26lSI+V2C02IR4t3+mLki9ZWJGU+oRxkRsxC4jdyxdLw7Yh
         19Yq6YAUbk6FOIJcwIdcF88rkSvJTkLvT5dztI1UIHTOdKyt0eS1l5qQxiO4R0Hk7Gwn
         fLEA==
X-Forwarded-Encrypted: i=1; AJvYcCVeOrzKH94oiQIngT//jSX44UK9sJT4eRUCblqfvd/jUssDzO9kKLDCywH5KAS71Vk/o/vZjVSd0bNYv6VtIuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPed43llv3jeuh3QBXwduxQTbVpLQ48c0ueuXHbd5Gl+B0yocn
	F2kwZT7jyhpYHCLsbIGAZoYBmApeGGUgEAjbU6E2TBGLspmLCE6cpfiKNhnmgJfrKiZmF3x0U9m
	RRASf
X-Google-Smtp-Source: AGHT+IHhZwdZs521ht99TvYd+N1C1DMKg8PEdoy+3gZtEz40AiLOKRqONnlrUyODKRv83P2r++xtEg==
X-Received: by 2002:a05:6a20:c998:b0:1c0:f5be:a3ca with SMTP id adf61e73a8af0-1cc89e1ecc7mr14079194637.30.1724773732927;
        Tue, 27 Aug 2024 08:48:52 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143425492fsm8682654b3a.58.2024.08.27.08.48.51
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 08:48:52 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20260346ca1so246045ad.0
        for <linux-integrity@vger.kernel.org>; Tue, 27 Aug 2024 08:48:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMW16cIoEAe5Th5eBjeUrR8XuxvzDx19ljA+YisudqXnzcoZdjXT1LklsElIv6Jp2JbBw5ZLTggYuc4h8RF5Y=@vger.kernel.org
X-Received: by 2002:a17:902:d4c6:b0:1fa:fe30:8fce with SMTP id
 d9443c01a7336-204e50afb1emr3053325ad.23.1724773730828; Tue, 27 Aug 2024
 08:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806165134.1692428-1-jettrink@chromium.org>
In-Reply-To: <20240806165134.1692428-1-jettrink@chromium.org>
From: Jett Rink <jettrink@chromium.org>
Date: Tue, 27 Aug 2024 09:48:39 -0600
X-Gmail-Original-Message-ID: <CAK+PMK62crXQurf1R3vQ=4mtC3pLCKUjA3Vw-qZggcK2ucdrBQ@mail.gmail.com>
Message-ID: <CAK+PMK62crXQurf1R3vQ=4mtC3pLCKUjA3Vw-qZggcK2ucdrBQ@mail.gmail.com>
Subject: Re: [PATCH v5] tpm: Add new device/vendor ID 0x50666666
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just wanted to follow up to ensure this patch got accepted. Is there
anything else I need to do?

-Jett

On Tue, Aug 6, 2024 at 10:51=E2=80=AFAM Jett Rink <jettrink@chromium.org> w=
rote:
>
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> ---
>
> Changes in v5:
> Correct Suggested-by tag form.
>
> Changes in v4:
> Add Suggested-by tag. Sorry that I forget.
>
> Changes in v3:
> Refactor ternary operators into helper method.
>
> Changes in v2:
> Patchset 2 applies cleanly
>
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 30 ++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index adf22992138e..1f83cfe2724c 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -31,7 +31,8 @@
>  #define TPM_CR50_TIMEOUT_SHORT_MS      2               /* Short timeout =
during transactions */
>  #define TPM_CR50_TIMEOUT_NOIRQ_MS      20              /* Timeout for TP=
M ready without IRQ */
>  #define TPM_CR50_I2C_DID_VID           0x00281ae0L     /* Device and ven=
dor ID reg value */
> -#define TPM_TI50_I2C_DID_VID           0x504a6666L     /* Device and ven=
dor ID reg value */
> +#define TPM_TI50_DT_I2C_DID_VID                0x504a6666L     /* Device=
 and vendor ID reg value */
> +#define TPM_TI50_OT_I2C_DID_VID                0x50666666L     /* Device=
 and vendor ID reg value */
>  #define TPM_CR50_I2C_MAX_RETRIES       3               /* Max retries du=
e to I2C errors */
>  #define TPM_CR50_I2C_RETRY_DELAY_LO    55              /* Min usecs betw=
een retries on I2C */
>  #define TPM_CR50_I2C_RETRY_DELAY_HI    65              /* Max usecs betw=
een retries on I2C */
> @@ -668,6 +669,27 @@ static const struct of_device_id of_cr50_i2c_match[]=
 =3D {
>  MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
>  #endif
>
> +/**
> + * tpm_cr50_vid_to_name() - Maps VID to name.
> + * @vendor:    Vendor identifier to map to name
> + *
> + * Return:
> + *     A valid string for the vendor or empty string
> + */
> +static const char *tpm_cr50_vid_to_name(u32 vendor)
> +{
> +       switch (vendor) {
> +       case TPM_CR50_I2C_DID_VID:
> +               return "cr50";
> +       case TPM_TI50_DT_I2C_DID_VID:
> +               return "ti50 DT";
> +       case TPM_TI50_OT_I2C_DID_VID:
> +               return "ti50 OT";
> +       default:
> +               return "";
> +       }
> +}
> +
>  /**
>   * tpm_cr50_i2c_probe() - Driver probe function.
>   * @client:    I2C client information.
> @@ -741,14 +763,16 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cl=
ient)
>         }
>
>         vendor =3D le32_to_cpup((__le32 *)buf);
> -       if (vendor !=3D TPM_CR50_I2C_DID_VID && vendor !=3D TPM_TI50_I2C_=
DID_VID) {
> +       if (vendor !=3D TPM_CR50_I2C_DID_VID &&
> +           vendor !=3D TPM_TI50_DT_I2C_DID_VID &&
> +           vendor !=3D TPM_TI50_OT_I2C_DID_VID) {
>                 dev_err(dev, "Vendor ID did not match! ID was %08x\n", ve=
ndor);
>                 tpm_cr50_release_locality(chip, true);
>                 return -ENODEV;
>         }
>
>         dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> -                vendor =3D=3D TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
> +                tpm_cr50_vid_to_name(vendor),
>                  client->addr, client->irq, vendor >> 16);
>         return tpm_chip_register(chip);
>  }
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

