Return-Path: <linux-integrity+bounces-9626-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIZ6GESUD2o1NgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9626-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 01:24:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D10755ACA8C
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 01:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6354B30D1A0E
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 23:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B103911C3;
	Thu, 21 May 2026 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+x03od/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EF382F26;
	Thu, 21 May 2026 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405464; cv=none; b=fGUkz0UsSKc7+hdqYoS46GHKfoC5lPZKK5x8dA6jDez8L/AQEUlAUnN/gK1OFbHqf9macbuz+4ehtGUhr3g1Wm0oX4vCPB46xBMS2jgJ3oYgRm2HssB89ROTDDKUIF2Flhv0e4VS4iFE8kbeA8LKRdySLQZJKeIlx212vSLNCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405464; c=relaxed/simple;
	bh=X8B+AIJOFTlyCPnhSpIhzs9v0o8K4b9MKRWy9DoWIhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRsTzrZd2HUtbv2Pm1MUOO8MLj9D0K7Rg6n5gW2TnIcvNFiJLdH2M2znkPrCShn8ICCe5G3XV/o1FD6FCR+8D4pzFRYy7PKeJZp8yM/RKX+CQ5MhDRqfU0Q+43MyC3TsIseg9avGyHla5gbPviMfeHEU54aUXuAQPaoV10N60lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+x03od/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9D3721F00A3B;
	Thu, 21 May 2026 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779405460;
	bh=NY7sgpyWwX6rlPhDxGscLPxrqmLhhQD+LGw026ZvCVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+x03od/KEYQY40i9/IAV080PGKpCh0DptJVytfKAPNCyYF41kUphnGJvagMd0y9x
	 CFMCGwMN+8amdOOIHhU7N1CF6liiTOAObsPxuO7kmPQJ/DmKqEPyNZgFQYNSv8IRQB
	 s7w2dtLJ/SVSC45vijRheIZRLZNkXKihw9yx6ryd98Qwc7z+TkBSND/5K6d1/LIwYx
	 I2HNk85HWZTL0dEwsl7WGCwTvYBeGy9MYt/yYHOQ9zynOY4PtbzI43EOKqKMPqosEs
	 45Vvct6bajlscfIV27Mgn/MLR91yJ9oYiyfEy8mQIsg6ctseL9sYikgrNzk3QDm89N
	 lgJtVZMUB2Puw==
Date: Fri, 22 May 2026 02:17:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v3 2/6] tpm_crb: Split start method into a separate header
Message-ID: <ag-Sj3sUfkBXP4Eu@kernel.org>
References: <20260518151724.730443-1-armenon@redhat.com>
 <20260518151724.730443-3-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518151724.730443-3-armenon@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9626-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: D10755ACA8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:47:20PM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> The current implementation handles different platform start methods
> (ACPI, ARM SMC, and ARM FFA) directly within crb_send().
> Move this logic into a new helper function, tpm_crb_start(). This is a
> pure refactor with no functional changes intended.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index d76f9e30f036..9a2f512b4ae3 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -446,6 +446,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
>  }
>  #endif
>  
> +static int tpm_crb_start(struct tpm_chip *chip)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	int rc = 0;
> +	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
> +	 * report only ACPI start but in practice seems to require both
> +	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
> +	 */
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
> +	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
> +	    !strcmp(priv->hid, "MSFT0101"))
> +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +	if (priv->sm == ACPI_TPM2_START_METHOD ||
> +	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
> +		rc = crb_do_acpi_start(chip);
> +	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
> +	}
> +	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
> +		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
> +		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
> +	}
> +	return rc;
> +}
> +
>  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> @@ -471,29 +497,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
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
> +	rc = tpm_crb_start(chip);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.54.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

