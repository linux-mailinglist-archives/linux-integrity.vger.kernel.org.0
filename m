Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E049C68BE06
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 14:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBFNUy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 08:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFNUh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 08:20:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0EF6E93;
        Mon,  6 Feb 2023 05:19:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38CFE60ED1;
        Mon,  6 Feb 2023 13:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1F2C4339B;
        Mon,  6 Feb 2023 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675689550;
        bh=2saXlK97w5WyWBp0YUX7n3tw1FpuVsWIsWJjLCYY7iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/JTBcx1HvSuzfy9kiR4E+ppPynHRJl6VR28pjn86PRasXMXc+ifp3QJ5rGI6Kig4
         TFqOpX9UUGjV2KLWUSF9qgNHtHAJUVKk0rH3dOMwaFuMtDv9O5CE6km6YMXjURnwt9
         z6MpS4jPKQRXcMAv6zhZw2NvD3BcqBFr5ADEk/lKNzG2yp/TRmHaRlMKygcWBlgYko
         ssuApSzuQKhXuN9AXiHDtRXmMSayla7iuYmefM/mQ/SexWZDbB3vz5BWMIu3h9TJzs
         XlBppeldaX2sCy9GHJgAxeJokMesQJH0E/xSJTTDFQP9d+drsyGhnyK5terAxjQ9tZ
         TUHdEOrBZIh4g==
Date:   Mon, 6 Feb 2023 13:19:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, robh+dt@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, jarkko@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V2 2/4] tpm: tegra: Support SPI tpm wait state detect
Message-ID: <Y+D+SHT63awKdC4H@sirena.org.uk>
References: <20230203130133.32901-1-kyarlagadda@nvidia.com>
 <20230203130133.32901-3-kyarlagadda@nvidia.com>
 <d356a20f-629c-a534-7a80-b96d0940056d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VPK3WbWBcseP0sJC"
Content-Disposition: inline
In-Reply-To: <d356a20f-629c-a534-7a80-b96d0940056d@molgen.mpg.de>
X-Cookie: Hope is a waking dream.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--VPK3WbWBcseP0sJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2023 at 12:02:56PM +0100, Paul Menzel wrote:
> Am 03.02.23 um 14:01 schrieb Krishna Yarlagadda:

> > +	/* If the SPI device has an IRQ then use that */
> > +	if (dev->irq > 0)
> > +		irq = dev->irq;
> > +	else
> > +		irq = -1;

> Use ternary operator?

>     irq = dev->irq > 0 ? dev->irq : -1;

No, please write the code using normal conditional instructions.  This
isn't the IOCCC and the ternery operator is rarely a legibility aid.

--VPK3WbWBcseP0sJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPg/kcACgkQJNaLcl1U
h9AGMQf/Wh2xXfFbQOIcvVB8NuEwAdA+/T+Qejo7UuRQlAII246c6s5rHu2KlaWh
fNVz9+ElmgrkfkOEsB5ptnv8fgJsKY4aJOueP0mLqPcKyPWlXTILkXRLzxEwKUfu
ZxHjVtzTA8ffxKF5kNm1uklIZoPMPeEVnMzDFXLO4prfN4hRX7YsbT53omOqmj8P
rejanMUrXQjcVZzvWweuGM7U2rSZnjo5MrJOaKCqZ7rjEUGZjqRHocwlXKvCA/wZ
e4jI3cCSVoDtjaH5OKcR65/lkgnYhfAKVeM9Ab8Q+oqJTWySJd+jXqw0981ejGNW
PzVoNfqIxIdVP/VNJuy17+x20tkheA==
=0C39
-----END PGP SIGNATURE-----

--VPK3WbWBcseP0sJC--
