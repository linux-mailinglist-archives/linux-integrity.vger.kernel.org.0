Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4320B9DADA
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 02:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfH0A6w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 20:58:52 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56606 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfH0A6w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 20:58:52 -0400
Received: from c-73-71-116-68.hsd1.ca.comcast.net ([73.71.116.68] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i2Pou-0007GJ-PT; Tue, 27 Aug 2019 02:58:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v4 0/6] tpm: Add driver for cr50
Date:   Tue, 27 Aug 2019 02:58:43 +0200
Message-ID: <5576462.WM6bgkPhtz@phil>
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am Dienstag, 13. August 2019, 00:36:16 CEST schrieb Stephen Boyd:
> This patch series adds support for the the H1 secure microcontroller
> running cr50 firmware found on various recent Chromebooks. This driver
> is necessary to boot into a ChromeOS userspace environment. It
> implements support for several functions, including TPM-like
> functionality over a SPI interface.
> 
> The last time this was series sent looks to be [1]. I've looked over the
> patches and review comments and tried to address any feedback that
> Andrey didn't address (really minor things like newlines). I've reworked
> the patches from the last version to layer on top of the existing TPM
> TIS SPI implementation in tpm_tis_spi.c. Hopefully this is more
> palatable than combining the two drivers together into one file.
> 
> [1] https://lkml.kernel.org/r/1469757314-116169-1-git-send-email-apronin@chromium.org

Gave this a spin on a rk3399-gru-scarlet and it seems to have worked fine
and tpm2-tools was happy talking to it, so

Tested-by: Heiko Stuebner <heiko@sntech.de>

From looking through the patches everything also looks nice and peachy
but my tpm-insights are limited so I don't really feel comfortable with a RB.


Heiko



