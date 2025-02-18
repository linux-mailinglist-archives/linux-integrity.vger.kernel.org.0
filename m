Return-Path: <linux-integrity+bounces-4864-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC60A3A1CC
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 16:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D84C18955B7
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8F26E14C;
	Tue, 18 Feb 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="cGMqdM0M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925E26B2CE;
	Tue, 18 Feb 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894084; cv=pass; b=Pnjgmy+h2CUi7XK7bxRgMUxe9Z7t5+SyXM18HJ+oOxKSAdcKgCvX7vzAzKBFxH5EKYJocLotHMWQ/666dcHVWuNr1DH8ESv97Z+dnMBVMREFyUTy7aKrZv1Xc08edFprdYyaXfYAzZ3kRx5b9fxuov+EPVxKqKMCoXy/EHj0odw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894084; c=relaxed/simple;
	bh=i8TVq23L/G8C0NS6wWJ+z2Rsn+AEhqXLbnC/4ma/k8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IpC2xbt7ZxYD0ag4xrdFAYw5yPl5t5sVYWagtBXN+qS+Mgymrn0dN0nPy60LzBjUvkncFY6H0RjRCwJGwATGYiAmeNlSx8sdJgHwgS4AnnIVZFsDJYFWFcb16GtywV4r3L5dSQerFzE/91RWVLKQFhz188Fg3Zku+t2E6+rvU4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=cGMqdM0M; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-208.elisa-laajakaista.fi [83.245.197.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Yy3xW5FDtz49Pxd;
	Tue, 18 Feb 2025 17:54:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739894080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dostfF33edzIu5bbFnti7Iey1MHOViHz0E9G6QuKVtY=;
	b=cGMqdM0Mouiyh1OwzvHufMUz7tk5U6uVdkRuz1ouRKzHNJHGzLpMaKOrry6vrU9XkHC1p7
	1h0l22n5dInL2oND34kelcJgdtLf4Jp6r7iOw+Q46JkATYuz01Y6rKCNBI59Uqb8DnoQBs
	z+824dWx2j27Uud32IMWHn9YooBweTlRBigawJ39QY2x6GBKQZmtj4MHXF3/yUZKcoDSaO
	1f7V01KfYr4POHyOCVtHxeVYlEy4XKKXOwYlvk4PM49JMg5wVNozgXdNLMMfGStLZzof0j
	fSW+rlL7Oex9utbR8+iD5+MPW6DfQep7jbKhIAdL17RiFPci7qC1KnmcWAMXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739894080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dostfF33edzIu5bbFnti7Iey1MHOViHz0E9G6QuKVtY=;
	b=wL6qH6D33pak4CnJTUz+AYTEfYraSCsQEtVacWCZ+KqrRdXgZ/Fq2M2yyXVBX0p7gtJVgb
	F45RdQby7GlHOh2aytmXAXdFjnyj9ltTpcSHEuYoODSXCIs4yqHkw2onv8Fi197iASo/Qd
	TblAaeYiQftvXL8ByJ+8cISOl3XGJxxvvUTMyinti30sVESrlD4DMtoHX9w5LCRXXXw4vC
	NR44S/v82u3wrGnkKFF/HaHEZ0prNJ5C8IDf8qLOYr1B4gT8boF+UeT0CHPmpWQknD/DyW
	mea+QnHQlli75kd6AlqC1xgWrk3LsJ+3PRZXe0lJMQT3gJ41xdJmalPwVZh6eQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739894080; a=rsa-sha256;
	cv=none;
	b=f7wG4CXxAZEsWc5vgHPQMiK1VHOTU8gYdVnmcsVQFXb0K+TRF7DZANMrKE/F5WjNpxv8w4
	tehjEZwU9IHPHgpDdhtEXs+9sFx4gh+pYRcf0194Y3LowH1MEBOq3YLiChOazRvXVTPS3W
	4sKEbEPPY27I6yDg3BZiPF/29SeBztnHtb0tqVazwuMAo8+XbPgRlmXnqbhjMp/5gGpUYb
	GhqJ79thVsZFrqNM7Nc7XF6LfLoubv3WM7R6UXWRdYe7HKWGE5KobzfnVbq2Fpu6pP9nxq
	1HFh59riqu6y/91B2DOXlszAGSZUDsjF7hd3vOk2iu6nFTjOa1ONXrNnl/CJzw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Message-ID: <e854c672d0414b7deb348da86902a9de66f917b9.camel@iki.fi>
Subject: Re: [PATCH v4 4/5] tpm_crb: add support for the Arm FF-A start
 method
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Stuart Yoder <stuart.yoder@arm.com>, linux-integrity@vger.kernel.org, 
	jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com, 
	rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 17:54:38 +0200
In-Reply-To: <20250217224946.113951-5-stuart.yoder@arm.com>
References: <20250217224946.113951-1-stuart.yoder@arm.com>
	 <20250217224946.113951-5-stuart.yoder@arm.com>
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
> The TCG ACPI spec v1.4 defines a start method for the
> TPMs implemented with the Arm CRB over FF-A ABI.
>=20
> Add support for the FF-A start method, and use interfaces
> provided by the ffa_crb driver to interact with the
> FF-A based TPM.
>=20
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
> =C2=A0drivers/char/tpm/tpm_crb.c | 71 +++++++++++++++++++++++++++++++++++=
-
> --
> =C2=A01 file changed, 66 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 31db879f1324..2a57650ba9b4 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -19,6 +19,7 @@
> =C2=A0#ifdef CONFIG_ARM64
> =C2=A0#include <linux/arm-smccc.h>
> =C2=A0#endif
> +#include "tpm_crb_ffa.h"
> =C2=A0#include "tpm.h"
> =C2=A0
> =C2=A0#define ACPI_SIG_TPM2 "TPM2"
> @@ -100,6 +101,8 @@ struct crb_priv {
> =C2=A0	u32 smc_func_id;
> =C2=A0	u32 __iomem *pluton_start_addr;
> =C2=A0	u32 __iomem *pluton_reply_addr;
> +	u8 ffa_flags;
> +	u8 ffa_attributes;
> =C2=A0};
> =C2=A0
> =C2=A0struct tpm2_crb_smc {
> @@ -110,6 +113,14 @@ struct tpm2_crb_smc {
> =C2=A0	u32 smc_func_id;
> =C2=A0};
> =C2=A0
> +/* CRB over FFA start method parameters in TCG2 ACPI table */
> +struct tpm2_crb_ffa {
> +	u8 flags;
> +	u8 attributes;
> +	u16 partition_id;
> +	u8 reserved[8];
> +};
> +
> =C2=A0struct tpm2_crb_pluton {
> =C2=A0	u64 start_addr;
> =C2=A0	u64 reply_addr;
> @@ -122,7 +133,8 @@ static inline bool tpm_crb_has_idle(u32
> start_method)
> =C2=A0{
> =C2=A0	return start_method =3D=3D ACPI_TPM2_START_METHOD ||
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_method =3D=3D
> ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_method =3D=3D
> ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC;
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_method =3D=3D ACPI_TPM2_COMM=
AND_BUFFER_WITH_ARM_SMC
> ||
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_method =3D=3D ACPI_TPM2_CRB_=
WITH_ARM_FFA;
> =C2=A0}
> =C2=A0
> =C2=A0static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32
> value,
> @@ -261,13 +273,20 @@ static int crb_cmd_ready(struct tpm_chip *chip)
> =C2=A0static int __crb_request_locality(struct device *dev,
> =C2=A0				=C2=A0 struct crb_priv *priv, int loc)
> =C2=A0{
> -	u32 value =3D CRB_LOC_STATE_LOC_ASSIGNED |
> -		=C2=A0=C2=A0=C2=A0 CRB_LOC_STATE_TPM_REG_VALID_STS;
> +	u32 value =3D CRB_LOC_STATE_LOC_ASSIGNED |
> CRB_LOC_STATE_TPM_REG_VALID_STS;
> +	int rc;
> =C2=A0
> =C2=A0	if (!priv->regs_h)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	iowrite32(CRB_LOC_CTRL_REQUEST_ACCESS, &priv->regs_h-
> >loc_ctrl);
> +
> +	if (priv->sm =3D=3D ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		rc =3D
> tpm_crb_ffa_start(CRB_FFA_START_TYPE_LOCALITY_REQUEST, loc);
> +		if (rc)
> +			return rc;
> +	}
> +
> =C2=A0	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value,
> value,
> =C2=A0				 TPM2_TIMEOUT_C)) {
> =C2=A0		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed
> out\n");
> @@ -287,14 +306,21 @@ static int crb_request_locality(struct tpm_chip
> *chip, int loc)
> =C2=A0static int __crb_relinquish_locality(struct device *dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 struct crb_priv *priv, int loc)
> =C2=A0{
> -	u32 mask =3D CRB_LOC_STATE_LOC_ASSIGNED |
> -		=C2=A0=C2=A0 CRB_LOC_STATE_TPM_REG_VALID_STS;
> +	u32 mask =3D CRB_LOC_STATE_LOC_ASSIGNED |
> CRB_LOC_STATE_TPM_REG_VALID_STS;
> =C2=A0	u32 value =3D CRB_LOC_STATE_TPM_REG_VALID_STS;
> +	int rc;
> =C2=A0
> =C2=A0	if (!priv->regs_h)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
> +
> +	if (priv->sm =3D=3D ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		rc =3D
> tpm_crb_ffa_start(CRB_FFA_START_TYPE_LOCALITY_REQUEST, loc);
> +		if (rc)
> +			return rc;
> +	}
> +
> =C2=A0	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask,
> value,
> =C2=A0				 TPM2_TIMEOUT_C)) {
> =C2=A0		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed
> out\n");
> @@ -443,6 +469,11 @@ static int crb_send(struct tpm_chip *chip, u8
> *buf, size_t len)
> =C2=A0		rc =3D tpm_crb_smc_start(&chip->dev, priv-
> >smc_func_id);
> =C2=A0	}
> =C2=A0
> +	if (priv->sm =3D=3D ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		iowrite32(CRB_START_INVOKE, &priv->regs_t-
> >ctrl_start);
> +		rc =3D tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND,
> chip->locality);
> +	}
> +
> =C2=A0	if (rc)
> =C2=A0		return rc;
> =C2=A0
> @@ -452,6 +483,7 @@ static int crb_send(struct tpm_chip *chip, u8
> *buf, size_t len)
> =C2=A0static void crb_cancel(struct tpm_chip *chip)
> =C2=A0{
> =C2=A0	struct crb_priv *priv =3D dev_get_drvdata(&chip->dev);
> +	int rc;
> =C2=A0
> =C2=A0	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t->ctrl_cancel);
> =C2=A0
> @@ -459,6 +491,12 @@ static void crb_cancel(struct tpm_chip *chip)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_=
WITH_START_METHOD)
> &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 crb_do_acpi_start(chip))
> =C2=A0		dev_err(&chip->dev, "ACPI Start failed\n");
> +
> +	if (priv->sm =3D=3D ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		rc =3D tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND,
> chip->locality);
> +		if (rc)
> +			dev_err(&chip->dev, "FF-A Start failed\n");
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
> @@ -616,6 +654,7 @@ static int crb_map_io(struct acpi_device *device,
> struct crb_priv *priv,
> =C2=A0	 * stuff that puts the control area outside the ACPI IO
> region.
> =C2=A0	 */
> =C2=A0	if (priv->sm =3D=3D ACPI_TPM2_COMMAND_BUFFER ||
> +	=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_CRB_WITH_ARM_FFA ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 priv->sm =3D=3D ACPI_TPM2_MEMORY_MAPPED) {
> =C2=A0		if (iores &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 buf->control_address =3D=3D iores->start +
> @@ -737,6 +776,7 @@ static int crb_acpi_add(struct acpi_device
> *device)
> =C2=A0	struct tpm_chip *chip;
> =C2=A0	struct device *dev =3D &device->dev;
> =C2=A0	struct tpm2_crb_smc *crb_smc;
> +	struct tpm2_crb_ffa *crb_ffa;
> =C2=A0	struct tpm2_crb_pluton *crb_pluton;
> =C2=A0	acpi_status status;
> =C2=A0	u32 sm;
> @@ -775,6 +815,27 @@ static int crb_acpi_add(struct acpi_device
> *device)
> =C2=A0		priv->smc_func_id =3D crb_smc->smc_func_id;
> =C2=A0	}
> =C2=A0
> +	if (sm =3D=3D ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		if (buf->header.length < (sizeof(*buf) +
> sizeof(*crb_ffa))) {
> +			dev_err(dev,
> +				FW_BUG "TPM2 ACPI table has wrong
> size %u for start method type %d\n",
> +				buf->header.length,
> +				ACPI_TPM2_CRB_WITH_ARM_FFA);
> +			rc =3D -EINVAL;
> +			goto out;
> +		}
> +		crb_ffa =3D ACPI_ADD_PTR(struct tpm2_crb_ffa, buf,
> sizeof(*buf));
> +		priv->ffa_flags =3D crb_ffa->flags;
> +		priv->ffa_attributes =3D crb_ffa->attributes;
> +		rc =3D tpm_crb_ffa_init();
> +		if (rc) {
> +			if (rc =3D=3D -ENOENT) {=C2=A0 // FF-A driver is not
> available yet
> +				rc =3D -EPROBE_DEFER;
> +			}
> +			goto out;
> +		}
> +	}
> +
> =C2=A0	if (sm =3D=3D ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
> =C2=A0		if (buf->header.length < (sizeof(*buf) +
> sizeof(*crb_pluton))) {
> =C2=A0			dev_err(dev,

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

