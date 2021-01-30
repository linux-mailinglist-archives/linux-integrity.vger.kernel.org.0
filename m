Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF78630984A
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 21:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhA3Ul0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 15:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhA3UlZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 15:41:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7670864E0C;
        Sat, 30 Jan 2021 20:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612039245;
        bh=DKQK33mpM/iViVFNbv8TDOJi1lqJMU2DVixsIqk2mW0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g1aOScIkLWmri33ssnNrJ4k6JVvZpVVILp/LuhDofe1VJ3ua2WxPL6jsdz/orycWT
         j8RKWFzwBVMQnU1/sS+4bS2670hjv8VN1+n8u3BBKgt86gLsI7DVBEal9iunMLhEym
         zfp5GXMQmG85eKONcfXuxYYHkEHjMRREskFEhVBYQhJo+E4jb6GWb+KoltXwkvD9mr
         R4sGgrIblh1xtBtvXKicYze9YD4+cyyiXYQ2hyDk8qsfrYqXDA8z4Byxupqr3OYDOp
         UtjYYD8J+UwntP+Bmq8BRjOXcLgkUBsTmBvohS5/vUvTSq1SHDXbkgNjl2Jt2/zCM7
         4W1TYZre/+YBw==
Message-ID: <464454f440df67d3470e67ff0386bbc306d07dac.camel@kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Add missing tpm_request/relinquish_locality
 calls
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Tj <ml.linux@elloe.vision>, Dirk Gouders <dirk@gouders.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Date:   Sat, 30 Jan 2021 22:40:40 +0200
In-Reply-To: <20210128130753.1283534-1-lma@semihalf.com>
References: <20210123014247.989368-1-lma@semihalf.com>
         <20210128130753.1283534-1-lma@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-01-28 at 14:07 +0100, Lukasz Majczak wrote:
> There is a missing call to tpm_request_locality before the call to
> the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
> approach might work for tpm2, it fails for tpm1.x - in that case
> call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
> without locality fails and in turn causes tpm_tis_core_init() to fail.
> Tested on Samsung Chromebook Pro (Caroline).
>=20
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>

Is it possible that you test against linux-next and see if any
problems still arise? I've applied the locality fixes from James.

> ---
> Jarkko, James, Guenter
>=20
> I=E2=80=99m aware about the other thread, but it seems to be dead for a f=
ew months.
> Here is the small patch as fixing this specific issue
> would allow us to unblock the ChromeOs development.=20
> We want to upstream all of our patches,
> so the ChromeOs will not diverge even more,
> so I'm hoping this could be applied, if you see it neat enough.

The usual approach is that you construct a series picking the pre-existing
fixes and on top of that create your own, if any required.

> Best regards,
> Lukasz

/Jarkko

>=20
> v1 -> v2:
> =C2=A0- fixed typos
> =C2=A0- as there is no need to enable clock, switched to
> =C2=A0=C2=A0 use only tpm_request/relinquish_locality calls
> =C2=A0- narrowed down boundaries of tpm_request/relinquish_locality calls
> =C2=A0
> =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4=
 ++--
> =C2=A0drivers/char/tpm/tpm-interface.c | 11 +++++++++--
> =C2=A0drivers/char/tpm/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0drivers/char/tpm/tpm_tis_core.c=C2=A0 | 12 ++++++++++--
> =C2=A04 files changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..5351963a4b19 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -32,7 +32,7 @@ struct class *tpm_class;
> =C2=A0struct class *tpmrm_class;
> =C2=A0dev_t tpm_devt;
> =C2=A0
> -static int tpm_request_locality(struct tpm_chip *chip)
> +int tpm_request_locality(struct tpm_chip *chip)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> =C2=A0
> @@ -47,7 +47,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0
> -static void tpm_relinquish_locality(struct tpm_chip *chip)
> +void tpm_relinquish_locality(struct tpm_chip *chip)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> =C2=A0
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-inte=
rface.c
> index 1621ce818705..69309b2bea6a 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -243,8 +243,15 @@ int tpm_get_timeouts(struct tpm_chip *chip)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->flags & TPM_CHI=
P_FLAG_TPM2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return tpm2_get_timeouts(chip);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return tpm1_get_timeouts(chip);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ssize_t ret =3D tpm_request_locality(chip);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return re=
t;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ret =3D tpm1_get_timeouts(chip);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0tpm_relinquish_locality(chip);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(tpm_get_timeouts);
> =C2=A0
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..8c13008437dd 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -193,6 +193,8 @@ static inline void tpm_msleep(unsigned int delay_msec=
)
> =C2=A0
> =C2=A0int tpm_chip_start(struct tpm_chip *chip);
> =C2=A0void tpm_chip_stop(struct tpm_chip *chip);
> +int tpm_request_locality(struct tpm_chip *chip);
> +void tpm_relinquish_locality(struct tpm_chip *chip);
> =C2=A0struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
> =C2=A0__must_check int tpm_try_get_ops(struct tpm_chip *chip);
> =C2=A0void tpm_put_ops(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 92c51c6cfd1b..0ae675e8cf2f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -754,9 +754,17 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *ch=
ip)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->flags & TPM_CHI=
P_FLAG_TPM2)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, =
desc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ssize_t ret =3D tpm_request_locality(chip);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return re=
t;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ret =3D tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap,=
 desc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0tpm_relinquish_locality(chip);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> =C2=A0}
> =C2=A0
> =C2=A0/* Register the IRQ and issue a command that will cause an interrup=
t. If an

