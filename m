Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B773AC7FD
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Sep 2019 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfIGRUu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 Sep 2019 13:20:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58786 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729790AbfIGRUu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 Sep 2019 13:20:50 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i6eOF-0006wv-1N; Sat, 07 Sep 2019 19:20:47 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v6 4/4] tpm: tpm_tis_spi: Support cr50 devices
Date:   Sat, 07 Sep 2019 19:20:46 +0200
Message-ID: <3727576.e4YuOxhLfb@diego>
In-Reply-To: <8a6f05b76c37968d494fce9e555f9c21cca83003.camel@linux.intel.com>
References: <20190829224110.91103-1-swboyd@chromium.org> <5d6e9a38.1c69fb81.ad03c.cb4c@mx.google.com> <8a6f05b76c37968d494fce9e555f9c21cca83003.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

Am Samstag, 7. September 2019, 19:04:15 CEST schrieb Jarkko Sakkinen:
> On Tue, 2019-09-03 at 09:52 -0700, Stephen Boyd wrote:
> > That's fair. I'll put the Kconfig option back. There's still the small
> > issue of what to do about the module name. Should I rename the
> > tpm_tis_spi.c file to something else so that the module can keep the
> > same name? Or was the tpm_tis_spi_mod.ko trick from v5 good enough?
> 
> Not sure I understood the question correctly but how I think
> this should be deployed is:
> 
> - A boolean CONFIG_TCG_TIS_SPI_CR50.
> - tpm_tis_spi_cr50.c that gets compiled in as part of tpm_tis_spi
>   when the config option is selected.
> 
> I think this would best follow the conventions that are in place
> already. Please tell if I got something wrong or if there is some
> bottleneck in this framework but this is anyway what I would prefer
> with the knowledge I have...

There is an implementation detail to iron out:

Doing

	obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o cr50_spi.o

as in this patch results in it failing to build as a module, due to them
getting compiled to separate modules, yt sharing code. So I guess doing

	obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
	obj-$(CONFIG_TCG_TIS_SPI_CR50) += cr50_spi.o

will result in the same error, hence the question of doing something like

	obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi_mod.o
	tpm_tis_spi_mod-y := tpm_tis_spi.o
	tpm_tis_spi_mod-$(CONFIG_TCG_TIS_SPI_CR50) += cr50_spi.o

so that sources get compiled and the module getting build from the result.


Heiko


