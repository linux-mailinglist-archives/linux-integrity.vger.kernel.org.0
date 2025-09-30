Return-Path: <linux-integrity+bounces-7313-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BC0BACA7E
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 13:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191E47A361B
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA7240611;
	Tue, 30 Sep 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="kv55QJzh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE831F1302;
	Tue, 30 Sep 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230870; cv=none; b=p9xmWAQ2C4a+3PSvljWISyPlf6X4+/olWD+3WAH3DZkp9zjZWt7eiZ+zft30LlSrRwtF00NEwavJW096iiQaUZMQnQOdhFIl1P/weSfh0rIGCqK5m2yIPkj1Dk+ZsKTOnpsjubDRgOt8XdWWdHd3UTOMEfY6tjLIRV9QOjZT2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230870; c=relaxed/simple;
	bh=b+sIA11UCeOGaR6Xp/XIWK25VNYoOjZIhVvHQu5o/TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZkbPBMQfesHgBO4litreCCgEL0dx3sdc7d0KpE4BEYT/wORPWOqBcicNgzcMXklrnvm31EiaqCsTihWuYZ+ThYsybF038NxwSNEmVT6EcdzZMR+8sz69WMz9zc9KNH2uZSitMz802oxGsULFGFkkVgGDhXM5aRRuK8tSfgxa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=kv55QJzh; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=H6BOVlN5qcdKMb71bHqSEu/fyP7QGSvLxTTAnUcwrR4=; b=kv55QJzh2PC8A0O2FkkT58gvTd
	gn+K7Jvj7EOfr5pYx0wP5k6Fm5vAwlu48oXiqFYnOy8RF4TBYYwcQ1rNAtkfx6dN3xN+rCg7gQDmh
	3yUQWJBlPicL7n0c0ygtv/jVhy9/QyVF2pHhTQVe5OSm06w6c/HzI5oPSzjHHqotB6VY2rerK5pfN
	nUWQ4HdzCLrWVxronCpeKzw9/Xv0O30OBaCd7KB9fMM98vbVWtJPWmALquGocXUbN4kEePagTbcB0
	EuZRsDk50KveDGaqy4D+LkZbr4YDXC/e+YEkJXVXC8hmSJF9xCFGKrXwqIIaDIaczONiDSKchjPvR
	ANoUmITg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v3YJG-0072ep-2w;
	Tue, 30 Sep 2025 12:14:18 +0100
Date: Tue, 30 Sep 2025 12:14:18 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] tpm-buf: Remove chip parameter from
 tpm_buf_append_handle
Message-ID: <aNu7ilPSTQPuOQFt@earth.li>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-9-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-9-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:30PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Remove chip parameter from tpm_buf_append_handle() in order to maintain
> decoupled state with tpm-buf. This is mandatory change in order to re-use
> the module in early boot code of Trenchboot, and the binding itself brings
> no benefit. Use WARN like in other functions, as the error condition can
> happen only as a net effect of a trivial programming mistake.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Reviewed-by: Jonathan McDowell <noodles@meta.com>

> ---
> v3:
> - No changes.
> v2:
> - A new patch.
> ---
>  drivers/char/tpm/tpm-buf.c       | 5 ++---
>  drivers/char/tpm/tpm2-cmd.c      | 2 +-
>  drivers/char/tpm/tpm2-sessions.c | 2 +-
>  include/linux/tpm.h              | 2 +-
>  4 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 69ee77400539..1b9dee0d0681 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -147,20 +147,19 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
>  
>  /**
>   * tpm_buf_append_handle() - Add a handle
> - * @chip:	&tpm_chip instance
>   * @buf:	&tpm_buf instance
>   * @handle:	a TPM object handle
>   *
>   * Add a handle to the buffer, and increase the count tracking the number of
>   * handles in the command buffer. Works only for command buffers.
>   */
> -void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
> +void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
>  {
>  	if (buf->flags & TPM_BUF_INVALID)
>  		return;
>  
>  	if (buf->flags & TPM_BUF_TPM2B) {
> -		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
> +		WARN(1, "tpm-buf: invalid type: TPM2B\n");
>  		buf->flags |= TPM_BUF_INVALID;
>  		return;
>  	}
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index c7bfa705ea8f..b69ff7266450 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -190,7 +190,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
>  		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
>  	} else {
> -		tpm_buf_append_handle(chip, &buf, pcr_idx);
> +		tpm_buf_append_handle(&buf, pcr_idx);
>  		tpm_buf_append_auth(chip, &buf, NULL, 0);
>  	}
>  
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 13f019d1312a..bbc05f0997a8 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -232,7 +232,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  #endif
>  
>  	if (!tpm2_chip_auth(chip)) {
> -		tpm_buf_append_handle(chip, buf, handle);
> +		tpm_buf_append_handle(buf, handle);
>  		return;
>  	}
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 5283f32781c4..b2d89df70c18 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -423,7 +423,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
>  u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
>  u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
>  u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
> -void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
> +void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
>  
>  /*
>   * Check if TPM device is in the firmware upgrade mode.
> -- 
> 2.39.5
> 
> 

J.

-- 
101 things you can't have too much of : 24 - Taglines.
This .sig brought to you by the letter X and the number 45
Product of the Republic of HuggieTag

