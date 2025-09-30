Return-Path: <linux-integrity+bounces-7312-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F536BACA63
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 13:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE17E17B75C
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB223AB8E;
	Tue, 30 Sep 2025 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="v8G7KKgh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC01F1932;
	Tue, 30 Sep 2025 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230803; cv=none; b=qRApJyvkr0H5k071JGcGsz7gl/mhPiNIOlEnO2NS91xzGWJHMH3Y9b4aGctUk4W5Q/fZlxK15BJ7ViipvlXGrEm4K5cZxbaE/ztJQK1pwp0Ma3urX32k0yci6LwJ4U72w0heBUaEEeGW3YRO0sCisYUTlbs7CB5NpI1frQegmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230803; c=relaxed/simple;
	bh=y4NzDr0/KkuDyl9TgRRAMLCj6X6iyfJFww2cL6UxEF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4Af0T1u4Q8gJxOF30ENFE3P2f0ze/lfM0itWvpAbr+11ylbAx20COGf8dtEtIGyR7Y54+oZAIwa0rl9yrSHNLw9AkbssCMNgREggDNmUidT3h4yDcOPffQcznA1X99yBC3YfoeGIiLqyevozIy+EQNzpu1omw6P+2uuhmduxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=v8G7KKgh; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dDGpMRKrk/cvbMn+hG0L18gHoWLf5b5mle8y8oMi32Y=; b=v8G7KKghW8HC8+/vDbjOW0P+KR
	tmu9MUtukW/JDgJLqvjqy/Z5MnKBjP0VmqwbsYByOZL4WqIgoxFyR2pJvB7D6Nfd4NnSyglilQs4s
	8Qff8VP3nmxfwAQnyS1MlTuRcUVmWPUQtjjI2boyK7+wuaZ9fPzpJi5ZlwepiaRpRtNCQHXC6nqLs
	Y8kwhDg/xH/32HBJSSbPUM1VBDRkbkDAstbH9eDf9NtTSbMQhjSaPM1OjzsSfxAOeKDCsROcxeHrg
	vasfSHgpkN/PPS7cHLc0+ZHT2ziJaoA0QVhpnN5fjgXOLxDRPLyYm/SBEJJZFC3c0hUX+M9HV1reL
	tpXSBU5w==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v3YIB-0071OX-2v;
	Tue, 30 Sep 2025 12:13:11 +0100
Date: Tue, 30 Sep 2025 12:13:11 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] tpm-buf: check for corruption in
 tpm_buf_append_handle()
Message-ID: <aNu7R8J8h8Kmon0H@earth.li>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-8-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-8-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:29PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Unify TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW into TPM_BUF_INVALID
> flag because semantically they are identical.
> 
> Test and set TPM_BUF_INVALID in tpm_buf_append_handle() following the
> pattern from other functions in tpm-buf.c.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Reviewed-by: Jonathan McDowell <noodles@meta.com>

> ---
> v3:
> - No changes.
> v2:
> - A new patch.
> ---
>  drivers/char/tpm/tpm-buf.c                | 14 ++++++++------
>  include/linux/tpm.h                       |  8 +++-----
>  security/keys/trusted-keys/trusted_tpm2.c |  6 +++---
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index dc882fc9fa9e..69ee77400539 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -104,13 +104,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
>   */
>  void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
>  {
> -	/* Return silently if overflow has already happened. */
> -	if (buf->flags & TPM_BUF_OVERFLOW)
> +	if (buf->flags & TPM_BUF_INVALID)
>  		return;
>  
>  	if ((buf->length + new_length) > PAGE_SIZE) {
>  		WARN(1, "tpm_buf: write overflow\n");
> -		buf->flags |= TPM_BUF_OVERFLOW;
> +		buf->flags |= TPM_BUF_INVALID;
>  		return;
>  	}
>  
> @@ -157,8 +156,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
>   */
>  void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
>  {
> +	if (buf->flags & TPM_BUF_INVALID)
> +		return;
> +
>  	if (buf->flags & TPM_BUF_TPM2B) {
>  		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
> +		buf->flags |= TPM_BUF_INVALID;
>  		return;
>  	}
>  
> @@ -177,14 +180,13 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
>  {
>  	off_t next_offset;
>  
> -	/* Return silently if overflow has already happened. */
> -	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
> +	if (buf->flags & TPM_BUF_INVALID)
>  		return;
>  
>  	next_offset = *offset + count;
>  	if (next_offset > buf->length) {
>  		WARN(1, "tpm_buf: read out of boundary\n");
> -		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
> +		buf->flags |= TPM_BUF_INVALID;
>  		return;
>  	}
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index e72e7657faa2..5283f32781c4 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -366,12 +366,10 @@ struct tpm_header {
>  } __packed;
>  
>  enum tpm_buf_flags {
> -	/* the capacity exceeded: */
> -	TPM_BUF_OVERFLOW	= BIT(0),
>  	/* TPM2B format: */
> -	TPM_BUF_TPM2B		= BIT(1),
> -	/* read out of boundary: */
> -	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
> +	TPM_BUF_TPM2B		= BIT(0),
> +	/* The buffer is in invalid and unusable state: */
> +	TPM_BUF_INVALID		= BIT(1),
>  };
>  
>  /*
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 8e3b283a59b2..119d5152c0db 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -295,7 +295,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	/* creation PCR */
>  	tpm_buf_append_u32(&buf, 0);
>  
> -	if (buf.flags & TPM_BUF_OVERFLOW) {
> +	if (buf.flags & TPM_BUF_INVALID) {
>  		rc = -E2BIG;
>  		tpm2_end_auth_session(chip);
>  		goto out;
> @@ -308,7 +308,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		goto out;
>  
>  	blob_len = tpm_buf_read_u32(&buf, &offset);
> -	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
> +	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
>  		rc = -E2BIG;
>  		goto out;
>  	}
> @@ -414,7 +414,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  
>  	tpm_buf_append(&buf, blob, blob_len);
>  
> -	if (buf.flags & TPM_BUF_OVERFLOW) {
> +	if (buf.flags & TPM_BUF_INVALID) {
>  		rc = -E2BIG;
>  		tpm2_end_auth_session(chip);
>  		goto out;
> -- 
> 2.39.5
> 
> 

J.

-- 
Web [       Reality is for people with no grasp of fantasy.        ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

