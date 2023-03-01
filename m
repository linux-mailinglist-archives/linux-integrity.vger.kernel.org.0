Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7876A6DFB
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 15:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCAOJj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 09:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCAOJi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 09:09:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681983E0B7;
        Wed,  1 Mar 2023 06:09:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cw28so5155465edb.5;
        Wed, 01 Mar 2023 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677679767;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ2h5y+b44F+mobDdB2zdaT79/B0GO70ffL6CZHUWgE=;
        b=JrRY8a+aDfmP7FhclenYHyfaudCjQqqMaVlFEzXA9zsMH1pLKxTA1IZvqtbLGQvo2j
         S6zzYEWFEM5tPZEu+VCWHhbWHFtT7IYXDV0J5e6HOk+15cK6DBkgz7TBehXMPuBWZzIP
         g+54aw9uzSVCq6g+LaveaEbLm8tLIXyVL/8Y8GF36jU2rE8jMMxOmxCgzNuRvOdcXGVw
         9sF7TixOanZdaE+bxsN1as2U3iQgRMu1mTg9GtnMlrysO+ZQ9pQbmniN4tnuRWWogyCJ
         IlNYPuKpA50iV9ObYw18WiFTaZaZy1TRbl9qVdeT8FWLtrneFHJ/iukyrpL02BftqTbq
         LtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677679767;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQ2h5y+b44F+mobDdB2zdaT79/B0GO70ffL6CZHUWgE=;
        b=HvdXkk3AdeABLztt+V4nq0HiKUMbPCMm6Bocn8xEMC2El2imyn0zv0LvKMKzysdAx/
         wR/VtG9Hx8cfiuaJDwI3qI8iQBycIy8BMFqxNDbuG9gcqvfCwctoWe5knlyORe83rGNo
         RQBcAs9er+ulrVsq9WugJP08bX81HxmoqFTkyJQhCuKIAzKsrWl9aIaSZ03eZWhxvG3/
         NLoABFfmFqDuetCiG2M9MAHa5SUQQsdNClvaFc3czgCAQWEL0hRf66nYDpyG224zur69
         /G9YsPZQfphA8zrar/0WlKDMX8DCkOGyvw4wFxiz5xryA53GMtlmwHwvaxA3ayqnR5DB
         SSvQ==
X-Gm-Message-State: AO0yUKUNawCjGlFjRXLNaiUTv77dCx45rNA9V0bf8umYlopW+Ht67QKT
        D9r9tLoar0h8ajEtXKZCcho=
X-Google-Smtp-Source: AK7set/MejFRKaJfqO1GVMw1llYY9kytb3ybjbJGwgizkRQJSDCVCjXyIjIgM0jO8roS7tmQ69h05Q==
X-Received: by 2002:a17:906:4d4b:b0:8af:2a97:91d4 with SMTP id b11-20020a1709064d4b00b008af2a9791d4mr6644489ejv.14.1677679766724;
        Wed, 01 Mar 2023 06:09:26 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qp16-20020a170907207000b008eb5877a221sm5813466ejb.75.2023.03.01.06.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:09:26 -0800 (PST)
Date:   Wed, 1 Mar 2023 15:09:24 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/9clKU9lAHxvOdd@orome>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com>
 <Y/1oqr0RfD7KVA4y@kernel.org>
 <Y/3zVdgnVz8BvGGl@ziepe.ca>
 <DM4PR12MB576942B7C00F446BDF58D984C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/9EwTtmxcVBjiHz@nvidia.com>
 <Y/9HB/KF2Kjkihkg@sirena.org.uk>
 <Y/9VkGjCP48FHtyS@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L7TwG/A0jb5em9Jb"
Content-Disposition: inline
In-Reply-To: <Y/9VkGjCP48FHtyS@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--L7TwG/A0jb5em9Jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2023 at 09:39:28AM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 01, 2023 at 12:37:27PM +0000, Mark Brown wrote:
> > On Wed, Mar 01, 2023 at 08:27:45AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Mar 01, 2023 at 11:56:53AM +0000, Krishna Yarlagadda wrote:
> >=20
> > > > TPM device connected behind half duplex controller can only work
> > > > this way. So, no additional flag needed to check.
> >=20
> > > Just because a DT hooks it up this way doesn't mean the kernel driver
> > > can support it, eg support hasn't been implemented in an older SPI
> > > driver or something.
> >=20
> > > If the failure mode is anything other than the TPM doesn't probe we
> > > will need to check for support.
> >=20
> > It's not like these buses are hot pluggable - someone would have to
> > design and manufacture a board which doesn't work.  It's probably
> > reasonable for this to fail with the SPI subsystem saying it can't
> > support things when the operation is tried.
>=20
> If the spi subsystem fails this request with these flags that would be
> great, it would cause the TPM to fail probing reliably.
>=20
> But does this patch do that? It looks like non-supporting half duplex
> drivers will just ignore the new flag?

I think the assumption is that there are currently no half duplex
drivers that would be impacted by this. If I understand correctly, the
TPM driver currently supports only full duplex controllers, because
that's required in order to detect the wait state in software.

So, yes, half duplex controllers would ignore this flag, but since they
couldn't have supported TPM flow control before anyway it doesn't make a
difference.

Thierry

--L7TwG/A0jb5em9Jb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmP/XJIACgkQ3SOs138+
s6E0sA//aMFMddr/WWIey7Ad32TSDXrGtSEPVXMk5rWm6crWKj7Py6JqCe/y+q8J
uVjrk8XOsPW/YfZnPrdjQMyJ9Kke+SqFrptQ2Dy08/6szO08PURxs5vfs773EYxG
viQywY/kNpaRkPUrpkSTGtwJDI3/OruuxJ539FEwwF3uPeRGykYv5BngON/2Dymo
kvwRaIs/nQXtYDX/RAPPXyPbFgpRPKYE2MvEqbZ9z2gsc6BJUkYn65PcTmnARFho
WuUbkltRjAFtKDlhfiOmetPQGi5COUsitMHM2gI6zqpH09mznnTo7ilwMvKP2UGd
aoGRmyyV0L3a3WpMa9okjDMutqeBCNKle3q9n7ezf1Ztz8d8yRUap/VLYOjHlrt6
4M2j2L7PmZaKXSKKp91+Sky5m+2c0ZX7l1o5ahIquZtLULcSCPKpVdz2rfAwDN2N
iFITSw9PyfKX7clGSJ3T8Gbr+TUm6HnG6bmTU4CFs64rolmg2JM4Tj8HJYAK+DDj
/J3iYwdduA5jdOpwFEFmhwnb0XMVVYRCufIFER1Ix7cG1WMJPpPr+zHC490/Gom+
Cq54KRs2WXRXlolOmEmnsQN3iZ0tBQPHuNkJmOmQLnWhDXkNzmYMU/BiPH/WZV/A
CoHwTOX/uP6FUeYJtNeXrCCz/x8gaLfG3kz9+1Ps31oO0urBnVg=
=RWuP
-----END PGP SIGNATURE-----

--L7TwG/A0jb5em9Jb--
