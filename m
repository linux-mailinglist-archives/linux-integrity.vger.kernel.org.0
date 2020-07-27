Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C922E640
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgG0HLK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 03:11:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50799 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0HLK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 03:11:10 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N4h7p-1kyCr62TdH-011hog; Mon, 27 Jul 2020 09:11:07 +0200
Received: by mail-qk1-f182.google.com with SMTP id u64so14355116qka.12;
        Mon, 27 Jul 2020 00:11:07 -0700 (PDT)
X-Gm-Message-State: AOAM531OSdJyh3z8+ghcN9eoMwnQL5ebKU0+xOc2zmyA/5ri9anUQq4Q
        Ut1RRd6tvjNX2x1IolAjyHi7RKwuzKQBc8nCC74=
X-Google-Smtp-Source: ABdhPJy3om/b5yfbL78HDLH/rnzkke+/U+UGsNkbziTiST5/6yFHt5avoAQwzc+RR0buVr7DFkGVHITGn7RcGzdsP58=
X-Received: by 2002:a37:9004:: with SMTP id s4mr21325446qkd.286.1595833866359;
 Mon, 27 Jul 2020 00:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200727025323.26712-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20200727025323.26712-1-tianjia.zhang@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 09:10:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2neQUP2marbRUxpSZE4OTJtf97JKSK5-LC6EzH8rRHDQ@mail.gmail.com>
Message-ID: <CAK8P3a2neQUP2marbRUxpSZE4OTJtf97JKSK5-LC6EzH8rRHDQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix the description error of the help information in Kconfig
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        gregkh <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christophe Ricard <christophe.ricard@gmail.com>,
        Peter Huewe <peter.huewe@infineon.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8Z5K81F9baE7B2UaBG7GLmf7c7eet4NNXGiJprqd+LoI1Ak6v7f
 N3woNLGYBGzhnzUxbrq31ftzIgs9tDE+CEmNTha3xdo5bRSWzA6cRN0loJIuhnFcivk633b
 333pTz8tK9+eML8uu9LTYU7BuqCW00DJ/h64Y8wSmBr85k0hJX0C+/AoQn3nBfUPROuZyPA
 Oo8uSWdTLOOhzoYw2vjdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Wct88ulyn8=:KvaP+lz/86jDuuHMJ/yfXP
 /ELuXiqhtIm4OTTc2o+4wdhiXccCq3VCHZ37uaNyCEXy/fcG3g+3vPVdETIFApsAQ9iExLblS
 cLYkz0UQn2lU5rz5UtYXgSEQa/5xjFF4RioilFWaLoNxX+HJPHS8Ypv3FhYjO0a/h84HJeKw7
 3YDbsRaiABB+zBkAcEZKcrJ2H6ywdRecH288pgt/g4MvN6tso9oKvGjBwUlBXK4w6qygFN6Hy
 kKfYN5+GotKLb41bHI+q7IyPR1VPhnXOP09uaW5LDkUfU9TdC3lF1oVzpbUNfXIXNYpv0fu/8
 176F/g7ELCg3rECy2O+6s72mDftUNSlGYjI6rxTYlOFaiZEN/y17KwseNvNqfP2tzbXTGN6MP
 tzSEfnhXs7H4qh84Rm66xk0GZNK5ArXWd7qOoNGfGs3NZvPsMBnxD+jhzkX5tNrtDvo1CfHyN
 79c7xy/e7puo/zy/kV4rXNTw5/Np04A4y1UrsojToSpiiYrE8K/M+6POtEIMQgXSMpbZ7CFrB
 wVvJY6+0w8LOtCxd2VoU3A3jMs/2Og5bPWRLypsS+XaiBw3uZgaayPB//6ZgrIjaCy+whDU7H
 ga52W04iYK8dMR1xLJQbH/UIUWRTgsakI7apDlvpHCxxNpguLx4jDyJ8Pd7exHVryasa5K7xc
 Vgl6qjbp78K2dXuaZHwIp2iTlAto4TJg9kf+817vugcGWhrSi5tJeYl/ET3ZDwFjAaVQHAMDl
 iNMqwy9jOWHI+tueEfNLV7yLT5vwx3MJ3Vc1QLf4SEV1MhfMnkaVnMwwT1Ya2kkiteuvOdck1
 R1rVF4U+TD4g3EKBWL5JMVjd2wPpm6nUwqomONkkLNKrz05/zvIXi2OWGe0TbxYVckc+YQ4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 27, 2020 at 4:54 AM Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> Obviously, the TPM version number in the help message is wrong, which
> will cause confusion. This patch fixes it.

How is this "obvious"? I tried finding the specification and could not
see anything
to back up TIS 1.3 being only supported with TPM 1.3, or the existence of a
TPM 1.3 specification at all.

Please consider that not everyone reading this patch description is deeply
familiar with the details and explain exactly what the mistake is.

> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

In a bug fix, try to always add a 'FIxes' tag such as 'Fixes: 0edbfea537d1
("tpm/tpm_tis_spi: Add support for spi phy")', and Cc everyone that was
involved in the original patch that introduced a bug so they can Ack or
Nak it.

      Arnd

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
