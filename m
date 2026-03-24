Return-Path: <linux-integrity+bounces-9050-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ApcILdswmmncwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9050-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:51:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BAE306BEA
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3ED330B26C9
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3E3E51F0;
	Tue, 24 Mar 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi0/ySUX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6552853EE;
	Tue, 24 Mar 2026 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348944; cv=none; b=AL4L03QwJjRWWkbDW00TOZuc9KWiCK+4xYg9XSyHJdWTJmAxJ7zESC1CgypPjNbvSbd8MNTwfLD7BXjqJAL9fPT4nPdaWzIkmMSRZXa/DfYYmFLmoYKp7vUUxJ97Hduy/hg7eP5+GG5HZlgl5nAElI7llHoywu2LL/UQYLO6pY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348944; c=relaxed/simple;
	bh=hB7uZDB3c+H9gYgDKoRbEIp8YHhuGF62pZMIIWz1WMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3SAOjlQYPvuC1ACbbdXOuSLE/7Fbwa+jMfQDmVzaXuXPqCM4FeQ1I/vsfspruv3wGSR2bpWNqSTrYlIC/9RXh+ux5JUKzKkidop7QeOjnnzriVMSQVgl07IY6qUq897Tw16UimqMPk8UorYmPIQvR+hQCl+HY/tE/yi9RNxPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi0/ySUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD57C19424;
	Tue, 24 Mar 2026 10:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348943;
	bh=hB7uZDB3c+H9gYgDKoRbEIp8YHhuGF62pZMIIWz1WMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pi0/ySUXDZt4VQv5JLscy1HYkUGqGNeoBGkJuEjRtySTtP812VpSMBQxF1nokS+pu
	 vZ+kZ1Iep5YiRwvO8oT0aFT/bFZl1ne4UYmvRdYmRRZ6v+0FWAJoBqcy9qZMX9jsKu
	 lj66wcO38ydTZpFT8WV/+I6hEwOZ24oMqEBnp1a+e3suFJvi+zlGZyTPHNHK7p++K6
	 7iiyva0CN9I/GzWqArOFLE9naFxLRx1rMl6XkKKO/cCzSxOB61d61im5CiK9HgHSqG
	 QtbHg5CePjIdZOatdzIhBmzp/K9cUjqeNQDuBlJDASP9wI/rTeKs/54GsLVCVzzJ2D
	 CZaC47YzlLCiw==
Date: Tue, 24 Mar 2026 12:42:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 2/4] tpm_crb: Add new wrapper function to invoke start
 method
Message-ID: <acJqi8S81I2hwvsR@kernel.org>
References: <20260324071803.324774-1-armenon@redhat.com>
 <20260324071803.324774-3-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324071803.324774-3-armenon@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	TAGGED_FROM(0.00)[bounces-9050-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5BAE306BEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 12:48:01PM +0530, Arun Menon wrote:
> - Extract start invocation code into a separate function called
>   crb_trigger_tpm. This will be helpful in repeatedly calling the
>   start method with different bits set to toggle between start,
>   nextChunk or crbRspRetry behaviours.
> - Based on the bit set, we signal the TPM to consume
>   contents of the command/response buffer.
> - No functional change intended.

Please write a proper commit message, which is not a task list.

> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 67c0061d4cab7..10128d078245c 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -445,6 +445,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
>  }
>  #endif
>  
> +static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	int rc;
> +	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> +	 * report only ACPI start but in practice seems to require both
> +	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> +	 */
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> +	    !strcmp(priv->hid, "MSFT0101"))
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> +	if (priv->sm == ACPI_TPM2_START_METHOD ||
> +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> +		rc = crb_do_acpi_start(chip);
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> +	}
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> +	}
> +	return rc;
> +}
> +
>  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> @@ -470,29 +496,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	/* Make sure that cmd is populated before issuing start. */
>  	wmb();
>  
> -	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> -	 * report only ACPI start but in practice seems to require both
> -	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> -	 */
> -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> -	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> -	    !strcmp(priv->hid, "MSFT0101"))
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> -
> -	if (priv->sm == ACPI_TPM2_START_METHOD ||
> -	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> -		rc = crb_do_acpi_start(chip);
> -
> -	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> -		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> -	}
> -
> -	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> -		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> -	}
> -
> +	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.53.0
> 

BR, Jarkko

