Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C266E8873
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Apr 2023 05:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjDTDMy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Apr 2023 23:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjDTDMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Apr 2023 23:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098502117
        for <linux-integrity@vger.kernel.org>; Wed, 19 Apr 2023 20:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681960318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJkzeJvwCETUjWcwNy+63mU9+yCXou1XIKFoGxVIfQ0=;
        b=UzlpK56KozcxWUUR2VWbvemwuxkAcB4A5hqCA2PpI1Bsfv4Mjg344YOqjN4stmrqvKoVsq
        PHlVHUgOkiZdJXdF8d+wbQeep+78LVaIo8p2LLxqiIkRhAP/GNXtYVLLa/irVKOKBjWCaU
        dbnFddmUOBSsbR0q6C5EwEDsz/DeIa8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-5u-vdQKUNsGbqOQAupHW2Q-1; Wed, 19 Apr 2023 23:11:57 -0400
X-MC-Unique: 5u-vdQKUNsGbqOQAupHW2Q-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1a52677bd54so3721585ad.3
        for <linux-integrity@vger.kernel.org>; Wed, 19 Apr 2023 20:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681960316; x=1684552316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJkzeJvwCETUjWcwNy+63mU9+yCXou1XIKFoGxVIfQ0=;
        b=gtSDiCSzO8byYD920ryrR+L9jn3VgotIJH3BigyROzUOW3xkTVw193DXZTu2Eavq3T
         Y9Y0cEiWcMIQcx75/cuiuHO5MPm3BNePgwKiZl4vE5sdrjgf1/bnuZT0c1Cc0YLIyfz/
         omefGjo5OKuoaCl/P8ZE+aGTKKIp/6JbOqTCq8Cc5aRR1GamFpG1neLm1GkKb9IWkDXs
         cFw0ijW7tq7jwSPjuhksIN/7QAzIbIM0QUF0mUNc3wd6h+pz/VTsmAaRXwvc0skljgaz
         dU/sNR+TgYXs+F1NgD8C2XQEh3WHLJpz0F9+v6V4lvSyLf6EE3MCR1pA7zts8bOzZ47/
         8tlQ==
X-Gm-Message-State: AAQBX9eiVq5TxU3IA7JEvGVYqZE7c9wnrMa5b/S07UulxBTXQWaSho6+
        ts873vUhpCndjsKNS8LaciaSbUBOofOXghlVmigYLnsz51erln4QmbZhi9D9rCsuRSmUupz5UCY
        DVYCzm0PM7UhsJ4+kkI6txzDLm1qx
X-Received: by 2002:a17:902:e0cc:b0:19e:dc0e:1269 with SMTP id e12-20020a170902e0cc00b0019edc0e1269mr76471pla.7.1681960316376;
        Wed, 19 Apr 2023 20:11:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350ax8FFXo3OHHtKHTICA0kOA/Q49kpcfJ7vYva+HjvLXcSzVkRLCzrjx53STrgpygHaJ1jeLfg==
X-Received: by 2002:a17:902:e0cc:b0:19e:dc0e:1269 with SMTP id e12-20020a170902e0cc00b0019edc0e1269mr76444pla.7.1681960316010;
        Wed, 19 Apr 2023 20:11:56 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027d8d00b001a647709860sm153930plm.157.2023.04.19.20.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 20:11:55 -0700 (PDT)
Date:   Wed, 19 Apr 2023 20:11:54 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V9 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <enfduqgdgrdpfw73suydlbmu3mopk545vwrpoat2chkop375np@o3fxh5k7wc76>
References: <20230325183409.7695-1-kyarlagadda@nvidia.com>
 <20230325183409.7695-3-kyarlagadda@nvidia.com>
 <a6jhf7wghnos6yjvgt3rbudhwsx4r4r7kurm35euofz3mjwmdu@74z44ohjgmre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6jhf7wghnos6yjvgt3rbudhwsx4r4r7kurm35euofz3mjwmdu@74z44ohjgmre>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 19, 2023 at 07:32:40PM -0700, Jerry Snitselaar wrote:
