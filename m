Return-Path: <linux-integrity+bounces-4833-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEFFA358B9
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 09:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513B13AB68D
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C34222564;
	Fri, 14 Feb 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3eNSxcy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F42222BE;
	Fri, 14 Feb 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521218; cv=none; b=ZNiw1zs89QWOQpR30C2jfO2SgHptYEwquLzwTWOsFNxwc++GqseJMdm0a8ifqyLBD76Rz6+UucfeSLKjJAbzlZSywVTEpBt4UCgy1vuijZPSVHgJ6Ju8q8r6inB4eXkRkkqUukBCPyEL+SxDsQXRslfb9wTCPs8lNlup+ZAOVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521218; c=relaxed/simple;
	bh=0MpK6YHG5YjSn9vxi2RL9jzrVwiXgNLaq2gHHt4v/rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+KNQTFnxs9w0IrT2j5Eq2fI5Yq7MQ+uPD7r5Pj/PwUauQMQds8rXCpUz0nzgGWQiwa630kNxHJfH9Aqy/Fxx9mqZMiSBmpfjAnLGrlVy+CbUKrMIDk1UGsnHv2uDy9RJKyITTGFUN9TmfDXBSUZ4rhANbTsbaaDng/54TpH3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3eNSxcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9F4C4CED1;
	Fri, 14 Feb 2025 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521215;
	bh=0MpK6YHG5YjSn9vxi2RL9jzrVwiXgNLaq2gHHt4v/rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3eNSxcyFQJ4AUAs4VK2PfAS+UYy0KoFogiZswgcDBV6uus5GPPNRZc7nOBBk+g7w
	 R0+ELVwWB+dqqvn+nf/bVjv7YNri/aMmbap1HquUWl7nXxmKPzNF3AgzplWDaHbA9/
	 ILBcKfIzEo8ad1c+Cc/cc4mrH4dC9zqdVuu4jqrfW9OQteZ/fbg5i5mca31ef6ekcY
	 2VFtdPHPCctjTHhTg4BJghyhOY3jv5lv9l9FppyoANiKMKgwC+9TtFp7FxlDxCAy8D
	 sNymrIAN1SmwSDQgIvQ7iAWMkM1CKRnjqneuZWGGM+2tjuvpnuYopoLNiokNgVwo67
	 ykJEfIJxUc26g==
Date: Fri, 14 Feb 2025 10:20:11 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] tpm_crb: add support for the Arm FF-A start method
Message-ID: <Z678u1yp2Wx_cIUR@kernel.org>
References: <20250214002745.878890-1-stuart.yoder@arm.com>
 <20250214002745.878890-5-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214002745.878890-5-stuart.yoder@arm.com>

