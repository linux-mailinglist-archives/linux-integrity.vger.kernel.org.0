Return-Path: <linux-integrity+bounces-6912-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6AB34E8B
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 23:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491B61B21C82
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31992BD00C;
	Mon, 25 Aug 2025 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3n/Al7V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818E2628C;
	Mon, 25 Aug 2025 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159085; cv=none; b=BzhUbD0zlxoMOyf24ISlmF/LAiR9SBtG/ZlAsmrLBDD2CkWf3zJfUS+fwWCEnIPwCaRF1ENMAJw16mm/IxgBzP0yyEZBhiOmVzZD8UO9cL/HCEL5k7eO0yoy/6zuS02pmlkOkPdiVPSCmCfGb398mQkxFgc4OmGXJr/L7kyT+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159085; c=relaxed/simple;
	bh=YpIXpdv+4SI1dR7v3nDMKSGZCS+c+XAhJeUhjd05fls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnwKa1FQr90FpyDHdMg2L04jPrOzA9/tBXpw4C+blXqksk9AeK5BY52C+57ZTrv7zYMIukSs6A71Nl3gXeJIZ/VXWeYsU3jzWSI6NKsnnMiyM+Lx+Z0Goh7/NjAw0t87EjDZoGiZvIPt/vo/inOdl5LkgFP3UBM2ChvcUdivUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3n/Al7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD2CC4CEED;
	Mon, 25 Aug 2025 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159085;
	bh=YpIXpdv+4SI1dR7v3nDMKSGZCS+c+XAhJeUhjd05fls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3n/Al7VUoeRfWkyuy2BpXagtQrR+gDTOiCJ0WJpbjvJg/vrMHBkqNIWr0T2SpcJN
	 8Rrn5Y+JOymFMpdQmEHVgXFHd+3GpJttnxUl8Mm/3Q51BH9dtNQKCXRznKg46+eoLE
	 1GB7M0mL1eoqJLJBWJ6JOQ+BeYjbqy6I1/ZVe0E8CcEcII1n1OkRC5VT7Ichr8uAcA
	 /Cl881bfsBQz4blPIZ1PCZCSG5CTBYAsaZ0iJd0hR0bhzB1N9zQD7PryTv3kYyw+bu
	 QdMezqCjqF04Q4yAlKKU4HlpPbcRON8QE5qTHxz+ToWNUjJehvhCpFl8PZO3k3P7OH
	 OErUf8xGDiwSA==
Date: Tue, 26 Aug 2025 00:58:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, Prachotan.Bathi@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Add idle support for the Arm FF-A start method
Message-ID: <aKzcaaXGQyLfDPrf@kernel.org>
References: <20250825205943.1225599-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825205943.1225599-1-stuart.yoder@arm.com>

On Mon, Aug 25, 2025 at 03:59:43PM -0500, Stuart Yoder wrote:
> According to the CRB over FF-A specification [1], a TPM that implements
> the ABI must comply with the TCG PTP specification. This requires support
> for the Idle and Ready states.
> 
> This patch implements CRB control area requests for goIdle and
> cmdReady on FF-A based TPMs.
> 
> The FF-A message used to notify the TPM of CRB updates includes a
> locality parameter, which provides a hint to the TPM about which
> locality modified the CRB.  This patch adds a locality parameter
> to __crb_go_idle() and __crb_cmd_ready() to support this.
> 
> [1] https://developer.arm.com/documentation/den0138/latest/
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>

Perhaps a dummy question but is this "QEMU testable"? I know how
to bind swtpm to QEMU and make it appear as CRB device on x86-64.

I don't see much testing happening with these ARM CRB patches,
and if that works in the first palce  I could probably add
a new board target to my BR2_EXTERNAL [1].

I can of course do "negative testing' i.e. that these don't
break x86 ;-)

> ---
>  drivers/char/tpm/tpm_crb.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 876edf2705abb..a18bae0a53717 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -133,8 +133,7 @@ static inline bool tpm_crb_has_idle(u32 start_method)
>  {
>  	return !(start_method == ACPI_TPM2_START_METHOD ||
>  	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
> -	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC ||
> -	       start_method == ACPI_TPM2_CRB_WITH_ARM_FFA);
> +	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
>  }
>  
>  static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
> @@ -191,7 +190,7 @@ static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete
>   *
>   * Return: 0 always
>   */
> -static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
> +static int __crb_go_idle(struct device *dev, struct crb_priv *priv, int loc)
>  {
>  	int rc;
>  
> @@ -200,6 +199,12 @@ static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
>  
>  	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
>  
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, loc);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc = crb_try_pluton_doorbell(priv, true);
>  	if (rc)
>  		return rc;
> @@ -220,7 +225,7 @@ static int crb_go_idle(struct tpm_chip *chip)
>  	struct device *dev = &chip->dev;
>  	struct crb_priv *priv = dev_get_drvdata(dev);
>  
> -	return __crb_go_idle(dev, priv);
> +	return __crb_go_idle(dev, priv, chip->locality);
>  }
>  
>  /**
> @@ -238,7 +243,7 @@ static int crb_go_idle(struct tpm_chip *chip)
>   *
>   * Return: 0 on success -ETIME on timeout;
>   */
> -static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
> +static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv, int loc)
>  {
>  	int rc;
>  
> @@ -247,6 +252,12 @@ static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
>  
>  	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
>  
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, loc);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc = crb_try_pluton_doorbell(priv, true);
>  	if (rc)
>  		return rc;
> @@ -267,7 +278,7 @@ static int crb_cmd_ready(struct tpm_chip *chip)
>  	struct device *dev = &chip->dev;
>  	struct crb_priv *priv = dev_get_drvdata(dev);
>  
> -	return __crb_cmd_ready(dev, priv);
> +	return __crb_cmd_ready(dev, priv, chip->locality);
>  }
>  
>  static int __crb_request_locality(struct device *dev,
> @@ -444,7 +455,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  
>  	/* Seems to be necessary for every command */
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
> -		__crb_cmd_ready(&chip->dev, priv);
> +		__crb_cmd_ready(&chip->dev, priv, chip->locality);
>  
>  	memcpy_toio(priv->cmd, buf, len);
>  
> @@ -672,7 +683,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  	 * PTT HW bug w/a: wake up the device to access
>  	 * possibly not retained registers.
>  	 */
> -	ret = __crb_cmd_ready(dev, priv);
> +	ret = __crb_cmd_ready(dev, priv, 0);
>  	if (ret)
>  		goto out_relinquish_locality;
>  
> @@ -744,7 +755,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  	if (!ret)
>  		priv->cmd_size = cmd_size;
>  
> -	__crb_go_idle(dev, priv);
> +	__crb_go_idle(dev, priv, 0);
>  
>  out_relinquish_locality:
>  
> -- 
> 2.34.1
> 
> 

[1] https://codeberg.org/jarkko/linux-tpmdd-test

BR, Jarkko

