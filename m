Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908E61E9B6F
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2020 03:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgFABrM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 May 2020 21:47:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:49961 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgFABrL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 May 2020 21:47:11 -0400
IronPort-SDR: bnwIKUdM3zFGyjUmHo6alrAQeLildxFQCybqlrLXRd95/AvGmsgfE9vMd6FaLteF1+C9e+xzru
 7GbgEgV0XqJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 18:47:11 -0700
IronPort-SDR: yY+ReLDEh0PbAWeRxdaZMOTuz4lwLRP3yWWA+ziY3HY4jQzQ+eN9wrh0WcZuqOkkUE5afipicH
 kj+VzC5AOQEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="444115094"
Received: from dytagah-mobl.amr.corp.intel.com (HELO localhost) ([10.252.58.236])
  by orsmga005.jf.intel.com with ESMTP; 31 May 2020 18:47:08 -0700
Date:   Mon, 1 Jun 2020 04:47:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: Don't send anything during flow control
Message-ID: <20200601014646.GA794847@linux.intel.com>
References: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 28, 2020 at 03:19:30PM -0700, Douglas Anderson wrote:
> During flow control we are just reading from the TPM, yet our spi_xfer
> has the tx_buf and rx_buf both non-NULL which means we're requesting a
> full duplex transfer.
> 
> SPI is always somewhat of a full duplex protocol anyway and in theory
> the other side shouldn't really be looking at what we're sending it
> during flow control, but it's still a bit ugly to be sending some
> "random" data when we shouldn't.
> 
> The default tpm_tis_spi_flow_control() tries to address this by
> setting 'phy->iobuf[0] = 0'.  This partially avoids the problem of
> sending "random" data, but since our tx_buf and rx_buf both point to
> the same place I believe there is the potential of us sending the
> TPM's previous byte back to it if we hit the retry loop.
> 
> Another flow control implementation, cr50_spi_flow_control(), doesn't
> address this at all.
> 
> Let's clean this up and just make the tx_buf NULL before we call
> flow_control().  Not only does this ensure that we're not sending any
> "random" bytes but it also possibly could make the SPI controller
> behave in a slightly more optimal way.
> 
> NOTE: no actual observed problems are fixed by this patch--it's was
> just made based on code inspection.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/char/tpm/tpm_tis_spi_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index d96755935529..8d2c581a93c6 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -53,8 +53,6 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
>  
>  	if ((phy->iobuf[3] & 0x01) == 0) {
>  		// handle SPI wait states
> -		phy->iobuf[0] = 0;
> -

Why this should be removed?

/Jarkko
