Return-Path: <linux-integrity+bounces-3244-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F1946038
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A0B2853D2
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE0015C159;
	Fri,  2 Aug 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BKvudFLM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628AE15C15C
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611974; cv=none; b=GGAKVfPgn8xCo/m7UKyMPAVzylFBKtfg2rTnnC1AOqWB2qPtn8R0netccmipPaRUTsCdlbOS0my73trEn7MUx+n3ZBuVRMu41GW/lpHwPEzbKldScBZQIlMxWDlNkXwsTjg6oysXRrfFKBSiSVVzAiJ7J2gKNSkDMI1uVuf9GH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611974; c=relaxed/simple;
	bh=yf3/DcLNflmZVVdGmRQQ3m5ZTvXvQqIBueCI1PWXdwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwKjnJ4s33Wjnse/27F63WFgd+KqnK9h4SCV8KoTTOwNeVwXbHrWr97RiOWQrhBB7x9gzukxglkpgbFQTDTZ4h8KSBCyyc858zsKtmhQomsVpU5u0eBnVIgx8ByQwmqvwIkxBJKjxIbVRtRCoqNs++VibFTsCkABGHevi0ibsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BKvudFLM; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5c8c1006eso4732236eaf.3
        for <linux-integrity@vger.kernel.org>; Fri, 02 Aug 2024 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722611970; x=1723216770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVQxTJ6XiBlo2K6vivKGyjwtwzsISazu9ikSPPmJl/k=;
        b=BKvudFLMgRl2q3rvuTbFgJvNchsosRZK4tIukjujKRw1dEr89Jz2GO8z9IurlGrvcP
         Wjh5ti/uV11DwSPsTUIGYK5qVo/QekWR6Xhk9lcbuWearkuOEX6HWZgDHlTSIrsdYDah
         xjdBbMymQPfOrplba70BKcxbvLeHMSmEFbKGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611970; x=1723216770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVQxTJ6XiBlo2K6vivKGyjwtwzsISazu9ikSPPmJl/k=;
        b=RDAAK0xOE6HUo8ZJn8bfEpVsx21nheveXY8Qw1dm+t2NjCyAUis46ufWheR0GTcqsN
         Caf9iOwMt7EKcZXMVupx8yanTfmFmpec2O1vJNWZyUPf2jHolLJSOQ3eRwAwt1WZSFdK
         ccbPa7Ht/VvQkc/TyAj7CaZgyCrZj86qznhRc3GtZjPfEzODIVADMKSSd/NXGUXyTa29
         ubmDdHK2QFBJJ++vYcUJdkLhTTB88RWfubrvSgAIf186yxSuUthwSsnhz/3ZaCn+1cPk
         a9Co4jrKet6amt7xahSPez5WdAoz+ykrotxzuouWvvsoMfvREhY6WjF41YkUBw46osBI
         qYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW74rBGRK/XOumXl2+1YPGHp1sYdrmyP1QCP1Kf3RiM+tHZQBAfw2ZI4jYbxG7VcaBCiA/4I/EuSUTYcbQ/1ZgcIZni10OiJcwT1y8CrXCI
X-Gm-Message-State: AOJu0Yx3gPBmidT2d6UKyu40hk6pzzQ2MeR0QzMfJHFTd9QHDPffoAP8
	Wx2ol6JED7NRQFhwrwS6mRALbPQB85eA7tBV4c74sy+BrNOFMymqhqaeGXcHGg1Hqn34JlEYkHo
	NZA==
X-Google-Smtp-Source: AGHT+IET4EQQ0MrqJ5PjS77FdtIVWuByjF7+WbMH/2gYrFAwEZn1GU8FKJTh0w3veLKFmO+aYr7FQQ==
X-Received: by 2002:a05:6870:c18b:b0:261:1eb4:dd8e with SMTP id 586e51a60fabf-26891aa8b89mr4863729fac.2.1722611970112;
        Fri, 02 Aug 2024 08:19:30 -0700 (PDT)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com. [209.85.160.48])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2689a2fc510sm355130fac.22.2024.08.02.08.19.29
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 08:19:29 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2689f749649so390857fac.0
        for <linux-integrity@vger.kernel.org>; Fri, 02 Aug 2024 08:19:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWI8wfcRiQzTg6mVVvdGGcNSHF5k3llzrLmFItwvOvCDb25oUYt89VDqIfHwalpngNS4dtSSRT3fL+Wpv+T1ochQlp6CBjc9Vjb1h0VT+GV
X-Received: by 2002:a05:6870:b025:b0:25e:24b:e65b with SMTP id
 586e51a60fabf-26891f23fc9mr4898926fac.42.1722611968742; Fri, 02 Aug 2024
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718202359.127482-1-jettrink@chromium.org>
In-Reply-To: <20240718202359.127482-1-jettrink@chromium.org>
From: Jett Rink <jettrink@chromium.org>
Date: Fri, 2 Aug 2024 09:19:17 -0600
X-Gmail-Original-Message-ID: <CAK+PMK4yBkqpfJdcQ5M93DKB1-7Wn4zJmx6VmqNghogJJhDa6A@mail.gmail.com>
Message-ID: <CAK+PMK4yBkqpfJdcQ5M93DKB1-7Wn4zJmx6VmqNghogJJhDa6A@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Add new device/vendor ID 0x50666666
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could I get some feedback on this patch please? Is there something I
am not doing correctly?

-Jett

On Thu, Jul 18, 2024 at 2:24=E2=80=AFPM Jett Rink <jettrink@chromium.org> w=
rote:
>
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> ---
>
> Changes in v2:
> Patchset 2 applies cleanly
>
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index adf22992138e..b50005ccfc5e 100644
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
> @@ -741,14 +742,18 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cl=
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
> +                vendor =3D=3D TPM_CR50_I2C_DID_VID    ? "cr50" :
> +                vendor =3D=3D TPM_TI50_DT_I2C_DID_VID ? "ti50 DT" :
> +                                                    "ti50 OT",
>                  client->addr, client->irq, vendor >> 16);
>         return tpm_chip_register(chip);
>  }
> --
> 2.45.2.1089.g2a221341d9-goog
>

