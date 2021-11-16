Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1DE45367E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Nov 2021 16:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbhKPP7A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Nov 2021 10:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238786AbhKPP6g (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Nov 2021 10:58:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56F9861C12;
        Tue, 16 Nov 2021 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637078137;
        bh=BtX9jWIE6WUbTRiRgUTKNHbgFkN+wayCXmBMzwnBEig=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sQrpgmoEuMvlyB81kjfD1Qprbc7wjRQ7bpneSX5EtVJ7NvUp0moWnF3L7dpdvjaJR
         zQRv631GTYogbxdLcvFlL23wDy02L6rpXdSI8VPvyNyv7BLdCawuQ4LJINa0+vzB8i
         zz9rJ2vcOcNSFrOJtKSQ3NbX+5GC9FsoQn5LQDSkv4Hd8KU9vkOyp3DQ69g2bfgIpj
         sQeaLx/IqA06P1Hj2miL23JaEDStw6Y4vQgkyn1ow7BiVjIOYfz+cT20YrVfG7qWbz
         WGeF8eF79hRE/xEWrnSNkc0MCMttiEhK0kfUNll8RbM/DSqxYaXDFgWbHpUYX86gGx
         YEzdGT4el7szw==
Message-ID: <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
Subject: Re: [PATCH] char: tpm: cr50_i2c: Drop if with an always false
 condition
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Date:   Tue, 16 Nov 2021 17:55:35 +0200
In-Reply-To: <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
         <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
         <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-11-13 at 22:53 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sat, Nov 13, 2021 at 12:53:32PM +0200, Jarkko Sakkinen wrote:
> > On Fri, 2021-11-12 at 23:53 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_probe() retur=
ned
> > > successfully. As i2c_get_clientdata() returns driver data for the
> > > client's device and this was set in tpmm_chip_alloc() it won't return
> > > NULL.
> >=20
> > This does not make the check obsolete, e.g. it would catch a programmin=
g
> > error elsewhere.
> >=20
> > > Simplify accordingly to prepare changing the prototype of the i2c rem=
ove
> > > callback to return void. Notice that already today returning an error
> > > code from the remove callback doesn't prevent removal.
> >=20
> > I don't understand what you are trying to say.
>=20
> The eventual goal is the following change:
>=20
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 16119ac1aa97..c7069ebf5a66 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -273,7 +273,7 @@ struct i2c_driver {
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Standard driver model =
interfaces */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*probe)(struct i2c_c=
lient *client, const struct i2c_device_id *id);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int (*remove)(struct i2c_clien=
t *client);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void (*remove)(struct i2c_clie=
nt *client);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* New driver model inter=
face to aid the seamless removal of the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * current probe()'s, mor=
e commonly unused than used second parameter.
>=20
> To prepare that I want to change all remove callbacks to unconditionally
> return 0.
>=20
> The motivation for the above change is that returning an error from an
> i2c (or spi or platform) remove callback doesn't prevent the device from
> being removed. So the ability to return an int leads to wrong
> expectations by driver authors.
>=20
> The only effect a non-zero return code has, is an error message from the
> i2c core. So if you object to my suggested change, the minimal change I
> want to convince you of is to replace
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
>=20
> by
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>=20
> .
>=20
> Best regards
> Uwe

Please then include it to a patch set, where this happens.

/Jarkko

