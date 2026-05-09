Return-Path: <linux-integrity+bounces-9502-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBS4KodK/2mN4QAAu9opvQ
	(envelope-from <linux-integrity+bounces-9502-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 16:53:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A95002DF
	for <lists+linux-integrity@lfdr.de>; Sat, 09 May 2026 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED52B300CFF4
	for <lists+linux-integrity@lfdr.de>; Sat,  9 May 2026 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0FC3939BC;
	Sat,  9 May 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKnIOAJY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CC239567;
	Sat,  9 May 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338435; cv=none; b=S8RZMZaK1kC2RdSuZWjcz+A1VJMi8A+sF+X6j4UL4hUOlAAFEDpAZR7hiGbaGUgIQ5sCnW+bmbA76JM/B+d9TTdOM5CHe+VPr9MpLnDvOQUNE33f2rKr6zm8+i/E84thOb5S8nVptC8EwzbQFJBUmYWjNXa6iWn6a67Us/dvGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338435; c=relaxed/simple;
	bh=BYtjv4KhvWkDxH/BEEcnnWjx3kC/fGJis0VxgeAwqTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYxJWxjNhdl4MKK8uUG7Pb7BpPYZfTDyTh31Wo7r3dMtQ1gJ1IZdYjzQSJTFlom0+rxqcGzLKtGOWQNaFo+Vg23wBK95xOq3+Tu1RSyUIbC1O7woJc1wup5VEifW/3oxJ43Ax8MC+Li+7jbQMWMjMY/ThEgvUkpDWEPzvW0Pfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKnIOAJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC475C2BCB2;
	Sat,  9 May 2026 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778338435;
	bh=BYtjv4KhvWkDxH/BEEcnnWjx3kC/fGJis0VxgeAwqTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKnIOAJYndwu91INM71rbq/VIhpIlXBkjhvUTMCw6Scyk/K2gE+22P5XFi1qKzPW5
	 7HPdZtO0dkfewd58pfwmSFkF8ahgYgmy2Znjp9/WkFj8i5a5vv4iGx+Cwhi5yu1r5T
	 JOZLtneViv5i/rHK/9i8EswofvDHeKtwFor8ONLmkhRDKSAHNqtHAb4DKhSrZ0T1iB
	 HrLRaOlcts17mOjwQs7LbYeKR4pfS7mzJ6ZgraHFA8CGslofJ0CwNxp0HQmDz8z7gF
	 kAz/Q271IibjC5rvHjxmkGUeToM13ZTQzQGR9EwBx5APOke1l+GlvRoHK4Ds1xwlY1
	 OEXjZ8NXGdUcw==
Date: Sat, 9 May 2026 17:53:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC v2 3/5] tpm_crb: Implement command and response chunking
 logic
Message-ID: <af9Kf671p1ocUwYY@kernel.org>
References: <20260324181244.17741-1-armenon@redhat.com>
 <20260324181244.17741-4-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324181244.17741-4-armenon@redhat.com>
X-Rspamd-Queue-Id: 294A95002DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-9502-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, Mar 24, 2026 at 11:42:42PM +0530, Arun Menon wrote:
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
> [1] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---

This is really bad at rationalizing the code change, which are heavy.

Couldn't you instead:

1. Rename crb_recv as tpm_crb_recv_no_chunks().
2. Add tpm_crb_recv_chunks().
3. Add new tpm_crb_recv(), which delegates either.

I would not mind too much if they have some duplicate logic. It's less
of a harm than convolution caused by interleaving.

>  drivers/char/tpm/tpm_crb.c | 155 +++++++++++++++++++++++++++----------
>  1 file changed, 114 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 922bcf7a69ad5..a97fc5e9927e3 100644
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

Why not "u32 intf_id" i.e. cache the value of the register?

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
> @@ -491,18 +463,108 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
>  	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
>  		__crb_cmd_ready(&chip->dev, priv, chip->locality);
>  
> -	memcpy_toio(priv->cmd, buf, len);
> +	while (offset < len) {
> +		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
>  
> -	/* Make sure that cmd is populated before issuing start. */
> -	wmb();
> -
> -	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
> -	if (rc)
> -		return rc;
> +		if (chunk_size == 0)
> +			break;
>  
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
>  	return crb_try_pluton_doorbell(priv, false);
>  }
>  
> +static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> +	unsigned int expected;
> +	size_t offset = 0;
> +	size_t chunk_size;
> +	size_t first_read;
> +	int rc;
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
> +	if (chunk_size < 8)
> +		return -EIO;
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
> +}
> +
>  static void crb_cancel(struct tpm_chip *chip)
>  {
>  	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
> @@ -727,6 +789,15 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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
> @@ -764,8 +835,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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

