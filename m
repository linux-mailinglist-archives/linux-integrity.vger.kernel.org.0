Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E04440FC0
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Oct 2021 18:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJaR2H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Oct 2021 13:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhJaR2G (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Oct 2021 13:28:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5602260F4F;
        Sun, 31 Oct 2021 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635701134;
        bh=zN8yQFNClD3MLP6tvq7SoO7Xv8MoW8wgpR90u//ZFVI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bVc1QYRzdcvCveVC0bMy8NbUFSmJ9BAniTTacWFnLGFAO7XpwsIEslxAMOk3UJlbR
         ANPBoQNKf39LcxDCwb2nc6tWoFo6FzJ42ABGcObfi5SgjW99toFCePRwoI1Ta0Nqmw
         g+4DbhiTk8sMdrvyit9R40H4CgneA0HXdaea43Uup/nEq6JM1F9HBd+ePYJYjXnp3d
         9XqBSgknWga5bHmBQyc/3uY9s2Cb57t4NpwwOkNuFndtEh79KaZvHXX3y2vucaEJaj
         Q549w17Oezcsj8LMeqzN1i3hHABR5j7uKWA0MkOOBiHFIjBPR1vDjd6UuvED0472jK
         SRbTpOCpGovTw==
Message-ID: <d5af176ca19ec16cd2102799113cd302dec9db1b.camel@kernel.org>
Subject: Re: [PATCH v2] tpm: tpm_tis_spi_cr50: Add default RNG quality
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-integrity@vger.kernel.org
Cc:     apronin@chromium.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org
Date:   Sun, 31 Oct 2021 19:25:32 +0200
In-Reply-To: <20211029080915.63838-1-angelogioacchino.delregno@collabora.com>
References: <20211029080915.63838-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-10-29 at 10:09 +0200, AngeloGioacchino Del Regno wrote:
> To allow this device to fill the kernel's entropy pool at boot,
> setup a default quality for the hwrng found in Cr50.
>=20
> After some testing with rngtest and dieharder it was, in short,
> discovered that the RNG produces fair quality randomness, giving
> around 99.93% successes in rngtest FIPS140-2.
>=20
> Notably, though, when testing with dieharder it was noticed that
> we get 3 WEAK results over 114, which isn't optimal, and also
> the p-values distribution wasn't uniform in all the cases, so a
> conservative quality value was chosen by applying an arbitrary
> penalty to the calculated values.
>=20
> For reference, this is how the values were calculated:
>=20
> The dieharder results were averaged, then normalized (0-1000)
> and re-averaged with the rngtest result (where the result was
> given a score of 99.93% of 1000, so 999.3), then aggregated
> together and averaged again.
> An arbitrary penalty of -100 was applied due to the retrieved
> value, which brings us finally to 700.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
> =C2=A0drivers/char/tpm/tpm_tis_spi_cr50.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_t=
is_spi_cr50.c
> index ea759af25634..dae98dbeeeac 100644
> --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> @@ -36,6 +36,9 @@
> =C2=A0#define TPM_CR50_FW_VER(l)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0(0x0f90 | ((l) << 12))
> =C2=A0#define TPM_CR50_MAX_FW_VER_LEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A064
> =C2=A0
> +/* Default quality for hwrng. */
> +#define TPM_CR50_DEFAULT_RNG_QUALITY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0700
> +
> =C2=A0struct cr50_spi_phy {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm_tis_spi_phy sp=
i_phy;
> =C2=A0
> @@ -264,6 +267,7 @@ int cr50_spi_probe(struct spi_device *spi)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy =3D &cr50_phy->spi_ph=
y;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy->flow_control =3D cr5=
0_spi_flow_control;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy->wake_after =3D jiffi=
es;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phy->priv.rng_quality =3D TPM_=
CR50_DEFAULT_RNG_QUALITY;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_completion(&phy->rea=
dy);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cr50_phy->access_delay =
=3D CR50_NOIRQ_ACCESS_DELAY;

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>

/Jarkko

