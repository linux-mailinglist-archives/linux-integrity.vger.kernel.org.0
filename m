Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED51D3A54
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2019 09:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfJKHua (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Oct 2019 03:50:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36338 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfJKHua (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 03:50:30 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iIpgx-0000mF-Tj; Fri, 11 Oct 2019 09:50:27 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v7 0/6] tpm: Add driver for cr50
Date:   Fri, 11 Oct 2019 09:50:27 +0200
Message-ID: <4042311.vcUrecXYXX@diego>
In-Reply-To: <20191006223831.GA10397@linux.intel.com>
References: <20190920183240.181420-1-swboyd@chromium.org> <20191006223831.GA10397@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am Montag, 7. Oktober 2019, 00:39:00 CEST schrieb Jarkko Sakkinen:
> On Fri, Sep 20, 2019 at 11:32:34AM -0700, Stephen Boyd wrote:
> > This patch series adds support for the H1 secure microcontroller
> > running cr50 firmware found on various recent Chromebooks. This driver
> > is necessary to boot into a ChromeOS userspace environment. It
> > implements support for several functions, including TPM-like
> > functionality over a SPI interface.
> > 
> > The last time this was series sent looks to be [1]. I've looked over the
> > patches and review comments and tried to address any feedback that
> > Andrey didn't address (really minor things like newlines). I've reworked
> > the patches from the last version to layer on top of the existing TPM
> > TIS SPI implementation in tpm_tis_spi.c. Hopefully this is more
> > palatable than combining the two drivers together into one file.
> > 
> > Please review so we can get the approach to supporting this device
> > sorted out.
> > 
> > [1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org

[...]

> OK, so, I put these to my master in hopes to get testing exposure.
> I think the changes are in great shape now. Thank you.

on a rk3399-gru-bob it works nicely for me, so
Tested-by: Heiko Stuebner <heiko@sntech.de>

Thanks
Heiko


