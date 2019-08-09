Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF67588411
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2019 22:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfHIUbK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Aug 2019 16:31:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:61895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfHIUbK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Aug 2019 16:31:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 13:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="169414994"
Received: from wulili-mobl1.ger.corp.intel.com ([10.249.36.9])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2019 13:31:04 -0700
Message-ID: <e7951cb251116e903cf0040ee6f271dc4e68ff2e.camel@linux.intel.com>
Subject: Re: [PATCH v3 4/4] tpm: add driver for cr50 on SPI
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Date:   Fri, 09 Aug 2019 23:31:04 +0300
In-Reply-To: <20190806220750.86597-5-swboyd@chromium.org>
References: <20190806220750.86597-1-swboyd@chromium.org>
         <20190806220750.86597-5-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-08-06 at 15:07 -0700, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> firmware. The firmware running on the currently supported H1
> Secure Microcontroller requires a special driver to handle its
> specifics:
> 
>  - need to ensure a certain delay between spi transactions, or else
>    the chip may miss some part of the next transaction;
>  - if there is no spi activity for some time, it may go to sleep,
>    and needs to be waken up before sending further commands;
>  - access to vendor-specific registers.

Which Chromebook models have this chip?

If I had an access to one, how do I do kernel testing with it i.e.
how do I get it to boot initramfs and bzImage from a USB stick?

/Jarkko

