Return-Path: <linux-integrity+bounces-4862-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36DA3A1BF
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 16:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF1C172DB4
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FEF26B2CA;
	Tue, 18 Feb 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IphbnR5Z";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="WbOgOc53"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3526A098;
	Tue, 18 Feb 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893973; cv=pass; b=pq/mpz1Im1U+gmR9s9OF7iIBUmYG3Wby2pBAHM4rWOU0gNKPc1Be5H3sq0ayR1VjZ0JvdtaDGgNg4mH9y1gebJTP6dgRc7Hak1GD8ZRqMmg00ShfswzEaNQRRqesNsVJhf5raENvhF8uY6fI/5ne/rAODrtSV8grGbTVzhtRzpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893973; c=relaxed/simple;
	bh=nxoT9BDJB8RX9SDnME/W1wWP43k3WOhsGo7UAUCiQ4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5IOFISlnMo3zfLiNAgaMt0vXCGAmPMDet3JNeEh0jNLUYyVA+4vx/CDW6VRLCFYgf8xMhGvB6rBCEZ9kWpsLBPE2RDIEctt8fo374eMeCZCLkhsGUIdVULyr7OXHsYvoPKLiTkgFYrLzCNvy8fkk6+asvSq9Gkcs5wtWsT4cNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=IphbnR5Z; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=WbOgOc53; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4Yy3vM38H6z49Pxd;
	Tue, 18 Feb 2025 17:52:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739893967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGj6CcH3TT0YGC7zReNey6aCQDLaJ6CgaQzfzirglus=;
	b=IphbnR5ZX088IQ3qUa/pSFx9/c3UIkoCLRSlSIbxtr5dE/ODZ7n4z5Ka6oFEaD7WCAVPy/
	EbnERqc7Vs30ITwvopTF4E+F9sHnZxQ6QVC4rMFckhax9rPvrIYx9Uv2DxDvCUlzPuz/R5
	0nyC1CjjPJmtKT9rwTOpv7ja32vi5/xYYWXnv7KPjJ1c9got2MVp/nadNvJVQCr9sVzi8p
	CqRgfbCdwI+f9c/Ut66G7+UGWI0KkucyBhbqQz5JxLjwEyH4l2w12Ti5zH1BT/1TTraBWf
	aGJCs8Yc9jP0maBtLpyL6GnsueiKsoligkCzLOQL63WIcN/uwInayaObcPN+kQ==
