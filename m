Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6286EC0AC
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjDWPIY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDWPIX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 11:08:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45272E73;
        Sun, 23 Apr 2023 08:08:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D49A161A18;
        Sun, 23 Apr 2023 15:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62058C433EF;
        Sun, 23 Apr 2023 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682262501;
        bh=Bx08/1DfqELmigMEJHsOejEGnnoVg2rW5edq8aepiMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INdR8/X3lJVtD4B20CDbxGQjqqiWV8AcaGSfeoVppiLGDmv7vdgy0fC1aPiI4wXKb
         E33YNCFOu2n2nA47tfllh27dBlZqxVqOvLbRzcCCYihSTEKarZYOCL6IYgjuZjBu9N
         iv969l3igGxijcs62IlpWZMXIYnUwoll3SI4g5P5W91XpVNR3RnuWtslVYVD1QXAmY
         9eqtF06gESC7jxsmOPaTrmSCLBgs4R7wAnu0LyaF7ZK6SxD1u3pVeJwxjrit1adB7w
         pTVFdLG3jwsYqVhv4mPG6WdJR2vAAlzMnuUf6ZmW6IKeTQrsNlBDT71AJp6U/fjyJr
         oSpnn2JgC7nKw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 18:08:16 +0300
Message-Id: <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        <jsnitsel@redhat.com>, <robh+dt@kernel.org>, <broonie@kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
X-Mailer: aerc 0.14.0
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
In-Reply-To: <20230421091309.2672-3-kyarlagadda@nvidia.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Apr 21, 2023 at 12:13 PM EEST, Krishna Yarlagadda wrote:
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
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_t=
is_spi_main.c
> index a0963a3e92bd..8967f179f808 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -71,8 +71,74 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi=
_phy *phy,
>  	return 0;
>  }
> =20
> -int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> -			 u8 *in, const u8 *out)
> +/*
> + * Half duplex controller with support for TPM wait state detection like
> + * Tegra QSPI need CMD, ADDR & DATA sent in single message to manage HW =
flow
> + * control. Each phase sent in different transfer for controller to iden=
ity
> + * phase.
> + */
> +static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr=
,
> +				     u16 len, u8 *in, const u8 *out)
> +{
> +	struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> +	struct spi_transfer spi_xfer[3];
> +	struct spi_message m;
> +	u8 transfer_len;
> +	int ret;
> +
> +	while (len) {
> +		transfer_len =3D min_t(u16, len, MAX_SPI_FRAMESIZE);
> +
> +		spi_message_init(&m);
> +		phy->iobuf[0] =3D (in ? 0x80 : 0) | (transfer_len - 1);
> +		phy->iobuf[1] =3D 0xd4;
> +		phy->iobuf[2] =3D addr >> 8;
> +		phy->iobuf[3] =3D addr;
> +
> +		memset(&spi_xfer, 0, sizeof(spi_xfer));
> +
> +		spi_xfer[0].tx_buf =3D phy->iobuf;
> +		spi_xfer[0].len =3D 1;
> +		spi_message_add_tail(&spi_xfer[0], &m);
> +
> +		spi_xfer[1].tx_buf =3D phy->iobuf + 1;
> +		spi_xfer[1].len =3D 3;
> +		spi_message_add_tail(&spi_xfer[1], &m);
> +
> +		if (out) {
> +			spi_xfer[2].tx_buf =3D &phy->iobuf[4];
> +			spi_xfer[2].rx_buf =3D NULL;
> +			memcpy(&phy->iobuf[4], out, transfer_len);
> +			out +=3D transfer_len;
> +		}
> +
> +		if (in) {
> +			spi_xfer[2].tx_buf =3D NULL;
> +			spi_xfer[2].rx_buf =3D &phy->iobuf[4];
> +		}
> +
> +		spi_xfer[2].len =3D transfer_len;
> +		spi_message_add_tail(&spi_xfer[2], &m);
> +
> +		reinit_completion(&phy->ready);
> +
> +		ret =3D spi_sync(phy->spi_device, &m);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (in) {
> +			memcpy(in, &phy->iobuf[4], transfer_len);
> +			in +=3D transfer_len;
> +		}
> +
> +		len -=3D transfer_len;
> +	}
> +
> +	return ret;
> +}
> +
> +static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr=
,
> +				     u16 len, u8 *in, const u8 *out)
>  {
>  	struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
>  	int ret =3D 0;
> @@ -140,6 +206,24 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, =
u32 addr, u16 len,
>  	return ret;
>  }
> =20
> +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +			 u8 *in, const u8 *out)
> +{
> +	struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
> +	struct spi_controller *ctlr =3D phy->spi_device->controller;
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
> =20
>  	phy->flow_control =3D tpm_tis_spi_flow_control;
> =20
> +	if (dev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
> +		dev->mode |=3D SPI_TPM_HW_FLOW;
> +
>  	/* If the SPI device has an IRQ then use that */
>  	if (dev->irq > 0)
>  		irq =3D dev->irq;
> --=20
> 2.17.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Should I pick these patches?

BR, Jarkko
