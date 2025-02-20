Return-Path: <linux-integrity+bounces-4922-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4842A3D4B9
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 10:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA837188F237
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E61EE7C6;
	Thu, 20 Feb 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJypC3wa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4BB2FC23;
	Thu, 20 Feb 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043787; cv=none; b=G5+XVEDdEGHXjv5zWSkSeCb6DGbKECqXODolo/qLfl028G6L286T5ya1/YcUInT0g0aQT7eqa3Az0Vss4OSZJ2B14NnEqNJKEFacuwP+YmQbRQjYHnKjMtZuAZNf1EtCeRmrRLKBjOPteEyE/JkcQ+wHvL5JvIUgwE+M68OCgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043787; c=relaxed/simple;
	bh=iDLQYAkTEH+OngR6rup9XAAF2+pFtb7O6bJup02zASU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfrvbLHzzC3PlRlErR1Bhy3sbZhWouMFC9/cCjja/ifV0NS/DZ9vgs0+PqsC/F0sdhWm2U1h2DPCpES0U3TuAjo7cIQ2dyh0w5OR0//Ckc3naeIP6E4RvULNfMW43vV8W5sjREhfJzS6D0/5Fo7E2sj8MX5ltS7oo+s/HEdztNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJypC3wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F104C4CED1;
	Thu, 20 Feb 2025 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740043786;
	bh=iDLQYAkTEH+OngR6rup9XAAF2+pFtb7O6bJup02zASU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJypC3wafwg97JMv6IytAaK18W13IMEy0UjkMeYLajEjBKExz/bFsKcJSWlw9AWL2
	 wSaeEerypr9IIT0TShlrdC42LbYNhH6NqH71SlRbJjMfXIbjfiuMaZUjVRt4vjXs2u
	 Qz+ECeF4KcTJ7EdLeQjG8gZ8acfzS9EPP5NK9j8KXeIGTADAsXt7e3IAaLGM20eXZ9
	 fhysmjSttW9cwDFDUCuQMSnBCMPNB5fY2Bk6AKZJ2WB8GZFnbvYq9lZ0kHkAqNPWvO
	 ebqF16SmHJ/M468ZUxftsGhXPQLMq2TyDPBVjaha3eYMbCry/beQrSXz2k3nvSovsd
	 xmAlcg95dZzPw==
Date: Thu, 20 Feb 2025 11:29:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] tpm_crb: clean-up and refactor check for idle
 support
Message-ID: <Z7b2BlllE6HVIZNN@kernel.org>
References: <20250219201014.174344-1-stuart.yoder@arm.com>
 <20250219201014.174344-3-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219201014.174344-3-stuart.yoder@arm.com>

On Wed, Feb 19, 2025 at 02:10:11PM -0600, Stuart Yoder wrote:
> Refactor TPM idle check to tpm_crb_has_idle(), and reduce paraentheses
> usage in start method checks
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index ea085b14ab7c..31db879f1324 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
>  	u64 reply_addr;
>  };
>  
> +/*
> + * Returns true if the start method supports idle.
> + */
> +static inline bool tpm_crb_has_idle(u32 start_method)
> +{
> +	return start_method == ACPI_TPM2_START_METHOD ||
> +	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
> +	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC;
> +}
> +
>  static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
>  				unsigned long timeout)
>  {
> @@ -173,9 +183,7 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
>  {
>  	int rc;
>  
> -	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
> +	if (!tpm_crb_has_idle(priv->sm))
>  		return 0;
>  
>  	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
> @@ -222,9 +230,7 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
>  {
>  	int rc;
>  
> -	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
> +	if (!tpm_crb_has_idle(priv->sm))
>  		return 0;
>  
>  	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
> @@ -423,13 +429,13 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	 * report only ACPI start but in practice seems to require both
>  	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
>  	 */
> -	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
> -	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED) ||
> -	    (!strcmp(priv->hid, "MSFT0101")))
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> +	    !strcmp(priv->hid, "MSFT0101"))
>  		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
>  
> -	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD))
> +	if (priv->sm == ACPI_TPM2_START_METHOD ||
> +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
>  		rc = crb_do_acpi_start(chip);
>  
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> @@ -449,8 +455,8 @@ static void crb_cancel(struct tpm_chip *chip)
>  
>  	iowrite32(CRB_CANCEL_INVOKE, &priv->regs_t->ctrl_cancel);
>  
> -	if (((priv->sm == ACPI_TPM2_START_METHOD) ||
> -	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)) &&
> +	if ((priv->sm == ACPI_TPM2_START_METHOD ||
> +	     priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) &&
>  	     crb_do_acpi_start(chip))
>  		dev_err(&chip->dev, "ACPI Start failed\n");
>  }
> @@ -609,8 +615,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  	 * the control area, as one nice sane region except for some older
>  	 * stuff that puts the control area outside the ACPI IO region.
>  	 */
> -	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
> -	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED) {
>  		if (iores &&
>  		    buf->control_address == iores->start +
>  		    sizeof(*priv->regs_h))
> -- 
> 2.34.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

