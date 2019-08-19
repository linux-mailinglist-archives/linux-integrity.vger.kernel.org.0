Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16EA94A19
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2019 18:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfHSQcr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Aug 2019 12:32:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:15320 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfHSQcq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Aug 2019 12:32:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 09:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="172172910"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.125])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2019 09:32:40 -0700
Date:   Mon, 19 Aug 2019 19:32:40 +0300
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
Subject: Re: [PATCH v4 2/6] tpm: tpm_tis_spi: Introduce a flow control
 callback
Message-ID: <20190819163240.vsgylmctemzgqd34@linux.intel.com>
References: <20190812223622.73297-1-swboyd@chromium.org>
 <20190812223622.73297-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812223622.73297-3-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 12, 2019 at 03:36:18PM -0700, Stephen Boyd wrote:
> Cr50 firmware has a different flow control protocol than the one used by
> this TPM PTP SPI driver. Introduce a flow control callback so we can
> override the standard sequence with the custom one that Cr50 uses.
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
>  drivers/char/tpm/tpm_tis_spi.c | 55 +++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
> index 19513e622053..819602e85b34 100644
> --- a/drivers/char/tpm/tpm_tis_spi.c
> +++ b/drivers/char/tpm/tpm_tis_spi.c
> @@ -42,6 +42,8 @@
>  struct tpm_tis_spi_phy {
>  	struct tpm_tis_data priv;
>  	struct spi_device *spi_device;
> +	int (*flow_control)(struct tpm_tis_spi_phy *phy,
> +			    struct spi_transfer *xfer);
>  	u8 *iobuf;
>  };
>  
> @@ -50,12 +52,39 @@ static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *da
>  	return container_of(data, struct tpm_tis_spi_phy, priv);
>  }
>  
> +static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
> +				    struct spi_transfer *spi_xfer)
> +{
> +	struct spi_message m;
> +	int ret, i;
> +
> +	if ((phy->iobuf[3] & 0x01) == 0) {
> +		// handle SPI wait states
> +		phy->iobuf[0] = 0;
> +
> +		for (i = 0; i < TPM_RETRY; i++) {
> +			spi_xfer->len = 1;
> +			spi_message_init(&m);
> +			spi_message_add_tail(spi_xfer, &m);
> +			ret = spi_sync_locked(phy->spi_device, &m);
> +			if (ret < 0)
> +				return ret;
> +			if (phy->iobuf[0] & 0x01)
> +				break;
> +		}
> +
> +		if (i == TPM_RETRY)
> +			return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

AFAIK the flow control is not part of the SPI standard itself but is
proprietary for each slave device. Thus, the flow control should be
documented to the source code. I do not want flow control mechanisms to
be multiplied before this is done.

The magic number 0x01 would be also good to get rid off.

/Jarkko
