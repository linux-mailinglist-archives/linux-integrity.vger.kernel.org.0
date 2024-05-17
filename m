Return-Path: <linux-integrity+bounces-2436-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2192A8C89AC
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 17:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC240284D95
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631FC12F5B2;
	Fri, 17 May 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iluTzaVJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21312F5AD;
	Fri, 17 May 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961467; cv=none; b=sD2TyCaJPQs2/X4Li4PaQiqUGUFywIL+65GtDHmkJAVwvLWxypZl5yovp9WAXWnyRGFC6OxwHFzqMcQOfj7xcQpmG7C+oUFX2fFcu51qdsDbubKhrq3R7MS8wHtmulpCAmih8i4DgsgI5534FocVRP/+26/ll4UqfX8PhLsFgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961467; c=relaxed/simple;
	bh=C7OBzn5ovR9MRd7VBL4t/mfvst5rJG04ZZ3eFtxBEtE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BkJtgttCi+sB9M1uOnDzgA/Xtc1P3yTjoyh6ku1s0DXTjlfXtSz6QBQFMjbyiZ6Jl4rR38XHSMt0umbIZgWo2cP+jROrnkT/wRKLYVuAxI7VSqxQR/8HBLCV+Tht7Upr3zkQFXbTtfTtcI5MrhWmtCPQV8EWJa6Mii3YBsMBNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iluTzaVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C3FC32782;
	Fri, 17 May 2024 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715961465;
	bh=C7OBzn5ovR9MRd7VBL4t/mfvst5rJG04ZZ3eFtxBEtE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=iluTzaVJnFfbgjU9RbgxZt9r3ezVdeq/JqZJr78PaN7m3fpW2pKb18rqHTLUtzk8U
	 GsRRJVBZJe0CmzzM/2yNE+jw+lTIfHCIksGpmGbQOvMHrpgyNfdDbybDQhZb2sBdbi
	 jHZIzTszrIdiLnHcqZ6oiWmvEZd6gJOiNn7pNwZeljcwEdMmZc59vYM2oVDV9HVcJh
	 EFuJq1DU5IS5hDjnlNvR1YNunXHHtXDdv0Bv83Eo9Q3FaNmldOgrWbHm5xX1dOpNYm
	 5WgSAs7hi77odDfQa4jwARJMVjoaszPbwdxIxoYnMspRtJl/VNmcof2XvNgj7XT5+N
	 P+/rm+h/ShCRQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 18:57:42 +0300
Message-Id: <D1C1KL7Q27P9.39BH0Z4EMBBUG@kernel.org>
Cc: <jgg@ziepe.ca>, <peterhuewe@gmx.de>, <vitor.soares@toradex.com>
Subject: Re: tpm_tis_spi takes minutes to probe
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Vitor Soares"
 <ivitro@gmail.com>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <bf67346ef623ff3c452c4f968b7d900911e250c3.camel@gmail.com>
 <D1C18M92CMJ1.GNLD51L95OHV@kernel.org>
In-Reply-To: <D1C18M92CMJ1.GNLD51L95OHV@kernel.org>

On Fri May 17, 2024 at 6:42 PM EEST, Jarkko Sakkinen wrote:
> On Fri May 17, 2024 at 5:53 PM EEST, Vitor Soares wrote:
> > Greetings,
> >
> > I'm using the tpm_tis_spi.ko module and it is taking several minutes to=
 probe on
> > kernel:
> >  - commit ea5f6ad9ad96 ("Merge tag 'platform-drivers-x86-v6.10-1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6")
> >
> > root@verdin-imx8mm-07317726:~# time modprobe tpm_tis_spi=20
> > [   57.534597] SPI driver tpm_tis_spi has no spi_device_id for atmel,at=
tpm20p
>
> This was added in 6.9:
>
> $ git --no-pager log -1 3c45308c44eda
> commit 3c45308c44eda6cc3343a48341a82b96753c8a13
> Author: Lukas Wunner <lukas@wunner.de>
> Date:   Sat Jan 13 18:10:52 2024 +0100
>
>     tpm_tis_spi: Add compatible string atmel,attpm20p
>    =20
>     Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM devic=
e")
>     added a devicetree node for the Trusted Platform Module on certain
>     Gateworks boards.
>    =20
>     The commit only used the generic "tcg,tpm_tis-spi" compatible string,
>     but public documentation shows that the chip is an ATTPM20P from Atme=
l
>     (nowadays Microchip):
>     https://trac.gateworks.com/wiki/tpm
>    =20
>     Add the chip to the supported compatible strings of the TPM TIS SPI
>     driver.
>    =20
>     For reference, a datasheet is available at:
>     https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Pla=
tform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
>    =20
>     Signed-off-by: Lukas Wunner <lukas@wunner.de>
>     Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>
>     Cc: Tim Harvey <tharvey@gateworks.com>
>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> linux-tpmdd on =EE=82=A0 tpm2_key=20
> $ git describe --contains 3c45308c44eda
> tpmdd-v6.9-rc1~2
>
> > [   57.560684] tpm_tis_spi spi2.1: 2.0 TPM (device-id 0x3205, rev-id 1)
> > [   57.584943] tpm tpm0: A TPM error (256) occurred attempting the self=
 test
>
> Course of event is I think:
>
> 	rc =3D tpm2_do_selftest(chip);
> 	if (rc && rc !=3D TPM2_RC_INITIALIZE)
> 		goto out;
>
> 	/* 1. TPM_RC_INITIALIZE */
> 	if (rc =3D=3D TPM2_RC_INITIALIZE) {
> 		/* 2. Branches here. */
> 		rc =3D tpm2_startup(chip);
> 		if (rc)
> 			goto out;
>
> 		rc =3D tpm2_do_selftest(chip);
> 		if (rc)
> 			goto out;
> 	}
>
> 	/* 4. Second self-test successful. */
>
> It is possible that there is a performance regression given multitude
> of HMAC changes. It would likely had to be in tpm2_do_selftest(), since
> it is the most time-consuming function.
>
> I checked the timeouts etc. but in the first seek did find anything
> obvious.

Right, the extra time comes from probably null key creation, even though
tpm2_do_selftest() does not itself invoke tpm2_start_auth_session().

If you don't want that to happen, then you should disable
CONFIG_TCG_TPM2_HMAC but also bus encrypted sessions to trusted keys
random number generation and PCR extension.

BR, Jarkko

