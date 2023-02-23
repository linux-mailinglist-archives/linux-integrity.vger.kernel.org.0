Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B386A0EB4
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBWR3I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 12:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjBWR3G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 12:29:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7855C35;
        Thu, 23 Feb 2023 09:28:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3666170B;
        Thu, 23 Feb 2023 17:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AD8C433D2;
        Thu, 23 Feb 2023 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677173320;
        bh=LzpjYrzMkE1k7rGUe6s0yE5cuUgZpgYy+pFMFaJysHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QntOjBVFMpZDS3aIvl4xPTmGLCE+ySJySzOgtqMR265A7EJAUreBVHDdpOIzCNzkO
         T3pj8wRAByUjzJnFRo7kufApeaj0wRHb9NHxkpaP2IH+7R8D89L13b3E+Pqqz+L8lb
         ic91d9cjmAJvEfmtptILf7BILed7hdRPe6H1QZvWL7z6Z5xpHYrV9uuL9FPKv7+Sgg
         G5+7OO8DKXwsQFgaZ8ql2vxAklg9wbdfmExnSxS/emMeLB3K9ovtO3y4P+IvZfjtAj
         M4etuPrRR029NjyhGlgvclfk2YJ2CUSJNI5Dlb/cZjfhzQ18XsP3wWIYAfguWlhL0O
         bReyVZX0Qp4kA==
Date:   Thu, 23 Feb 2023 17:28:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     robh+dt@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V3 3/3] spi: tegra210-quad: Enable TPM wait polling
Message-ID: <Y/eiQg56fPn17uVf@sirena.org.uk>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
 <20230223162635.19747-4-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O/f/GcIvq3/s+B+G"
Content-Disposition: inline
In-Reply-To: <20230223162635.19747-4-kyarlagadda@nvidia.com>
X-Cookie: Hindsight is an exact science.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--O/f/GcIvq3/s+B+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2023 at 09:56:35PM +0530, Krishna Yarlagadda wrote:

> Trusted Platform Module requires flow control. As defined in TPM
> interface specification, client would drive MISO line at same cycle as
> last address bit on MOSI.
> Tegra241 QSPI controller has TPM wait state detection feature which is
> enabled for TPM client devices reported in SPI device mode bits.
> Set half duplex flag for TPM device to detect and send entire message
> to controller in one shot.

I don't really understand what the controller is actually doing here, or
what the intended effect of the SPI_TPM_HW_FLOW flag is supposed to be.

>  	/* Enable Combined sequence mode */
>  	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
> +	if (spi->mode & SPI_TPM_HW_FLOW) {
> +		if (tqspi->soc_data->tpm_wait_poll)
> +			val |= QSPI_TPM_WAIT_POLL_EN;
> +		else
> +			return -EIO;
> +	}

This just sets a bit in a register...

>  	val |= QSPI_CMB_SEQ_EN;
>  	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
>  	/* Process individual transfer list */

...my guess is that setting that bit causes the individual transfers to
be delayed in completing without further changes?  Is is just some
transfers or all of them?

--O/f/GcIvq3/s+B+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP3okEACgkQJNaLcl1U
h9DS1wf7BuDUQOr/gwEv++44AI8XaJKX7ThTm1Yz7gSKfmjBnRMD2LZKvUW7KZgc
IG+5yLeW2ggZmqBeQ3nfYjXPWc0ONXA2wRoXie3VNeaMdY6/p/B+8C5cHFoQVVW2
C7CDtV/bPXmGHsY4cBmvkOjmQiOhFuNric9K+VJJxckJzqnnxviKPK+Qhm/Q7XQs
1xIQ19QcyaLDGjRYFWDNPXY8z9Q9CsW2S9gItlVvJ6Sg3WacIvAlqpzSXafF6nj6
TDqPE893T2X1D05QPJTteq6NqjLzz3Xd5Z5IanGhHDPoEnaTs2PDqSaRCG6//x9Q
qDVJFbKisNLIOR4Dk2W7m3qBTl0j3Q==
=QTUE
-----END PGP SIGNATURE-----

--O/f/GcIvq3/s+B+G--
