Return-Path: <linux-integrity+bounces-9627-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGf6IyKWD2q9NgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9627-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 01:32:50 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7085ACC9D
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 01:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7DBB3018166
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CB836683D;
	Thu, 21 May 2026 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKwqOWmO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCD495E5;
	Thu, 21 May 2026 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405831; cv=none; b=YUIMDIMl1bN9+5+zJB/UZNMHzCb6TSf1V3t6QqMR3jf5mqU1ZqSnJIzK3PYJY+z9intT4H1iAmKqoLYTKYhjl5q/yVI6Rw5rvcayjnZYpXUK6gU+rEmBji+1Uc+sewy9kpfRy5LjXmdehh9ZB+uJIaqHuTvq9NMul9P7ipLrP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405831; c=relaxed/simple;
	bh=lwXubo77mh4/XhhR6Qe9wYnFin8jgO8bdRlPvY6bSJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG7yVce8Wzz0KFPvVIjIAwoq23RYl5KHpN0/mZWdnMubdYUGbMupwWeIsQhOBsdkF0j5PFI+spPnJNEyApqgSmTe+zz8/uw9hgFeu3JG/XQmlOOfETeUpVsROmFTTFU66+U0QJw4Ieztr2pWVu4Fh2hyig/NFN1jilg1JsAhUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKwqOWmO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B880F1F000E9;
	Thu, 21 May 2026 23:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779405830;
	bh=VdNmfWV7DlqxdT86c7E4rX+xIhla0Heb/vMqsuo8Q1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OKwqOWmOT96whb+hTZqinZ9T1nt+D7mqAAPBBx7D5iOYHGaFDvjDCcksR/vdvCKFu
	 rp+B8fGtAXEEG4BZ4mSFw7Z6cNlLfoPyxge2s/5FhombDlUWbfnKC5q9CXX0AaFXwv
	 n0WlwWXJhR83uUDt6C15JPnDaTJ2eicqzzrk1LYVcF4dBFax5ZtQGtDVJSpjbS3Mn2
	 IKKvjiKB1jBouvd1y06SgmxqsgOhJfV+yXr6zE97kfGpVGv2QLV3iAvY01kOKQMiw5
	 QeDnEILWwwaH8PXVopVq+1GsBjY4hP6tY0RzpV/aJ+FYz70P5quKX4j0s8ratveXe/
	 aSz65JPkZp+Bg==
Date: Fri, 22 May 2026 02:23:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v3 4/6] tpm: tis_i2c: Use local 4KB buffer to limit
 memory usage
Message-ID: <ag-UAtiWtBiuM9cB@kernel.org>
References: <20260518151724.730443-1-armenon@redhat.com>
 <20260518151724.730443-5-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518151724.730443-5-armenon@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9627-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9C7085ACC9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:47:22PM +0530, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> The global increase of TPM_BUFSIZE to 8KB is necessary to support
> Post-Quantum Cryptography (PQC) payloads. However, applying this increase
> to the tpm_tis_i2c driver is unnecessary and wasteful due to physical
> transport limitations as pointed out in [1]
> 
> This commit introduces a local buffer limit that is used in the i2c
> driver.
> 
> [1] https://sashiko.dev/#/patchset/20260324071803.324774-1-armenon%40redhat.com?patch=8319
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 6cd07dd34507..db19d459ea1e 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -54,6 +54,8 @@
>  #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
>  #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
>  
> +#define TPM_I2C_BUFSIZE 4096
> +
>  struct tpm_tis_i2c_phy {
>  	struct tpm_tis_data priv;
>  	struct i2c_client *i2c_client;
> @@ -232,7 +234,7 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
>  	int ret;
>  	u16 wrote = 0;
>  
> -	if (len > TPM_BUFSIZE - 1)
> +	if (len > TPM_I2C_BUFSIZE - 1)
>  		return -EIO;
>  
>  	phy->io_buf[0] = reg;
> @@ -339,7 +341,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev)
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	phy->io_buf = devm_kzalloc(&dev->dev, TPM_BUFSIZE, GFP_KERNEL);
> +	phy->io_buf = devm_kzalloc(&dev->dev, TPM_I2C_BUFSIZE, GFP_KERNEL);
>  	if (!phy->io_buf)
>  		return -ENOMEM;
>  
> -- 
> 2.54.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

