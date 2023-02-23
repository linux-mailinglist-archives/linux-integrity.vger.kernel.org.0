Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9A6A0F9D
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBWSnY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 13:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBWSnX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 13:43:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2115C72BC;
        Thu, 23 Feb 2023 10:43:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5B52B81AA9;
        Thu, 23 Feb 2023 18:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90958C433EF;
        Thu, 23 Feb 2023 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677177799;
        bh=EoyvHhFMyQGXw2No9OqzspTFh7GFyMft+j03gEuJhlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWSlNN7jM4cJRtrlRZIef6oWeakHXiO+u8pKDpHIwqyNKSwBoi2gXoyht8UkYw8wS
         DOHaI4ILWvfcpYzNbA9BRCnHo3R7AunuRKE87ZmKQxyFrEMfNdl+rrilXB1bULbo/W
         c4D3ikCLnD1OXA3xIa+N0zB3JONFn4feGXSM7+wKk1NUK/pnniPzLB8Ks6tcdVDTiI
         LMZpXw7qpPe5nUjlcZ4VZ/BUmLnaTzOkuTsiiVxZq6WTqrhX3xW2wTb+5raDaDbDAB
         puhklCsImZnMrla5kjbr1HcNOe8+HTZ3XYG/W1eV3+RjX7zQE68bMg/KQL7r9SnPPJ
         A003aR5xV29Sg==
Date:   Thu, 23 Feb 2023 18:43:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/ezwaFCn5h86u6X@sirena.org.uk>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
 <20230223162635.19747-2-kyarlagadda@nvidia.com>
 <Y/egACRAp6nKZWdN@sirena.org.uk>
 <DM4PR12MB57695DE127286D1DA436E804C3AB9@DM4PR12MB5769.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qLqQojnsICnVSpYL"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB57695DE127286D1DA436E804C3AB9@DM4PR12MB5769.namprd12.prod.outlook.com>
X-Cookie: Hindsight is an exact science.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--qLqQojnsICnVSpYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2023 at 06:41:43PM +0000, Krishna Yarlagadda wrote:

> > > +       spi_bus_lock(phy->spi_device->master);
> > > +
> > > +       while (len) {

> > Why?

> TPM supports max 64B in single transaction. Loop to send rest of it.

No, why is there a bus lock?

> > > +		spi_xfer[0].tx_buf = phy->iobuf;
> > > +		spi_xfer[0].len = 1;
> > > +		spi_message_add_tail(&spi_xfer[0], &m);
> > > +
> > > +		spi_xfer[1].tx_buf = phy->iobuf + 1;
> > > +		spi_xfer[1].len = 3;
> > > +		spi_message_add_tail(&spi_xfer[1], &m);

> > Why would we make these two separate transfers?

> Tegra QSPI combined sequence requires cmd, addr and data in different
> transfers. This eliminates need for additional flag for combined sequence.

That needs some documentation, and we might need a flag to ensure the
core doesn't coalesce the transfers.

--qLqQojnsICnVSpYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP3s8AACgkQJNaLcl1U
h9AfNwf9FwG661UErfSK8+jwq23TjK4myFDmTfFv1EmXBffn/PZkzp7U+uN2/AR0
PrPrqawPn+hGqFbIbLx3M67Faj69quNMzR53xWY2pdGoPcHSq9bjdFgjg5aL2PVX
N7k2ZxyK+sJFqgQt9wcGlFu76ee9Dh7nQbs/Wg7RGqI0p4Kkq6tQz4u8p7KYNQ3i
09M0dvScK6pY8J7qWkO3IxdKzlUu3pAuVJ9F8cxk0VPOjGQ8rzBnCDDWD+ngfxmZ
RGtvCLlmvElvDrh/4LrEBm7ebNw/52ss6roaOwjKRTXfbGmhQLHhyBaiU4zzpbvd
k8rjuDCy/OMRVDVw/diilc3NoEE9ew==
=YYgH
-----END PGP SIGNATURE-----

--qLqQojnsICnVSpYL--