Received: from localhost (83-245-197-208.elisa-laajakaista.fi [83.245.197.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Yy3vB30NyzyQQ;
	Tue, 18 Feb 2025 17:52:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739893958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGj6CcH3TT0YGC7zReNey6aCQDLaJ6CgaQzfzirglus=;
	b=WbOgOc53xvnef21XIx2h+OHE7S5TeSuISyuGXXiXjbP4caVUS3hh9zo6ZuGfYOuLfV3/4/
	maTnKgFRBoxwdhOIp4fCJk8zzjzZ/54+nwhsJyD6wmRqgFQlqqphyjucfKpFf7wGCEzOSe
	8gAFJrQzApH8LLjiImCCsKrec+T/jR4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739893958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGj6CcH3TT0YGC7zReNey6aCQDLaJ6CgaQzfzirglus=;
	b=jxbEKOftQu5fp8+n3gkXPtK0S+T9vKNQflDI8LSJfdm7Ii3KGj/jH4Z5VVgjwSgxLdJlDN
	lsH7/cIRbmO65KWBooqMICVJCB4tbFOiHCQ5jmZmLohafD7VIcLuPhJ0XGc7LVh11c3rfZ
	HkPAfYibdfSYhurK5Pcpq1kdVu+eEac=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739893958; a=rsa-sha256; cv=none;
	b=AJtzRvCV73AEOwiInxhVjfao79PQVwssRRNyERIWjwoYiGwQCFuQkKsYqvKBQBPN9uSewP
	baV7l4T5rSMG+996QpXL+Lsq+XAdKRGXAXGHEx3Kiu2BGkZm1NXspYCCV1PgT1vma1d5Fh
	0AyWrdbYbYf6oLF9NpDfVmVI3Gvq4yU=
Message-ID: <5c17c24e8bfb73967c1f20b6a94064b05856875a.camel@iki.fi>
Subject: Re: [PATCH v4 2/5] tpm_crb: clean-up and refactor check for idle
 support
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org, 
	jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com, 
	rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 17:52:35 +0200
In-Reply-To: <20250217224946.113951-3-stuart.yoder@arm.com>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
	 <20250217224946.113951-3-stuart.yoder@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 16:49 -0600, Stuart Yoder wrote:
> -Clean up unnecessary parenthesis usage
> -Refactor the two checks for whether the TPM supports idle into a
> single
> =C2=A0inline function.

IMHO, this would be better:

"Refactor TPM idle check to tpm_crb_has_idle(), and reduce paraentheses
usage in start method checks."

>=20
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
> =C2=A0drivers/char/tpm/tpm_crb.c | 36 +++++++++++++++++++++--------------=
-
> =C2=A01 file changed, 21 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index ea085b14ab7c..31db879f1324 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
> =C2=A0	u64 reply_addr;
> =C2=A0};
> =C2=A0
> +/*
> + * Returns true if the start method supports idle.
> + */
> +static inline bool tpm_crb_has_idle(u32 start_method)
> +{
> +	return start_method =3D=3D ACPI_TPM2_START_METHOD ||
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_method =3D=3D
> ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_method =3D=3D
> ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC;
> +}
> +
> =C2=A0static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32
> value,
> =C2=A0				unsigned long timeout)
> =C2=A0{
> @@ -173,9 +183,7 @@ static int __crb_go_idle(struct device *dev,
> struct crb_priv *priv)
> =C2=A0{
> =C2=A0	int rc;
> =C2=A0
> -	if ((priv->sm =3D=3D ACPI_TPM2_START_METHOD) ||
> -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_START=
_METHOD)
> ||
> -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_S=
MC))
> +	if (!tpm_crb_has_idle(priv->sm))
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
> @@ -222,9 +230,7 @@ static int __crb_cmd_ready(struct device *dev,
> struct crb_priv *priv)
> =C2=A0{
> =C2=A0	int rc;
> =C2=A0
> -	if ((priv->sm =3D=3D ACPI_TPM2_START_METHOD) ||
> -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_START=
_METHOD)
> ||
> -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_S=
MC))
> +	if (!tpm_crb_has_idle(priv->sm))
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
> @@ -423,13 +429,13 @@ static int crb_send(struct tpm_chip *chip, u8
> *buf, size_t len)
> =C2=A0	 * report only ACPI start but in practice seems to require
> both
> =C2=A0	 * CRB start, hence invoking CRB start method if hid =3D=3D
> MSFT0101.
> =C2=A0	 */
> -	if ((priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER) ||
> -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED) ||
> -	=C2=A0=C2=A0=C2=A0 (!strcmp(priv->hid, "MSFT0101")))
> +	if (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER ||
> +	=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED ||
> +	=C2=A0=C2=A0=C2=A0 !strcmp(priv->hid, "MSFT0101"))
> =C2=A0		iowrite32(CRB_START_INVOKE, &priv->regs_t-
> >ctrl_start);
> =C2=A0
> -	if ((priv->sm =3D=3D ACPI_TPM2_START_METHOD) ||
> -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D
> ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD))
> +	if (priv->sm =3D=3D ACPI_TPM2_START_METHOD ||
> +	=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_START_=
METHOD)
> =C2=A0		rc =3D crb_do_acpi_start(chip);
> =C2=A0
> =C2=A0	if (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> @@ -449,8 +455,8 @@ static void crb_cancel(struct tpm_chip *chip)
> =C2=A0
> =C2=A0	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t->ctrl_cancel);
> =C2=A0
> -	if (((priv->sm =3D=3D ACPI_TPM2_START_METHOD) ||
> -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D
> ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)) &&
> +	if ((priv->sm =3D=3D ACPI_TPM2_START_METHOD ||
> +	=C2=A0=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_=
START_METHOD)
> &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 crb_do_acpi_start(chip))
> =C2=A0		dev_err(&chip->dev, "ACPI Start failed\n");
> =C2=A0}
> @@ -609,8 +615,8 @@ static int crb_map_io(struct acpi_device *device,
> struct crb_priv *priv,
> =C2=A0	 * the control area, as one nice sane region except for some
> older
> =C2=A0	 * stuff that puts the control area outside the ACPI IO
> region.
> =C2=A0	 */
> -	if ((priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER) ||
> -	=C2=A0=C2=A0=C2=A0 (priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED)) {
> +	if (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER ||
> +	=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED) {
> =C2=A0		if (iores &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 buf->control_address =3D=3D iores->start +
> =C2=A0		=C2=A0=C2=A0=C2=A0 sizeof(*priv->regs_h))


BR, Jarkko

