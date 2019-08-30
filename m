Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32547A3A8F
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfH3Pkp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 11:40:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40066 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3Pkp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 11:40:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3so3530977pls.7
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=Ni6vNyoiAeI273d2BSfT1RbRFUtf/5mAYsPvknqZkqM=;
        b=muR7C5wWL5lPrP4S4XeyNe0FZ45O/GeNLN2/NCaK1O+WpN6QlMihoe7PQzPflJ02i6
         GV+xG/6KhUXf03e1zxSM4P1ZsyC7i4I+MWgMBk0Ab5i+a50uYi4U+fIL8nHwiWM+3Jiq
         DljDInXRECSbYBXAKNKHbWpE6HUOKD/nxznnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=Ni6vNyoiAeI273d2BSfT1RbRFUtf/5mAYsPvknqZkqM=;
        b=LLiQXT/IHU1b1HsGISmdEQRI00Q7+1Qyvcgp2aGZfPIawH7Y4/zIRxS3Gsk6b+kHzN
         riemp3iI3tnc2YQRtCtEJ33O3WDuYGhwtK5bEBYwVuCKwqznFYhOWjREy7Hn4/am3jzy
         JISDLrqyeF/tcfsRPQwdx6R0MVzXyJIOR3NKY0GaV/T/7x5FUG358bZ/N4ypordTnSOF
         I6WIVa4YLi3TIRkhOHgvRedDWdY1/qehIu2eXyfLqI0WY14JJTzlHz4rkDLm9/uQDCgY
         m8xdS9wOZl1dq1xnpcSrSfG6rap9t4wYznBHGHBB9SdQOcL4zFByJ5Qj2UXNJsmN5VQJ
         smHA==
X-Gm-Message-State: APjAAAXtyu/FUZkyiFod4Ks7KIXJMxNTm3685KYuDofqDBYf6l7qx4DC
        ElIVywxT7BGZ2tvoNY2cm1xvAg==
X-Google-Smtp-Source: APXvYqzZ0ZAHomdPr+u0gekRSspkMTVbLIDC9pDSXzLNL2dUFK/VU90FKtIevvRB/QYLVlF4ZbfAlA==
X-Received: by 2002:a17:902:e9:: with SMTP id a96mr16802533pla.169.1567179644447;
        Fri, 30 Aug 2019 08:40:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i14sm3164228pfo.158.2019.08.30.08.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:40:43 -0700 (PDT)
