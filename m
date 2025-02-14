Return-Path: <linux-integrity+bounces-4832-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE64A358A6
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 09:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A51890B5E
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3910221D8B;
	Fri, 14 Feb 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un5xPtTe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6A84037;
	Fri, 14 Feb 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521105; cv=none; b=D05JD7ropzKuDcfoWwcK8g9Lq9rudfBIhWQe7vWraoz096nH/2TCyEI6BSPNax4nLEH/8LIFTo2bGJ6kG0raim1FqwGb71b+6vgyw70uq215xYxBz0KFE/8RwRMW09kMC9k4lWCIopKWgmTnDjpY9PWGQHP3M2lR3TfCJ7Oq9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521105; c=relaxed/simple;
	bh=ZVf/pYT2VCVOUbytrd/xzKgcYYVFcGofwMyImLokvu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcq/x/81ntcOVjOlNmE/FBW3ws/y8zs/d31G6aKNaG7qL/gLTT/YxXQrbGeQq2/xEuKHg3ShHojFTpX5ShDEkacZEAr5nPQ1wmR037N6cnwZWpZelS7TUmlX68OWkvBmeRY4OVpWY//2McNjNzIShu/WNksQD31BJkvovu83Q8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un5xPtTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DD4C4CED1;
	Fri, 14 Feb 2025 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521104;
	bh=ZVf/pYT2VCVOUbytrd/xzKgcYYVFcGofwMyImLokvu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un5xPtTeTcQT08Wzaiz3QvzOu6B6fYCH0Iu53XN/KpXlw3RymwRkTjnNJGscoOQct
	 xnWOZdzXATzTC2A3Pfwn3+rKmE7n92SOrF+Xgq57XABQgcHLVavwm1ZwqFDW52GZUU
	 oU7b57eIR8D7CnpzJ7jcFHPIeVtN+VYJKfJhNq64bS+BsJoXyxSK9R3Io5ac/b+9+/
	 NZTemZ5inPwMp5F7oPPovHh+56PJTbjKMazxJPRvASeruJLFnzbQH4FoFZe6N0u251
	 SNW0DsIhNQ44FMw3YKmra6WbzbZYVw0Y5aTDa07PiGiGLPaqPK3DkTAGOQqsUzNle5
	 zPP46PaDPS+Yg==
Date: Fri, 14 Feb 2025 10:18:20 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tpm_crb: refactor check for idle support into TPM
 into inline function
Message-ID: <Z678TKuFTJ4vgHqH@kernel.org>
References: <20250214002745.878890-1-stuart.yoder@arm.com>
 <20250214002745.878890-3-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214002745.878890-3-stuart.yoder@arm.com>

On Thu, Feb 13, 2025 at 06:27:42PM -0600, Stuart Yoder wrote:
> Refactor the two checks for whether the TPM supports idle into a single
> inline function.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index ea085b14ab7c..d696226906a2 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
>  	u64 reply_addr;
>  };
>  
> +static inline bool tpm_crb_has_idle(u32 start_method)
> +{
> +	if ((start_method == ACPI_TPM2_START_METHOD) ||

Unnecessary parentheses in each condition.

> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
> +		return false;
> +	else
> +		return true;
> +}

Could be just plain

/*
 * Returns true, if the start method supports idle.
 */
static inline bool tpm_crb_has_idle(u32 start_method)
{
	return start_method == ACPI_TPM2_START_METHOD ||
	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD ||
	       start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC;
}

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

Right, those parentheses come from legacy code. Still, they should be
removed. Also with this afaik checkpatch.pl --strict should give you
a complain.

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
> -- 
> 2.34.1
> 

BR, Jarkko

