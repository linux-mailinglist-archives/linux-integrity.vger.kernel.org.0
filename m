Return-Path: <linux-integrity+bounces-3155-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5B6933B30
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE06E281BED
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6407C17E8FE;
	Wed, 17 Jul 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="MzZLfdDE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B114AD19;
	Wed, 17 Jul 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212697; cv=none; b=TqcVTlqGUYHHul+vC+4xMGikc+mza6YNPM1fUS+5SFo3PbEYgcov/CgEEHJqtTszRuvuyFCSCMi9z1+5q3JHWVf9aOaliZqWyLxYzPz7C/A3QXRxk5I1fGl7CR1WGwf2H4FJHWQb+8V4Qn5abRV7V34feGcVQfnbIGDrpDFJVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212697; c=relaxed/simple;
	bh=HvhgoHyJKpIIPXLDKtSS/sCs2jXautb++tsD2DLZoBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECv8qcEnPXNCTpQ949BXsN1wCdg7mAeA7B37WWyT8Z9545NfFn/lz6wuk549sPhUrPPuJXL8usO8zBJbv//VsevIjm8UipIe31+yCDSqxPphOh14dKMEffFf9JCdqohW21Xp+yfMEdX1d3h/BAtP/vDel0CZrIKauoyyko6EUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=MzZLfdDE; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=crA7kBcB4rPslVEtpJNh9J3l8TLIse9JtfSt0FeRbRs=; b=MzZLfdDErg+lO02YjKutidxYlY
	r6Yo77WfjHzXWWmnJEpO6OMjO4mhdQnMSE0ZJ0vOhaT+T28S8GsD84LHrG0jSAXB9RNNDlRPvcg3+
	mTzDKnCMTVet153q690eQElvXA+RL9crciP35BwrVIdmNWeMopk/uOksVVs1Q2WAkr/0qxEBnLTdJ
	yzudAfS5w724oEPnyS82XPiEhKpPKjUmGg+jykafXDC0JxzKobNIDBwfu4x+ZxYAj4/NjpaElvuCJ
	SWyvKVLy8kCQ5qeJh1CE1A5L66Sko97ltaH6jpOlD5UU/zsBtXnz1hI1JlLCHGPp5rEww1xKoT7wE
	zbAGjhhQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sU1NO-008WmH-2y;
	Wed, 17 Jul 2024 10:55:10 +0100
Date: Wed, 17 Jul 2024 10:55:10 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm: Relocate buf->handles to appropriate place
Message-ID: <ZpeU_lxLtrpKGk4s@earth.li>
References: <20240716185225.873090-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716185225.873090-1-jarkko@kernel.org>

On Tue, Jul 16, 2024 at 09:52:24PM +0300, Jarkko Sakkinen wrote:
> tpm_buf_append_name() has the following snippet in the beginning:
> 
> 	if (!tpm2_chip_auth(chip)) {
> 		tpm_buf_append_u32(buf, handle);
> 		/* count the number of handles in the upper bits of flags */
> 		buf->handles++;
> 		return;
> 	}
> 
> The claim in the comment is wrong, and the comment is in the wrong place
> as alignment in this case should not anyway be a concern of the call
> site. In essence the comment is  lying about the code, and thus needs to
> be adressed.
> 
> Further, 'handles' was incorrectly place to struct tpm_buf, as tpm-buf.c
> does manage its state. It is easy to grep that only piece of code that
> actually uses the field is tpm2-sessions.c.
> 
> Address the issues by moving the variable to struct tpm_chip.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> v3:
> * Reset chip->handles in the beginning of tpm2_start_auth_session()
>   so that it shows correct value, when TCG_TPM2_HMAC is enabled but
>   tpm2_sessions_init() has never been called.
> v2:
> * Was a bit more broken than I first thought, as 'handles' is only
>   useful for tpm2-sessions.c and has zero relation to tpm-buf.c.
> ---
>  drivers/char/tpm/tpm-buf.c       | 1 -
>  drivers/char/tpm/tpm2-cmd.c      | 2 +-
>  drivers/char/tpm/tpm2-sessions.c | 7 ++++---
>  include/linux/tpm.h              | 8 ++++----
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index cad0048bcc3c..d06e8e063151 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -44,7 +44,6 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>  	head->tag = cpu_to_be16(tag);
>  	head->length = cpu_to_be32(sizeof(*head));
>  	head->ordinal = cpu_to_be32(ordinal);
> -	buf->handles = 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_reset);
>  
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 1e856259219e..b781e4406fc2 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -776,7 +776,7 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  	if (rc)
>  		goto out;
>  
> -	rc = tpm2_sessions_init(chip);
> +	/* rc = tpm2_sessions_init(chip); */

Left over from testing? Or should be removed entirely?

>  out:
>  	/*
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index d3521aadd43e..5e7c12d64ba8 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -238,8 +238,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  
>  	if (!tpm2_chip_auth(chip)) {
>  		tpm_buf_append_u32(buf, handle);
> -		/* count the number of handles in the upper bits of flags */
> -		buf->handles++;
> +		chip->handles++;
>  		return;
>  	}
>  
> @@ -310,7 +309,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
>  
>  	if (!tpm2_chip_auth(chip)) {
>  		/* offset tells us where the sessions area begins */
> -		int offset = buf->handles * 4 + TPM_HEADER_SIZE;
> +		int offset = chip->handles * 4 + TPM_HEADER_SIZE;
>  		u32 len = 9 + passphrase_len;
>  
>  		if (tpm_buf_length(buf) != offset) {
> @@ -963,6 +962,8 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
>  	int rc;
>  	u32 null_key;
>  
> +	chip->handles = 0;
> +
>  	if (!auth) {
>  		dev_warn_once(&chip->dev, "auth session is not active\n");
>  		return 0;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index e93ee8d936a9..b664f7556494 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -202,9 +202,9 @@ struct tpm_chip {
>  	/* active locality */
>  	int locality;
>  
> +	/* handle count for session: */
> +	u8 handles;
>  #ifdef CONFIG_TCG_TPM2_HMAC
> -	/* details for communication security via sessions */
> -
>  	/* saved context for NULL seed */
>  	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
>  	 /* name of NULL seed */
> @@ -377,7 +377,6 @@ struct tpm_buf {
>  	u32 flags;
>  	u32 length;
>  	u8 *data;
> -	u8 handles;
>  };
>  
>  enum tpm2_object_attributes {
> @@ -517,7 +516,7 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
>  	if (tpm2_chip_auth(chip)) {
>  		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
>  	} else  {
> -		offset = buf->handles * 4 + TPM_HEADER_SIZE;
> +		offset = chip->handles * 4 + TPM_HEADER_SIZE;
>  		head = (struct tpm_header *)buf->data;
>  
>  		/*
> @@ -541,6 +540,7 @@ void tpm2_end_auth_session(struct tpm_chip *chip);
>  
>  static inline int tpm2_start_auth_session(struct tpm_chip *chip)
>  {
> +	chip->handles = 0;
>  	return 0;
>  }
>  static inline void tpm2_end_auth_session(struct tpm_chip *chip)
> -- 
> 2.45.2

J.

-- 
"I'm not anti-establishment, I just don't see the point." -- Matthew
Kirkwood, OxLUG mailing list.

