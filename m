Return-Path: <linux-integrity+bounces-4951-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7EEA3E6B8
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 22:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AD517D8A5
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35C263F34;
	Thu, 20 Feb 2025 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR4xawd4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AE19DF6A;
	Thu, 20 Feb 2025 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087311; cv=none; b=K0gPi865DbVYgLK8jkCxgV932Fq2LkhA1n7U+PYOK3RhtLUpHgjpLvhjLPFB9XjAKHcx11uS0YhIewwOs5vzLULITRyk5jUhSABWKQPDJirP8UAt3vWP+hkE7hf1J3ff/ofKgUNT5RoG5SS+jTAvQOww501tap9BuWACv53qFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087311; c=relaxed/simple;
	bh=MhjbQXZHVOKqHLGQ5xLuusLGfFvPWfVaBl0Y5meaJyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlh6Sw1RD9MF2HTgq4iYOvBqcO3CeME+98UaPWuJvBrOCj3KAdOpTuHu5KB0w2y275lkyR8UoAPDGzj4nr9Y8WzNTpbg7L3M1+1qUMfcR2JyLpRFKoUFVsRPLusla/eQOKoRbzmOG1kGunL6aoZQirq8wFHXETkALEK1IHM0pr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR4xawd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EFDC4CED1;
	Thu, 20 Feb 2025 21:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740087311;
	bh=MhjbQXZHVOKqHLGQ5xLuusLGfFvPWfVaBl0Y5meaJyk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WR4xawd4Zl9KRCZa4NkJXihZxBC/kSWalxZMgm1gl8oGmVggAZ+QXMubnZRhbh/ft
	 oceZtmds/xHBk2+sQ1/qeg5ozbtzyJSfzf1WTY/AMxoKLrv9N6MNqSRIYNw6YgF1jw
	 vrqjuOnMQK+gAw/PoHQmyoZ8V/EsU/q6OK8mcTfHxpqZg8DwisWJmij4jQPu/n1V/s
	 QPnty1pE+J6aun3y6Xyp6VfpWIL7rsZH8wGxlgUh8yZfC2CdH4/Wmifx76le9sp4I5
	 +UP1OaLOdMAwDP6sYTjJpgtyu4ffW3drvDpVqWC/MxSbc25G7Up0i9xR2wyrFOglnN
	 GEjYlDbx9urIw==
Message-ID: <fdc24d5564b21cf554616afa94b008909ada27f0.camel@kernel.org>
Subject: Re: [PATCH v5 2/5] tpm_crb: clean-up and refactor check for idle
 support
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 23:35:06 +0200
In-Reply-To: <7c913fc0-0f2c-4327-99ee-510bdff8a537@arm.com>
References: <20250219201014.174344-1-stuart.yoder@arm.com>
	 <20250219201014.174344-3-stuart.yoder@arm.com>
	 <Z7b2BlllE6HVIZNN@kernel.org>
	 <7c913fc0-0f2c-4327-99ee-510bdff8a537@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 13:04 -0600, Stuart Yoder wrote:
