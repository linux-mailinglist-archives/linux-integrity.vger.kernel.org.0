Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7A6A0E8A
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBWRTF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 12:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBWRTE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 12:19:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A1A16302;
        Thu, 23 Feb 2023 09:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A076170B;
        Thu, 23 Feb 2023 17:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0384FC433D2;
        Thu, 23 Feb 2023 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172742;
        bh=aZu6ntK+R/n0LBJGGEpFgcMMTDGBBpmpfVg/f1+RK30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX1oaKX1mIA/ZgsOM53jj21anheNjYm8fQL2pMg4sEg9IwL9m1G5bUbp7L1KTr10y
         vbqx0ThlabpbAVYmk8BqIk4/sDk91aRrGSQ6vXpNOMI44hTNqyKj5OPZkIikNyJHxs
         ceuErG78iFZk8LGF85v4+AGsmFs/t/60tK3DlyP1fY6ZhOoDRx+TrwOHl+cJCD9BlB
         qA2yMfWv7ThH8HrFDGGZiPRHIeKhr5RjYo+e5LC2DyDb36GxVrySMuJIILVi44k/Pu
         GabcD9LSvpGHxQHXcI5WnMXTc2VUUbSCkSAimm1/JcEgHmRzTbCa0ezciVaGwYWt4q
         NwRF/I8fnEPbg==
Date:   Thu, 23 Feb 2023 17:18:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/egACRAp6nKZWdN@sirena.org.uk>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
 <20230223162635.19747-2-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jD9PyuoFogP+Kbsz"
Content-Disposition: inline
In-Reply-To: <20230223162635.19747-2-kyarlagadda@nvidia.com>
X-Cookie: Hindsight is an exact science.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--jD9PyuoFogP+Kbsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2023 at 09:56:33PM +0530, Krishna Yarlagadda wrote:

> +       spi_bus_lock(phy->spi_device->master);
> +
> +       while (len) {

Why?

> +		spi_xfer[0].tx_buf = phy->iobuf;
> +		spi_xfer[0].len = 1;
> +		spi_message_add_tail(&spi_xfer[0], &m);
> +
> +		spi_xfer[1].tx_buf = phy->iobuf + 1;
> +		spi_xfer[1].len = 3;
> +		spi_message_add_tail(&spi_xfer[1], &m);

Why would we make these two separate transfers?

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

This will use the same buffer for rx and tx if some bug manages to leave
them both set.  That shouldn't be an issue but it's an alarm bell
reading the code.

> index 988aabc31871..b88494e31239 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -184,8 +184,9 @@ struct spi_device {
>  	u8			chip_select;
>  	u8			bits_per_word;
>  	bool			rt;
> -#define SPI_NO_TX	BIT(31)		/* No transmit wire */
> -#define SPI_NO_RX	BIT(30)		/* No receive wire */
> +#define SPI_NO_TX		BIT(31)		/* No transmit wire */
> +#define SPI_NO_RX		BIT(30)		/* No receive wire */
> +#define SPI_TPM_HW_FLOW		BIT(29)		/* TPM flow control */

Additions to the SPI API should be a separate commit for SPI rather than
merged into a driver change.

--jD9PyuoFogP+Kbsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP3n/8ACgkQJNaLcl1U
h9CRtAf9FFsG6QfCTNSairafqsZ3vz7HSuZQD2JqZrR15XiModR6Vy+VZVPY8CZX
202aKZVbykOJWqUuYHa2peCZzZzEbPJwCJCTebUK10mNNOuVZimWm6bgM+CjeK1v
FXO9+inTecIXDuaOWQAyuPcLZ/RzX+Yslb3oG/QdWrdnDlCdOrpHbcdj4UzMO1Us
3rYWvFeznoJuIG/KPs0T8rVW7f+Ayofa+gzAMdX+nJLNM8+weCX0G1ygPZlr0YMa
PAV3Kmxex68xxsRxbN4nSPaPEh42oTsRHUfeIRPEBWGjh1rw6oipkgrB4fr1ziXY
7yma0+7zY30UX8NsLhsSzAobhEI2rA==
=rA+v
-----END PGP SIGNATURE-----

--jD9PyuoFogP+Kbsz--
