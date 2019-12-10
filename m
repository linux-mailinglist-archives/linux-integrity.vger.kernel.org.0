Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3119C1199A0
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 22:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLJVrZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 16:47:25 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43373 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfLJVc1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 16:32:27 -0500
Received: by mail-yw1-f65.google.com with SMTP id s187so7903736ywe.10
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 13:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2HBW6fWxv/h9l5/xoQmu2icNmaNt5TwBrIw1IUoyYE=;
        b=g6B5OOLx1gqAh7MPazEsaen/d1R+xGYrL/GP798PFAkHdu2wiunBg2paDTaJceGbIw
         sWjAhqzIlWpesc2jzY6aw/UcUOvVt5NsNnq5e5nx14owuSFKQofWpCfg2w6HR1MAoE75
         POHT/xXoBR0ZoNG9TIoRBuXLUNkFcM17CoMaIUQ7ronNRBjck+pGb7DLuMc6mb6B1NtI
         8jPsnuvDw9MVHELMrhN88JxodOUrR/5TOT01shZZF/r2DTFrEzFc84oW6uT2psRiW69/
         3BxRoJPf3C8kfQ0qyaJhUEvaxnmLhLN0lMDuLcLsXbMJVLl66ftLXVSPkwnpmHKtWJS7
         M3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2HBW6fWxv/h9l5/xoQmu2icNmaNt5TwBrIw1IUoyYE=;
        b=BHqU/uzagejtJO6j7Az2fhflJ59jA3wz5AxIhZ0P/XfuLpoFMep5871ZikKTkh7wfo
         hwVXhL6leAoY9VwujeqwajpddRJ6b0ELMImJ1Iopv+oC6UGR5UWg84FVGwsaMfGxtagh
         QNpUcRv6I13h4DFBI6THc66i/0VqxGp0Awp9Abi7j7cggYJwEVo7gM27tkqq/0LdAKYG
         8WC5MJ+8wV3YljOPgU1yV0jahP56rU3looZpDfRsBTz+Nqs05q3Ke3IzRBs1GKFkd0ik
         uTQVcjWSIZAl/uH+UCgIJD3HttcPQD1U/VPc/TGaam5vpDKLbbZ9rj/fnRSa9ImvMMhB
         NlHg==
X-Gm-Message-State: APjAAAWdppNxAindJKOi92RAQBKDdan9LWYRzVUOf+aAGDePTYNf8ebZ
        mssc/x2aEAzsBw/KU76nxJvaV4L0WM+4h5jtXvkkZw==
X-Google-Smtp-Source: APXvYqzU6RMVMM/68NdsM1nTuws4x8Fw3keyEjjXcdNrjesF+lar40piLjYGKtCGGC7Q/Fsal1/sIH9aoZP1c8PRrik=
X-Received: by 2002:a81:5303:: with SMTP id h3mr26896078ywb.267.1576013546566;
 Tue, 10 Dec 2019 13:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20191210210735.9077-1-sashal@kernel.org> <20191210210735.9077-238-sashal@kernel.org>
In-Reply-To: <20191210210735.9077-238-sashal@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 10 Dec 2019 13:32:15 -0800
Message-ID: <CABXOdTdO16V4AtO1t=BwXW2=HAtT6CYoSddmrn5T2qZP9hs0eQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 277/350] tpm: Add a flag to indicate TPM power
 is managed by firmware
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "# v4 . 10+" <stable@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 10, 2019 at 1:12 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Stephen Boyd <swboyd@chromium.org>
>
> [ Upstream commit 2e2ee5a2db06c4b81315514b01d06fe5644342e9 ]
>
> On some platforms, the TPM power is managed by firmware and therefore we
> don't need to stop the TPM on suspend when going to a light version of
> suspend such as S0ix ("freeze" suspend state). Add a chip flag,
> TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED, to indicate this so that certain
> platforms can probe for the usage of this light suspend and avoid
> touching the TPM state across suspend/resume.
>

Are the patches needed to support CR50 (which need this patch) going
to be applied to v5.4.y as well ? If not, what is the purpose of
applying this patch to v5.4.y ?

Thanks,
Guenter

> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/char/tpm/tpm-interface.c | 8 +++++++-
>  drivers/char/tpm/tpm.h           | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index d7a3888ad80f0..7f105490604c8 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -23,6 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> +#include <linux/suspend.h>
>  #include <linux/freezer.h>
>  #include <linux/tpm_eventlog.h>
>
> @@ -394,7 +395,11 @@ int tpm_pm_suspend(struct device *dev)
>                 return -ENODEV;
>
>         if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> -               return 0;
> +               goto suspended;
> +
> +       if ((chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED) &&
> +           !pm_suspend_via_firmware())
> +               goto suspended;
>
>         if (!tpm_chip_start(chip)) {
>                 if (chip->flags & TPM_CHIP_FLAG_TPM2)
> @@ -405,6 +410,7 @@ int tpm_pm_suspend(struct device *dev)
>                 tpm_chip_stop(chip);
>         }
>
> +suspended:
>         return rc;
>  }
>  EXPORT_SYMBOL_GPL(tpm_pm_suspend);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index a7fea3e0ca86a..f3bf2f7f755c8 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -162,6 +162,7 @@ enum tpm_chip_flags {
>         TPM_CHIP_FLAG_VIRTUAL           = BIT(3),
>         TPM_CHIP_FLAG_HAVE_TIMEOUTS     = BIT(4),
>         TPM_CHIP_FLAG_ALWAYS_POWERED    = BIT(5),
> +       TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED    = BIT(6),
>  };
>
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> --
> 2.20.1
>
