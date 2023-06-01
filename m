Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEA71959A
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jun 2023 10:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjFAIaB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Jun 2023 04:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjFAI36 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Jun 2023 04:29:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB00FB;
        Thu,  1 Jun 2023 01:29:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f5d651170so400788266b.1;
        Thu, 01 Jun 2023 01:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685608194; x=1688200194;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbSQgpWmVvvf6Ger/U3E7Qya16hIjDrcHHADXFTwc44=;
        b=il2m1cdOF4m77zGJqK9Lg9lP2TL0UqL2Zz9oqwykiomjpibxeyFFLwgmc6YZ1+thzK
         NxaPxlijHYeGOtWV/2kOVhQqFtDCBX2Taon34XZPPxujGReVNKgravy+0IW62khIZ95c
         VYjCBWPiKv68SvPSGGiT02fWzUeRbLswFfhBVaxKdaXfuDTmmVGMqJLJc34D3tvHbWJo
         cvxTuO0Fal94nPLFCoRXaafA5+U6Zulu1lNguafnzAbfM5iEJvSeROCICwkBILGIx/fP
         iM3ICYdQM5Jso3KxW1Tht8t7uJJJUvgaUJn5DkiBS09t9xoHBHnrtBui2PYt9R9hiy0V
         oNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608194; x=1688200194;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbSQgpWmVvvf6Ger/U3E7Qya16hIjDrcHHADXFTwc44=;
        b=IM7f7t+fBDSWEqu2vFgj8TBJKrbYJXNDhPRN2kBzaTcI2pxtHx7afe0cyckwsAWgW8
         Iy/koLZn8CrNgHSP19xRHip5/I0lzxMghEzq/ihI2H7NwzpAd3EoxIe4KHsM/u/WfWF+
         YP3/ZmhUdbjwJlWqHUhjPHPbjdhCLXl+gVnV6L/xfr+Wke7MDcz2Ay3d0QkzZEOY9iWQ
         RMEYmHtN5PxvWUGsKBd3bXXEbeRXlcyr/y+Fy8T0DbwextronL9nyGEk/u/puAnV/y2o
         EaXW0r6BLbloBFRpu+O/ULoxRnLoThhKer1sWypVEHydDm9bTfX4OSu1kdHGP7vaIsdg
         81oQ==
X-Gm-Message-State: AC+VfDz2Pyoz2D42gxbaRVwG76uge8TVO0n/dNMzV1uL1IgCgvNzBkdi
        WitBwn3oxQiw3WmGE1lBouybvLGx5tw=
X-Google-Smtp-Source: ACHHUZ5btNdjWB8txv4wG4Dyh7VfDTUmHRsBSJTL75wiv9C2TdrgUmdAxHEPJXnQLbD7n9Yjn0KtOA==
X-Received: by 2002:a17:907:9484:b0:973:e5bf:281e with SMTP id dm4-20020a170907948400b00973e5bf281emr1054612ejc.27.1685608194075;
        Thu, 01 Jun 2023 01:29:54 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gg26-20020a170906e29a00b00973a9d66f56sm10026127ejb.206.2023.06.01.01.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 01:29:53 -0700 (PDT)
Date:   Thu, 1 Jun 2023 10:29:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
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
Message-ID: <ZHhW_wFvRWInR_iM@orome>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
 <20230421091309.2672-3-kyarlagadda@nvidia.com>
 <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
 <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
 <ZEag1lAonYcmNFXk@orome>
 <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com>
 <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tJDrl2ClcUSMc8xJ"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--tJDrl2ClcUSMc8xJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 12:43:12PM +0000, Krishna Yarlagadda wrote:
