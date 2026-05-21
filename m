Return-Path: <linux-integrity+bounces-9625-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBDnEgqLD2qnNAYAu9opvQ
	(envelope-from <linux-integrity+bounces-9625-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 00:45:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C23CB5AC730
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 00:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C99303DAA3
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 22:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F265367B8A;
	Thu, 21 May 2026 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKjorfmZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F423644C2;
	Thu, 21 May 2026 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403406; cv=none; b=Wz4pXgEPl9JRD/QYQPJ4rw1Rx/Ac0WFdxlShto/s7/krHfdyU1ZLKGxIy93yDrvOdgXmEm/8dUEs+pNO/mIC/2yqTmcyApLKhWApW/keJUMJx98ztO5gqwRS1T/J5b77DwEGjVU5yjbIesXPR2Otw+9v48NMl1FLwva5nJKnsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403406; c=relaxed/simple;
	bh=B+QDWSA168uws4wKIxFAj3031nZSzVn8O5jOZRFPVSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3HoHrRn6vI94FbUbJ1fuko7NxyzvsWkLAw3KQB6MJyrpgI8S3Uo7G+NdnKx3JWAmfHMOVets5YmdN5nXMAhmXZu3V/FAzG6dt8TBYVTyC3ycB+3QLeF0H7tiWGHPZ22mH2IlIdMFjAYKboh4+g8ulEikhINiFzJButFVjfrUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKjorfmZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 331D81F000E9;
	Thu, 21 May 2026 22:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779403404;
	bh=QsXPgt+ZJarn05n24TBsl5Aqg5RYhmxHCY7O+p8Qfyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iKjorfmZSwWWDPomD8gUInrU3I3tSEF+ig6d7EP/2sAWJXCoXKfs/+EfGGbmsXwpE
	 bBnfTc0CYWB1fszJVzKOJ/xoeSQaOTdZl5yRQUBQe/AyEtbssYbaKviIwbl+7L0vYp
	 iSvBLPp6U4ifxIh1SJvCQtD2M/ZDOIEC8fSnemRT+Y23q34adPnVaucodCq98fbJ4l
	 Cm2WjbeiLFpqJ0meC0AomRJcHI2KklWXwxvHEV8/C4+jdG0IUak6R8X+gj7pGcNkHO
	 OFHABJjFFi/XfYqXhH/0s6i4h8gAII59rGqM2M6ntvUqUTCZ/dMd0ELEHd29qCvLDf
	 gMCh+8abMfciw==
Date: Fri, 22 May 2026 01:43:12 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v3 3/6] tpm_crb: Add start_cmd parameter to tpm_crb_start
 wrapper
Message-ID: <ag-KgDtvbDUdCxWP@kernel.org>
References: <20260518151724.730443-1-armenon@redhat.com>
 <20260518151724.730443-4-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518151724.730443-4-armenon@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9625-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C23CB5AC730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:47:21PM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> The current implementation of tpm_crb_start() is limited to triggering
> the CRB_START_INVOKE bit. To support command and response chunking, the
> driver must be able to send other control bits, like
> CRB_START_NEXT_CHUNK, using the same platform-specific paths.
> 
> This commit adds the start_cmd parameter to tpm_crb_start() so the
> caller can specify which command to send.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 9a2f512b4ae3..31f530744e90 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -446,7 +446,7 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
>  }
>  #endif
>  
> -static int tpm_crb_start(struct tpm_chip *chip)
> +static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
>  	int rc = 0;
> @@ -457,16 +457,16 @@ static int tpm_crb_start(struct tpm_chip *chip)
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
>  	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
>  	    !strcmp(priv->hid, "MSFT0101"))
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
>  	if (priv->sm == ACPI_TPM2_START_METHOD ||
>  	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
>  		rc = crb_do_acpi_start(chip);
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
>  		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
>  	}
>  	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> -		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
>  		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
>  	}
>  	return rc;
> @@ -497,7 +497,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	/* Make sure that cmd is populated before issuing start. */
>  	wmb();
>  
> -	rc = tpm_crb_start(chip);
> +	rc = tpm_crb_start(chip, CRB_START_INVOKE);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.54.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

