Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264EA1E7875
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2020 10:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgE2Idc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 May 2020 04:33:32 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:53477 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbgE2Idb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 May 2020 04:33:31 -0400
Received: from [192.168.0.6] (unknown [95.90.247.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9D5242002EE2C;
        Fri, 29 May 2020 10:33:28 +0200 (CEST)
Subject: Re: [PATCH] tpm_tis_spi: Don't send anything during flow control
To:     Douglas Anderson <dianders@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <c628b545-f883-3c2e-cabf-944f6a313bf2@molgen.mpg.de>
Date:   Fri, 29 May 2020 10:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Douglas,


Thank you for the patch.

Am 29.05.20 um 00:19 schrieb Douglas Anderson:
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

s/it's was/it was/

Were you able to test this? Maybe in the “Chromebook QA arsenal”? Are
you already running it in production on Google Chrome OS devices?

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/char/tpm/tpm_tis_spi_main.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index d96755935529..8d2c581a93c6 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -53,8 +53,6 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
>   
>   	if ((phy->iobuf[3] & 0x01) == 0) {
>   		// handle SPI wait states
> -		phy->iobuf[0] = 0;
> -
>   		for (i = 0; i < TPM_RETRY; i++) {
>   			spi_xfer->len = 1;
>   			spi_message_init(&m);
> @@ -104,6 +102,8 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>   		if (ret < 0)
>   			goto exit;
>   
> +		/* Flow control transfers are receive only */
> +		spi_xfer.tx_buf = NULL;
>   		ret = phy->flow_control(phy, &spi_xfer);
>   		if (ret < 0)
>   			goto exit;
> @@ -113,9 +113,8 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>   		spi_xfer.delay.value = 5;
>   		spi_xfer.delay.unit = SPI_DELAY_UNIT_USECS;
>   
> -		if (in) {
> -			spi_xfer.tx_buf = NULL;
> -		} else if (out) {
> +		if (out) {
> +			spi_xfer.tx_buf = phy->iobuf;
>   			spi_xfer.rx_buf = NULL;
>   			memcpy(phy->iobuf, out, transfer_len);
>   			out += transfer_len;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
