Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9D6A5142
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Feb 2023 03:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjB1Cgc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 21:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1Cgc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 21:36:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1601F2749A;
        Mon, 27 Feb 2023 18:36:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC23B60C4D;
        Tue, 28 Feb 2023 02:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4F9C433EF;
        Tue, 28 Feb 2023 02:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677551790;
        bh=YkYrE/66JIbKjV2GisFBDCUFQh90xWJG9H4uHts57Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sinxr+v6ElgqMLvk+Nu9cUgpCwG5cFGMKMV4wDWxEisnDge5/R2loFXubbEu9T51P
         aPl2yNPR70NQt5iPmXA84ftk69BBGSywnkz5cvwJ7+fgJmSjQXk865WqlzGAJH1Ko6
         Op+RVABe7l55N4xo9OGyALD5JsQNagK6lOghmin17fQsfuvTR4dLau1Fzi6oR9kXz6
         FqlmROiY26FRPtrHmgU60ulB5LoqPJkbJk2si20ZyIlX6izztJaBpzYEdFlj5jGGsV
         ZMK0SIaLvF+o2LogSyFNKYdbbe9njsX2wFUCk22bQp2b+pWOjPffxnAVk6d8REWD2X
         vWdTpSxNxzRFA==
Date:   Tue, 28 Feb 2023 04:36:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/1oqr0RfD7KVA4y@kernel.org>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227120702.13180-3-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 27, 2023 at 05:37:01PM +0530, Krishna Yarlagadda wrote:
> TPM devices raise wait signal on last addr cycle. This can be detected
> by software driver by reading MISO line on same clock which requires
> full duplex support. In case of half duplex controllers wait detection
> has to be implemented in HW.
> Support hardware wait state detection by sending entire message and let
> controller handle flow control.

When a is started sentence with the word "support" it translates to "I'm
too lazy to write a proper and verbose description of the implementation"
:-)

It has some abstract ideas of the implementation, I give you that, but do
you think anyone ever will get any value of reading that honestly? A bit
more concrette description of the change helps e.g. when bisecting bugs.

> QSPI controller in Tegra236 & Tegra241 implement TPM wait polling.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 92 ++++++++++++++++++++++++++++-
>  1 file changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index a0963a3e92bd..5f66448ee09e 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -71,8 +71,74 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
>  	return 0;
>  }
>  
> -int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> -			 u8 *in, const u8 *out)
> +/*
> + * Half duplex controller with support for TPM wait state detection like
> + * Tegra241 need cmd, addr & data sent in single message to manage HW flow
> + * control. Each phase sent in different transfer for controller to idenity
> + * phase.
> + */
> +int tpm_tis_spi_hw_flow_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +				 u8 *in, const u8 *out)
> +{
> +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> +	struct spi_transfer spi_xfer[3];
> +	struct spi_message m;
> +	u8 transfer_len;
> +	int ret;
> +
> +	while (len) {
> +		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
> +
> +		spi_message_init(&m);
> +		phy->iobuf[0] = (in ? 0x80 : 0) | (transfer_len - 1);
> +		phy->iobuf[1] = 0xd4;
> +		phy->iobuf[2] = addr >> 8;
> +		phy->iobuf[3] = addr;
> +
> +		memset(&spi_xfer, 0, sizeof(spi_xfer));
> +
> +		spi_xfer[0].tx_buf = phy->iobuf;
> +		spi_xfer[0].len = 1;
> +		spi_message_add_tail(&spi_xfer[0], &m);
> +
> +		spi_xfer[1].tx_buf = phy->iobuf + 1;
> +		spi_xfer[1].len = 3;
> +		spi_message_add_tail(&spi_xfer[1], &m);
> +
> +		if (out) {
> +			spi_xfer[2].tx_buf = &phy->iobuf[4];
> +			spi_xfer[2].rx_buf = NULL;
> +			memcpy(&phy->iobuf[4], out, transfer_len);
> +			out += transfer_len;
> +		}
> +
> +		if (in) {
> +			spi_xfer[2].tx_buf = NULL;
> +			spi_xfer[2].rx_buf = &phy->iobuf[4];
> +		}
> +
> +		spi_xfer[2].len = transfer_len;
> +		spi_message_add_tail(&spi_xfer[2], &m);
> +
> +		reinit_completion(&phy->ready);
> +
> +		ret = spi_sync_locked(phy->spi_device, &m);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (in) {
> +			memcpy(in, &phy->iobuf[4], transfer_len);
> +			in += transfer_len;
> +		}
> +
> +		len -= transfer_len;
> +	}
> +
> +	return ret;
> +}
> +
> +int tpm_tis_spi_sw_flow_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +				 u8 *in, const u8 *out)
>  {
>  	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
>  	int ret = 0;
> @@ -140,6 +206,28 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>  	return ret;
>  }
>  
> +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +			 u8 *in, const u8 *out)
> +{
> +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> +	struct spi_controller *ctlr = phy->spi_device->controller;
> +
> +	/*
> +	 * TPM flow control over SPI requires full duplex support.
> +	 * Send entire message to a half duplex controller to handle
> +	 * wait polling in controller.
> +	 * Set TPM HW flow control flag..
> +	 */
> +	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> +		phy->spi_device->mode |= SPI_TPM_HW_FLOW;
> +		return tpm_tis_spi_hw_flow_transfer(data, addr, len, in,
> +						    out);
> +	} else {
> +		return tpm_tis_spi_sw_flow_transfer(data, addr, len, in,
> +						    out);
> +	}
> +}
> +
>  static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
>  				  u16 len, u8 *result, enum tpm_tis_io_mode io_mode)
>  {
> -- 
> 2.17.1
> 

Looking pretty good but do you really want to export tpm_tis_spi_{hw,sw}_flow_transfer?

BR, Jarkko