> On Sun, Mar 26, 2023 at 12:04:08AM +0530, Krishna Yarlagadda wrote:
> > TPM devices may insert wait state on last clock cycle of ADDR phase.
> > For SPI controllers that support full-duplex transfers, this can be
> > detected using software by reading the MISO line. For SPI controllers
> > that only support half-duplex transfers, such as the Tegra QSPI, it is
> > not possible to detect the wait signal from software. The QSPI
> > controller in Tegra234 and Tegra241 implement hardware detection of the
> > wait signal which can be enabled in the controller for TPM devices.
> > 
> > The current TPM TIS driver only supports software detection of the wait
> > signal. To support SPI controllers that use hardware to detect the wait
> > signal, add the function tpm_tis_spi_hw_flow_transfer() and move the
> > existing code for software based detection into a function called
> > tpm_tis_spi_sw_flow_transfer(). SPI controllers that only support
> > half-duplex transfers will always call tpm_tis_spi_hw_flow_transfer()
> > because they cannot support software based detection. The bit
> > SPI_TPM_HW_FLOW is set to indicate to the SPI controller that hardware
> > detection is required and it is the responsibility of the SPI controller
> > driver to determine if this is supported or not.
> > 
> > For hardware flow control, CMD-ADDR-DATA messages are combined into a
> > single message where as for software flow control exiting method of
> > CMD-ADDR in a message and DATA in another is followed.
> > 
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/char/tpm/tpm_tis_spi_main.c | 91 ++++++++++++++++++++++++++++-
> >  1 file changed, 89 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> > index a0963a3e92bd..db9afd0b83da 100644
> > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > @@ -71,8 +71,74 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
> >  	return 0;
> >  }
> >  
> > -int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> > -			 u8 *in, const u8 *out)
> > +/*
> > + * Half duplex controller with support for TPM wait state detection like
> > + * Tegra QSPI need CMD, ADDR & DATA sent in single message to manage HW flow
> > + * control. Each phase sent in different transfer for controller to idenity
> > + * phase.
> > + */
> > +static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr,
> > +				     u16 len, u8 *in, const u8 *out)
> > +{
> > +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> > +	struct spi_transfer spi_xfer[3];
> > +	struct spi_message m;
> > +	u8 transfer_len;
> > +	int ret;
> > +
> > +	while (len) {
> > +		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
> > +
> > +		spi_message_init(&m);
> > +		phy->iobuf[0] = (in ? 0x80 : 0) | (transfer_len - 1);
> > +		phy->iobuf[1] = 0xd4;
> > +		phy->iobuf[2] = addr >> 8;
> > +		phy->iobuf[3] = addr;
> 
> I haven't looked at much TPM code in the past couple of years, but
> perhaps some defines instead of magic numbers here? 0x80 is the rw bit,
> and 0xd4 the transaction offset?
> 
> > +
> > +		memset(&spi_xfer, 0, sizeof(spi_xfer));
> > +
> > +		spi_xfer[0].tx_buf = phy->iobuf;
> > +		spi_xfer[0].len = 1;
> > +		spi_message_add_tail(&spi_xfer[0], &m);
> > +
> > +		spi_xfer[1].tx_buf = phy->iobuf + 1;
> > +		spi_xfer[1].len = 3;
> > +		spi_message_add_tail(&spi_xfer[1], &m);
> > +
> > +		if (out) {
> > +			spi_xfer[2].tx_buf = &phy->iobuf[4];
> > +			spi_xfer[2].rx_buf = NULL;
> > +			memcpy(&phy->iobuf[4], out, transfer_len);
> > +			out += transfer_len;
> > +		}
> > +
> > +		if (in) {
> > +			spi_xfer[2].tx_buf = NULL;
> > +			spi_xfer[2].rx_buf = &phy->iobuf[4];
> > +		}
> > +
> > +		spi_xfer[2].len = transfer_len;
> > +		spi_message_add_tail(&spi_xfer[2], &m);
> > +
> > +		reinit_completion(&phy->ready);
> > +
> > +		ret = spi_sync_locked(phy->spi_device, &m);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (in) {
> > +			memcpy(in, &phy->iobuf[4], transfer_len);
> > +			in += transfer_len;
> > +		}
> > +
> > +		len -= transfer_len;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> Does tpm_tis_spi_transfer_half not need to lock the bus?  The doc comments for spi_sync_locked
> state:
> 
>  This call should be used by drivers that require exclusive access to the
>  SPI bus. It has to be preceded by a spi_bus_lock call. The SPI bus must
>  be released by a spi_bus_unlock call when the exclusive access is over.
> 
> If that isn't the case should it be using spi_sync instead of spi_sync_locked?
> 
> Regards,
> Jerry

b4 mbox -c to the rescue. I found the earlier discussion with Mark about
the lock, so I guess the question is just should this call spi_sync
instead of spi_sync_locked then?

The magic numbers is a minor nit, and can probably be cleaned up
separately since the full duplex code was already doing the same
thing. The only other nit is just the older tcg spec being referenced
in patch 1.

Regards,
Jerry

> 
> > +
> > +static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,
> > +				     u16 len, u8 *in, const u8 *out)
> >  {
> >  	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> >  	int ret = 0;
> > @@ -140,6 +206,24 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> >  	return ret;
> >  }
> >  
> > +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> > +			 u8 *in, const u8 *out)
> > +{
> > +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> > +	struct spi_controller *ctlr = phy->spi_device->controller;
> > +
> > +	/*
> > +	 * TPM flow control over SPI requires full duplex support.
> > +	 * Send entire message to a half duplex controller to handle
> > +	 * wait polling in controller.
> > +	 * Set TPM HW flow control flag..
> > +	 */
> > +	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX)
> > +		return tpm_tis_spi_transfer_half(data, addr, len, in, out);
> > +	else
> > +		return tpm_tis_spi_transfer_full(data, addr, len, in, out);
> > +}
> > +
> >  static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
> >  				  u16 len, u8 *result, enum tpm_tis_io_mode io_mode)
> >  {
> > @@ -181,6 +265,9 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
> >  
> >  	phy->flow_control = tpm_tis_spi_flow_control;
> >  
> > +	if (dev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
> > +		dev->mode |= SPI_TPM_HW_FLOW;
> > +
> >  	/* If the SPI device has an IRQ then use that */
> >  	if (dev->irq > 0)
> >  		irq = dev->irq;
> > -- 
> > 2.17.1
> > 
> 

