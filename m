Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493D322E7C1
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 10:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgG0IcX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 04:32:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0IcX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 04:32:23 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MVe5c-1kPNjt1Rzw-00RWsc; Mon, 27 Jul 2020 10:32:21 +0200
Received: by mail-qk1-f172.google.com with SMTP id l64so7717906qkb.8;
        Mon, 27 Jul 2020 01:32:21 -0700 (PDT)
X-Gm-Message-State: AOAM530aHzeBBGQBX7s1ey60X7+XOeTzej9uR9FSB61hdJv6Su3cod0w
        vLkTPquWCMSGbUWZvipwo/RME8LVclPolSPZ+4w=
X-Google-Smtp-Source: ABdhPJzyTPxOK6vZdZT/d+3i2DAYRSWdinyddxsPCbfdr6galcnEkZBovcl/giEP23k4ZYxJyKjVkd01u/IMfM+B6c8=
X-Received: by 2002:a37:b484:: with SMTP id d126mr21820563qkf.394.1595838740089;
 Mon, 27 Jul 2020 01:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200727082245.32396-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200727082245.32396-1-tianjia.zhang@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 10:32:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0FkrTKvAgPi=tnsShK+=eysbfiRxUTqoxfs6SJVXXnpw@mail.gmail.com>
Message-ID: <CAK8P3a0FkrTKvAgPi=tnsShK+=eysbfiRxUTqoxfs6SJVXXnpw@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Fix the description error of the help information
 in Kconfig
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Christophe Ricard <christophe.ricard@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        gregkh <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fGmoXc97HwWm0taWe0j3NZVkmu3qtLuXG7uRW+PrwVAcmbIshhz
 PpD9LNv2NbOrl+fDa483YXd0jnZ++ONr8j49xOklvD/HmJTXFAgRnboRoRZbnmrRdzrRHFt
 XK5HoAlPWRfSP5JJHb2JkBheyXF1xlmwNp2ZGUGofkE3HRHIIXPz//J8WGenz9VeJCQWUTa
 lHIiLq/GEStMg3mYvWSqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/PwI69mCbTE=:4LWc2xx1mee7ydFcCqtnnn
 4bXJXdCBOxHk//7lhhBaNIGLulw1CH++gO+ZOyROxcRJYohKWjiz1fFa5j9+6rPbIeG85NfC4
 VYqIDtTChhFrt1g1Kt4bDX/hGfpasBIK54mZpqo+ZJuS0x2lOu+BAFBBL4z2KmiPidVvoTsYL
 wyj9GoymU8lTFyihJgqnNpSoDSJFB/c/ug9KROCrKQ/2aRwRb4d8AWlxFoVI1qLpwfC20y3C9
 JpGqsu+x/62cjGAh3xP6zKodyS7jw07qpVZQdmzZq3RE0IujdLjIeGSu+PImg+7eWP7krG6Ex
 yBJ7FWb9rhPzWD62X0x7GgQdbu+aPihawjR1tLmYXwYFHczgbXlZ2/LhGr8RmU3f1KEoD7cKu
 9P8q0v1k3yPTtcqRJIybYR2E57L9sye9sDj6CE/AVapKFPhXXYYK0XYb9bfx1cL9B54S/FjLI
 wjtu1cQaoso5ablsuaJam8UqxAzY7G99vu8RrPMn969PkaFgPrHWmcUZRhfwE3f553vDXjyuB
 OTTqBRWg76GzEYFvfzpbq66I8hjV8xQY0jL1l3qEaupG+0vxAW6ZUOEbj/8gkfvW+o8UxQJKy
 iMg91qoS2X5YXXRFZ6bIWWrhhR+Vf+T33dQC6xoOif7W4SKL7/Hm1tudRjCWvtXnayK6KyJbg
 /is7Rcf8/ChdjUdfE87MCjTEvBsBY7wvci6urE6mnZUFucFyRpLcoqVA9m2a0E6M7pDyEfXCD
 V9RVcYzm4eVsTDqTCMzJEGg1hJ1Ext4a3wzqTp0iK0n1Asv+1QDHNTOEp06AJHbWZ6BxlvxET
 0DmcJS2H/xZXYCJLnyKQPifk7x5OxNTjd+12PM+mM1tdMG9xeKMnDKuKeEJJSuBtPY7bKDJWl
 mETJ+9qHGUeUWoOBGjDzhTdBAXEQyYf5n6aqryCmtcrXCHaWT+9r4Cx2O0VIyHA9Sx4toxA1M
 IkxwIh6uG1+OkDuE52D2DIhvdw0kdAeBUJ/r/tPsC/P9TzPPETGmD
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 27, 2020 at 10:22 AM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> SPI protocol standardized by the TCG is described in the TCG PTP
> specification 1.3 (chapter 6.4.6 SPI Bit Protocol), It was published by
> TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf.

I'm still not convinced you got this right, the document you cite only
seems to mention TPM 1.2 as the base for TIS 1.3, but not TPM 1.3.

     Arnd

> The TPM version number in the help message is wrong, which will
> cause confusion. This patch fixes it.
>
> Fixes: 0edbfea537d1 ("tpm/tpm_tis_spi: Add support for spi phy")
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  drivers/char/tpm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 58b4c573d176..8eedb3e704f3 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -62,7 +62,7 @@ config TCG_TIS_SPI
>         help
>           If you have a TPM security chip which is connected to a regular,
>           non-tcg SPI master (i.e. most embedded platforms) that is compliant with the
> -         TCG TIS 1.3 TPM specification (TPM1.2) or the TCG PTP FIFO
> +         TCG TIS 1.3 TPM specification (TPM1.3) or the TCG PTP FIFO
>           specification (TPM2.0) say Yes and it will be accessible from
>           within Linux. To compile this driver as a module, choose  M here;
>           the module will be called tpm_tis_spi.
> --
> 2.17.1
>
