Return-Path: <linux-integrity+bounces-2435-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233C88C897F
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 17:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABCCEB228A0
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB612F39B;
	Fri, 17 May 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNbjwofJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BB1A2C26;
	Fri, 17 May 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960528; cv=none; b=DEFWivAO44FEv2xDkS2LFmrxhlK74/vW1y0fOG20vqOpYKLFQuhGIOdG/0M7MK+t0z4op4pU9RWKLReSMGJwt5+yDyTvSg5BaHM0wEUkVwfDH+WqaTiL/MISjabZ5psKHQ1x0IXADva5M5hTKT/AmctgkNpU+fQx2H0tMTkZ73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960528; c=relaxed/simple;
	bh=yhVafEpOeiyybflVBl8GoHvZIG0y5kH+I19BIPviMXc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=rEaWmxBxBux6HuNz4SF9Kvf2j3ONWaeSFp8V0vdNEgfSVPiaiLJnE3FegX3JOYlA5YCF2o1pnQ9sG8ecKweHGm94z2KKuvmeQGwZ7IF4kq2bQOWydVqOAKTwWZ4l81m3likXYspQhHv8z+dn3vIZIqH6iEzEc4rtsSV99FKXkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNbjwofJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A77C2BD10;
	Fri, 17 May 2024 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715960527;
	bh=yhVafEpOeiyybflVBl8GoHvZIG0y5kH+I19BIPviMXc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=tNbjwofJiNnKlnVFDsr71EjVgjioaMGbmamWTE0eSuUVX9/VZz405WwHrrO0Q8+ri
	 3urfYHww0vHbDt8pqX9fnSNkagJluRBSPDl02wI4NbKE5jCy066T1zY+yb+8FEXMfs
	 J0anOqVG71CQCC/45kqkfPA6/FaQXFltcvzbD1NrX6VjTJ8+s9F9nPKf4PDhomtcb4
	 qdUC5dv499PXXAaMmqEY13bd5986SXq6RM39RyC+7e0tACYWxKqdz+9IRi+eA1XIMC
	 sR9T+oC8mSmunAUpuw/EL+s7Q/xEXNTzQRV4FtMx9b5WzFE5AEX7Le4eDOv7jh+FDi
	 9HoPwzcmcG9Fw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 18:42:04 +0300
Message-Id: <D1C18M92CMJ1.GNLD51L95OHV@kernel.org>
Subject: Re: tpm_tis_spi takes minutes to probe
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Vitor Soares" <ivitro@gmail.com>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: <jgg@ziepe.ca>, <peterhuewe@gmx.de>, <vitor.soares@toradex.com>
X-Mailer: aerc 0.17.0
References: <bf67346ef623ff3c452c4f968b7d900911e250c3.camel@gmail.com>
In-Reply-To: <bf67346ef623ff3c452c4f968b7d900911e250c3.camel@gmail.com>

On Fri May 17, 2024 at 5:53 PM EEST, Vitor Soares wrote:
> Greetings,
>
> I'm using the tpm_tis_spi.ko module and it is taking several minutes to p=
robe on
> kernel:
>  - commit ea5f6ad9ad96 ("Merge tag 'platform-drivers-x86-v6.10-1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86"=
)
>
> root@verdin-imx8mm-07317726:~# time modprobe tpm_tis_spi=20
> [   57.534597] SPI driver tpm_tis_spi has no spi_device_id for atmel,attp=
m20p

This was added in 6.9:

$ git --no-pager log -1 3c45308c44eda
commit 3c45308c44eda6cc3343a48341a82b96753c8a13
Author: Lukas Wunner <lukas@wunner.de>
Date:   Sat Jan 13 18:10:52 2024 +0100

    tpm_tis_spi: Add compatible string atmel,attpm20p
   =20
    Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device"=
)
    added a devicetree node for the Trusted Platform Module on certain
    Gateworks boards.
   =20
    The commit only used the generic "tcg,tpm_tis-spi" compatible string,
    but public documentation shows that the chip is an ATTPM20P from Atmel
    (nowadays Microchip):
    https://trac.gateworks.com/wiki/tpm
   =20
    Add the chip to the supported compatible strings of the TPM TIS SPI
    driver.
   =20
    For reference, a datasheet is available at:
    https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platf=
orm-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
   =20
    Signed-off-by: Lukas Wunner <lukas@wunner.de>
    Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>
    Cc: Tim Harvey <tharvey@gateworks.com>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

linux-tpmdd on =EE=82=A0 tpm2_key=20
$ git describe --contains 3c45308c44eda
tpmdd-v6.9-rc1~2

> [   57.560684] tpm_tis_spi spi2.1: 2.0 TPM (device-id 0x3205, rev-id 1)
> [   57.584943] tpm tpm0: A TPM error (256) occurred attempting the self t=
est

Course of event is I think:

	rc =3D tpm2_do_selftest(chip);
	if (rc && rc !=3D TPM2_RC_INITIALIZE)
		goto out;

	/* 1. TPM_RC_INITIALIZE */
	if (rc =3D=3D TPM2_RC_INITIALIZE) {
		/* 2. Branches here. */
		rc =3D tpm2_startup(chip);
		if (rc)
			goto out;

		rc =3D tpm2_do_selftest(chip);
		if (rc)
			goto out;
	}

	/* 4. Second self-test successful. */

It is possible that there is a performance regression given multitude
of HMAC changes. It would likely had to be in tpm2_do_selftest(), since
it is the most time-consuming function.

I checked the timeouts etc. but in the first seek did find anything
obvious.

BR, Jarkko

