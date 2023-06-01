Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC5719C50
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jun 2023 14:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjFAMkY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Jun 2023 08:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAMkX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Jun 2023 08:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54A0119;
        Thu,  1 Jun 2023 05:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C02460BBA;
        Thu,  1 Jun 2023 12:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A1AC433D2;
        Thu,  1 Jun 2023 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685623221;
        bh=7qqTSFuzN+5BAsf9nDoTRMBA/FCLSHSdLYJW3vp1ILc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuDym9NHx1DIGY7ks5zS3LxttTt/Gp5ALbhSyLuwxTJG60Fnvm4bieKZoCRLvao5B
         d3yBlAj1enLvnuAC6A6fUO3fdppTTMqOtScu1SSW6I68garnk6yrEhuBBQ9m9nkDKn
         GsMIVC1ImFHGu6wlV0g2JIDbPz1D+SDtXxgDBsXkv+Rj8aJA0wt1+Q236dvi5VFRmh
         4c9vbUcE856dKA8yFfI0I9ihdiW2phqGjjGsGwcXVuAw/NR7h6bm4vWKoopaxLg0if
         9eMFuDhK0rxuvDrua6bGV8hxeTm/ILj3kXnTH6IqmMP7IvK+RwPeytg+Yu9qtABOBJ
         bpP3F3BqukUtQ==
Date:   Thu, 1 Jun 2023 13:40:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
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
Message-ID: <c0cf893d-8bc5-4f4b-a326-bb10dd0c84de@sirena.org.uk>
References: <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
 <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
 <ZEaWQD_QTs2usVl8@orome>
 <5fae29cd-d5f4-4616-be1c-1cd4d5b9a538@sirena.org.uk>
 <ZEag1lAonYcmNFXk@orome>
 <DM4PR12MB5769BB69B97F77DBA9ED2935C3779@DM4PR12MB5769.namprd12.prod.outlook.com>
 <DM4PR12MB5769499349B6B936FE46BF0CC3419@DM4PR12MB5769.namprd12.prod.outlook.com>
 <ZHhW_wFvRWInR_iM@orome>
 <dec901be-4bef-43e0-a125-23c5c4e92789@sirena.org.uk>
 <ZHiQ44gAL3YEZPUh@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IvavpcweNeB8Xkph"
Content-Disposition: inline
In-Reply-To: <ZHiQ44gAL3YEZPUh@orome>
X-Cookie: Positively no smoking.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--IvavpcweNeB8Xkph
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 01, 2023 at 02:36:51PM +0200, Thierry Reding wrote:
> On Thu, Jun 01, 2023 at 12:04:59PM +0100, Mark Brown wrote:

> > On Thu, Jun 01, 2023 at 10:29:51AM +0200, Thierry Reding wrote:

> > > any ideas on how we can best get this merged? I guess at this point it
> > > could go through either tree since the SPI dependency has been in Linus'
> > > tree since v6.4-rc1.

> > I would expect it to go via whatever path TPM patches usually take given
> > that it's a TPM patch.

> There might have been a misunderstanding. My recollection was that you
> had said a few weeks ago that you would pick this up. Going through the
> thread again I realize that may not have been what you meant. Perhaps
> Jarkko misinterpreted this in the same way.

> Jarkko, can you pick this up for v6.5?

No, I said that I had applied the SPI parts for v6.4 so there would be
no blocker whenever people got round to reviewing the TPM side.

--IvavpcweNeB8Xkph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR4kacACgkQJNaLcl1U
h9AFRAf/YCqBhGfPsTf6l9zkrF2M3MzrJSBWRH5TVLxxZgKaiBKoCk9QnZbNGc4m
gONpETWIBIYicFcaWyq4DNyXljgswehEkFjXShymxKAdU7KKrEtechKCQdCuPB4f
k7hzTtG9h/A6fWBegnLjc+h6uxyjUS/LWzXuPjhajTVosZDiQEklVfclJuhqeM3q
u588U4merDDBrmpQweo3jpuYtfsy4cdauIe/S1+H4SojnZvdsIxGdpipViYpxfV3
glMZuwOlhyjeJLiH3NHjnh9HYd87ezrjnDG0MpGheGmLhJOXeEQFoNIJPxtdeGdF
6RfdPvTrFSxpzgJuHVDe1DB8o6NFQQ==
=rf99
-----END PGP SIGNATURE-----

--IvavpcweNeB8Xkph--
