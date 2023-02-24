Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0D6A1EF3
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 16:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBXPvx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 10:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXPvw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 10:51:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2DD66977;
        Fri, 24 Feb 2023 07:51:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAC866191A;
        Fri, 24 Feb 2023 15:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F26BC433EF;
        Fri, 24 Feb 2023 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677253909;
        bh=xyswDycFYOnH3OLm6yjdEnadl171xXYVSUGbW9DmNHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVX36u2yZISWcQ3QXyTFcdSES/tw6/23dFtMGG+tCD/ohprehx2yX4V/6rTAEUP4S
         2+UOYpey9/D0PvrLUx6zV2StvNM38B1sVh2nUKGufqiHRpT4vulvb36JOBCIlyD0Vx
         rWpkB7sIBEtvSEvpPAy+ren2eyLnBiq3078vac10wGPsDpm+mZneWhMg02DkGiODr5
         AsOnK0p0BwZS6fErJgzRYortzdUQCCB/8y+wtgmsvarkE8IbC3Xy++FZvywfv+feDh
         6ET9IXyfO1ASSPkXAJ5oKbH1iFcGStzgxXRKrZiBelaSFEWKmTu2afWvU/VB/loBLR
         U74bX7sHr6Ejg==
Date:   Fri, 24 Feb 2023 15:51:41 +0000
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
Message-ID: <Y/jdDeBPM//W5WG8@sirena.org.uk>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
 <20230223162635.19747-2-kyarlagadda@nvidia.com>
 <Y/egACRAp6nKZWdN@sirena.org.uk>
 <DM4PR12MB57695DE127286D1DA436E804C3AB9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/ezwaFCn5h86u6X@sirena.org.uk>
 <DM4PR12MB5769C60EFD807376CE09DC3FC3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SemSX6WN8QUcTnlj"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5769C60EFD807376CE09DC3FC3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
X-Cookie: The early worm gets the bird.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--SemSX6WN8QUcTnlj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2023 at 02:16:27PM +0000, Krishna Yarlagadda wrote:

> > > > > +       spi_bus_lock(phy->spi_device->master);
> > > > > +
> > > > > +       while (len) {

> > > > Why?

> > > TPM supports max 64B in single transaction. Loop to send rest of it.

> > No, why is there a bus lock?

> Bus lock to avoid other clients to be accessed between TPM transfers.

That's what a bus lock does but what would be the problem if something
else sent a message between messages?  Note that a message will always
be sent atomically.

--SemSX6WN8QUcTnlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP43QwACgkQJNaLcl1U
h9A9sAgAhiW1GDLXSwrMMR4lVUh3Y2wiwwwbVC8An/U4WxMaAY4JkLdmk/PkSR2F
phAVWcUQpvwSsfrb2BYAFARC2ic/Y7iY+q7Aqxf8CAYJnT1ZjfR2cNGyYhwJm0lx
VMcxLMyGG9VF8egmG9nyUC8BvSqkX0PMpm2J6gVRg/I7RNpEtD2d7+afgwrEWORL
vefU0LC4cAKdXpeHWL8BwLVgErx6pjW4QGYo3WtQ+IiU/eiZdA9R3DolaBq4x119
zA3kN1HRpLO4R16i0pLZ/GHiyY6oIOzQmI7vzxOH2dRUnwkNZwZAB+NX0DhnkEC0
7T+RBfloSG2qeF/xfhwnEsZjWbjLXA==
=XLe0
-----END PGP SIGNATURE-----

--SemSX6WN8QUcTnlj--
