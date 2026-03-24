Return-Path: <linux-integrity+bounces-9051-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePWHMt1swmmncwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9051-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:52:13 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F5A306C08
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2D8F301E94A
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 10:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2D3DF00F;
	Tue, 24 Mar 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhZuFd9O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995D368263;
	Tue, 24 Mar 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349133; cv=none; b=WAJqLyoJVIhqvW70hhN/dS0rWgQWHb0J1OqrhV0dHkY6XkFuInivVxlYGgt8c5Kz/rvP38fGTMjjg8qXcGZov5w2eDSytZmnwCdkW4TsOIiL2gZTjEgEmFLciOvu+C6uPrJkLvDsebVblSskf7gB5cOS+XPdvXqSb6U2WMjeNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349133; c=relaxed/simple;
	bh=ng3sQdylaGfpjHTfTm6TbbWmw/h++CAawgwfIWjmkuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYJqVdlPqHLwcXx2mqaHGUVPwAEZiwsTeJyojRWpWRHEMsMjF1Ih/I4ik07PAlFPFAwAhnb8swLpo99qCcnat+XCicz9ui+bouj1ri6rcc2Z2p+VaFIDchoIqZ1/d8R1khbql4fxyhDAxPQ/nPy6KV3vxWkYbwmLdu5n4bmfB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhZuFd9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA592C19424;
	Tue, 24 Mar 2026 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774349133;
	bh=ng3sQdylaGfpjHTfTm6TbbWmw/h++CAawgwfIWjmkuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhZuFd9Ob9r7uEPpOx//gsx+DBicZQYrTolalDGduPdTJcO/6HpBM0eGtYNMrkXGV
	 8gmsd1DH5lYaostm1g5ht5hjSEwgDXbSHZfr6M/tQHTtNrJLGuKkR8uBPO8QrCjp4e
	 oKvFq+MoHnEM4pbdYjgRuvmHtcwJS3df/GSVmAvAgTPtnaxLKhz8Fh+R9LztQijAzo
	 yLDMtOuWJLhGx2AX5mLpoJNPcDj0nTZtJc9Z5khNqmacsUSS4/mu6H/33ENiXXwy1U
	 8aXj6pIBycRP5hfs5b/G0dokQcF3ObU6a9UXPfH7a51eQjU/NXvTv8qFUHoq8UDEZa
	 90AYXPIg3qjww==
