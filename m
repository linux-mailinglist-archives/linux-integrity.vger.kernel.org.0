Return-Path: <linux-integrity+bounces-9628-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KkpB0aWD2o1NgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9628-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 01:33:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7345D5ACCBC
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 01:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB1330265BC
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 23:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2C33FE05;
	Thu, 21 May 2026 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUsF3wGt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D183546D1;
	Thu, 21 May 2026 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406123; cv=none; b=GliAeOYeKBrbGZ8GOPmJQP4rlWiElantLcKwlFX9W6uLMs/46uIMnwfyqgyCtLOC9lIr8+smm9Di57OXiLNyREyQ2LFw4X8I4f71sNuQqReExINdhSwZldS8ZeMmXstOsaF4CqCsbncKmzgxfBdl0qFJLlZOlIy4KQSG5qAgl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406123; c=relaxed/simple;
	bh=2dHzJJDbECav/9DuCE/jPvdEc7Yjjcm2HsmG0evWPUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEv3lcPXt8tCyx35Z8lNOzEvwtvs3wQnV7R+4A1Ko+71dMMDwTXYe7C0hCHksRmHhGbJBMDBoRtd6rxyu9hsIxEqcmOJolVFqfWEdr75OW6BqMsK2ejSMKPQIdkF5GPqoZDoKWMXDR7LHC/msNo68UT+4KX7JmsjoM5WcYUXMd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUsF3wGt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 687CC1F000E9;
	Thu, 21 May 2026 23:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406122;
	bh=eJTqJV2TvEexFuWzItTpliaKrdmROZ+4K+UcfE8UuyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eUsF3wGtjGHpOlc8T0ppcmSuJuIg7BYfJjsFSB5d6KdaJiW16dRuiYt7pimw0sBip
	 2C7M47Ak0uRM6zV42LwG9J5GSuZpzBl3dvLouaubP6TgTOroBxmnxJr+u6Th05k2pM
	 y9sSCcwC71MwlSN9YemReF8OJTuNh5VVh5wrrnLUIp2ebiyn/KXTAWckljYHM59t4/
	 nCtyV7IZk3RgfnOHMKaZBT5CeK5rTmH0R4+a19Snv3zFW+T4jX7x6xubjj8tiIAif8
	 FJbCyVv0wRXTTjcIpa2ugxrHKp5UlVVdMWjU31AFrER+yHYpnJJ9UcWR9HYYXbgN4l
	 o/pVNJ35OgYzA==
Date: Fri, 22 May 2026 02:28:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v3 6/6] tpm_crb: Implement command and response chunking
 logic
Message-ID: <ag-VJhst_NjfGw8r@kernel.org>
References: <20260518151724.730443-1-armenon@redhat.com>
 <20260518151724.730443-7-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518151724.730443-7-armenon@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9628-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: 7345D5ACCBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:47:24PM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> With the introduction of support for Post Quantum Cryptography