On Thu, Feb 13, 2025 at 06:27:44PM -0600, Stuart Yoder wrote:
> The TCG ACPI spec v1.4 defines a start method for the
> TPMs implemented with the Arm CRB over FF-A ABI.
> 
> Add support for the FF-A start method, and use interfaces
> provided by the ffa_crb driver to interact with the
> FF-A based TPM.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 65 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index d696226906a2..486be5ea82bb 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -19,6 +19,7 @@
>  #ifdef CONFIG_ARM64
>  #include <linux/arm-smccc.h>
>  #endif
> +#include "tpm_crb_ffa.h"
>  #include "tpm.h"
>  
>  #define ACPI_SIG_TPM2 "TPM2"
> @@ -100,6 +101,8 @@ struct crb_priv {
>  	u32 smc_func_id;
>  	u32 __iomem *pluton_start_addr;
>  	u32 __iomem *pluton_reply_addr;
> +	u8 ffa_flags;
> +	u8 ffa_attributes;
>  };
>  
>  struct tpm2_crb_smc {
> @@ -110,6 +113,14 @@ struct tpm2_crb_smc {
>  	u32 smc_func_id;
>  };
>  
> +/* CRB over FFA start method parameters in TCG2 ACPI table */
> +struct tpm2_crb_ffa {
> +	u8 flags;
> +	u8 attributes;
> +	u16 partition_id;
> +	u8 reserved[8];
> +};
> +
>  struct tpm2_crb_pluton {
>  	u64 start_addr;
>  	u64 reply_addr;
> @@ -119,7 +130,8 @@ static inline bool tpm_crb_has_idle(u32 start_method)
>  {
>  	if ((start_method == ACPI_TPM2_START_METHOD) ||
>  	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
> -	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) ||
> +	    (start_method == ACPI_TPM2_CRB_WITH_ARM_FFA))

Now that we have a chance, let's rip of the parentheses clutter.

>  		return false;
>  	else
>  		return true;
> @@ -261,6 +273,7 @@ static int crb_cmd_ready(struct tpm_chip *chip)
>  static int __crb_request_locality(struct device *dev,
>  				  struct crb_priv *priv, int loc)
>  {
> +	int rc;
>  	u32 value = CRB_LOC_STATE_LOC_ASSIGNED |
>  		    CRB_LOC_STATE_TPM_REG_VALID_STS;

Declaration order + put to the same line.

>  
> @@ -268,6 +281,13 @@ static int __crb_request_locality(struct device *dev,
>  		return 0;
>  
>  	iowrite32(CRB_LOC_CTRL_REQUEST_ACCESS, &priv->regs_h->loc_ctrl);
> +
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_LOCALITY_REQUEST, loc);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, value, value,
>  				 TPM2_TIMEOUT_C)) {
>  		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
> @@ -287,6 +307,7 @@ static int crb_request_locality(struct tpm_chip *chip, int loc)
>  static int __crb_relinquish_locality(struct device *dev,
>  				     struct crb_priv *priv, int loc)
>  {
> +	int rc;
>  	u32 mask = CRB_LOC_STATE_LOC_ASSIGNED |
>  		   CRB_LOC_STATE_TPM_REG_VALID_STS;
>  	u32 value = CRB_LOC_STATE_TPM_REG_VALID_STS;
> @@ -295,6 +316,13 @@ static int __crb_relinquish_locality(struct device *dev,
>  		return 0;
>  
>  	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
> +
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_LOCALITY_REQUEST, loc);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
>  				 TPM2_TIMEOUT_C)) {
>  		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed out\n");
> @@ -443,6 +471,11 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
>  	}
>  
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> +	}
> +
>  	if (rc)
>  		return rc;
>  
> @@ -451,6 +484,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  
>  static void crb_cancel(struct tpm_chip *chip)
>  {
> +	int rc;
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
>  
>  	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t->ctrl_cancel);
> @@ -459,6 +493,12 @@ static void crb_cancel(struct tpm_chip *chip)
>  	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)) &&
>  	     crb_do_acpi_start(chip))
>  		dev_err(&chip->dev, "ACPI Start failed\n");
> +
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> +		if (rc)
> +			dev_err(&chip->dev, "FF-A Start failed\n");
> +	}
>  }
>  
>  static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
> @@ -616,6 +656,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  	 * stuff that puts the control area outside the ACPI IO region.
>  	 */
>  	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
> +	    (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) ||
>  	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {

Ditto.

>  		if (iores &&
>  		    buf->control_address == iores->start +
> @@ -737,6 +778,7 @@ static int crb_acpi_add(struct acpi_device *device)
>  	struct tpm_chip *chip;
>  	struct device *dev = &device->dev;
>  	struct tpm2_crb_smc *crb_smc;
> +	struct tpm2_crb_ffa *crb_ffa;
>  	struct tpm2_crb_pluton *crb_pluton;
>  	acpi_status status;
>  	u32 sm;
> @@ -775,6 +817,27 @@ static int crb_acpi_add(struct acpi_device *device)
>  		priv->smc_func_id = crb_smc->smc_func_id;
>  	}
>  
> +	if (sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_ffa))) {
> +			dev_err(dev,
> +				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
> +				buf->header.length,
> +				ACPI_TPM2_CRB_WITH_ARM_FFA);
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +		crb_ffa = ACPI_ADD_PTR(struct tpm2_crb_ffa, buf, sizeof(*buf));
> +		priv->ffa_flags = crb_ffa->flags;
> +		priv->ffa_attributes = crb_ffa->attributes;
> +		rc = tpm_crb_ffa_init();
> +		if (rc) {
> +			if (rc == -ENOENT) {  // FF-A driver is not available yet
> +				rc = -EPROBE_DEFER;
> +			}
> +			goto out;
> +		}
> +	}
> +
>  	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
>  		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_pluton))) {
>  			dev_err(dev,
> -- 
> 2.34.1
> 

BR, Jarkko

