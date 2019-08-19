Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBED94A95
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfHSQkK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 12:40:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:56825 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfHSQkK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 12:40:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 09:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="207058543"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2019 09:40:05 -0700
Date:   Mon, 19 Aug 2019 19:40:05 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v4 4/6] tpm: tpm_tis_spi: Export functionality to other
 drivers
Message-ID: <20190819164005.evg35d2hcuslbnrj@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org>
 <20190812223622.73297-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812223622.73297-5-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 12, 2019 at 03:36:20PM -0700, Stephen Boyd wrote:
> Export a new function, tpm_tis_spi_init(), and the associated
> read/write/transfer APIs so that we can create variant drivers based on
> the core functionality of this TPM SPI driver. Variant drivers can wrap
> the tpm_tis_spi_phy struct with their own struct and override the
> behavior of tpm_tis_spi_transfer() by supplying their own flow control
> and pre-transfer hooks. This shares the most code between the core
> driver and any variants that want to override certain behavior without
> cluttering the core driver.

I think this is adding way too much complexity for the purpose. We
definitely do want this three layer architecture here.

Instead there should be a single tpm_tis_spi driver that dynamically
either TCG or CR50. I rather take some extra bytes in the LKM than
the added complexity.

/Jarkko
