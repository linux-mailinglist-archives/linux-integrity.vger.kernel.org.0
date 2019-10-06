Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4016CD97A
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2019 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfJFWcg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Oct 2019 18:32:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:52024 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfJFWcg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Oct 2019 18:32:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 15:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="204889687"
Received: from dnlarsen-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.3.159])
  by orsmga002.jf.intel.com with ESMTP; 06 Oct 2019 15:32:30 -0700
Date:   Mon, 7 Oct 2019 01:32:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 4/6] tpm: tpm_tis_spi: Support cr50 devices
Message-ID: <20191006223228.GA8860@linux.intel.com>
References: <20190920183240.181420-1-swboyd@chromium.org>
 <20190920183240.181420-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920183240.181420-5-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 20, 2019 at 11:32:38AM -0700, Stephen Boyd wrote:
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

First, I apologize for such a long latency (two weeks).

I think this looks legit now.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
