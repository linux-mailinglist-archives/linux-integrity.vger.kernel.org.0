Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52572046C7
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 03:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgFWBgW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jun 2020 21:36:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:27364 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731765AbgFWBgW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jun 2020 21:36:22 -0400
IronPort-SDR: dlsQy92Mrlab15jQCyjMiF4qFGPTtFKqlZyeTiF6MbudlPHKRKk/cKrlzzdCdIl1xzXTC+nRuB
 QF3slQC69iTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="145428328"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="145428328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 18:36:20 -0700
IronPort-SDR: l0hgTZezbicPnpNQTxiqE2o0v0lv/Chi/rXanxIoShOuu8EKeXtf5Qig5J5D7f6EIG2OSBWmQR
 4wny8STu2B5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="264664177"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.133])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2020 18:36:16 -0700
Date:   Tue, 23 Jun 2020 04:36:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: Prefer async probe
Message-ID: <20200623013614.GJ28795@linux.intel.com>
References: <20200619141958.1.I58d549fded1fd2299543ede6a103fe2bb94c805d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619141958.1.I58d549fded1fd2299543ede6a103fe2bb94c805d@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 19, 2020 at 02:20:01PM -0700, Douglas Anderson wrote:
> On a Chromebook I'm working on I noticed a big (~1 second) delay
> during bootup where nothing was happening.  Right around this big
> delay there were messages about the TPM:
> 
> [    2.311352] tpm_tis_spi spi0.0: TPM ready IRQ confirmed on attempt 2
> [    3.332790] tpm_tis_spi spi0.0: Cr50 firmware version: ...
> 
> I put a few printouts in and saw that tpm_tis_spi_init() (specifically
> tpm_chip_register() in that function) was taking the lion's share of
> this time, though ~115 ms of the time was in cr50_print_fw_version().
> 
> Let's make a one-line change to prefer async probe for tpm_tis_spi.
> There's no reason we need to block other drivers from probing while we
> load.
> 
> NOTES:
> * It's possible that other hardware runs through the init sequence
>   faster than Cr50 and this isn't such a big problem for them.
>   However, even if they are faster they are still doing _some_
>   transfers over a SPI bus so this should benefit everyone even if to
>   a lesser extent.
> * It's possible that there are extra delays in the code that could be
>   optimized out.  I didn't dig since once I enabled async probe they
>   no longer impacted me.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/char/tpm/tpm_tis_spi_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index d96755935529..422766445373 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -288,6 +288,7 @@ static struct spi_driver tpm_tis_spi_driver = {
>  		.pm = &tpm_tis_pm,
>  		.of_match_table = of_match_ptr(of_tis_spi_match),
>  		.acpi_match_table = ACPI_PTR(acpi_tis_spi_match),
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe = tpm_tis_spi_driver_probe,
>  	.remove = tpm_tis_spi_remove,
> -- 
> 2.27.0.111.gc72c7da667-goog
> 


Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