> algorithms in TPM, the commands and responses will grow in size.
> Some TPMs have a physical hardware memory window (MMIO) that is
> smaller than the commands we need to send. Therefore this commit
> implements the core logic of sending/receiving data in chunks.
> 
> Instead of sending the whole command at once, the driver now sends it in
> small chunks. After each chunk, it signals the TPM using a nextChunk
> signal, and waits for the TPM to consume the data. Once the final piece
> is delivered, the driver signals the TPM to begin execution by toggling
> the start invoke bit. We use the same logic in reverse to read large
> responses from the TPM.
> 
> This allows the driver to handle large payloads even when the hardware
> interface has limited memory. This kernel-side support corresponds to
> the backend implementation in QEMU [1]. QEMU reassembles the chunks
> before passing them to the TPM emulator.
> 
> [1] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 215 +++++++++++++++++++++++++++++--------
>  1 file changed, 173 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 31f530744e90..8b2aaa109fc4 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -105,11 +105,13 @@ struct crb_priv {
>  	u8 __iomem *cmd;
>  	u8 __iomem *rsp;
>  	u32 cmd_size;
> +	u32 rsp_size;
>  	u32 smc_func_id;
>  	u32 __iomem *pluton_start_addr;
>  	u32 __iomem *pluton_reply_addr;
>  	u8 ffa_flags;
>  	u8 ffa_attributes;
> +	u32 intf_id;
>  };
>  
>  struct tpm2_crb_smc {
> @@ -369,38 +371,6 @@ static u8 crb_status(struct tpm_chip *chip)
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
> @@ -472,17 +442,71 @@ static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
>  	return rc;
>  }
>  
> +static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	int rc;
> +
> +	memcpy_toio(priv->cmd, buf, len);
> +
> +	/* Make sure that cmd is populated before issuing start. */
> +	wmb();
> +
> +	rc = tpm_crb_start(chip, CRB_START_INVOKE);
> +	if (rc)
> +		return rc;
> +
> +	return crb_try_pluton_doorbell(priv, false);
> +}
> +
> +static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	size_t offset = 0;
> +	size_t chunk_size;
> +	int rc;
> +
> +	while (offset < len) {
> +		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
> +
> +		if (chunk_size == 0)
> +			break;
> +
> +		memcpy_toio(priv->cmd, buf + offset, chunk_size);
> +		offset += chunk_size;
> +
> +		/* Make sure that cmd is populated before issuing start. */
> +		wmb();
> +		if (offset < len) {
> +			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
> +			if (rc)
> +				return rc;
> +			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> +									 CRB_START_NEXT_CHUNK, 0,
> +									 TPM2_TIMEOUT_C)) {
> +				dev_err(&chip->dev,
> +						"Timeout waiting for backend to consume chunk\n");
> +				return -ETIME;
> +			}
> +		} else {
> +			rc = tpm_crb_start(chip, CRB_START_INVOKE);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +
> +	return crb_try_pluton_doorbell(priv, false);
> +}
>  static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> -	int rc = 0;
>  
>  	/* Zero the cancel register so that the next command will not get
>  	 * canceled.
>  	 */
>  	iowrite32(0, &priv->regs_t->ctrl_cancel);
>  
> -	if (len > priv->cmd_size) {
> +	if (len > priv->cmd_size && !(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
>  		dev_err(&chip->dev, "invalid command count value %zd %d\n",
>  			len, priv->cmd_size);
>  		return -E2BIG;
> @@ -492,16 +516,115 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
>  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
>  
> -	memcpy_toio(priv->cmd, buf, len);
> +	if (len <= priv->cmd_size)
> +		return tpm_crb_send_no_chunks(chip, buf, len);
>  
> -	/* Make sure that cmd is populated before issuing start. */
> -	wmb();
> +	return tpm_crb_send_chunks(chip, buf, len);
> +}
>  
> -	rc = tpm_crb_start(chip, CRB_START_INVOKE);
> -	if (rc)
> -		return rc;
> +static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	unsigned int expected;
>  
> -	return crb_try_pluton_doorbell(priv, false);
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
> +	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
> +
> +	return expected;
> +}
> +
> +static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
> +							   unsigned int expected)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	size_t offset = 0;
> +	size_t chunk_size;
> +	size_t first_read;
> +	int rc;
> +
> +	if (expected > count)
> +		return -EIO;
> +	/*
> +	 * Set chunk_size by comparing the size of the buffer that the upper
> +	 * layer has allocated (count) to the hardware tpm limit (priv->rsp_size).
> +	 * This is to prevent buffer overflow while writing to buf.
> +	 */
> +	chunk_size = min_t(size_t, count, priv->rsp_size);
> +	if (chunk_size < 8)
> +		return -EIO;
> +
> +	memcpy_fromio(buf, priv->rsp, 8);
> +
> +	/*
> +	 * Compare the actual size of the response we found in
> +	 * the header to the chunk size
> +	 */
> +	first_read = min_t(size_t, expected, chunk_size);
> +
> +	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
> +	offset = first_read;
> +
> +	while (offset < expected) {
> +		rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
> +		if (rc)
> +			return rc;
> +
> +		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
> +								 CRB_START_NEXT_CHUNK, 0,
> +								 TPM2_TIMEOUT_C)) {
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
> +}
> +
> +static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	unsigned int expected;
> +
> +	/* A sanity check that the upper layer wants to get at least the header
> +	 * as that is the minimum size for any TPM response.
> +	 */
> +	if (count < TPM_HEADER_SIZE)
> +		return -EIO;
> +
> +	/* If this bit is set, according to the spec, the TPM is in
> +	 * unrecoverable condition.
> +	 */
> +	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
> +		return -EIO;
> +
> +	/*
> +	 * Peek at the first 8 bytes to determine the response size
> +	 */
> +	expected = be32_to_cpup((__be32 *)&priv->rsp[2]);
> +
> +	if (expected <= priv->rsp_size)
> +		return tpm_crb_recv_no_chunks(chip, buf, count);
> +
> +	if (!(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
> +		dev_err(&chip->dev,
> +			    "Response larger than MMIO and chunking not supported\n");
> +		return -EIO;
> +	}
> +
> +	return tpm_crb_recv_chunks(chip, buf, count, expected);
>  }
>  
>  static void crb_cancel(struct tpm_chip *chip)
> @@ -728,6 +851,12 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
>  		goto out;
>  	}
>  
> +	if (priv->regs_h)
> +		priv->intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
> +
> +	if (priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)
> +		dev_info(dev, "CRB Chunking is supported by backend\n");
> +
>  	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
>  	rsp_pa = le64_to_cpu(__rsp_pa);
>  	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
> @@ -765,8 +894,10 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
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
> 2.54.0
> 

Looks pretty good. I'll hold r-by up until I've tested +1 revision of
the series (for which I provided rebased patch).

BR, Jarkko

