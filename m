Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E3C729CB1
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbjFIOWu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbjFIOWt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 10:22:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3663830E7;
        Fri,  9 Jun 2023 07:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C74D86189D;
        Fri,  9 Jun 2023 14:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A3DC433EF;
        Fri,  9 Jun 2023 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320568;
        bh=PFEySzC7tACtP/XyP8fsFBTxk131P5gKr8Atqgb7dqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toM+LEM3YozmlHZ+XBE1mBW2qo9vKIHZXnT3Z9w+O8PouVRTFEeXOiTABtgF2FYs5
         fecRrZ7+1u0/8h1veEVKzXPEuK3WXbwX1y6RVhgFxD3Aj6c27wT8ydpqcr2+v5iyu/
         bOdPel0xByAwm/pI5BsjqNcvB0SDjKu/cWw1xwg0egDUkV9opK9g+P1tlEswQYPPq1
         /LYOP/IPXu3ISRFIDS4eUCfNYGrFFqfc5qMemZLjC/HLBUV9cJzyZp8hj/yqfS0Kfb
         /kOUg9QB1Iz6M0I+HroY6Bi+E0ygI3nnP8E4Z2OleuuVMDtZczKCZnNZEm8uZZ7VxM
         8bRuhy49tzTJw==
Date:   Fri, 9 Jun 2023 15:22:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Message-ID: <3b5e149d-4d52-46f8-85f5-821aa7b99ae9@sirena.org.uk>
References: <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
 <ZEag1lAonYcmNFXk@orome>
 <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com>
 <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com>
 <ZHhW_wFvRWInR_iM@orome>
 <dec901be-4bef-43e0-a125-23c5c4e92789@sirena.org.uk>
 <ZHiQ44gAL3YEZPUh@orome>
 <c0cf893d-8bc5-4f4b-a326-bb10dd0c84de@sirena.org.uk>
 <CT86OCSDQS17.21FWH48JRKKI9@suppilovahvero>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O0OAEmr40Unwas+e"
Content-Disposition: inline
In-Reply-To: <CT86OCSDQS17.21FWH48JRKKI9@suppilovahvero>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--O0OAEmr40Unwas+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 05:19:15PM +0300, Jarkko Sakkinen wrote:
> On Thu Jun 1, 2023 at 3:40 PM EEST, Mark Brown wrote:
> > On Thu, Jun 01, 2023 at 02:36:51PM +0200, Thierry Reding wrote:
> > > On Thu, Jun 01, 2023 at 12:04:59PM +0100, Mark Brown wrote:
> > > > On Thu, Jun 01, 2023 at 10:29:51AM +0200, Thierry Reding wrote:

> > > Jarkko, can you pick this up for v6.5?

> > No, I said that I had applied the SPI parts for v6.4 so there would be
> > no blocker whenever people got round to reviewing the TPM side.

> I'm totally cool with this: won't pick the patch then.

I have no intention of applying the patch, I am expecting it to go via
the TPM tree.

--O0OAEmr40Unwas+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSDNbAACgkQJNaLcl1U
h9DFTwf/fxy+VHx3rPhTGHVI3g+3B5YfkGyIZZUUizJ4Y/FZtz0pzFEhcFBiThSp
BDTAmG6rrS1bbseotnzkArMI0v0ts2BX+CqhaLxWAOHusEdDUS/xXXUzpZOHK6ZD
+f7ELs4ANXHTVpYV3vDnMO0bcM/hjtljLj2GhG1FrAcEHP6l65aTrK+we6dR1kMG
QlIIiLaq2DWTrpW9B//x8slCBbMmCNEWNnmGliBuBr83FiIPydVk8oDXlHZSfSd0
90tNkdivHTNG9Dhs1c487cuIoirN+sevKt+ucutAk/mi1tteNzIlpVcLQoq54sOj
0QgnqIAtXTSvNrPXRMKufHDpj3K0qA==
=uu6t
-----END PGP SIGNATURE-----

--O0OAEmr40Unwas+e--