Message-ID: <5d69437b.1c69fb81.2722d.8556@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2926868.n5I8ZQlzTx@phil>
References: <20190829224110.91103-1-swboyd@chromium.org> <20190829224110.91103-5-swboyd@chromium.org> <2926868.n5I8ZQlzTx@phil>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] tpm: tpm_tis_spi: Support cr50 devices
To:     Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 30 Aug 2019 08:40:42 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Heiko Stuebner (2019-08-30 08:33:48)
> Am Freitag, 30. August 2019, 00:41:10 CEST schrieb Stephen Boyd:
> > From: Andrey Pronin <apronin@chromium.org>
> >=20
> > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > firmware. The firmware running on the currently supported H1 Secure
> > Microcontroller requires a special driver to handle its specifics:
> >=20
> >  - need to ensure a certain delay between SPI transactions, or else
> >    the chip may miss some part of the next transaction
> >  - if there is no SPI activity for some time, it may go to sleep,
> >    and needs to be waken up before sending further commands
> >  - access to vendor-specific registers
> >=20
> > Cr50 firmware has a requirement to wait for the TPM to wakeup before
> > sending commands over the SPI bus. Otherwise, the firmware could be in
> > deep sleep and not respond. The method to wait for the device to wakeup
> > is slightly different than the usual flow control mechanism described in
> > the TCG SPI spec. Add a completion to tpm_tis_spi_transfer() before we
> > start a SPI transfer so we can keep track of the last time the TPM
> > driver accessed the SPI bus to support the flow control mechanism.
> >=20
> > Split the cr50 logic off into a different file to keep it out of the
> > normal code flow of the existing SPI driver while making it all part of
> > the same module when the code is optionally compiled into the same
> > module. Export a new function, tpm_tis_spi_init(), and the associated
> > read/write/transfer APIs so that we can do this. Make the cr50 code wrap
> > the tpm_tis_spi_phy struct with its own struct to override the behavior
> > of tpm_tis_spi_transfer() by supplying a custom flow control hook. This
> > shares the most code between the core driver and the cr50 support
> > without combining everything into the core driver or exporting module
> > symbols.
> >=20
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > Cc: Andrey Pronin <apronin@chromium.org>
> > Cc: Duncan Laurie <dlaurie@chromium.org>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > [swboyd@chromium.org: Replace boilerplate with SPDX tag, drop
> > suspended bit and remove ifdef checks in cr50.h, migrate to functions
> > exported in tpm_tis_spi.h, combine into one module instead of two]
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> This variant breaks building the tpm as a module:
>=20
>=20
> WARNING: modpost: missing MODULE_LICENSE() in drivers/char/tpm/cr50_spi.o
> see include/linux/module.h for more information
> ERROR: "tpm_tis_spi_write32" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_read32" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_read16" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_init" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_transfer" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_resume" [drivers/char/tpm/tpm_tis_spi.ko] undefined!
> ERROR: "cr50_spi_probe" [drivers/char/tpm/tpm_tis_spi.ko] undefined!
> make[2]: *** [../scripts/Makefile.modpost:103: modules-modpost] Fehler 1
> make[1]: *** [/home/devel/hstuebner/00_git-repos/linux-rockchip/Makefile:=
1302: modules] Fehler 2
> make[1]: Verzeichnis =E2=80=9E/home/devel/hstuebner/00_git-repos/linux-ro=
ckchip/_build-arm64=E2=80=9C wird verlassen
> make: *** [Makefile:179: sub-make] Fehler 2
>=20
>=20
> After adding a dummy MODULE_LICENSE I end up with:
>=20
> ERROR: "tpm_tis_spi_write32" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_read32" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_read16" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_init" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_transfer" [drivers/char/tpm/cr50_spi.ko] undefined!
> ERROR: "tpm_tis_spi_resume" [drivers/char/tpm/tpm_tis_spi.ko] undefined!
> ERROR: "cr50_spi_probe" [drivers/char/tpm/tpm_tis_spi.ko] undefined!
>=20
>=20
> So building things as modules this way clearly is not working. Going back
> to the previous approach makes the module happy again, aka:
>=20
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 6ff135d6f008..477fcddbff8c 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -21,7 +21,9 @@ tpm-$(CONFIG_EFI) +=3D eventlog/efi.o
>  tpm-$(CONFIG_OF) +=3D eventlog/of.o
>  obj-$(CONFIG_TCG_TIS_CORE) +=3D tpm_tis_core.o
>  obj-$(CONFIG_TCG_TIS) +=3D tpm_tis.o
> -obj-$(CONFIG_TCG_TIS_SPI) +=3D tpm_tis_spi.o cr50_spi.o
> +obj-$(CONFIG_TCG_TIS_SPI) +=3D tpm_tis_spi_mod.o
> +tpm_tis_spi_mod-y :=3D tpm_tis_spi.o
> +tpm_tis_spi_mod-y +=3D cr50_spi.o
>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) +=3D tpm_i2c_atmel.o
>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) +=3D tpm_i2c_infineon.o
>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) +=3D tpm_i2c_nuvoton.o
>=20

I wasn't happy that I had to make a tpm_tis_spi_mod target to get the
.ko to build properly but I thought it was because of the extra Kconfig
option. If two files can't be combined into one .ko and have it be named
tpm_tis_spi.ko then we have to do the above workaround. Or we can
#include the cr50_spi.c file into tpm_tis_spi.c file. Or we can rename
tpm_tis_spi.c to tpm_tis_spi_base.c and then do the above change with a
tpm_tis_spi-y. Maybe Masahiro has some hints.

