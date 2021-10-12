Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5A42AADE
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Oct 2021 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhJLRgW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Oct 2021 13:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhJLRgV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 13:36:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 102DB60F3A;
        Tue, 12 Oct 2021 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634060059;
        bh=vQbEidpgXr6FaFFn7V0wQVFQj8i1/kMIP06dD8XVfKI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FMFXZHVJfcoeh8Z/aKa+0uWphQld+A5M0vvJ2jfNQCOR6/26sAHeT2oksujVBLR6T
         4g1clLPN2oFCIZwJh8MMjW0MvFIJXh1UTPRlWubeVeYwbSXDVIgZajcWY1YZgJbVHW
         akr2ByLYWkTZQTwriV8KplrDxL0ncHpdrZYfDi0dPgZs2KAsDJsrLBP4v8dxA3x3eq
         2MdMFd8+71dmmtREeGtU8KCTGWT3ZPyGqQ3oexUnRvZ7uENLBHEqsw5w/lqT0LKV56
         9rwSOaNoobocy3nGeD36D45i9EgK34JQq1+uJYif/CcF0MwMs+fLRyaH4T4wED9sFF
         jSMepMizG/4pg==
Message-ID: <b990e7af84075968f2c0cd018077f40ec280d136.camel@kernel.org>
Subject: Re: [PATCH v2 1/1] tpm: add request_locality before write
 TPM_INT_ENABLE
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, rui.xiang@huawei.com
Date:   Tue, 12 Oct 2021 20:34:16 +0300
In-Reply-To: <20211012124803.11956-1-chenjun102@huawei.com>
References: <20211012124803.11956-1-chenjun102@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-10-12 at 12:48 +0000, Chen Jun wrote:
> the addr can not be written without request_locality.

So, you need to describe the commit does here, e.g. you could replace
what you have with

"
Locality is not appropriately requested before writing the int mask.
Add the missing boilerplate.
"

I.e. for any commit you need to be able to describe what you are doing,
not just the sympton.

>=20
> Fixes: e6aef069b6e9 ("tpm_tis: convert to using locality callbacks")
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
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

Thanks a lot for the fix. If you could fix the commit message,
I'm happy to apply this.

Also add:

Cc: stable@vger.kernel.org

/Jarkko

