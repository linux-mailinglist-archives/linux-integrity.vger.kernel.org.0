Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDB36E87FB
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Apr 2023 04:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjDTCdf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Apr 2023 22:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjDTCdf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Apr 2023 22:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F349CB
        for <linux-integrity@vger.kernel.org>; Wed, 19 Apr 2023 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681957965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9IH18D+jEVDVrg48E7D/+Hh3Zv47nKyKN2/CYQ3+8w=;
        b=ikwwBniAbSr7wUYr3NCkLw2z/BUmm2BptMVemQT+UhrRjkVLCxK+ayC+lw+aHV8lW3Cyuf
        YJXckAB6DtpgRlU4LgAZEnLNE/qTonZo71pvkXpomitvlq145JsEfevsJ0BpjBRiwStXj5
        Jg7PJZYq9eIYcBsZFGunn9IpXH+cY28=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-7FughIsJOvixO_Cn0gG34g-1; Wed, 19 Apr 2023 22:32:44 -0400
X-MC-Unique: 7FughIsJOvixO_Cn0gG34g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1a525acf6daso5994875ad.0
        for <linux-integrity@vger.kernel.org>; Wed, 19 Apr 2023 19:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681957963; x=1684549963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9IH18D+jEVDVrg48E7D/+Hh3Zv47nKyKN2/CYQ3+8w=;
        b=OV/mFU5NpOn8sCOLbRdQighMJQ69N2X9Y9B9cSntUAwSAtKd/xjHgMAoVbvDHA1D/E
         7idAluGJ8vhWgOskajoquvYv7Qin3n6J6FMuinUyxpm37fchAF1s8faZ/k7Ro0rSKSy3
         F6D2wHlff4kkTz2BYScmDzxPBWeAKm6hStVxdR422Ta76tnXlxX608cD32kwTwGh3PPI
         Rfg4X/G9j3lPg4EtqDg5aW875RkXTXYWbeyzZWFNB1gvpQkNAMBTQxOBSSATddzyFSTa
         D78GYm4NdFeQ3aAcKbw8fQn20BfES4As214w1V74o0WioZ2u591M10PHNMe+S4GVibUA
         Weug==
X-Gm-Message-State: AAQBX9fS1mA69v87aBWK5zakq23nUdLiAM6JgHjXlXCDUM25Ox1iOXDw
        14FtHIoPjSDkr46dcP+InO6sRGwhXMY8s2f1SnBO6/RA1rsWp5+/I4i0Oc6LKGH7icMW+5S3cH2
        /AMRqo4pNyqu3WADDvvZmtPsprKYO
X-Received: by 2002:a17:902:c40f:b0:1a6:34ea:6bcf with SMTP id k15-20020a170902c40f00b001a634ea6bcfmr8945991plk.45.1681957962970;
        Wed, 19 Apr 2023 19:32:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1VqyocJwfvjl49Pr9/YOTM3pq0JRu0La34QR/GP+CXIeyAco/PY+sgLhpPkkP0NDdWwroew==
X-Received: by 2002:a17:902:c40f:b0:1a6:34ea:6bcf with SMTP id k15-20020a170902c40f00b001a634ea6bcfmr8945964plk.45.1681957962576;
        Wed, 19 Apr 2023 19:32:42 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902ee4500b001a064282b11sm124862plo.151.2023.04.19.19.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 19:32:42 -0700 (PDT)
Date:   Wed, 19 Apr 2023 19:32:40 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V9 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <a6jhf7wghnos6yjvgt3rbudhwsx4r4r7kurm35euofz3mjwmdu@74z44ohjgmre>
References: <20230325183409.7695-1-kyarlagadda@nvidia.com>
 <20230325183409.7695-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325183409.7695-3-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Mar 26, 2023 at 12:04:08AM +0530, Krishna Yarlagadda wrote:
> TPM devices may insert wait state on last clock cycle of ADDR phase.
> For SPI controllers that support full-duplex transfers, this can be
> detected using software by reading the MISO line. For SPI controllers
> that only support half-duplex transfers, such as the Tegra QSPI, it is
> not possible to detect the wait signal from software. The QSPI
> controller in Tegra234 and Tegra241 implement hardware detection of the
> wait signal which can be enabled in the controller for TPM devices.
> 
> The current TPM TIS driver only supports software detection of the wait
> signal. To support SPI controllers that use hardware to detect the wait
> signal, add the function tpm_tis_spi_hw_flow_transfer() and move the
> existing code for software based detection into a function called
> tpm_tis_spi_sw_flow_transfer(). SPI controllers that only support
> half-duplex transfers will always call tpm_tis_spi_hw_flow_transfer()
> because they cannot support software based detection. The bit
> SPI_TPM_HW_FLOW is set to indicate to the SPI controller that hardware
> detection is required and it is the responsibility of the SPI controller
> driver to determine if this is supported or not.
> 
> For hardware flow control, CMD-ADDR-DATA messages are combined into a
> single message where as for software flow control exiting method of
> CMD-ADDR in a message and DATA in another is followed.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 91 ++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index a0963a3e92bd..db9afd0b83da 100644
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
> + * Tegra QSPI need CMD, ADDR & DATA sent in single message to manage HW flow
> + * control. Each phase sent in different transfer for controller to idenity
> + * phase.
> + */
> +static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr,
> +				     u16 len, u8 *in, const u8 *out)
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

I haven't looked at much TPM code in the past couple of years, but
perhaps some defines instead of magic numbers here? 0x80 is the rw bit,
and 0xd4 the transaction offset?

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

Does tpm_tis_spi_transfer_half not need to lock the bus?  The doc comments for spi_sync_locked
state:

 This call should be used by drivers that require exclusive access to the
 SPI bus. It has to be preceded by a spi_bus_lock call. The SPI bus must
 be released by a spi_bus_unlock call when the exclusive access is over.

If that isn't the case should it be using spi_sync instead of spi_sync_locked?

Regards,
Jerry

> +
> +static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,
> +				     u16 len, u8 *in, const u8 *out)
>  {
>  	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
>  	int ret = 0;
> @@ -140,6 +206,24 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
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
> +	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX)
> +		return tpm_tis_spi_transfer_half(data, addr, len, in, out);
> +	else
> +		return tpm_tis_spi_transfer_full(data, addr, len, in, out);
> +}
> +
>  static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
>  				  u16 len, u8 *result, enum tpm_tis_io_mode io_mode)
>  {
> @@ -181,6 +265,9 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
>  
>  	phy->flow_control = tpm_tis_spi_flow_control;
>  
> +	if (dev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
> +		dev->mode |= SPI_TPM_HW_FLOW;
> +
>  	/* If the SPI device has an IRQ then use that */
>  	if (dev->irq > 0)
>  		irq = dev->irq;
> -- 
> 2.17.1
> 

