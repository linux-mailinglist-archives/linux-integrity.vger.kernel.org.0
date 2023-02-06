Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B564168C29C
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 17:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjBFQLF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 11:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjBFQLD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 11:11:03 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9EA2FCCB;
        Mon,  6 Feb 2023 08:10:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hx15so35543815ejc.11;
        Mon, 06 Feb 2023 08:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTVXWY/3o1UVrqV9BfluzW+BNUpKYmiwJBEQxgZXRDY=;
        b=jG5bBZ3jwgVV9gOXxq1uA9c51oU4ENW3ZO7iCwd+OpDAI/oASQHItsnq2g2LfDwQWM
         ts4X+8Xtqnk/jbgs5gCc00r7HjgJ2qbNsCb7Ozl40yguxG5nXoxSgONLNgNNyMyVlCvR
         kBvUeOSXx0iNvyEC3jVFxltsI3CAayHrUSFdG/D2fuUzZkHGks5eGwmq1ru59in9yb7o
         3xmTqZCxLb3xAxmKxRy+fkZBTGvsfAfEZo//Y5XUIdxTQWFvuzM9oZ4BGdR64dfPNq63
         gW0rih+7neqgojzkapyFG5dLwbewE1oL99PCCkcOHPofTPvY+257y1tMBawfOvSmCuyl
         I69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTVXWY/3o1UVrqV9BfluzW+BNUpKYmiwJBEQxgZXRDY=;
        b=hZvi9u1LHjWVBX4bR9csPKS4Y15GauNXMH9hXgxbobrvRl2QvGWootMIPvjn6MPOCB
         0L5DA1sGvx+Afj8xE9rvPmatbiiGACQ5MpwWeHHNZzQhlIS2uCUiISugxyQTiFleCIYH
         RiqNNnB+jbc1jRD9H2xwhiMGiNZmwMX5fHJ8PAwzt+cM4Jbza/v29vj4MXCR+gI2mMJ0
         W4Jq245P4fbqTg1lZMAZkuaeU9N9xFxzXgEigBU5hDOmFV2VW5j9maQ9N4bGsqcucEcO
         73Ynz7DLCneDjuatvf9v595ShzYr6DKx144UmjdNyUoNQfooUnNL2Jm8gq4pnG1svmS5
         M/Fw==
X-Gm-Message-State: AO0yUKVnJcMKYyCoTFZva5i1xv/uQ7Xj2IbOTYNZa2aKwhjudBxOCmPb
        f6ntnQBqXvVyTL73O+MbRlLQD89XG7o=
X-Google-Smtp-Source: AK7set/lb2BzEgpyfL820itMLTe9P2w3fF+hOe578hznyyeQ+ArUiDbrjOIGiBd3TgJ7iHSP3ZBz+g==
X-Received: by 2002:a17:907:8dcd:b0:87b:db29:61af with SMTP id tg13-20020a1709078dcd00b0087bdb2961afmr21406723ejc.24.1675699835284;
        Mon, 06 Feb 2023 08:10:35 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p10-20020aa7cc8a000000b004a21c620266sm5293620edt.83.2023.02.06.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:10:34 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:10:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        robh+dt@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V2 2/4] tpm: tegra: Support SPI tpm wait state detect
Message-ID: <Y+EmeP3ccaxxaBHX@orome>
References: <20230203130133.32901-1-kyarlagadda@nvidia.com>
 <20230203130133.32901-3-kyarlagadda@nvidia.com>
 <d356a20f-629c-a534-7a80-b96d0940056d@molgen.mpg.de>
 <Y+D+SHT63awKdC4H@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4jMQNYXv9g85GIdj"
Content-Disposition: inline
In-Reply-To: <Y+D+SHT63awKdC4H@sirena.org.uk>
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


--4jMQNYXv9g85GIdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 01:19:04PM +0000, Mark Brown wrote:
> On Mon, Feb 06, 2023 at 12:02:56PM +0100, Paul Menzel wrote:
> > Am 03.02.23 um 14:01 schrieb Krishna Yarlagadda:
>=20
> > > +	/* If the SPI device has an IRQ then use that */
> > > +	if (dev->irq > 0)
> > > +		irq =3D dev->irq;
> > > +	else
> > > +		irq =3D -1;
>=20
> > Use ternary operator?
>=20
> >     irq =3D dev->irq > 0 ? dev->irq : -1;
>=20
> No, please write the code using normal conditional instructions.  This
> isn't the IOCCC and the ternery operator is rarely a legibility aid.

Looks like the SPI core sets dev->irq =3D 0 for any error other than
-EPROBE_DEFER and the TPM TIS core checks for irq !=3D 0 before trying to
setup that IRQ, so seems like we can just skip this altogether and pass
in dev->irq directly.

Thierry

--4jMQNYXv9g85GIdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPhJngACgkQ3SOs138+
s6GN1RAAraD6eFc9I0Ex4Xp09TLqgcmofp+GytuozfmFph+0j8hBhoCgH7meAK4X
v6Yj81wPmpX63ZK6wl2x8imrF3m/WbQalC/VHkHBOaEAwqcIQgxXuejPyFhdHUKH
4sp9kx1b/5wuCJRiQvw1w9OA70/tlBBpoA88y/03ErNrIcPskLB0DfrA38DgP3Nf
hDFwa95atSXIJpkY87QnGjRuDNWxdu0tfrDohWzqenaBiZ83u98oKSBPE19bc2+7
x5quKfv3t295OF2BSXJeVn5ktNlfsMHYlTIA5YEIkKtIKnfPz+LoUVwn2blTka29
ofqnDjAyEyyqZN8NdV71iZCGyUklN+rrahD/MQ7edGQePSPvX8DBnb9Y6MucRGHo
5EVdlmGBh+/Rqs5kdHZ1dqJjR3O7crR8DyrnfUuimMmRUGn0e6bEgx0NJ5z0K1VL
xth70QQ8wiie3VqC601OA57yQTPWzPL7sLfvGgA031jKDLKfuhKsG6DR260pRTRY
RnHz4NkACoO0Lso2M4GJVu14BvSKjBU2deUjws2Q2wZezgqADhJnoCepFqu2N1NO
7rXKeVGowUQCiFUIDql3+PATanYtwG1zYhZgMLFMUpBSKMoji/k0dUG6/IulZLYb
EYL4rxMYCHaazO+O9tXBZn4LSaZSyKdjpHBDHHij21fNLVpmD40=
=C7QB
-----END PGP SIGNATURE-----

--4jMQNYXv9g85GIdj--
