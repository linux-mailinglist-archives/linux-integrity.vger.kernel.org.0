Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4815294A6F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 18:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfHSQfJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 12:35:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:10068 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfHSQfI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 12:35:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 09:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="207057229"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2019 09:35:04 -0700
Date:   Mon, 19 Aug 2019 19:35:05 +0300
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
Subject: Re: [PATCH v4 3/6] tpm: tpm_tis_spi: Add a pre-transfer callback
Message-ID: <20190819163505.wnyhgrtg4akiifdn@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org>
 <20190812223622.73297-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812223622.73297-4-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 12, 2019 at 03:36:19PM -0700, Stephen Boyd wrote:
> Cr50 firmware has a requirement to wait for the TPM to wakeup before
> sending commands over the SPI bus. Otherwise, the firmware could be in
> deep sleep and not respond. Add a hook to tpm_tis_spi_transfer() before
> we start a SPI transfer so we can keep track of the last time the TPM
> driver accessed the SPI bus.
> 
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/char/tpm/tpm_tis_spi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
> index 819602e85b34..93f49b1941f0 100644
> --- a/drivers/char/tpm/tpm_tis_spi.c
> +++ b/drivers/char/tpm/tpm_tis_spi.c
> @@ -44,6 +44,7 @@ struct tpm_tis_spi_phy {
>  	struct spi_device *spi_device;
>  	int (*flow_control)(struct tpm_tis_spi_phy *phy,
>  			    struct spi_transfer *xfer);
> +	void (*pre_transfer)(struct tpm_tis_spi_phy *phy);

A callback should have somewhat well defined purpose. A callback named
as pre_transfer() could have any purpose.

/Jarkko