>=20
>=20
> On 2/20/25 3:29 AM, Jarkko Sakkinen wrote:
> > On Wed, Feb 19, 2025 at 02:10:11PM -0600, Stuart Yoder wrote:
> > > Refactor TPM idle check to tpm_crb_has_idle(), and reduce
> > > paraentheses
> > > usage in start method checks
> > >=20
> > > Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> > > ---
> > > =C2=A0 drivers/char/tpm/tpm_crb.c | 36 +++++++++++++++++++++---------=
-
> > > -----
> > > =C2=A0 1 file changed, 21 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/drivers/char/tpm/tpm_crb.c
> > > b/drivers/char/tpm/tpm_crb.c
> > > index ea085b14ab7c..31db879f1324 100644
> > > --- a/drivers/char/tpm/tpm_crb.c
> > > +++ b/drivers/char/tpm/tpm_crb.c
> > > @@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
> > > =C2=A0=C2=A0	u64 reply_addr;
> > > =C2=A0 };
> > > =C2=A0=20
> > > +/*
> > > + * Returns true if the start method supports idle.
> > > + */
> > > +static inline bool tpm_crb_has_idle(u32 start_method)
> > > +{
> > > +	return start_method =3D=3D ACPI_TPM2_START_METHOD ||
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_method =3D=3D
> > > ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_method =3D=3D
> > > ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC;
> > > +}
> > > +
> > > =C2=A0 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u3=
2
> > > value,
> > > =C2=A0=C2=A0				unsigned long timeout)
> > > =C2=A0 {
> > > @@ -173,9 +183,7 @@ static int __crb_go_idle(struct device *dev,
> > > struct crb_priv *priv)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	int rc;
> > > =C2=A0=20
> > > -	if ((priv->sm =3D=3D ACPI_TPM2_START_METHOD) ||
> > > -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D
> > > ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
> > > -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_A=
RM_SMC))
> > > +	if (!tpm_crb_has_idle(priv->sm))
> > > =C2=A0=C2=A0		return 0;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t-
> > > >ctrl_req);
> > > @@ -222,9 +230,7 @@ static int __crb_cmd_ready(struct device
> > > *dev, struct crb_priv *priv)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	int rc;
> > > =C2=A0=20
> > > -	if ((priv->sm =3D=3D ACPI_TPM2_START_METHOD) ||
> > > -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D
> > > ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
> > > -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_A=
RM_SMC))
> > > +	if (!tpm_crb_has_idle(priv->sm))
> > > =C2=A0=C2=A0		return 0;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t-
> > > >ctrl_req);
> > > @@ -423,13 +429,13 @@ static int crb_send(struct tpm_chip *chip,
> > > u8 *buf, size_t len)
> > > =C2=A0=C2=A0	 * report only ACPI start but in practice seems to
> > > require both
> > > =C2=A0=C2=A0	 * CRB start, hence invoking CRB start method if hid =3D=
=3D
> > > MSFT0101.
> > > =C2=A0=C2=A0	 */
> > > -	if ((priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER) ||
> > > -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED) ||
> > > -	=C2=A0=C2=A0=C2=A0 (!strcmp(priv->hid, "MSFT0101")))
> > > +	if (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER ||
> > > +	=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED ||
> > > +	=C2=A0=C2=A0=C2=A0 !strcmp(priv->hid, "MSFT0101"))
> > > =C2=A0=C2=A0		iowrite32(CRB_START_INVOKE, &priv->regs_t-
> > > >ctrl_start);
> > > =C2=A0=20
> > > -	if ((priv->sm =3D=3D ACPI_TPM2_START_METHOD) ||
> > > -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D
> > > ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD))
> > > +	if (priv->sm =3D=3D ACPI_TPM2_START_METHOD ||
> > > +	=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D
> > > ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> > > =C2=A0=C2=A0		rc =3D crb_do_acpi_start(chip);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	if (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SM=
C) {
> > > @@ -449,8 +455,8 @@ static void crb_cancel(struct tpm_chip *chip)
> > > =C2=A0=20
> > > =C2=A0=C2=A0	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t-
> > > >ctrl_cancel);
> > > =C2=A0=20
> > > -	if (((priv->sm =3D=3D ACPI_TPM2_START_METHOD) ||
> > > -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D
> > > ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)) &&
> > > +	if ((priv->sm =3D=3D ACPI_TPM2_START_METHOD ||
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D
> > > ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) &&
> > > =C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 crb_do_acpi_start(chip))
> > > =C2=A0=C2=A0		dev_err(&chip->dev, "ACPI Start failed\n");
> > > =C2=A0 }
> > > @@ -609,8 +615,8 @@ static int crb_map_io(struct acpi_device
> > > *device, struct crb_priv *priv,
> > > =C2=A0=C2=A0	 * the control area, as one nice sane region except for
> > > some older
> > > =C2=A0=C2=A0	 * stuff that puts the control area outside the ACPI IO
> > > region.
> > > =C2=A0=C2=A0	 */
> > > -	if ((priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER) ||
> > > -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED)) {
> > > +	if (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER ||
> > > +	=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED) {
> > > =C2=A0=C2=A0		if (iores &&
> > > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0 buf->control_address =3D=3D iores->s=
tart +
> > > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0 sizeof(*priv->regs_h))=20
> > > --=20
> > > 2.34.1
> > >=20
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> Thanks for the review.=C2=A0 Do you want me to respin and send out
> a v6 with your Reviewed-by tags on patches 2/5 and 5/5?

It's fine I can append them :-)

You might have to hold up until to the first work week of
March because I'm actually on holiday up until that but
yeah no need for extra noise.

Up until that tested-by's to this patch set version are
obviously welcome but it's now definitely good enough
as far as I'm concerned.

>=20
> Thanks,
> Stuart

BR, Jarkko

