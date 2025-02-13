Return-Path: <linux-integrity+bounces-4816-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FBA35104
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 23:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD5C16C668
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D77266B59;
	Thu, 13 Feb 2025 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qanKyfCa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A26A20CCE2;
	Thu, 13 Feb 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484834; cv=none; b=C5yiQqUsGKfy1S/SXrAwF1gTnj6v/Czx+uqHABkPH4hAvus/GpM7WV/9b41qG1OvSHDVX2uIqtar0dmoKGypZT1qzH0v4kH+nINDoH/HmklIKcX1bWxOb4hTfiAb0/1dA42Y1lhvmDe4Of54J4EiN0jQIeTfDIEqsZWCRe62jP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484834; c=relaxed/simple;
	bh=qobvBkQ6h6gcLSELLG4aRiJvMDiRRwamnZVPmowXdHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpJboBrmOnaZ7T0uQnocbYKcZeMFsUyZTb3XAc79hG9+z7RZV/cJnk+tcPlV8PAbjw3m9Q8ZfsYdOf/PsjJ+I17289RTaoxrKCw47kejzEoq1frK0MhdE0uwwbybQVQaKSOIdEi3gUUAnynjvWlPcgj/QhvJlUuQkqztsjw+Zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qanKyfCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277A5C4CED1;
	Thu, 13 Feb 2025 22:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739484831;
	bh=qobvBkQ6h6gcLSELLG4aRiJvMDiRRwamnZVPmowXdHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qanKyfCabr6MMkK/Qly+ex01dMDJjOmuhTSaZZDvHimEOGb9p9zQQ2i7X5morO/4J
	 Mo4rwPYAXMhSqVpwzoYgf+KDzZhCihLFDX40Xtj6U+LZ522b/LZnVyAwJZeEug3nv4
	 K9qJH5yTBVLElJ0Fv3lbJDIMUgR+wH4SJAvkUMBCUiBrxnRlBnVcZvVWOHpSoOJd9U
	 NG/SbFtZHpWmjQ+svJNB3TxmfWIpPKHb3ex2oxyDX8rJPtvsGd8O7o5ANy5gCirxTV
	 V+vJnz3Onl7SlVTVF7frSwd0+BfvHXi0xW5iTJ45csV5FwtQDgBNp/taBPrt2M2yOT
	 fudF95KVIN8cg==
Date: Fri, 14 Feb 2025 00:13:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tpm_crb: refactor check for idle support into TPM
 into inline function
Message-ID: <Z65umt3_lzAgXbJX@kernel.org>
References: <20250212220548.400447-1-stuart.yoder@arm.com>
 <20250212220548.400447-3-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212220548.400447-3-stuart.yoder@arm.com>

On Wed, Feb 12, 2025 at 04:05:45PM -0600, Stuart Yoder wrote:
> Refactor the two checks for whether the TPM supports idle into a single
> inline function.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index ea085b14ab7c..87d69e990249 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -115,6 +115,16 @@ struct tpm2_crb_pluton {
>  	u64 reply_addr;
>  };
>  
> +static inline bool does_tpm_support_idle(u32 start_method)
> +{
> +	if ((start_method == ACPI_TPM2_START_METHOD) ||
> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
> +	    (start_method == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
> +		return false;
> +	else
> +		return true;
> +}
> +

I think we could also prefix tpm_crb stuff with tpm_crb_* for the sake
of easier grepping etc.

So I'd propose this to be called as: tpm_crb_has_idle()

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
> +	if (!does_tpm_support_idle(priv->sm))
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
> +	if (!does_tpm_support_idle(priv->sm))
>  		return 0;
>  
>  	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
> -- 
> 2.34.1
> 

BR, Jarkko

