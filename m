Return-Path: <linux-integrity+bounces-7311-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A63BACA5A
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 13:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C83188CBDB
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E96241673;
	Tue, 30 Sep 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="DHMJW7pR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897C239E6F;
	Tue, 30 Sep 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230721; cv=none; b=MjFu0mwObE6eJcSokGMqGdMqWAxYkM7Y52EQ/5pmMb7Svnk4BgiymRRdcbDDkHz+V37OR86JoRkw//Q2pbtW6KICnVcrAuSsGu8/2TaQNk1K1166Z3s4R3aivHQvmuvDLLJKr+9XzhEkGJgg1HrYOSdBLmCF3g/J4Hyayk6nSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230721; c=relaxed/simple;
	bh=Ss2VKXj/fYPNv0JGXafyLVT6Y1pr5ZG9uLLvk1TndQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5makORx23Tf40UHS4df2f6jPN7sdcjl+RNTglBySzTLbyqENsESgQ94SAK6hfw3zDOoF62TczID0xLflIzttpNwwJdjQsAal6BJf8kpqcrmPs/RIeMm8tHzQ2RCyqO7zr7mfhyy6uhtyxMrk28/SxJg7qK61kNp2KUZvyTSU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=DHMJW7pR; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sE9Ib/S3VKVM5KE47eUDUmbyhTmDXZGKFHGpjGWQlEk=; b=DHMJW7pRtjw9D2iG9AhUTeUZNk
	B9iJtZxAyXi1j20o5vZoAIo2JiGc3IIo/9lL54monnVtdMEQ2k83xLusVpOLGfF3LPjMjNWZcX2BD
	2KXJJtf/WHwbIiSrBs/8GJYSMSvViwt0go+/f0GGrwpSf66gcBCoXACOX/eDFOa0jHpqme/0N/dFl
	CMXQTMkZPmpw81nzTqqfGMQwf8wJlSHRR/kxfkpt7PVTZoFOL4sYk1C+ua0vlHJT2SH5YQJLjeYG6
	4NJO7ZKCrnS1SlewvepcjYN1dnKnvDevv1N61HVP4uJKrGNaSwzvocNZQvfSS6FifetfLqJnnO30R
	nEUI0gOg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v3YGp-006znN-1k;
	Tue, 30 Sep 2025 12:11:47 +0100
Date: Tue, 30 Sep 2025 12:11:47 +0100
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
Subject: Re: [PATCH v3 05/10] tpm2-sessions: Umask
 tpm_buf_append_hmac_session()
Message-ID: <aNu6834tzirFzKM7@earth.li>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-6-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-6-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:27PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Open code tpm_buf_append_hmac_session_opt() in order to unmask the code
> paths in the call sites of tpm_buf_append_hmac_session().
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Reviewed-by: Jonathan McDowell <noodles@meta.com>

> ---
> v3:
> - No changes.
> v2:
> - Uncorrupt the patch.
> ---
>  drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++---
>  include/linux/tpm.h                       | 23 -----------------------
>  security/keys/trusted-keys/trusted_tpm2.c | 12 ++++++++++--
>  3 files changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 86b1a4d859b9..c7bfa705ea8f 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -257,9 +257,17 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  
>  	do {
>  		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
> -		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
> -						| TPM2_SA_CONTINUE_SESSION,
> -						NULL, 0);
> +		if (tpm2_chip_auth(chip)) {
> +			tpm_buf_append_hmac_session(chip, &buf,
> +						    TPM2_SA_ENCRYPT |
> +						    TPM2_SA_CONTINUE_SESSION,
> +						    NULL, 0);
> +		} else  {
> +			offset = buf.handles * 4 + TPM_HEADER_SIZE;
> +			head = (struct tpm_header *)buf.data;
> +			if (tpm_buf_length(&buf) == offset)
> +				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> +		}
>  		tpm_buf_append_u16(&buf, num_bytes);
>  		tpm_buf_fill_hmac_session(chip, &buf);
>  		err = tpm_transmit_cmd(chip, &buf,
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 1fa02e18e688..e72e7657faa2 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -532,29 +532,6 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
>  				 int passphraselen);
>  void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
>  			 u8 *passphrase, int passphraselen);
> -static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
> -						   struct tpm_buf *buf,
> -						   u8 attributes,
> -						   u8 *passphrase,
> -						   int passphraselen)
> -{
> -	struct tpm_header *head;
> -	int offset;
> -
> -	if (tpm2_chip_auth(chip)) {
> -		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
> -	} else  {
> -		offset = buf->handles * 4 + TPM_HEADER_SIZE;
> -		head = (struct tpm_header *)buf->data;
> -
> -		/*
> -		 * If the only sessions are optional, the command tag must change to
> -		 * TPM2_ST_NO_SESSIONS.
> -		 */
> -		if (tpm_buf_length(buf) == offset)
> -			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> -	}
> -}
>  
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index e165b117bbca..c414a7006d78 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -482,8 +482,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  			   struct trusted_key_options *options,
>  			   u32 blob_handle)
>  {
> +	struct tpm_header *head;
>  	struct tpm_buf buf;
>  	u16 data_len;
> +	int offset;
>  	u8 *data;
>  	int rc;
>  
> @@ -518,8 +520,14 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  		tpm2_buf_append_auth(&buf, options->policyhandle,
>  				     NULL /* nonce */, 0, 0,
>  				     options->blobauth, options->blobauth_len);
> -		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT,
> -						NULL, 0);
> +		if (tpm2_chip_auth(chip)) {
> +			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
> +		} else  {
> +			offset = buf.handles * 4 + TPM_HEADER_SIZE;
> +			head = (struct tpm_header *)buf.data;
> +			if (tpm_buf_length(&buf) == offset)
> +				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
> +		}
>  	}
>  
>  	tpm_buf_fill_hmac_session(chip, &buf);
> -- 
> 2.39.5
> 
> 

J.

-- 
... I love you the way a bomb loves a crowd.

