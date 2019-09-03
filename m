Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF03A70A9
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfICQj5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 12:39:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:46920 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbfICQj5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 12:39:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 09:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="183621162"
Received: from vkuppusa-mobl2.ger.corp.intel.com ([10.252.39.67])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2019 09:39:52 -0700
Message-ID: <a950f3986375ee4893dff156dc2f9554338c27d8.camel@linux.intel.com>
Subject: Re: [PATCH v6 4/4] tpm: tpm_tis_spi: Support cr50 devices
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Date:   Tue, 03 Sep 2019 19:39:51 +0300
In-Reply-To: <20190829224110.91103-5-swboyd@chromium.org>
References: <20190829224110.91103-1-swboyd@chromium.org>
         <20190829224110.91103-5-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-08-29 at 15:41 -0700, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> firmware. The firmware running on the currently supported H1 Secure
> Microcontroller requires a special driver to handle its specifics:
> 
>  - need to ensure a certain delay between SPI transactions, or else
>    the chip may miss some part of the next transaction
>  - if there is no SPI activity for some time, it may go to sleep,
>    and needs to be waken up before sending further commands
>  - access to vendor-specific registers
> 
> Cr50 firmware has a requirement to wait for the TPM to wakeup before
> sending commands over the SPI bus. Otherwise, the firmware could be in
> deep sleep and not respond. The method to wait for the device to wakeup
> is slightly different than the usual flow control mechanism described in
> the TCG SPI spec. Add a completion to tpm_tis_spi_transfer() before we
> start a SPI transfer so we can keep track of the last time the TPM
> driver accessed the SPI bus to support the flow control mechanism.
> 
> Split the cr50 logic off into a different file to keep it out of the
> normal code flow of the existing SPI driver while making it all part of
> the same module when the code is optionally compiled into the same
> module. Export a new function, tpm_tis_spi_init(), and the associated
> read/write/transfer APIs so that we can do this. Make the cr50 code wrap
> the tpm_tis_spi_phy struct with its own struct to override the behavior
> of tpm_tis_spi_transfer() by supplying a custom flow control hook. This
> shares the most code between the core driver and the cr50 support
> without combining everything into the core driver or exporting module
> symbols.
> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: Heiko Stuebner <heiko@sntech.de>

Had to time to look at this patch set after all before LPC. I just
realized that the kconfig has taken away. Not sure why is that
because there's been only request to not have a new LKM. There
still should be ability opt-out to have Cr50 support in vmlinux.

/Jarkko

