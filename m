Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9389C42CF5B
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Oct 2021 02:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhJNACQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 20:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhJNACQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 20:02:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B56961130;
        Thu, 14 Oct 2021 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634169612;
        bh=DgsauICWZrB6vmbcVKHsM1e7USI1w/ySQXqfO1/VPU0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hEb5cg2grel2fe/lRllJBbYGwl1N5p9UTx3PGvUw1cy0fYrjgeXsUHOWeVX/KK+hO
         /msPDYz+l7PGlUXjKwRCM2bsFdMwGEbQB9VxkAbRMQW2fJyxeSz3ilyXMWuU0/AW95
         ihsPKyJWW8fsQN1rIYh4kKtdnRdE9i4GGs+iatq3MYWN5+W4Iv2gWERH2zIadrx0qo
         58E0yugE2aVL89OGElIxy4kkxv0gMvZpfwOBKo/XKDbiyUpyWtBnwuFKMe1c2cVgmH
         /fY3ohU+BEol6zn4oaB9/FqwMZK8ULpaz8F/+lq10WBUxCrgbB0nnfvL8p9AqfZU9u
         Q+0znygEEk5vg==
Message-ID: <035231e191d757cb8edd1c060067b6e19ddf43ea.camel@kernel.org>
Subject: Re: [PATCH v2 1/1] tpm: add request_locality before write
 TPM_INT_ENABLE
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, rui.xiang@huawei.com
Date:   Thu, 14 Oct 2021 03:00:09 +0300
In-Reply-To: <20211013062556.116504-1-chenjun102@huawei.com>
References: <20211013062556.116504-1-chenjun102@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-10-13 at 06:25 +0000, Chen Jun wrote:
> Locality is not appropriately requested before writing the int mask.
> Add the missing boilerplate.
>=20
> Fixes: e6aef069b6e9 ("tpm_tis: convert to using locality callbacks")
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>=20
> =C2=A0v2: rewrite the commit message.
>=20
> =C2=A0drivers/char/tpm/tpm_tis_core.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 69579efb247b..bea587301917 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -978,7 +978,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm=
_tis_data *priv, int irq,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intmask |=3D TPM_INTF_CMD=
_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS=
_VALID_INT;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0intmask &=3D ~TPM_GLOBAL_=
INT_ENABLE;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D request_locality(chip, =
0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0rc =3D -ENODEV;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto out_err;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_tis_write32(priv, TPM=
_INT_ENABLE(priv->locality), intmask);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0release_locality(chip, 0);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm_chip_start(chi=
p);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