> > -----Original Message-----
> > From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > Sent: Wednesday, May 10, 2023 8:41 PM
> > To: Thierry Reding <thierry.reding@gmail.com>; Mark Brown
> > <broonie@kernel.org>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>; jsnitsel@redhat.com;
> > robh+dt@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> > krzysztof.kozlowski+dt@linaro.org; linux-spi@vger.kernel.org; linux-
> > tegra@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Jonathan Hunter <jonathanh@nvidia.com>;
> > Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> > <ldewangan@nvidia.com>
> > Subject: RE: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
> >=20
> >=20
> > > -----Original Message-----
> > > From: Thierry Reding <thierry.reding@gmail.com>
> > > Sent: 24 April 2023 21:02
> > > To: Mark Brown <broonie@kernel.org>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>; Krishna Yarlagadda
> > > <kyarlagadda@nvidia.com>; jsnitsel@redhat.com; robh+dt@kernel.org;
> > > peterhuewe@gmx.de; jgg@ziepe.ca; krzysztof.kozlowski+dt@linaro.org;
> > > linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> > > integrity@vger.kernel.org; linux-kernel@vger.kernel.org; Jonathan Hun=
ter
> > > <jonathanh@nvidia.com>; Sowjanya Komatineni
> > > <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> > > Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
> > >
> > > On Mon, Apr 24, 2023 at 04:18:45PM +0100, Mark Brown wrote:
> > > > On Mon, Apr 24, 2023 at 04:46:24PM +0200, Thierry Reding wrote:
> > > >
> > > > > Would it make sense for you to pick up patch 2/3 as well? As far =
as I
> > > > > can tell there's a build dependency on patch 1/3 because of the n=
ewly
> > > > > added SPI_TPM_HW_FLOW symbol.
> > > >
> > > > I'll include it in my pull request for spi this time round so it sh=
ould
> > > > end up in -rc1, my thinking was that I was happy with the SPI bits =
and
> > > > if it was in -rc1 then the TPM bits could be handled without cross =
tree
> > > > issues when the review was sorted (which it is now but wasn't at the
> > > > time).  If the SPI side doesn't make -rc1 for some reason I can pic=
k up
> > > > the TPM bit as well, and/or do a signed tag.
> > >
> > > Sounds good.
> > >
> > > Thanks,
> > > Thierry
> >=20
> > Mark,
> > Now that SPI changes are in, can we pull this TPM change for rc2.
> > Will this be picked into SPI or TPM list?
> Jarkko, Mark,
> Can we pick this change in TPM list since SPI header changes are in.

Hey Mark, Jarkko,

any ideas on how we can best get this merged? I guess at this point it
could go through either tree since the SPI dependency has been in Linus'
tree since v6.4-rc1.

Thierry

--tJDrl2ClcUSMc8xJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmR4Vv8ACgkQ3SOs138+
s6Ea2A//aD5NaNndniIgOO2WjoxEOu9lY1qLgQ0/tEZFzRiILX1RXAo4oJmIl1QF
ruHanVFdif3GT52KJMKLm18U2aMJ1+TJ20DABJq4NEjQd6oRkZvsIYhR41HLK/Ij
ui7cAlpHhFUy9qe8L/ehN9E5mkCkoU2SlZlSwHa7YOONIWyoC0FDiCUAGUwTHyem
nkqlEXkYXVXdFtDVyHu6M4QalSGtQ9SGkFFKxQXqcCy84pUA5o9jnQhtL/0qnM+Q
R3SlpH97SKq0InYsNcEqVIuF5qr+jvjvr4kiDrKDMzs4uQ08lsAZO1ADMAuTU1Vv
QrF0zpXwZsiP9bf9m6GOmvw5TW9trEiSQpcKol8QzS6Ouqc2CFDN3J4PhQ9PsOjc
kx/LJBc4kN3WJOGnPM90IZv9Wf8FhdD6efuiTpaKBR2HojEfGLbYs0bd4ZhsDeSD
jQcrdKrA1tKr0dOfBTiFNuKGfa/O0K8X/j9tAcEDUi+AZphe5VMZv9k4T3U+G4O5
Gkt7G1mMMwIVJAKOqLsQDY+LSqBrfrZUL7JU7m+/VUmTA0l0LSaFzBrrWpOeP30W
2bkrTmDchXLK65ax7yLgXcpBU0S6dCwqatQn5I550R8Qd54w+PKSiHLp+wPPWHIU
Gk3zF2jdpwxXjKjj4aIksuBOYwUKCgzxNoMxGBqDIAOaTH/GBvo=
=SRF2
-----END PGP SIGNATURE-----

--tJDrl2ClcUSMc8xJ--