Date: Tue, 24 Mar 2026 12:45:29 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 3/4] tpm_crb: Implement command and response chunking logic
Message-ID: <acJrSXwUMjh5Pt_8@kernel.org>
References: <20260324071803.324774-1-armenon@redhat.com>
 <20260324071803.324774-4-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324071803.324774-4-armenon@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmx.de];
	TAGGED_FROM(0.00)[bounces-9051-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21F5A306C08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 12:48:02PM +0530, Arun Menon wrote:
> Add support for sending and receiving TPM command data in chunks when
> the payload exceeds the physical size of the hardware MMIO window.
> 
> This introduces the following changes:
> 
> - crb_map_io(): Checks the device interface capability to determine if
>   chunking is supported, setting the chunking_supported flag. It also
>   stores the hardware's maximum response buffer size in priv->rsp_size.
> - crb_send(): Iteratively writes command chunks to the fixed priv->cmd
>   MMIO window. It signals the TPM backend to process intermediate chunks
>   using CRB_START_NEXT_CHUNK, and signals the final chunk to begin
>   execution using CRB_START_INVOKE.
> - crb_recv(): Parses the expected response size from the initial TPM
>   header. It then iteratively reads chunks from the fixed priv->rsp
>   MMIO window into the destination buffer, advancing the buffer offset
>   until the complete response is retrieved.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>

This is also just description of wha this adds. I'd lessen the detail
and write a description that describes motivation and logic of the
change. It's a good test for author knowledge, as if you really get
the topic you can explain its gist. In addition, it can be reflected
to implementation (vs. the descriptions that are pseudocode in English)

Since this RFC and QEMU does not have the feature in release it is
good to polish stuff like this.

> ---
>  drivers/char/tpm/tpm_crb.c | 150 +++++++++++++++++++++++++++----------
>  1 file changed, 109 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 10128d078245c..fb63cc3737253 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -104,11 +104,13 @@ struct crb_priv {
>  	u8 __iomem *cmd;
>  	u8 __iomem *rsp;
>  	u32 cmd_size;
> +	u32 rsp_size;
>  	u32 smc_func_id;
>  	u32 __iomem *pluton_start_addr;
>  	u32 __iomem *pluton_reply_addr;
>  	u8 ffa_flags;
>  	u8 ffa_attributes;
> +	bool chunking_supported;
>  };
>  
>  struct tpm2_crb_smc {
> @@ -368,38 +370,6 @@ static u8 crb_status(struct tpm_chip *chip)
>  	return sts;
>  }
>  
> -static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> -{
> -	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> -	unsigned int expected;
> -
> -	/* A sanity check that the upper layer wants to get at least the header
> -	 * as that is the minimum size for any TPM response.
> -	 */
> -	if (count < TPM_HEADER_SIZE)
> -		return -EIO;
> -
> -	/* If this bit is set, according to the spec, the TPM is in
> -	 * unrecoverable condition.
> -	 */
> -	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> -		return -EIO;
> -
> -	/* Read the first 8 bytes in order to get the length of the response.
> -	 * We read exactly a quad word in order to make sure that the remaining
> -	 * reads will be aligned.
> -	 */
> -	memcpy_fromio(buf, priv->rsp, 8);
> -
> -	expected = be32_to_cpup((__be32 *)&buf[2]);
> -	if (expected > count || expected < TPM_HEADER_SIZE)
> -		return -EIO;
> -
> -	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> -
> -	return expected;
> -}
> -
>  static int crb_do_acpi_start(struct tpm_chip *chip)
>  {
>  	union acpi_object *obj;
> @@ -474,6 +444,8 @@ static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
>  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	size_t offset = 0;
> +	size_t chunk_size;
>  	int rc = 0;
>  
>  	/* Zero the cancel register so that the next command will not get
> @@ -481,7 +453,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	 */
>  	iowrite32(0, &priv->regs_t->ctrl_cancel);
>  
> -	if (len > priv->cmd_size) {
> +	if (len > priv->cmd_size && !priv->chunking_supported) {
>  		dev_err(&chip->dev, "invalid command count value %zd %d\n",
>  			len, priv->cmd_size);
>  		return -E2BIG;
> @@ -491,16 +463,101 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
>  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
>  
> -	memcpy_toio(priv->cmd, buf, len);
> +	while (offset < len) {
> +		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
> +
> +		memcpy_toio(priv->cmd, buf + offset, chunk_size);
> +		offset += chunk_size;
> +
> +		/* Make sure that cmd is populated before issuing start. */
> +		wmb();
> +		if (offset < len) {
> +			rc = crb_trigger_tpm(chip, CRB_START_NEXT_CHUNK);
> +			if (rc)
> +				return rc;
> +			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> +			    CRB_START_NEXT_CHUNK, 0, TPM2_TIMEOUT_C)) {
> +				dev_err(&chip->dev,
> +					"Timeout waiting for backend to consume chunk\n");
> +				return -ETIME;
> +			}
> +		} else {
> +			rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +	return crb_try_pluton_doorbell(priv, false);
> +}
>  
> -	/* Make sure that cmd is populated before issuing start. */
> -	wmb();
> +static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	unsigned int expected;
> +	size_t offset = 0;
> +	size_t chunk_size;
> +	size_t first_read;
> +	int rc;
>  
> -	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> -	if (rc)
> -		return rc;
> +	/* A sanity check that the upper layer wants to get at least the header
> +	 * as that is the minimum size for any TPM response.
> +	 */
> +	if (count < TPM_HEADER_SIZE)
> +		return -EIO;
>  
> -	return crb_try_pluton_doorbell(priv, false);
> +	/* If this bit is set, according to the spec, the TPM is in
> +	 * unrecoverable condition.
> +	 */
> +	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> +		return -EIO;
> +
> +	/* Read the first 8 bytes in order to get the length of the response.
> +	 * We read exactly a quad word in order to make sure that the remaining
> +	 * reads will be aligned.
> +	 */
> +	memcpy_fromio(buf, priv->rsp, 8);
> +
> +	expected = be32_to_cpup((__be32 *)&buf[2]);
> +	if (expected > count || expected < TPM_HEADER_SIZE)
> +		return -EIO;
> +
> +	/*
> +	 * Set chunk_size by comparing the size of the buffer that the upper layer has
> +	 * allocated (count) to the hardware tpm limit (priv->rsp_size).
> +	 * This is to prevent buffer overflow while writing to buf.
> +	 */
> +	chunk_size = min_t(size_t, count, priv->rsp_size);
> +
> +	/*
> +	 * Compare the actual size of the response we found in the header to the chunk_size.
> +	 */
> +	first_read = min_t(size_t, expected, chunk_size);
> +
> +	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
> +	offset = first_read;
> +
> +	while (offset < expected) {
> +		if (!priv->chunking_supported) {
> +			dev_err(&chip->dev, "Response larger than MMIO and chunking not supported\n");
> +			return -EIO;
> +		}
> +
> +		rc = crb_trigger_tpm(chip, CRB_START_NEXT_CHUNK);
> +		if (rc)
> +			return rc;
> +
> +		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> +					 CRB_START_NEXT_CHUNK, 0, TPM2_TIMEOUT_C)) {
> +			dev_err(&chip->dev, "Timeout waiting for backend response\n");
> +			return -ETIME;
> +		}
> +
> +		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
> +		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
> +		offset += chunk_size;
> +	}
> +
> +	return expected;
>  }
>  
>  static void crb_cancel(struct tpm_chip *chip)
> @@ -727,6 +784,15 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  		goto out;
>  	}
>  
> +	if (priv->regs_h) {
> +		u32 intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
> +
> +		if (intf_id & CRB_INTF_CAP_CRB_CHUNK) {
> +			priv->chunking_supported = true;
> +			dev_info(dev, "CRB Chunking is supported by backend\n");
> +		}
> +	}
> +
>  	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
>  	rsp_pa = le64_to_cpu(__rsp_pa);
>  	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
> @@ -764,8 +830,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
>  	priv->rsp = priv->cmd;
>  
>  out:
> -	if (!ret)
> +	if (!ret) {
>  		priv->cmd_size = cmd_size;
> +		priv->rsp_size = rsp_size;
> +	}
>  
>  	__crb_go_idle(dev, priv, 0);
>  
> -- 
> 2.53.0
> 

BR, Jarkko

