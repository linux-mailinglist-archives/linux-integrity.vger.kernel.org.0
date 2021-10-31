Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C9440FC3
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Oct 2021 18:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhJaRak (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Oct 2021 13:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhJaRak (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Oct 2021 13:30:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E6F060F58;
        Sun, 31 Oct 2021 17:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635701288;
        bh=zKIWs4oOGTGw7ox6z7dzH/VVrJFc5UzCZNkb2WTd61k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jhegMVq26qmlCD94mhfwjhMlm5i4ZAsaDdgNW+X3i3p/w6IMMHtXpHogrvaCQOMpa
         qGUp65f8CWTOqBSaJorYe4vsNeiTaTEfT600KqaxrjPMquXM9W1prCuLblNjQHhskQ
         /rRbD0EG0s/O37nj6MdvDSnWG77JXvkQmpZeG4BcKskiqYPNfMRVtqTiwNQP1onZsc
         1/6Z/+vwdFzX2pBJCdURBsgjp5f24sM6YNOvkidx9v1ST/M4fj4RxuRGuNsaWvOz/z
         WX5SqBMJH5tbgJ0q3r+Hwxxr9uoZzwOpI75pBrQEZTTf8XAJLkwhp2Gd01Hk/xbK0A
         xduImz3CuXJUA==
Message-ID: <a4571e9c3416d11fbbac2d5a7c98180fe901ae12.camel@kernel.org>
Subject: Re: [PATCH v2] tpm: tpm_tis_spi_cr50: Add default RNG quality
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-integrity@vger.kernel.org
Cc:     apronin@chromium.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org
Date:   Sun, 31 Oct 2021 19:28:05 +0200
In-Reply-To: <d5af176ca19ec16cd2102799113cd302dec9db1b.camel@kernel.org>
References: <20211029080915.63838-1-angelogioacchino.delregno@collabora.com>
         <d5af176ca19ec16cd2102799113cd302dec9db1b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-10-31 at 19:25 +0200, Jarkko Sakkinen wrote:
> On Fri, 2021-10-29 at 10:09 +0200, AngeloGioacchino Del Regno wrote:
> > To allow this device to fill the kernel's entropy pool at boot,
> > setup a default quality for the hwrng found in Cr50.
> >=20
> > After some testing with rngtest and dieharder it was, in short,
> > discovered that the RNG produces fair quality randomness, giving
> > around 99.93% successes in rngtest FIPS140-2.
> >=20
> > Notably, though, when testing with dieharder it was noticed that
> > we get 3 WEAK results over 114, which isn't optimal, and also
> > the p-values distribution wasn't uniform in all the cases, so a
> > conservative quality value was chosen by applying an arbitrary
> > penalty to the calculated values.
> >=20
> > For reference, this is how the values were calculated:
> >=20
> > The dieharder results were averaged, then normalized (0-1000)
> > and re-averaged with the rngtest result (where the result was
> > given a score of 99.93% of 1000, so 999.3), then aggregated
> > together and averaged again.
> > An arbitrary penalty of -100 was applied due to the retrieved
> > value, which brings us finally to 700.
> >=20
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> > =C2=A0drivers/char/tpm/tpm_tis_spi_cr50.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm=
_tis_spi_cr50.c
> > index ea759af25634..dae98dbeeeac 100644
> > --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> > +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> > @@ -36,6 +36,9 @@
> > =C2=A0#define TPM_CR50_FW_VER(l)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(0x0f90 | ((l) << 12))
> > =C2=A0#define TPM_CR50_MAX_FW_VER_LEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A064
> > =C2=A0
> > +/* Default quality for hwrng. */
> > +#define TPM_CR50_DEFAULT_RNG_QUALITY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0700
> > +
> > =C2=A0struct cr50_spi_phy {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm_tis_spi_phy =
spi_phy;
> > =C2=A0
> > @@ -264,6 +267,7 @@ int cr50_spi_probe(struct spi_device *spi)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy =3D &cr50_phy->spi_=
phy;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy->flow_control =3D c=
r50_spi_flow_control;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy->wake_after =3D jif=
fies;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy->priv.rng_quality =3D TP=
M_CR50_DEFAULT_RNG_QUALITY;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_completion(&phy->r=
eady);
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cr50_phy->access_delay =
=3D CR50_NOIRQ_ACCESS_DELAY;
>=20
> Thank you.
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>

Oops, a typo.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

