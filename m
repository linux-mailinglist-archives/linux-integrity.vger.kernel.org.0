Return-Path: <linux-integrity+bounces-8304-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJUVDMFJdmlqOwEAu9opvQ
	(envelope-from <linux-integrity+bounces-8304-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 17:50:09 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE61817F9
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 17:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14E103000FEE
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072919C566;
	Sun, 25 Jan 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9aZFcs6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53710E3;
	Sun, 25 Jan 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769359805; cv=none; b=K0q1Z3XYzH9/HvV0yeyFrZr1BX+l4J5GwpCP06P8MD+oo0J+qd7da8eK5cvc7rs4eTU/X+b6Vuv4xuDRlDXfuTsvsqQJZpgxOBwHXPFVR0Wl6h6COMf6zntbDnr67jMRpH0l5VjS0mfZLKcY/c6hsQXvzS/WeYZrK8zrlwzM0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769359805; c=relaxed/simple;
	bh=xwz1xpeInw0lWBWkze0PpmyxlbO1KupJukmlBXPq/9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1vLnGA/bZQRBt0WPH4Zrg0T81H1RwiaOeM7B5LITin1tXC8334Mn4Mgp4fyyK8eUU3lK0AFuF3kDkTPHsWKS7RdeMWeyl/hlFzjSXB4DfhauDSSmSzWptRcpsjLZ7G9suy3OqXs8+yavzZwHRVSAYeov/I7LMD1dGAoZHHiqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9aZFcs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4646DC4CEF1;
	Sun, 25 Jan 2026 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769359804;
	bh=xwz1xpeInw0lWBWkze0PpmyxlbO1KupJukmlBXPq/9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9aZFcs63Tv3gzMGalvB0Dumf/qdJHmnJ/0ertY+nER3pSVUHPPEKGozQMakDLdY/
	 7TdoIdy9MaLo5uxTImV8N0wUji29zBjTD/AaXogaAJBx2qPzdioWl6QCzyhRR+nZB/
	 aKKuIBfzuI0Pw7ASNyYhgtLHZ4ktp1vgrSADSBaBAS+qin5W+Hb8EWfnys/cspGHYz
	 vha5WxPQTw/LA8C6kxcejgEzQEpJ9GOZlGTq/35P71K0PJGOFCfkyjQG0t9n/oT1Kq
	 jtQmbkjcXtBrb5CoH1SCYn3EfAa6wtWcgQaGYbTKXISldsyEgiZe8T/P+T+LgXwx08
	 IoLdsL5xv2wDQ==
Date: Sun, 25 Jan 2026 18:50:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 09/21] char: tpm: cr50: Remove IRQF_ONESHOT
Message-ID: <aXZJuFXFvvfsW-Qb@kernel.org>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-10-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-10-bigeasy@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,gmx.de,ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8304-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FE61817F9
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 12:36:55PM +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> Remove IRQF_ONESHOT from irqflags.
> 
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
>  drivers/char/tpm/tpm_tis_spi_cr50.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index fc6891a0b6936..b48cacacc0664 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -749,8 +749,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  
>  	if (client->irq > 0) {
>  		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
> -				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> -				      IRQF_NO_AUTOEN,
> +				      IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
>  				      dev->driver->name, chip);
>  		if (rc < 0) {
>  			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
> diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
> index f4937280e9406..32920b4cecfb4 100644
> --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> @@ -287,7 +287,7 @@ int cr50_spi_probe(struct spi_device *spi)
>  	if (spi->irq > 0) {
>  		ret = devm_request_irq(&spi->dev, spi->irq,
>  				       cr50_spi_irq_handler,
> -				       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +				       IRQF_TRIGGER_RISING,
>  				       "cr50_spi", cr50_phy);
>  		if (ret < 0) {
>  			if (ret == -EPROBE_DEFER)
> -- 
> 2.51.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Shoud I pick this? I did apply it to my master branch (not next).

BR, Jarkko

